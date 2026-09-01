#include <algorithm>
#include <cstdint>
#include <fstream>
#include <iostream>
#include <string>
#include <vector>

using u64=std::uint64_t;
using u128=unsigned __int128;

static u64 mul_mod(u64 a,u64 b,u64 m){return (u128(a)*b)%m;}
static u64 pow_mod(u64 a,u64 e,u64 m){u64 r=1%m;while(e){if(e&1)r=mul_mod(r,a,m);a=mul_mod(a,a,m);e>>=1;}return r;}
static bool prime(u64 n){
  if(n<2)return false;
  for(u64 p:{2ULL,3ULL,5ULL,7ULL,11ULL,13ULL,17ULL,19ULL,23ULL,29ULL,31ULL,37ULL})
    if(n%p==0)return n==p;
  u64 d=n-1,s=0;while(!(d&1)){d>>=1;++s;}
  for(u64 a:{2ULL,325ULL,9375ULL,28178ULL,450775ULL,9780504ULL,1795265022ULL}){
    if(a%n==0)continue;u64 x=pow_mod(a%n,d,n);if(x==1||x==n-1)continue;
    bool bad=true;for(u64 r=1;r<s;++r){x=mul_mod(x,x,n);if(x==n-1){bad=false;break;}}
    if(bad)return false;
  }return true;
}
struct M{u64 a,b,c,d;};
static M mm(M x,M y,u64 m){return{(mul_mod(x.a,y.a,m)+mul_mod(x.b,y.c,m))%m,(mul_mod(x.a,y.b,m)+mul_mod(x.b,y.d,m))%m,(mul_mod(x.c,y.a,m)+mul_mod(x.d,y.c,m))%m,(mul_mod(x.c,y.b,m)+mul_mod(x.d,y.d,m))%m};}
static u64 umod(unsigned n,u64 m){M r{1,0,0,1},q{6%m,(m-1)%m,1,0};unsigned e=n-1;while(e){if(e&1)r=mm(r,q,m);q=mm(q,q,m);e>>=1;}return r.a;}
static std::string dec(u128 x){if(!x)return"0";std::string s;while(x){s.push_back('0'+x%10);x/=10;}std::reverse(s.begin(),s.end());return s;}
static u128 umodp2(unsigned n,u64 p){u128 m=u128(p)*p,a=0,b=1;for(unsigned i=0;i<n;++i){u128 c=(6*b+m-a)%m;a=b;b=c;}return a;}
static int legendre2(u64 p){u64 r=p%8;return(r==1||r==7)?1:-1;}

int main(int argc,char**argv){
  u64 low=argc>1?std::stoull(argv[1]):500000000ULL;
  u64 high=argc>2?std::stoull(argv[2]):10000000000ULL;
  std::vector<unsigned> ns={1009,1181,1447,1523,1621,1667,1699,1723,1801,1847,1873,1879,1901,1913,1951};
  std::ofstream out("balancing_deep_prime_index_certificates.csv");
  out<<"n,p,residue_mod_p2,quotient_mod_p,status\n";
  for(unsigned n:ns){
    bool found=false;u64 step=2ULL*n,k0=low/step;
    if(k0*step<=low)++k0;
    for(u64 k=k0;step*k<=high+1;++k){
      for(int sign:{-1,1}){
        u64 p=step*k;if(sign<0){if(p<=1)continue;--p;}else ++p;
        if(p<=low||p>high)continue;
        int needed=sign; // p == sign (mod n), so (32/p) must equal sign.
        if(legendre2(p)!=needed||!prime(p)||umod(n,p)!=0)continue;
        u128 r=umodp2(n,p);
        if(r%p==0&&r!=0){out<<n<<','<<p<<','<<dec(r)<<','<<dec(r/p)<<",not_squarefull\n";found=true;break;}
      }
      if(found)break;
    }
    if(!found)out<<n<<",,,,unresolved_by_search\n";
    std::cerr<<n<<":"<<(found?"found":"unresolved")<<"\n";
  }
}
