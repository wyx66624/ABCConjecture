# Arakelov-weighted congruence degree: the exact positive module and its boundary

## 1. Result of the audit

There is a genuine and very small positive construction.  If `n>0` and

\[
 n=\prod_{p\mid n}p^{e_p},\qquad
 R=\operatorname{rad}(n),\qquad Q=n/R,
\]

then the finite torsion sheaf on `Spec Z`

\[
 \mathcal C_{\rm exc}(n)=\mathbf Z/Q\mathbf Z                 \tag{1.1}
\]

has arithmetic degree

\[
 \widehat{\deg}\mathcal C_{\rm exc}(n)
 =\log Q
 =\sum_{p\mid n}(e_p-1)\log p.                              \tag{1.2}
\]

Thus the requested `log p` weighting can be constructed honestly.  It is not
an ordinary Hecke congruence module, however: its modulus already contains
the full powerful part of `n`.  The remaining radical-level upper bound is
exactly the hard height estimate one wanted to prove.

The construction is also canonical as a boundary-intersection object, not
merely as a cyclic group chosen to have the desired order.  Since `(n)` is
contained in `(R)`, there is a short exact sequence

\[
 0\longrightarrow (R)/(n)\longrightarrow \mathbf Z/(n)
 \longrightarrow\mathbf Z/(R)\longrightarrow0,              \tag{1.3}
\]

and multiplication by `R` identifies `(R)/(n)` with `Z/QZ`.  Thus
`C_exc` is the ideal of the reduced boundary inside its nonreduced
thickening: it measures exactly the excess contact multiplicity.

The audit also gives a strict support obstruction.  Higher level-lowering
congruences live at primes `lambda | ell` of a coefficient ring, while the
weight in (1.2) lives on the bad-prime divisor `[p]`.  In the range where the
Tate inertia calculation applies, `p != ell`; the two vertical supports are
comaximal.  Tensor products, ordinary intersections, Fitting ideals, and
Deligne pairings do not transport `log ell` into `log p`.

No proof of abc or Szpiro is obtained.  The companion Lean file formalizes
the exact algebraic and arithmetic-degree core and the strict countermodels.
The moduli-stack, Tate, Fitting, and Arakelov interpretations below remain
paper mathematics.

## 2. Why arithmetic degree gives exactly the right weight

For a finite `Z`-module `M`,

\[
 \widehat{\deg}M=\log\#M
 =\sum_p \operatorname{length}_{\mathbf Z_p}(M_p)\log p.     \tag{2.1}
\]

The factor `log p` is the logarithm of the residue-field norm.  Applying
(2.1) to (1.1) gives

\[
 \operatorname{length}_{\mathbf Z_p}
   (\mathcal C_{\rm exc}(n)_p)=v_p(Q)=e_p-1,                 \tag{2.2}
\]

and hence (1.2).  Moreover

\[
 \operatorname{Fitt}_0(\mathcal C_{\rm exc}(n))=(Q).        \tag{2.3}
\]

The exact sequence (1.3) gives the same identity additively:

\[
 \widehat\deg\mathbf Z/(n)
 =\widehat\deg\mathbf Z/(R)+\widehat\deg\mathcal C_{\rm exc}(n).
                                                                    \tag{2.4}
\]

This is a real finite module, not a record containing a desired inequality
as a field.  When `Q=1`, it is the zero module, its cardinality is one, and
its degree is zero, as required.

There is also a finite-profile version.  For positive exponents `e_i` and
bases `b_i`, set

\[
 C_{\rm exc}=\prod_i b_i^{e_i-1},\quad
 D_{\rm exc}=\sum_i(e_i-1)w_i.                              \tag{2.5}
\]

Then

\[
 \left(\prod_i b_i\right)C_{\rm exc}=\prod_i b_i^{e_i},
 \qquad
 \sum_i e_iw_i=\sum_iw_i+D_{\rm exc}.                      \tag{2.6}
\]

For `w_i=log b_i`, `D_exc=log C_exc`.  The Lean module proves all three
identities and specializes them to the prime factorization of `n`.

