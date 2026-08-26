# A four-point same-index bridge and a window barrier for the Pell radical

## Abstract

Let

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad b_n=s_n^2-3,
 \qquad c_n=s_n^2-2=b_n+1,
\]

and put

\[
 X_n=b_nc_n,
 \qquad H_n=n\log(97+56\sqrt3).
\]

Thus

\[
 \log b_n=\log c_n=H_n+O(1),
 \qquad \log X_n=2H_n+O(1).                      \tag{0.1}
\]

This note isolates an exact same-index algebraic-geometric bridge.  The Pell
equation gives

\[
 b_n,\quad b_n+1,\quad b_n+2=3r_n^2,\quad
 b_n+3=s_n^2.                                    \tag{0.2}
\]

For the reduced four-point divisor

\[
 D_4=[0]+[-1]+[-2]+[-3]\subset\mathbf P^1
\]

put

\[
 N_{4,n}=N^{(1)}_{\mathbf P^1}(D_4,b_n)
 =\log\operatorname {rad}
   \bigl(b_n(b_n+1)(b_n+2)(b_n+3)\bigr)+O(1).     \tag{0.3}
\]

The two square branches in (0.2) have total truncated mass at most one
source-height unit:

\[
 \log\operatorname {rad}(b_n+2)
 +\log\operatorname {rad}(b_n+3)
 \le H_n+O(1).                                   \tag{0.4}
\]

Consequently the conjectural coefficient-two inequality

\[
 N_{4,n}\ge(2-\epsilon)H_n-O_\epsilon(1)          \tag{0.5}
\]

would imply, at the **same index**,

\[
 \log\operatorname {rad}(b_nc_n)
 \ge(1-\epsilon)H_n-O_\epsilon(1).               \tag{0.6}
\]

The coefficient in (0.5) is exactly
\(\deg D_4-2=2\), the truncated Second Main Theorem coefficient on
\(\mathbf P^1\).  It is also obtainable from two applications of the
usual `abc` conjecture to the two gap-two pairs.  Thus (0.5) is a precise
same-index bridge, but it is `abc`-strength input, not an unconditional
advance.

The original statements of Pasten, Corvaja--Zannier, the available
dynamical gcd theorem, the Thue estimate for consecutive almost powers, and
Stewart's square-free-factor theorem do not supply (0.5).  Pasten's theorem
does apply pointwise on \(\mathbf P^1\), outside only a finite exceptional
set, but its inverse scale is

\[
 \log\operatorname {rad}(b_nc_n)
 \gg {\log n\,\log_2 n\over\log_3 n},             \tag{0.7}
\]

not a positive multiple of \(H_n\).

Finally, a component-correct nonnegative profile shows that even an exact
aggregate super-square/exponent-one balance over a fixed window does not
imply the balance at each index.  Cross-index surplus therefore cannot be
used as the same-index compensation required by the cubeful-tail ledger.
No proof of (0.5), (0.6), or `abc` is obtained.

## 1. The four-consecutive block and its heights

The Pell equation is

\[
 s_n^2-3r_n^2=1.
\]

Subtracting the fixed constants gives the exact block

\[
 \begin{aligned}
 b_n   &=3r_n^2-2,\\
 b_n+1 &=3r_n^2-1,\\
 b_n+2 &=3r_n^2,\\
 b_n+3 &=s_n^2.
 \end{aligned}                                    \tag{1.1}
\]

If \(\alpha=7+4\sqrt3\), then \(\lambda=\alpha^2\), and

\[
 \log r_n={1\over2}H_n+O(1),
 \qquad
 \log s_n={1\over2}H_n+O(1).                    \tag{1.2}
\]

Since \(\operatorname {rad}(m)\le |m|\), (1.1)--(1.2) give

\[
 \begin{aligned}
 \log\operatorname {rad}(b_n+2)
  &=\log\operatorname {rad}(3r_n)
    \le {1\over2}H_n+O(1),\\
 \log\operatorname {rad}(b_n+3)
  &=\log\operatorname {rad}(s_n)
    \le {1\over2}H_n+O(1).
 \end{aligned}                                    \tag{1.3}
\]

These are upper bounds at the current index.  No radical mass from an
earlier Pell value is being transported into (1.3).

## 2. The exact four-point truncated bridge

For an integer \(x\), the finite part of the level-one count of \(D_4\)
is, up to the fixed normalization error,

