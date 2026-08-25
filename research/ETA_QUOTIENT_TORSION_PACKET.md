# Exact eta-quotient packet of cyclic `ell`-lines

For `q=e^(2 pi i tau)`, Jacobi's product gives

\[
 \prod_{j=1}^{\ell-1}\vartheta_1(j/\ell,\tau)
 =\ell\,\eta(\tau)^{\ell-3}\eta(\ell\tau)^2.
\]

After Hodge normalization, the canonical cyclic-line coordinate is

\[
 u_\infty(\tau)
 =\ell\left(\frac{\eta(\ell\tau)}{\eta(\tau)}\right)^2.
\]

For prime `ell`, set

\[
 u_k(\tau)=\ell^{-1}
 \frac{\eta((\tau+k)/\ell)^2}{\eta(\tau)^2},
 \qquad 0\le k<\ell.
\]

The eta product identity

\[
 \prod_{k=0}^{\ell-1}\eta((\tau+k)/\ell)
 =\zeta_\ell\frac{\eta(\tau)^{\ell+1}}{\eta(\ell\tau)}
\]

implies the exact complete-packet relation

\[
 u_\infty\prod_{k=0}^{\ell-1}u_k
 =\zeta_\ell^2\ell^{1-\ell}.
\]

At the cusp infinity,

\[
 -\log|u_\infty|
 =\frac{\ell-1}{12}L-\log\ell+o(1),
\]

\[
 -\log|u_k|
 =-\frac{\ell-1}{12\ell}L+\log\ell+o(1),
 \qquad L=-\log|q|.
\]

Thus the projective oscillation of the inverse packet retains

\[
 \frac{(\ell-1)(\ell+1)}{12\ell}L
\]

up to `O(log ell)`, while the complete linear product remains constant. This
constructs the modular-unit coordinates required by the nonlinear torsion
packet route. The unresolved step is the sharp global oscillation-height bound
in terms of truncated conductor rather than ordinary specialization height.
