# Root independent ordinary review of ZS1--ZS4

PASS on the stated fixed-curve domain. This review is next-only and outside
the sealed publication at main 455c68d. No analytic zero certificate or Lean
formalization is implied.

Root actually read the complete final ordinary source
`../2026_09_07_independent_route/eighteenth_round/next_zero_slope_sigma.md`,
SHA256 `63814e40fe99f39f9d325c74a8b43058222d73a5a2e465a693bf36213d90d9ff`.

Primary inputs actually reopened and read:

* Balakrishnan--Dogra, [Quadratic Chabauty and rational points I](https://arxiv.org/pdf/1601.00388),
  section 7 and Lemmas 7.3--7.4, printed pages 29--30.
* Mazur--Stein--Tate, [Computation of p-adic heights and log convergence](https://bpb-us-e1.wpmucdn.com/sites.harvard.edu/dist/a/189/files/2023/01/Computation-of-p-Adic-Heights-and-Log-Convergence.pdf),
  Theorem 1.3 and its differential equation, printed page 3.

BD uses diagonal divisor heights. The required group-difference identification
is justified separately by translation functoriality, the translation-invariant
differential and tangents, and the trivial translation action on cohomology.
It must not be inferred by merely changing notation. In the doubling limit,
x(Q)-x(P)=2y(P)t(Q-P)+higher terms, while the principal local-height term is
-2log(t(Q-P)); these singular terms cancel and give exactly
lambda(2P)=4lambda(P)-2log(2y(P)). The division-polynomial recurrence then
gives the asserted multiplication formula. The corrected even-index leading
sign is required for the polynomial formula, and has logarithm zero.

Subtracting the multiplication laws with index nine extends the splitting
change from the formal group to every non-pole Q5 point. Changes at nonzero
nine-torsion are removable. The global change is exactly c log(P)^2 because
all other local heights stay fixed, so the two occurrences of c cancel in
the rank-one expression. No generator assertion is used.

The w recurrence follows by substituting x=t/w and y=-1/w into the actual
short model. The invariant differential and the two Laurent integrations
have the indicated principal terms and parity. MST supplies an integral odd
canonical sigma and integral c for the already established good ordinary
models; its existence suffices for the denominator bound on the zero-slope
series. The bound j-2 floor(log_5 j)>=ceil(j/2) proves convergence and the
entire omitted-tail bound, not only the computed initial coefficients.

Every Q5 point reduces to a group of order nine. On its ninefold multiple,
t is regular on the formal disk and vanishes only at the origin. At a
nonzero nine-torsion point the numerator and denominator defining delta
have matching simple zeros. At the origin their ratio has order 81 and
leading coefficient one. The explicit quotient parameters at z=0 and
infinity cancel the factors z^81 exactly. Thus Xi is finite and nonzero
on all Q5 points; this is not an assertion about all geometric points.

The formula for F0, the change to alpha_0, and the loss of one digit from
its valuation -1 are consistent. Squaring a logarithm of valuation at least
one restores the required precision. The separate rational-function and
log(Xi) evaluation errors are explicitly still pending. The twelve smooth
disk inventory is complete, but this review certifies no zero list or
nonvanishing derivative, and no rational-point classification.

Root has not in this review independently run the author's new 40-degree
finite replay. Its mathematical all-tail statement is reviewed here as an
ordinary proof and is distinct from that finite software check.
