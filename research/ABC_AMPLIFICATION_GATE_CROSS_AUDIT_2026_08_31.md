# Cross-audit of the affine amplification gate

Author: ChatGPT. Date: 2026-08-31.

## 0. Scope and verdict

This note independently audits Theorem 2.2 through Corollary 4.2 of
`research/ABC_AMPLIFICATION_GATE_ATTACK_2026_08_31.md`, at final source SHA256
`fa730ca4e3166ba9823e4edbbed9783384f92dcea345cb5a086731081baf81ba`.
The audit checks the
primitive shear, both parameter-box counts in Lemma 2.3, every height and
radical exponent, the uniform use of de Bruijn's estimate, and all strict
inequalities used in the BBLT closing step.

The main conclusions are:

1. Theorem 2.2, Lemma 2.3, Corollary 2.4, Theorem 3.1, Theorem 4.1, and
   Corollary 4.2 are mathematically valid.
2. Corollary 3.2 is also valid, including its displayed constant `8192`.
   The final source now explicitly rewrites the threshold as
   `R*UVW*H^(-3/4)`.  After that rewrite, the upper bound `H<c^8` has exactly
   the required direction; the earlier exposition issue is resolved.
3. The de Bruijn application in Theorem 4.1 is uniform in the seed.  A
   finite-mesh proof works because the varying exponent stays in the fixed
   compact interval `[5/21,2/7]` after all three factors are placed below
   `c^7`.  The final source already states the finite-mesh principle in
   Section 1.2; writing the interval explicitly in Theorem 4.1 would improve
   transparency but is not needed for validity.
4. The number `14/3` is not an upper bound for every seed's exceptional
   fibre.  It is the lower envelope of the *available upper-budget
   exponent* over the relaxed worst-shape region `rho<=3`, `sigma<1`.
   At the level of pure exponent compatibility, `4<beta<=14/3` remains
   unexcluded; the strict upper endpoint gives a fixed worst-shape power
   margin.  For a fixed locus `R<c^lambda`, the corresponding relaxed lower envelope is the
   larger number `5-lambda/3`.  No argument here proves that actual seeds
   realize either boundary shape.

No lower bound for the actual exceptional fibre is proved by these
calculations, so the report remains a conditional positive route rather
than a proof of abc.

## 1. Parameter ranges used throughout

For a primitive positive seed `a+b=c`, the three seed coordinates are
pairwise coprime.  With

\[
 P=abc,\qquad R=\operatorname{rad}(P),\qquad
 \rho=\frac{\log P}{\log c},\qquad
 \sigma=\frac{\log R}{\log c},
\]

one has the exact bounds

\[
 c(c-1)\leq P\leq \frac{c^3}{4}.                            \tag{1.1}
\]

In particular, for `c>1`,

\[
 \rho\leq 3-\frac{\log 4}{\log c}<3.                       \tag{1.2}
\]

On a fixed subcritical locus `R<c^lambda`, where `0<lambda<1`,

\[
 0\leq\sigma<\lambda<1.                                    \tag{1.3}
\]

It is useful to retain (1.2), rather than write only `rho<=3+o(1)`, because
it identifies the direction and strictness of every exponent comparison in
Section 4.

## 2. Audit of the affine shear

### 2.1 Theorem 2.2: equation, primitivity, and injectivity

Set

\[
 U=1+Ph,\qquad V=1+P(h+ck),\qquad W=1+P(h+bk),               \tag{2.1}
\]

where `h,k>=1`.  Then `V=U+cPk` and `W=U+bPk`; Theorem 2.1
therefore gives

\[
 aU+bV=cW.                                                   \tag{2.2}
\]

Every cofactor is congruent to `1 mod P`, so

\[
 \gcd(UVW,P)=1.                                              \tag{2.3}
\]

