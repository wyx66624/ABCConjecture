# Review and scope

## IL1--IL4

Root, critical_bottleneck, and adversarial_audit each independently read
the full ordinary proof and reported PASS. Both peers then read the
entire TeX transcription and reported final PASS. The final transcription
includes explicit integer exponents h,g>=2 and the corrected `(R')^n`.

The reviews checked the opposite-orientation valuations, the full
content divisor C|V, the radical cancellation bill at arbitrary replacement
root norm, the sharp log(7) threshold, and the exact fixed-root inverse.
They also checked that local exclusions reconstruct the original residual
and do not promise an arbitrarily prescribed smaller residual budget.

The following boundary checks were independently supplied by
adversarial_audit and are not used as assumptions in the proofs:

* With pi=2+zeta, tau=pi^(n+1), w=bar(pi), n>=3, one has C=7^n,
  reduced norm 7, V=7^(n+1), V'=7. Thus C^n need not divide VV'.
* If tau is not primitive, tau=7, w=pi gives C=7, V=49 and V'=1;
  the radical bill fails for n>2.
* If the root is allowed to be ramified, tau=1, w=gamma, n=3 gives
  C=3 and reduced norm 3; the radical bill with V=1,V'=3 fails.

## CI1--CI2

The pure-coefficient converse was proposed independently by
critical_bottleneck. Root and both peers read the complete ordinary proof
and reported PASS; both peers read the complete TeX and reported final
PASS. The primitive-input ramified depth is zero or one, and the exact
content is 3^floor((e_initial+epsilon*n)/2), including unit, ramified, and
infinite projective inputs. The proof then reconstructs both primitive
outputs and excludes unit root norms from positive seeds.

All reviews rechecked the exact older combined-square obstruction used
to exclude the finite positive locus when both exponents are even. They
did not infer that the entire rational curve has no rational points.

## GE1--GE4 and BK1--BK3

Root and both peers read each complete ordinary proof and reported PASS.
All three then read both self-contained TeX sections and reported final
PASS. The Gaussian lift keeps the actual primitive orientation, allows
overlapping supports and non-power-free residuals, and proves the exact
half-logarithmic coefficient height. The inverse keeps the additional
square condition and positive integer U. One invalid intermediate parity
sentence in the initial candidate was caught by adversarial_audit: even
a,b do not force c,d to be multiples of four. It was replaced by the
valid norm argument U^2=a^2+ab+b^2, which forces U and c even and
contradicts their coprimality. The replacement was independently reread.
The logarithm of the quadratic discriminant means its absolute value.

The BK reviews checked all four quadratic factors and eight distinct
branches, the exact relation kernel of size gcd(g,2), and each component's
ramification and genus. The even case has two geometric components,
defined over the fixed field for the stated pure-unit constants. The
actual positive parameter fixes the scaling sign, and both UFD powers
give actual nonbranch points. Neither a birational equivalence with DC
nor an inverse for arbitrary K-points is asserted.

## Formal and computational status

These are ordinary proofs over the Eisenstein UFD, depending on the
previously reviewed rational-map construction and, for CI2, the earlier
ordinary elliptic descent. This directory supplies no claim that those
complete geometric or elliptic arguments are Lean formalized. The parent
is independently developing explicitly scoped integer arithmetic kernels.
No new finite experiment is used as a substitute for a universal proof.

The author ran `replay_gaussian_cover.py` in write mode and then
`--check`, both PASS. The parent independently read the complete source
and ran `--check`, also PASS. Its standard-library arithmetic is exact
in Q(alpha), alpha^4-alpha^2+1=0. It verifies the polynomial
factorizations, four discriminants and six pairwise nonzero resultants;
119 relation kernels at g=2 through 120; 52 actual square-first seeds
with 1<=a<=b<=300 and complete trial factorizations; and 74 inverse
instances with c<=600. The canonical JSON SHA-256 is
`524ee503761baafb19d1c25e2587562dfd57c939437fdcbc46a3336a14304d9f`.
Neither peer's mathematical review is counted as another software run.
No rational-point completeness, geometric formalization, or uniform
height theorem is inferred from these finite checks.

The final source snapshot is recorded in `verification_inventory.json`.
Header changes from candidate to reviewed are metadata only.