\[
 N^{(1)}_{\mathbf P^1}(D_4,x)
 =\log\operatorname {rad}\bigl(x(x+1)(x+2)(x+3)\bigr)+O(1). \tag{2.1}
\]

Repeated support between two of the four factors is confined to primes
dividing one of the fixed differences \(1,2,3\), so one may equivalently
write the right side as the sum of the four individual logarithmic
radicals, with an \(O(1)\) correction.  In particular, with

\[
 R_n=\log\operatorname {rad}(b_nc_n),
\]

equation (1.3) gives the one-sided estimate

\[
 N_{4,n}\le R_n+H_n+O(1).                         \tag{2.2}
\]

The truncated Second Main Theorem prediction for four reduced points on
\(\mathbf P^1\) is

\[
 (\deg D_4-2-\epsilon)h(x)
 \le N^{(1)}_{\mathbf P^1}(D_4,x)+O_\epsilon(1).  \tag{2.3}
\]

Here \(h(b_n)=H_n+O(1)\), so (2.3) is exactly (0.5).  Combining (0.5)
with (2.2) proves (0.6).

More generally, a hypothetical linear coefficient \(\kappa\) in place of
\(2-\epsilon\) would retain only

\[
 R_n\ge(\kappa-1)H_n-O(1).                        \tag{2.4}
\]

Thus the full coefficient two, up to an arbitrarily small loss, is the
threshold for this four-point construction.  A coefficient strictly below
two by a fixed amount does not prove the critical Pell estimate.

### 2.1 Why this is `abc`-strength

There is no hidden improvement over `abc` in (2.3).  Apply `abc`, after
removing the harmless common factor at 2, to the gap-two triple
\((b_n,2,b_n+2)\), and apply it again to the gap-two triple
\((b_n+1,2,b_n+3)\).

The two conclusions add to

\[
 \sum_{j=0}^3\log\operatorname {rad}(b_n+j)
 \ge(2-o(1))H_n,                                 \tag{2.5}
\]

which is (0.5).  Conversely, (2.3) is the usual four-point form of the
truncated \(\mathbf P^1\) conjecture.  The construction identifies the
right same-index geometry; it does not make that geometry unconditional.

## 3. Translation to the cubeful-tail boundary

For a positive integer \(N=\prod p^{e_p}\), write

\[
 \begin{aligned}
 E(N)&=\sum_p(e_p-1)\log p,\\
 C_3(N)&=\sum_p(e_p-2)_+\log p,\\
 S_1(N)&=\sum_{e_p=1}\log p.
 \end{aligned}
\]

The exact identity from the cubeful-tail audit is

\[
 2E(N)-\log N=C_3(N)-S_1(N).                      \tag{3.1}
\]

For \(N=X_n\), equations (0.1) and (0.6) give

\[
 E(X_n)\le(1+\epsilon)H_n+O_\epsilon(1),          \tag{3.2}
\]

and hence

\[
 C_3(X_n)\le S_1(X_n)+2\epsilon H_n+O_\epsilon(1). \tag{3.3}
\]

After the repeated-hit depth reduction, the unresolved high-prime part of
\(C_3(X_n)\) is, schematically,

\[
 W_n+D_n^{\rm sel}+o(n),                          \tag{3.4}
\]

where \(W_n\) is base-Wieferich carrier mass.  The superscript is essential:
the layers in \(D_n^{\rm sel}\) are first only relative to the selected
inverse-target pair, not necessarily first among all four target roots.  The
notation here denotes the **extended unresolved total**: it contains both the
medium-order range \(T_n<t_p\le 2n\) and the selected-target-first layers with
\(t_p>2n\).  In the medium range the repeated-hit audit first proves the exact
refinement below; the \(t_p>2n\) layers are then adjoined after applying the
same cross-target/four-target-first split.  Thus, for the extended totals used
throughout this note, one has

\[
 D_n^{\rm sel}=C_n^{\rm cross}+F_n^{\rm four},    \tag{3.5}
\]

where \(C_n^{\rm cross}\) consists of layers already hit at the same depth by
another target at an earlier index and \(F_n^{\rm four}\) is genuinely
four-target-first.

For a layer in \(C_n^{\rm cross}\), with earlier index \(m<n\), the complete
fixed-gap carrier gives

\[
 p^\ell\mid\gcd_{\rm odd}(X_m,X_n)\mid R_{|n-m|},
 \qquad \log|R_d|=O(d).                            \tag{3.6}
\]

