# Attacking the single-source amplification gate for abc

Author: ChatGPT. Date: 2026-08-31.

## 0. Status and scope

The standard abc conjecture remains open.  This report does not claim an
unconditional proof or a counterexample.  It attacks one precise positive
gate from `ABC_SUBCRITICAL_LOCUS_UNIFORMITY_2026_08_31.md`: construct, from
each point in a fixed subcritical radical locus, a sufficiently large fibre
of **distinct actual** low-radical abc points.

The main new construction below is a two-parameter affine shear.  It gives a
uniform primitive fibre of size at least a constant times `c^6` at target
height `c^8`; thus its raw exponents are

\[
                         \kappa=8,\qquad \beta_{\rm raw}=6.       \tag{0.1}
\]

At target radical exponent `mu=3/4`, the Bernert--Browning--Lichtman--
Teravainen bound has exponent `theta=1/2`, so the counting threshold is
`kappa theta=4`.  A lower bound `c^(17/4)` for the actual exceptional part
of this fibre would therefore close the single-source gate.

No such lower bound is proved here.  Instead, the report proves:

1. the complete primitive and injective affine-shear construction;
2. the exact repeated-prime excess which an actual exceptional output must
   have;
3. a new three-way unconditional upper budget for its exceptional part;
4. a fixed-support and large-square-divisor localization of the remaining
   problem;
5. two separate no-go theorems for natural fixed-full and odd-power
   thickenings; and
6. the exact effect of the new Pell adjacent-factor slope `1/2` on both the
   affine and conic gates.

Every use of an external theorem is identified.  No unproved distribution
statement is treated as an axiom.

## 1. Audited counting inputs

Throughout, let

\[
 a,b,c\in\mathbb N,\qquad a+b=c,\qquad \gcd(a,b)=1,            \tag{1.1}
\]

and put

\[
 P=abc,\qquad R=\operatorname{rad}(P),\qquad
 \rho={\log P\over\log c},\qquad
 \sigma={\log R\over\log c}.                                 \tag{1.2}
\]

After interchanging `a,b`, when useful, assume `b>=a`, so `b>=c/2`.
The elementary bounds

\[
 c(c-1)\le P\le {c^3\over4}                                  \tag{1.3}
\]

follow from `ab=a(c-a)`, whose minimum and maximum on the integer interval
`1<=a<=c-1` are `c-1` and at most `c^2/4`, respectively.  Thus, along an
unbounded family, `2+o(1)<=rho<=3+o(1)`.

### 1.1 The BBLT exceptional-set theorem

Bernert--Browning--Lichtman--Teravainen count ordered positive primitive
triples in the box `[1,X]^3`, equivalently abc points with output height
`c<=X`.  Combining their Proposition 1.1 and Theorems 1.2--1.3 gives, for
fixed `0<mu<1` and every `delta>0`,

\[
 N_\mu(X)\ll_{\mu,\delta} X^{F(\mu)+\delta},\qquad
 F(\mu)=\min\left\{{2\mu\over3},{23\mu+3\over40},{3\over5}\right\}.
                                                                    \tag{1.4}
\]

In particular,

\[
                              F(3/4)=1/2.                    \tag{1.5}
\]

The local primary source is
`research/sources/analytic_2026_08_30/BBLT_2410.12234v2.pdf`,
12 PDF pages, SHA256
`ee57b904398692ffecd0ccf8ccdcb0641f8e63ba6b971d6c9343bbac60d53470`.
The definition is on PDF p.1 and the three estimates are on PDF p.2.

### 1.2 Actual support with prescribed inherited support

The already audited theorem in
`ANALYTIC_ACTUAL_RADICAL_UNIFORM_GATE_2026_08_30.md`, obtained from the
Hirata-Kohno--Kawashima--Poels--Washio S-unit theorem, says that for
squarefree integers `R>=1` and real `Y>=R`, the number of all ordered
positive primitive abc points satisfying

\[
                 R\mid\operatorname{rad}(ABC),\qquad
                 \operatorname{rad}(ABC)\le Y
\]

is at most

\[
       905\,45^{\omega(R)}{Y\over R}
       \left(1+\log {Y\over R}\right)^{44}.                  \tag{1.6}
\]

The constant includes the archimedean place.  At fixed polynomial height
`c^K`, fixed `mu`, and `R=c^sigma`, this is

\[
                           \ll_\epsilon c^{K\mu-\sigma+\epsilon},
                                                                    \tag{1.7}
\]

with a constant independent of the seed.  The source PDF is
`research/sources/uniform_gate_2026_08_30/`
`HirataKohno_Kawashima_Poels_Washio_2211.14399v1.pdf`,
SHA256
`8f7fa1d49637498f5e3ad298981a822f6f6b1911f6570b7781d4d3cab9915cae`;
its Theorem 1.1 is on PDF p.1.

We also use the classical de Bruijn consequence quoted as (1.1) on BBLT
PDF pp.1--2:

\[
 \#\{n\le X:\operatorname{rad}(n)\le X^\alpha\}
       \ll_{\alpha,\epsilon}X^{\alpha+\epsilon}               \tag{1.8}
\]

for fixed `alpha>0`.  Whenever an exponent below varies in a fixed compact
interval, a finite epsilon-mesh and monotonicity reduce it to finitely many
fixed instances of (1.8).  Thus no constant is allowed to depend on the
individual seed.

