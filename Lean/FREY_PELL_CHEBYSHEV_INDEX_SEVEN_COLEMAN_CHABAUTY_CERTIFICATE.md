# The prime-seven Chebyshev curve: complete rational points by Coleman--Chabauty

## 1. Theorem

Use the first-kind Chebyshev convention

\[
T_0(X)=1,\qquad T_1(X)=X,\qquad
T_{n+2}(X)=2X T_{n+1}(X)-T_n(X).
\]

Then

\[
T_7(X)=64X^7-112X^5+56X^3-7X.
\]

This note gives an accepted-computation proof of the following unconditional
classification.

**Theorem.**  If \(T,y\in\mathbf Q\) and

\[
y^2=4T_7(T)+5,
\]

then

\[
(T,y)\in
\{(-1,1),(-1,-1),(1,3),(1,-3)\}.
\]

In particular, there is no rational, and hence no integral, solution with
\(T>1\).

No height cutoff, conjectural analytic rank, GRH, BSD, or `abc`-type
statement is used.  The non-Lean trust boundary is the documented
exact-arithmetic 2-descent in Magma V2.29-9 and the documented Coleman
integration implementation in SageMath 10.9.  The residue-disc argument after
the reported modulo-5 data is proved explicitly below.

## 2. The genus-three curve and a good integral model at 5

Put

\[
F(X)=256X^7-448X^5+224X^3-28X+5.
\]

The original equation is \(y^2=F(T)\).  Magma verifies

\[
\operatorname{disc}(F)
=-168987118377268131397632
=-2^{48}3^6 7^7,
\]

so the odd-degree hyperelliptic curve

\[
C:\quad y^2=F(X)
\]

is nonsingular of genus 3.  For the 5-adic calculation use the isomorphic
monic model

\[
H:\quad v^2=f(X):=\frac{F(X)}{256}
=X^7-\frac74X^5+\frac78X^3-\frac7{64}X+\frac5{256},
\qquad v=\frac y{16}.
\]

All coefficients of \(f\) are 5-integral and

\[
\operatorname{disc}(f)
=-\frac{600362847}{281474976710656}
=-\frac{3^6 7^7}{2^{48}}
\]

is a 5-adic unit.  Thus this is a smooth integral odd-degree model over
\(\mathbf Z_5\), and its proper smooth model has good reduction.

Exact enumeration over the finite field gives

\[
H(\mathbf F_5)=
\{\bar O,(0,0),(1,2),(1,3),(4,1),(4,4)\},
\]

where \(\bar O\) is the unique point at infinity.  This is an enumeration of
a finite set, not a bounded rational-point search.

The five already visible rational points on \(H\) are

\[
O,\quad (-1,\pm1/16),\quad (1,\pm3/16).
\]

They reduce to five of the six displayed points.  The only extra residue disc
is the one above the finite Weierstrass point \((0,0)\).

## 3. Mordell--Weil rank and two independent divisors

Let \(J=\operatorname{Jac}(C)\simeq\operatorname{Jac}(H)\), and write

\[
D_-=[(-1,1)-O],\qquad D_+=[(1,3)-O]
\]

on the original model.  Magma's unconditional call `RankBounds(J)` returns

\[
0\leq \operatorname{rank}J(\mathbf Q)\leq2.
\]

The same upper bound follows directly from the exact transcript without any
parity assertion about a Tate--Shafarevich group.  `TwoSelmerGroup(J)`
returns \((\mathbf Z/2\mathbf Z)^2\), and the documented descent gives an
injection

\[
J(\mathbf Q)/2J(\mathbf Q)\hookrightarrow
  \operatorname{Sel}^{(2)}(J/\mathbf Q).
\]

Because the odd-degree polynomial \(F\) is irreducible, its Galois group is
transitive on the seven roots, so \(J(\mathbf Q)[2]=0\).  It follows directly
that \(\operatorname{rank}J(\mathbf Q)\leq2\).  This argument is unconditional
and does not use finiteness of \(\Sha\).

The Sage transcript in Section 8 computes the 5-adic logarithm vectors of
\(D_-\) and \(D_+\) in the holomorphic basis

\[
\omega_i=X^i\frac{dX}{2v},\qquad i=0,1,2.
\]

Their coordinatewise valuations are respectively

\[
(1,1,1),\qquad(2,1,1).
\]

