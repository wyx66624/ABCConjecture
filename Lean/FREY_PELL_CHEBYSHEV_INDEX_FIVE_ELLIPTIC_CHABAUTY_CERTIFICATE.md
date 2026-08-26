# Prime-five Chebyshev curve: complete rational points by two-cover descent and elliptic Chabauty

## 1. Result

Let

\[
 F(T)=64T^5-80T^3+20T+5.
\]

The accepted-computation result recorded here is

\[
 y^2=F(T),\quad T,y\in\mathbf Q
 \quad\Longrightarrow\quad
 (T,y)\in\{(1,3),(1,-3),(-1,1),(-1,-1)\}.
\]

In particular, there is no integral solution with $T>1$.  This closes the
prime-index $p=5$ residual curve required by the four-consecutive Pell-unit
argument.

The computation is unconditional in the usual mathematical sense: it does
not invoke GRH, BSD, a conjectural analytic rank, or a height-search cutoff.
Its non-Lean trust boundary is the documented exact-arithmetic implementation
in Magma V2.29-9.  Section 7 gives the full executable input and the exact
successful transcript.  The companion Lean file checks the scalar change of
variables and all deductions from an explicitly supplied external
certificate; it does not manufacture a Lean proof of the Magma result.

## 2. Exact genus-two model

Put

\[
 X=-2T,\qquad Y=y,\qquad
 f(X)=-2X^5+10X^3-10X+5.
\]

Direct expansion gives

\[
 f(-2T)=64T^5-80T^3+20T+5=F(T).
\]

Thus it is enough to determine the rational points on the odd-degree
genus-two curve

\[
 C:\quad Y^2=f(X).
\]

## 3. The sole surviving two-cover candidate

Run `TwoCoverDescent(C : PrimeBound := 30)`.  The returned set has cardinality
one.  The phrase "returned set" is important: by the Magma handbook,
`PrimeBound := 30` restricts the good-prime local tests and therefore can make
the returned approximation *larger* than the proper fake two-Selmer set.  We
do not claim that Magma computed the full fake two-Selmer set here.

This one-sided approximation is nevertheless enough.  Every rational point
of $C$ gives a genuine locally soluble two-cover class, hence a class in the
returned approximation.  Since that approximation contains only one class,
every rational point must pass through its representative

\[
 \delta=\frac{2}{3}\theta^4-\frac{8}{3}\theta^2-\frac{4}{3}\theta+\frac{4}{3},
\]

where

\[
 A=\mathbf Q[\theta]/
 \left(\theta^5-5\theta^3+5\theta-\frac{5}{2}\right).
\]

This is a containment argument; no conclusion depends on whether the omitted
large-prime tests would later discard the candidate.

## 4. The elliptic quotient over a quintic field

Let

\[
 L=\mathbf Q(\alpha),\qquad
 \alpha^5-5\alpha^3+5\alpha-\frac{5}{2}=0.
\]

Over $L$, the polynomial factors as

\[
 f(X)=-2(X-\alpha)g(X),
\]

where

\[
\begin{aligned}
g(X)={}&X^4+\alpha X^3+(\alpha^2-5)X^2
 +(\alpha^3-5\alpha)X\\
&+\alpha^4-5\alpha^2+5.
\end{aligned}
\]

Map $A$ to $L[X]/(g)$ by $\theta\mapsto X$.  The norm associated with
the candidate cover is

\[
 \gamma=\operatorname{Norm}(\delta(X))
 =\frac{1}{3}(4\alpha^4-16\alpha^2-2\alpha+8).
\]

The standard two-cover construction used in the Magma handbook sends the
candidate cover to the genus-one quartic

\[
 E:\quad z^2=\gamma g(X).
\]

At $X=-2$, its right-hand side is the square of

\[
 s=-2\alpha^4+2\alpha^3+6\alpha^2-4\alpha-1,
\]

so $P_0=(-2,s)\in E(L)$.  Using $P_0$ as origin turns the quartic into an
elliptic curve $E_0/L$; Magma then replaces it by a minimal model
$E_m/L$.  The script retains the maps in both directions and verifies the
commuting identity for the map to the $X$-line at $P_0$.

