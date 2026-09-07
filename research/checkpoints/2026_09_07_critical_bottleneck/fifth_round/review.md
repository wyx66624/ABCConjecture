# Fifth-round review record

Date: 2026-09-07. Earlier publication rounds remain frozen.

## Fourth-round actual PDF inspection

I used `view_image` to inspect the actual rendered pages 388, 389 and
390 under `tmp/abc_20260907/round4pdf/qa/`. All three passed visual QA.
On page 388, Theorem 189.1 has its complete visible Proof and QED, and
Theorem 189.2 begins its normal continuation onto page 389. That page
contains the continuation, its visible Proof and QED, and the complete
proof of Theorem 189.3 with its QED at the bottom. Page 390 has the
one-sided signed scope and a clean transition to Section 190. I found
no clipped text, overflowing formulas, missing proof labels, unreadable
symbols or broken page transitions. This conclusion comes from the
actual images, not extraction or build logs.

## Independent route: QC1--QC5

I read the complete file
`research/checkpoints/2026_09_07_independent_route/fifth_round/quantitative_kummer_covers.md`.
The fixed degree-eight splitting field, its unit rank three, the lack
of ramification away from three and thirteen, and the exact thirteen
depth argument all pass ordinary proof review.

For the cover count, I checked the assignments of remainder ideal
valuations at every good prime, the bound of four choices per prime
ideal and eight prime ideals per rational prime, and the fixed bad-prime
factor. The total remainder product is exactly (V). The ideal g-root
classes give at most H^4 choices and the three unit ratios give g^9,
with a fixed torsion factor. These yield the stated uniform cover count.
The fixed-residual 16-lambda estimate and the additional residual choice
in the 17-lambda union estimate are distinct and correct.

For the coefficient heights, an integral principal ideal has an
integral generator whose complex logarithmic vector can be reduced
modulo the full log-unit lattice about its mean. This proves the
bound log(norm ideal)/8 plus a field constant. Applying it to the
four ideals and then three unit ratios gives 2 log V plus a constant
times g. The note retains that order-g term and does not turn the
subexponential cover count into a point-height estimate. The actual
point-height lower bound at the end has the correct inequality direction.

I independently opened the author's primary notes
<https://www.jmilne.org/math/CourseNotes/ANT.pdf> and checked Theorems
5.1 and 5.9 for the rank and full log-unit lattice inputs. These are
ordinary external number-theory inputs, not claimed Lean results.

## Actual cyclotomic rank packets

The complete CP1--CP5 ordinary proof has passed independent review by
both the parent and adversarial agents, including reciprocity at d=2,
nonvanishing, the exclusive first-rank valuation, CP4--CP5 and the
explicit distinction between a positive net signed rank packet and
a rank containing one depth-four prime. The latter may have its
positive contribution canceled by other primes in the same packet.
The complete TeX transcription in `paper/cyclotomic_rank_packets.tex`
passed the adversarial agent's final independent review. Its minor
domain observation was addressed by explicitly requiring the auxiliary
rank cutoff D to be a nonnegative integer in both the ordinary and
TeX statements, matching the displayed triangular-sum equality.

## Adversarial route: HR1--HR3

I read the complete `fifth_round/high_rank_depth.md` in the adversarial
checkpoint and approved the ordinary proof. The prime divisor of
Phi_(6*ell)(6*ell) is coprime to 6*ell by its constant term. The
squarefree factorization of X^(6*ell)-1 modulo that prime then forces
the precise order, so the existence argument needs no prime-distribution
theorem. The fractional-linear parameter has nonzero norm and the
prescribed order; its derivative proves the simple boundary root.
Choosing one of the two nonzero candidate lifting digits avoids the
unique next root, and the final three-adic CRT preserves the exact depth
and the stated upper and lower sizes of a.

The actual powers remain primitive, their unit rotation is legitimate,
and the chosen prime is beyond the moving cutoff. The lower bound
a>=p^s gives the stated sublinear cost of that one prime. Thus the
family refutes automatic sparsity of ranks containing a deep prime;
it supplies no sign for the whole net signed rank packet. This precise
distinction and all scope qualifications are correct.

## Finite actual cyclotomic replay

I ran `fifth_round/replay.py` and its stored-payload `--check` mode.
Both passed. Six actual roots give 180 exact integer factorizations,
16,560 exact cyclotomic valuation checks, and 540 signed packet
assembly checks over the explicitly retained primes at most 499.
The canonical payload SHA-256 is
81941c0830df549d9998b5e75d8687d82534ba328522e318e25ab2303edaf5db.
The factor values are evaluated from independently constructed integer
cyclotomic polynomials in the Eisenstein ring. No untested prime is
declared absent, and no full-tail bound is inferred from the finite
retained packet checks.
