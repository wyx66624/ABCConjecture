# Balanced persistence continuation for abc

Author: ChatGPT. Date: 2026-08-31.

## 0. Status, method, and route-retention rule

The standard unconditional abc conjecture remains neither proved nor
disproved.  This continuation keeps the positive proof search and the
counterexample search active at the same time.  It does not promote a
finite computation, a conditional theorem, a primitive-divisor theorem, or
a critical-slope family into a solution of abc.

The working order is mandatory:

1. state the exact mathematical claim and prove it on paper;
2. identify every external theorem and every still-open arithmetic premise;
3. formalize only the proved deterministic core in Lean; and
4. audit the formal declaration against the unchanged standard
   `ABCConjecture`.

An unproved distribution statement is not inserted as a project axiom.
In particular, the repository does not assume an unbounded squarefull Pell
subsequence, a squarefull Danilov remainder, a powerful Mordell
elliptic-divisibility coordinate, a powerful Walsh coordinate, or the
missing repeated-prime lower bound in the affine fibre.

The route-retention rule is equally strict.  Difficulty, lack of a current
proof, failure of a finite search, or the presence of a strong necessary
condition does not eliminate a route.  A concrete counterexample eliminates
only the exact universal proposition it contradicts.  A proved no-go theorem
closes only the construction mechanism inside its stated hypotheses; it
does not close broader routes involving moving kernels, sparse arithmetic
specializations, or different parameter spaces.

The detailed inputs synthesized here are:

- [the affine amplification attack](ABC_AMPLIFICATION_GATE_ATTACK_2026_08_31.md)
  and its [independent cross-audit](ABC_AMPLIFICATION_GATE_CROSS_AUDIT_2026_08_31.md);
- [the deep Pell/Lucas attack](ABC_PELL_SQUAREFULL_DEEP_ATTACK_2026_08_31.md)
  and [adjacent-factor gate](ABC_PELL_ADJACENT_FACTOR_GATE_2026_08_31.md);
- [the Hall squarefull gate](ABC_HALL_SQUAREFULL_GATE_2026_08_31.md);
- [the alternative-family primary-source audit](ABC_ALTERNATIVE_COUNTEREXAMPLE_FAMILIES_2026_08_31.md);
- [the mixed-full kernel-escape report](ABC_COUNTEREXAMPLE_CAMPANA_ESCAPE_2026_08_31.md); and
- [the exact subcritical-locus equivalence](ABC_SUBCRITICAL_LOCUS_UNIFORMITY_2026_08_31.md).

Primary-source metadata and archived copies are recorded in
[the alternative-family source manifest](sources/alternative_counterexample_2026_08_31/source-metadata.json)
and [the Pell/Lucas source manifest](sources/pell_squarefull_deep_2026_08_31/source-metadata.json).

## 1. One common standard-abc test

For a positive primitive point

`a+b=c`,  `gcd(a,b)=1`,

write

`H=log c`,  `R=log rad(abc)`.

An unbounded primitive family satisfying

`R <= sigma H + O(1)`

for one fixed `sigma<1` disproves the unchanged standard abc conjecture.
The mixed-full certificate is a special case: if the three entries are
respectively `p`-, `q`-, and `r`-full with

`1/p + 1/q + 1/r < 1`,

then the standard radical estimate already supplies such a fixed slope.
Every counterexample proposal below is tested for positivity, primitivity,
fixed slope or signature, and unbounded height.  Where a strict mixed-full
signature is used, it is also tested for residual-kernel escape.

In the positive direction, standard logarithmic abc is already proved
equivalent to height boundedness on every fixed subcritical radical locus.
Consequently a positive proof route must supply a pointwise uniform
mechanism.  A positive-power global count by itself, even with large gaps,
does not suffice.

## 2. Positive route: the affine-shear amplifier

### 2.1 Deterministic primitive fibre

Fix a primitive seed `a+b=c`, put `P=abc` and
`R_seed=rad(P)`, and define

`U=1+Ph`,

`V=1+P(h+ck)`,

`W=1+P(h+bk)`.

When `h,k>=1` and `gcd(U,k)=1`, the target

