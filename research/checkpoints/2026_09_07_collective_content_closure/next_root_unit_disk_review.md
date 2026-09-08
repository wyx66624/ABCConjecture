# Root independent review of the unit-disk zero certificate

Next-only ordinary and finite-review record. Root actually read the complete
UD1--UD3 proof and both complete finite verifiers. The ordinary proof PASSes
for the disk z=1+5s with W(1)=8, and its DS symmetry images. It does not
classify all rational points or certify any of the other three disk orbits.

Reviewed UD source:
`../2026_09_07_independent_route/eighteenth_round/next_unit_disk_certificate.md`
SHA256 `08decc8f07b2a5ef5c69b5f4682106ae2b74d3b225a5e87c9bc8502a00bed978`.

## Complete analytic proof

Root actually reopened [Sutherland, MIT 18.783 Lecture 5 (2023)](https://math.mit.edu/classes/18.783/2023/LectureNotes5.pdf),
printed pages 10--11, checking the initial division polynomials, both
recurrences, the exact phi/omega formulas and the multiplication-map theorem.
The formulas used in UD match these normalizations.

The branch W(u) is an integral formal series because its center has
2W=16 a 5-adic unit. Substitution u=5s gives coefficientwise decay in
the complete restricted-series ring. All quotient denominators and every
recurrence denominator are units. The finite center calculations make
phi and omega units on the entire disk; they do not require dividing by
psi_9. Consequently T belongs to 5A, and Xi is a unit whose normalized
variation has the claimed integral coefficient decay.

The logarithm expansion has its entire nonlinear part in 25A, since
j-v5(j)>=2 for j>=2. The already reviewed ZS coefficient bounds control
the complete R0 and L compositions in this same Gauss norm. Multiplication
by alpha of valuation -1 loses exactly the accounted digit. Differentiation
of restricted integral series does not decrease Gauss valuation.

The pullbacks 2z/W and -2/W of the invariant differentials are correct.
Integrating their higher coefficients before substituting u=5s gives the
full 25A error, including denominators divisible by five. The two exact
base-point logarithm and alpha digits yield the displayed affine reductions.
The squared-log contribution after subtracting the center is s+2s^2; the
logarithm of Xi contributes s. The exact rational center is a zero by the
previously proved global-height identity. Thus g=f/5 has reduction 2s(s+1)
as a congruence of whole restricted power series, not just of sampled values.

For every other residue class g is a unit. Above each of 0 and 4 its
derivative is a unit; the complete Taylor remainder proves existence by
Newton iteration and uniqueness by the difference identity. Therefore this
disk has exactly two simple Q5 zeros. The known center is the first; the
second has z=21 and W=3 modulo 25. No rationality assertion is made for
the second. DS then gives exactly eight simple zeros in the four disks
over z=+1 or -1 modulo five, four already known to be rational.

## Actual independent finite runs

Root ran both read-only commands successfully:

* `next_replay_zero_slope.py --check`: two exact degree-40 rational ODE
  calculations, the actual ninefold base points and leading digits PASS.
* `next_replay_unit_disk.py --check`: complete dual-number tables modulo
  five and twenty-five, multiplication-curve identities, independent
  binary-group-law comparison for t(9P), and the two residue roots PASS.

Files below are relative to the independent eighteenth round:

* `next_replay_zero_slope.py`:
  `37979b3897bbc53f64469bcfbb167851b752df2e1c336c03d97f65adc75e6316`
* `next_zero_slope_exact.json`:
  `13589e3cf79c01417786276a25394ad7ed1245decdcca36e984e01eeb744b0c9`
* `next_replay_unit_disk.py`:
  `caa29c57312979eb5809d3c46c242e3ff8f6c01f1b78123abcad42e5e557e25b`
* `next_unit_disk_exact.json`:
  `2f3d604e73a27acd59d2ed47b418595b40c717efa5588a78584e963ab9f00ce7`

The finite verifiers do not independently prove the infinite tail or the
exact center identity. Those are ordinary theorems reviewed above and in
the previously recorded HT/LH/ZS reviews. The old PARI comparison is a
secondary pinned comparison; neither new calculation runs PARI or derives
its coefficients from it. No Lean theorem is asserted by this record.