### 1.3 Browning--Verzobio and the old CRT/conic barriers

Browning--Verzobio count positive primitive targets whose three **actual
coordinates** are respectively `p,q,r`-full.  Their Corollary 4.4 gives an
upper exponent

\[
                    \Theta_{p,q,r}={1\over p}+{1\over q}
                                      -\eta(p,q,r)             \tag{1.9}
\]

for fixed `p>=q>=r>=2`, with the exact piecewise `eta` recorded in
`ABC_MIXED_FULL_CAMPANA_GATE_2026_08_31.md`.  Their Theorem 1.2 is uniform
in the three nonzero coefficients of one fixed generalized Fermat surface,
but it neither sums coefficient choices nor creates an amplification fibre.
The fixed-degree hypotheses cannot be used with a degree growing with the
seed.  The primary PDF is
`research/sources/powerful_sums_2026_08_31/`
`Browning_Verzobio_Sums_Three_Powerful_arXiv2608.24512v1.pdf`,
18 PDF pages, SHA256
`1ff50f5b0b66a4c0750aae03ae54f8a67bf451b05d9a386dbc6f5851855e04c9`;
the definitions and main statements are on PDF pp.1--3 and Corollary 4.4 is
on PDF pp.15--17.

The previous CRT audit proves only `c^o(1)` certified outputs at fixed
polynomial height.  The complete integer conic fibre has size

\[
       \le\tau(P)\left(1+4\pi\sqrt{T/P}\right),               \tag{1.10}
\]

and its actual-radical capacity can cross BBLT only in the necessary window

\[
 K>\rho+4\sigma,\qquad
 {3\sigma\over K}<\mu<{3\over4}\left(1-{\rho\over K}\right).
                                                                    \tag{1.11}
\]

These are upper-capacity statements, not exceptional-output lower bounds.

## 2. A complete two-parameter primitive shear

### Theorem 2.1 (all coordinatewise-multiple solutions)

Suppose a target has the form

\[
                         (A,B,C)=(aU,bV,cW).                  \tag{2.1}
\]

Then `A+B=C` if and only if there is an integer `t` such that

\[
                         V=U+ct,\qquad W=U+bt.                \tag{2.2}
\]

**Proof.**  The target equation and `a+b=c` give

\[
                         a(U-W)+b(V-W)=0.
\]

As `gcd(a,b)=1`, divisibility gives `b|(U-W)` and `a|(V-W)`.
Thus `U-W=-bt` and `V-W=at` for some integer `t`, which is exactly
(2.2).  Conversely,

\[
 aU+b(U+ct)=cU+bct=c(U+bt).
\]

This proves both directions.  \(\square\)

### Theorem 2.2 (the primitive affine fibre)

Let `h,k>=1` and define

\[
 \begin{aligned}
 U&=1+Ph, & t&=Pk,\\
 V&=1+P(h+ck),& W&=1+P(h+bk).                                \tag{2.3}
 \end{aligned}
\]

If `gcd(U,k)=1`, then

\[
                             (aU,bV,cW)                       \tag{2.4}
\]

is a positive, pairwise-coprime abc point.  Different pairs `(h,k)` give
different ordered targets.

**Proof.**  The equation follows from Theorem 2.1.  All three cofactors are
`1 mod P`, hence are coprime to `P`.  Moreover

\[
 V-U=cPk,\qquad W-U=bPk,\qquad V-W=aPk.                       \tag{2.5}
\]

A common divisor of `U,V` divides `cPk`; it is coprime to `cP`, and then
divides `k`, contradicting `gcd(U,k)=1`.  The same proof gives
`gcd(U,W)=1`.  A common divisor of `V,W` divides `aPk`; it is coprime to
`aP`, while `V` is congruent to `U mod k`, so it is also coprime to `k`.
Thus `U,V,W` are pairwise coprime.

The seed coordinates are pairwise coprime, the new cofactors avoid `P`, and
the cofactors are pairwise coprime.  Hence the three products in (2.4) are
pairwise coprime.  Finally, `A/a=U` recovers `h`, and
`V-U=cPk` then recovers `k`; the map is injective.  \(\square\)

### Lemma 2.3 (uniform number of admissible parameters)

For all sufficiently large `M`,

\[
 \#\{1\le h,k\le M:\gcd(1+Ph,k)=1\}\ge {M^2\over8}.          \tag{2.6}
\]

The same set restricted to `M/2<=h,k<=M` has size at least a positive
absolute constant times `M^2`.

**Proof.**  A bad pair has a prime `ell` dividing both `1+Ph` and `k`.
Such a prime does not divide `P`.  For each `ell<=M`, at most `M/ell`
choices of `k` are divisible by `ell`, and at most `M/ell+1` choices of
`h` solve the one residue class modulo `ell`.  Hence

\[
 \#\{\text{bad pairs}\}
 \le M^2\sum_{\substack{\ell\le M\\ \ell\text{ prime}}}{1\over\ell^2}
       +M\sum_{2\le n\le M}{1\over n}
 \le {3M^2\over4}+M\log M.                                  \tag{2.7}
\]