Thus every shared layer is transported in full.  But a fixed window
\(|n-m|\le M\) has only an \(O_M(1)\) carrier budget, while summing over all
earlier indices gives only

\[
 \sum_{m<n}O(n-m)=O(n^2).                          \tag{3.7}
\]

Neither estimate supplies the missing linear same-index compensation: the
carrier transports a prime-power layer from \(X_m\), not exponent-one mass
from \(X_n\).

The four-point inequality (0.5) would bypass the historical labels entirely,
because it counts all four values at the current index.  It would therefore
imply the precise remaining same-index statement

\[
 W_n+C_n^{\rm cross}+F_n^{\rm four}
 \le S_1(X_n)+2\epsilon H_n+o_\epsilon(n).        \tag{3.8}
\]

This route does not require \(W_n\), \(C_n^{\rm cross}\), or
\(F_n^{\rm four}\) to be individually sublinear.  It permits their mass
exactly to the extent that exponent-one support of the **same** \(X_n\)
compensates it.  The route remains wholly conjectural through (0.5).

## 4. Pasten's theorem: exact specialization and exact limit

Pasten's Theorem 1.6 applies to a smooth projective variety \(X/\mathbf Q\),
distinct prime divisors \(D_i\) that are linearly dependent modulo linear
equivalence, an algebraic point \(P\notin\operatorname {supp}(D)\), and a
place \(v\).  Its quantifiers produce one proper Zariski closed set
\(Z\subsetneq X\), depending only on \(X,D_1,\ldots,D_q,P\) and in
particular independent of \(\epsilon\) and \(v\); for every
\(\epsilon>0\), every place \(v\), and every rational point outside \(Z\),
the theorem gives

\[
 \lambda_{X,v}(P,x)
 <(\log^*h_D(x))
 \exp\!\left(
   {(1+\epsilon)N^{(1)}_D(x)\over
      \log^*N^{(1)}_D(x)}
      \log^*_2N^{(1)}_D(x)+O(1)
 \right).                                        \tag{4.1}
\]

The position of the iterated logarithm in (4.1) matters: it multiplies
the fraction; it is not an additional denominator.

Take \(X=\mathbf P^1\),

\[
 D_2=[0]+[-1],\qquad P=\infty,\qquad x=b_n.
\]

The two points are linearly dependent modulo linear equivalence, and

\[
 \begin{aligned}
 \lambda_{\infty}(\infty,b_n)&=H_n+O(1),\\
 h_{D_2}(b_n)&=2H_n+O(1),\\
 N^{(1)}_{D_2}(b_n)&=R_n+O(1).
 \end{aligned}                                    \tag{4.2}
\]

On \(\mathbf P^1\), a proper Zariski closed set is finite.  Since the
integers \(b_n\) are distinct and tend to infinity, the exceptional set in
Theorem 1.6 removes only finitely many indices.  Thus this is a legitimate
pointwise, all-sufficiently-large-\(n\) specialization, not a density-one
statement.

Equations (4.1)--(4.2) invert only to

\[
 R_n\gg {\log H_n\,\log_2H_n\over\log_3H_n}
 \asymp {\log n\,\log_2n\over\log_3n}.            \tag{4.3}
\]

This has zero coefficient relative to \(H_n\).  Applying Theorem 1.6 to
\(D_4\) merely replaces \(R_n\) in the right side by the larger count
\(N_{4,n}\); the theorem has no factor \(\deg D-2\) that can be harvested.

This absence is also visible in Pasten's proof.  The divisor dependence is
used to construct a nonconstant rational map \(f:X\dashrightarrow\mathbf
P^1\) whose pullback of \([0]+[\infty]\) is supported on \(D\).  The proof
then uses

\[
 N^{(1)}_{\mathbf P^1}([0]+[\infty],f(x))
 \le N^{(1)}_X(D,x)                               \tag{4.4}
\]

and applies the one-dimensional approximation theorem.  More components
increase the right side of (4.4); they do not multiply the left side of
(4.1).

Pasten's Theorem 1.9 has a genuinely stronger conclusion under the
Lang--Waldschmidt conjecture.  Specialized directly to \(D_2\), it gives

\[
 H_n\le(1+\epsilon)R_n+2\epsilon H_n+O(1),        \tag{4.5}
\]

which does imply (0.6) after changing \(\epsilon\).  This confirms rather
than removes the boundary: the required linear coefficient enters through
an unproved transcendence conjecture.

### 4.1 Why fixed-dimensional amplification does not help

One may embed a window into \((\mathbf P^1)^M\), for example