Assume `gcd(U,k)=1`.  If `d` divides `U` and `V`, then `d`
divides `cPk`.  By (2.3), `gcd(d,cP)=1`, hence `d|k`, and
therefore `d=1`.  The same proof gives `gcd(U,W)=1`.  If `d`
divides `V` and `W`, then `d|aPk`; again (2.3) gives
`gcd(d,aP)=1`, so `d|k`.  Since `V` is congruent to `U mod k`,
this implies `d|U`, and `gcd(U,k)=1` again gives `d=1`.

The seed coordinates are pairwise coprime; (2.3) removes all cross-gcds
between a seed coordinate and a new cofactor; and the preceding paragraph
removes gcds among the cofactors.  Thus `aU,bV,cW` are pairwise coprime.

For a fixed seed, the ordered target recovers

\[
 U=A/a,\qquad h=(U-1)/P,\qquad k=(V-U)/(cP),                 \tag{2.4}
\]

so the map from `(h,k)` is injective.  Positivity is immediate.  All parts
of Theorem 2.2 are valid.

### 2.2 Lemma 2.3: the full box

If `(h,k)` is bad, some prime `ell` divides both `1+Ph` and
`k`.  Necessarily `ell` does not divide `P`, and `ell<=k<=M`.
For each such prime, the congruence

\[
 Ph\equiv-1\pmod\ell                                      \tag{2.5}
\]

selects one residue class of `h mod ell`.  Hence its contribution is at
most

\[
 \left\lfloor\frac M\ell\right\rfloor
 \left(\frac M\ell+1\right)
 \leq \frac{M^2}{\ell^2}+\frac M\ell.                      \tag{2.6}
\]

The union bound is legitimate even though a bad pair may be counted more
than once.  Moreover,

\[
 \sum_{\ell\ {\rm prime}}\frac1{\ell^2}
 \leq\sum_{n=2}^{\infty}\frac1{n^2}\leq\frac34,
 \qquad
 \sum_{\ell\leq M}\frac1\ell
 \leq\sum_{n=2}^{M}\frac1n\leq\log M.                     \tag{2.7}
\]

Thus the number of bad pairs is at most
`3M^2/4+M log M`, and at most `7M^2/8` for all sufficiently
large `M`.  The asserted lower bound `M^2/8` follows uniformly in `P`.

### 2.3 Lemma 2.3: the upper box

Let

\[
 I=\{\lceil M/2\rceil,\ldots,M\},\qquad L=|I|\geq M/2.      \tag{2.8}
\]

An interval of length `L` contains at most `L/ell+1` members of any fixed
residue class modulo `ell`.  Consequently the union bound gives

\[
 \#\{\text{bad pairs in }I^2\}
 \leq L^2\sum_{\ell\leq M}\frac1{\ell^2}
      +2L\sum_{\ell\leq M}\frac1\ell+\pi(M)
 \leq\frac{3L^2}{4}+2L\log M+\pi(M).                       \tag{2.9}
\]

Since `L>=M/2`, the last two terms are `o(L^2)`; in particular they are at
most `L^2/8` for all sufficiently large `M`.  Thus at least

\[
 \frac{L^2}{8}\geq\frac{M^2}{32}                           \tag{2.10}
\]

upper-box pairs are admissible.  No dependence on the prime divisors of
`P` is hidden here: including all primes in (2.7) and (2.9) only enlarges
the upper bound for bad pairs.

### 2.4 Corollary 2.4: height and raw count

For fixed `K>5`, let

\[
 M=\left\lfloor\frac{c^{K-2}}{4P}\right\rfloor.             \tag{2.11}
\]

Because `h,k<=M` and `b+1<=c`,

\[
 H=cW\leq c+cPM(1+b)\leq c+\frac{c^K}{4}<c^K              \tag{2.12}
\]

for all sufficiently large `c`.  Also, by the upper bound in (1.1),

\[
 \frac{c^{K-2}}{4P}\geq c^{K-5}.                            \tag{2.13}
\]

The quantity on the left tends to infinity uniformly in the seed, so its
floor is at least `c^(K-5)/2` once `c` is large.  Lemma 2.3 therefore gives
at least

