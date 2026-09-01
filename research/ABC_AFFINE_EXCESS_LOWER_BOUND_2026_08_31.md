# A pair-projection radical barrier and a sharper affine-excess gate

Author: ChatGPT.  Date: 2026-08-31.

## 0. Status and exact scope

The standard abc conjecture is not proved or disproved here.  This report
audits the open affine-shear gate in
`research/ABC_AMPLIFICATION_GATE_ATTACK_2026_08_31.md`.  Its main result is
an unconditional, seed-uniform upper bound for the actual exceptional part
of the shear:

\[
 \#\mathcal E(X)\ll_\varepsilon
 R^{-2/3}X^{2\mu/3+\varepsilon}.                         \tag{0.1}
\]

Here `R=rad(abc)` is the inherited seed radical, `X` is the target-height
cap, and `mathcal E(X)` consists of primitive shear outputs with actual
radical below `H^mu`.  At `X=c^8` and `mu=3/4`, this becomes

\[
                     |\mathcal E_c|
       \ll_\varepsilon R^{-2/3}c^{4+\varepsilon}.          \tag{0.2}
\]

This does **not** refute the conditional proposal that every sufficiently
large subcritical seed produces many exceptional outputs.  Such a proposal
may be vacuously true if no sufficiently large subcritical seed exists, and
the contradiction between its lower bound and (0.2) would be the desired
positive proof.  Consequently the affine route remains active.  What (0.2)
does is sharpen its sufficient lower target from the seed-independent
`c^(4+eta)` to

\[
                   R^{-2/3}c^{4+\eta}.                     \tag{0.3}
\]

For a seed shape `R=c^(sigma+o(1))`, the new target exponent is
`4-2 sigma/3+eta`; it approaches `10/3+eta` when `sigma` approaches one.
The previously suggested `c^(17/4)` target remains sufficient, but is no
longer the sharp comparison furnished by the inherited support.

No finite computation is used as proof.  Section 7 records replayable
arithmetic checks of the exponent algebra and local residue counts only.

## 1. Audited affine setup

Let

\[
 a,b,c\in\mathbb N,\qquad a+b=c,\qquad \gcd(a,b)=1,
 \qquad P=abc,\qquad R=\operatorname{rad}(P).              \tag{1.1}
\]

For positive integers `h,k`, put

\[
 \begin{aligned}
 U&=1+Ph,\\
 V&=1+P(h+ck),\\
 W&=1+P(h+bk).
 \end{aligned}                                             \tag{1.2}
\]

On the admissible set `gcd(U,k)=1`, the existing affine-shear theorem proves
that `(aU,bV,cW)` is a positive pairwise-coprime abc point, that `U,V,W`
are pairwise coprime and avoid `P`, and that the parameter map is injective.
Write

\[
                           H=cW.                            \tag{1.3}
\]

The following stronger projection fact will be used three times:

### Lemma 1.1 (all two-coordinate projections are injective)

On the set of affine parameters, each of the maps

\[
              (h,k)\mapsto(U,V),\qquad(U,W),\qquad(V,W)     \tag{1.4}
\]

is injective.

**Proof.**  From `U=1+Ph` one recovers `h`.  Equations

\[
                 V-U=cPk,\qquad W-U=bPk                    \tag{1.5}
\]

then recover `k`, proving the first two cases.  Finally,

\[
                           V-W=aPk                          \tag{1.6}
\]

recovers `k` from `(V,W)`, and then
`h=(V-1)/P-ck`.  All denominators in these recovery formulas are fixed
positive integers, so two integral parameter pairs with the same projected
coordinates coincide.  \(\square\)

Because the cofactors avoid `P` and are pairwise coprime,

\[
 \operatorname{rad}(aUbVcW)
       =R\operatorname{rad}(U)\operatorname{rad}(V)
                         \operatorname{rad}(W).              \tag{1.7}
\]

Thus an actual `mu`-exception satisfies

\[
 \operatorname{rad}(U)\operatorname{rad}(V)
                  \operatorname{rad}(W)< {H^\mu\over R}.    \tag{1.8}
\]