Here
`sum_(n>=2)n^(-2)<=1/4+integral_2^infinity x^(-2)dx=3/4`.
For large `M`, `M log M<=M^2/8`, proving (2.6).  For the upper square, let
`I=[ceil(M/2),M]` and `L=|I|>=M/2`.  For each prime `ell<=M`, the number of
bad pairs in `I^2` charged to `ell` is at most `(L/ell+1)^2`.  Hence

\[
 \#\{\text{bad pairs in }I^2\}
 \le {3L^2\over4}+2L\log M+\pi(M).                           \tag{2.8}
\]

For all sufficiently large `M`, the last two terms are at most `L^2/8`.
Thus at least `L^2/8>=M^2/32` pairs in the upper square are admissible.
\(\square\)

### Corollary 2.4 (height and raw exponents)

For a fixed real `K>5`, put

\[
                         M_K=\left\lfloor {c^{K-2}\over4P}\right\rfloor.
                                                                    \tag{2.9}
\]

For all sufficiently large `c`, the construction gives

\[
              \gg M_K^2\gg c^{2K-10}                              \tag{2.10}
\]

distinct primitive outputs of height at most `c^K`.

**Proof.**  Since `b+1<=c`,

\[
 cW\le c+cPM_K(1+b)\le c+{c^K\over4}<c^K.                  \tag{2.11}
\]

Also `P<=c^3/4`, so `c^(K-2)/(4P)>=c^(K-5)` and its floor is at least half
that quantity for large `c`.  Lemma 2.3 and injectivity finish the proof.
\(\square\)

The integer choice `K=8` yields at least `c^6/32` outputs after enlarging
the fixed lower threshold for `c`.  Seed by seed, (1.2) gives the sharper
raw exponent

\[
                          \beta_{\rm raw}=12-2\rho+o(1).      \tag{2.12}
\]

The choice `K=7` already crosses BBLT at `mu=3/4` at the raw level, but
Section 4 shows why `K=8` is the clean uniform choice after charging actual
radicals.

## 3. The exact actual-radical obstruction

For a positive integer `n`, define its repeated-prime excess

\[
                              E(n)={n\over\operatorname{rad}(n)}.    \tag{3.1}
\]

### Theorem 3.1 (exact excess identity and criterion)

For every output in Theorem 2.2,

\[
 \operatorname{rad}(aUbVcW)
   =R\operatorname{rad}(UVW)
   ={RUVW\over E(U)E(V)E(W)}.                                \tag{3.2}
\]

Writing `H=cW`, the strict target condition

\[
                         \operatorname{rad}(aUbVcW)<H^\mu    \tag{3.3}
\]

is equivalent to

\[
 E(U)E(V)E(W)>{R\over c}\,UVH^{1-\mu}.                      \tag{3.4}
\]

In particular, because `U>P` and `V>Pc`, it implies

\[
                         E(U)E(V)E(W)>RP^2H^{1-\mu}.          \tag{3.5}
\]

**Proof.**  Theorem 2.2 says that `U,V,W` are pairwise coprime and avoid
`P`; radical multiplicativity gives (3.2).  Substitution into (3.3),
followed by multiplication by the positive excess, is exactly (3.4).
The inequalities in (3.5) follow directly from (2.3).  \(\square\)

There is no nonempty inherited-size subfibre hidden here.  Indeed, the
stronger certificate `RUVW<=(cW)^mu` for any `0<mu<=1` would give
`UV<=c^mu<=c`, whereas `U=1+Ph>c` because `P>=c`.  Thus **zero** nontrivial
members are certified by merely carrying the old powers through the shear.
All possible success lies in actual repeated powers of the new affine
factors.

### Corollary 3.2 (large-square-divisor localization at `K=8`)

Restrict to the upper half parameter box `M/2<=h,k<=M`, take `K=8`, and
orient the seed so `b>=c/2`.  Every `mu=3/4` exceptional output satisfies

\[
                         E(U)E(V)E(W)> {R\over8192}c^{14}      \tag{3.6}
\]

for all sufficiently large `c`.

If

\[
 Q(n)=\prod_p p^{\lfloor v_p(n)/2\rfloor},                  \tag{3.7}
\]

then `Q(UVW)^2|UVW`, `Q(UVW)^2>=E(UVW)`, and hence

\[
                         Q(UVW)\gg R^{1/2}c^7.                \tag{3.8}
\]

At the same time `M<<c^4`.  Thus every exceptional point is in a
large-square-divisor tail whose square-root modulus is much larger than the
entire parameter box.

**Proof.**  On the upper half box,

\[
 U\ge {PM\over2},\quad V\ge {cPM\over2},\quad
 W\ge {bPM\over2}\ge {cPM\over4},                           \tag{3.9}
\]

so `UVW>=P^3M^3c^2/16`.  From (2.9), for large `c`,
`M>=c^6/(8P)`, and therefore `UVW>=c^20/8192`.  Also `H<c^8`.
Because `H=cW`, the right side of (3.4) at `mu=3/4` is exactly

\[
 {R\over c}UVH^{1/4}={RUVW\over H^{3/4}}.
\]

The lower bound for `UVW` and the upper bound `H<c^8` therefore give (3.6).

For a prime exponent `e>=1`, one has
`2 floor(e/2)>=e-1`; multiplying prime by prime proves the two assertions
about `Q`.  Equation (3.8) follows from (3.6).  Finally (1.3) gives
`P>=c(c-1)` and hence `M<<c^4`.  \(\square\)

