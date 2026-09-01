# Log-field, log-shell, and a transported logarithmic coordinate

Author: ChatGPT. Date: 2026-08-31.

Source independently checked: Mochizuki, IUT III, archived May 2020
author version, Definition 1.1(i), PDF pp.23--25, including the original
p.24 image. The PDF is
research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf.

This is a coordinate audit only. It neither proves nor disproves the
proposed simultaneous global Hodge-theater identification.

## 1. What the standard logarithmic realization says

Fix the concrete native realization, and identify the finite Galois-fixed
part of the log-field with \(E\) using the standard logarithm. The full
ind-topological object in Definition 1.1 should not itself be confused
with a single finite field.

In this realization the log-field has the ordinary ring law on \(E\),
unit 1, and ordinary \(\mathbb Q_p\)-embedding. Its unit is not the image
of the original multiplicative-group identity under logarithm: that
original identity has logarithm 0.

The paragraph defining the pre-log-shell at the bottom of p.24 gives

\[
 L=\log_p\mathcal O_E^\times,\qquad
 I=(p^*)^{-1}L,\qquad
 p^*=\begin{cases}p,&p\ne2,\\4,&p=2.\end{cases}
\]

Here \(L\) is the image of the invariant unit monoid. The multiplication
by \((p^*)^{-1}\) occurs inside the resulting log-field; it is not a
replacement of its multiplication or its unit. At the odd primes in
the tame constructions, the canonical shell is exactly
\(I=p^{-1}\log_p\mathcal O_E^\times\).

In the explicitly fixed standard cyclotomic/Bloch--Kato normalization,
\(\log_{\rm BK}^{\rm std}({\rm Kum}(x))=\log_p(x)\) on these units.
Consequently \(\rho=p^{-1}\log_{\rm BK}^{\rm std}\), with the target
ring held fixed, maps their unit classes to the shell \(I\).
This statement changes the cohomological output coordinate; it does
not make \(\rho\) a unital ring identification of the entire log-field.

## 2. Transporting the entire field is a different construction

Let \(C:E\to E_\rho\) be the additive bijection \(C(x)=x/p\).
If this is to be a field isomorphism onto the new coordinate copy,
every field structure must be transported. For coordinate values \(u,v\)
in the underlying additive set \(E\), the necessary formulas are

\[
 u+_\rho v=u+v,\qquad
 u\star v=p\,uv,\qquad
 1_\rho=p^{-1},\qquad
 \iota_\rho(t)=t/p\quad(t\in\mathbb Q_p).
\]

Indeed \(C(x)\star C(y)=C(xy)\). The induced \(\mathbb Q_p\)-scalar
action is nevertheless the ordinary one:
\(\iota_\rho(t)\star u=tu\).
In particular the field element corresponding to \(p\) now has
coordinate 1; it is not the raw old-coordinate element \(p\).

The transported valuation and integral reference are

\[
 v_\rho(u)=v_p(pu),\qquad
 \mathcal O_\rho=C(\mathcal O_E)=p^{-1}\mathcal O_E.
\]

Thus \(v_\rho(1_\rho)=0\) and \(v_\rho(\iota_\rho(p))=1\).
The shell data transport as

\[
 L_\rho=C(L)=p^{-1}L,\qquad
 I_\rho=C(I)=(pp^*)^{-1}L.
\]

For odd \(p\), the new pre-log-shell is the old additive subset \(I\),
whereas the new canonical log-shell is \(p^{-1}I\). Calling that
new pre-log-shell the transported canonical shell loses a factor \(p\).

If \(a^n=b\) in the original field, set \(a_\rho=a/p\),
\(b_\rho=b/p\). The transported equation is

\[
 a_\rho^{\star n}=b_\rho,
 \qquad\text{equivalently}\qquad
 p^{\,n-1}a_\rho^n=b_\rho.
\]

This follows by induction from \(u\star v=p uv\).
It is not in general the ordinary-coordinate equation
\(a_\rho^n=b_\rho\). Coefficients, integer embeddings, units, and
valuation normalizations must follow the same transport.

## 3. Tensor references and the precise distinction

For \(m\) tensor slots, the induced additive coordinate map is
\(C_m=C^{\otimes m}=p^{-m}\mathrm{id}\). Thus a tensor reference
\(A=\mathcal O_E^{\otimes m}\) and a maximal product order \(B\)
transport to

\[
 A_\rho=p^{-m}A,\qquad B_\rho=p^{-m}B
\]

in the old additive tensor coordinates. The transported tensor-ring
law is \(x\star_Ty=p^mxy\), with unit \(p^{-m}\).
If \(\Phi:T\to\prod E\) is the original field decomposition, the
transported decomposition is

\[
 \Phi_\rho=(\prod C)\circ\Phi\circ C_m^{-1}
           =p^{m-1}\Phi.
\]

It sends \(B_\rho\) to \(\prod(p^{-1}\mathcal O_E)\), exactly the
product of the newly transported integral rings. This explains why
one must distinguish old tensor coordinates from new component-field
coordinates when writing the reference lattice.

With the Haar measure transported together with \(B\), one has

\[
 V_{B_\rho}(C_mH)=V_B(H).
\]

If the old reference \(B\) is instead kept fixed, then
\(V_B(p^{-m}H)=V_B(H)+m\log p\). Both formulas are valid, but they
describe different choices of reference.

The two operations that must not be identified are therefore:

1. replacing standard Bloch--Kato output by \(\rho\) inside the same
   native ring \(E\), with its multiplication, unit, root equations
   and reference \(B\) fixed;
2. changing the coordinate of the entire log-field by \(C\), while
   transporting its multiplication, base-field embedding, roots,
   valuation and reference as above.

In the first operation \(x\mapsto x/p\) is not a unital automorphism
of the old ring. In the second it is an isomorphism to the transported
ring, but the original ordinary-coordinate formulas cannot all be
retained unchanged. Neither operation alone identifies the tautological
log-link with the natural Frobenioid isomorphism mentioned on p.24:
the former includes the logarithmic diagram from units, whereas the
latter is an isomorphism of the reconstructed objects. Compatibility
with a specified global theater or a theta-pilot input requires its
own argument.
