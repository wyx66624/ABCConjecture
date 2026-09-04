#include <algorithm>
#include <array>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <numeric>
#include <sstream>
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

static bool operator==(const Hit &x, const Hit &y) {
  return x.a == y.a && x.b == y.b && x.c == y.c && x.rad_a == y.rad_a &&
         x.rad_b == y.rad_b && x.rad_c == y.rad_c && x.radical_abc == y.radical_abc;
}

static std::vector<Hit> read_hits(const std::string &path) {
  std::ifstream in(path, std::ios::binary);
  if (!in) throw std::runtime_error("cannot open expected hit file");
  std::string line;
  if (!std::getline(in, line) || line != "a,b,c,rad_a,rad_b,rad_c,radical_abc") {
    throw std::runtime_error("unexpected CSV header");
  }
  std::vector<Hit> ans;
  while (std::getline(in, line)) {
    if (line.empty()) continue;
    std::replace(line.begin(), line.end(), ',', ' ');
    std::istringstream row(line);
    Hit h{};
    if (!(row >> h.a >> h.b >> h.c >> h.rad_a >> h.rad_b >> h.rad_c >> h.radical_abc)) {
      throw std::runtime_error("malformed CSV row");
    }
    std::string extra;
    if (row >> extra) throw std::runtime_error("extra CSV field");
    ans.push_back(h);
  }
  if (!std::is_sorted(ans.begin(), ans.end())) throw std::runtime_error("CSV rows not sorted");
  return ans;
}

int main(int argc, char **argv) {
  try {
    std::uint32_t max_c = 100000;
    std::string hits_path = "ABC_HITS.csv";
    int requested_threads = 0;
    for (int i = 1; i < argc; ++i) {
      const std::string arg = argv[i];
      if (arg == "--max-c" && i + 1 < argc) max_c = std::stoul(argv[++i]);
      else if (arg == "--hits" && i + 1 < argc) hits_path = argv[++i];
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

    // Independent radical construction: multiply p into every multiple of each
    // prime.  The producer instead uses a smallest-prime-factor recurrence.
    std::vector<std::uint32_t> radical(max_c + 1, 1);
    std::vector<bool> prime(max_c + 1, true);
    prime[0] = prime[1] = false;
    for (std::uint32_t p = 2; p <= max_c; ++p) {
      if (!prime[p]) continue;
      for (std::uint64_t m = p; m <= max_c; m += p) {
        radical[static_cast<std::size_t>(m)] *= p;
        if (m > p) prime[static_cast<std::size_t>(m)] = false;
      }
    }

    // The primitive-triple count is independently obtained from
    // sum_{3<=c<=N} phi(c)/2.
    std::vector<std::uint32_t> phi(max_c + 1);
    std::iota(phi.begin(), phi.end(), 0);
    for (std::uint32_t p = 2; p <= max_c; ++p) {
      if (phi[p] != p) continue;
      for (std::uint32_t m = p; m <= max_c; m += p) phi[m] -= phi[m] / p;
    }
    std::uint64_t primitive_count = 0;
    for (std::uint32_t c = 3; c <= max_c; ++c) primitive_count += phi[c] / 2;

    std::vector<std::vector<Hit>> local_hits(static_cast<std::size_t>(thread_count));
#pragma omp parallel
    {
#ifdef _OPENMP
      const int tid = omp_get_thread_num();
#else
      const int tid = 0;
#endif
      auto &found = local_hits[static_cast<std::size_t>(tid)];
#pragma omp for schedule(dynamic, 64)
      for (std::int64_t c_signed = 3; c_signed <= static_cast<std::int64_t>(max_c); ++c_signed) {
        const auto c = static_cast<std::uint32_t>(c_signed);
        const std::uint32_t half = (c - 1) / 2;
        for (std::uint32_t a = 1; a <= half; ++a) {
          const std::uint32_t b = c - a;
          const std::uint64_t r =
              static_cast<std::uint64_t>(radical[a]) * radical[b] * radical[c];
          if (static_cast<std::uint64_t>(c) <= r) continue;
          if (std::gcd(a, c) != 1) continue;
          found.push_back(Hit{a, b, c, radical[a], radical[b], radical[c], r});
        }
      }
    }
    std::vector<Hit> actual;
    for (auto &part : local_hits) actual.insert(actual.end(), part.begin(), part.end());
    std::sort(actual.begin(), actual.end());
    const auto expected = read_hits(hits_path);
    if (actual.size() != expected.size()) throw std::runtime_error("hit count mismatch");
    for (std::size_t i = 0; i < actual.size(); ++i) {
      if (!(actual[i] == expected[i])) {
        throw std::runtime_error("first hit mismatch at zero-based row " + std::to_string(i));
      }
      const auto &h = actual[i];
      if (h.a + h.b != h.c || !(h.a < h.b) || std::gcd(h.a, h.b) != 1 ||
          h.radical_abc != static_cast<std::uint64_t>(h.rad_a) * h.rad_b * h.rad_c ||
          h.c <= h.radical_abc) {
        throw std::runtime_error("exact row invariant failed");
      }
    }
    std::cout << "status=PASS\n"
              << "validator_algorithm=prime-multiple radical sieve plus direct pair threshold and gcd\n"
              << "primitive_count_algorithm=sum_phi_over_two\n"
              << "max_c=" << max_c << '\n'
              << "primitive_triples=" << primitive_count << '\n'
              << "abc_hits_c_gt_radical=" << actual.size() << '\n'
              << "all_csv_rows_exactly_reproduced=true\n";
    return 0;
  } catch (const std::exception &e) {
    std::cerr << "ERROR: " << e.what() << '\n';
    return 2;
  }
}
