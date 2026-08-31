# Translation from the library theta divisor to the identity divisor

The product normalization in `tate-curves-theta` has zero divisor

\[
  u\in -q^{\mathbb Z},
\]

so its descended degree-one divisor is the class of `-1`, not the identity
class represented by `1`.  To compare with the cyclic kernel polynomial

\[
  \sum_{P\in C\setminus\{0\}}(P)-(\ell-1)(0),
\]

use the translated theta section

\[
  \vartheta_q(u)=\Theta_q(-u).
\]

Its zeros are exactly `q^Z`, hence it represents the identity divisor.

For odd `ell`, the two cyclic distribution identities are unchanged in form.
Indeed,

\[
 (-u)^\ell=-u^\ell,
 \qquad
 (-u)^{-(\ell-1)}=u^{-(\ell-1)}.
\]

Consequently

\[
 \prod_{\zeta^\ell=1}\vartheta_q(\zeta u)
 =\frac{C(q)^\ell}{C(q^\ell)}
   \vartheta_{q^\ell}(u^\ell),
\]

and, for `s^ell=q`,

\[
 \prod_{j=0}^{\ell-1}\vartheta_q(s^j u)
 =\frac{C(q)^\ell}{C(s)}
  s^{-\ell(\ell-1)/2}u^{-(\ell-1)}
  \vartheta_s(u).
\]

After dividing out the identity term, the left sides now have exactly the
cyclic kernel divisor relative to the origin.  Thus the distribution theorem
is compatible with the explicit kernel polynomial, but the translation by
`-1` must be stated.  Omitting it would identify the correct degree-one theta
divisor with the wrong point of the Tate curve.
