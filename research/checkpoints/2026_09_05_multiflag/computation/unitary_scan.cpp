#include <algorithm>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <numeric>
#include <vector>
using namespace std;
int main(int argc,char**argv){
 int N=argc>1?atoi(argv[1]):3000;
 vector<int> spf(N+1);vector<vector<int>> u(N+1);u[1]={1};
 for(int p=2;p<=N;p++)if(!spf[p])for(int k=p;k<=N;k+=p)if(!spf[k])spf[k]=p;
 for(int n=2;n<=N;n++){int m=n;u[n]={1};while(m>1){int p=spf[m],pp=1;do{m/=p;pp*=p;}while(m%p==0);int z=u[n].size();for(int j=0;j<z;j++)u[n].push_back(u[n][j]*pp);}}
 long long triples=0,faces=0,checks=0,equalities=0,refined=0;
 for(int c=2;c<=N;c++) for(int a=1;a<=c/2;a++){
  int b=c-a;if(gcd(a,b)!=1)continue;triples++;
  for(int A:u[a])for(int B:u[b]){
   if((A==1&&B==1)||(A==a&&B==b))continue;faces++;
   for(int M:u[c])if(M>=4&&(A+B)%M==0){
    checks++;int64_t bound=(M%3==1)?(int64_t)(2*M-1)*(M+1):(int64_t)(M-1)*(2*M+1);
    if(M%3==1)refined++;
    if((int64_t)a*b<bound){fprintf(stderr,"FAIL %d %d %d M=%d A=%d B=%d\n",a,b,c,M,A,B);return 1;}
    if((int64_t)a*b==bound)equalities++;
   }
  }
 }
 printf("{\"c_bound\":%d,\"primitive_triples\":%lld,\"proper_faces\":%lld,\"compatible_unitary_modulus_cases\":%lld,\"mod3_refined_cases\":%lld,\"equality_cases\":%lld,\"counterexamples\":0}\n",N,triples,faces,checks,refined,equalities);
}
