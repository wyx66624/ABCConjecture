# Holonomy, density, and deep-prime escape: a four-route abc continuation

**Author:** ChatGPT  
**Date:** 2026-09-01  
**Target:** the unchanged, standard, unconditional `ABCConjecture`

## 0. Exact status

This continuation does not contain an unconditional proof or disproof of the
abc conjecture. It advances positive deductions and counterexample searches
on four independent routes. No route is retired because it is difficult or
because a finite search has no hit. A route or mechanism is marked closed
only when a counterexample satisfies every hypothesis of the precise claim
being rejected.

The new strongest conclusions are:

1. a corrected, inhabited p-adic valuation-ball log-volume model obeys the
   desired prime-preimage shift, and every object-level closed transport has
   zero logarithmic holonomy;
2. rational-prime logarithmic holonomy cancels place by place for rational
   coefficients, while an explicit pair of different strictly positive
   normalized real weight systems has the same scalar log volume;
3. the minimal affine shear has a uniformly positive squarefree-admissible
   bulk on every seed range `R < c^theta`, `theta < 5/2`, while every desired
   three-quarter exception has high repeated-prime excess simultaneously in
   both long arms;
4. the balancing-Pell route has a pointwise simple-or-depth-three channel
   alternative, a second-order congruence modulo `4 ell^2`, and no
   depth-three prime below `10^9` in two independent exhaustive scans;
5. a squarefull survivor in the final Danilov progression would force at
   least `2^638-622` distinct Wall--Sun--Sun primes; a distinguished
   `2^637`-prime subfamily lies above `10^2199`, and one prime lies above
   `10^4399`.

## 1. Result and route ledger

| Route | New positive theorem | Full counterexample or finite search | Exact remaining gate | Disposition |
|---|---|---|---|---|
| Corrected IUT/LANA volume | Valuation balls are inhabited; prime preimages shift log volume by `log p`; closed pointed transport has zero holonomy; rational prime coefficients cancel locally | Two different positive normalized weight triples on `log 2, log 3, log 5` have the same scalar; arbitrary real prime-log coefficients are dependent | Construct and identify the complete q-pilot through every permitted link and correction, then prove object-level return with prime-local zero holonomy | Active; only scalar reconstruction and uncorrected positive-loop mechanisms are closed |
| Minimal affine shear | Exact support-closed gap recovery; every exception has high excess in `V` and `W`; positive squarefree-admissible bulk for `theta<5/2` | Extended conic search is finite only; a positive generic bulk is not a counterexample to a sparse exceptional lower bound | Construct the simultaneous two-arm high-excess tail, or construct support-closed low-radical gap triples, uniformly on the subcritical seed locus | Active |
| Balancing Pell | Channelwise simple-or-odd-depth-three escape; cofinite synchronized simplicity if the global depth-three set is finite; second-order and reciprocity ledgers | Exhaustive scan of all 50,847,533 odd primes through `10^9` finds only `13,31,1546463`, each exact depth two, and no depth three | Exclude or construct an actual same-rank four-prime packet with an opposite-channel depth-three pair | Active |
| Danilov/Fibonacci | A full final-progression survivor forces `2^638-622` distinct Wall--Sun--Sun primes; `2^637` exceed `10^2199`, and one exceeds `10^4399` | `Phi_10(-3)=11^2` with derivative and discriminant nonzero mod 11 refutes the generic multiple-root shortcut; the seven saved local primes do not cover the progression | Exclude the forced Wall--Sun--Sun population, find a new simple primitive divisor mechanism, or construct a survivor | Active |

## 2. The corrected-volume conclusions

For a rational prime `p` and integer `k`, define

```text
B_p(k) = {x in Q_p : |x|_p <= p^(-k)}.
```

Then multiplication by `p` has exact preimage `B_p(k-1)`, and normalized
Haar volume gives the log shift

```text
log vol((x ↦ p*x)^(-1) B_p(k)) = log vol(B_p(k)) + log p.
```

