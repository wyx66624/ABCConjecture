# The prime-thirteen Chebyshev curve: complete rational points by Coleman--Chabauty

## 1. Theorem

Use the first-kind Chebyshev convention

\[
T_0(X)=1,\qquad T_1(X)=X,\qquad
T_{n+2}(X)=2X T_{n+1}(X)-T_n(X).
\]

Then

\[
T_{13}(X)=4096X^{13}-13312X^{11}+16640X^9-9984X^7
 +2912X^5-364X^3+13X.
\]

This note gives an accepted-computation proof of the following unconditional
classification.

**Theorem.** If \(T,y\in\mathbf Q\) and

\[
y^2=4T_{13}(T)+5,
\]

then

\[
(T,y)\in
\{(-1,1),(-1,-1),(1,3),(1,-3)\}.
\]

In particular, there is no rational, and hence no integral, solution with
\(T>1\).

No height cutoff, conjectural analytic rank, GRH, BSD, or `abc`-type
statement is used.  The non-Lean trust boundary is the documented exact
2-descent in Magma V2.29-9 and the documented Coleman integration
implementation in SageMath 10.9.  The residue-disc argument after the
reported modulo-5 data is proved explicitly below.

## 2. Three exactly related models

Put

\[
\begin{aligned}
F(T)={}&4T_{13}(T)+5\\
={}&16384T^{13}-53248T^{11}+66560T^9-39936T^7\\
&+11648T^5-1456T^3+52T+5.
\end{aligned}
\]

Magma uses the smaller-coefficient model obtained from \(X=-2T\):

\[
\begin{aligned}
C:\quad Y^2=q(X):={}&-2X^{13}+26X^{11}-130X^9+312X^7\\
&-364X^5+182X^3-26X+5.
\end{aligned}
\]

The transcript verifies \(F(-X/2)=q(X)\), and also verifies

\[
\operatorname{disc}(q)
=659293182044133484843008
=2^{12}3^{12}13^{13}.
\]

Thus \(C\) is a nonsingular genus-six curve.  It also verifies that \(q\)
is irreducible over \(\mathbf Q\).

For the 5-adic calculation use the isomorphic monic model

\[
H:\quad v^2=h(T):=\frac{F(T)}{128^2},
\qquad v=\frac y{128}.
\]

All coefficients of \(h\) are 5-integral, and Sage returns

\[
\operatorname{disc}(h)=
\frac{160960249522493526573}
{374144419156711147060143317175368453031918731001856}
=\frac{3^{12}13^{13}}{2^{168}}.
\]

This is a 5-adic unit.  Hence the displayed odd-degree integral model has
good reduction over \(\mathbf Z_5\).

Exact finite-field enumeration gives

\[
H(\mathbf F_5)=
\{\bar O,(0,0),(1,1),(1,4),(4,2),(4,3)\},
\]

where \(\bar O\) is the unique point at infinity.  The five visible rational
points on \(H\) are

\[
O,\quad(-1,\pm1/128),\quad(1,\pm3/128).
\]

They reduce to five of the six displayed points.  The only extra residue
disc is the one above the finite Weierstrass point \((0,0)\).

## 3. Exact 2-descent and the Mordell--Weil rank

Let \(J=\operatorname{Jac}(C)\simeq\operatorname{Jac}(H)\).  On the reduced
model define

\[
\begin{aligned}
u_1(X)&=X^6+X^5-5X^4-4X^3+6X^2+3X-1,\\
u_9(X)&=X^6-X^5-5X^4+4X^3+6X^2-3X-1.
\end{aligned}
\]

The exact identities

\[
q(X)-1=-2(X-2)u_1(X)^2,
\qquad
q(X)-9=-2(X+2)u_9(X)^2
\]

produce the Mumford divisors

\[
H_1=(u_1,-1),\qquad H_9=(u_9,-3).
\]

Magma verifies exactly that

\[
2H_1=[(2,1)-O]=:D_1,
\qquad
2H_9=[(-2,3)-O]=:D_9.
\]

It also computes \(J(\mathbf Q)[2]=0\).

For transparency, the monic change returned by Magma is

\[
Z=-2X,\qquad W=64Y,
\]

and the monic polynomial is

\[
\begin{aligned}
q_{\rm m}(Z)={}&Z^{13}-52Z^{11}+1040Z^9-9984Z^7\\
&+46592Z^5-93184Z^3+53248Z+20480.
\end{aligned}
\]

The two transformed Mumford polynomials are