This is the precise obstruction faced by a squarefree sieve or a second
moment: their easy small-modulus range does not meet the required tail.

## 4. A new unconditional three-way budget

Let `E_c` be the subset of the `K=8` affine fibre satisfying (3.3) with
`mu=3/4`.  Thus `H<c^8` and

\[
                  D:=\operatorname{rad}(UVW)<{c^6\over R}.   \tag{4.1}
\]

### Theorem 4.1 (one-factor low-radical bound)

For a seed in a fixed subcritical locus, uniformly in that seed,

\[
                       |E_c|\ll_\epsilon
                       c^{8-\rho-\sigma/3+\epsilon}.          \tag{4.2}
\]

**Proof.**  Put

\[
                              Z=(c^6/R)^{1/3}=c^{2-\sigma/3}. \tag{4.3}
\]

Since `U,V,W` are pairwise coprime, (4.1) implies that at least one of
`rad(U),rad(V),rad(W)` is less than `Z`.

The ranges from (2.3) and (2.9) are `U<<c^6` and `V,W<<c^7`.
The de Bruijn estimate (1.8), together with the finite-mesh argument
described after it, shows that the number of possible values of any one of
these factors with radical below `Z` is

\[
                              \ll_\epsilon c^{2-\sigma/3+\epsilon}. \tag{4.4}
\]

For each fixed `U`, the value of `h` is unique, and there are at most `M`
values of `k`.  For a fixed `V`, the integer
`(V-1)/P=h+ck` is fixed, so the interval `1<=h,k<=M` contains at most
`M/c+1` representations.  For fixed `W`, the same argument gives at most
`M/b+1<=2M/c+1` representations.  The `U` case dominates.  Since
`M<<c^(6-rho)`, multiplication of (4.4) by `M` gives (4.2).  \(\square\)

Combining Theorem 4.1, the raw count, and (1.7) proves the unconditional
ledger

\[
 \boxed{
 |E_c|\ll_\epsilon
 c^{\min\{12-2\rho,\ 6-\sigma,\ 8-\rho-\sigma/3\}+\epsilon}.}
                                                                    \tag{4.5}
\]

The three terms have different meanings:

* `12-2rho` is the whole two-parameter fibre;
* `6-sigma` is the complete actual-support S-unit budget; and
* `8-rho-sigma/3` charges the fact that one of the three affine factors
  itself has small radical, together with its exact representation
  multiplicity in the parameter box.

For every subcritical seed, `rho<=3+o(1)` and `sigma<1`, so every term on
the right still exceeds the BBLT threshold `4` by a fixed limiting margin;
the infimum of the third exponent over the allowed parameter region is
`14/3`.  Consequently (4.5) does not disprove the affine route.  More
precisely, the three present upper bounds uniformly leave the candidate
interval

\[
                         4<\beta<{14\over3}                   \tag{4.6}
\]

unexcluded.  This is not an upper bound `beta<=14/3`: for a particular
pair `(rho,sigma)`, (4.5) may allow a larger exponent.  A concrete uniform
target safely inside the displayed common window is

\[
                              |E_c|\ge c^{17/4}.               \tag{4.7}
\]

For comparison, at `K=7` the analogous one-factor exponent is
`27/4-rho-sigma/3`, while the BBLT threshold is `7/2`.  Thus that shorter
height scale has room only if

\[
                              \rho+{\sigma\over3}<{13\over4}. \tag{4.8}
\]

This explains why the raw `K=7` optimization is not uniform over all
subcritical seed shapes, whereas `K=8` remains viable after actual-radical
charging.

### Corollary 4.2 (the exact conditional closing step)

Fix a source exponent `lambda<1`.  Suppose there is a constant `c_0(lambda)`
such that every seed with `R<c^lambda` and `c>=c_0(lambda)` has at least
`c^(17/4)` members in `E_c`.  Then that subcritical source locus has bounded
height.

**Proof.**  Every member of `E_c` is a distinct positive primitive target
of height below `c^8` and radical below its height to the power `3/4`.
By (1.4)--(1.5), for any fixed `delta>0`,

\[
                              |E_c|\ll_\delta c^{4+8\delta}.  \tag{4.9}
\]

Choose, for example, `delta=1/64`.  Then the exponent on the right is
`33/8<17/4`.  Combining (4.7) and (4.9) bounds `c` by a constant depending
only on `lambda` and the cited counting constant.  \(\square\)

If Corollary 4.2 were proved for every fixed `lambda<1`, the exact
subcritical-locus equivalence would yield the standard abc conjecture.  The
open premise (4.7), not the algebra above, is the remaining positive gate.

## 5. Fixed support, collisions, and sieve directions

### Proposition 5.1 (a large fibre must use many new supports)

Fix a seed and a squarefree integer `D` coprime to `R`.  The number of
outputs in `E_c` with

\[
                              \operatorname{rad}(UVW)=D       \tag{5.1}
\]

is at most `905*45^(omega(RD))`.  Hence, for every `epsilon>0`, a subfibre
of size `c^beta` must occupy at least `c^(beta-epsilon)` distinct values of
`D`, once `c` is sufficiently large.

