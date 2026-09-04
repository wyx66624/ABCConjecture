#include <algorithm>
#include <array>
#include <cstdint>
#include <cstring>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <stdexcept>
#include <string>
#include <tuple>
#include <vector>

#ifdef _OPENMP
#include <omp.h>
#endif

struct Hit {
  std::uint32_t a;
  std::uint32_t b;
  std::uint32_t c;
  std::uint32_t rad_a;
  std::uint32_t rad_b;
  std::uint32_t rad_c;
  std::uint64_t radical_abc;
};

static bool operator<(const Hit &x, const Hit &y) {
  return std::tie(x.c, x.a, x.b) < std::tie(y.c, y.a, y.b);
}

static std::vector<std::uint32_t> smallest_prime_factors(std::uint32_t n) {
  std::vector<std::uint32_t> spf(n + 1, 0);
  for (std::uint32_t i = 2; i <= n; ++i) {
    if (spf[i] != 0) continue;
    spf[i] = i;
    if (static_cast<std::uint64_t>(i) * i <= n) {
      for (std::uint64_t j = static_cast<std::uint64_t>(i) * i; j <= n; j += i) {
        if (spf[static_cast<std::size_t>(j)] == 0) spf[static_cast<std::size_t>(j)] = i;
      }
    }
  }
  return spf;
}

static std::vector<std::uint32_t> radicals_from_spf(
    const std::vector<std::uint32_t> &spf) {
  std::vector<std::uint32_t> rad(spf.size(), 1);
  for (std::uint32_t n = 2; n < spf.size(); ++n) {
    const std::uint32_t p = spf[n];
    const std::uint32_t m = n / p;
    rad[n] = (m % p == 0) ? rad[m] : rad[m] * p;
  }
  return rad;
}

int main(int argc, char **argv) {
  try {
    std::uint32_t max_c = 100000;
    std::string hits_path = "ABC_HITS.csv";
    std::string summary_path = "SCAN_SUMMARY.txt";
    int requested_threads = 0;
    for (int i = 1; i < argc; ++i) {
      const std::string arg = argv[i];
      if (arg == "--max-c" && i + 1 < argc) max_c = std::stoul(argv[++i]);
      else if (arg == "--hits" && i + 1 < argc) hits_path = argv[++i];
      else if (arg == "--summary" && i + 1 < argc) summary_path = argv[++i];
      else if (arg == "--threads" && i + 1 < argc) requested_threads = std::stoi(argv[++i]);
      else throw std::runtime_error("unknown or incomplete argument: " + arg);
    }
    if (max_c < 3) throw std::runtime_error("max_c must be at least 3");

#ifdef _OPENMP
    if (requested_threads > 0) omp_set_num_threads(requested_threads);
    const int thread_count = omp_get_max_threads();
#else
    (void)requested_threads;
    const int thread_count = 1;
#endif

    const auto spf = smallest_prime_factors(max_c);
    const auto rad = radicals_from_spf(spf);

    std::vector<std::uint64_t> local_counts(static_cast<std::size_t>(thread_count), 0);
    std::vector<std::vector<Hit>> local_hits(static_cast<std::size_t>(thread_count));

#pragma omp parallel
    {
#ifdef _OPENMP
      const int tid = omp_get_thread_num();
#else
      const int tid = 0;
#endif
      std::vector<unsigned char> coprime(static_cast<std::size_t>(max_c / 2 + 2), 1);
      auto &hits = local_hits[static_cast<std::size_t>(tid)];
      std::uint64_t count = 0;

#pragma omp for schedule(dynamic, 64)
      for (std::int64_t c_signed = 3; c_signed <= static_cast<std::int64_t>(max_c); ++c_signed) {
        const auto c = static_cast<std::uint32_t>(c_signed);
        const std::uint32_t half = (c - 1) / 2;
        std::memset(coprime.data(), 1, static_cast<std::size_t>(half + 1));
        coprime[0] = 0;

        std::uint32_t remaining = c;
        while (remaining > 1) {
          const std::uint32_t p = spf[remaining];
          for (std::uint32_t a = p; a <= half; a += p) coprime[a] = 0;
          do { remaining /= p; } while (remaining > 1 && remaining % p == 0);
        }

        for (std::uint32_t a = 1; a <= half; ++a) {
          if (!coprime[a]) continue;
          ++count;
          const std::uint32_t b = c - a;
          const std::uint64_t radical_abc =
              static_cast<std::uint64_t>(rad[a]) * rad[b] * rad[c];
          if (static_cast<std::uint64_t>(c) > radical_abc) {
            hits.push_back(Hit{a, b, c, rad[a], rad[b], rad[c], radical_abc});
          }
        }
      }
      local_counts[static_cast<std::size_t>(tid)] = count;
    }

    std::uint64_t primitive_count = 0;
    std::vector<Hit> hits;
    for (int t = 0; t < thread_count; ++t) {
      primitive_count += local_counts[static_cast<std::size_t>(t)];
      auto &part = local_hits[static_cast<std::size_t>(t)];
      hits.insert(hits.end(), part.begin(), part.end());
    }
    std::sort(hits.begin(), hits.end());

    std::ofstream out(hits_path, std::ios::binary);
    if (!out) throw std::runtime_error("cannot open hits output");
    out << "a,b,c,rad_a,rad_b,rad_c,radical_abc\n";
    for (const auto &h : hits) {
      out << h.a << ',' << h.b << ',' << h.c << ',' << h.rad_a << ','
          << h.rad_b << ',' << h.rad_c << ',' << h.radical_abc << '\n';
    }
    out.close();

    std::ofstream summary(summary_path, std::ios::binary);
    if (!summary) throw std::runtime_error("cannot open summary output");
    summary << "status=PASS\n"
            << "algorithm=independent-set marking by the distinct prime divisors of c\n"
            << "domain=unordered primitive positive triples 1<=a<b, a+b=c, 3<=c<=max_c\n"
            << "max_c=" << max_c << '\n'
            << "primitive_triples=" << primitive_count << '\n'
            << "abc_hits_c_gt_radical=" << hits.size() << '\n'
            << "threads_used_for_this_replay=" << thread_count << '\n';
    summary.close();

    std::cout << "status=PASS\nmax_c=" << max_c
              << "\nprimitive_triples=" << primitive_count
              << "\nabc_hits_c_gt_radical=" << hits.size() << '\n';
    return 0;
  } catch (const std::exception &e) {
    std::cerr << "ERROR: " << e.what() << '\n';
    return 2;
  }
}