\[
\begin{aligned}
U_1(Z)&=Z^6-2Z^5-20Z^4+32Z^3+96Z^2-96Z-64,\\
U_9(Z)&=Z^6+2Z^5-20Z^4-32Z^3+96Z^2+96Z-64.
\end{aligned}
\]

The exact call

```magma
PhiSelmerGroup(q,2 : ReturnRawData)
```

returns a 2-Selmer group

\[
S\simeq(\mathbf Z/2\mathbf Z)^2,
\qquad \#S=4.
\]

For \(q=2\), the Magma handbook specifies that `PhiSelmerGroup` reduces to
the ordinary 2-Selmer computation.  In the affine descent algebra, the exact
images of \(H_1\) and \(H_9\) are obtained by applying the returned descent
map to \(U_1(\theta)\) and \(U_9(\theta)\).  The transcript verifies that
both images lie in \(S\), that they are distinct and nonzero, and that they
generate a subgroup of order four.  Hence they generate all of \(S\).

The Kummer map gives an injection

\[
J(\mathbf Q)/2J(\mathbf Q)\hookrightarrow S.
\]

Since \(J(\mathbf Q)[2]=0\), the Selmer computation gives
\(\operatorname{rank}J(\mathbf Q)\leq2\).  The independent images of
\(H_1,H_9\) give the reverse inequality.  Thus

\[
\operatorname{rank}J(\mathbf Q)=2.
\]

More precisely, \(\langle H_1,H_9\rangle\) maps onto
\(J(\mathbf Q)/2J(\mathbf Q)\).  Its finite index in \(J(\mathbf Q)\) is
therefore odd.  This is stronger than the finite-index statement needed
below and does not use finiteness of a Tate--Shafarevich group.

Under \(X=-2T\), the classes \(D_1,D_9\) correspond respectively to

\[
D_-=[(-1,1/128)-O],\qquad
D_+=[(1,3/128)-O]
\]

on \(H\).  Since \(D_-=2H_1\) and \(D_+=2H_9\), their 5-adic logarithms
span the full Mordell--Weil logarithm space over \(\mathbf Q_5\).

## 4. A nonvanishing annihilating differential

Use the holomorphic basis

\[
\omega_i=T^i\frac{dT}{2v},\qquad 0\leq i\leq5.
\]

Sage computes the Coleman logarithm vectors \(\ell_-\) and \(\ell_+\) of
\(D_-\) and \(D_+\).  Their coordinatewise valuations are

\[
(1,1,1,1,1,1),\qquad(1,2,1,3,1,1).
\]

The right kernel of the \(2\times6\) logarithm matrix has four rows.  After
primitive normalization and reduction modulo 5, Sage certifies the basis

\[
\begin{aligned}
&(1,0,0,0,4,4),\\
&(0,1,0,0,2,1),\\
&(0,0,1,0,0,4),\\
&(0,0,0,1,3,4).
\end{aligned}
\]

In particular, there is an integral annihilating differential whose reduced
coefficient vector is

\[
\bar c=(1,0,0,0,4,4).
\]

Choose a primitive 5-adic lift \(c=(c_0,\ldots,c_5)\) in the computed exact
kernel and put

\[
\omega=(c_0+c_1T+\cdots+c_5T^5)\frac{dT}{2v},
\qquad
\lambda(P)=\int_O^P\omega.
\]

Because the logarithms of \(D_-\) and \(D_+\) span the Mordell--Weil
logarithm space, \(\omega\) annihilates all of \(J(\mathbf Q)\).  Therefore

\[
\lambda(P)=0\qquad(P\in H(\mathbf Q)).
\]

The numerator of the reduced differential has values

\[
\begin{array}{c|ccc}
T&0&1&4\\ \hline
1+4T^4+4T^5&1&4&1.
\end{array}
\]

At infinity its value is nonzero because the leading coefficient is
\(\bar c_5=4\).  At the Weierstrass point, take \(v\) as local parameter.
Since

\[
2v\,dv=h'(T)\,dT,
\qquad h'(0)\equiv3\pmod5,
\]

the local coefficient is again a unit.  Thus the reduction of \(\omega\)
does not vanish at any of the six points of \(H(\mathbf F_5)\).

## 5. A local one-zero lemma at 5

The usual global Coleman bound is sometimes quoted under a condition such
as \(p>2g\).  That condition is unnecessary here because the chosen
differential is nonvanishing in every residue disc.

**Lemma.** Let \({\cal D}\) be a residue disc of a smooth curve over
\(\mathbf Z_5\).  If a regular differential \(\eta\) has nonzero reduction
at the point below \({\cal D}\), then a Coleman primitive of \(\eta\) has at
most one zero in \({\cal D}\).

