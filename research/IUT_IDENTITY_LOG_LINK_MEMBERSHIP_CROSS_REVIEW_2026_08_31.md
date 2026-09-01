# Independent review: one identity log-link and its local pilot images

Author: ChatGPT. Date: 2026-08-31.

Reviewed report: IUT_IDENTITY_LOG_LINK_LOCAL_MEMBERSHIP_2026_08_31.md,
final reviewed SHA-256
6ca3f92988be870df06b3536d9f1f6b598e9ed1f87cbd2feef5d8785e3f6d3d9,
42,790 bytes and 937 lines.
The initial complete draft
702ebea3fb273c71d353310b3f0f2df034e9af624ec4c3fa1e7d115f728e8d8b
was read in full. The final revision's explicit packet qualification,
reciprocity convention, natural comparison source, adjacent-layer
global-ideal comparison, and permanent source archive were then read
again. They resolve the review's requested source and scope clarifications.

**Verdict:** the canonical, same-column, fixed-base-branch local
membership claim passes this independent source and mathematical review.
The two adjacent-layer diagrams in Section 5 and the local inclusion
in Theorem 6.3 have the required types. The canonical point subfamily
has the previously proved exact hull \(P_j\). This gives a lower
inclusion in the hull of the defined raw possible-image set, not an
equality for the entire set.

This review does not prove the multiradial reconstruction theorem,
the global comparison of IUT III Corollary 3.12, an assertion of
IUT IV, or ABC. No existing manuscript, Lean module, source PDF,
or acceptance snapshot was changed.

## 1. Original sources and the exact version inspected

The newly obtained original is Shinichi Mochizuki,
*Topics in Absolute Anabelian Geometry III: Global Reconstruction
Algorithms*. Its title page says **November 2015**.

- Author URL:
  <https://www.kurims.kyoto-u.ac.jp/~motizuki/Topics%20in%20Absolute%20Anabelian%20Geometry%20III.pdf>.
- Original downloaded file:
  tmp/iut_identity_loglink_review_2026_08_31/AbsTopIII_November2015_author.pdf.
- Parent's identical permanent archive:
  research/sources/iut_membership_2026_08_31/Mochizuki_AbsTopIII_November2015_author.pdf.
- 164 PDF pages; 1,132,226 bytes.
- SHA-256 of both copies:
  e8115df30a86dea26e2ebf60cb333558ff28fe3e4d57017a80421787b53421a9.

The title page and p.139 were actually viewed as rendered images.
They show the title/date and the contravariant transfer clause of
Proposition 5.8. The images are
tmp/iut_identity_loglink_review_2026_08_31/AbsTopIII-p1.png and
tmp/iut_identity_loglink_review_2026_08_31/AbsTopIII-p139.png.
No journal volume or pagination is inferred from the title page.

The following original pages were read in extracted text. This list
does not claim that every listed page was also rendered.

| Original source | Locations read for this audit |
|---|---|
| AbsTopIII, November 2015 | Definition 5.4 and discussion, pp.124--129; related comparison p.132; Proposition 5.8, pp.139--140; mono-analytic comparison discussion, pp.144--146 and 148--149. |
| IUT I, May 2020 | Corollary 5.3 and its proof, pp.143--145. The earlier audited procession definitions are also used with their exact representative scope. |
| IUT III, May 2020 | Definition 1.1, pp.23--25; Proposition 1.2, pp.31--33; Proposition 1.3 and Remarks 1.3.1--1.3.2, pp.42--43; tensor packets, pp.97--99; Propositions 3.4--3.5, pp.101--106; local ideals and pilot objects, pp.107--112; Proposition 3.10, pp.147--148; Theorem 3.11, pp.153--159; Remark 3.11.1, pp.160--164; raw unions and subsequent comparison discussion, pp.173--180. |

The reused IUT files are
research/sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf
and
research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf.
Their SHA-256 values are, respectively,
7360e3ed27c235b5497a0743d3ed1646fbb97688547d16b7c784fc7f127f1f03
and
9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9.
The original IUT II theta-evaluation formulas and the finite
full-Galois minimum construction were checked in the earlier
IUT_NATIVE_THETA_TORSION_POINT_CROSS_REVIEW_2026_08_31.md.

## 2. A single synchronized identity branch is available

Start with a valid initial datum and two distinct tagged copies
\(\mathcal H_{-1},\mathcal H_0\) of the same theater. Fix the one
copy-identity \(\Xi\) of their complete D-Hodge theaters.

