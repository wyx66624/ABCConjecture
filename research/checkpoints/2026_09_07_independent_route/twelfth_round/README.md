# Twelfth-round independent geometry

The three ordinary proofs below have complete independent reviews by
root, critical_bottleneck and adversarial_audit. Both peers have also
read their entire final TeX transcriptions. These mathematical sources
are ready for integration and are frozen except for a reported layout
defect; all subsequent unsolved genus-two probes belong in a separate
later directory. Parent performs final manuscript integration and QA.

- RL1--RL4, rational_biquadratic_locus.md: the precise rational
  norm-one domain on the simultaneous quadratic cover. Every positive
  rational Eisenstein point has a unique Gaussian rational lift; for
  gcd(g,6)=1 one curve is in bijection with the ordered actual pure
  first-square, second-g-th-power seeds. The Gaussian equation does
  not delete such points.
- UG1--UG3, unramified_gaussian_cover.md: forgetting the Gaussian
  coordinate is a degree-g finite etale cover. A specified function
  gives a K-rational Jacobian divisor class of exact order g on the
  genus-(3g-3) base. Its arithmetic action is a mu_g group-scheme
  torsor, without assuming all roots of unity lie in K.
- HG1--HG3, hyperelliptic_quotients.md: the base Jacobian is isogenous
  over Q to the product of three explicit genus-(g-1) Jacobians.
  The proof uses Q-defined norm and pullback maps with composite [2].
  The odd torsion tuple retains exact order. At g=3 this provides
  three genus-two equations, not a rank or rational-point computation.

The corresponding complete TeX files and the one new Milne
bibliography entry are in paper/. Their input order is RL, UG, HG.
They use the already existing StacksCurves2026 bibliography entry
and the previous BK, GE and CI results. No shared master was edited.

Run the immutable finite certificate from the repository root:

    python research/checkpoints/2026_09_07_independent_route/twelfth_round/replay_rational_geometry.py --check

Author --write and subsequent --check both actually passed. The
standard-library computation uses exact integer polynomial arithmetic
and Fraction; it checks six polynomial identities, 21 homogeneous
branch cases including infinity, 614 finite norm-one inverses and
two infinity branches, 360 actual first-square positive chart samples,
50 odd-exponent Laurent/RH arithmetic rows, and one integral V4
group-ring identity. The chart samples do not assert a perfect-power
second norm. There is no finite computation of Jacobian torsion or
rank, full rational-point enumeration, or Lean formalization here.
The canonical JSON SHA-256 is
9ccf3ce5e8c3e4316f880afdb44edfd0687744935beb98b17baa70a18efd9efa.

The separate review files record complete ordinary/source review of
peer MC, PN and PF work and source/scope review of 15 phase and six
finite root-count Lean declarations. Those reviews are not extra
independent Lean compilations or peer replay executions.

No uniform point-height theorem, odd-exponent emptiness, vanishing
far signed tail, or ABC proof follows from these results. The next
geometric computation must retain the same source coordinate on the
hyperelliptic quotients and the actual positive domain. Ramified first
norms, nonunit residuals and varying exponents remain active branches.
