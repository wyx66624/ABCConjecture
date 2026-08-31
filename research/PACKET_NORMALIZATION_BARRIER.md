# Packet normalization must apply to the complete adelic line

The transverse centered-weight calculation gives

\[
 S_\ell=M_\ell L/6,
 \qquad
 M_\ell=\ell(\ell^2-1)/2.
\]

This does not by itself permit division by `M_ell` inside the number-field
product formula. A square even-theta frame minor has dimension

\[
 d_\ell=(\ell^2+1)/2
\]

and ordinary scalar theta weight `d_ell/2`; after formal division by `M_ell`
this weight is asymptotic to `1/(2ell)`. The missing boundary, level,
determinant-of-cohomology and pure-theta terms must be normalized at the same
time.

Therefore the naive shortcut

`local order M_ell*L/6 -> divide by M_ell -> L/6`

is excluded unless one constructs a genuine rational/adelic line carrying the
same scaling and computes its complete divisor.

The surviving target is the integral pure-theta Plucker section. One must prove
that its complete divisor, after the canonical pure-theta and determinant
corrections, has normalized multiplicative part `Q/6+O(N)` and that all other
negative finite and archimedean terms are bounded by

\[
 (1+o(1))(D+N)+O(\log\ell).
\]

The finite frame, centered tropical exponent, integral convolution determinant,
pure theta metric and algebraic norm selection remain valid. What remains is
the global divisor/elementary-divisor computation; no arbitrary rescaling is
permitted.