The cross product has valuation 2.  After division by \(5^2\), its reduction
is

\[
\bar c=(2,4,3)\in\mathbf F_5^3,
\]

which is nonzero.  Hence the two logarithm vectors are linearly independent
over \(\mathbf Q_5\).  An integral relation between \(D_-\) and \(D_+\)
would give the same relation between these logarithms, so the divisors are
independent.  The rank is therefore exactly 2, and

\[
L=\langle D_-,D_+\rangle
\]

has finite index in \(J(\mathbf Q)\).

This finite-index conclusion is all that Chabauty needs.  In particular, no
claim that \(L\) is saturated is required.  If \(Q\in J(\mathbf Q)\), choose
any nonzero integer \(m\) with \(mQ\in L\).  Since \(\mathbf Q_5\) is a
field, even when \(5\mid m\),

\[
\log(Q)=\frac1m\log(mQ).
\]

Thus every differential annihilating the logarithms of \(D_-\) and \(D_+\)
annihilates all of \(J(\mathbf Q)\).

### Exact divisor and 2-descent cross-check

The proof above obtains independence directly from the certified nonzero
minor of the 5-adic logarithm matrix.  Magma also supplies the following
independent exact-arithmetic audit.

Define the Mumford divisors

\[
\begin{aligned}
H_+&=\left(X^3+\frac12X^2-\frac12X-\frac18,-3\right),\\
H_-&=\left(X^3-\frac12X^2-\frac12X+\frac18,-1\right).
\end{aligned}
\]

Magma verifies exactly that

\[
2H_+=D_+,
\qquad
2H_-=D_-.
\]

It also returns a 2-Selmer group isomorphic to
\((\mathbf Z/2\mathbf Z)^2\).  Under the monic change

\[
X_{\rm m}=256X,
\qquad y_{\rm m}=2^{24}y,
\]

the two Mumford polynomials become

\[
\begin{aligned}
U_+(X_{\rm m})&=X_{\rm m}^3+128X_{\rm m}^2
-32768X_{\rm m}-2097152,\\
U_-(X_{\rm m})&=X_{\rm m}^3-128X_{\rm m}^2
-32768X_{\rm m}+2097152.
\end{aligned}
\]

The three exact `IsSquare` tests in Section 7 match their standard Mumford
2-descent squareclasses with the two reported Selmer generators and their
sum.  This audit is recorded for reproducibility; the Coleman proof does not
use a saturation conclusion extracted from it.

## 4. The annihilating differential

Let \(\ell_-\) and \(\ell_+\) be the two exact Coleman logarithm vectors and
let

\[
c=(c_0,c_1,c_2)=5^{-2}(\ell_-\times\ell_+).
\]

The transcript certifies that \(c_i\in\mathbf Z_5^\times\) and

\[
(c_0,c_1,c_2)\equiv(2,4,3)\pmod5.
\]

Set

\[
\omega=(c_0+c_1X+c_2X^2)\frac{dX}{2v}
\]

and, with base point \(O\),

\[
\lambda(P)=\int_O^P\omega.
\]

By construction, \(\omega\) annihilates \(D_-\) and \(D_+\).  Section 3
therefore implies

\[
\lambda(P)=0\qquad(P\in H(\mathbf Q)).
\]

The numerator of the reduction of \(\omega\) has values

\[
\begin{array}{c|ccc}
X&0&1&4\\ \hline
\bar c_0+\bar c_1X+\bar c_2X^2&2&4&1.
\end{array}
\]

At infinity the value of the regular differential is nonzero because its
leading coefficient is \(\bar c_2=3\).  Consequently the reduction of
\(\omega\) does not vanish at any of the six points of \(H(\mathbf F_5)\).

For completeness, at the Weierstrass point one may take \(v\) as a local
parameter.  Since

\[
2v\,dv=f'(X)\,dX
\]