\[
 n\longmapsto(b_n,b_{n+1},\ldots,b_{n+M-1}).      \tag{4.6}
\]

Its image lies on the fixed algebraic curve obtained from the Pell conic.
The proper closed exceptional set in Theorem 1.6 is allowed to contain this
whole curve.  Therefore the high-dimensional theorem cannot be restricted
to (4.6) unless one separately proves that the curve is not exceptional.
If one instead works on the normalization of the curve, the exceptional set
is finite, but the argument is again one-dimensional and retains the scale
(4.3).

Duplicating the same coordinate is even more transparent.  The diagonal in
\((\mathbf P^1)^M\) is a proper closed subvariety and may be swallowed by
the exceptional set.  A theorem with a putative coefficient growing with
\(M\) would have to exclude precisely this diagonal; it cannot be read off
from Theorem 1.6.

## 5. Audit of the other unconditional inputs

The following distinctions are about theorem scope, not about heuristic
plausibility.

### 5.1 Corvaja--Zannier and BCZ gcd estimates

Corvaja--Zannier's Theorem 1 concerns two nonconstant coprime polynomials
\(p,q\in\mathbf Q[X,Y]\), not both vanishing at \((0,0)\), evaluated on a
fixed finitely generated subgroup of \(\mathbf G_m^2\).  The Zariski closure
of the exceptional solutions is a finite union of translates of
one-dimensional subtori and a finite set.  Its Corollary 1 gives the
corresponding small generalized gcd for multiplicatively independent pairs,
apart from finitely many pairs (for each fixed \(\epsilon\) and group).  This
is an all-points-outside-exceptions result, not an average.

For two same-orbit target coordinates

\[
 u_n=\lambda^n\gamma_i^{-1},
 \qquad v_n=\lambda^n\gamma_j^{-1},               \tag{5.1}
\]

one has the fixed relation

\[
 {u_n\over v_n}={\gamma_j\over\gamma_i}.          \tag{5.2}
\]

Thus the whole sequence lies in a translate of a one-dimensional subtorus,
exactly the type of exceptional locus retained in the original theorem.
Moreover, two distinct target factors have fixed difference and no common
odd support.  A gcd estimate measures simultaneous vanishing, whereas a
prime contributing to \(C_3(X_n)\) chooses one simple target and may vanish
there to high order.  The BCZ estimate

\[
 \log\gcd(a^n-1,b^n-1)\le\epsilon n+O_\epsilon(1)
\]

is pointwise for all sufficiently large \(n\) when \(a,b\) are
multiplicatively independent, but it controls the same intersection
statistic and therefore does not imply (0.5).

### 5.2 Dynamical gcd theorems

Matsuzawa's unconditional Theorem 1.5 treats a dominant rational self-map
of a smooth projective variety and a proper closed subscheme of codimension
\(c\).  When the map is not a morphism it imposes additional purity,
regular-embedding, and finite-locus hypotheses on the subscheme.  For a
well-defined generic orbit it gives

\[
 {h_Y(f^n(x))\over h_H(f^n(x))}\longrightarrow0  \tag{5.3}
\]

provided, in particular,

\[
 d_c(f)^{1/c}<\alpha_f(x).                        \tag{5.4}
\]

The paper explicitly notes that its method requires nontrivial dynamical
degree and does not recover the BCZ diagonal-map example, whose first
dynamical degree is one.  The Pell torus map \(z\mapsto\lambda z\) is a
morphism (indeed an automorphism), so the extra geometric branch above is
irrelevant; nevertheless all its dynamical degrees are one, while
\(h(\lambda^n)=\Theta(n)\) gives arithmetic degree one.  Condition (5.4)
would read \(1<1\).  For a fixed-window product, the orbit also lies on a
proper invariant curve and hence is not generic in the ambient product;
restriction to that curve restores genericity but still leaves \(1<1\).

Arithmetic-dynamical primitive-divisor theorems for rational maps of degree
at least two likewise do not apply to this degree-one orbit.  Even when
they apply, existence of one new prime records one level-one copy and does
not bound the super-square mass of the same term.

### 5.3 Runge, Thue, and Thue--Mahler scope

Write two consecutive integers as

\[
 b=a u^3,\qquad b+1=d v^3,
\]

with \(a,d\) cube-free.  De Weger--van de Woestijne's Theorem 1.3 is
effective and pointwise for every integer \(b\), but for \(k=3\) it gives
only

