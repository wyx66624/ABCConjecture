#include <algorithm>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

using u64 = std::uint64_t;
using u128 = unsigned __int128;

static u64 mul_mod(u64 a, u64 b, u64 m) {
  return static_cast<u64>((static_cast<u128>(a) * b) % m);
}

static u64 pow_mod(u64 a, u64 e, u64 m) {
  u64 r = 1 % m;
  while (e) {
    if (e & 1) r = mul_mod(r, a, m);
    a = mul_mod(a, a, m);
    e >>= 1;
  }
  return r;
}

static bool is_prime_u64(u64 n) {
  if (n < 2) return false;
  for (u64 p : {2ULL, 3ULL, 5ULL, 7ULL, 11ULL, 13ULL, 17ULL, 19ULL,
                23ULL, 29ULL, 31ULL, 37ULL}) {
    if (n % p == 0) return n == p;
  }
  u64 d = n - 1, s = 0;
  while ((d & 1) == 0) { d >>= 1; ++s; }
  // Deterministic for all unsigned 64-bit integers.
  for (u64 a : {2ULL, 325ULL, 9375ULL, 28178ULL, 450775ULL,
                9780504ULL, 1795265022ULL}) {
    if (a % n == 0) continue;
    u64 x = pow_mod(a % n, d, n);
    if (x == 1 || x == n - 1) continue;
    bool witness = true;
    for (u64 r = 1; r < s; ++r) {
      x = mul_mod(x, x, n);
      if (x == n - 1) { witness = false; break; }
    }
    if (witness) return false;
  }
  return true;
}

struct Mat2 { u64 a, b, c, d; };

static Mat2 mat_mul(const Mat2 &x, const Mat2 &y, u64 m) {
  return {
    (mul_mod(x.a,y.a,m)+mul_mod(x.b,y.c,m))%m,
    (mul_mod(x.a,y.b,m)+mul_mod(x.b,y.d,m))%m,
    (mul_mod(x.c,y.a,m)+mul_mod(x.d,y.c,m))%m,
    (mul_mod(x.c,y.b,m)+mul_mod(x.d,y.d,m))%m
  };
}

static u64 balancing_mod(unsigned n, u64 m) {
  if (n == 0) return 0;
  Mat2 r{1,0,0,1};
  Mat2 q{6 % m,(m-1)%m,1,0};
  unsigned e = n - 1;
  while (e) {
    if (e & 1) r = mat_mul(r,q,m);
    q = mat_mul(q,q,m);
    e >>= 1;
  }
  return r.a;
}

static std::vector<unsigned> primes_up_to(unsigned limit) {
  std::vector<bool> sieve(limit + 1, true);
  if (limit >= 0) sieve[0] = false;
  if (limit >= 1) sieve[1] = false;
  for (unsigned p=2; static_cast<u64>(p)*p<=limit; ++p)
    if (sieve[p])
      for (unsigned q=p*p; q<=limit; q+=p) sieve[q]=false;
  std::vector<unsigned> ans;
  for (unsigned p=2; p<=limit; ++p) if (sieve[p]) ans.push_back(p);
  return ans;
}

struct Certificate {
  u64 p = 0;
  u64 residue_mod_p2 = 0;
  std::string method;
};

