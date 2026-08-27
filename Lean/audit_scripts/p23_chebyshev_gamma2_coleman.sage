# Exact p=23 Coleman finish after Stoll-Gamma saturation.
# SageMath 10.9.  The finite-precision computation certifies the reductions
# of the exact Q_5 logarithms and an invertible lifting minor.

R.<x> = QQ[]
n = 23
T0=R(1); T1=x
for _ in range(2,n+1):
    T0,T1=T1,2*x*T1-T0
F=4*T1+5
f=F/2^(n+1)
fm=R(x^23-92*x^21+3680*x^19-83904*x^17+1201152*x^15
    -11210752*x^13+68583424*x^11-269434880*x^9+646643712*x^7
    -862191616*x^5+530579456*x^3-96468992*x+20971520)
assert fm(4*x) == 2^22*F
assert f(-1) == 1/2^24 and f(1) == 9/2^24

C=HyperellipticCurve(f)
g=C.genus(); p=5; k=GF(p)
assert g == 11 and f.is_irreducible()
assert f.discriminant().valuation(p) == 0
Ck=C.change_ring(k)
pts=Ck.points()
assert len(pts) == 6
assert len(f.change_ring(k).roots()) == 1
assert f.change_ring(k).roots()[0][0] == 0
assert sum(1 for P in pts if P[2] == 0) == 1
for z,mult in [(k(0),1),(k(1),2),(k(-1),2)]:
    assert sum(1 for P in pts if P[2] != 0 and P[0]/P[2] == z) == mult

K=Qp(p,70)
CK=C.change_ring(K)
O=CK(1,0,0)
Pm=CK(-1,QQ(1)/2^12,1)
Pp=CK(1,QQ(3)/2^12,1)
lm=vector(K,CK.coleman_integrals_on_basis(O,Pm)[:g])
lp=vector(K,CK.coleman_integrals_on_basis(O,Pp)[:g])
rows=[lm,lp]
contents=[min(z.valuation() for z in row if z != 0) for row in rows]
assert contents == [1,1]
L=matrix(K,[lm/5,lp/5])
M=matrix(k,[[k(z) for z in row] for row in L])
assert M.rank() == 2

# This reduction annihilates both endpoint logarithms and is nonzero at
# x=0, x=1, x=-1, and infinity.  The first two columns form a unit minor,
# so fixing columns 2..10 lifts it to one exact Q_5 differential.
cbar=vector(k,[1,0,0,0,0,0,0,0,0,0,3])
assert M*cbar == 0
def ev(c,z):
    return sum(c[j]*z^j for j in range(g))
evals=[ev(cbar,z) for z in [k(0),k(1),k(-1)]]+[cbar[g-1]]
assert all(z != 0 for z in evals)
for P in pts:
    if P[2] == 0:
        assert cbar[g-1] != 0
    else:
        assert ev(cbar,P[0]/P[2]) != 0
pair=(0,1)
B=L.matrix_from_columns(list(pair))
assert B.det().valuation() == 0
rest=[j for j in range(g) if j not in pair]
rhs=-vector(K,[sum(L[i,j]*K(ZZ(cbar[j])) for j in rest) for i in range(2)])
head=B.solve_right(rhs)
omega=vector(K,[head[list(pair).index(j)] if j in pair else K(ZZ(cbar[j]))
                for j in range(g)])
assert vector(k,omega) == cbar
dots=list(L*omega)
assert all(z == 0 for z in dots)
assert min(z.precision_absolute() for z in dots) >= 60

roots=f.roots(K)
assert len(roots) == 1 and k(roots[0][0]) == 0
print('GOOD_REDUCTION_POINTS',pts)
print('LOG_CONTENTS',contents)
print('NORMALIZED_LOG_REDUCTION'); print(M)
print('ANNIHILATOR_REDUCTION',cbar,'EVALS',evals,'UNIT_MINOR',pair)
print('DOTS',dots)
print('Q5_ROOTS',len(roots),'ROOT_REDUCTIONS',[k(z[0]) for z in roots])
print('P23_GAMMA2_COLEMAN_PASS')