\[
 \frac18\left(\frac{c^{K-5}}2\right)^2
 =\frac1{32}c^{2K-10}                                      \tag{2.14}
\]

distinct outputs.  For `K=8` this is `c^6/32`.  Seed by seed,
`M` is asymptotic to `c^(6-rho)/4`, uniformly up to a relative error
`O(c^(-3))`, so the logarithmic raw exponent is

\[
 12-2\rho+o(1).                                             \tag{2.15}
\]

All exponent directions in Corollary 2.4 are correct.

## 3. Audit of the actual-radical obstruction

### 3.1 Theorem 3.1

The factors `U,V,W` are pairwise coprime and avoid `P`, so

\[
 \operatorname{rad}(aUbVcW)
 =R\operatorname{rad}(UVW)
 =\frac{RUVW}{E(U)E(V)E(W)}.                                \tag{3.1}
\]

Since `H=cW`, the strict inequality

\[
 \frac{RUVW}{E(U)E(V)E(W)}<H^\mu                            \tag{3.2}
\]

is equivalent, without loss at an endpoint, to

\[
 E(U)E(V)E(W)>\frac Rc\,UVH^{1-\mu}.                        \tag{3.3}
\]

Here `U=1+Ph>P` and
`V=1+P(h+ck)>Pc`; hence the right-hand side of (3.3) is strictly
larger than `RP^2H^(1-mu)`.  The direction of (3.5) in the source report is
correct.

The inherited-size no-go is also correct.  From

\[
 RUVW\leq(cW)^\mu,\qquad 0<\mu\leq1,
\]

one gets

\[
 RUV\leq c^\mu W^{\mu-1}\leq c^\mu,
\]

and hence `UV<=c^mu<=c`; but (1.1) gives `P>=c` and therefore
`U=1+Ph>c`.

### 3.2 Corollary 3.2: algebraic expansion now present in the final source

The conclusion

\[
 E(U)E(V)E(W)>\frac{R}{8192}c^{14}                          \tag{3.4}
\]

is correct.  The two estimates quoted in the source proof do imply it, but
only after using `H=cW` to expose the direction of the height power.  Namely,
for `mu=3/4`,

\[
 \frac Rc\,UVH^{1/4}
 =\frac Rc\,\frac{UVW}{W}H^{1/4}
 =R\,UVW\,H^{-3/4}.                                         \tag{3.5}
\]

The upper-half-box bounds in the source report give

\[
 UVW\geq\frac{c^{20}}{8192},\qquad H<c^8.                   \tag{3.6}
\]

The second inequality now has the required direction:

\[
 H^{-3/4}>c^{-6}.                                            \tag{3.7}
\]

Substitution into the strict criterion (3.3) yields

\[
 E(U)E(V)E(W)>R\,UVW\,H^{-3/4}
 >\frac{R c^{14}}{8192}.                                    \tag{3.8}
\]

Thus there is no mathematical direction error in Corollary 3.2.  The final
source now includes the identity (3.5), so it no longer invites the incorrect
reading that `H<c^8` is being used directly to lower-bound `H^(1/4)`.  An
independent alternative proof is obtained from
`U>=c^6/16`, `V>=c^7/16`, and `H>=c^8/32`; it gives the stronger constant
`1/(256*32^(1/4))`.

For every prime exponent `e>=1`,

\[
 2\lfloor e/2\rfloor\geq e-1.                               \tag{3.9}
\]

Thus `Q(UVW)^2|UVW` and `Q(UVW)^2>=E(UVW)`.  Pairwise
coprimality gives `E(UVW)=E(U)E(V)E(W)`, so (3.4) implies

\[
 Q(UVW)>\frac{R^{1/2}c^7}{\sqrt{8192}}.                     \tag{3.10}
\]

Finally, `P>=c(c-1)` gives `M<<c^4`.  The large-square-divisor
localization is therefore valid after the algebraic expansion.

## 4. Audit of the one-factor low-radical bound

### 4.1 Strict radical pigeonhole

