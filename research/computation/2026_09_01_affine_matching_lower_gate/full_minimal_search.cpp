#include <cstdint>
#include <iostream>
#include <numeric>
#include <string>
#include <vector>

using u128 = unsigned __int128;

static std::string decimal(u128 x) {
  if (x == 0) return "0";
  std::string s;
  while (x) { s.push_back(char('0' + x % 10)); x /= 10; }
  return std::string(s.rbegin(), s.rend());
}

int main() {
  constexpr std::uint64_t a=1,b=8,c=9,L=6,R=6,Kpow=531441; // c^6
  const std::uint64_t M=Kpow/(4*L);
  const std::uint64_t maxn=1+L*(M+c*M);
  std::vector<std::uint32_t> rad(maxn+1,1);
  std::vector<std::uint32_t> primes;
  for (std::uint64_t p=2;p<=maxn;++p) if(rad[p]==1) {
    primes.push_back(static_cast<std::uint32_t>(p));
    for(std::uint64_t j=p;j<=maxn;j+=p) rad[j]*=static_cast<std::uint32_t>(p);
  }
  const std::uint64_t cutoff=(Kpow-1)/R; // rad(U)rad(V)rad(W) < c^6/R
  std::uint64_t admissible=0,necessary=0,admissible_necessary=0,exceptional=0;
  std::uint64_t sample_h=0,sample_k=0,sample_U=0,sample_V=0,sample_W=0;
  std::uint64_t sample_H=0,sample_rr=0;
  u128 sample_num=0,sample_den=1;
  for(std::uint64_t h=1;h<=M;++h){
    const std::uint64_t U=1+L*h, rU=rad[U];
    std::vector<std::pair<std::uint64_t,int>> mobius{{1,1}};
    std::uint64_t squarefree=rU;
    for (auto p:primes) {
      if ((std::uint64_t)p*p>squarefree) break;
      if (squarefree%p==0) {
        const auto old=mobius;
        for (auto [d,sgn]:old) mobius.push_back({d*p,-sgn});
        squarefree/=p;
      }
    }
    if(squarefree>1){
      const auto old=mobius;
      for(auto [d,sgn]:old) mobius.push_back({d*squarefree,-sgn});
    }
    std::int64_t coprime_count=0;
    for(auto [d,sgn]:mobius) coprime_count+=sgn*static_cast<std::int64_t>(M/d);
    admissible+=static_cast<std::uint64_t>(coprime_count);
    if(rU>cutoff) continue;
    for(std::uint64_t k=1;k<=M;++k){
      const std::uint64_t V=1+L*(h+c*k), rV=rad[V];
      if(rU>cutoff/rV) continue;
      const std::uint64_t W=1+L*(h+b*k), rW=rad[W];
      if(rU*rV>cutoff/rW) continue;
      ++necessary;
      if(std::gcd(U,k)!=1) continue;
      ++admissible_necessary;
      const std::uint64_t H=c*W;
      const std::uint64_t rr=R*rU*rV*rW;
      const u128 rr2=(u128)rr*rr;
      const u128 h2=(u128)H*H;
      const u128 num=h2*H, den=rr2*rr2;
      if(num<=den) {
        // Retain one fixed diagnostic row; this selection is not part of the
        // exhaustive exceptional-set decision above.
        if(h==104 && k==292){
          sample_h=h; sample_k=k; sample_U=U; sample_V=V; sample_W=W;
          sample_H=H; sample_rr=rr; sample_num=num; sample_den=den;
        }
      } else {
        ++exceptional;
      }
    }
  }
  if(M!=22143 || maxn!=1328581 || admissible!=447120793 ||
     necessary!=46 || admissible_necessary!=32 || exceptional!=0 ||
     sample_h==0){
    std::cerr << "exact regression check failed\n";
    return 1;
  }
  std::cout << "M=" << M << " maxn=" << maxn
            << " raw_pairs=" << M*M << " admissible=" << admissible
            << " necessary_radprod_cutoff=" << cutoff
            << " necessary=" << necessary
            << " admissible_necessary=" << admissible_necessary
            << " exceptional=" << exceptional << "\n";
  std::cout << "sample=(h=" << sample_h << ",k=" << sample_k
            << ",U=" << sample_U << ",V=" << sample_V << ",W=" << sample_W
            << ",H=" << sample_H << ",radical=" << sample_rr << ")\n"
            << "sample_H3=" << decimal(sample_num)
            << " sample_radical4=" << decimal(sample_den) << "\n";
}