## 3. Frey and Tate interpretation

Put `n=abc` for a primitive abc point.  At an odd prime `p | abc`, the Frey
curve has multiplicative reduction and

\[
 v_p(\Delta_{\min})=2e_p,\qquad f_p(N)=1.                   \tag{3.1}
\]

Consequently the odd part of the desired excess divisor is

\[
 D_{\rm exc}^{\rm odd}
 =\sum_{\substack{p\mid abc\\p\ne2}}(e_p-1)[p]
 =\tfrac12\operatorname{div}(\Delta_{\min})_{\rm odd}
   -\operatorname{div}(N)_{\rm odd}.                       \tag{3.2}
\]

For a Tate local model with parameter `q`, the boundary contact order is
`v_p(q)=v_p(Delta_min)`.  Thus (3.2) is geometrically the excess contact with
the boundary after removing the reduced bad divisor, with the Frey-specific
factor one half.  Equivalently, over `Z_p` the local summand is

\[
 \mathbf Z_p/p^{e_p-1}\mathbf Z_p.                          \tag{3.3}
\]

At `p=2`, minimality and conductor corrections must be treated separately;
no claim that (3.2) holds unchanged at two is made.  The arithmetic module
`Z/(abc/rad(abc))` itself includes two exactly, independently of the curve
interpretation.

On the compactified elliptic moduli stack, the discriminant section records
the nonreduced boundary contact, whereas the semistable conductor records the
reduced boundary.  The relation `12 lambda = delta` transports discriminant
degree to Hodge degree; it does not bound contact multiplicity by reduced
support.  The module in (3.2) is the **Frey-normalized half-discriminant
excess** `(1/2)D_Delta-D_red`.  The raw thickening difference attached to
the full Tate boundary contact `2e_p` would instead have coefficient
`2e_p-1`; these two normalizations are not identified.

## 4. The radical upper bound is the target height inequality

Let

\[
 H(n)=\log n,\qquad R(n)=\log\operatorname{rad}(n),\qquad
 E(n)=\widehat{\deg}\mathcal C_{\rm exc}(n).
\]

The construction gives the exact identity

\[
 H(n)=R(n)+E(n).                                             \tag{4.1}
\]

Therefore, for every real `eta,C` and every positive `n`,

\[
 E(n)\le \eta R(n)+C
 \quad\Longleftrightarrow\quad
 H(n)\le(1+\eta)R(n)+C.                                    \tag{4.2}
\]

This is an equivalence, not merely an implication.  Constructing the lower
module has not made the upper bound easier; the upper bound is exactly a
powerful-part estimate.  When `n=abc`, (4.2) is a statement about the product
height `log(abc)`, not the standard abc height `log c`; no equivalence between
(4.2) and the abc conjecture is asserted.

For the odd Frey divisor, write

\[
 H_{\Delta}=\log|\Delta_{\min,\rm odd}|=2\sum_p e_p\log p,
 \qquad H_N=\log N_{\rm odd}=\sum_p\log p.
\]

Then

\[
 E_{\rm odd}\le\eta H_N+C
 \quad\Longleftrightarrow\quad
 H_{\Delta}\le2(1+\eta)H_N+2C.                             \tag{4.3}
\]

In particular, `eta=2+epsilon/2` gives the `6+epsilon` discriminant-conductor
slope for the odd semistable part.  After the usual fixed-prime corrections,
this is Szpiro-strength input, not a proved Szpiro or abc theorem.  Calling
(4.3) an “Arakelov upper bound” does not remove that content.

Arithmetic Noether formulas, the Hodge bundle, or a Deligne pairing can
rewrite the left side of (4.3).  An upper bound by the reduced boundary still
requires a new theorem of precisely the strength displayed in (4.3).

## 5. Strict local counterexample to a formal intersection upper bound

Let `R` be an arithmetic DVR with finite residue field `k`, let `pi` be a
uniformizer, and map `Spec R` to the affine line with boundary `t=0` by

\[
 t\longmapsto\pi^m.                                         \tag{5.1}
\]