For an exceptional output, `H<c^8` and

\[
 R\operatorname{rad}(UVW)<H^{3/4}<c^6.                      \tag{4.1}
\]

Therefore, with

\[
 D=\operatorname{rad}(UVW),\qquad
 Z=(c^6/R)^{1/3},                                           \tag{4.2}
\]

one has the strict inequality `D<Z^3`.  Since `U,V,W` are pairwise
coprime,

\[
 D=\operatorname{rad}(U)\operatorname{rad}(V)
   \operatorname{rad}(W).                                  \tag{4.3}
\]

If all three radicals were at least `Z`, their product would be at least
`Z^3`.  Hence at least one factor has radical strictly below `Z`.  The
strict inequality is preserved correctly.

### 4.2 Uniform de Bruijn estimate

For `K=8`, `PM<=c^6/4`.  Directly from (2.1), for `c>=2`, all three
factors are less than `c^7`; in particular,

\[
 U<c^7,\qquad V<c^7,\qquad W<c^7.                            \tag{4.4}
\]

Write `X=c^7` and

\[
 \alpha=\frac{\log Z}{\log X}
       =\frac{2-\sigma/3}{7}.                               \tag{4.5}
\]

On every subcritical seed, `0<=sigma<1`, so

\[
 \frac5{21}<\alpha\leq\frac27.                             \tag{4.6}
\]

This is a fixed compact interval after adjoining its lower endpoint.  To
make uniformity explicit, fix a desired final loss `eta>0`, cover
`[5/21,2/7]` by finitely many right-endpoint mesh values of spacing at most
`eta/14`, and apply de Bruijn at each mesh value with exponent loss
`eta/14`.  For the first mesh value `alpha_j>=alpha`, monotonicity gives

\[
 \begin{aligned}
 \#\{n\leq X:\operatorname{rad}(n)<X^\alpha\}
 &\leq \#\{n\leq X:\operatorname{rad}(n)\leq X^{\alpha_j}\}\\
 &\ll_\eta X^{\alpha_j+\eta/14}
 \leq X^{\alpha+\eta/7}
 =c^{2-\sigma/3+\eta}.
 \end{aligned}                                               \tag{4.7}
\]

The maximum of finitely many de Bruijn constants is independent of the
seed.  Thus (4.4) of the source report is uniform as claimed.  The report's
one-sentence mesh reference is mathematically adequate, but the explicit
compact interval and loss calculation should be included because uniformity
is the central issue of this route.

### 4.3 Representation multiplicities and exponent

For fixed `U`, the integer `h=(U-1)/P` is unique, leaving at most `M`
choices of `k`.  For fixed `V`, the value

\[
 T=(V-1)/P=h+ck                                             \tag{4.8}
\]

is fixed; as `k` varies, the interval restriction on `h=T-ck` gives at
most `M/c+1` representations.  Similarly, a fixed `W` has at most
`M/b+1<=2M/c+1` representations.  Since `M` tends to infinity much faster
than `c` here, the `U` multiplicity `M` dominates all three cases.

Because

\[
 M\leq\frac{c^6}{4P}=\frac14c^{6-\rho},                     \tag{4.9}
\]

the union of the three alternatives in (4.3), together with (4.7), gives

\[
 |E_c|\ll_\eta c^{2-\sigma/3+\eta}c^{6-\rho}
 =c^{8-\rho-\sigma/3+\eta}.                                \tag{4.10}
\]

Theorem 4.1 and every exponent direction in its proof are correct.

## 5. Audit of the three-way exponent ledger

The three available upper bounds are:

\[
 \begin{array}{c|c}
 \text{source of the upper bound}&\text{exponent}\\
 \hline
 \text{whole parameter fibre}&12-2\rho\\
 \text{actual-support bound with }Y=c^6&6-\sigma\\
 \text{one-factor de Bruijn bound}&8-\rho-\sigma/3
 \end{array}                                                \tag{5.1}
\]