\[
 \max\{a,d\}\gg(\log b)^{1/5}.                  \tag{5.5}
\]

Their proof quotes a quantitative Thue bound whose constants depend on the
height of the binary form; this dependence is exactly what leads to the
logarithmic power in (5.5).  Their Theorem 1.4 obtains the polynomial
threshold exponent \(1/4\) for two consecutive cubes only under `abc`.

A Runge or Thue--Mahler theorem for one fixed curve, one fixed twist, or one
fixed finite prime set gives an all-solutions statement for that fixed
data.  Here the cube-free twists and the support set move with \(n\).
Taking a union over those data loses the fixed constants.  Finiteness for
each member of a moving family is not a uniform coefficient-two inequality
for (0.3).

There is a second mismatch: cube-free kernels record exponents modulo
three.  The critical identity (3.1) treats exponent two as neutral and
compares copies after the second with primes of exponent exactly one.  A
bound for \(\max\{a,d\}\) must therefore be translated with care even
before its scale is considered.

### 5.4 Square-free factors of recurrences

Stewart's Theorem 1 is a pointwise theorem.  If an integer \(u(n)\) admits
fixed algebraic data \(\alpha,f,\delta\), with \(|\alpha|>1\),
\(0<\delta<1\), and

\[
 0<|u(n)-f(n)\alpha^n|<|\alpha|^{\delta n},        \tag{5.6}
\]

then for every sufficiently large \(n\) it gives

\[
 \operatorname {rad}(u(n))
 >n^{C\log_2n/\log_3n}.                           \tag{5.7}
\]

Indeed, with \(\lambda=97+56\sqrt3\), the present sequence has the exact
five-root expansion

\[
 X_n={1\over16}
 \bigl(\lambda^{2n}-16\lambda^n+62
       -16\lambda^{-n}+\lambda^{-2n}\bigr).        \tag{5.8}
\]

Take \(\alpha=\lambda^2\), \(f=1/16\), and any fixed
\(1/2<\delta<1\).  The remaining four terms are \(O(\lambda^n)\), so
(5.6) holds and (5.7) applies directly to the integer \(X_n\) for all
sufficiently large \(n\).  Taking logarithms again gives (0.7), not a
positive multiple of \(H_n\).  This theorem is not merely an average; its
failure here is the coefficient, not the quantifier.

By contrast, a density-one or mean estimate for square-free values, sieve
remainders, or Hensel classes would still leave exceptional indices.  No
such average can be substituted for the pointwise statement (3.8).

## 6. A component-correct window counterprofile

The fixed-window idea has a separate logical obstruction even if one grants
an optimal aggregate estimate.  Fix a positive source height \(H\), and put

\[
 w={H\over3}.
\]

At one bad index, let each of the two components consist of one cube of
prime-log weight \(w\).  Each component has total height \(3w=H\), and the
two-component ledger is

\[
 C_3^{\rm bad}=2w={2H\over3},
 \qquad S_1^{\rm bad}=0.                          \tag{6.1}
\]

At a neighboring good index, let each component contain one exponent-one
prime and one exponent-two prime, both of log weight \(w\).  Each component
again has total height

\[
 w+2w=H,
\]

while

\[
 C_3^{\rm good}=0,
 \qquad S_1^{\rm good}=2w={2H\over3}.             \tag{6.2}
\]

All masses are nonnegative, both indices have total logarithmic size
\(2H\), and supports may be chosen disjoint.  Nevertheless,

\[
 C_3^{\rm bad}+C_3^{\rm good}
 =S_1^{\rm bad}+S_1^{\rm good},                  \tag{6.3}
\]

whereas the bad index violates

\[
 C_3^{\rm bad}
 \le S_1^{\rm bad}+2\eta H                       \tag{6.4}
\]

for every \(\eta<1/3\).

One good profile already offsets one bad profile.  Hence any fixed window
of length at least two can satisfy an aggregate balance while containing a
bad index.  Disjoint support also satisfies every cross-index gcd upper
bound.  For actual Pell heights, neighboring source heights differ only by
\(O_M(1)\) in a fixed length-\(M\) window, so the scalar construction is
stable after an arbitrarily small slack.

Actual cross-target early hits come with more structure than this abstract
profile: (3.6) places their full common depth in the fixed-gap carrier
\(R_{|n-m|}\).  This does not repair localization.  For a fixed window its
total logarithmic budget is only \(O_M(1)\); over the whole moving past the
available sum is \(O(n^2)\), as in (3.7).  In neither case does the carrier
assign compensating exponent-one mass to the current \(X_n\).