Consequently, every point of $C(\mathbf Q)$ yields a point of $E_m(L)$
whose image in $\mathbf P^1$ is rational.

## 5. Elliptic Chabauty and why the list is complete

`PseudoMordellWeilGroup(Em)` returns `success=true` and

\[
 G\simeq \mathbf Z/2\mathbf Z\oplus\mathbf Z^3.
\]

The documented meaning of `success=true` is that the displayed group maps
injectively to a subgroup of finite odd index in $E_m(L)$.  It does **not**
assert that the subgroup is the full Mordell--Weil group.

The single-prime call

```magma
N,V,R,LC:=Chabauty(mp,EmToP1,19:Bound:=20);
```

returns

\[
 N=8,\qquad \#V=8,\qquad R=1.
\]

The Magma handbook specifies:

1. $N$ is an upper bound for the points in the image of `mp` whose
   projective-line image is rational.
2. `V` consists of points actually found with that property.
3. If the subgroup has finite index coprime to $R$, the same $N$ bounds
   the points in all of $E_m(L)$ with rational image.

Here the index is finite and every integer is coprime to $R=1$.  Therefore
$N=8$ bounds the full set in $E_m(L)$, while the eight elements of `V`
already give eight such points.  Equality $N=\#V=8$ proves completeness.
The returned value `#LC=2` does not weaken this count-equality argument.
Likewise, `Bound := 20` controls the search for the elements of `V`; once
eight points are found against the proved upper bound eight, it is not an
unproved global height cutoff.

The four distinct rational images of those eight elliptic points are

\[
 X=-2,\quad X=2,\quad X=0,\quad X=\infty.
\]

For transparency, $19$ was also checked independently.  The quintic field
has discriminant $4050000$, and $19$ factors into three unramified prime
ideals of norms $19,19^2,19^2$.  The minimal elliptic model has Kodaira type
`I0` at all three; at every prime above $19$, the quartic cover coefficients
are integral and its discriminant valuation is zero.

## 6. Pullback to the genus-two curve

The fibres on $C$ are elementary:

\[
\begin{array}{c|c|c}
X&f(X)&C(\mathbf Q)\text{ above }X\\ \hline
-2&9&(-2,\pm3)\\
 2&1&(2,\pm1)\\
 0&5&\varnothing\\
 \infty&-&\{\infty\}.
\end{array}
\]

The $X=0$ image is an elliptic-cover image only; it contributes no point to
$C(\mathbf Q)$, since $5$ is not a square in $\mathbf Q$.  Because the
model has odd degree, it has one rational point at infinity.  Hence

\[
 C(\mathbf Q)=
 \{\infty,(-2,-3),(-2,3),(2,-1),(2,1)\}.
\]

Finally $T=-X/2$, giving precisely $T=1$ and $T=-1$.  Therefore no
rational, and a fortiori no integral, $T>1$ solves the original equation.

## 7. Reproducible Magma V2.29-9 certificate

The following exact input was run on the official Magma calculator with
`SetSeed(1)`.  An independent rerun completed in 28.489 seconds and used
93.62 MB.  Online wall time is variable; an occasional gateway timeout is a
server limitation rather than a mathematical change.

