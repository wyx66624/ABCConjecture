#include <cstdint>
#include <iostream>
#include <vector>
using u64=std::uint64_t; using u128=unsigned __int128;
static u64 mulmod(u64 a,u64 b,u64 m){return (u128)a*b % m;}
static u64 powmod(u64 a,u64 e,u64 m){u64 r=1%m;while(e){if(e&1)r=mulmod(r,a,m);a=mulmod(a,a,m);e>>=1;}return r;}
static std::vector<u64> factor_distinct(u64 n,const std::vector<int>&pr){std::vector<u64> f;for(int pp:pr){u64 p=pp;if(p*p>n)break;if(n%p==0){f.push_back(p);while(n%p==0)n/=p;}}if(n>1)f.push_back(n);return f;}
int main(int argc,char**argv){int N=argc>1?std::stoi(argv[1]):20000000;std::vector<bool> isp(N+1,true);isp[0]=isp[1]=false;for(int p=2;(long long)p*p<=N;++p)if(isp[p])for(long long j=1LL*p*p;j<=N;j+=p)isp[(size_t)j]=false;std::vector<int> primes;for(int p=2;p<=N;++p)if(isp[p])primes.push_back(p);std::cout<<"{\n  \"limit\": "<<N<<",\n  \"prime_count\": "<<primes.size()<<",\n  \"hits\": [\n";bool first=true;for(int pi:primes){if(pi==2)continue;u64 p=pi, p2=p*p;if(powmod(2,p-1,p2)!=1)continue;u64 d=p-1;auto fs=factor_distinct(d,primes);for(u64 q:fs)while(d%q==0 && powmod(2,d/q,p)==1)d/=q;u64 rr=(p-1)/d;if(!first)std::cout<<",\n";first=false;std::cout<<"    {\"p\": "<<p<<", \"d\": "<<d<<", \"r\": "<<rr<<"}";}std::cout<<"\n  ]\n}\n";}