**Proof.**  Condition (5.1) fixes the complete finite prime support `RD` of
the target abc equation.  The fixed-S instance in the proof of (1.6) gives
the displayed bound before summing over `D`.  Here `RD<c^6`, so the standard
fixed-power estimate `45^omega(n)<<_epsilon n^epsilon` makes every one of
these support fibres `c^epsilon`.  Division proves the last assertion.
\(\square\)

Thus old-support reuse, any fixed `O(log c)` pool with only `c^o(1)` possible
support products, or a single S-unit orbit cannot establish (4.7).  A
successful amplifier must spread over at least `c^(17/4-o(1))` genuinely
different new radical products.  This rules out only a shortcut based on
many parameter collisions over one fixed support.  Theorem 2.2 is already
injective, while the map from an output to its radical support has the
`c^epsilon` multiplicity bound above.  It does not rule out a family spread
over polynomially many distinct values of `D`.

### Proposition 5.2 (fixed prime-power templates have the wrong density)

Let `m_1,m_2,m_3` be pairwise coprime and coprime to `P`.  The number of
pairs `1<=h,k<=M` satisfying

\[
                         m_1\mid U,\qquad m_2\mid V,\qquad m_3\mid W       \tag{5.2}
\]

is at most

\[
                    {M^2\over Q}+2M+Q,\qquad Q=m_1m_2m_3.    \tag{5.3}
\]

**Proof.**  Modulo `Q`, the three congruences live at pairwise coprime
moduli.  At modulus `m_i`, its one affine linear equation in `(h,k)` is
surjective because all relevant coefficients are units at primes dividing
`m_i`; it therefore has exactly `m_i` solutions among `m_i^2` pairs.
Chinese remaindering gives exactly `Q` admissible residue pairs among the
`Q^2` pairs modulo `Q`.  Each residue pair occurs at most `(M/Q+1)^2`
times in the box.  Multiplication gives (5.3).  \(\square\)

If (5.2) prescribes prime powers, the congruence cost `Q` is at least the
repeated-prime excess it certifies.  Its main density therefore loses at
least the same factor that the radical gains.  The boundary term in (5.3)
becomes dominant precisely when `Q>>M`; Corollary 3.2 proves that every
candidate exceptional output is in this large-modulus range.  Thus an
ordinary CRT main term cannot prove the needed lower bound, while treating
the boundary requires new Diophantine information rather than a formal
rearrangement of the same congruences.

### 5.3 What squarefree sieve and moments do and do not prove

For a prime `p` not dividing `P`, each congruence
`p^2|U`, `p^2|V`, or `p^2|W` cuts out one affine line with `p^2` points in
the `p^4`-point parameter plane.  Their union has at most `3p^2` points.
If `p|P`, none of the three congruences has a solution.  Consequently, for
every **fixed finite** set of primes, the Chinese remainder theorem gives a
positive-density set of parameters on which none of those primes occurs to
second order.

This is a valid local squarefree sieve statement, but it points in the
opposite direction from (4.7): it constructs generic large-radical values.
Letting the sieving range grow requires control of the large-square-divisor
tail, and Corollary 3.2 places every desired exceptional point wholly in
that tail.  Likewise, a first or second moment for small-prime valuations
only gives an upper-tail estimate.  It cannot be inverted into a lower
bound for simultaneous huge excess in `U,V,W`.

Even a density-one theorem for squarefree values would not settle the gate.
At the uniform `K=8` scale, (4.7) asks for a proportion only `c^(-7/4)` of
the guaranteed `c^6` raw fibre.  A statement that the complement is merely
`o(c^6)` is fully compatible with such a set.  A useful negative theorem
would need a power-saving upper bound below `c^(4+eta)`; a useful positive
theorem must explicitly construct more than `c^(4+eta)` points with the
excess (3.4).  Neither follows from an expectation or an average radical.

The minimal unresolved analytic object may therefore be stated without
abc terminology:

> Uniformly for the coefficients arising from (1.1), count pairs in a box
> for which three pairwise-coprime affine forms have product excess at
> least a fixed multiple of `R*c^14`, with the excess supported on square
> divisors whose combined square-root modulus exceeds the box length.

Current S-unit, elementary squarefree-sieve, and fixed-template estimates
give only the upper budgets above.  No lower theorem of this form is known
or assumed here.

## 6. A fixed-full one-dimensional no-go

Write the seed as `f+g=c` with `g=max(a,b)`, and for `s>=1` put

\[
 y_s=1+fcs,\qquad z_s=1+fgs.                                 \tag{6.1}
\]

Then

\[
                              (f,gy_s,cz_s)                   \tag{6.2}
\]

is a positive primitive abc point, and `s` is recovered from it.  The
primitivity proof is the same difference argument as Theorem 2.2.  Namely,
`y_s-z_s=f(c-g)s=f^2s`, while both factors are `1 mod f` and `1 mod s`, so
`gcd(y_s,z_s)=1`.  Also `y_s=1 mod c`, `z_s=1 mod g`, and
`gcd(f,g)=gcd(f,c)=gcd(g,c)=1`.  These relations check all four cross terms
in `gcd(gy_s,cz_s)` and the two pairs involving `f`.

### Lemma 6.1 (elementary count of full numbers)

For fixed `m>=2`, the number of `m`-full positive integers at most `X` is
`O_m(X^(1/m))`.