For the middle row, every target contains the inherited support `R`, and
the strict inequality in (4.1) permits the non-strict counting cutoff
`Y=c^6`.  The factor `45^omega(R)` and the logarithm in the actual-support
theorem are `c^eta` uniformly, so the exponent is indeed `6-sigma+eta`.

Therefore the mathematical content of (4.5) is

\[
 |E_c|\ll_\eta
 c^{\min\{12-2\rho,\ 6-\sigma,\ 8-\rho-\sigma/3\}+\eta}.    \tag{5.2}
\]

The source display contains stray commas immediately after `min\{` and
before `\}`.  They should be removed; this is a TeX/editorial defect, not
an exponent error.

### 5.1 The exact role of `14/3`

Under only the relaxed inequalities

\[
 \rho<3,\qquad 0\leq\sigma<1,                               \tag{5.3}
\]

the three exponent expressions satisfy

\[
 12-2\rho>6,\qquad 6-\sigma>5,
 \qquad 8-\rho-\sigma/3>14/3.                              \tag{5.4}
\]

All three therefore lie above the BBLT threshold `4`.  The last expression
has lower envelope `14/3` on the closure of the relaxed rectangle, at the
formal corner `(rho,sigma)=(3,1)`.  This says only that the currently known
upper bounds do not obstruct asking for a uniform lower exponent in

\[
                         4<\beta\leq14/3.                    \tag{5.5}
\]

The endpoint is unexcluded because an upper estimate with exponent
`14/3+eta` is compatible with a lower estimate of order `c^(14/3)`.
Using the open interval `4<beta<14/3`, as the source report currently does,
is a safe conservative formulation.

The following interpretations would be invalid and must not appear in the
source report or a route ledger:

* (5.2) does **not** imply `|E_c|<<c^(14/3+eta)` for every seed.  Its
  exponent can be larger than `14/3`, and a larger upper exponent is a
  weaker upper bound.
* No construction here proves `|E_c|` has exponent at most, at least, or
  exactly `14/3`.
* The formal corner `(3,1)` need not be realized by an unbounded family of
  actual primitive abc seeds.  The value `14/3` comes from a relaxed
  worst-shape comparison, not an existence theorem about seeds.

For a fixed source locus `R<c^lambda`, one can state the sharper relaxed
comparison.  From `sigma<lambda<1`,

\[
 \begin{aligned}
 12-2\rho&>6,\\
 6-\sigma&>6-\lambda,\\
 8-\rho-\sigma/3&>5-\lambda/3.
 \end{aligned}                                               \tag{5.6}
\]

Since, for `0<lambda<1`,

\[
 5-\lambda/3<6-\lambda<6,                                  \tag{5.7}
\]

the fixed-locus relaxed lower envelope is `5-lambda/3`, not `14/3`.
Thus

\[
                     4<\beta\leq5-\lambda/3                 \tag{5.8}
\]

is unexcluded for that fixed locus by the present ledger.  The target
`beta=17/4` lies strictly below `14/3` and is therefore safe uniformly as
`lambda` ranges below `1`.

### 5.2 The `K=7` comparison

At general target height exponent `K`, the one-factor argument contributes

\[
 K-2-\rho+\frac{K\mu-\sigma}{3}.                            \tag{5.9}
\]

For `K=7` and `mu=3/4`, this is

\[
 \frac{27}{4}-\rho-\frac\sigma3.                            \tag{5.10}
\]

It exceeds the BBLT threshold `K/2=7/2` precisely when

\[
 \rho+\frac\sigma3<\frac{13}{4}.                            \tag{5.11}
\]

The strict direction in (4.8) of the source report is correct.

## 6. Audit of Corollary 4.2

Every member of `E_c` is distinct by Theorem 2.2.  Its largest coordinate
is `H=cW<c^8`, because its two positive summands add to `H`, and its radical
satisfies the strict BBLT condition

\[
 \operatorname{rad}(aUbVcW)<H^{3/4}.                        \tag{6.1}
\]