Equivalently, for `E(n)=n/rad(n)`, it satisfies the already audited exact
criterion

\[
 E(U)E(V)E(W)>{RUVW\over H^\mu}.                            \tag{1.9}
\]

## 2. A uniform radical tail from de Bruijn

The only analytic input in the main proof is the consequence of de Bruijn
quoted as equation (1.1) in Bernert--Browning--Lichtman--Teravainen,
arXiv:2410.12234v2:

\[
 \#\{n\le X:\operatorname{rad}(n)\le X^\alpha\}
             \ll_{\alpha,\varepsilon}X^{\alpha+\varepsilon}
                                                               \tag{2.1}
\]

for fixed positive `alpha` and every positive `epsilon`.  The finite-mesh
argument below makes the radical cutoff uniform; no constant is allowed to
depend on a seed or on a dyadic box.

### Lemma 2.1 (uniform radical-cutoff count)

For every `epsilon>0`, uniformly for real `X>=2` and `Y>=1`,

\[
 \#\{n\le X:\operatorname{rad}(n)\le Y\}
                       \ll_\varepsilon YX^\varepsilon.      \tag{2.2}
\]

When `Y>=X`, this follows from the trivial bound `X<=Y`.  When `1<=Y<X`,
it follows from finitely many fixed instances of (2.1).

**Proof.**  Fix `delta=epsilon/3` and choose the finite mesh
`delta,2 delta,...,J delta`, where `J delta>=1`.  If
`X^((j-1)delta)<=Y<X^(j delta)`, apply (2.1) with the fixed exponent
`alpha=j delta` and with error exponent `epsilon/3`.  It gives

\[
 \#\{n\le X:\operatorname{rad}(n)\le Y\}
 \ll X^{j\delta+\varepsilon/3}
 \le YX^{\delta+\varepsilon/3}
 \le YX^\varepsilon.                                      \tag{2.3}
\]

For `1<=Y<X^delta`, use `alpha=delta`; the same conclusion follows from
`Y>=1`.  Taking the maximum of the finitely many constants proves the
uniform statement.  \(\square\)

An immediate excess-tail form, useful for checking (1.9), is

\[
 \#\{n\le X:E(n)\ge D\}
                 \ll_\varepsilon {X^{1+\varepsilon}\over D}
                 \qquad(1\le D\le X),                      \tag{2.4}
\]

because `E(n)>=D` implies `rad(n)<=X/D`.

### Lemma 2.2 (two-coordinate radical count)

Uniformly for `X_1,X_2>=2` and `Y>=1`,

\[
 \#\{(m,n):m\le X_1,n\le X_2,
          \operatorname{rad}(m)\operatorname{rad}(n)\le Y\}
       \ll_\varepsilon Y(X_1X_2)^\varepsilon.              \tag{2.5}
\]

**Proof.**  If `rad(m)rad(n)<=Y`, then `rad(m)<=Y`.  Split `rad(m)` into
the `O(log(2Y))` dyadic intervals `D<rad(m)<=2D`, including the first
interval at one.  Lemma 2.1 gives `O_epsilon(D X_1^epsilon)` possible
values of `m` in such an interval.  For each one,
`rad(n)<=Y/D`, and Lemma 2.1 gives
`O_epsilon((Y/D)X_2^epsilon)` possible `n`.  Every dyadic block therefore
contributes `O_epsilon(Y(X_1X_2)^epsilon)`.  The logarithmic number of
blocks is absorbed after decreasing `epsilon` in the two applications.
For completeness, if `Y>=X_1X_2`, the trivial bound `X_1X_2<=Y` proves
the result directly.  In the remaining case `log(2Y)<<log(2X_1X_2)`, so
the asserted absorption is uniform even when `Y` was initially unrestricted.
\(\square\)

## 3. The pair-projection radical barrier

### Theorem 3.1 (three-factor, pair-determined barrier)