**Proof.**  If a prime exponent `e>=m` has residue `r` modulo `m`, use an
`m`-th power when `r=0`, and write

\[
                     e=m(q-1)+(m+r)\quad(1\le r<m)            \tag{6.3}
\]

otherwise.  Hence every `m`-full integer has a representation

\[
                       x_m^m x_{m+1}^{m+1}\cdots x_{2m-1}^{2m-1}.  \tag{6.4}
\]

Ignoring uniqueness and summing first over `x_m` bounds the count by

\[
 X^{1/m}\prod_{j=m+1}^{2m-1}\sum_{x>=1}x^{-j/m},             \tag{6.5}
\]

whose product converges.  \(\square\)

### Theorem 6.2 (fixed-full capacity cannot cross BBLT)

Suppose both `y_s,z_s` are `m`-full.  For `H=cz_s<=T`,

\[
 \#\{s\}\ll_m(T/c)^{1/m},                                   \tag{6.6}
\]

and

\[
 \operatorname{rad}(fgy_scz_s)
       \le 2^{1/m}Rc^{-2/m}H^{2/m}.                          \tag{6.7}
\]

More precisely, consider any fixed polynomial height shell `H` of scale
`c^tau`, with `tau>=1`.  Whenever (6.7) itself certifies exponent `mu<1`
on that shell with a fixed power margin, its capacity exponent
`(tau-1)/m` is strictly smaller than `tau F(mu)`.  Consequently a union of
the `O(log c)` dyadic shells below `c^kappa` cannot close the
single-source BBLT gate through this natural radical certificate.

**Proof.**  The identity `f+gy_s=cz_s` gives
`y_s<(c/g)z_s<=2T/c`.  Lemma 6.1 and injectivity in `s` prove (6.6).
Also

\[
 \operatorname{rad}(fgy_scz_s)
 \le R(y_sz_s)^{1/m}
 <R(cg)^{-1/m}H^{2/m}
 \le2^{1/m}Rc^{-2/m}H^{2/m},                                 \tag{6.8}
\]

because `g>=c/2`.

Write `R=c^sigma`.  On a shell `H` of scale `c^tau`, the count (6.6) has
exponent at most `(tau-1)/m`.  If `mu<2/m`, certification by (6.7) with a
fixed power margin means

\[
                 \tau\mu>\sigma+{2(\tau-1)\over m}.          \tag{6.9}
\]

Since `sigma>=0`, this gives

\[
          \tau F(\mu)>{\tau\mu\over2}>{\tau-1\over m}.       \tag{6.10}
\]

If `mu>=2/m`, no condition on `sigma` is needed for the capacity
comparison:

\[
          \tau F(\mu)>{\tau\mu\over2}\ge{\tau\over m}
                         >{\tau-1\over m}.                   \tag{6.11}
\]

Here `F(mu)>mu/2` because each of the three entries in (1.4) is strictly
greater than `mu/2` for `0<mu<1`.  A logarithmic decomposition into height
shells changes no power exponent.  This proves the claimed limited no-go.
\(\square\)

### Proposition 6.3 (exact square completion is only `c^o(1)`)

If `y_s=X^2` and `z_s=Y^2`, then

\[
                              cY^2-gX^2=f.                    \tag{6.12}
\]

For every fixed `kappa`, the number of positive solutions with
`cY^2<=c^kappa` is `c^o(1)`, uniformly in the seed.

**Proof.**  Put `D=cg` and multiply (6.12) by `c`:

\[
                         (cY)^2-DX^2=cf.                      \tag{6.13}
\]

If `D` is a square, the left side factors over the integers and there are
at most `tau(cf)` choices.

If `D` is nonsquare, work in the maximal order of
`K=Q(sqrt(D))`.  The algebraic integer

\[
                         \alpha=cY+X\sqrt D                  \tag{6.14}
\]

has norm `cf`, and `(alpha)` divides the ideal `(cf)`.  The number of ideal
divisors of `(cf)` is at most `tau(cf)^4`: above each rational prime there
are at most two prime ideals, and `(2e+1)^2<=(e+1)^4` for an exponent `e`.
Two generators of the same principal ideal differ by a unit.  Every
nontrivial positive unit in a real quadratic field is at least the golden
ratio, while (6.13) and the height bound put both real embeddings in an
interval of polynomial multiplicative length in `c`.  Hence each unit orbit
contributes `O_kappa(log c)` generators.  The divisor bound now gives
`tau(cf)^4 log c=c^o(1)`.  Congruence and positivity conditions can only
decrease this count.  \(\square\)

These square completions are genuine low-radical points when the numerical
inequality from (6.7) holds, but their exponent is `beta=0`.

## 7. An odd-power transfer and why its CRT thickening is sparse

### Proposition 7.1 (one genuine odd-power transfer)

For every odd integer `n>=3`,

\[
                         (a^n,b^n,a^n+b^n)                   \tag{7.1}
\]

is a primitive abc point, `c|(a^n+b^n)`, and

\[
 \operatorname{rad}\bigl(a^nb^n(a^n+b^n)\bigr)
       \le {R\over c}(a^n+b^n).                              \tag{7.2}
\]

Thus a seed with `R<c^lambda` maps to an actual target of exponent