Normalized finite packets and positive-length averages preserve the same
common shift. If a transport has coordinate equation

```text
L(y) = L(x) + delta,
```

then composition adds deltas, reversal negates them, and `y=x` forces
`delta=0`. Thus an uncorrected loop with a positive accumulated prime shift
cannot be a same-pilot loop. A genuine correcting term must contribute the
negative of the accumulated shift.

For distinct rational primes and rational coefficients,

```text
sum_i c_i log p_i = 0
```

forces every `c_i=0` by denominator clearing, exponentiation, and unique
factorization. This supplies a place-by-place ledger when the local
coefficients are arithmetically rational.

There are two exact limits to scalar inference. Real coefficients satisfy

```text
(log 3)(log 2) - (log 2)(log 3) = 0,
```

so rationality cannot simply be dropped. More strongly, set

```text
a = log 2 < b = log 3 < c = log 5,
W = ((c-b)/(2(c-a)), 1/2, (b-a)/(2(c-a))),
V = ((c-b)/(3(c-a)), 2/3, (b-a)/(3(c-a))).
```

Every coordinate is positive, each triple sums to one, `W != V`, and both
weighted scalar averages equal `b`. This satisfies every hypothesis of the
claim that one positive normalized scalar recovers labelled weights, so that
claim is closed. It does not satisfy the hypotheses of an object-level
same-pilot theorem retaining the labelled local data.

The full proofs are in
`research/ABC_IUT_CORRECTED_VOLUME_HOLONOMY_2026_09_01.md`; the elementary
core is formalized in
`Lean/IUTThreeClosures/IUTCorrectedVolumeHolonomy20260901.lean`.

## 3. The affine division between generic bulk and exceptional tails

For a primitive seed `a+b=c`, let `R=rad(abc)` and

```text
U = 1 + R h,
V = 1 + R(h + c k),
W = 1 + R(h + b k).
```

The gaps recover the seed exactly:

```text
gcd(V-U, W-U) = R k,
(V-W, W-U, V-U)/(R k) = (a,b,c).
```

This also has a converse for `1<U<W<V`: an increasing cofactor triple is a
positive-parameter minimal shear when the radical of its normalized gap
triple divides both the common gap and `U-1`. The strict lower bound on `U`
is necessary. The full counterexample `(U,W,V)=(1,3,5)` satisfies the weaker
divisibility statement but yields `h=0`. The corrected theorem reformulates
the live construction as a support-closed gap problem.

On the three-quarter exceptional locus, the previous product inequality and
the canonical size bounds imply

```text
8192 E(V) > R c,    8192 E(W) > R c,
E(n) = n/rad(n).
```

Thus each desired point lies in simultaneous high-excess tails of two
different coprime affine forms.

Conversely, in the upper-half parameter box of side
`N ~ c^6/(8R)`, a direct union bound over inadmissibility and every possible
prime-square divisor leaves at least

```text
(1/2)(5 - pi^2/2) N^2
```

admissible pairs for which `U,V,W` are all squarefree, uniformly whenever
`R<c^theta` and `theta<5/2`. These outputs have radical at least their height.
The error is `O(N log M + M + N c^(7/2))`; it is `o(N^2)` exactly in the
stated range. This positive-density nonexceptional bulk can coexist with the
much thinner target exceptional population and hence does not refute the
matching lower bound.

The full proof and finite conic search boundary are in
`research/ABC_AFFINE_DENSITY_ATTACK_2026_09_01.md`.

## 4. The Pell second-order and finite-depth boundary

At an odd prime index `ell`, perfect-power classifications give, separately
in both Pell channels, an exponent-one divisor or an odd exponent at least
three. The latter divisor has first-occurrence rank `ell`. Therefore each
channel has either a cofinite set of simple prime indices or infinitely many
distinct prime-rank depth-three primes. If the global depth-three population
is finite, both channels have simple divisors at the same index for every
sufficiently large prime index.