```magma
SetSeed(1);
Q:=Rationals(); Qx<x>:=PolynomialRing(Q);
f:=-2*x^5+10*x^3-10*x+5; C:=HyperellipticCurve(f);
Hk,AtoHk:=TwoCoverDescent(C:PrimeBound:=30);
printf "HKSIZE=%o\n",#Hk;
A<theta>:=Domain(AtoHk); delta:=Rep(Hk)@@AtoHk;
printf "DELTA=%o\n",delta;
L<alpha>:=NumberField(x^5-5*x^3+5*x-5/2); LX<X>:=PolynomialRing(L);
g:=X^4+alpha*X^3+(alpha^2-5)*X^2+(alpha^3-5*alpha)*X+alpha^4-5*alpha^2+5;
printf "FACTOR=%o\n",Evaluate(f,X) eq -2*(X-alpha)*g;
LTHETA<THETA>:=quo<LX|g>; j:=hom<A->LTHETA|THETA>; gamma:=Norm(j(delta));
printf "GAMMA=%o\n",gamma;
E:=HyperellipticCurve(gamma*g); ok,s:=IsSquare(gamma*Evaluate(g,L!-2));
printf "SQUARE=%o\nS=%o\n",ok,s;
P0:=E![-2,s]; E0,EtoE0:=EllipticCurve(E,P0); Em,E0toEm:=MinimalModel(E0);
P1:=ProjectiveSpace(Q,1); EtoP1:=map<E->P1|[E.1,E.3]>; h:=EtoE0*E0toEm;
EmToP1:=Expand(Inverse(h)*EtoP1);
printf "MAP_DOMCOD=%o\n",Domain(h) eq E and Codomain(h) eq Em;
printf "COMMUTE=%o IMAGE=%o\n",EtoP1(P0) eq EmToP1(h(P0)),EmToP1(h(P0));
success,G,mp:=PseudoMordellWeilGroup(Em);
printf "SUCCESS=%o\nG=%o\n",success,G;
N,V,R,LC:=Chabauty(mp,EmToP1,19:Bound:=20);
printf "N=%o NV=%o R=%o NLC=%o\nV=%o\n",N,#V,R,#LC,V;
pi:=Extend(EmToP1); imgs:={P1(Q)|pi(mp(v)):v in V};
printf "IMGS=%o\n",imgs;
CtoP1:=map<C->P1|[C.1,C.3]>; fibres:=[ <p,RationalPoints(p@@CtoP1)> : p in imgs ];
printf "FIBRES=%o\n",fibres;
Qt<T>:=PolynomialRing(Q); F:=64*T^5-80*T^3+20*T+5;
printf "TRANSFORM=%o\n",Evaluate(f,-2*T) eq F;
```

Exact successful output (set ordering is non-semantic):

```text
HKSIZE=1
DELTA=2/3*theta^4 - 8/3*theta^2 - 4/3*theta + 4/3
FACTOR=true
GAMMA=1/3*(4*alpha^4 - 16*alpha^2 - 2*alpha + 8)
SQUARE=true
S=-2*alpha^4 + 2*alpha^3 + 6*alpha^2 - 4*alpha - 1
MAP_DOMCOD=true
COMMUTE=true IMAGE=(-2 : 1)
SUCCESS=true
G=Abelian Group isomorphic to Z/2 + Z + Z + Z
Defined on 4 generators
Relations:
2*G.1 = 0
N=8 NV=8 R=1 NLC=2
V={
0,
G.2 - 2*G.3 - 2*G.4,
-2*G.3 - 2*G.4,
G.2 - 6*G.3 - 4*G.4,
G.2 - 4*G.3 - 2*G.4,
2*G.2 - 8*G.3 - 4*G.4,
-4*G.3 - 2*G.4,
-G.2 + 2*G.3
}
IMGS={ (-2 : 1), (2 : 1), (1 : 0), (0 : 1) }
FIBRES=[
<(-2 : 1), {@ (-2 : -3 : 1), (-2 : 3 : 1) @}>,
<(2 : 1), {@ (2 : -1 : 1), (2 : 1 : 1) @}>,
<(1 : 0), {@ (1 : 0 : 0) @}>,
<(0 : 1), {@ @}>
]
TRANSFORM=true
```

### Independent check of the prime (19)

This input can be run separately.