The BBLT estimate with `X=c^8`, `mu=3/4`, and `F(3/4)=1/2` gives

\[
 |E_c|\ll_\delta(c^8)^{1/2+\delta}
 =c^{4+8\delta}.                                            \tag{6.2}
\]

Here `1/2=2mu/3` is the exponent in BBLT Proposition 1.1.  BBLT Theorem
1.3 supplies the alternative exponent `3/5`, which is weaker at
`mu=3/4`; taking the minimum therefore leaves `F(3/4)=1/2`.

With `delta=1/64`,

\[
 4+8\delta=\frac{33}{8}<\frac{17}{4}.                      \tag{6.3}
\]

Thus a hypothetical lower bound `|E_c|>=c^(17/4)` for every sufficiently
large seed in a fixed source locus contradicts (6.2) once `c` exceeds a
constant.  The lower threshold is allowed to depend on `lambda`, and the
BBLT constant depends only on the fixed analytic parameters.  Corollary
4.2 is correct, including its strict exponent comparison and its bounded-
height conclusion.

## 7. Status against the final source and remaining issues

The final source file has SHA256
`fa730ca4e3166ba9823e4edbbed9783384f92dcea345cb5a086731081baf81ba`.
The upper-box count now uses `L=|I|`, and the malformed commas in (4.5) have
been removed.  The Corollary 3.2 identity discussed in Section 3.2 is now
displayed as well.  Those three issues are resolved.

No theorem-level mathematical error remains in Theorems 2.2--4.2.  One
wording issue remains:

1. The final source correctly says that (4.6) is not a per-seed upper bound.
   The preceding phrase "the infimum ... over the allowed parameter region"
   should still be read, and ideally written, as the infimum over the
   *relaxed rectangle supplied only by* `rho<3` and `sigma<1`.  Actual
   subcritical seeds approaching `(3,1)` have not been constructed.  Thus
   `14/3` is a robust worst-shape lower envelope of the budget exponents,
   not an attained infimum theorem about the actual seed set.

The generic finite-mesh statement in Section 1.2 is enough to make Theorem
4.1 uniform.  Adding the explicit interval `alpha in [5/21,2/7]` would be a
journal-level clarity improvement, not a missing hypothesis or mathematical
repair.

The endpoint convention also deserves precision.  At the level of mere
compatibility with upper bounds of the form `c^(B+epsilon)`, `beta=14/3` is
not excluded.  If "safe window" means a target retaining a fixed positive
power gap from the relaxed worst-shape budget as `lambda` tends to `1`, the
strict form `4<beta<14/3` used in (4.6) is the correct formulation.  In both
readings this is only a worst-shape target window, never a uniform upper
bound for each seed.

## 8. Conclusions that may be retained unchanged

With the interpretation above and the algebraic expansion now in the final
source, the following claims are rigorous and may remain in the route ledger.

1. The affine shear is positive, primitive, pairwise coprime, and
   injective for every admissible pair `gcd(1+Ph,k)=1`.
2. Both the full box and the upper half box contain a positive absolute
   proportion of admissible pairs, uniformly in the seed.
3. At `K=8`, the raw fibre contains at least `c^6/32` distinct primitive
   targets of height below `c^8`.
4. The low-radical condition is exactly the strict excess inequality
   (3.3), and the inherited-size certificate gives no nontrivial member.
5. Every upper-half-box exceptional target has repeated-prime excess
   greater than `R c^14/8192` and hence a square-root divisor
   `Q(UVW)>>R^(1/2)c^7`.
6. The exceptional fibre obeys the uniform three-way upper ledger (5.2).
7. The ledger leaves a universal worst-shape target window above the BBLT
   threshold; `beta=17/4` is safely inside it.
8. Assuming the actual lower bound `|E_c|>=c^(17/4)` uniformly on each
   fixed subcritical locus, BBLT forces that locus to have bounded height.

Difficulty in proving the missing lower bound is not a no-go theorem.  The
affine route remains open, and none of the audited upper bounds licenses
discarding it.