**Proof.** Translate an integral local parameter so that one zero has
parameter \(t=0\).  A second point in the same disc has
\(t\in5\mathbf Z_5\); if it is distinct, let \(m=v_5(t)\geq1\).  Write

\[
\eta=(a_0+a_1t+a_2t^2+\cdots)dt,
\qquad a_0\in\mathbf Z_5^\times.
\]

The difference of primitive values is

\[
a_0t+\frac{a_1}{2}t^2+\frac{a_2}{3}t^3+\cdots.
\]

The first term has valuation \(m\).  Every term of degree \(n\geq2\) has
valuation at least

\[
nm-v_5(n)>m,
\]

because \((n-1)m>v_5(n)\).  The first term cannot cancel, so two distinct
zeros are impossible. \(\square\)

Applying the lemma to \(\omega\), every residue disc of \(H(\mathbf Q_5)\)
contains at most one zero of \(\lambda\).

## 6. Six local zeros and all rational points

There is already one zero in each of the six residue discs.

* The point \(O\) is a zero by the choice of base point.
* The four rational affine points \((-1,\pm1/128)\) and
  \((1,\pm3/128)\) are zeros because \(\omega\) annihilates
  \(J(\mathbf Q)\).  They occupy the four discs above \(T=4\) and \(T=1\).
* Modulo 5, \(h\) has the single simple root 0.  Hensel's lemma gives a
  unique \(\alpha\in\mathbf Z_5\) with \(h(\alpha)=0\) and
  \(\alpha\equiv0\pmod5\).  Put \(W=(\alpha,0)\).  Since

  \[
  \operatorname{div}(T-\alpha)=2W-2O,
  \]

  the class \([W-O]\) is 2-torsion.  The 5-adic abelian logarithm kills
  torsion, hence \(\lambda(W)=0\).  Sage independently returns all six
  basis integrals from \(O\) to \(W\) as exactly zero at the available
  precision, with valuation `+Infinity`.

The local lemma now proves that these are the only six 5-adic zeros, one in
each disc.  Every rational point is a zero, so

\[
H(\mathbf Q)\subseteq
\{O,(-1,\pm1/128),(1,\pm3/128),W\}.
\]

The point \(W\) is not rational.  Indeed, Magma verifies that \(q\) is
irreducible over \(\mathbf Q\); the rational changes relating \(q,F,h\)
preserve irreducibility, so \(h\) has no rational root.  Consequently

\[
H(\mathbf Q)=\{O,(-1,\pm1/128),(1,\pm3/128)\}.
\]

Returning via \(y=128v\) proves the theorem in Section 1.

## 7. Reproducible Magma V2.29-9 transcript

The following input was run twice successfully in fresh sessions on the
official Magma calculator.  It invokes neither `SetClassGroupBounds` nor any
GRH option and uses no point-search or height bound.

```magma
SetSeed(1);
Q:=Rationals(); Qx<X>:=PolynomialRing(Q);
T0:=Qx!1; T1:=X;
for n in [2..13] do
  T2:=2*X*T1-T0; T0:=T1; T1:=T2;
end for;
F13:=4*T1+5;
f:=-2*X^13+26*X^11-130*X^9+312*X^7-364*X^5+182*X^3-26*X+5;
assert Evaluate(F13,-X/2) eq f;
C:=HyperellipticCurve(f); J:=Jacobian(C);
u1:=X^6+X^5-5*X^4-4*X^3+6*X^2+3*X-1;
u9:=X^6-X^5-5*X^4+4*X^3+6*X^2-3*X-1;
assert f-1 eq -2*(X-2)*u1^2;
assert f-9 eq -2*(X+2)*u9^2;
H1:=J![u1,-1]; H9:=J![u9,-3];
D1:=J![X-2,1]; D9:=J![X+2,3];
assert 2*H1 eq D1; assert 2*H9 eq D9;
T2grp,t2map:=TwoTorsionSubgroup(J);
assert #T2grp eq 1;
fm,chg:=MonicModel(f,2);
U1:=(-2)^6*Evaluate(u1,-X/2);
U9:=(-2)^6*Evaluate(u9,-X/2);
time S,m,expvecs,fb,SelPic1:=PhiSelmerGroup(f,2 : ReturnRawData);
A<theta>:=Domain(m); G:=Codomain(m);
z:=G!0;
e1:=m(Evaluate(U1,theta)); e9:=m(Evaluate(U9,theta));
assert #S eq 4; assert Invariants(S) eq [2,2];
assert e1 in S and e9 in S;
assert e1 ne z and e9 ne z and e1 ne e9;
assert #sub<G|e1,e9> eq 4;
printf "TRANSFORM_OK=%o\nGENUS=%o NS=%o DISC=%o IRR=%o\n",
  Evaluate(F13,-X/2) eq f,Genus(C),IsNonsingular(C),
  Discriminant(f),IsIrreducible(f);
printf "HALVES=%o,%o\nTWO_TORSION_SIZE=%o\n",
  2*H1 eq D1,2*H9 eq D9,#T2grp;
printf "MONIC=%o\nCHANGE=%o\nU1=%o\nU9=%o\n",fm,chg,U1,U9;
printf "SELMER=%o\nSIZE=%o INVARIANTS=%o\nSELPIC1=%o\n",
  S,#S,Invariants(S),SelPic1;
printf "IMAGE1=%o MEMBER1=%o\nIMAGE9=%o MEMBER9=%o\nSPAN_SIZE=%o\n",
  e1,e1 in S,e9,e9 in S,#sub<G|e1,e9>;
```

