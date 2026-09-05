# Unbounded endpoint-residue obstructions to Boolean counting

Author: ChatGPT  
Date: 2026-09-05  
Baseline: `6118955d20b4edd32e577e06d1060f3945358dd9`

**Status.** Complete ordinary proofs follow. This extends the repository's
already proved finite NBF counterexample, not the abc conjecture. The finite
algebraic kernel is supplied in Lean, with explicit scope. The whole Dirichlet,
CRT and valuation construction is not claimed kernel-checked. No claim of
priority, external peer review, unconditional abc, or disproof of FCRT-1 is made.

## 1. Exact target

For a primitive positive triple `(a,b,c)`, `a+b=c`, let `J` be the primes of `ab`.
If `p^e || c`, `e>=2`, its endpoint group is `G_p=(Z/p^e Z)^*`. Packets contain
whole prime-power factors, and `Phi_p(U)=a_U/b_U`. Compatibility is
`p^e | a_U+b_U`, equivalently `Phi_p(U)=-1`.

The September 4 anchored-prefix note refuted the raw implication
`2^|J|>|G_p| -> a nonempty proper compatible packet exists` at `(1,4715,4716)`.
We show that the counting ratio can be unbounded on genuine primitive endpoints,
including a compatible saturated donor block, without creating a proper face.

## 2. Exact order and valuation

**Lemma 2.1.** For `e>=1`,

    v_3(2^(3^(e-1))+1)=e,    ord_(3^e)(2)=2*3^(e-1).

**Proof.** Put `A_t=2^(3^t)`. Initially `A_0+1=3`. For `A_t=-1+3u`,
`A_t^2-A_t+1=3(1-3u+3u^2)` has exact valuation one. The identity
`A_(t+1)+1=(A_t+1)(A_t^2-A_t+1)` proves the first formula by induction.
For the order, `2^n=1 mod 3^e` requires `n=2u`. Write `u=3^t s`, `3` not
dividing `s`. Factoring `4^(3^t)-1` into `2^(3^t)-1` and `2^(3^t)+1` gives
valuation `t+1`. The geometric sum
`(4^(3^t s)-1)/(4^(3^t)-1)` is `s mod 3`, so has valuation zero.
Thus `v_3(4^u-1)=1+v_3(u)`. It follows that `3^(e-1)|u`, and the first
formula provides the exponent `2*3^(e-1)`. QED.

## 3. Infinite arithmetic family

**Theorem 3.1.** For every `e>=2`, put `m=3^(e-1)`. There are infinitely many
squarefree products `B` of `m` distinct primes such that `(1,B,B+1)` satisfies:

- `v_2(B+1)=2`, `v_3(B+1)=e`;
- `|G_3|=2m`, every sink label is `2^(-1) mod 3^e`, and only the full packet
  has label `-1`; no nonempty packet has identity label;
- the full-packet donor with source `{2}` is compatible and saturated with
  positive surplus, but has no proper-face FCRT flag to the target `3`;
- the raw counting ratio is `2^m/(2m)`, unbounded with `e`.

**Proof.** Set `Q=3^(e+1)`. CRT gives a unit residue `r mod 8Q` with
`r=2 mod Q` and `r=3 mod 8`. Dirichlet's theorem supplies infinitely many
primes in that progression. Choose distinct `q_1,...,q_m` and let `B` be their
product. Varying one prime gives infinitely many products at each `e`.
The first coordinate one guarantees positivity and primitivity.

Since `m` is odd, `B=3^m=3 mod 8`; hence `v_2(B+1)=2`. Also
`B+1=2^m+1 mod 3^(e+1)`, so Lemma 2.1 gives the exact valuation `e`.
Every prime occurs to exponent one on the B-arm, and its label is
`g=q_i^(-1)=2^(-1) mod 3^e`. This element has order `2m` and `g^m=-1`.
A packet of cardinality `k<m` has label `g^k`, distinct from `g^m` by
injectivity of the first `2m` powers. For `0<k<=m`, it is also distinct from
one. Thus neither a proper target face nor a positive zero-sum deletion exists.

The source `{2}` has full modulus four and demand `log 2`. The full packet
is compatible and has capacity `log B>log 2`. A flag to `3` would require
the proper target face just excluded. Indeed no block at this point can emit
a flag to `3`, because such a face would be a proper subset of `J`.

Finally the group order is `2*3^(e-1)=2m`, while the cube has `2^m` packets.
For `m>=3`, `2^m/(2m)>=binomial(m,3)/(2m)=(m-1)(m-2)/12`, which tends to
infinity along the stated values of `m`. QED.

**Corollary 3.2.** For every real `C>0`, some such points satisfy
`2^|J|>C|G_3|` without a proper compatible packet. No fixed multiplicative
increase of the retired NBF counting threshold repairs the implication.

**Proof.** Choose `e` with the ratio in Theorem 3.1 larger than `C`. QED.

## 4. These are not abc or FCRT counterexamples

**Proposition 4.1.** Every constructed point has

    c<rad(abc),    Delta=(log c-log rad(abc))_+=0,
    B_FCRT=B_SCRT=0.