The pullback boundary is `m[pi]`; its reduced pullback is `[pi]`.  Hence the
excess contact is `(m-1)[pi]`, with arithmetic degree
`(m-1)log #k`, while the reduced support is fixed.  Equivalently, over
`Spec Z` take

\[
 n=2^{m},\qquad \operatorname{rad}(n)=2,\qquad
 n/\operatorname{rad}(n)=2^{m-1}.                           \tag{5.2}
\]

Thus, with exact quantifiers,

\[
 \forall B\ \exists n:
 \operatorname{rad}(n)=2,\quad
 \#\mathcal C_{\rm exc}(n)>B.                              \tag{5.3}
\]

This strictly rules out deriving a radical-only upper bound from the formal
properties of vertical divisors, Fitting ideals, or intersection positivity
for arbitrary arithmetic maps.  It does not rule out a theorem exploiting
the global equation `a+b=c`; that global input is exactly what remains open.

## 6. Why Hecke congruence ideals have the wrong vertical support

Let `T -> O` be an eigenpacket with congruence ideal `eta_f`, and let
`lambda | ell`.  A `lambda`-primary congruence contribution has arithmetic
degree

\[
 \operatorname{ord}_{\lambda}(\eta_f)\log N\lambda
 =f_{\lambda}\operatorname{ord}_{\lambda}(\eta_f)\log\ell. \tag{6.1}
\]

The higher Tate inertia criterion can relate its depth to
`v_ell(e_p)`.  Summing over residual primes dividing `e_p` reconstructs at
best

\[
 \sum_{\ell}v_{\ell}(e_p)\log\ell=\log e_p,                 \tag{6.2}
\]

not `e_p log p`.

There is a sharper support statement.  If `p != ell`, then

\[
 (p^a)+(\ell^b)=\mathbf Z,\qquad
 \gcd(p^a,\ell^b)=1.                                       \tag{6.3}
\]

Consequently

\[
 (\mathbf Z/p^a)\otimes_{\mathbf Z}(\mathbf Z/\ell^b)=0,
 \qquad
 \operatorname{Tor}_1^{\mathbf Z}
   (\mathbf Z/p^a,\mathbf Z/\ell^b)=0.                     \tag{6.4}
\]

The corresponding vertical closed subschemes are disjoint.  The companion
Lean theorem proves (6.3) for all exponents and all distinct primes.  Over a
coefficient ring, the same conclusion holds for primes above distinct
rational characteristics.

Therefore an intersection or tensor operation on an `ell`-primary Hecke
congruence module and a `p`-vertical Tate divisor gives zero rather than a
new `p`-weighted length.  To obtain (3.3), one must insert a `p`-supported
object whose length already knows `e_p-1`.

## 7. Exact depth-only countermodel

The mismatch is present even for actual local Tate curves.  First use the
**raw contact normalization** `m=v_p(q)`.  Fix `m=2` and, for an arbitrarily
large odd prime `p`, take a Tate parameter of valuation two.  The
prime-power content of `m` is always the fixed integer two, whereas the raw
contact-excess carrier and degree are

\[
 C_{\rm exc}=p,\qquad \widehat{\deg}C_{\rm exc}=\log p.      \tag{7.1}
\]

In exact arithmetic form,

\[
 \forall B\ \exists p\text{ prime}: B\cdot2<p,
 \qquad p^{2-1}=p.                                          \tag{7.2}
\]

Thus no function of unweighted congruence depth alone can dominate the
weighted carrier uniformly in the bad prime.  This countermodel is local; it
does not assert that every such Tate curve is a Frey curve of a global abc
point.  In the Frey normalization of Section 3, the analogous statement sets
`e_p=2`, hence `v_p(q)=v_p(Delta_min)=4`, and again obtains normalized carrier
`p^(e_p-1)=p`.  The raw and Frey-normalized statements must not be conflated.

The previously isolated global family
`(3^e,2,3^e+2)` supplies the complementary phenomenon: at the fixed bad prime
three, the target grows like `e log 3`, higher congruence recovery gives only
`log e`, and the rational Tamagawa number stays two.