int main(int argc, char **argv) {
  unsigned nmax = argc > 1 ? std::stoul(argv[1]) : 2000;
  unsigned tmax = argc > 2 ? std::stoul(argv[2]) : 60;
  unsigned small_limit = argc > 3 ? std::stoul(argv[3]) : 200000;
  u64 prime_index_limit = argc > 4 ? std::stoull(argv[4]) : 500000000ULL;

  const auto primes = primes_up_to(small_limit);
  std::vector<Certificate> bc(nmax+1), dc(tmax+1);

  // Exact coefficients of (9+4*sqrt(5))^10.  This is the least positive
  // power that keeps z == 57 (mod 125) along the chosen Danilov orbit.
  const u64 eta_a = 1730726404001ULL;
  const u64 eta_b = 774004377960ULL;

  unsigned unresolved_b = nmax >= 2 ? nmax-1 : 0;
  unsigned unresolved_d = tmax+1;
  for (unsigned p32 : primes) {
    const u64 p = p32;
    const u64 m = p*p;

    if (unresolved_b) {
      u64 u0=0, u1=1 % m;
      for (unsigned n=1; n<=nmax; ++n) {
        const u64 u = (n==1) ? u1 : (6*u1 + m - u0) % m;
        if (n>=2 && bc[n].p==0 && u%p==0 && u!=0) {
          bc[n] = {p,u,"small-prime recurrence scan"};
          --unresolved_b;
        }
        if (n>=2) { u0=u1; u1=u; }
      }
    }

    if (unresolved_d && p!=3 && p!=5) {
      u64 z=682 % m, w=305 % m;
      const u64 aa=eta_a%m, bb=eta_b%m;
      for (unsigned t=0; t<=tmax; ++t) {
        u64 L=(2*z+11)%m;
        if (dc[t].p==0 && L%p==0 && L!=0) {
          dc[t]={p,L,"small-prime orbit scan"};
          --unresolved_d;
        }
        const u64 zn=(mul_mod(aa,z,m)+mul_mod((5*bb)%m,w,m))%m;
        const u64 wn=(mul_mod(bb,z,m)+mul_mod(aa,w,m))%m;
        z=zn; w=wn;
      }
    }
    if (!unresolved_b && !unresolved_d) break;
  }

  // A prime-index Lucas divisor p has rank n and hence p == +/-1 (mod 2n).
  // Search these necessary congruence classes only for unresolved prime n.
  for (unsigned n=3; n<=nmax; n+=2) {
    if (bc[n].p || !is_prime_u64(n)) continue;
    const u64 step=2ULL*n;
    for (u64 k=1;;++k) {
      bool exhausted=true;
      for (int sign : {-1,1}) {
        u64 p=step*k;
        if (sign<0) { if (p<=1) continue; --p; }
        else { if (p==UINT64_MAX) continue; ++p; }
        if (p>prime_index_limit) continue;
        exhausted=false;
        if (!is_prime_u64(p)) continue;
        const u64 m=p*p;
        const u64 r=balancing_mod(n,m);
        if (r%p==0 && r!=0) {
          bc[n]={p,r,"prime-index congruence search"};
          --unresolved_b;
          break;
        }
      }
      if (bc[n].p || exhausted || step*k > prime_index_limit+1) break;
    }
  }

  std::ofstream bout("balancing_certificates.csv");
  bout << "n,is_prime_index,p,residue_mod_p2,quotient_mod_p,method,status\n";
  for (unsigned n=2;n<=nmax;++n) {
    if (bc[n].p) {
      bout << n << ',' << (is_prime_u64(n)?1:0) << ',' << bc[n].p << ','
           << bc[n].residue_mod_p2 << ','
           << (bc[n].residue_mod_p2/bc[n].p) << ','
           << bc[n].method << ",not_squarefull\n";
    } else {
      bout << n << ',' << (is_prime_u64(n)?1:0)
           << ",,,,,unresolved_by_search\n";
    }
  }

  std::ofstream dout("danilov_certificates.csv");
  dout << "t,p,L_mod_p2,quotient_mod_p,method,status\n";
  for (unsigned t=0;t<=tmax;++t) {
    if (dc[t].p) {
      dout << t << ',' << dc[t].p << ',' << dc[t].residue_mod_p2 << ','
           << (dc[t].residue_mod_p2/dc[t].p) << ','
           << dc[t].method << ",K_not_squarefull\n";
    } else {
      dout << t << ",,,,,unresolved_by_search\n";
    }
  }

  std::ofstream meta("certificate_search_summary.txt");
  meta << "nmax=" << nmax << "\n"
       << "tmax=" << tmax << "\n"
       << "small_prime_limit=" << small_limit << "\n"
       << "prime_index_limit=" << prime_index_limit << "\n"
       << "small_prime_count=" << primes.size() << "\n"
       << "balancing_unresolved=" << unresolved_b << "\n"
       << "danilov_unresolved=" << unresolved_d << "\n";

  std::cout << "balancing unresolved: " << unresolved_b << " / " << (nmax-1)
            << "\ndanilov unresolved: " << unresolved_d << " / " << (tmax+1)
            << "\n";
  return unresolved_b || unresolved_d ? 2 : 0;
}