**Proof.** Squarefreeness and coprimality give `rad(abc)=B rad(B+1)`.
Both two and three divide `B+1`, so `rad(abc)>=6B>B+1=c`.
For the endpoint masses `X=log(c/rad(c))` and `Y=log B`, this gives `X<Y`.
The full block `(I,J)` is compatible, since its modulus divides `c`, and
saturated. It covers every source at boundary zero. Nonnegativity completes
the optimization argument. QED.

Thus the result strengthens only the already retired NBF child. SCRT-0,
FCRT-1 and abc remain open. Requiring every saturated donor to have a useful
flag is stronger than optimizing over all configurations and is false here.
The valid anchored-prefix theorem is not refuted: every nonempty reservoir
has at most `m` generators but generates a group of size `2m`, so its
sufficient prefix-count premise fails.

## 5. A valid positive combinatorial replacement

**Theorem 5.1 (central-binomial criterion).** Let an `m`-element packet carry
labels in an abelian group, and suppose its packet products lie in a finite
subgroup of order `h`. If

    2^m > h * binomial(m, floor(m/2)),

there is a nonempty identity-product deletion. If the full label is
`tau != 1`, its complement is a nonempty proper packet with label `tau`.

**Proof.** In the absence of an identity-product deletion, every label fibre
is an antichain: comparable distinct equal-label packets would give an
identity-product difference. An antichain has at most the central binomial
coefficient members. To see this directly, an `r`-set lies in
`r!(m-r)!` of the `m!` maximal chains indexed by permutations. An antichain
meets any chain at most once. Dividing the resulting count by `m!` gives
`sum_A 1/binomial(m,|A|)<=1`, which implies the bound. Summing over at most
`h` fibres contradicts the displayed hypothesis. Cancellation gives the
complement assertion; the deletion cannot be the whole packet. QED.

This is a standard finite-combinatorial consequence, not a novel global
estimate. It is often weaker than the ordered light-reservoir criterion.
If it holds on a reservoir `K` of nonnegative total weight `y(K)<=x(S)`,
the resulting deletion `D` has weight at most `x(S)`. Hence its complementary
witness has weight at least the block surplus and can reuse the full surplus
under the existing FCRT cap. No claim is made that difficult arithmetic
endpoints meet these premises.

## 6. Remaining research boundary

The substantive uniform problem is on `X>Y` and concerns the best permissible
configuration. It must allow choosing blocks, reservoirs and targets, rather
than forcing a flag at an arbitrary donor on every point. The new family lies
entirely in the easy `X<Y` region and does not resolve that problem.

IUT still needs the source-faithful all-place/order objects, Ind3 comparison,
same-pilot transport and a noncircular uniform height theorem. Mochizuki's
April 2026 report describes an early skeletal Stage 1, not a released
unconditional abc term. No missing IUT input is supplied here.

For Mason specialization, bad specialization primes and coefficient heights
still require control. Frey/Szpiro, Vojta and S-unit routes need constants
uniform as curves and supports vary. Primitive-divisor existence in the Pell
route alone does not imply valuation one. All these routes remain active.
Bae's September 3 revision has a useful anchored-fibre lemma, but its separate
binomial-coefficient tail estimates are not an endpoint uniformity theorem.

## 7. Formal and computational scope

`Lean/IUTThreeClosures/EndpointConstantResidueObstruction.lean` contains
finite-group packet lemmas and a direct use of Mathlib's established Dirichlet
theorem. Its exact-order assumption is explicit. It does not formalize the
whole CRT/valuation realization, the real-log radical identity, or Theorem
5.1's antichain argument. Those have ordinary proofs above and must not be
promoted to kernel-checked statements merely because the companion builds.
Actual checks are reported separately; writing a file is not a successful build.

The deterministic Python replay uses trial-division certified primes, exact
valuations and exact modular arithmetic. It checks every possible subset
cardinality; constant labels make this exhaustive for packet labels. It does
not enumerate all `2^m` subsets, factor large `B+1`, optimize FCRT, or supply
an infinite-family computational proof.

## Sources

- Baseline `6118955d20b4edd32e577e06d1060f3945358dd9`, especially
  `research/ABC_ROUTE_BOTTLENECKS.md`,
  `research/ABC_ENDPOINT_RESIDUE_CUBE_FLAGGED_CRT_2026_09_04.md`, and
  `research/ABC_ANCHORED_PREFIX_FLAGGED_CRT_2026_09_04.md`.
- Mathlib `Mathlib.NumberTheory.LSeries.PrimesInAP`, theorem
  `Nat.forall_exists_prime_gt_and_modEq`:
  https://leanprover-community.github.io/mathlib4_docs/Mathlib/NumberTheory/LSeries/PrimesInAP.html
- Mathlib `Mathlib.GroupTheory.OrderOfElement`, theorem `pow_injOn_Iio_orderOf`:
  https://leanprover-community.github.io/mathlib4_docs/Mathlib/GroupTheory/OrderOfElement.html
- Ji Ho Bae, *Unbounded logarithmic limsup in Erdos Problem 684 via shifted
  carry scheduling*, arXiv:2604.23784v3, revised 2026-09-03:
  https://arxiv.org/html/2604.23784v3
- Shinichi Mochizuki, *Formalization of IUT*, April 2026:
  https://www.kurims.kyoto-u.ac.jp/~motizuki/Formalization%20of%20IUT%20(2026-04).pdf
