# Independent review of the tenth-round root papers

Date: 2026-09-07. Both TeX sources were read in full and compared
against the independently reviewed ordinary proofs, final Lean sources,
and current validation manifests. Final mathematical transcription and
formal-scope review: PASS. No compiler run was repeated in this review.

Reviewed sources and SHA256:

- `2026_09_07_depth_compensation/paper/actual_prime_log_compensation.tex`
  `6c389bf7f3c02e43c81a4c8807ebb5bc97403c3a428cf866848c7c4bc375addd`.
- `2026_09_07_depth_compensation/paper/tenth_research_status.tex`
  `ffba0aa85740b9b110cf76fe36562d9a55f1bb1aada2f27437c275d5971edb37`.

## Actual prime-log theorem

The definitions use positive natural-number arguments and a natural
cutoff. The full large-prime mass S and small-prime mass L partition
log N. R is a sum of prime logarithms, and the displayed signed quantity
is S-3R, not the associated multiplicative cost. Natural h includes zero;
the depth-cap statement still holds there. The positive part exactly
matches natural-number subtraction in the Lean excess definition.

The ledger's statements correspond to the mass partition,
nonnegativity, actual cap budget, product, support and overlap lemmas in
ActualPrimeLogCompensation, and small_mass_mul in ActualPrimeLogHeight.
All product factors are positive, hence satisfy the Lean nonzero
antecedents. Only the exact coprime-additivity claims require disjoint
supports. The old-factor estimate retains every overlap and uses no
unstated coprimality with the quotient product.

The main theorem agrees with finite_actual_arm_compensation. Its
positive inputs and quotients, pairwise-coprime A,B,C, upper output
bounds and first-two input bounds are explicitly displayed. The proof
derives both lower quotient-mass estimates from these integer bounds;
it does not assume the desired finite signed inequality. The coefficient
3/2 on the two excesses, 1/2 on the small mass, negative -3R(C), and
positive log U overlap cost have the correct signs and constants.

The displayed defect is 3 log H-log T, for precisely the actual output
product T=(aA)(bB)(dC). The reconstruction T=UABC is used correctly.
Additivity of L and its nonnegativity imply L(A)+L(B)<=L(T) even if
the old factor U shares primes with every quotient. No maximum-height
equality is needed: the stated upper bounds suffice, as in Lean.

The squarefree-arm interface faithfully transcribes
actual_one_squarefree_prime_log_budget. Its actual large-prime depth
condition is retained, so zero excess is proved from a cap rather than
assumed as a statement about all roots. Its remaining real mass bounds
are explicit. The two unrestricted radical credits have coefficient -3.

## Formal counts and dependency scope

The current prime-log manifest records 24 new declarations, split as
17 in ActualPrimeLogCompensation and seven in ActualPrimeLogHeight.
These match the final sources already audited in
`actual_prime_log_review.md`, with hashes respectively
`e032065e14cb3f917cccbe100d9e6e81c29b83827b53bbc6cb5310c33923307b`
and
`e91a8cb4fbb8d708c2bf8d9f8207179565479bc1382cda592edbd2034e7d6581`.

The reciprocal-depth manifest separately records 17 new declarations
and 71 unchanged dependency declarations: 29 EisensteinDescent,
10 GeneralLucasBoundary and 32 SignedArmArithmetic. Thus the new
inventory is 41=17+24; the 71 dependencies are not counted as new.
The first scoped build freshly compiled the reciprocal module and those
dependencies. The separate prime-log build freshly compiled its two new
modules against the pinned Mathlib cache. The TeX correctly avoids
claiming a fresh build of all Mathlib or the entire repository.

Both current manifests were read again for this review. Their standard
axiom union and the new source inventories are consistent with the
earlier independent full source/log audit. Lean 4.32.0 and Mathlib
revision 81a5d257c8e410db227a6665ed08f64fea08e997 are transcribed
correctly. The paper does not add an ordinary arithmetic fact as an
axiom, or claim a real-cutoff asymptotic limit from a natural-cutoff
finite theorem.

## Research-status claims

The status paper distinguishes three different open issues accurately:
actual excess-minus-credit control, the exceptional roots beyond the
average mass theorem, and a uniform upper bound for points on the
varying geometric models. The three-private-depth family excludes the
specified automatic cap-membership assertion; its selected-prime
normalized cost does not refute net compensation or ABC. The ordinary
block result and its elementary replacement still retain both the
Brun--Titchmarsh input and an exceptional set.

The generic mixed construction, stronger actual quadratic-field model,
and expanded rational descent have their respective degree and height
budgets distinguished. Their geometric and Weil-height proofs are not
included in the Lean inventory. Neither a large genus nor small
coefficients are promoted to a uniform point-height upper bound.

The two new exact finite replays are the three-arm private-depth replay
and the elementary-block replay, separately reviewed with their actual
arithmetic scopes. Infinite families and analytic conclusions retain
their ordinary proofs. No full ABC proof, disproof, global membership
theorem, or dismissal of another unrefuted route is asserted.

No mathematical or scope correction is required. This is a text and
proof-transcription audit; actual rendered-page visual review remains
a separate publication step.