Let `T` be a finite set of triples `(u,v,w)` of positive integers at most
`X`.  Suppose every one of the three two-coordinate projections of `T` is
injective.  Then, uniformly for `Y>=1`,

\[
 \#\{(u,v,w)\in T:
       \operatorname{rad}(u)\operatorname{rad}(v)
                         \operatorname{rad}(w)<Y\}
       \ll_\varepsilon Y^{2/3}X^\varepsilon.               \tag{3.1}
\]

**Proof.**  Put `r_1=rad(u)`, `r_2=rad(v)`, `r_3=rad(w)`.  Since

\[
 (r_1r_2)(r_1r_3)(r_2r_3)=(r_1r_2r_3)^2<Y^2,              \tag{3.2}
\]

at least one of the three pair products is less than `Y^(2/3)`.  Partition
the triples according to which pair has this property.  For a fixed pair,
injectivity of the corresponding projection and Lemma 2.2 bound its
cardinality by

\[
                       \ll_\varepsilon Y^{2/3}X^\varepsilon.
                                                                    \tag{3.3}
\]

Summing the three cases proves (3.1).  \(\square\)

There is an equivalent excess proof that exposes the geometric mean behind
the exponent `2/3`.  In coordinate boxes `u~X_1`, `v~X_2`, `w~X_3` and
excess boxes `E(u)~D_1`, `E(v)~D_2`, `E(w)~D_3`, Lemma 2.1 or (2.4) and
the three injective projections give

\[
 N\ll_\varepsilon
 \min\left\{
 {X_1X_2\over D_1D_2},
 {X_1X_3\over D_1D_3},
 {X_2X_3\over D_2D_3}\right\}(X_1X_2X_3)^\varepsilon.      \tag{3.4}
\]

The minimum is at most the geometric mean, hence

\[
 N\ll_\varepsilon
 \left({X_1X_2X_3\over D_1D_2D_3}\right)^{2/3}
 (X_1X_2X_3)^\varepsilon.                                  \tag{3.5}
\]

For the affine application, `H=cw` is comparable to `cX_3` throughout
the chosen `w` box.  After also splitting the finitely many dyadic excess
boxes, (1.9) gives `D_1D_2D_3` at least a fixed multiple of
`R X_1X_2X_3/H^mu`.  Substitution in (3.5) cancels all three cofactor
sizes and leaves a fixed multiple of `(H^mu/R)^(2/3)`.  Summing the
logarithmically many boxes is absorbed into `X^epsilon`.  This is the
excess-distribution form of Theorem 3.1; without the `w`/height box one may
instead replace `H` directly by its cap `X`.

## 4. Application to the full affine fibre

### Theorem 4.1 (seed-uniform affine exceptional-set bound)

Fix `X>=2`, `0<mu<1`, a primitive seed (1.1), and any subset of admissible affine
parameters (1.2).  Let `mathcal E(X)` be its distinct outputs satisfying

\[
 H=cW\le X,
 \qquad \operatorname{rad}(aUbVcW)<H^\mu.                 \tag{4.1}
\]

Then, with a constant independent of the seed,

\[
                 |\mathcal E(X)|
       \ll_{\mu,\varepsilon}R^{-2/3}X^{2\mu/3+\varepsilon}.
                                                                    \tag{4.2}
\]

**Proof.**  Every positive abc output has `aU<H` and `bV<H`; also
`W=H/c`.  Thus `U,V,W<=X`.  Lemma 1.1 supplies all three projection
injectivities.  Equation (1.7) and (4.1) give

\[
 \operatorname{rad}(U)\operatorname{rad}(V)
           \operatorname{rad}(W)< {X^\mu\over R}.          \tag{4.3}
\]

Apply Theorem 3.1 with `Y=X^mu/R`.  If `Y<1`, (4.3) is impossible because
the product of three radicals is at least one; otherwise (3.1) gives
(4.2).  No parameter-box lower bound and no averaging over seeds is used.
\(\square\)

### Corollary 4.2 (`K=8`, `mu=3/4`)

For the full `K=8` affine fibre in the source report,

