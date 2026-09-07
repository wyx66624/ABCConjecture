"""Exact finite-field traces and integral local shadows of the boundary curve."""
from argparse import ArgumentParser
from hashlib import sha256
from json import dumps
from math import gcd
from pathlib import Path


def add(a,b,p):return ((a[0]+b[0])%p,(a[1]+b[1])%p)
def mul(a,b,p):
    return ((a[0]*b[0]-3*a[1]*b[1])%p,
            (a[0]*b[1]+a[1]*b[0])%p)


def F(a,b):return a**4+3*a**3*b+5*a*a*b*b+3*a*b**3+b**4


def run():
    p=5
    assert all(r*r%p!=(-3)%p for r in range(p))
    elements=[(u,v) for u in range(p) for v in range(p)]
    A=(12%p,0); B=(18%p,6%p)
    squares={z:sum(mul(y,y,p)==z for y in elements) for z in elements}
    count=1
    for x in elements:
        x2=mul(x,x,p)
        rhs=add(add(mul(x2,x,p),mul(A,x2,p),p),mul(B,x,p),p)
        count+=squares[rhs]
    trace=26-count
    assert trace==-8 and gcd(trace,5)==1
    rows=[{'characteristic':5,'residue_degree':2,'points':count,
           'trace':trace,'frobenius_discriminant':trace*trace-100}]
    for r in (2,5):
        p=7
        assert r*r%p==(-3)%p
        A=12%p;B=6*(3+r)%p
        count=1+sum((y*y-x**3-A*x*x-B*x)%p==0
                    for x in range(p) for y in range(p))
        trace=8-count
        assert abs(trace)==4 and gcd(trace,7)==1
        rows.append({'characteristic':7,'residue_degree':1,'r':r,
                     'points':count,'trace':trace,
                     'frobenius_discriminant':trace*trace-28})
    shadows=[]
    for primes in ([5],[7,13],[5,7,11,13],[17,19,23]):
        L=1
        for p in primes:L*=p
        for k in (1,2,7,23):
            a=L*k;b=a+1;x=a*a+b*b;y=a+b
            assert gcd(a,b)==1 and a>0 and b>0
            assert 2*x-y*y==(a-b)**2
            for p in primes:
                assert (a%p,b%p,x%p,y%p,F(a,b)%p)==(0,1,1,1,1)
            shadows.append({'primes':primes,'k':k,'a':a,'b':b,
                            'F':F(a,b)})
    return {'scope':'exact finite traces and local residue shadows; no global power or modular identification',
            'field_traces':rows,'actual_residue_shadows':shadows}


def main():
    parser=ArgumentParser();parser.add_argument('--check',action='store_true')
    args=parser.parse_args(); data=run()
    raw=(dumps(data,sort_keys=True,indent=2)+'\n').encode('utf-8')
    path=Path(__file__).parent/'verification'/'boundary_shadow_results.json'
    if args.check:assert path.read_bytes()==raw
    else:path.parent.mkdir(exist_ok=True);path.write_bytes(raw)
    print(dumps({'status':'PASS','field_traces':data['field_traces'],
                 'actual_shadows':len(data['actual_residue_shadows']),
                 'sha256':sha256(raw).hexdigest()}))


if __name__=='__main__':main()
