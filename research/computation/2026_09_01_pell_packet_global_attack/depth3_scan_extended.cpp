#include <algorithm>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <stdexcept>
#include <string>
#include <vector>

using u64 = std::uint64_t;
using u128 = __uint128_t;

static u64 mul_mod64(u64 a, u64 b, u64 m) {
    return static_cast<u64>((static_cast<u128>(a) * b) % m);
}

static u64 add_mod64(u64 a, u64 b, u64 m) {
    return static_cast<u64>((static_cast<u128>(a) + b) % m);
}

static u64 sub_mod64(u64 a, u64 b, u64 m) {
    return a >= b ? a - b : m - (b - a);
}

// U_n modulo m for U_0=0, U_1=1, U_{n+2}=6U_{n+1}-U_n.
// The identities used are
// U_{2k}=U_k(2U_{k+1}-6U_k), U_{2k+1}=U_{k+1}^2-U_k^2.
static u64 balancing_mod64(u64 n, u64 m) {
    u64 a = 0;
    u64 b = 1;
    if (n == 0) return 0;
    int top = 63;
    while (top > 0 && ((n >> top) & 1U) == 0) --top;
    for (int bit = top; bit >= 0; --bit) {
        const u64 twice_b = add_mod64(b, b, m);
        const u64 six_a = mul_mod64(6, a, m);
        const u64 c = mul_mod64(a, sub_mod64(twice_b, six_a, m), m);
        const u64 d = sub_mod64(mul_mod64(b, b, m), mul_mod64(a, a, m), m);
        if (((n >> bit) & 1U) == 0) {
            a = c;
            b = d;
        } else {
            a = d;
            b = sub_mod64(mul_mod64(6, d, m), c, m);
        }
    }
    return a;
}

// Slow overflow-free multiplication is used only for the very rare q^2 hits.
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
        const u128 twice_b = add_mod128(b, b, m);
        const u128 six_a = mul_mod128(6, a, m);
        const u128 c = mul_mod128(a, sub_mod128(twice_b, six_a, m), m);
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

static std::string to_string128(u128 n) {
    if (n == 0) return "0";
    std::string s;
    while (n != 0) {
        s.push_back(static_cast<char>('0' + n % 10));
        n /= 10;
    }
    std::reverse(s.begin(), s.end());
    return s;
}

static std::vector<u64> distinct_prime_factors(u64 n) {
    std::vector<u64> ans;
    if ((n & 1U) == 0) {
        ans.push_back(2);
        while ((n & 1U) == 0) n >>= 1;
    }
    for (u64 p = 3; p * p <= n; p += 2) {
        if (n % p != 0) continue;
        ans.push_back(p);
        while (n % p == 0) n /= p;
    }
    if (n > 1) ans.push_back(n);
    return ans;
}

static u64 rank_of_apparition(u64 q, int legendre2) {
    u64 z = legendre2 == 1 ? q - 1 : q + 1;
    for (u64 p : distinct_prime_factors(z)) {
        while (z % p == 0 && balancing_mod64(z / p, q) == 0) z /= p;
    }
    return z;
}

// Return (A_n,B_n) modulo m for (1+sqrt(2))^n=A_n+B_n sqrt(2).
static std::pair<u64,u64> sqrt_two_power_mod(u64 n, u64 m) {
    u64 ra = 1, rb = 0;
    u64 aa = 1, ab = 1;
    while (n != 0) {
        if (n & 1U) {
            const u64 na = add_mod64(mul_mod64(ra, aa, m),
                                      mul_mod64(2, mul_mod64(rb, ab, m), m), m);
            const u64 nb = add_mod64(mul_mod64(ra, ab, m), mul_mod64(rb, aa, m), m);
            ra = na; rb = nb;
        }
        const u64 na = add_mod64(mul_mod64(aa, aa, m),
                                  mul_mod64(2, mul_mod64(ab, ab, m), m), m);
        const u64 nb = mul_mod64(2, mul_mod64(aa, ab, m), m);
        aa = na; ab = nb;
        n >>= 1;
    }
    return {ra, rb};
}

int main(int argc, char** argv) {
    const int limit = argc >= 2 ? std::stoi(argv[1]) : 10000000;
    const std::string output = argc >= 3 ? argv[2] : "depth3_scan_extended.csv";
    if (limit < 3 || limit > 100000000) {
        throw std::runtime_error("limit must lie in [3,100000000]");
    }
    // q^2 must fit u64 for the first-stage exhaustive filter.
    if (static_cast<u128>(limit) * limit >
        static_cast<u128>(~static_cast<u64>(0))) {
        throw std::runtime_error("q^2 does not fit uint64");
    }

    std::vector<bool> prime(static_cast<std::size_t>(limit) + 1, true);
    prime[0] = prime[1] = false;
    for (int p = 2; static_cast<long long>(p) * p <= limit; ++p) {
        if (!prime[p]) continue;
        for (int j = p * p; j <= limit; j += p) prime[j] = false;
    }

    std::ofstream csv(output, std::ios::binary);
    if (!csv) throw std::runtime_error("cannot open output");
    csv << "q,legendre_2,canonical_index,rank,rank_is_prime,channel,"
           "u_mod_q3,u_over_q2_mod_q,status\n";

    std::size_t odd_prime_count = 0;
    std::size_t wieferich_count = 0;
    std::size_t depth3_count = 0;
    for (int qi = 3; qi <= limit; qi += 2) {
        if (!prime[qi]) continue;
        ++odd_prime_count;
        const u64 q = static_cast<u64>(qi);
        const int r8 = qi & 7;
        const int legendre2 = (r8 == 1 || r8 == 7) ? 1 : -1;
        const u64 index = legendre2 == 1 ? q - 1 : q + 1;
        const u64 q2 = q * q;
        if (balancing_mod64(index, q2) != 0) continue;

        ++wieferich_count;
        const u128 q3 = static_cast<u128>(q) * q * q;
        const u128 residue = balancing_mod128(index, q3);
        const bool depth3 = residue == 0;
        if (depth3) ++depth3_count;
        const u128 quotient = residue / q2;

        const u64 rank = rank_of_apparition(q, legendre2);
        const auto factors = distinct_prime_factors(rank);
        const bool rank_prime = factors.size() == 1 && factors[0] == rank;
        const auto [A, B] = sqrt_two_power_mod(rank, q);
        const char channel = A == 0 ? 'A' : (B == 0 ? 'B' : '?');

        csv << q << ',' << legendre2 << ',' << index << ',' << rank << ','
            << (rank_prime ? "true" : "false") << ',' << channel << ','
            << to_string128(residue) << ',' << to_string128(quotient) << ','
            << (depth3 ? "valuation_at_least_3" : "valuation_exactly_2") << '\n';
    }
    csv.close();
    std::cout << "limit=" << limit << '\n';
    std::cout << "odd_primes_tested=" << odd_prime_count << '\n';
    std::cout << "wieferich_hits=" << wieferich_count << '\n';
    std::cout << "valuation_at_least_3_hits=" << depth3_count << '\n';
    std::cout << "output=" << output << '\n';
    return 0;
}