\[
                         |\mathcal E_c|
        \ll_\varepsilon R^{-2/3}c^{4+\varepsilon}.          \tag{4.4}
\]

**Proof.**  Substitute `X=c^8` and `mu=3/4` into (4.2), obtaining
`X^(2mu/3)=c^4`.  Rename the arbitrary error exponent after the fixed
change of scale from `X` to `c`.  \(\square\)

The proof covers the entire parameter square, including small `h` or `k`;
it does not rely on the upper-half lower bound `E(U)E(V)E(W)>Rc^14/8192`.
In the upper half, (3.5) recovers the same exponent by inserting that excess
threshold and the bounds `U<<c^6`, `V,W<<c^7`:

\[
 \left({c^{6+7+7}\over Rc^{14}}\right)^{2/3}
                       =R^{-2/3}c^4.                        \tag{4.5}
\]

In the seed-shape notation `rho=log(P)/log(c)` and
`sigma=log(R)/log(c)`, (4.4) adds the term `4-2 sigma/3` to the old
three-way ledger.  On the relaxed region `2+o(1)<=rho<=3+o(1)` and
`0<=sigma<1`, it is smaller than each of

\[
 12-2\rho,\qquad6-\sigma,\qquad8-\rho-\sigma/3             \tag{4.6}
\]

up to endpoint `o(1)` terms.  Thus the inherited-support pair projection,
not the former one-factor estimate, is the currently strongest unconditional
upper budget for this fibre.

### Theorem 4.3 (all `P`-avoiding coordinatewise-multiple fibres)

The bound (4.2) is not special to the formulas (1.2).  Fix `X>=2`,
`0<mu<1`, a seed `a+b=c`, and put `P=abc`, `R=rad(P)`.  Let `F` be any
set of distinct positive triples `(U,V,W)` such that

\[
                          aU+bV=cW,                          \tag{4.7}
\]

the three cofactors are pairwise coprime, and each cofactor is coprime to
`P`.  Require every member to satisfy

\[
 H=cW\le X,\qquad \operatorname{rad}(aUbVcW)<H^\mu.        \tag{4.8}
\]

Then

\[
                        |F|\ll_\varepsilon
                  R^{-2/3}X^{2\mu/3+\varepsilon}.           \tag{4.9}
\]

**Proof.**  On the weighted plane (4.7), any two cofactor coordinates
determine the third: for example, equality of `U,V` in two triples gives
`cW=cW'` and hence `W=W'`; the other two cases are identical.  Therefore
all pair projections are injective.  The coprimality hypotheses give the
radical factorization (1.7), and Theorem 3.1 applies exactly as in Theorem
4.1.  \(\square\)

Thus the `R^(-2/3)` comparison is a structural feature of every primitive,
`P`-avoiding, coordinatewise-multiple amplifier.  A future construction can
still use the contradiction embodied in (4.9); alternatively it may seek
additional leverage by reusing inherited primes inside their own
coordinates or by leaving the coordinatewise-multiple model.  Theorem 4.3
does not analyze those broader mechanisms.

## 5. The improved positive gate and its logical status

### Corollary 5.1 (sharper conditional closing criterion)

Fix `lambda<1` and `eta>0`.  Suppose there is a seed-uniform threshold such
that every sufficiently large seed with `R<c^lambda` produces at least

\[
                         R^{-2/3}c^{4+\eta}                 \tag{5.1}
\]

actual `mu=3/4`, `H<c^8` affine exceptions.  Then the heights of all seeds
in that subcritical locus are bounded.

**Proof.**  Corollary 4.2, used with an error exponent smaller than `eta`,
is incompatible with (5.1) once `c` exceeds a constant depending only on
`eta` and the two uniform constants.  \(\square\)

If `R=c^(sigma+o(1))`, (5.1) asks for exponent

\[
                       4-{2\sigma\over3}+\eta.              \tag{5.2}
\]

This is a genuine improvement over the fixed exponent `17/4` whenever
`sigma` is bounded below.  To cover all seed shapes, the active arithmetic
problem becomes:

> produce more than `R^(-2/3)c^(4+eta)` actual exceptions from each
> sufficiently large subcritical seed, or obtain a still sharper
> seed-dependent upper comparison and a matching constructive lower bound.

Equations (4.4) and (5.1) are deliberately contradictory on a hypothetical
large seed.  That contradiction is a positive proof mechanism, not a
counterexample to (5.1).  No route is closed by Theorem 4.1.

## 6. Exact local distribution away from the seed

The global tail above can also be compared with the exact local law.  Fix a
prime `p` not dividing `P`.  Such a prime is odd because `P=abc` is even.
Let the local admissibility event be

\[
             \mathcal A_p:\quad \neg(p\mid U\ \hbox{and}\ p\mid k).
                                                                    \tag{6.1}
\]

It has Haar measure `1-p^(-2)` in `Z_p^2`.  On this event no prime `p` can
divide two of `U,V,W`, by the difference identities (1.5)--(1.6).

### Proposition 6.1 (valuation law)

For each `i` in `{U,V,W}` and every integer `e>=1`,

\[
 \operatorname{meas}\{\mathcal A_p,\ v_p(i)=e\}
                 =(1-p^{-1})^2p^{-e}.                       \tag{6.2}
\]

The three events in (6.2) are disjoint.  The measure on `mathcal A_p` on
which none of the three factors is divisible by `p` is

\[
                         (1-p^{-1})(1-2p^{-1}).              \tag{6.3}
\]

**Proof.**  For each of the three affine forms, the change of variables
`(h,k)->(i,k)` has unit determinant in `Z_p`, because `p` divides none of
`P,a,b,c`.  Exact valuation `e` has measure `(1-p^(-1))p^(-e)`, and local
admissibility then says that `k` is a unit, contributing another factor
`1-p^(-1)`.  If two factors were divisible, their difference would force
`p|k`, contradicting admissibility; hence the three sets are disjoint.
Summing (6.2) over `e>=1` and over the three factors gives
`3(p-1)/p^2`.  Subtracting this from `1-p^(-2)` gives (6.3).  \(\square\)

### Corollary 6.2 (exact local squarefree density)

Conditioned on `mathcal A_p`, the probability that `p^2` divides none of
`U,V,W` is

\[
                           1-{3\over p(p+1)}.                \tag{6.4}
\]

**Proof.**  Modulo `p^2`, `mathcal A_p` contains `p^4-p^2` residue pairs.
For each factor, the conditions `p^2|i` and `p` not dividing `k` give
`p^2-p` pairs.  The three sets are disjoint, so the bad proportion is

\[
 {3(p^2-p)\over p^4-p^2}={3\over p(p+1)}.                  \tag{6.5}
\]

This proves (6.4).  \(\square\)

### Corollary 6.3 (an exact counterexample to same-prime independence)

Conditioned on `mathcal A_p`, each of the three events
`p^2|U`, `p^2|V`, `p^2|W` has the positive probability

\[
                            {1\over p(p+1)},                 \tag{6.6}
\]

but every pairwise intersection is empty.  Therefore these three
same-prime events are not independent.  In particular, their union has the
exact probability `3/(p(p+1))`, rather than

\[
             1-\left(1-{1\over p(p+1)}\right)^3.            \tag{6.7}
\]

This is a genuine counterexample to the precise candidate model that the
three affine forms have independent square divisibility at one fixed prime.
It does not refute Chinese-remainder independence between distinct primes,
the large-square-divisor tail, or the affine route.

### Proposition 6.4 (exact independence across distinct primes)

Let `S` be a finite set of primes not dividing `P`.  For each `p in S`,
fix `e_p>=1` and prescribe any union of residue conditions on `(U,V,W,k)`
modulo `p^(e_p)`.  Give `(h,k)` the uniform counting measure modulo
`p^(e_p)`.  The corresponding uniform density of the simultaneous
condition modulo `prod_(p in S) p^(e_p)` is the product of its local
uniform densities.