Exact output from the second official run (55.020 seconds, 32.09 MB; group
presentation whitespace is non-semantic):

```text
Time: 54.970
TRANSFORM_OK=true
GENUS=6 NS=true DISC=659293182044133484843008 IRR=true
HALVES=true,true
TWO_TORSION_SIZE=1
MONIC=X^13 - 52*X^11 + 1040*X^9 - 9984*X^7 + 46592*X^5
    - 93184*X^3 + 53248*X + 20480
CHANGE=[ -2*X, 64*X ]
U1=X^6 - 2*X^5 - 20*X^4 + 32*X^3 + 96*X^2 - 96*X - 64
U9=X^6 + 2*X^5 - 20*X^4 - 32*X^3 + 96*X^2 + 96*X - 64
SELMER=Abelian Group isomorphic to Z/2 + Z/2
Defined on 2 generators in supergroup G:
    S.1 = G.1
    S.2 = G.3 + G.4 + G.7 + G.11 + G.12 + G.13 + G.14
Relations:
    2*S.1 = 0
    2*S.2 = 0
SIZE=4 INVARIANTS=[ 2, 2 ]
SELPIC1=0
IMAGE1=G.1 MEMBER1=true
IMAGE9=G.3 + G.4 + G.7 + G.11 + G.12 + G.13 + G.14 MEMBER9=true
SPAN_SIZE=4
```

The first successful independent run returned `Time: 54.850`; all exact
mathematical output was identical.

## 8. Reproducible SageMath 10.9 transcript

This is the complete Sage input used for the Coleman calculation.  Only the
first six entries returned by `coleman_integrals_on_basis` are used because
they form the holomorphic basis \(T^i dT/(2v)\), \(0\leq i\leq5\).

```sage
from itertools import product
from sage.version import version as sage_version

print("SAGE", sage_version)
R.<x> = QQ[]
p_index = 13
T0 = R(1)
T1 = x
for _ in range(2, p_index + 1):
    T0, T1 = T1, 2*x*T1 - T0
F = 4*T1 + 5
scale = QQ(2)^((p_index + 1)//2)
f = F / scale^2
H = HyperellipticCurve(f)
p = 5
k = GF(p)
Hk = H.change_ring(k)
g = H.genus()
print("GENUS", g, "DISC", f.discriminant())
print("F5COUNT", len(Hk.points()), "F5POINTS", Hk.points())
print("F5ROOTS", f.change_ring(k).roots())

K = Qp(p, 40)
HK = H.change_ring(K)
O = HK(1, 0, 0)
Pm = HK(-1, QQ(1)/scale, 1)
Pp = HK(1, QQ(3)/scale, 1)
lm = vector(K, HK.coleman_integrals_on_basis(O, Pm)[:g])
lp = vector(K, HK.coleman_integrals_on_basis(O, Pp)[:g])
print("LOGVALS", [z.valuation() for z in lm],
      [z.valuation() for z in lp])

M = matrix(K, [lm, lp])
KB = M.right_kernel_matrix()
print("KERNEL_ROWS", KB.nrows(), "KERNEL_COLS", KB.ncols())

primitive_rows = []
for row in KB.rows():
    v = min(z.valuation() for z in row if z != 0)
    primitive_rows.append(vector(K, [z / p^v for z in row]))

red_rows = []
for row in primitive_rows:
    red_rows.append(vector(k, [k(z) if z.valuation() >= 0 else k(0)
                               for z in row]))
W = span(red_rows, k)
print("REDUCED_KERNEL_DIM", W.dimension())
print("REDUCED_KERNEL_BASIS", list(W.basis()))

chosen = None
for coeffs in product(*([list(k)] * W.dimension())):
    if all(a == 0 for a in coeffs):
        continue
    c = sum((coeffs[i] * W.basis()[i]
             for i in range(W.dimension())), vector(k, g))
    vals = [sum(c[j] * a^j for j in range(g)) for a in [0, 1, 4]]
    if all(z != 0 for z in vals) and c[g-1] != 0:
        chosen = c
        print("CHOSEN", c, "FINITEVALUES", vals,
              "INFINITYVALUE", c[g-1])
        break
print("FOUND", chosen is not None)

roots = f.roots(K)
alpha = [a for a, e in roots if a.valuation() >= 1][0]
Wpt = HK(alpha, 0, 1)
iw = vector(K, HK.coleman_integrals_on_basis(O, Wpt)[:g])
print("Q5ROOT_REDUCTION", k(alpha), "ROOT_COUNT", len(roots))
print("IWVALS", [z.valuation() for z in iw])
```