At a nonarchimedean place, Definition 1.1 constructs the log-field
on perfected old units, retaining the same fundamental-group action.
Its standard-log field realization is equivariant for this action.
Consequently the associated natural Frobenioid isomorphism, followed
by the tag-copy map, lies over the local D-identity.
It is not an arbitrarily chosen linear map of log-shells.

The bijection of IUT I Corollary 5.3(ii) identifies this map with
the lift selected by the D-identity. IUT III Proposition 1.3(i)
uses the one \(\Xi\) to make all the prime-strip lifts. Remarks
1.3.1--1.3.2 supply their synchronization and their compatibility
with the symmetrizing isomorphisms. The archimedean constituents
use their corresponding tautological construction with the retained
Aut-holomorphic space, not a single-valued logarithm on
\(\mathbb C^\times\).

Thus the claim in Proposition 4.1 of the reviewed report is stronger
than separately naming local coordinates, and its global compatibility
is supplied. It remains only one representative of the full log-link;
the full poly-arrows of the lattice have not been replaced by
singletons. It says nothing about arbitrary independently prescribed
local coordinates.

Nor does it assert that ordinary local logarithms or exponentials
map a global number field into itself. In particular,
AbsTopIII Remark 5.4.1, p.129, is not contradicted.

## 3. The carrier, the new multiplication, and the two diagrams

In the fixed finite realization, let \(L_{-1}\) be the new
predecessor log-field. The standard-log map
\(\lambda:L_{-1}\longrightarrow E_0\) is a unital field isomorphism.
The canonical shell in its native \(E\)-coordinate is
\(I=p^{-1}\log_p\mathcal O_E^\times\) at the odd primes in question.
Dividing this lattice by \(p\) does not divide the field unit.

For \(x\in E\) put
\[
 y(x)=p^{-N}[\exp(p^Nx)]
\]
in the perfected old unit group, with \(N\) sufficiently large.
Increasing \(N\) does not change the element, since
\(\exp(p^{N+1}x)=\exp(p^Nx)^p\).
This is the new field element with standard-log coordinate \(x\).
The new field unit is \(y(1)\); the old multiplicative identity
has additive log coordinate zero.

The old unit Kummer carrier is
\[
 \kappa^{\rm lin}_{-1}(x)
  =p^{-N}\operatorname{Kum}_{\mu_{-1}}(\exp(p^Nx)).
 \tag{3.1}
\]
It has zero valuation component in the old rationalized \(H^1\).
The new multiplicative Kummer map for \(L_{-1}\), with coefficient
cyclotome \(\mu_{\log}\), is a different map. Naturality under
\(\lambda\) concerns
\[
 \operatorname{Kum}_{\mu_{\log}}(y(x))
 \longmapsto \operatorname{Kum}_{\mu_0}(x).
 \tag{3.2}
\]
It does not send (3.1), by an old-unit cohomological isomorphism,
to a current nonunit's raw Kummer class.

The report's canonical module chart is
\[
 \sigma_E(x)=p^{-N}
       [\operatorname{rec}_E(\exp(p^Nx))].
 \tag{3.3}
\]
The brackets now lie in the reconstructed unit-perfection
abelianization. A common large \(N\), the convergent logarithm
and exponential, and subsequent rational scaling prove that
this is an additive \(\mathbb Q_p\)-linear isomorphism.
Its image of \(I\) is exactly the source's canonical shell.
There is no further division by \(p\) in (3.3).

The comparison
\[
 \eta_E(\operatorname{Kum}(u))
     =[\operatorname{rec}_E(u)],\qquad
 \sigma_E=\eta_E\kappa^{\rm lin}_{-1}
 \tag{3.4}
\]
is not an invented equivariant isomorphism between arbitrary
coefficient choices. AbsTopIII Corollary 5.10(iv)(c),(d),
p.148, and its proof on p.149 explicitly compare the
abelianization and Kummer reconstructions through the
reciprocity map. IUT III Proposition 1.2(vi), p.32, invokes
this comparison for the actual holomorphic-to-mono-analytic
module maps.

The report's diagram (5.4) is correctly typed: its left side
first applies the predecessor's original constant-monoid
reconstruction and then forms the new log-field; its right
side is the current constant-monoid reconstruction.
They are not one old \(H^1\)-map written twice.
In the concrete copy model, both paths send \(y(x)\) to
the reconstructed field element with coordinate \(x\).
On a sufficiently small unit this follows term by term from
the logarithm series and the copy field map. Division by
\(p^N\) extends it to every \(x\).

