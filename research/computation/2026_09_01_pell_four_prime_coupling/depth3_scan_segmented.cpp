#include <algorithm>
#include <cmath>
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

static u64 add_mod(u64 a, u64 b, u64 m) {
    return static_cast<u64>((static_cast<u128>(a) + b) % m);
}

static u64 sub_mod(u64 a, u64 b, u64 m) {
    return a >= b ? a - b : m - (b - a);
}

// Fast doubling for U_0=0, U_1=1, U_(n+2)=6U_(n+1)-U_n.
static u64 balancing_mod(u64 n, u64 m) {
    u64 a = 0;
    u64 b = 1;
    if (n == 0) return 0;
    int top = 63;
    while (top > 0 && ((n >> top) & 1U) == 0) --top;
    for (int bit = top; bit >= 0; --bit) {
        const u64 c = mul_mod(a, sub_mod(add_mod(b, b, m), mul_mod(6, a, m), m), m);
        const u64 d = sub_mod(mul_mod(b, b, m), mul_mod(a, a, m), m);
        if (((n >> bit) & 1U) == 0) {
            a = c;
            b = d;
        } else {
            a = d;
            b = sub_mod(mul_mod(6, d, m), c, m);
        }
    }
    return a;
}

static u128 mul_mod128(u128 a, u128 b, u128 m) {
    u128 ans = 0;
    while (b != 0) {
        if (b & 1U) ans = (ans + a) % m;
        a = (a + a) % m;
        b >>= 1;
    }
    return ans;
}

static u128 add_mod128(u128 a, u128 b, u128 m) {
    return (a + b) % m;
}

static u128 sub_mod128(u128 a, u128 b, u128 m) {
    return a >= b ? a - b : m - (b - a);
}

static u128 balancing_mod128(u64 n, u128 m) {
    u128 a = 0;
    u128 b = 1;
    if (n == 0) return 0;
    int top = 63;
    while (top > 0 && ((n >> top) & 1U) == 0) --top;
    for (int bit = top; bit >= 0; --bit) {
        const u128 c = mul_mod128(a,
            sub_mod128(add_mod128(b, b, m), mul_mod128(6, a, m), m), m);
        const u128 d = sub_mod128(mul_mod128(b, b, m), mul_mod128(a, a, m), m);
        if (((n >> bit) & 1U) == 0) {
            a = c;
            b = d;
        } else {
            a = d;
            b = sub_mod128(mul_mod128(6, d, m), c, m);
        }
    }
    return a;
}

static std::string decimal(u128 n) {
    if (n == 0) return "0";
    std::string s;
    while (n != 0) {
        s.push_back(static_cast<char>('0' + n % 10));
        n /= 10;
    }
    std::reverse(s.begin(), s.end());
    return s;
}

static std::vector<int> base_primes(int bound) {
    std::vector<bool> prime(static_cast<std::size_t>(bound) + 1, true);
    prime[0] = prime[1] = false;
    for (int p = 2; static_cast<long long>(p) * p <= bound; ++p) {
        if (!prime[p]) continue;
        for (int j = p * p; j <= bound; j += p) prime[j] = false;
    }
    std::vector<int> ans;
    for (int p = 3; p <= bound; p += 2) if (prime[p]) ans.push_back(p);
    return ans;
}

int main(int argc, char** argv) {
    const int limit = argc >= 2 ? std::stoi(argv[1]) : 300000000;
    const std::string output = argc >= 3 ? argv[2] : "depth3_scan_300m.csv";
    if (limit < 3 || limit > 1000000000) {
        throw std::runtime_error("limit must lie in [3,1000000000]");
    }

    const int root = static_cast<int>(std::sqrt(static_cast<double>(limit))) + 1;
    const auto small = base_primes(root);
    constexpr std::size_t odd_block = 1U << 20;

    std::ofstream csv(output, std::ios::binary);
    if (!csv) throw std::runtime_error("cannot open output");
    csv << "q,legendre_2,canonical_index,u_mod_q3,u_over_q2_mod_q,status\n";

    std::uint64_t odd_prime_count = 0;
    std::uint64_t wieferich_count = 0;
    std::uint64_t depth3_count = 0;

    for (u64 low = 3; low <= static_cast<u64>(limit); low += 2 * odd_block) {
        const u64 high = std::min<u64>(static_cast<u64>(limit),
                                      low + 2 * odd_block - 2);
        const std::size_t count = static_cast<std::size_t>((high - low) / 2 + 1);
        std::vector<std::uint8_t> prime(count, 1);
        for (int pi : small) {
            const u64 p = static_cast<u64>(pi);
            if (p * p > high) break;
            u64 start = std::max<u64>(p * p, ((low + p - 1) / p) * p);
            if ((start & 1U) == 0) start += p;
            for (u64 n = start; n <= high; n += 2 * p) {
                prime[static_cast<std::size_t>((n - low) / 2)] = 0;
            }
        }

        for (std::size_t i = 0; i < count; ++i) {
            if (!prime[i]) continue;
            const u64 q = low + 2 * i;
            ++odd_prime_count;
            const int r8 = static_cast<int>(q & 7U);
            const int legendre2 = (r8 == 1 || r8 == 7) ? 1 : -1;
            const u64 index = legendre2 == 1 ? q - 1 : q + 1;
            const u64 q2 = q * q;
            if (balancing_mod(index, q2) != 0) continue;

            ++wieferich_count;
            const u128 q3 = static_cast<u128>(q) * q * q;
            const u128 residue = balancing_mod128(index, q3);
            const bool depth3 = residue == 0;
            if (depth3) ++depth3_count;
            csv << q << ',' << legendre2 << ',' << index << ','
                << decimal(residue) << ',' << decimal(residue / q2) << ','
                << (depth3 ? "valuation_at_least_3" : "valuation_exactly_2")
                << '\n';
        }
    }

    std::cout << "algorithm=segmented sieve plus Lucas fast doubling\n";
    std::cout << "limit=" << limit << '\n';
    std::cout << "odd_primes_tested=" << odd_prime_count << '\n';
    std::cout << "wieferich_hits=" << wieferich_count << '\n';
    std::cout << "valuation_at_least_3_hits=" << depth3_count << '\n';
    std::cout << "output=" << output << '\n';
}