\[
                         \mu_n=1-{1-\lambda\over n}<1         \tag{7.3}
\]

at height scale `kappa=n`, but this gives only one target.

**Proof.**  Oddness and `a=-b mod c` give the divisibility.  Primitivity is
immediate from `gcd(a,b)=1`.  If `C=a^n+b^n=cw`, then

\[
 \operatorname{rad}(C)\le\operatorname{rad}(c)\operatorname{rad}(w)
             \le {\operatorname{rad}(c)\over c}C.
\]

Multiplying by `rad(ab)=R/rad(c)` proves (7.2).  Since `C<=c^n`, one has
`c>=C^(1/n)`; substitution of `R<c^lambda` in (7.2) proves (7.3).
\(\square\)

### Proposition 7.2 (the certified multiplier thickening has `beta=0`)

Try to thicken (7.1) by

\[
              A=(au)^n,\qquad B=(bv)^n,\qquad C=A+B=cw,      \tag{7.4}
\]

with positive `u,v`, and restrict to **primitive outputs**, equivalently in
this equation to `gcd(au,bv)=1`.  Integrality is exactly
`u^n=v^n mod c`.  Any such output certified by the natural estimate

\[
                         {R\over c}uvC\le C^\mu              \tag{7.5}
\]

has `uv<=c/R`.  For fixed odd `n`, all such outputs in polynomial height
number `c^o(1)`.

**Proof.**  The condition `gcd(au,bv)=1` includes all cross-coprimality
conditions, not merely `gcd(u,v)=1`.  Since `C=A+B`, it is equivalent to
pairwise primitivity of `(A,B,C)`.  Moreover, if a prime divided both `u`
and `c`, it would divide `A` and `C`; similarly for `v`.  Thus primitive
integral outputs make `u,v` units modulo `c`, and their quotient is an
`n`-th root of unity.  For an odd prime power the unit group is cyclic and
has at most `n` such roots.  At the `2`-power component an odd `n` has only
the trivial root.  Hence there are at most `n^omega(c)` quotient classes.

Indeed, since `c|C`,

\[
 \operatorname{rad}(ABC)
 \le \operatorname{rad}(ab)\,uv\,\operatorname{rad}(C)
 \le {R\over\operatorname{rad}(c)}uv
      {\operatorname{rad}(c)\over c}C
 ={R\over c}uvC.                                             \tag{7.6}
\]

Thus (7.5) implies
`uv<=(c/R)C^(mu-1)<=c/R`.

Partition `u,v` into dyadic boxes.  Two primitive pairs in one box with the
same quotient have determinant divisible by `c`.  On the other hand its
absolute value is less than `4uv<=4c/R<c` once `R>4`, so it is zero; the two
positive primitive pairs are equal.  If `R<=4`, parity forces the support
to be only `{2}`; pairwise coprimality and `a+b=c` then give only
`(a,b,c)=(1,1,2)`.  This bounded edge case is irrelevant to an unbounded
source locus.  There
are `O((log c)^2)` boxes at fixed polynomial height.  Therefore the count is

\[
                         \le n^{\omega(c)}O((\log c)^2)=c^{o(1)}.  \tag{7.7}
\]

If `n` is also allowed to vary while the output height is at most
`c^kappa`, then `(c/2)^n<=C<=c^kappa` bounds `n` in terms of the fixed
`kappa`; the finite union remains `c^o(1)`.  \(\square\)

As in the original CRT audit, extra actual repeated-prime savings outside
(7.5) are not covered by this no-go.

## 8. Why the affine shear is not automatically mixed-full

Because `U,V,W` avoid `P`, the product `aU` is `p`-full if and only if both
coprime factors `a` and `U` are `p`-full; the analogous statements hold for
`bV,cW`.  A Browning--Verzobio signature has all three fullness exponents at
least two.  Therefore the affine shear cannot uniformly land in any such
fixed signature from an arbitrary subcritical seed unless the seed
coordinates already have the required fullness.

This is a scope obstruction, not a criticism of their theorem.  Their
coefficient-uniform generalized-Fermat estimate applies after a genuine
fixed signature and a fixed surface have been supplied.  It cannot be used
to infer that the `c^6` raw shear fibre is mixed-full.

For completeness, suppose some different construction really does produce
a fixed `(p,q,r)`-full subfibre inside the complete unscaled conic, and put

\[
                 s={1\over p}+{1\over q}+{1\over r},\qquad
                 \theta={1\over p}+{1\over q}-\eta(p,q,r).   \tag{8.1}
\]

The conic lattice count and actual-support theorem then force

\[
 \beta\le\min\left\{\max\left(0,{K-\rho\over2}\right),
                           Ks-\sigma\right\}+o(1).            \tag{8.2}
\]

Consequently a strict crossing of the Browning--Verzobio exponent requires

\[
 \boxed{\theta<{1\over2},\qquad
        K(1-2\theta)>\rho,\qquad
        K\left({1\over r}+\eta(p,q,r)\right)>\sigma.}         \tag{8.3}
\]

Indeed, the first two inequalities are exactly
`(K-rho)/2>K theta`; the third is `K(s-theta)>sigma`.
These are necessary conditions only.  In the automatically squarefull case,
Corollary 4.4 gives

\[
                    \theta_{2,2,2}={11\over15}+{\sqrt2\over6}>{1\over2},
                                                                    \tag{8.4}
\]