The signed Fellini--Murty argument independently gives infinitely many
simple-index occurrences in each channel when the common super-Wieferich set
is finite. These are two separate infinite sets; no intersection statement
is inferred from infinitude alone.

Expanding the channel factorizations through their second quotient digit and
using the exact negative Pell identity gives

```text
K_A - 2 K_B + ell(K_A^2 - 2 K_B^2)
  + 2 ell(C_A - 2 C_B) = 0 mod 4 ell^2.
```

The all-pairs quadratic-character product supplies a second necessary packet
constraint. Neither condition is currently contradictory.

Two independent exhaustive implementations evaluate every odd prime
`q<=10^9`: one uses a segmented sieve and Lucas fast doubling, and the other
uses a dense sieve and binary powering in `Z[T]/(T^2-6T+1)`. Both enumerate
50,847,533 primes and return the same three exact depth-two hits and zero
depth-three hits. Arbitrary-precision replay checks each rare hit modulo
`q^3`. Hence any depth-three rational balancing prime, and in particular
each of the two required by a full opposite-channel packet, exceeds `10^9`.

The proof, exact quantifier boundary, source notes, and reproduction commands
are in `research/ABC_PELL_FOUR_PRIME_COUPLING_2026_09_01.md` and
`research/computation/2026_09_01_pell_four_prime_coupling/`.

## 5. Danilov divisor-pair amplification

The Danilov factorization is

```text
K_t = (27/25) F_N F_(N-5),    N = 10(3t+1),
gcd(F_N,F_(N-5)) = 5.
```

Let a squarefree `Q>1`, coprime to ten, divide `3t+1`. Pair the divisors of
`Q` by `d <-> Q/d` and choose the smaller member from each pair. For each
chosen `d`, Carmichael--Yabuta supplies a primitive divisor at rank `N/d`.
The split-rank congruence and `d<sqrt(Q)` ensure that this prime does not
divide `N`. Squarefullness of `K_t`, together with the exact Fibonacci
valuation formula, then transfers a square divisor back to the primitive
rank. Distinct ranks give distinct Wall--Sun--Sun primes.

If `Q` has `s` prime factors, this produces `2^(s-1)` distinct primes and
each is larger than `N/sqrt(Q)`. A factor-bound refinement uses every divisor
`e|Q` with `10e` larger than the greatest prime factor of `Q`. At the verified
endpoint the largest factor is `99,966,059`, and exact truncated subset-product
enumeration finds only 622 excluded divisors. The full survivor therefore
forces at least `2^638-622` distinct Wall--Sun--Sun primes. The half-divisor
subfamily of `2^637` primes is termwise larger than `10^2199`, while Hong's
large primitive-divisor theorem supplies one above `10^4399`.

This is an unconditional implication from the survivor hypothesis, but it is
not a contradiction because no theorem bounds the total Wall--Sun--Sun
population. The derivative example `Phi_10(-3)=11^2` closes only the generic
multiple-root shortcut. The detailed proof and finite local branch audit are
in `research/ABC_DANILOV_WSS_ESCAPE_2026_09_01.md`.

## 6. Proof, formalization, and claim boundary

Every new formal declaration was written after its corresponding
mathematical proof. Lean checks the valuation-ball identities, finite packet
shifts, holonomy algebra, rational prime-log independence, positive scalar
collision, affine algebraic invariants, Pell second-order algebra, and the
abstract Danilov witness-count and multiplicity-transfer kernels. Published
perfect-power, primitive-divisor, valuation, and number-field theorems remain
explicit paper inputs; they are not inserted as new axioms.

The final integration must pass direct compilation of all four new modules,
the aggregate `lake build IUTThreeClosures`, forbidden-token and declaration
scans, expected `#print axioms` parsing, computation-manifest replay, paper
compilation, and rendered PDF inspection. Until an unconditional Lean term
of `ABCConjecture` or its rigorous negation exists, the repository status
remains open.
