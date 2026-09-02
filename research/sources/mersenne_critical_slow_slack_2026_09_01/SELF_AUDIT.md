# Self-audit: critical slow-slack Mersenne gate

**Date:** 2 September 2026
**Auditor:** ChatGPT

## Verdict

The slow-slack theorem is an unconditional strengthening of the previous
fixed-power localization.  It does not prove either surviving arm is
little-oh and does not close abc.  No proof step uses a density heuristic,
abc, GRH, finiteness of super-Wieferich primes, or finite computational
absence.

## Mathematical audit

1. **Quantifiers.**  The function `sigma` is fixed before `m` tends to
   infinity.  It is positive, tends to infinity, and satisfies
   `L_m sigma(m) / log(3m) -> 0`.  The integer `k` is fixed.  The stronger
   comparison with every fixed `eta > 0` separately assumes
   `sigma(m) / L_m^eta -> 0` for every such `eta`.

2. **One-copy packet.**  From `p = 1 + d r_p` and
   `p <= d^2/F`, one obtains the strict bound `r_p < d/F`.  Multiplier
   injectivity gives at most `d/F` rows, and `F >= 1` gives
   `log p <= 2 log m`.  The harmonic co-divisor sum is at most
   `1 + k L_m`.  Division by `m` leaves
   `O(1/(L_m sigma(m)) + k/sigma(m))`, which tends to zero.

3. **Deep packet.**  Yamada plus exact-order LTE gives the previously
   audited fibre bound with triangular term `H(H-1)/2`.  Substitution of
   `H^2 <= log(3m)/(L_m sigma(m))` leaves `O_k(1/sigma(m))` after the
   harmonic window sum.  The error term is at most a fixed power of `log m`
   and hence is `o(m)`.

4. **Floor and strict comparison.**  Before flooring, the new-to-old
   multiplier-cutoff ratio is `sqrt(L_m^eta/sigma(m)) -> infinity`.
   Both raw cutoffs tend to infinity, so the floored new cutoff is eventually
   larger.  The size denominator ratio is `sigma(m)/L_m^eta -> 0`, hence the
   surviving one-copy threshold is eventually larger.  The report only
   claims containment of actual supports; it does not claim that a prime
   must occur in either difference band.

5. **Explicit slack.**  `sigma_*(m)=log(3+L_m)` tends to infinity,
   is `o(L_m^eta)` for every fixed positive `eta`, and satisfies
   `L_m sigma_*(m)=o(log(3m))`.  Thus all hypotheses are simultaneous.

6. **Euler-character identity.**  If `r` is even, the half exponent is a
   multiple of the exact order.  If `r` is odd, parity forces `d` even;
   exactness makes `2^(d/2)=-1 mod p`.  These cases give
   `2^((p-1)/2)=(-1)^r`, and Euler's criterion gives `(2/p)=(-1)^r`.
   The 64-entry residue enumeration is a direct consequence of the
   supplementary law for `2`.

7. **Two-arm extraction.**  The four nonnegative pieces still sum exactly
   prime by prime.  The newly enlarged `U` and `V` pieces are little-oh, so
   a failed endpoint leaves `G+B >= (epsilon-o(1))m`.  Any fixed share below
   one half is then obtained by the same infinite-pigeonhole argument as in
   the preceding audited gate.

## Counterexample boundary

- The exact arithmetic row `p=1093`, `d=364`, `w=2`, `r=3` satisfies all
  premises of the universal statement that every repeated exact-order
  multiplier is even and falsifies its conclusion.  Only that pointwise
  statement is retired.
- The complete-label family falsifies the precise abstract schema that
  positivity, injectivity, and a pointwise linear multiplier envelope force
  subquadratic packet energy.  It is not a prime packet.
- The critical arithmetic target with `sigma=1` has no known full-premise
  counterexample and remains active.
- The replay scan through `100000` contains no depth-three hit.  This finite
  absence is not used in any asymptotic proof and retires no route.

## Formal audit

The independent module is
`Lean/IUTThreeClosures/MersenneCriticalSlowSlackGate20260901.lean`.
Direct compilation with `-DwarningAsError=true` passes.  A lexical scan finds
no `sorry`, `admit`, `native_decide`, or custom `axiom`.  Every printed
theorem uses only the standard trusted axioms `propext`, `Classical.choice`,
and `Quot.sound` (some purely finite support theorems use a subset of these).
The module formalizes the support monotonicity, exact scale algebra, finite
ledger, Euler/Legendre core, abstract energy obstruction, and actual `1093`
counterexample.  Yamada's analytic estimate and real little-oh conclusions
remain paper proofs and are not encoded as assumptions.