so the entire conic is too small before any radical estimate is used.  This
recovers the earlier square-completion no-go in the precise 2026 counting
language.

## 9. Interaction with the Pell adjacent-factor slope `1/2`

The report `ABC_PELL_ADJACENT_FACTOR_GATE_2026_08_31.md` proves the following
conditional statement.  If

\[
                         x^2-8y^2=1                           \tag{9.1}
\]

and `y` is squarefull, then

\[
 r={x-1\over2},\qquad s={x+1\over2},\qquad r+1=s,qquad rs=2y^2,
                                                                    \tag{9.2}
\]

and the primitive point `(r,1,s)` satisfies

\[
       \log\operatorname{rad}(rs)\le{1\over2}\log s+\log2. \tag{9.3}
\]

The existence of unbounded squarefull Pell roots is open; (9.3) is not an
unconditional abc counterexample.

For this conditional source family, using `c=s`, one has

\[
                         P=s(s-1),\qquad \rho=2+o(1),\qquad
                         \sigma\le1/2+o(1).                  \tag{9.4}
\]

The `K=8` affine shear therefore has raw size `c^(8-o(1))`, far above the
BBLT threshold `c^4`.  However, its new cofactors are all `1 mod P` and
avoid every Pell source prime.  The squarefull hypothesis on `y`, and the
slope improvement (9.3), supply no repeated-prime divisibility in
`U,V,W`.  The exact missing condition remains (3.4), and on the upper box it
still requires excess `>>R*c^14`.  One must not insert the upper bound
`sigma<=1/2` as a lower bound in (1.7); doing so would reverse the useful
direction of the actual-support estimate.

The conic capacity calculation is more favorable but still conditional.
For `K=7`, (9.4) makes (1.11) hold, for all large members, at for example
`mu=2/5`:

\[
 {3\sigma\over7}\le {3\over14}+o(1)<{2\over5}
 <{3\over4}\left(1-{\rho\over7}\right)={15\over28}+o(1).    \tag{9.5}
\]

Thus the Pell slope enters the **necessary capacity window** for the full
integer conic.  The previously proved square-certificate count is still too
small, and no lower bound for actual repeated-prime savings on that conic is
known.  Equation (9.5) must therefore not be described as an amplification
or as a proof that the Pell premise is false.

If the squarefull Pell premise itself held at unbounded indices, (9.3)
would already disprove abc without amplification.  Its value here is as a
sharp stress test: any claimed universal positive amplifier must cope with
a source whose good radical is concentrated entirely in old primes while
the new cofactors deliberately avoid those primes.

## 10. What is proved, what failed, and the next exact gate

### Unconditional theorems proved in this report

1. The affine shear (2.3) is positive, primitive, pairwise coprime, and
   injective on `gcd(1+Ph,k)=1`.
2. At height `c^8` it has at least a constant times `c^6` outputs uniformly
   over every seed.
3. Its actual low-radical condition is exactly the excess inequality (3.4);
   no output is covered by the inherited-size certificate.
4. At `mu=3/4`, all top-box exceptions lie in the large-square-divisor tail
   (3.8).
5. The actual exceptional subfibre satisfies the combined budget (4.5).
6. A large exceptional fibre must occupy polynomially many distinct new
   support products.
7. Fixed-full one-dimensional slices and certified odd-power CRT
   thickenings have capacity strictly below their relevant counting gates.

### No-go results with deliberately limited scope

* CRT main terms cannot force the huge new excess at positive fibre
  exponent; they do not rule out accidental extra powers.
* A squarefree sieve or a low-prime moment controls generic outputs and has
  the wrong direction for a lower bound; this does not rule out the
  large-modulus tail.
* The `m`-full slice no-go applies only when its displayed fullness estimate
  is the radical certificate.
* The odd-power no-go applies only to the natural certificate (7.5).
* The Browning--Verzobio theorem cannot be applied until actual fixed
  fullness of all three target coordinates has been proved.

### Minimal open positive statement

For every fixed `lambda<1`, prove that every sufficiently large seed with
`R<c^lambda` has more than `c^(4+eta)` distinct pairs in the `K=8` affine
fibre for some fixed `eta>0` (for example `eta=1/4`) satisfying

\[
 E(U)E(V)E(W)>{R\over c}UVH^{1/4}.                           \tag{10.1}
\]

The theorem must be a lower bound for actual repeated-prime excess in the
three affine forms, uniform in the seed.  Equivalently, one may prove a
different amplifier with explicit exponents `beta>kappa F(mu)`.  The
upper ledger (4.5) shows that (10.1) is not contradicted by current general
counting theorems, while Corollary 3.2 shows why the missing input lies
beyond ordinary small-modulus sieve estimates.

Until that lower theorem, another genuine target fibre, or a direct proof
of subcritical-locus boundedness is found, the positive route remains open.
The unconditional integer core of Theorems 2.1--2.2 is formalized in
`Lean/IUTThreeClosures/AffineShearAmplification20260831.lean`: it proves the
shear equation, cofactor and endpoint coprimality, construction of the actual
`ABCPoint`, and parameter injectivity.  The substantive missing statement is
analytic and has not been encoded as an axiom or theorem premise masquerading
as progress on the unconditional target.