`(aU,bV,cW)`

is a positive pairwise-coprime abc point.  The parameter pair is recovered
from `U` and `V-U=cPk`, so the construction is injective.  A uniform
union bound shows that a positive absolute proportion of every sufficiently
large parameter square is admissible.

At target height below `c^8`, the full fibre has at least `c^6/32`
distinct primitive points.  This is a genuine amplifier before radical
conditions are imposed.

### 2.2 Exact missing radical statement

Let

`E(n)=n/rad(n)`

be the repeated-prime excess and let `C_target=cW` be the target's largest
coordinate.
For every affine output the low-radical condition is exactly

`E(U)E(V)E(W) > (R_seed/c) U V (C_target)^(1-mu)`.

Here `C_target` is a numerical height, rather than its logarithm.

At `mu=3/4`, every exceptional point in the upper parameter box must have

`E(U)E(V)E(W) > R_seed c^14 / 8192`.

Equivalently, its square-root divisor `Q(UVW)` is much larger than the
whole parameter side length.  The old seed powers do not certify even one
nontrivial output: all success must come from repeated primes newly occurring
in the three affine factors.

For

`rho=log(P)/log(c)`,  `sigma=log(R_seed)/log(c)`,

the actual exceptional subfibre has the unconditional three-way budget

`|E_c| << c^(min(12-2rho, 6-sigma, 8-rho-sigma/3)+epsilon)`.

The number `14/3` is only the lower envelope of these available
upper-budget exponents on the relaxed worst-shape rectangle
`rho<3, sigma<1`.  It is not a uniform upper bound for every seed.
On a fixed locus `R_seed<c^lambda`, the corresponding relaxed envelope
is `5-lambda/3`.  The open target `|E_c|>=c^(17/4)` lies safely above
the BBLT counting threshold `c^4` and below the universal worst-shape
budget.

The exponent `1/2` behind this BBLT threshold comes from Proposition 1.1:
at `mu=3/4` its exponent is `2mu/3=1/2`.  Theorem 1.3's exponent `3/5`
is a weaker alternative at this value of `mu`; it does not replace the
Proposition 1.1 estimate.  With target bound `X=c^8` and `delta=1/64`, the
actual upper exponent is `4+8delta=33/8<17/4`.

Thus the affine route remains active.  Its precise missing theorem is a
seed-uniform lower bound for actual repeated-prime excess in three linked
affine forms.  Existing sieve moments and support counts give upper bounds
or generic squarefreeness; they cannot be reversed into this required lower
bound.

### 2.3 Local mechanisms that are closed, and those that survive

The following conclusions have exact limited scope:

- a fixed-full one-dimensional slice cannot cross the BBLT gate through its
  displayed fullness certificate;
- the certified odd-power CRT thickening has zero power exponent;
- exact square completion produces only `c^o(1)` certified parameters;
- a fixed packet of imposed prime powers loses at least the density that its
  radical saving gains; and
- carrying only inherited seed powers through the shear certifies no
  nontrivial exceptional output.

These theorems do not refute accidental large powers, large-modulus tails,
different target fibres, or the full two-parameter affine shear.  None is a
reason to abandon the active amplifier.

## 3. Pell and Lucas: the sharpest explicit counterexample gate

Let

`u_0=0`,  `u_1=1`,  `u_(n+2)=6u_(n+1)-u_n`.

This is the balancing sequence `U_n(6,1)`, arising from
`(3+sqrt(8))^n=x_n+u_n sqrt(8)`.

### 3.1 Exact square-root descent

Write

`(1+sqrt(2))^n=A_n+B_n sqrt(2)`.

Then

`x_n=A_n^2+2B_n^2`,

`u_n=A_n B_n`,

`A_n^2-2B_n^2=(-1)^n`,

and `gcd(A_n,B_n)=1`.  Therefore

`u_n is squarefull iff A_n and B_n are both squarefull`.

The unresolved premise is consequently simultaneous squarefullness of two
coprime companion Pell coordinates, rather than an unspecified large square
factor.

The norm identity gives primitive adjacent points