and \(f'(0)\equiv2\pmod5\), the local coefficient of \(\omega\) there is a
unit as well.

## 5. A local one-zero lemma valid at p=5

The frequently quoted global Coleman estimate is sometimes stated with a
hypothesis such as \(p>2g\).  That hypothesis is unnecessary here because
the differential is nonvanishing in every residue disc.  We use the following
elementary local statement.

**Lemma.**  Let \({\cal D}\) be a residue disc of a smooth curve over
\(\mathbf Z_5\).  Suppose a regular differential \(\eta\) has nonzero
reduction at the point below \({\cal D}\).  Then a Coleman primitive of
\(\eta\) has at most one zero in \({\cal D}\).

**Proof.**  Take any two points in the disc and translate an integral local
parameter so that the first has \(t=0\).  The second then has
\(t\in5\mathbf Z_5\); if the points are distinct, put \(m=v_5(t)\geq1\).
Nonvanishing of the reduced differential says that, after this translation,
we may write

\[
\eta=(a_0+a_1t+a_2t^2+\cdots)dt,
\qquad a_0\in\mathbf Z_5^\times.
\]

The difference of primitive values is

\[
a_0t+\frac{a_1}{2}t^2+\frac{a_2}{3}t^3+\cdots.
\]

The first term has valuation \(m\).  For every \(n\geq2\), the term of
degree \(n\) has valuation at least

\[
nm-v_5(n)>m,
\]

because \((n-1)m>v_5(n)\).  Hence the first term cannot cancel unless
\(t=0\).  Two distinct zeros are impossible.  \(\square\)

Applying the lemma to \(\omega\), every residue disc of \(H(\mathbf Q_5)\)
contains at most one zero of \(\lambda\).

## 6. The six local zeros and the rational-point classification

There is already a zero in each of the six residue discs.

* The point \(O\) is a zero by the choice of base point.
* The points \((-1,1/16)\) and \((1,3/16)\) are zeros by the construction of
  the cross-product differential.
* Their hyperelliptic conjugates are zeros because
  \([\iota(P)-O]=-[P-O]\) in the Jacobian.
* Modulo 5, the polynomial \(f\) has the single simple root 0.  Hensel's
  lemma gives a unique root \(\alpha\in\mathbf Z_5\) with
  \(\alpha\equiv0\pmod5\).  Put \(W=(\alpha,0)\).  Since

  \[
  \operatorname{div}(X-\alpha)=2W-2O,
  \]

  the class \([W-O]\) is 2-torsion.  The 5-adic abelian logarithm kills
  torsion, so \(\lambda(W)=0\).  Sage independently returns the entire
  holomorphic vector \(\int_O^W(\omega_0,\omega_1,\omega_2)\) as zero.

The local lemma now says that these are the only six 5-adic zeros, one per
disc.  Every rational point is a zero, so

\[
H(\mathbf Q)\subseteq
\{O,(-1,\pm1/16),(1,\pm3/16),W\}.
\]

The point \(W\) is not rational: Magma verifies `IsIrreducible(F)=true` and
`Roots(F)=[]`.  In particular, \(F\), and hence \(f\), has no rational root.
Therefore

\[
H(\mathbf Q)=\{O,(-1,\pm1/16),(1,\pm3/16)\}.
\]

Returning via \(y=16v\) proves the theorem in Section 1.

## 7. Reproducible Magma V2.29-9 transcript

The following input was run in a fresh session on the official Magma
calculator.  It invokes neither `SetClassGroupBounds` nor any GRH option, and
uses no non-rigorous class-group bound or point-search bound.

```magma
SetSeed(1);
Q:=Rationals(); Qx<x>:=PolynomialRing(Q);
F:=256*x^7-448*x^5+224*x^3-28*x+5;
C:=HyperellipticCurve(F); J:=Jacobian(C);
printf "GENUS=%o NS=%o DISC=%o IRR=%o ROOTS=%o\n",
  Genus(C),IsNonsingular(C),Discriminant(F),IsIrreducible(F),Roots(F);
printf "IDM=%o IDP=%o\n",
  F-1 eq 4*(x+1)*(8*x^3-4*x^2-4*x+1)^2,
  F-9 eq 4*(x-1)*(8*x^3+4*x^2-4*x-1)^2;
up:=x^3+1/2*x^2-1/2*x-1/8;
um:=x^3-1/2*x^2-1/2*x+1/8;
Hp:=J![up,-3]; Hm:=J![um,-1];
Dp:=J![x-1,3]; Dm:=J![x+1,1];
printf "DOUBLEP=%o EQP=%o\nDOUBLEM=%o EQM=%o\n",
  2*Hp,2*Hp eq Dp,2*Hm,2*Hm eq Dm;
fm,chg:=MonicModel(F,2);
Up:=x^3+128*x^2-32768*x-2097152;
Um:=x^3-128*x^2-32768*x+2097152;
printf "MONIC=%o\nCHANGE=%o\nUPCHANGE=%o UMCHANGE=%o\n",
  fm,chg,256^3*Evaluate(up,x/256) eq Up,
  256^3*Evaluate(um,x/256) eq Um;
lo,hi:=RankBounds(J);
S,m:=TwoSelmerGroup(J); A<theta>:=Codomain(m);
printf "RANKBOUNDS=%o,%o\nSELMER=%o SIZE=%o\nTHETAPOLY=%o\n",
  lo,hi,S,#S,MinimalPolynomial(theta);
ok1,r1:=IsSquare((-Evaluate(Up,theta))/m(S.1));
ok2,r2:=IsSquare((-Evaluate(Um,theta))/m(S.2));
ok3,r3:=IsSquare(Evaluate(Up,theta)*Evaluate(Um,theta)/m(S.1+S.2));
printf "MATCH1=%o ROOT=%o\nMATCH2=%o ROOT=%o\nMATCH3=%o ROOT=%o\n",
  ok1,r1,ok2,r2,ok3,r3;
```

Exact output (3.330 seconds, 32.09 MB; group presentation whitespace is
non-semantic):

```text
GENUS=3 NS=true DISC=-168987118377268131397632 IRR=true ROOTS=[]
IDM=true IDP=true
DOUBLEP=(x - 1, 3, 1) EQP=true
DOUBLEM=(x + 1, 1, 1) EQM=true
MONIC=x^7 - 114688*x^5 + 3758096384*x^3 - 30786325577728*x
    + 1407374883553280
CHANGE=[ 256*x, 16777216*x ]
UPCHANGE=true UMCHANGE=true
RANKBOUNDS=0,2
SELMER=Abelian Group isomorphic to Z/2 + Z/2
Defined on 2 generators in supergroup:
    S.1 = $.5 + $.8
    S.2 = $.3
Relations:
    2*S.1 = 0
    2*S.2 = 0
SIZE=4
THETAPOLY=x^7 - 114688*x^5 + 3758096384*x^3 - 30786325577728*x
    + 1407374883553280
MATCH1=true ROOT=1/50331648*theta^5 - 5/3072*theta^3
    + 1/12*theta^2 + 80/3*theta - 8192/3
MATCH2=true ROOT=1/50331648*theta^5 - 1/393216*theta^4
    - 1/768*theta^3 + 1/8*theta^2 + 80/3*theta - 2048
MATCH3=true ROOT=1/192*theta^4 + 1/3*theta^3 - 1024/3*theta^2
    - 16384*theta + 8388608/3
```

The two factor identities printed as `IDM` and `IDP` are

\[
\begin{aligned}
F(X)-1&=4(X+1)(8X^3-4X^2-4X+1)^2,\\
F(X)-9&=4(X-1)(8X^3+4X^2-4X-1)^2.
\end{aligned}
\]

They explain the unusually small half-divisors but are not used as a global
rational-point shortcut.

## 8. Reproducible SageMath 10.9 transcript

This is the complete Sage input used for the Coleman calculation.  Only the
first three entries returned by `coleman_integrals_on_basis` are used because
they are the holomorphic basis \(X^i dX/(2v)\), \(0\leq i\leq2\).

```sage
from sage.version import version as sage_version
print("SAGE",sage_version)
R.<x>=QQ[]
F=256*x^7-448*x^5+224*x^3-28*x+5; f=F/256
H=HyperellipticCurve(f); p=5; k=GF(p); Hk=H.change_ring(k)
print("GENUS",H.genus(),"DISC",f.discriminant())
print("F5COUNT",len(Hk.points()),"F5POINTS",Hk.points())
print("F5ROOTS",f.change_ring(k).roots())
K=Qp(p,30); HK=H.change_ring(K)
O=HK(1,0,0); Pm=HK(-1,QQ(1)/16,1); Pp=HK(1,QQ(3)/16,1)
lm=vector(K,HK.coleman_integrals_on_basis(O,Pm)[:3])
lp=vector(K,HK.coleman_integrals_on_basis(O,Pp)[:3])
cross=vector(K,[lm[1]*lp[2]-lm[2]*lp[1],
                lm[2]*lp[0]-lm[0]*lp[2],
                lm[0]*lp[1]-lm[1]*lp[0]])
vc=min(z.valuation() for z in cross); c=cross/p^vc
print("LOGVALS",[z.valuation() for z in lm],
                [z.valuation() for z in lp])
print("CROSSVAL",vc,"CVALS",[z.valuation() for z in c],
      "CMOD5",[k(z) for z in c])
print("ANNVAL",c.dot_product(lm).valuation(),
      c.dot_product(lp).valuation())
print("FINITEVALUES",[(a,k(c[0]+c[1]*a+c[2]*a^2))
                      for a in [0,1,4]])
print("INFINITYVALUE",k(c[2]))
roots=f.roots(K); alpha=[a for a,e in roots if a.valuation()>=1][0]
W=HK(alpha,0,1)
iw=vector(K,HK.coleman_integrals_on_basis(O,W)[:3])
print("Q5ROOT_REDUCTION",k(alpha),"MULT",[(k(a),e) for a,e in roots])
print("IW",iw,"IWVALS",[z.valuation() for z in iw])
```

Exact output, reproduced in two independent runs:

```text
SAGE 10.9
GENUS 3 DISC -600362847/281474976710656
F5COUNT 6 F5POINTS [(1 : 0 : 0), (0 : 0 : 1), (1 : 2 : 1),
 (1 : 3 : 1), (4 : 1 : 1), (4 : 4 : 1)]
F5ROOTS [(0, 1)]
LOGVALS [1, 1, 1] [2, 1, 1]
CROSSVAL 2 CVALS [0, 0, 0] CMOD5 [2, 4, 3]
ANNVAL 29 29
FINITEVALUES [(0, 2), (1, 4), (4, 1)]
INFINITYVALUE 3
Q5ROOT_REDUCTION 0 MULT [(0, 1)]
IW (0, 0, 0) IWVALS [+Infinity, +Infinity, +Infinity]
```

`ANNVAL 29 29` means that the two dot products vanish to the full available
precision after normalization.  Exact orthogonality is built into the cross
product; the computation needed by the proof is the certified primitive
residue `(2,4,3)` and its nonzero evaluations.

## 9. Lean boundary

The companion file is

`IUTThreeClosures/FreyPellChebyshevIndexSevenColemanChabautyCertificate.lean`.

It defines the transparent proposition

```lean
def MagmaSageRationalXCertificateIndexSeven : Prop :=
  ∀ X Y : ℚ,
    Y ^ 2 = 256 * X ^ 7 - 448 * X ^ 5 + 224 * X ^ 3 - 28 * X + 5 ->
      X = -1 ∨ X = 1
```

and accepts a proof of this proposition as an explicit hypothesis.  Lean then
checks the seventh Chebyshev formula, the scalar polynomial model, the
integral specialization, and the exclusion at \(T>1\).  It does not claim to
reimplement Magma's descent or Sage's Coleman integration in the kernel.

## 10. References and trust boundary

* Magma Handbook, [the 2-Selmer group and rank bounds for hyperelliptic
  Jacobians](https://magma.maths.usyd.edu.au/magma/handbook/text/1618).
  The handbook states that \(J(K)/2J(K)\) embeds in the computed 2-Selmer
  group and that `RankBounds` collects the resulting rank information.
* SageMath Reference Manual, [hyperelliptic curves over a p-adic
  field](https://doc.sagemath.org/html/en/reference/arithmetic_curves/sage/schemes/hyperelliptic_curves/hyperelliptic_padic_field.html),
  documenting that `coleman_integrals_on_basis(P,Q)` returns
  \(\int_P^Q X^i dX/(2v)\), \(0\leq i<2g\).
* J. S. Balakrishnan, R. W. Bradshaw, and K. S. Kedlaya,
  [*Explicit Coleman integration for hyperelliptic curves*](https://arxiv.org/abs/1004.4936),
  ANTS IX, LNCS 6197 (2010), 16--31.
* R. F. Coleman,
  [*Torsion points on curves and p-adic Abelian integrals*](https://annals.math.princeton.edu/1985/121-1/p03),
  Annals of Mathematics 121 (1985), 111--168.

The completeness claim uses the exact Magma rank upper bound, the certified
modulo-5 Coleman logarithm data, and the explicit local lemma above.  It does
not use the exploratory `Points(... : Bound := ...)` routine, a database
assertion, or any unproved conjecture.