```magma
Q:=Rationals(); Qx<x>:=PolynomialRing(Q);
L<alpha>:=NumberField(x^5-5*x^3+5*x-5/2); OL:=IntegerRing(L); LX<X>:=PolynomialRing(L);
g:=X^4+alpha*X^3+(alpha^2-5)*X^2+(alpha^3-5*alpha)*X+alpha^4-5*alpha^2+5;
gamma:=1/3*(4*alpha^4-16*alpha^2-2*alpha+8);
E:=HyperellipticCurve(gamma*g); ok,s:=IsSquare(gamma*Evaluate(g,L!-2)); assert ok;
P0:=E![-2,s]; E0,EtoE0:=EllipticCurve(E,P0); Em,E0toEm:=MinimalModel(E0);
fac19:=Factorization(19*OL);
printf "DISC_L=%o NPRIMES19=%o\n",Discriminant(L),#fac19;
data:=[];
for q in fac19 do
    li:=LocalInformation(Em,q[1]);
    Append(~data,<Norm(q[1]),q[2],li[2],li[3],li[4],li[5],li[6]>);
end for;
printf "LOCAL19=%o\n",data;
discCov:=Discriminant(gamma*g);
covdata:=[ <[Valuation(c,q[1]):c in Coefficients(gamma*g)],Valuation(discCov,q[1])> : q in fac19 ];
printf "COVER19=%o\n",covdata;
```

Exact output (0.210 seconds):

```text
DISC_L=4050000 NPRIMES19=3
LOCAL19=[ <19, 1, 0, 0, 1, I0, true>, <361, 1, 0, 0, 1, I0, true>, <361, 1, 0, 0, 1, I0, true> ]
COVER19=[
<[ 0, 1, 1, 0, 0 ], 0>,
<[ 0, 0, 0, 0, 0 ], 0>,
<[ 0, 0, 0, 0, 0 ], 0>
]
```

## 8. Lean boundary

The companion file is

`IUTThreeClosures/FreyPellChebyshevIndexFiveEllipticChabautyCertificate.lean`.

It defines the transparent proposition

```lean
def MagmaIntegralXCertificateIndexFive : Prop :=
  ∀ X Y : ℤ,
    Y ^ 2 = -2 * X ^ 5 + 10 * X ^ 3 - 10 * X + 5 →
      X = -2 ∨ X = 2
```

and takes a proof of that proposition as an explicit hypothesis.  Lean then
checks:

* the substitution $X=-2T$;
* every integral solution forces $T=1$ or $T=-1$;
* no integral $T>1$ solves the polynomial equation;
* the same result in the form $y^2=4T_5(T)+5$.

This interface is weaker than the external rational-point theorem and is
exactly as strong as the downstream integer argument needs.

## 9. Independent elementary identities

The following identities are useful diagnostics but are not used to claim
the global classification:

\[
\begin{aligned}
F(T)-1&=4(T+1)(4T^2-2T-1)^2,\\
F(T)-9&=4(T-1)(4T^2+2T-1)^2.
\end{aligned}
\]

There is also an elementary exclusion when $T$ itself is a square.  Write
$T=m^2>1$ and, replacing $m$ by $|m|$, assume $m\ge 2$.  Put
$A=8m^5-5m$.  Then

\[
F(m^2)=A^2-5(m^2-1).
\]

For this $m$,

\[
0<5(m^2-1)<2A-1,
\]

so

\[
(A-1)^2<F(m^2)<A^2.
\]

Thus no square $T>1$ can be a solution.  The elliptic-Chabauty certificate
is what excludes all remaining nonsquare $T$.

## 10. References and trust boundary

* Magma Handbook, [Two-Selmer set of a hyperelliptic curve and the documented
  two-cover-to-elliptic-Chabauty example](https://magma.maths.usyd.edu.au/magma/handbook/text/1619).
  In particular, this page documents that `PrimeBound` can enlarge the
  returned set.
* Magma Handbook, [Elliptic Curve Chabauty](https://magma.maths.usyd.edu.au/magma/handbook/text/1568#18242).
  This page gives the exact meanings of $N,V,R,L$, the finite-index
  condition, and `Bound`.
* Magma Handbook, [Mordell-Weil and two-descent functionality for genus-two
  Jacobians](https://magma.maths.usyd.edu.au/magma/handbook/text/1618).

The completeness claim rests on the exact Magma transcript plus the published
semantics above.  It is not a bounded search, an LMFDB assertion, or a
conditional rank computation.  The only external trust is Magma V2.29-9 and
its documented algorithms; all displayed substitutions and final finite
fibres are independently checkable scalar algebra.