- `(1,2B_n^2,A_n^2)` for even `n`; and
- `(1,A_n^2,2B_n^2)` for odd `n`.

If `u_n` is squarefull, their radicals satisfy

`log rad <= (1/2) log height + log 2`.

An unbounded squarefull subsequence would therefore disprove standard abc.
On even indices the same family has the fixed strict signature
`(3,4,4)`, with reciprocal sum `5/6`.  The older points
`(1,8u_n^2,x_n^2)` give the weaker but still strict signature
`(7,3,2)`, with reciprocal sum `41/42`.

### 3.2 Strong necessary conditions do not refute the route

Strong divisibility, ranks of apparition, and Sanna's valuation formula give
an exact saturation rule.  The finite propagation currently proves that
every even squarefull index is divisible by

`22,318,790,340`.

This is a finite necessary condition, not an eventual nonexistence theorem.
The largest-prime descent is stronger: if `u_N` is squarefull and
`N>1`, then the term at the largest prime divisor of `N` is itself
squarefull.  It is therefore enough to settle squarefullness at odd prime
indices.

Carmichael and Bilu--Hanrot--Voutier guarantee primitive divisors in their
respective ranges, but neither theorem guarantees valuation one.
Squarefullness at a prime index forces at least two distinct
balancing-Wieferich primes of that same rank.  This double-Wieferich packet
is a sharp necessary condition, not a contradiction.

No unconditional theorem in the audited literature proves an exponent-one
prime divisor in every sufficiently large `u_n`, and that literature supplies
no unbounded squarefull subsequence.  Perfect-power classifications do not
decide squarefull values.
Results of Ribenboim--Walsh and Yabuta that force finiteness of powerful
Lucas terms assume abc and cannot be used to prove abc here.  The Pell/Lucas
route remains active in both directions: seek simultaneous squarefull
coordinates, or prove an eventual valuation-one theorem.

## 4. Hall and Danilov: a moving-remainder gate

For positive coprime `X,Y` satisfying

`X^3+K=Y^2`,

the triple `(X^3,K,Y^2)` is primitive.  If `K` is squarefull and
`K^2<=X`, then

`rad(X^3 K Y^2)^12 < (Y^2)^11`.

Thus an unbounded family satisfying these hypotheses has radical slope
strictly below `11/12` and disproves standard abc.

Danilov's identity, in the audited Dujella normalization, supplies an
unconditional unbounded primitive family at the critical Hall scale:

`X^3+K=Y^2`,  `K asymptotic to constant * sqrt(X)`,

with the constant below one, so `K^2<=X` holds on a tail.  What remains is
squarefullness of the moving remainder `K` at unbounded indices.

For every fixed exponent `m>=2`, imposing that the moving linear factor
is one exact `m`th power reduces to a fixed positive-genus
hyperelliptic curve; Siegel's theorem gives only finitely many integral
points.  This closes the exact-fixed-power specialization only.  It does
not settle squarefull values, because a squarefull integer may have
independently moving square and cube kernels.  The Danilov squarefull
remainder route therefore remains active.

## 5. Mordell elliptic divisibility: an unbounded critical family

On the Mordell curve

`E: y^2=x^3-2`,  `P=(3,5)`,

write a multiple in lowest terms as

`nP=(A_n/B_n^2, C_n/B_n^3)`.

Then

`C_n^2+2B_n^6=A_n^3`

is pairwise coprime.  The point `P` is nontorsion, and on the unbounded
even-index subsequence `B_n` is even.  Hence the three entries have
signature

`(2,6,3)`,

whose reciprocal sum is exactly one.  This is a genuine critical family,
not an abc counterexample.

Three deterministic strict upgrades remain active:

1. powerful `|C_n|` gives signature `(4,6,3)`, sum `3/4`;
2. powerful `A_n` gives signature `(2,6,6)`, sum `5/6`;
3. a powerful odd part of `B_n` gives signature `(2,7,3)`, sum
   `41/42`.

