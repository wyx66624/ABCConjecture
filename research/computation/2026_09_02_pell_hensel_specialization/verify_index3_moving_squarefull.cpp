#include <algorithm>
#include <cmath>
#include <cstdint>
#include <iostream>
#include <map>
#include <stdexcept>
#include <vector>

using u64 = std::uint64_t;

static u64 isqrt_u64(u64 n) {
    if (n == 0) return 0;
    u64 x = static_cast<u64>(std::sqrt(static_cast<long double>(n)));
    while ((x + 1) <= n / (x + 1)) ++x;
    while (x > n / x) --x;
    return x;
}

static std::map<u64, int> factor_trial(u64 n) {
    std::map<u64, int> out;
    for (u64 d = 2; d <= n / d; d += (d == 2 ? 1 : 2)) {
        while (n % d == 0) {
            ++out[d];
            n /= d;
        }
    }
    if (n > 1) ++out[n];
    return out;
}

int main() {
    constexpr u64 s_max = 10000000ULL;
    constexpr u64 value_max = 4ULL * s_max * s_max + 1ULL;
    u64 b_max = 0;
    while ((b_max + 1) * (b_max + 1) <= value_max / (b_max + 1)) ++b_max;

    std::vector<unsigned char> squarefree(b_max + 1, 1);
    squarefree[0] = 0;
    for (u64 d = 2; d * d <= b_max; ++d) {
        const u64 dd = d * d;
        for (u64 k = dd; k <= b_max; k += dd) squarefree[k] = 0;
    }

    u64 tested = 0;
    std::vector<u64> candidates;
    u64 witness_a = 0, witness_b = 0;
    for (u64 b = 1; b <= b_max; ++b) {
        if (!squarefree[b]) continue;
        const u64 b3 = b * b * b;
        const u64 a_max = isqrt_u64(value_max / b3);
        tested += a_max;
        for (u64 a = 1; a <= a_max; ++a) {
            const u64 value = a * a * b3;
            if (value % 4 != 1) continue;
            const u64 s2 = (value - 1) / 4;
            const u64 s = isqrt_u64(s2);
            if (s == 0 || s > s_max || s * s != s2) continue;
            candidates.push_back(s);
            if (s == 341) {
                witness_a = a;
                witness_b = b;
            }
        }
    }
    std::sort(candidates.begin(), candidates.end());
    if (tested != 43355470ULL) throw std::runtime_error("representation count mismatch");
    if (candidates != std::vector<u64>{341ULL}) throw std::runtime_error("candidate list mismatch");
    if (witness_a != 61 || witness_b != 5) throw std::runtime_error("powerful representation mismatch");

    const u64 s = 341;
    const u64 F = 4 * s * s + 1;
    const u64 A = s * (4 * s * s + 3);
    const auto fF = factor_trial(F);
    const auto fA = factor_trial(A);
    const std::map<u64, int> expected_F{{5, 3}, {61, 2}};
    const std::map<u64, int> expected_A{{11, 1}, {13, 1}, {31, 1}, {37, 1}, {967, 1}};
    if (fF != expected_F || fA != expected_A) throw std::runtime_error("factorization mismatch");
    for (const auto &[p, e] : fA) {
        if (e == 1) goto simple_found;
    }
    throw std::runtime_error("A channel unexpectedly squarefull");

simple_found:
    std::cout << "{\n"
              << "  \"status\": \"PASS\",\n"
              << "  \"powerful_representations_tested\": " << tested << ",\n"
              << "  \"F3_squarefull_candidate_count\": 1,\n"
              << "  \"candidate_s\": 341,\n"
              << "  \"candidate_T\": 682,\n"
              << "  \"full_two_channel_hits\": 0,\n"
              << "  \"logical_boundary\": \"bounded search only\"\n"
              << "}\n";
    return 0;
}