## 8. Audit of the standard proposed bridges

### 8.1 Fitting and congruence ideals

Fitting ideals correctly add lengths for genuine direct sums.  They do not
prove that congruences obtained by lowering different bad primes are
independent direct summands.  A single common `lambda^k` congruence retains a
minimum depth, and repeated branches can have the same congruence ideal.
Even after independence across residual primes, the degree is (6.2).

### 8.2 Monodromy and component groups

Geometric monodromy order can recover the integer `e_p`; its logarithmic
size is still `log e_p`.  Rational Tamagawa groups can lose even that depth in
the nonsplit case.  Neither object has order `p^(e_p-1)`.

### 8.3 Arakelov determinants and Deligne pairings

These constructions do attach `log p` to a `p`-vertical length.  Applied to
the Tate contact divisor, they reproduce (1.2) or (3.2).  Their determinant
identities give equalities with discriminant/Hodge height, not an upper bound
by the reduced conductor.  Positivity gives a lower inequality in the wrong
direction for deleting contact multiplicity.

### 8.4 Modular degrees

Qualitative relations among modular degrees, congruence numbers, and
component groups transport divisibility by factors of `e_p`.  They do not
transport the bad prime `p` into the characteristic of the congruence ideal.
A hypothetical divisibility by `p^(e_p-1)` would be the genuinely new input,
and local Hecke/Tate support gives no such divisibility.

### 8.5 Modular units or the discriminant section

Evaluating a modular unit at a Tate point can indeed have valuation
proportional to `v_p(q)` and therefore realizes the correct weighted divisor.
But bounding that value by its reduced prime support is an `S`-unit or
truncated-counting inequality.  It is a reformulation of the surviving
height problem, not a consequence of the divisor formula.

## 9. The smallest surviving positive target

The lower module is now explicit.  The remaining theorem cannot merely say
“there exists an Arakelov congruence module”; it must provide an independently
proved global inequality for the Frey moduli map.  One precise version is:

\[
 \widehat{\deg}D_{\rm contact}^{\rm excess}
 \le (2+\varepsilon/2)\widehat{\deg}D_{\rm contact}^{\rm red}
      +C_{\varepsilon},                                    \tag{9.1}
\]

with the two-adic and archimedean corrections stated explicitly.  By (4.3),
the excess symbol in (9.1) means the Section 3 **Frey-normalized** divisor
`(1/2)D_Delta-D_red`, not the raw Tate excess of Section 7.  With this
normalization, (9.1) is already the `6+epsilon` Szpiro-slope statement; its
proof must use genuinely new global arithmetic and must be audited for
circular dependence on abc, Szpiro, Vojta, or an equivalent modular-height
estimate.

A less ambitious but still nontrivial research target would be a theorem
showing that a naturally defined global determinant receives the
`p^(e_p-1)`-Fitting divisor from the Tate contact module.  The support audit
shows that ordinary `ell`-primary Hecke congruence modules cannot supply this
map.  A candidate must contain a new `p`-primary correspondence, not a
relabeling of `ell`-adic length.

## 10. Lean boundary

`IUTThreeClosures/ArakelovCongruenceDegreeBarrier.lean` formalizes:

1. the finite-profile excess carrier and exact radical-times-excess identity;
2. exact total-weight equals radical-weight plus excess-weight accounting;
3. `log` of the excess carrier equals its `sum (e_i-1) log b_i` degree;
4. specialization to `n/rad(n)`;
5. for `n != 0`, the genuine finite module `ZMod (n/rad(n))`, its cardinality,
   finiteness, and its arithmetic degree;
6. the exact equivalence (4.2), without assuming either side;
7. unbounded excess at fixed radical;
8. comaximality of distinct vertical prime powers;
9. the fixed-depth/arbitrarily-large-support carrier countermodel.

It does not formalize the identification with a Tate deformation module,
Fitting ideals, the moduli-stack identity, Deligne pairings, Hecke algebras,
modular degrees, Szpiro, or abc.  None of those statements appears as an
assumption or structure field.