Silverman's eventual primitive-divisor theorem for elliptic divisibility
sequences, the strong divisibility law, and valuation lifting control
support novelty and recurrence of old primes.  They do not determine the
valuation at first appearance.  Alfaraj's explicit example with primitive
divisors already squared shows why primitive does not mean exponent one.
Perfect-power finiteness in a different curve class also does not prove
finiteness of powerful terms here.  None of the three strict upgrade gates
has been disproved.

## 6. Cohn--Nitaj and Walsh: genuine infinite families on the critical line

Nitaj proved that there are infinitely many positive pairwise-coprime
3-full solutions of `a+b=c`.  Cohn strengthened the construction so that
none of the three entries need be a perfect cube.  This is an unconditional,
height-unbounded family with fixed signature

`(3,3,3)`,

but its reciprocal sum is exactly one.  The 3-full property alone therefore
does not disprove abc.  This result is also a warning that restricting a
search to exact cubes misses genuine full-number phenomena.

Walsh proves that when the Mordell curve

`Y^2=X^3-432p^2`

has positive rank for the specified odd prime `p`, there are infinitely
many pairwise-coprime solutions

`x^3+y^3=p^4 z^3`.

After the necessary sign normalization these give primitive abc points.
Their base signature is again `(3,3,3)`, hence critical.  They become
strict only after a new arithmetic input:

- powerful `|x|` or `|y|` gives signature `(6,3,3)`, sum `5/6`;
- powerful `|z|` gives signature `(3,3,4)`, sum `11/12`.

No cited theorem supplies an unbounded powerful-coordinate subsequence.
The base critical certificate is insufficient, while the strict upgrade
routes remain active.

## 7. Exact local no-go theorems

The following statements are rigorously closed only in the displayed scope.

### 7.1 Finite residual-kernel packets

For fixed strict exponents `p,q,r`, canonical full-number decomposition
turns a mixed-full abc point into

`A X^p + B Y^q = C Z^r`.

Darmon--Granville gives only finitely many proper solutions for each fixed
nonzero coefficient triple.  Therefore an unbounded strict mixed-full
family must visit infinitely many residual-kernel triples.  This rules out
one fixed generalized-Fermat equation and every finite packet of them.  It
does not rule out one Pell or elliptic source curve whose integer points
induce infinitely many residual kernels.

### 7.2 Polynomial-full tripods

Mason--Stothers proves that three nonconstant pairwise-coprime polynomial
entries satisfying `A+B=C` cannot algebraically carry fixed fullness
exponents whose reciprocal sum is at most one.  This closes a full
polynomial tripod after primitive cancellation.  It does not rule out
sparse integer parameters at which polynomial values acquire accidental
high valuations, nor rational specializations with moving denominator
kernels.

### 7.3 Critical certificates

Ordinary consecutive powerful pairs and the Cohn--Nitaj and Walsh
3-full families reach only slope one under their displayed fullness
certificates.  This proves that those certificates alone are insufficient.
It does not prove that their actual radicals never enjoy an additional
uniform saving on a subsequence.

### 7.4 Primitive divisors

A primitive-divisor theorem is a theorem about first occurrence of support,
not first-occurrence valuation.  It cannot be used as a no-go theorem for a
squarefull sequence unless an exponent-one conclusion is separately proved.
This distinction applies to both Lucas and elliptic divisibility sequences.

## 8. Consolidated route ledger

| Route or mechanism | Unconditional result now available | Missing statement | Exact status |
|---|---|---|---|
| Affine shear | Primitive injective fibre of raw size at least `c^6/32`; exact excess criterion and three-way upper budget | Uniform lower bound such as `|E_c|>=c^(17/4)` for actual exceptional outputs | **Active positive route** |
| Balancing Pell/Lucas | Exact coprime square-root factorization, half-slope adjacent points, saturation and prime-index descent | Unbounded squarefull terms, or eventual valuation-one divisors | **Active in both directions** |
| Hall squarefull gate | Squarefull `K` with `K^2<=X` gives slope below `11/12` | An unbounded family satisfying the squarefull premise | **Active counterexample gate** |
| Danilov family | Explicit unbounded primitive Hall family at critical scale | Squarefull moving remainder on an unbounded subsequence | **Active; exact fixed powers alone closed** |
| Mordell EDS | Explicit unbounded primitive `(2,6,3)` family | One of three powerful-coordinate upgrades | **Critical base; upgrades active** |
| Cohn--Nitaj | Infinite primitive `(3,3,3)` family | Extra actual radical saving beyond 3-fullness | **Critical certificate only** |
| Walsh | Infinite primitive `(3,3,3)` family under the stated positive-rank hypothesis | Powerful `x`, `y`, or `z` subsequence | **Critical base; upgrades active** |
| Finite generalized-Fermat kernel packet | Darmon--Granville finiteness | Moving kernels lie outside the theorem | **Closed only for finite packets** |
| Polynomial-full identity | Mason--Stothers obstruction | Sparse powerful values lie outside the theorem | **Closed only for algebraic fullness** |

