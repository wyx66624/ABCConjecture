# Independent ordinary review of the next affine-power intersection candidate

Root actually read all AI1--AI4 in
`../2026_09_07_critical_bottleneck/eighteenth_round/next_affine_power_intersection.md`.
The precise final source hash must be rechecked if the author changes it.
This review and the candidate are outside the current sealed manuscript scope.

The mathematical argument passes ordinary review on its stated domain.
Factoring the two derivatives by (3x+zeta)^(n-2) gives determinant
-27 n^2(n-1) N(3x+zeta)^(n-2). With n>=2 and x>=B>=n the first-coordinate
derivative is positive, so the graph has strictly negative second derivative.
A line cannot have three intersections with that strictly concave graph.
Invertible residual multiplication and conjugation preserve this fact.

For the fixed-content selector, the determinant line is correctly Delta/g.
When g=1 its two known intersections correspond to t=0 and t=1, both forbidden
by the nonempty CRT packets. Varying the content gives at most two intersections
for each divisor of |Delta|, and each output fixes the selector parameter.

For an arbitrary nonconstant affine integer progression, count actual nonzero
integer residuals, not abstract prime profiles. N(a+b zeta)>=(a^2+b^2)/2 puts
them in the stated finite box. Two intersections per residual give <30X;
allowing both orientations gives <60X. The elementary estimate is valid for
every real X>=1. The constant is uniform in the fixed exponent and progression.

The density consequence applies the bound to a common fixed exponent and a
fixed progression, with residual cutoff X(J)=o(J). It does not allow a different
unbounded exponent at every counted output, nor replace arbitrary two-coordinate
roots by the one-parameter chart. The fixed-data positive-density threshold
from LM remains separate. The result excludes a particular transfer of most
affine outputs to that chart, not every transfer, a finite useful intersection,
nonlinear selectors or the parent ABC route. No numerical computation or new
Lean theorem is claimed by this review.