Exact output from a fresh SageMath 10.9 run:

```text
SAGE 10.9
GENUS 6 DISC 160960249522493526573/374144419156711147060143317175368453031918731001856
F5COUNT 6 F5POINTS [(1 : 0 : 0), (0 : 0 : 1), (1 : 1 : 1),
 (1 : 4 : 1), (4 : 2 : 1), (4 : 3 : 1)]
F5ROOTS [(0, 1)]
LOGVALS [1, 1, 1, 1, 1, 1] [1, 2, 1, 3, 1, 1]
KERNEL_ROWS 4 KERNEL_COLS 6
REDUCED_KERNEL_DIM 4
REDUCED_KERNEL_BASIS [(1, 0, 0, 0, 4, 4), (0, 1, 0, 0, 2, 1),
 (0, 0, 1, 0, 0, 4), (0, 0, 0, 1, 3, 4)]
CHOSEN (1, 0, 0, 0, 4, 4) FINITEVALUES [1, 4, 1] INFINITYVALUE 4
FOUND True
Q5ROOT_REDUCTION 0 ROOT_COUNT 1
IWVALS [+Infinity, +Infinity, +Infinity, +Infinity, +Infinity, +Infinity]
```

The calculation was independently rerun to exit code zero.  The temporary
source used for that rerun is `tmp/p13_coleman.sage`; it is not part of the
certificate deliverable.

## 9. Lean boundary

The companion file is

`IUTThreeClosures/FreyPellChebyshevIndexThirteenColemanChabautyCertificate.lean`.

It defines the transparent proposition

```lean
def MagmaSageRationalXCertificateIndexThirteen : Prop :=
  ∀ X Y : ℚ,
    Y ^ 2 =
        16384 * X ^ 13 - 53248 * X ^ 11 + 66560 * X ^ 9 -
          39936 * X ^ 7 + 11648 * X ^ 5 - 1456 * X ^ 3 +
            52 * X + 5 →
      X = -1 ∨ X = 1
```

and accepts a proof of this proposition as an explicit hypothesis.  Lean
then checks the thirteenth Chebyshev formula, the scalar polynomial model,
the full affine rational-point values once the `X`-classification is
supplied, the integral specialization, and the exclusion at \(T>1\).  It
does not claim to reimplement Magma's descent or Sage's Coleman integration
in the kernel.

## 10. References and trust boundary

* Magma Handbook, [the phi-Selmer computation for superelliptic
  Jacobians](https://magma.maths.usyd.edu.au/magma/handbook/text/1621).
  The handbook states that for \(q=2\) this reduces to the 2-Selmer group and
  that the Selmer group contains the Kummer image.
* SageMath Reference Manual, [hyperelliptic curves over a p-adic
  field](https://doc.sagemath.org/html/en/reference/arithmetic_curves/sage/schemes/hyperelliptic_curves/hyperelliptic_padic_field.html),
  documenting `coleman_integrals_on_basis`.
* J. S. Balakrishnan, R. W. Bradshaw, and K. S. Kedlaya,
  [*Explicit Coleman integration for hyperelliptic curves*](https://arxiv.org/abs/1004.4936),
  ANTS IX, LNCS 6197 (2010), 16--31.
* R. F. Coleman,
  [*Torsion points on curves and p-adic Abelian integrals*](https://annals.math.princeton.edu/1985/121-1/p03),
  Annals of Mathematics 121 (1985), 111--168.

The completeness claim uses the exact Magma 2-Selmer computation, the exact
Mumford descent images, the certified Sage modulo-5 Coleman data, and the
explicit local lemma.  It does not use bounded point search, a database
assertion, or an unproved conjecture.