**Proof.**  Each local condition is a subset of the two-dimensional residue
space modulo its prime power.  The Chinese remainder theorem identifies the
two-dimensional residue space modulo the product with the Cartesian product
of those local spaces.  Cardinalities therefore multiply.  \(\square\)

Consequently the exact distribution has two distinct features: negative
dependence among `U,V,W` at the same prime, forced by primitivity, and exact
independence of prescribed finite data at distinct primes.  Passing from a
fixed finite prime set to all primes is precisely where a uniform
large-square tail estimate is still required.  Proposition 6.4 does not
assert a natural density after imposing the global condition `gcd(U,k)=1`,
nor does it pass automatically to an infinite set of primes.

The Euler product of (6.4) over primes not dividing `P` is positive, since
the omitted proportions have convergent sum.  Hence the compatible
finite-prime densities have a positive Euler-product limit.  This statement
does not assert a global density uniformly in the growing seed: that would
still require control of the large-prime-square tail.  The local laws alone
cannot force the huge excess needed by the positive gate.

For `0<alpha<1`, the conditional local `alpha`-moment of the `p`-part of
`E(U)E(V)E(W)` is

\[
 1+{3(1-p^{-1})^2\over1-p^{-2}}
       \sum_{e\ge2}p^{-e}\bigl(p^{\alpha(e-1)}-1\bigr).     \tag{6.8}
\]

Its excess over one is `O_alpha(p^(alpha-2))`, so the Euler product over
`p` converges for every fixed `alpha<1`.  At `alpha=1`, the sum in (6.8)
diverges already for each fixed prime: its terms tend to `1/p`.  This gives
a precise reason that fractional local moments are well behaved while an
uncapped first or second excess moment is dominated by arbitrarily deep
prime powers.  Neither fact supplies a lower bound in the large-modulus
tail.

## 7. Replayable checks and Lean-ready interfaces

`verify.py` performs only exact rational arithmetic and finite residue
enumeration.  It checks:

1. `2*K*mu/3=4` for `K=8`, `mu=3/4`;
2. the fixed `17/4` target exceeds the sharpened worst-case exponent `4`
   by `1/4`;
3. for several primes not dividing sample seed products, the exact counts
   `p^4-p^2`, `3(p^2-p)`, and the conditional probability
   `3/(p(p+1))`; and
4. injectivity of all three pair projections on finite sample boxes.

The proof-relevant deterministic interfaces are suitable for later Lean
formalization without importing any analytic statement as an axiom:

- `AffinePairProjectionInjective`: the three recovery formulas in Lemma 1.1;
- `min_pair_radical_le`: from `r1*r2*r3<Y`, one of the three pair products
  is `<Y^(2/3)` (a cube-free integer formulation can avoid real powers);
- `local_pairwise_prime_exclusion`: under `p not dividing P` and local
  admissibility, a prime cannot divide two cofactors;
- `modSq_bad_count`: the finite count in (6.5).

The analytic statements Lemmas 2.1--2.2 should remain documented external
theorems until the relevant de Bruijn estimate is available in the Lean
dependency graph.  They must not be inserted as project axioms.

## 8. Source and retention audit

Primary source used:

- C. Bernert, T. Browning, J. D. Lichtman and J. Teravainen,
  *Bounds on the exceptional set in the abc conjecture*,
  [arXiv:2410.12234v2](https://arxiv.org/html/2410.12234v2), equation (1.1)
  and Proposition 1.1.  The repository
  copy is `research/sources/analytic_2026_08_30/BBLT_2410.12234v2.pdf`,
  SHA256
  `ee57b904398692ffecd0ccf8ccdcb0641f8e63ba6b971d6c9343bbac60d53470`.

Route status after this report:

- the affine shear remains **active**;
- the old fixed lower target `c^(17/4)` is sufficient but nonoptimal;
- the sharper active target is (5.1);
- exact same-prime local independence is refuted only in the narrow sense
  of Corollary 6.3;
- ordinary small-square sieves and local moments still do not construct
  any member of the required large-modulus tail; and
- no lower-bound proposition has been refuted by a genuine seed
  counterexample.