Applying the distinguished-slot tensor recipe gives diagram
(5.5). The choice of preceding carrier is essential:
IUT III Proposition 3.5(i), p.104, explicitly compares the
current LGP construction with the core using both
\(m'=m\) and \(m'=m-1\). Proposition 3.10(i), pp.147--148,
extends this comparison to the fields and Frobenioids and
their displayed inclusions. The layer-\(m\) display of
Theorem 3.11(ii)(a) alone would not establish the required
predecessor-chart identity.

No commuting square for the full old multiplicative
log-link diagram is deduced. The incompatibility stated in
IUT III Proposition 1.2(iv), p.31, is therefore preserved.

## 4. One actual global pilot supplies the local point

Let \(x_j\) be an actual Gaussian splitting generator in the
current theater. After pullback to the predecessor log-field
its standard coordinate is \(x_j\). Its distinguished-slot
image is
\[
 Z_j=1^{\otimes j}\otimes x_j,\qquad m_j=j+1.
 \tag{4.1}
\]

IUT III Proposition 3.4(ii), pp.102--103, describes both
the subset and multiplicative-action structures of this
monoid. Proposition 3.7(ii) represents the associated
objects by local fractional ideals. Part (v), p.112,
explicitly constructs objects of the global categories
from ideals generated by LGP elements; Definition 3.8 on
the same page specifies the theta-pilot objects.

Thus the local fractional-ideal representative of the
specified global pilot contains (4.1), its generator times
the integral ring unit. This does not assert that arbitrary
local lattices can be made into a theta-pilot.
Multiplication of \(x_j\) by a root of unity in the new
local field does not change its principal ideal. Hence
the report correctly obtains all its independent local
torsion choices inside the same pilot's local ideals,
without claiming that all these tuples are one strictly
chosen global theta-function evaluation.

Diagram (5.5) of the report transports this inclusion to
the core. This is the needed base point inclusion before
applying an Ind1 map.

## 5. Transfer, image ideals, and the unit that must move

Let \(M_\alpha\) be the forward principal-unit logarithmic
action of an actual automorphism \(\alpha\) of \(G_E\).
AbsTopIII Proposition 5.8(i), p.139, specifies contravariant
functoriality by transfer on abelianizations. For an
isomorphism this is its inverse abelianized map: after
identification with its image, the subgroup inclusion has
index one and its transfer is the identity. Therefore
\[
 \Phi_\alpha\sigma_E=\sigma_E M_\alpha^{-1}.
 \tag{5.1}
\]
It preserves the shell. An arbitrary extra Tate-unit
coefficient is not part of this canonical map.

The earlier independent procession audit proves that the
same actual outer Galois representative is allowed in
all repeated labels and slots, with identities at the
other selected places. The relevant category is the
mono-analytic output category, not the earlier curve
category. No lift of this particular \(\alpha\) to the
global curve is asserted or needed for that Ind1 operation.

The subset and action data in Theorem 3.11(i) are
transported together. If \(J=m_z(R)\), then
\[
 \Phi J=(\Phi m_z\Phi^{-1})(\Phi R),\qquad
 (\Phi m_z\Phi^{-1})(\Phi1)=\Phi z.
 \tag{5.2}
\]
These are elementary equalities for any invertible
additive \(\Phi\). Holding the native test vector \(1\)
fixed in the second expression would be a different,
generally incorrect operation.

Consequently the local image of the actual pilot contains
\(\Phi^{\otimes m_j}Z_j\), in the marked chart. This is
one of the images included in the raw union defined on
pp.173--174. The report fixes a layer and takes the
basic Kummer branch, rather than its positive iterates.
It does not posit a group called Ind3 with an identity
element. This proves its Theorem 6.3 in the stated
same-column sense.

## 6. General packet projection and the rational specialization

For general initial data, Proposition 3.2, pp.97--99, has
rational-prime packet
\[
 \bigotimes_{s=0}^{j}
          \left(\bigoplus_{v\mid p}E_{s,v}\right).
 \tag{6.1}
\]
Even fixing the distinguished slot at \(v\) leaves the
other slots ranging over all selected places above \(p\).
The algebra \(E_v^{\otimes m_j}\) is the all-\(v\)
direct factor. Thus in this generality the justified
statement is
\[
 (M_\alpha^{-1})^{\otimes m_j}Z_j
       \in \operatorname{pr}_v(U^{\rm raw}_{j,p})
 \tag{6.2}
\]
in the corresponding fixed chart. The other slots'
full units project to their units, and the label-fixing
procession representative commutes with this projection.
The original ideal image provides a preimage in (6.2);
no zero-extension membership is assumed.

