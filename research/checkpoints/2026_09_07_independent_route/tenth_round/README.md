# Tenth round: two actual norm profiles

This directory is independent of the frozen ninth-round mathematical
sources. The primary new result is `double_oriented_covers.md` (DC1--DC4):
the actual quartic is the norm of the primitive Eisenstein integer
ab+(a^2+ab+b^2)*zeta. A numerical second profile F=V1*Q^g therefore
has an actual oriented lifting, even for a noncanonical residual.

Together with the actual first profile, this gives a quadratic-field
cover of degree h*g and genus 1+2*h*g-g-2*h. For residual norms at
most X0,X1, the cumulative list has size at most C*X0*X1. Its sparse
coefficient height is O(1+log V0+log V1), with no term proportional
to either exponent. Every simultaneous small-residual sequence would
require points whose heights dominate these coefficient heights and
the logarithms of both degrees. No point-height upper bound, existence
of the sequence, or ABC proof is asserted.

The previously established MX1--MX4 generic splitting-field construction
is retained in `mixed_exponent_covers.md`. It uses a degree-h*g^3 cover
and the QC second-norm coefficient budget. DC exploits more of the
actual norm structure; it does not refute QC's generic unit-class
obstruction, whose hard classes were not proved to have actual seeds.

Paper sources:

- `paper/mixed_exponent_covers.tex`
- `paper/double_oriented_covers.tex`
- `paper/rational_map_descent.tex`
- `paper/geometry_bibliography.tex`

Both ordinary manuscripts have complete independent mathematical reviews
by the root researcher, critical_bottleneck and adversarial_audit.
Final TeX review status is tracked in `REVIEW.md`. These algebraic
geometry and height results are ordinary proofs, not Lean formalizations.

The separate `rational_map_descent.md` (RD1--RD3) gives an explicit
rational fiber product. It handles all projective poles and branch
fibers and proves that actual profiles give rational points. Its
expanded rational equation has coefficient height O(h+g+log V0+log V1),
which is distinguished from DC's sparse quadratic-field bound. Both
peers have completed ordinary and full TeX reviews; root review is
pending. The Stacks Project curve-extension and Riemann--Hurwitz
inputs were directly checked, and the new bibliography records them.

Independent peer reviews performed here:

- `private_depth_review.md`: TD ordinary proof and final TeX transcription.
- `reciprocal_lean_review.md`: all seventeen peer Lean signatures/proofs,
  with the integer/finite-list scope explicitly retained.

No global factorization of the relevant large integers, new actual
simultaneous power family, or additional independent fresh Lean build
is claimed by these review records. The next geometric question is
control of actual point heights, including nonunit residuals and
unequal or relatively prime exponents.
