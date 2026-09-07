"""Exact O/8 character and norm-thirteen trace diagnostic for the boundary curve."""
from argparse import ArgumentParser
from hashlib import sha256
from itertools import product
from json import dumps
from pathlib import Path


def mul(x,y,m=8):
    a,b=x;c,d=y
    return ((a*c-b*d)%m,(a*d+b*c+b*d)%m)


def power(x,n):
    z=(1,0)
    for _ in range(n):z=mul(z,x)
    return z


def run():
    generators=[(-1,1),(-1,2),(1,4),(-1,0)]
    orders=[3,4,2,2]
    for x,n in zip(generators,orders):
        assert power(x,n)==(1,0)
        assert all(power(x,j)!=(1,0) for j in range(1,n))
    character={};coordinates={}
    for exponents in product(*(range(n) for n in orders)):
        z=(1,0)
        for x,n in zip(generators,exponents):z=mul(z,power(x,n))
        assert z not in character
        character[z]=exponents[1]%4; coordinates[z]=exponents
    units={(a,b) for a in range(8) for b in range(8)
           if (a*a+a*b+b*b)%2}
    assert set(character)==units and len(units)==48
    for x in units:
        for y in units:
            assert character[mul(x,y)]==(character[x]+character[y])%4
    assert character[(0,1)]==0 and character[(7,0)]==0
    assert character[(5,0)]==2  # unit congruent to one mod four: conductor exactly eight
    rows=[]
    for pi in ((3,1),(4,-1)):
        a,b=pi; assert a*a+a*b+b*b==13
        roots=[r for r in range(13) if (r*r+3)%13==0
               and (a+b*((1+r)*7%13))%13==0]
        assert len(roots)==1; r=roots[0]
        coefficient=6*(3+r)%13
        points=1+sum((Y*Y-X**3-12*X*X-coefficient*X)%13==0
                     for X in range(13) for Y in range(13))
        trace=14-points
        phase=character[(a%8,b%8)]
        assert phase in (0,2)
        twisted_trace=trace*(1 if phase==0 else -1)
        rows.append({'norm13_generator':pi,'r_mod13':r,'points':points,
                     'trace':trace,'local_character_i_exponent':phase,
                     'inverse_character_twisted_trace':twisted_trace})
    return {'scope':'exact local character and trace; not an unconditional eigenform identification',
            'generator_orders':orders,'unit_count':len(units),
            'character_table':[[list(z),character[z],list(coordinates[z])] for z in sorted(units)],
            'norm13_primes':rows}


def main():
    parser=ArgumentParser();parser.add_argument('--check',action='store_true')
    args=parser.parse_args();data=run()
    raw=(dumps(data,sort_keys=True,indent=2)+'\n').encode('utf-8')
    path=Path(__file__).parent/'verification'/'boundary_character_results.json'
    if args.check:assert path.read_bytes()==raw
    else:path.parent.mkdir(exist_ok=True);path.write_bytes(raw)
    print(dumps({'status':'PASS','unit_count':48,'homomorphism_pairs':48**2,
                 'norm13_primes':data['norm13_primes'],'sha256':sha256(raw).hexdigest()}))


if __name__=='__main__':main()
