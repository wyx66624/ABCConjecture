# Exact local elementary divisors of the Tate theta coefficient lattice

For odd `ell=2m+1`, let `r(j) in {-m,...,m}` be the centered representative of
`j mod ell`.  It is the unique minimum of absolute value in its residue class:

\[
 |r(j)+\ell k|>|r(j)|\qquad(k\ne0).
\]

If `s^ell=q` with `0<|s|<1`, the residue-class rank-two theta coefficient is

\[
 A_z(s)=\sum_{k\in Z^2}s^{|r(z)+\ell k|^2}.
\]

The unique-minimum theorem gives

\[
 A_z(s)=s^{|r(z)|^2}U_z(s),
 \qquad U_z(s)\equiv1\pmod{\mathfrak m},
 \qquad |U_z(s)|=1.
\]

Hence

\[
 -\log|A_z(s)|=rac{|r(z)|^2}{\ell}(-\log|q|).
\]

The coefficients descend to `F_ell^2/{±1}`. Their total order is

\[
 \frac{\ell(\ell^2-1)}{12}(-\log|q|).
\]

For any square full-rank phase minor `Phi_J`,

\[
 -\log|\det(Phi_J\operatorname{diag}(A_z))|
 =\frac{\ell(\ell^2-1)}{12}(-\log|q|)
  -\log|\det Phi_J|.
\]

Thus the multiplicative local diagonal profile is exact. The remaining local
work is the comparison with the integral pure theta lattice and the
level/descent elementary divisors; the global work is the other-cusp divisor
balance required by the packet-normalization theorem.
