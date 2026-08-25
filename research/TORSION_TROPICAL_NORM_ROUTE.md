# Galois-invariant tropical norm of the torsion-line packet

Let `L=P^1(F_ell)` and let `C` be the canonical Tate line. With

\[
 A_\ell=(\ell-1)/12,
 \qquad
 B_\ell=-(\ell-1)/(12\ell),
\]

define the local score vector by `A_ell*(-log|q|)` in the canonical coordinate
and `B_ell*(-log|q|)` in every other coordinate.

Its coordinate sum is zero, so every permutation-invariant linear functional
vanishes. Nevertheless its symmetric nonlinear invariants retain the q-signal:

\[
 \max s=A_\ell L,
 \qquad
 \operatorname{osc}(s)
 =\frac{(\ell-1)(\ell+1)}{12\ell}L,
\]

\[
 \|s\|_2^2
 =\frac{(\ell-1)^2(\ell+1)}{144\ell}L^2.
\]

Thus the Galois-average no-go theorem excludes symmetric linear packets, not
symmetric norms.

If algebraic modular-unit/determinant coordinates `u_D` tropicalize to this
score vector up to a common scalar, the projective local oscillation

\[
 \max_D\log|u_D^{-1}|_v-\min_D\log|u_D^{-1}|_v
\]

recovers the displayed positive multiple of `-log|q_v|` and is invariant under
both Galois coordinate permutations and projective scaling.

The remaining theorem is a sharp global oscillation-height bound for this
packet in terms of different plus conductor. Since oscillation is the maximum
height of coordinate ratios, this becomes a structured varying-S-unit problem.
Generic modular-map height bounds are insufficient; additional modular-unit,
determinant or Plucker relations must yield the truncated conductor coefficient.