No row marked active is downgraded because the missing theorem is difficult.
No row marked closed supports a broader claim than the theorem stated in
that row.

## 9. Reproducible finite-search boundary

The final finite-search evidence is preserved permanently in
[the targeted counterexample-search bundle](computation/2026_08_31_targeted_counterexample_search/REPORT.md),
with [reproduction instructions](computation/2026_08_31_targeted_counterexample_search/REPRODUCE.md)
and a [file manifest](computation/2026_08_31_targeted_counterexample_search/manifest.json).
After copying the bundle, `exact_audit.py` was rerun from the permanent
directory.  All 85 manifest entries match their recorded sizes and SHA256
values.  The manifest SHA256 is
`62abe5c80716d9e4d5697df95e5330b9fb3d011f463d4647e72332c9288bbac3`.

The exact certified conclusions are deliberately finite:

1. For the balancing recurrence, every one of the 999 terms with
   `2<=n<=1000` has an explicit prime `p` with `v_p(u_n)=1`.  This includes
   all 168 prime indices in that interval, so every term in this exact range
   is proved non-squarefull.
2. In the exploratory extension through `n=2000`, 1,990 of the 1,999
   nonunit terms have such certificates.  The nine indices
   `1009, 1181, 1667, 1699, 1723, 1847, 1873, 1901, 1951` remain unresolved:
   they are neither squarefull hits nor certified non-hits.  The formerly
   unresolved composite index `1711=29*59` is now certified by
   `p=44560482149` through a direct computation modulo `p^2`.
3. For the forward Danilov orbit, every one of the 81 points with
   `0<=t<=80` has an explicit prime satisfying `v_p(K_t)=1`, hence none of
   those 81 remainders is squarefull.  The five-small-prime periodic sieve
   first leaves `t=326` uncovered.  That is a sieve noncertificate, not a
   squarefull hit.

These computations do not prove eventual valuation one, do not decide any
of the nine unresolved balancing terms or the Danilov point at `t=326`, and
do not close either the Pell or Danilov route.  They are exact local
non-hit certificates and finite-search diagnostics only.

## 10. Lean formalization boundary and declaration inventory

The mathematical proofs preceded the Lean layer.  The four new mathematical
modules formalize deterministic cores only:

| Module | Formalized scope | Theorems | Definitions or structures | Total |
|---|---|---:|---:|---:|
| [PellAdjacentFactorCounterexample20260831.lean](../Lean/IUTThreeClosures/PellAdjacentFactorCounterexample20260831.lean) | Pell half-factorization, primitive adjacent point, half-slope bound, conditional standard-abc negation | 13 | 2 | 15 |
| [PellSquareRootDescent20260831.lean](../Lean/IUTThreeClosures/PellSquareRootDescent20260831.lean) | Square-root orbit, norm and coprimality identities, parity shapes, squarefull equivalence | 14 | 1 | 15 |
| [HallSquarefullCounterexample20260831.lean](../Lean/IUTThreeClosures/HallSquarefullCounterexample20260831.lean) | Primitive Hall point, twelfth-power radical bound, conditional standard-abc negation | 7 | 2 | 9 |
| [AffineShearAmplification20260831.lean](../Lean/IUTThreeClosures/AffineShearAmplification20260831.lean) | Shear equation, cofactor and endpoint coprimality, actual point, parameter injectivity | 28 | 10 | 38 |
| **Total** |  | **62** | **15** | **77** |