For the actual rational Frey family in the reviewed report,
\(F_{\rm mod}=\mathbb Q\). Its selected place set \(V\)
maps bijectively to \(V_{\rm mod}\), so there is exactly
one selected place over each rational \(p\). Here (6.1)
is \(E^{\otimes m_j}\), and the projection is unnecessary.
The report's formula (1.6) correctly imposes this
specialization.

Selected \(V\) is not the set of all primes \(w\mid p\)
of \(K\). The all-conjugate weighted sums used in the
separate arithmetic-bundle construction do not insert
additional direct summands into this selected packet.

## 7. Exact local subfamily hull and the retained boundary

In the previously proved tame configuration, write
\[
 I=\beta^{1-e}\mathcal O_E,\quad
 k_j=\lfloor v_p(x_j)+1-1/e\rfloor,\quad
 P_j=\beta^{e k_j-(e-1)m_j}B_j.
 \tag{7.1}
\]
Every canonical core operator preserves \(I\), so its
point images lie in \(P_j\). The earlier common-minimum
construction produces an actual full Galois lift whose
forward integral map attains the minimum for \(1\) and
all normalized \(x_j\). Taking the inverse group
automorphism in (5.1) makes that forward map the
canonical core operator. Its tensor attains the
exponent of (7.1) in every field component and for
every \(j\). Thus its tensor generates \(P_j\) over
\(B_j\), proving
\[
 \operatorname{Hull}_{B_j}
   \{F^{\otimes m_j}Z_j:F\text{ canonical core operator}\}
   =P_j
   \subseteq
   \operatorname{Hull}_{B_j}
       \bigl(\operatorname{pr}_v U^{\rm raw}_{j,p}\bigr).
 \tag{7.2}
\]
The projection is omitted in the rational family.
If an earlier formulation uses \(cM_\alpha^{-1}\),
the unit \(c\) does not change component valuations;
it does not license identifying the literal points
with those for the same canonical representative.

The report's trace distinction in Lemma 8.1 also checks:
the pure labels have trace zero, whereas
\[
 \operatorname{Tr}\!\left(
  \frac{\log(1+p\zeta r_0^{j^2})}{p^{k_j+1}}\right)
 =\frac{30}{p^{k_j+1}}
        \log(1+\zeta^\ell p^\ell b_0^{j^2})
\]
is nonzero. Its valuation is
\(\ell-1+2j^2-k_j\geq\ell\).
Indeed the tame character has order \(\ell\);
the norm over \(K_0\) is the fifteenth power of
the displayed principal unit, and the quadratic
unramified norm squares it. The logarithm has the
valuation of its first nonzero term. Equality of
the earlier point-generated principal ideals does
not identify these different cohomological points.

The proof of (7.2) supplies no upper bound for all
other source points or vertical branches. In
particular, it introduces no \(p^{m_j}\) factor
into the original theta-point source.

## 8. Which source assertions are and are not being used

The single-branch construction uses the definitions and
the explicitly cited reconstruction/comparison results:
IUT I Corollary 5.3; IUT III Propositions 1.3, 3.5 and
3.10; AbsTopIII Proposition 5.8 and Corollary 5.10.
The direct copy-model check evaluates their relevant
maps here. This is not an independent reproof of all
those reconstruction results.

The reference to Theorem 3.11 specifies its
representation data and allowed indeterminacies.
The reference to Corollary 3.12 specifies its
possible-image union. Their full multiradial,
horizontal, and global inequality assertions are
not used as axioms proving the single local image.

In particular this review does not establish:

- transport of the same native region to an independently
  fixed holomorphic codomain across a horizontal theta-link;
- global IPL/SHE compatibility for all branches from
  this local calculation;
- the assertion that the one-prime arithmetic bundle
  is the entire synchronized global theta-pilot;
- an equality between \(P_j\) and the hull of the
  full possible-image union;
- the global sign or prime-strip interpretability
  used later in the proof on p.175;
- an IUT IV upper bound, a contradiction to any
  IUT inequality, or a proof or disproof of ABC.

These are substantive boundaries. IUT III Remark
3.11.1(iii), pp.160--161, states IPL and SHE.
Part (iv), p.162, explicitly distinguishes the
algorithm from set-theoretic transport across a
horizontal theta-link. A local point inclusion
cannot replace these additional comparisons.

No reason to discard the broader IUT route follows.
The verified progress is the source-compatible
canonical local subfamily, with its exact marking,
action direction, and packet scope.
