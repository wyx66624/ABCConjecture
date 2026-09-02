# Independent audit: balanced Mersenne multiplier/depth localization

**Auditor:** Codex independent review agent  
**Date:** 1 September 2026

## Verdict

The mathematical reduction, its asymptotic quantifiers, the cited Yamada
input, the exact-order LTE transport, the counterexample boundary, and the
Lean finite core are sound. I found no proof-breaking defect and no mandatory
mathematical or formal correction. The two surviving arithmetic estimates
remain open; this audit gives no reason to retire either route.

One nonblocking wording clarification is advisable. Relative to the preceding
denominator `log(3m) L_m^2`, the new one-copy cutoff is strictly larger only
when `0 < eta < 1`, equal when `eta = 1`, and smaller when `eta > 1`. The
theorem for every fixed `eta > 0` is correct, and its family is a strict
improvement because one may choose `eta` in `(0,1)`. Statements saying that
the cutoff is *strictly* improved should make this comparison explicit.

## Proof audit

1. The four-part identity is exact prime by prime. A prime of depth two
   contributes one copy through `U` or `B`; a prime of depth at least three
   contributes that copy and exactly `w_p - 2` further copies through `V` or
   `G`. Primes of depth one contribute zero to `a_d`.

2. For the adaptive one-copy estimate, `p = 1 + d r_p` and
   `p <= d^2/F` imply the strict inequality `r_p < d/F`. Distinct positive
   integral multipliers therefore give at most `d/F` primes as a real-valued
   bound. The window substitution `q=m/d` gives
   `q < (log(3m))^k`, and
   `sum_{q<Q} 1/q <= 1 + log Q = 1 + k L_m`. After division by `m`, the bound
   is `O_k(L_m^(-eta))`; all uses are for fixed `k, eta` and sufficiently large
   `m`.

3. Visual inspection of page 2 of
   `Yamada_2006_p_adic_Fermat_quotient_bound.pdf` confirms that Theorem 1.2,
   equation (7), is exactly
   `v_p(2^(p-1)-1) <= floor(283 (p-1) log(3) log(6)/(log p)^2) + 4`
   for every prime `p`. For an odd exact-order prime,
   `p-1 = d r`, `1 <= r < p`, and hence `p` does not divide `r`. Ordinary LTE
   then gives
   `v_p(2^(p-1)-1) = v_p(2^d-1) + v_p(r) = w`.
   Subtracting two from Yamada's inequality produces the stated `+2` error,
   and `d < p < 1+dH` gives the displayed logarithmic envelope. No density
   conclusion is imported from Yamada.

4. Injective positive labels below the integral threshold `H` form a subset
   of `{1,...,H-1}`. Thus both the cardinality `H-1` and the triangular energy
   `H(H-1)/2` are exact. In the divisor window, `d > m/Q_m` makes
   `1/log d <= 1/log(m/Q_m)`, while the number of positive co-divisors is less
   than `Q_m`. With
   `H^2 <= log(3m)/L_m^(1+eta)` and
   `log(m/Q_m) = log m - k L_m ~ log m`, the normalized triangular term is
   `O_k(L_m^(-eta))`. The remaining term
   `2 H Q_m log(1+mH)` is polylogarithmic for fixed `k, eta`, hence `o(m)`.

5. The inherited Lean theorem
   `log_mersennePowerLoss_isLittleO_iff_all_fixedPolylogBlockMass` has the
   required order of quantifiers: every fixed positive integer window is
   little-oh. Its contrapositive yields one fixed `k` for which the localized
   nonnegative mass is not little-oh. Negating little-oh then supplies a fixed
   positive `epsilon` and an unbounded failure sequence. Removing the two
   controlled little-oh arms leaves two nonnegative arms; every fixed
   `gamma < 1/2` is valid, and infinite pigeonhole permits the selected arm
   and subsequence to depend on `gamma`. Finally,
   `p > d^2/F` is equivalent to the claimed strict square-root inequality.

## Literature scope

Visual inspection of page 3 of
`Li_Zhao_2026_higher_Wieferich_prime_ideals.pdf` confirms that their Theorem
1.1 fixes a prime ideal and a non-torsion `alpha`, and only then produces a
threshold `v`. In the unramified case the successive kernel is nontrivial for
all `r>v`; the theorem supplies no threshold uniform over varying rational
primes and no estimate for the initial fixed-base-two depths used here.

The stated boundaries for the other papers are also correct. Erdős--Murty is
global and unweighted; Murty--Séguin supplies the exact-order cyclotomic
valuation dictionary and Brun--Titchmarsh input, not the surviving localized
weighted estimates; Shparlinski averages consecutive base variables (and in
one result also averages over primes), so it does not specialize to the fixed
base-two intersection; Fellini--Murty's quantitative conclusions require
number-field abc or finiteness of the relevant super-Wieferich primes.

All seven pre-audit files listed in `SHA256SUMS` matched their recorded hashes.

## Formal and counterexample checks

Direct compilation of
`MersenneBalancedMultiplierDepthLocalization20260901.lean` with
`-DwarningAsError=true` passed. A scan found no `sorry`, `admit`, custom
`axiom`, or `native_decide`. Every printed theorem reports only `propext`,
`Classical.choice`, and `Quot.sound`. The module honestly formalizes the
finite multiplier/LTE/ledger core and does not assert Yamada's theorem or the
real asymptotics as Lean axioms.

I reran the independent segmented-sieve verifier for the sealed scan through
`10,000,000`. It recomputed all `664,579` prime positions and again found only

| `p` | exact order `d` | canonical depth `w` | multiplier `(p-1)/d` |
|---:|---:|---:|---:|
| 1093 | 364 | 2 | 3 |
| 3511 | 1755 | 2 | 2 |

The order, square divisibility, failure modulo the next prime power, and
multiplier were independently rechecked. Thus `3511` is a full-premise
counterexample to the stronger pointwise assertion that every repeated
exact-order prime has multiplier at least three. Neither row is deep, and no
depth-at-least-three row occurs in this finite range. This finite no-hit is not
evidence for an asymptotic theorem and does not refute or retire the deep
route.

The complete-label packets correctly refute a linear energy inference made
from injectivity alone, and `(2,0,0,1,1)` correctly refutes every two-arm share
strictly above one half. Both are explicitly labeled as abstract and are not
misrepresented as Mersenne packets. I found no full-premise counterexample to
the new adaptive one-copy estimate, the low-multiplier deep estimate, or either
surviving arithmetic closure target.
