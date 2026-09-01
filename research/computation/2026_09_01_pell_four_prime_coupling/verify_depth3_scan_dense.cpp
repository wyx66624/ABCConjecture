#include <algorithm>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

using u64 = std::uint64_t;
using u128 = __uint128_t;

static u64 mul_mod(u64 a, u64 b, u64 m) {
    return static_cast<u64>((static_cast<u128>(a) * b) % m);
}

// Multiplication in Z[T]/(T^2-6T+1), represented by a*T+b.
static std::pair<u64, u64> quotient_mul(
    std::pair<u64, u64> x, std::pair<u64, u64> y, u64 m) {
    const u64 ac = mul_mod(x.first, y.first, m);
    const u64 ad = mul_mod(x.first, y.second, m);
    const u64 bc = mul_mod(x.second, y.first, m);
    const u64 bd = mul_mod(x.second, y.second, m);
    const u64 first = static_cast<u64>((static_cast<u128>(mul_mod(6, ac, m)) + ad + bc) % m);
    const u64 second = bd >= ac ? bd - ac : m - (ac - bd);
    return {first, second};
}

// Since T^n=U_n*T-U_(n-1), the T coefficient is U_n.
static u64 balancing_mod_quotient_ring(u64 n, u64 m) {
    std::pair<u64, u64> result{0, 1};
    std::pair<u64, u64> base{1, 0};
    while (n != 0) {
        if (n & 1U) result = quotient_mul(result, base, m);
        base = quotient_mul(base, base, m);
        n >>= 1;
    }
    return result.first;
}

int main(int argc, char** argv) {
    const int limit = argc >= 2 ? std::stoi(argv[1]) : 300000000;
    const std::string expected = argc >= 3 ? argv[2] : "depth3_scan_300m.csv";
    if (limit < 3 || limit > 1000000000) {
        throw std::runtime_error("limit must lie in [3,1000000000]");
    }

    std::vector<bool> prime(static_cast<std::size_t>(limit) + 1, true);
    prime[0] = prime[1] = false;
    for (int p = 2; static_cast<long long>(p) * p <= limit; ++p) {
        if (!prime[p]) continue;
        for (int j = p * p; j <= limit; j += p) prime[j] = false;
    }

    std::vector<u64> hits;
    std::uint64_t odd_prime_count = 0;
    for (int qi = 3; qi <= limit; qi += 2) {
        if (!prime[qi]) continue;
        ++odd_prime_count;
        const u64 q = static_cast<u64>(qi);
        const int r8 = qi & 7;
        const int legendre2 = (r8 == 1 || r8 == 7) ? 1 : -1;
        const u64 index = legendre2 == 1 ? q - 1 : q + 1;
        if (balancing_mod_quotient_ring(index, q * q) == 0) hits.push_back(q);
    }

    std::ifstream csv(expected, std::ios::binary);
    if (!csv) throw std::runtime_error("cannot open producer CSV");
    std::string line;
    std::getline(csv, line);
    std::vector<u64> producer_hits;
    while (std::getline(csv, line)) {
        if (line.empty()) continue;
        const auto comma = line.find(',');
        producer_hits.push_back(std::stoull(line.substr(0, comma)));
    }

    if (producer_hits != hits) {
        throw std::runtime_error("producer and dense verifier hit lists differ");
    }
    std::cout << "algorithm=dense Eratosthenes plus quotient-ring binary powering\n";
    std::cout << "limit=" << limit << '\n';
    std::cout << "odd_primes_tested=" << odd_prime_count << '\n';
    std::cout << "wieferich_hits=" << hits.size() << '\n';
    std::cout << "hit_list=";
    for (std::size_t i = 0; i < hits.size(); ++i) {
        if (i != 0) std::cout << ',';
        std::cout << hits[i];
    }
    std::cout << "\nverification=PASS\n";
}