This count means explicitly written top-level source declarations:
62 theorems, 11 definitions, and 4 structures.  It does not include
constructors, field projections, recursors, or equation declarations that
Lean generates automatically from those definitions and structures.

The companion
[ResearchBalancedPersistence20260831Audit.lean](../Lean/IUTThreeClosures/ResearchBalancedPersistence20260831Audit.lean)
enumerates all 77 declarations with matching `#check` and
`#print axioms` commands.  It is an audit entry, not a fifth mathematical
module and not part of the 77 count.

The frozen Lean evidence is recorded in
[the balanced-persistence validation bundle](../Lean/verification/2026_08_31_balanced_persistence/VALIDATION.md).
The four modules and audit entry compile directly with exit code zero and no
warnings.  The audit-target build passes 8,767 jobs with 19 historical
dependency warnings and zero warnings attributed to the new modules.  Both
the library-target and default builds pass 9,147 jobs with 265 warnings; each
warning multiset exactly matches the frozen dual-route baseline.  Source and
kernel audits find no `sorry`, `admit`, axiom declaration, `unsafe`, or
`sorryAx`; the dependency union is exactly `propext`, `Classical.choice`, and
`Quot.sound`.  All 13 JSON files parse, the 22-file artifact manifest agrees
with the files, and all 23 entries in `SHA256SUMS` verify.  The SHA256 of
`SHA256SUMS` is
`4e25867f5026bbd04a05240de9d6f51e06abc6518bf9819d48aaa03d1bb85916`.
The released paper is
[ChatGPT_ABC_Balanced_Persistence_2026_08_31.pdf](../output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_08_31.pdf):
109 pages, 830,854 bytes, SHA256
`ccbc4d77d112aec78a869caba53104b133467f6cd4a60ee528e09437f79d2e3e`.
All 109 pages were rerendered at 110 dpi.  Relative to the immediately
preceding fully inspected candidate, only pages 102--109 changed; all eight
passed page-by-page inspection at original rendered size.  Extracted text
has 340,732 characters and every page has text, with a minimum of 1,926
characters.  All 29 font resources are embedded, and the PDF contains no
forms or JavaScript.  The final log has only one pre-existing underfull box.
The retained
[`QA directory`](../output/pdf/ChatGPT_ABC_Balanced_Persistence_2026_08_31_QA/)
has `SHA256SUMS` SHA256
`206f1edb9c9e190ec65c3333ddf2a3166fefe06f907e132f349725897be18e98`.

The following substantive results remain paper-only:

- the analytic BBLT, de Bruijn, and S-unit inputs and the missing affine
  exceptional-output lower bound;
- Sanna valuation lifting, Carmichael and Bilu--Hanrot--Voutier primitive
  divisors, and the Lucas--Wieferich frontier;
- the Mordell EDS construction and its external primitive-divisor inputs;
- the Danilov parametrization and Siegel finiteness step;
- the existence theorems of Nitaj, Cohn, and Walsh; and
- Darmon--Granville, Mason--Stothers, and Browning--Verzobio.

These external theorems are cited mathematical inputs.  The open upgrades
are neither Lean theorems nor hidden axioms.

## 11. Next concentrated attacks

The most concrete positive target is the affine statement
`|E_c|>=c^(17/4)` on every fixed subcritical source locus, or a different
amplifier with a proved exponent above its target-counting threshold.

The most concrete counterexample targets are:

1. simultaneous squarefull Pell coordinates `A_n,B_n`;
2. a squarefull Danilov remainder;
3. one of the three powerful-coordinate upgrades in the Mordell EDS family;
   or
4. a powerful-coordinate subsequence in Walsh's family.

The parallel negative target is an eventual valuation-one theorem for the
balancing sequence or a selected elliptic divisibility coordinate.  A proof
of that statement would close the corresponding squarefull premise only.
Until such a proof or an actual counterexample is obtained, the associated
route remains in the registry.

This continuation therefore records balanced persistence rather than a
premature verdict: standard abc remains open, the strongest explicit routes
remain active, and the local no-go theorems retain exactly their proved
scope.
