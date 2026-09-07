# Final ninth-round companion transcription review

Date: 2026-09-07. The three documents below were read in full and
compared with the independently reviewed ordinary proofs. All PASS.
No mathematical or scope correction was required.

## General-exponent progression

`2026_09_07_independent_route/ninth_round/paper/euler_progression_compatibility.tex`
has SHA256
`ff34bf398dafcddc4de664bfec28dd364d24b23cfb4d2df40a4221e8f33de721`.

The complete odd-index cyclotomic valuation proof, the depth-one largest
prime exception, the value at one and root-pair lower bound are faithfully
transcribed. The actual root, unit absorption and selected arm are
unchanged. The general odd-index rank-one step and the positivity of
the substituted denominator exponent are explicit. The totient gate
and its actual root-height proof retain every constant, including
243/(64)>1. The failure of that gate is not described as a no-go theorem.

The full finite replay source was read, and
`python .../replay_euler_progression.py --check` was actually rerun.
Exit code zero and explicit PASS were returned for 14 completely
factored values and four further exact exceptional valuations. The
canonical JSON hash is
`cfa7705fbd29e52a6288ffddc8abd4ea2bd112580457a06aeda6ed6b43287271`.
The divisor-product divisions are exact; the generic order and largest
prime checks are separate from any actual norm representation. The
three displayed 11-adic examples in the TeX match the replay. No
actual simultaneous pure-power existence test is claimed.

## Signed-arm compensation

`2026_09_07_critical_bottleneck/ninth_round/paper/signed_arm_compensation.tex`
has SHA256
`90bd0d29d1ad30e96d986ead6bcdd2e5396ccc82172c1954b2b8d243d3641de0`.

The primitive unramified domain, both normalized-power residues, the
three integer quotient polynomials and pairwise coprimality agree with
SA1. Prime versus composite cyclotomic products are correctly separated.
The ramified counterexample is correctly excluded.

The finite signed inequality preserves negative radical credit. Its
overlap step with T1 does not assume coprime supports. The full input
and output height ranges are explicit, and the finite evidence was
already independently rerun in `signed_arm_review.md`.

The positive-sector unit argument supplies precisely the actual LR2
representation with unit residual, ramified exponent zero, and
lambda=1/n. It preserves c, T, the archimedean defect and all prime
valuations, including at two and three. The constants, moving-cutoff
error and positive-part conclusion match the ordinary proof. The
text correctly restricts the resulting estimate to sufficiently large
indices and expressly leaves bounded indices with moving roots open.
The 32-declaration formal description matches the source review; it
does not claim that real logarithms, LR2 or general membership were
formalized. The chosen two-arm condition remains sufficient only.

## Split-progression compatibility

`2026_09_07_critical_bottleneck/ninth_round/paper/split_progression_compatibility.tex`
has SHA256
`bc76e4de9fa702477dd27545ef6a1ba30f971402ff82f419f7c8faa41b32a465`.

The exact root absorbs the unit using p>=5. The selected input arm
is the sum arm for p=1 modulo six and the first arm of the conjugate
output for p=5. Inert new bad primes have rank one; the valuation
formula therefore identifies every complete c-depth with that input
arm. The exceptional exponent prime stays in the original CE bad
part. The disjoint-support multiplication and squared integer budget
are exact, and the logarithmic statement retains the strict sign and
constant. Unequal exponents use a chosen common prime divisor only.

The final paragraph correctly limits the result to necessary conditions
on actual seeds. It does not claim the integer arm module formalizes
the rank/valuation proof or controls surviving high multiplicities.

These are mathematical transcription reviews, not PDF visual reviews.
The final rendered page layout must still be inspected separately.
