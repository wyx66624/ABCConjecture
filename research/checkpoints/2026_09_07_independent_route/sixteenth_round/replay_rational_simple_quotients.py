"""Exact small-field arithmetic for QS; no rank or rational-point oracle."""
from pathlib import Path
import argparse
import hashlib
import itertools
import json

P=5
NS=2

def add(z,w): return ((z[0]+w[0])%P,(z[1]+w[1])%P)
def mul(z,w): return ((z[0]*w[0]+NS*z[1]*w[1])%P,(z[0]*w[1]+z[1]*w[0])%P)
def scale(a,z): return (a*z[0]%P,a*z[1]%P)
def cubic(t,z):
    return add(add(mul(mul(z,z),z),scale(3*t,mul(z,z))),add(scale(3*t-3,z),(-1%P,0)))
def character(z):
    norm=(z[0]*z[0]-NS*z[1]*z[1])%P
    return 0 if norm==0 else (1 if pow(norm,(P-1)//2,P)==1 else -1)
def trim(a):
    while len(a)>1 and a[-1]==0:a.pop()
    return a

def pmul(a,b):
    c=[0]*(len(a)+len(b)-1)
    for i,x in enumerate(a):
        for j,y in enumerate(b):c[i+j]=(c[i+j]+x*y)%P
    return trim(c)
def prem(a,b):
    a=a[:]
    while a!=[0] and len(a)>=len(b):
        r=a[-1]*pow(b[-1],-1,P)%P;shift=len(a)-len(b)
        for j,c in enumerate(b):a[j+shift]=(a[j+shift]-r*c)%P
        trim(a)
    return a

def pgcd(a,b):
    while b!=[0]:a,b=b,prem(a,b)
    return [c*pow(a[-1],-1,P)%P for c in a]

def main():
    ap=argparse.ArgumentParser();ap.add_argument('--check',action='store_true');args=ap.parse_args()
    global P,NS
    records=[]
    expected={5:{'H2':(6,36,5),'H3':(6,12,-7)},7:{'H2':(11,61,10),'H3':(11,61,10)}}
    for P,NS in [(5,2),(7,3)]:
        assert pow(NS,(P-1)//2,P)==P-1
        elements=list(itertools.product(range(P),repeat=2))
        square_multiplicities={z:0 for z in elements}
        for z in elements:square_multiplicities[mul(z,z)]+=1
        assert all(square_multiplicities[z]==1+character(z) for z in elements)
        for name,t,u in [('H2',1,4),('H3',0,4)]:
            f=[P-1,(3*t-3)%P,3*t%P,1];g=[P-1,(3*u-3)%P,3*u%P,1]
            sextic=pmul(f,g);derivative=[i*sextic[i]%P for i in range(1,len(sextic))]
            assert pgcd(sextic,trim(derivative))==[1]
            base_values=[mul(cubic(t,(a,0)),cubic(u,(a,0)))[0] for a in range(P)]
            base_fibers=[sum(y*y%P==v for y in range(P)) for v in base_values]
            extension_fibers=[];extension_characters=[]
            for b in range(P):
                fr=[];ch=[]
                for a in range(P):
                    val=mul(cubic(t,(a,b)),cubic(u,(a,b)))
                    fr.append(square_multiplicities[val]);ch.append(character(val))
                extension_fibers.append(fr);extension_characters.append(ch)
            n1=sum(base_fibers)+2;n2=sum(map(sum,extension_fibers))+2
            s1=P+1-n1;s2=P*P+1-n2
            assert (s1*s1-s2)%2==0
            a2=(s1*s1-s2)//2
            assert (n1,n2,a2)==expected[P][name]
            records.append({'prime':P,'non_square':NS,'curve':name,'cubic_parameters':[t,u],
                'sextic_mod_p_low_to_high':sextic,'derivative_gcd':[1],
                'Fp_values':base_values,'Fp_affine_fiber_sizes':base_fibers,
                'Fp2_affine_fiber_sizes_by_b_then_a':extension_fibers,
                'Fp2_characters_by_b_then_a':extension_characters,
                'infinity_points_each_field':2,'N1':n1,'N2':n2,
                'frobenius_polynomial_high_to_low':[1,-s1,a2,-P*s1,P*P],
                'hypothetical_elliptic_trace_square':2*P-a2})
    result={'status':'PASS','fields':['F5[omega]/(omega^2-2)','F7[omega]/(omega^2-3)'],
       'field_elements_total':74,'field_square_fibers_checked':74,'curves':records,
       'scope':'Finite arithmetic and polynomial gcds only. Good reduction, Frobenius, Q-simplicity, torsion and rank parity/lower bounds are the separate ordinary proof; no rank API or all-rational-points computation.'}
    raw=(json.dumps(result,sort_keys=True,indent=2)+'\n').encode()
    output=Path(__file__).parent/'verification'/'rational_simple_quotients.json'
    output.parent.mkdir(exist_ok=True)
    if args.check:assert output.read_bytes()==raw,'canonical certificate mismatch'
    else:output.write_bytes(raw)
    print('PASS',len(records),'curves;',hashlib.sha256(raw).hexdigest())

if __name__=='__main__':main()