This is not a sequence of Pell integers, and it is not an `abc`
counterexample.  Its strict conclusion is only

> A theorem bounding the sum of \(C_3-S_1\) over several indices does not,
> by nonnegativity or by gcd disjointness alone, imply the required bound at
> each index.

To recover (3.8) from a window, one needs an additional localization or
mass-transport theorem that assigns the compensating exponent-one mass to
the same \(X_n\).  An ordinary average supplies no such assignment.

## 7. The smallest surviving proposition

The four-point route is now exact.  It would be enough to prove, for every
\(\epsilon>0\),

\[
 \boxed{
 N^{(1)}_{\mathbf P^1}
   ([0]+[-1]+[-2]+[-3],b_n)
 \ge(2-\epsilon)H_n-O_\epsilon(1)}                \tag{7.1}
\]

for every sufficiently large \(n\).

Equation (7.1) is a same-index statement and would absorb the
base-Wieferich mass \(W_n\), the selected-target-first cross-carrier mass
\(C_n^{\rm cross}\), and the genuinely four-target-first mass
\(F_n^{\rm four}\) through the current exponent-one ledger, regardless of
their historical classification.  It is also the full conjectural
\(\deg D_4-2\) coefficient and follows from `abc`; none of the audited
unconditional theorems proves it.

An unconditional result with a genuine linear coefficient
\(\kappa>1\) in (2.4) would still be new: it would give a positive linear
lower bound for \(R_n\).  To close the Pell route by this auxiliary divisor,
however, the coefficient must approach two.

## 8. Formalization boundary

The companion module
`IUTThreeClosures/FreyPellFourPointTruncatedBridge.lean` proves only:

* the four identities in (1.1) and the square-branch product identity;
* the scalar implication from a coefficient-\(\kappa\) four-point count to
  a coefficient-\((\kappa-1)\) target count;
* the coefficient-two specialization (0.5) \(\Rightarrow\) (0.6);
* conversion of the critical radical bound to the same-index
  super-square/exponent-one balance; and
* the nonnegative, component-height-correct two-index profile
  (6.1)--(6.4).

Lean does not formalize or assume Vojta's conjecture, `abc`, Pasten's
theorem, the Subspace Theorem, dynamical degrees, Runge or Thue--Mahler
theorems, Stewart's theorem, radical asymptotics, or (7.1).  No missing
number-theoretic statement is introduced as an axiom.

## References

* H. Pasten, *On the arithmetic case of Vojta's conjecture with truncated
  counting functions*, Math. Res. Lett. 32 (2025), 1249--1268,
  [author preprint](https://arxiv.org/abs/2205.07841).
* P. Corvaja and U. Zannier, *A lower bound for the height of a rational
  function at S-unit points*, Monatsh. Math. 144 (2005), 203--224,
  [authors' preprint](https://arxiv.org/abs/math/0311030).
* Y. Bugeaud, P. Corvaja and U. Zannier, *An upper bound for the G.C.D. of
  \(a^n-1\) and \(b^n-1\)*, Math. Z. 243 (2003), 79--84,
  [journal record](https://doi.org/10.1007/s00209-002-0449-z).
* Y. Matsuzawa, *Growth of generalized greatest common divisors along
  orbits of self-rational maps on projective varieties*,
  [primary preprint](https://arxiv.org/abs/2507.05027).
* P. Ingram and J. H. Silverman, *Primitive divisors in arithmetic
  dynamics*, Math. Proc. Cambridge Philos. Soc. 146 (2009), 289--302,
  [authors' preprint](https://arxiv.org/abs/0707.2505).
* B. M. M. de Weger and C. E. van de Woestijne, *On the power-free parts of
  consecutive integers*, Acta Arith. 90 (1999), 387--395,
  [author PDF](https://deweger.net/papers/%5B31%5DvdWdW-PowFree-ActaArith%5B1999%5D.pdf).
* C. L. Stewart, *On the greatest square-free factor of terms of a linear
  recurrence sequence*, in **Diophantine Equations**, Tata Institute
  Studies in Mathematics 20 (2008), 257--264,
  [author PDF](https://uwaterloo.ca/pure-mathematics/sites/default/files/uploads/documents/greatest_square_free_factor_0.pdf).
* P. Vojta, *A more general abc conjecture* (1998),
  [primary text](https://arxiv.org/abs/math/9806171).
