# The next global comparison gate in the IUT route

**Author:** ChatGPT  
**Date:** 2026-08-31  
**Status:** Mathematical research continuation; no new Lean declarations.

This note does not modify the accepted 66-page manuscript, its TeX inputs, or
its verification record. It records a new, explicit arithmetic-vector-bundle
realization of the already proved local equality \(M=P\), a complete degree
calculation with the source's packet and procession weights, and a global
normalization test. Neither the construction of an arithmetic bundle nor
equality of two degrees establishes membership in the possible-output family
of IUT III, Corollary 3.12. That remaining requirement is stated precisely in
Section 7.

The initial theta data in Mochizuki I, Definition 3.1(a)--(f), have already
been constructed throughout the unbounded family used here. They are not
listed again as an unresolved condition. No unconditional proof or disproof
of abc is asserted. No disputed global comparison is used as an axiom.

## 1. Primary sources and exact locations

All page numbers below are one-based physical PDF pages, which agree with
the printed folios at these passages. The archived bytes, not a possibly
later replacement at a mutable author URL, determine this audit.

| Source | Archived file and SHA-256 | Original URL and version |
| --- | --- | --- |
| Mochizuki, IUT III | `research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf`; `9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9` | <https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf>; May 2020 author version, 199 pages |
| Mochizuki, IUT IV | `research/sources/continuation_2026_08_30/Mochizuki_IUT_IV_April2020.pdf`; `5bf4b1e0a8c2686562a6859e5009d301335044cfb5efec5d3a9edf764e4af87f` | <https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20IV.pdf>; April 2020 author version, 87 pages |
| Joshi, Arithmetic Teichmuller III | `research/sources/iut_2026_08_30/Joshi_III_2401.13508v4.pdf`; `86a92ca893e774e1ea591ed9825a30627f3f19d8df0b26b7f5855dc0923f0429` | <https://arxiv.org/pdf/2401.13508v4>; arXiv stamp 2025-02-24, title-page date 2025-02-25, 165 pages |
| Joshi, Arithmetic Teichmuller IV | `research/sources/iut_2026_08_30/Joshi_IV_2403.10430v2.pdf`; `ef8851fe656c705f7e9881778b4dd0c592c9f35a2980be6a335412a15542547a` | <https://arxiv.org/pdf/2403.10430v2>; arXiv stamp 2025-02-24, title-page date 2025-02-25, 80 pages |

The relevant definitions and arrows were reread at these locations:

| Location | Exact role |
| --- | --- |
| Mochizuki III, Proposition 3.5(ii), pp.104--105 | Nonarchimedean inclusions and archimedean surjections/containers for iterated log-links; the concrete upper-semicompatibility behind Ind3. |
| Mochizuki III, Proposition 3.7, pp.109--112; Definition 3.8, pp.112--113 | Local fractional ideals, global realified Frobenioids, the two pilot objects, and the horizontal link. |
| Mochizuki III, Proposition 3.9, pp.115--117 | Holomorphic reference integral structures, packet log-volumes, the procession average, and log-link compatibility as stated by the source. |
| Mochizuki III, Remark 3.9.5(i), p.127; (vii)(Ob1)--(Ob5), pp.131--134 | Holomorphic hull; arithmetic vector bundles; weighted determinants; subtraction of the reference structure-sheaf determinant; sufficiently divisible positive tensor powers. |
| Mochizuki III, Theorem 3.11(i)--(iii), pp.153--158 | The indexed carriers, splitting monoids, Kummer arrows, and the three distinct indeterminacies. |
| Mochizuki III, Corollary 3.12, pp.173--175; proof (x)--(xi-g), pp.181--184 | Componentwise possible-image unions and hulls; the comparison with the unindetermined q-pilot; the final proposed membership in a lower real interval. |
| Mochizuki IV, Remark 1.7.1, p.17; Theorem 1.10, pp.22--23 | Conversion from raw local weights to normalized weights; the additional arithmetic hypotheses and the global upper-bound claim. |
| Mochizuki IV, proof of Theorem 1.10, steps (iv)--(viii), pp.26--30 | First the place, then the label, then the tensor word; the finite-place containers and archimedean contribution. |
| Joshi III, Sections 8.9--8.11, pp.90--93 | Frobenius/log-link interpretation and the author's proposed interpretation of Ind1--Ind3. |
| Joshi III, Proposition 9.4.2.4, p.101; Sections 9.4.4--9.4.10, pp.102--106 | Selected places, restriction/corestriction degrees, product and tensor carriers, and labels. |
| Joshi III, Sections 9.6.2--9.7.5, pp.109--112 | The actual Kummer classes, printed Bloch--Kato formulas, and the specified collation arrows. |
| Joshi III, Theorem-Definition 9.8.1.1, pp.113--116 | Ansatz tuples, simultaneous actions, convex closure in the product carrier, and passage to the tensor carrier. |
| Joshi III, Sections 9.10.3--9.11.1, pp.123--128 | Weighted tensor prescription, maximal-order hull, the claimed hull/convex identification, and the lower estimate/sign convention. |
| Joshi IV, Sections 6.9--6.11, pp.65--71 | Two arithmeticoids, the middle global equality, the warning against direct local comparison, and reuse of Mochizuki IV's upper containers. |

The formulas on Mochizuki III pp.173 and 183 and Joshi III p.128 were also
visually checked in rendered page images. In particular the sign recorded in
Section 3.7 below is present in the original PDF, not an extraction artifact.

Previously proved mathematical inputs, with their stated boundaries, are:

* `research/FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md`;
* `research/IUT_INITIAL_DATA_POWERFREE_FAMILY_2026_08_31.md`, Theorems 1.1 and 2.1;
* `research/IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md`, Propositions 2.1--2.2 and the Ind2 span result;
* `research/IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md`, including the common full-Galois lift and the sharp trace-dual argument;
* `research/IUT_NATIVE_PILOT_DICTIONARY_2026_08_30.md`, the per-arrow logarithm/root bridge and the strengthened preideal equality;
* `research/IUT_MIXED_WEIGHT_CONTINUATION_2026_08_30.md`, Section 7, for the separate general number-field weighting calculation.

Their results do not include the full published pilot-family identification
or Ind3/global comparison. This note does not enlarge their conclusions by
changing their names.

## 2. The actual global family and the local input being globalized

Let \(\ell\equiv43\pmod {60}\) be any sufficiently large prime in the
proved power-free family, and let \(p\equiv-1\pmod {30\ell}\) and \(A\)
be its chosen prime and integer. Put

\[
 D_A:y^2=x(x-A^2)(x+A^2+1),\qquad
 F=\mathbb Q(i,D_A[30]),\qquad
 K=F(D_A[\ell])=\mathbb Q(i,D_A[30\ell]).                 \tag{2.1}
\]

Take the bad-place set \(S_0\) to be all odd bad rational primes of this
curve. The already proved construction supplies one global cover, one
nonzero decorated cusp, and an appropriate place section, satisfying the
original initial data (a)--(f). The field of moduli is \(\mathbb Q\).
The fields \(F\) and \(K\) are Galois over \(\mathbb Q\). The rational
change of variables \(x=A^2X,\ y=A^3Y\) puts (2.1) in Legendre form;
there is no remaining quadratic-twist issue for the model requirement of
Mochizuki IV, Theorem 1.10. Over \(F\) the curve is semistable, is good at
2, and all its other bad places lie over \(S_0\). Thus its good-place
hypothesis in that theorem also holds. This checks input hypotheses; it
does not verify the conclusion of Corollary 3.12 invoked by that theorem.

Fix the chosen place over \(p\). Its completion is the actual torsion-field
completion

\[
 E=\mathbb Q_p(\mu_{30\ell},\varpi),\qquad
 \varpi^{15\ell}=b_0,\quad b_0^2=q,\quad
 b_0\in\mathbb Q_p,\quad v_p(b_0)=2.                    \tag{2.2}
\]

Write

\[
 e=15\ell,\quad f=2,\quad d=[E:\mathbb Q_p]=30\ell,
 \quad h=(\ell-1)/2,\quad \kappa=(e-1)/e.
\]

The valuation convention is \(v_p(p)=1\). The element \(\varpi\) is
**not** a uniformizer: its valuation is \(2/e\). For example
\(\beta=\varpi^{(e+1)/2}/p\) is a uniformizer. Let
\(r_0=\varpi^{15}\); then \(r_0^{2\ell}=q\). For \(1\le j\le h\), put

\[
 \begin{split}
 m_j&=j+1,\qquad a_j=r_0^{j^2},\qquad r_j=v_p(a_j)=2j^2/\ell,\\
 k_j&=\lfloor r_j+\kappa\rfloor
       =\lfloor2j^2/\ell\rfloor+1,\\
 \eta_j&=e k_j-(e-1)m_j,\qquad
 N_j=d^{m_j-1},\quad D_j=d^{m_j}=dN_j .                 \tag{2.3}
 \end{split}
\]

The expression for \(k_j\) follows because \(\ell\nmid 2j^2\), and its
nonzero fractional part is at least \(1/\ell>1/e\).

Define the three different integral structures

\[
 \begin{split}
 T_j&=E^{\otimes_{\mathbb Q_p}m_j},\\
 A_j&=\mathcal O_E^{\otimes_{\mathbb Z_p}m_j},\\
 B_j&=\prod_{\operatorname{Gal}(E/\mathbb Q_p)^{m_j-1}}\mathcal O_E
       \ \subset T_j,\\
 I&=p^{-1}\log\mathcal O_E^\times
       =\beta^{-(e-1)}\mathcal O_E .                    \tag{2.4}
 \end{split}
\]

Here the product description uses the separable field decomposition of
\(T_j\), with its first factor as coefficient field. It has \(N_j\)
components. \(A_j\) is generally smaller than \(B_j\). The lattice
preserved by the induced tensor action of a native Kummer arrow is
\(I^{\otimes m_j}=A_j^\vee\), with duality for the absolute algebra trace;
it is not being identified with \(B_j\).

Let \(\Gamma_E\) denote the actual native Kummer image of the full local
Galois outer automorphisms used in the proved construction. Its elements
are integral automorphisms of \(I\), and act diagonally in repeated
labels. The construction uses full Galois lifts, not merely automorphisms
of a pro-\(p\) quotient. For \(z_j=a_j\otimes1\otimes\cdots\otimes1\),
the following local result is already proved:

\[
 \begin{split}
 M_j^\rho
   &:=\overline{\operatorname{span}_{B_j}}\!
       \left(\bigcup_{F\in\Gamma_E}F^{\otimes m_j}(z_jB_j)\right)\\
   &=P_j^\rho=\beta^{\eta_j}B_j.                      \tag{2.5}
 \end{split}
\]

The last notation means that every field component has valuation depth
\(\eta_j\) in its own uniformizer. It does not impose equality of the
component generators. The same equality holds for the point-source
Kummer construction using the explicitly declared coordinate

\[
 \rho=p^{-1}\log_{\rm BK}^{\rm std},\qquad
 u=\rho({\rm Kum}(1+p)),\quad
 \tau_j=\rho({\rm Kum}(1+pa_j)),                       \tag{2.6}
\]

with \(m_j-1\) background entries \(u\) and one active entry \(\tau_j\).
One actual arrow attains the required depths for all labels at once.
The per-arrow logarithm/root argument proves equality of the resulting
principal \(B_j\)-ideals; it does not identify the individual points.

For orientation, the upper half of (2.5) uses
\(B_j^\vee\subset A_j^\vee\) and
\(p^{-k_j}z_jB_j\subset B_j^\vee\). Every permitted tensor arrow preserves
\(A_j^\vee\), whence its image is contained in \(p^{k_j}A_j^\vee\).
The common full-Galois witness supplies the reverse inclusion after
\(B_j\)-span. The different, whole-product source has hull
\(p^{-1}P_j^\rho\). These source sets are not interchangeable.

Equation (2.5) is the input to the new theorem below. It is a theorem about
the specified native principal-preideal/point family. The claim that this
family represents the complete published theta-pilot output is not part
of (2.5).

## 3. A typed dictionary for the published comparisons

### 3.1 The Mochizuki input, output, and quantifiers

Fix the initial data (2.1), and a log-theta lattice of Hodge theaters
\(^{n,m}\!\mathcal H\), \((n,m)\in\mathbb Z^2\), as in Theorem 3.11.
For each coric column \(n,\circ\), each \(j=1,\ldots,h\), and each
rational place \(v_{\mathbb Q}\), the theorem supplies a local tensor
carrier \(^{n,\circ}T_{j,v_{\mathbb Q}}\). At a finite rational prime,
this is a tensor product of \(m_j\) direct sums of the selected local
field copies. A tensor word is a possibly repeated selection of one place
for each slot. For the rational field of moduli there is just one such
selected place over each rational place, so just one word for each label.

The exact source-object distinctions are these:

| Object | What is fixed or allowed to vary | What the source does with it |
| --- | --- | --- |
| Theta-pilot object | Generators, modulo the specified torsion, of the local splitting monoids at bad places; all labels and the global realified object are retained. | Definition 3.8(i), pp.112--113; its value-group data enters the horizontal link. |
| q-pilot object | The local \(q_v^{1/(2\ell)}\) data in its global realified arithmetic line bundle. | The same definition; its log-volume is measured without Ind1--Ind3 in Corollary 3.12. |
| Kummer arrows | The labeled arrows attached to each \((n,m)\), before applying Ind1 and Ind2. | Theorem 3.11(ii), pp.155--156; they relate holomorphic and coric carriers. |
| Ind1 | Representatives of automorphisms of the monoanalytic procession, including the allowed local outer-Galois representatives. | Theorem 3.11(i). One cannot replace it by field automorphisms; nor may one enlarge it to all lattice automorphisms without proof. |
| Ind2 | The separately specified Ism actions on local summands and factors. | Theorem 3.11(i). The proved fixed-carrier scalar result eliminates their effect on a \(B\)-span in that fixed marking. It does not eliminate Ind3 or changes of carrier. |
| Ind3 | Upper-semicompatibility of the log-packet arrows through vertical log-links. | Theorem 3.11(ii) and Proposition 3.5(ii): finite-place inclusions and archimedean surjections/containers, not a declaration of an arbitrary linear group action. |
| \(^{n,\circ}U_{j,v_{\mathbb Q}}\) | Union of possible theta-pilot images with all of the preceding source permissions. | Corollary 3.12, pp.174--175. The global notation denotes a collection of component sets. |
| \(^{n,\circ}\overline U_{j,v_{\mathbb Q}}\) | The holomorphic hull of that component union, in the indicated ring structure. | It is formed separately for each \((j,v_{\mathbb Q})\), before weighted log-volume and the label average. |

At a finite place, Remark 3.9.5(i), p.127, defines the hull using the
maximal product order of the finite etale algebra. For a bounded,
full-dimensional set this is the smallest product of fractional ideals
containing the set. The source assumes a positive-volume piece in the
sets to which this definition is applied. The union defining \(M_j^\rho\)
contains \(z_jB_j\), so it meets that requirement. An isolated point
itself does not meet it; the algebraic span of a point is not silently
substituted for a source region of positive volume.

The previous procession-admissibility result permits a representative
supported at one rational place, with the same local arrow at its repeated
labels and identity representatives elsewhere. Thus finite support of an
Ind1 representative is not a newly missing global condition. However, a
choice of such a representative does not determine the input pilot,
Ind3 arrows, reference lattices, or value-group part of the horizontal
link.

### 3.2 The exact numerical order

For a finite word of fields \(E_i/\mathbb Q_p\), let
\(D=\prod_i[E_i:\mathbb Q_p]\). Let \(B\) be the maximal product order,
and let \(\mu_B(B)=1\) be ordinary additive Haar measure. We use

\[
             V_B(H)=D^{-1}\log\mu_B(H).                 \tag{3.1}
\]

This is a normalized log-volume. The positive power \(\mu_B^{1/D}\)
is not claimed to be another additive Haar measure. This distinction
matters when interpreting a weighted-volume formula.

For a general field of moduli \(F_0\), let
\(h_v=[(F_0)_v:\mathbb Q_p]\). The normalized weight of a word
\(\boldsymbol v=(v_0,\ldots,v_j)\) in Mochizuki IV, Remark 1.7.1, p.17,
is

\[
 \omega_{\boldsymbol v}
   =\frac{\prod_{i=0}^j h_{v_i}}
          {\sum_{\boldsymbol w}\prod_{i=0}^j h_{w_i}}
   =\frac{\prod_{i=0}^j h_{v_i}}{[F_0:\mathbb Q]^{m_j}}. \tag{3.2}
\]

The last equality uses \(\sum_{v\mid p}h_v=[F_0:\mathbb Q]\).
Thus the finite contribution is first the weighted sum of (3.1) over
words, and then the average \(h^{-1}\sum_{j=1}^h\). There is **no further
division by the number of slots \(m_j\)**. In our rational branch,
(3.2) is 1 and

\[
             V_{j,p}=D_j^{-1}\log\mu_{B_j}(H_{j,p}).     \tag{3.3}
\]

At infinity the source uses its radial log-volume, zero on the specified
holomorphic unit ball, rather than an undeclared ordinary Euclidean
volume. Mochizuki IV, step (vii), pp.29--30, bounds that contribution
by \((\ell+5)\log\pi/4\), and hence by \(\ell+1\).

The source's global number is consequently obtained by local hulls,
local normalizations, word weights, and the procession average, followed
by the sum over rational places. It is not the Haar measure of an
arbitrary correlated subset of one global product. No unproved
independence of global choices is needed to write the componentwise
quantity. Membership of component choices in a common allowed global
family is nevertheless a separate issue.

### 3.3 What Corollary 3.12 asserts

Use \(L_\Theta\) for the quantity denoted \(-|\log\Theta|\) in the
original statement, and \(L_q\) for \(-|\log q|\). The statement allows
\(L_\Theta\in\mathbb R\cup\{+\infty\}\) initially. It asserts finiteness
and

\[
 L_\Theta\ge L_q,
 \qquad L_q=-\frac{Q}{2\ell}<0,                        \tag{3.4}
\]

where \(Q\) is the normalized total Tate divisor degree. In particular,
the typographical form \(-|\log\Theta|\) does not authorize declaring
every arbitrary native log-volume negative. On p.174 the proof explicitly
reduces to the negative case only because the nonnegative case would
already satisfy its desired inequality.

The decisive source step is specific. The horizontal value-group
polyisomorphism sends the theta-pilot to the q-pilot (p.175), whereas
the unit part passes through the three indeterminacies. Steps (xi-b)--(xi-e),
pp.181--184, then invoke IPL, SHE, and APT, use the **1-column**
log-Kummer correspondence, and take weighted determinants of the hulls.
Step (xi-f) asserts the membership

\[
                 L_q\in\mathbb R_{\le L_\Theta}.        \tag{3.5}
\]

The implication from (3.5) to (3.4) is elementary. This note neither
assumes (3.5), nor replaces the particular 1-column comparison that is
supposed to establish it by an isomorphism between arbitrary numerical
copies of \(\mathbb R\).

### 3.4 What the upper estimate does, and does not, identify

Mochizuki IV, Theorem 1.10, first fixes initial data and adds the exact
Legendre level-field and good-reduction conditions checked in Section 2.
Its proof, step (iv), pp.26--27, announces an upper bound for the **same
holomorphic hull of full possible images** used in Corollary 3.12.

In step (v), pp.27--28, after fixing \(p,j\), and a tensor word, the active
slot is \(j\) and

\[
 \lambda=0\quad\text{at a good active place},\qquad
 \lambda=v_p\bigl(q_v^{j^2/(2\ell)}\bigr)
       \quad\text{at a bad active place}.               \tag{3.6}
\]

The argument uses Proposition 1.4(iii) to contain
\(\phi(p^\lambda\widetilde R_I)\) in a multiple of the tensor log-lattice.
Here \(p^\lambda\widetilde R_I\) means the corresponding product
fractional ideal; it does not require an element of \(\mathbb Q_p\)
with fractional valuation \(\lambda\). The arbitrary linear maps in
that upper estimate account for a containing class of possible arrows.
Their use as an upper envelope is not a proof that all such maps occur
as source-admissible arrows.

The text accounts for Ind3 by the direction of the inequality and by
enlarging a container to include the relevant log-shell products.
It does not identify an Ind3 orbit with the preideal \(z_jB_j\), the
point source in (2.6), or the larger whole-product source. In the small
ramification case the displayed local upper estimate is
\(( -\lambda+d_I+1)\log p\). Its subsequent word and label averages
are numerical estimates on the announced full source hull. We do not
reverse a containment used for such an estimate to infer actual source
membership.

### 3.5 The different Joshi input family

Joshi III, Proposition 9.7.5.1, p.112, fixes a standard arithmeticoid and
collates given classes from a collection of holomorphoids under the
topological isomorphisms provided by the cited Part II-half, Proposition
7.4.1. Theorem-Definition 9.8.1.1, pp.113--116, specifies an Ansatz
tuple, including its simultaneous Frobenius action, forms a convex
closure in the product carrier, and then takes its tensor image.
For a good finite place its class is explicitly the compatible roots
of \(1+p^*\); at a bad place it is the compatible roots of
\(1+p^*q^{1/(2\ell)}\), computed in the indicated marking
(Section 9.7.4, pp.111--112).

These are actual source definitions, not permission to replace the
Ansatz by a freely chosen family of same-field powers. Its \(j^2\)
norm relation between markings and the native valuation of
\(r_0^{j^2}\) have to be related by a stated arrow. Remark 9.8.1.2,
p.116, itself points out that Mochizuki's construction uses a
multiplicative action of theta-values rather than these cohomology
classes. The correspondence of the two families is therefore a
mathematical assertion to prove, not an equality supplied by notation.

Section 9.10.3, p.124, gives a prescription on tensor product lattices;
Section 9.10.5, p.125, gives the factor weight
\(1/[L'_w:(L_{\rm mod})_v]\). For our single rational-place word this
weight is \(1/d\). The tensor prescription, when consistently
interpreted, uses \(A_j\) as reference and equals
\(\mu_{A_j}^{1/D_j}\). The maximal-order normalization (3.3) uses
\(B_j\). Their exact difference is calculated in Proposition 4.3.
Thus agreeing on the factor weights alone does not identify the two
normalizations.

Section 9.10.7, p.125, then defines a hull in the product of local field
factors. Proposition 9.10.8.1, p.126, claims a further identification
with the minimal \(\mathbb Z_p\)-convex closure. That additional claim
cannot simply be used here: the already recorded strict distinction
between an order and its normalization supplies counterexamples to a
general such assertion. Taking a \(B_j\)-hull is legitimate when that
is the declared operation, but does not prove that a preceding convex
closure already contains the same \(B_j\)-module.

### 3.6 What changes across Frobenius in Joshi IV

Theorem 6.10.1, p.66, fixes \(y_0\), \(y'_0=\varphi(y_0)\), and a
concurrent global normalization of the two presented copies of the
number field. It states equality of the two q-pilot numerical values
and the chain

\[
 L_q\ \le\ V^{\varphi(y_0)}_\Theta
       \ =\ V^{y_0}_\Theta
       \ \le\ C_\Theta|\log q|.                       \tag{3.7}
\]

Here \(V^y_\Theta\) abbreviates exactly the signed, procession-normalized
hull quantity stated there, not any native test hull from (2.5).
The first inequality is invoked from Part III using \(y'_0\); the right
inequality is estimated using \(y_0\) (p.67). Remark 6.10.2, p.66,
expressly excludes direct comparison of the distinct arithmeticoids'
local quantities merely by naming that concurrent normalization.
The proof on p.67 describes the middle equality as following from
identical number-field normalization. It does not in that passage give
an explicit map of the actual collated hulls and their reference
structures.

Proposition 6.10.9, p.69, imports the local upper estimate from
Mochizuki IV, step (v); Propositions 6.10.10 and 6.10.12 give the other
finite and infinite terms. The theorem's hypotheses also invoke the
author's selection in Theorem 5.7.1. Our separately constructed prime
\(\ell\) is not silently identified with that existentially selected
prime. This issue is separate from the original Mochizuki initial
data, which are complete for our family.

The data needed simultaneously for a proof of the middle equality are:

| Datum | Must be stated in a comparison | Insufficient substitute |
| --- | --- | --- |
| Source classes | Which \(\xi_{z,j,v}\) is carried to which class after \(\varphi\), with its background entries. | Equality of the base number fields. |
| Allowed arrows | A correspondence respecting the collation arrows and simultaneous label actions. | A theorem about all linear isomorphisms with a freely fixed source set. |
| Carrier and hull | The indicated product/tensor operation and maximal-order or convex reference on each side. | An abstract isomorphism of the ambient vector spaces. |
| Local scale | The local absolute values, reference lattices, and their exponents in volume. | Rescaling just the displayed q-root while leaving all background entries unchanged. |
| Global weights | The word weights, \(D_j^{-1}\), the label average, and the archimedean term. | A placewise norm equality without its global weights. |
| Value-group link | Compatibility with the global realified pilot and its q-pilot value. | Equal real dimensions or equal degrees of unrelated arithmetic bundles. |

The proved fixed-source target-reset covariance addresses a restricted
row of this table when the **same** source family is transported along
an isomorphism. It does not by itself show that the two source families
appearing in (3.7) are such transports.

### 3.7 A literal sign mismatch that must not be used as an axiom

The last display of Joshi III, Corollary 9.11.1.1, PDF p.128, prints

\[
 -\frac1h\left|\operatorname{LogVol}(\widetilde\Theta)\right|
      \ \ge\ -\sum_w\log|q_w^{1/(2\ell)}|_{L'_w}.       \tag{3.8}
\]

For a nonempty bad-place set, every summand on the right before its
leading minus sign is strictly negative. Thus the right side of (3.8)
is strictly positive, whereas its left side is nonpositive. The
literal display cannot hold. Taking the logarithm of the preceding
Theorem 9.11.1 would instead give the **plus** sign before that sum.
This proves a sign defect in the displayed formulation; it is not a
counterexample to abc or a reason to abandon the IUT route. The form
used in Joshi IV, Theorem 6.10.1, has the negative q-pilot value on the
left and is not (3.8). No conclusion in this note depends on exploiting
the sign defect.

## 4. New theorem: the exact local hulls have global arithmetic bundles

We now construct actual bundles on \(\operatorname{Spec}\mathcal O_K\)
with all archimedean metrics specified, on the same \(K\) in (2.1).
This resolves a concrete arithmetic-degree interface in Remark
3.9.5(vii)(Ob2)--(Ob3). It does not prove the additional source-family
membership in Corollary 3.12.

### 4.1 Arithmetic degree conventions, including the sign

For a finite place \(w\), write \(q_w=\#k(w)\) and
\(|x|_w=q_w^{-\operatorname{ord}_w(x)}\). Thus this absolute value is
the local norm absolute value; for \(w\mid p\) of degree \(d_w\), it
is the \(d_w\)-th power of the native \(p\)-adic absolute value.
At an infinite place \(\sigma\), use the ordinary real or complex
modulus and multiplicity \(n_\sigma=1\) or 2, respectively.

If \(\overline L\) is a metrized rank-one \(\mathcal O_K\)-module,
the finite norm is specified by declaring its local lattice to be the
unit ball. For \(0\ne s\in L\otimes K\), define normalized degree by

\[
 \widehat{\deg}_K(\overline L)
  =-\frac1{[K:\mathbb Q]}
     \left(\sum_{w\ \mathrm{finite}}\log\|s\|_w
          +\sum_{\sigma\mid\infty}n_\sigma\log\|s\|_\sigma\right).
                                                               \tag{4.1}
\]

The finite sum is finite for a fractional ideal with the usual
metrics. This definition is independent of the chosen rational section:
replacement by \(xs\) adds
\(\sum_w\log|x|_w+\sum_\sigma n_\sigma\log|\sigma(x)|=0\).
For completeness, the finite sum is
\(-\log|N_{K/\mathbb Q}x|\), by the norm of the principal fractional
ideal, and the infinite sum is \(\log|N_{K/\mathbb Q}x|\), by the product
of the embeddings. This is the required product formula with its exact
multiplicities.

In particular, if \(\mathfrak a\subset K\) is a fractional ideal with
the standard ambient metric \(\|x\|_\sigma=|\sigma(x)|\), then

\[
       \widehat{\deg}_K(\overline{\mathfrak a})
       =-[K:\mathbb Q]^{-1}\log N(\mathfrak a).          \tag{4.2}
\]

Indeed use the rational section 1. At a finite place with
\(\mathfrak a_w=\pi_w^{b_w}\mathcal O_{K_w}\), its norm is
\(q_w^{b_w}\), and its infinite norm is 1. A positive effective divisor
\(\sum b_ww\) thus corresponds to the lattice \(\mathcal O(-\sum b_ww)\)
of negative degree, not its dual. This fixes the sign convention.

For a rank-\(N\) bundle, degree means degree of its determinant. The
standard Hermitian norm on \(K_\sigma^N\) induces norm 1 on the
determinant of its standard coordinate basis.

### 4.2 Simultaneous realization on the actual field

**Theorem 4.1.** In the situation of Section 2, set

\[
 \mathfrak a_j=\prod_{w\mid p}\mathfrak p_w^{\eta_j},
 \qquad
 \mathcal E_j=\mathfrak a_j^{\oplus N_j}\subset K^{N_j}. \tag{4.3}
\]

Give \(\mathcal E_j\) the standard ambient Hermitian metric at every
infinite place. Negative exponents in (4.3) denote fractional ideals.
Then:

1. \(\mathcal E_j\) is an actual rank-\(N_j\) projective
   \(\mathcal O_K\)-module. At every \(w\mid p\), its lattice identifies
   with the conjugate of \(M_j^\rho=P_j^\rho\), viewed over the first
   factor of \(T_j\). At all other finite places its lattice is
   \(\mathcal O_{K_w}^{N_j}\).
2. With the normalization (3.3),

   \[
    \frac{\widehat{\deg}_K(\overline{\mathcal E_j})}{N_j}
       =-\frac{\eta_j}{e}\log p
       =\frac1{D_j}\log\mu_{B_j}(M_j^\rho).            \tag{4.4}
   \]

3. Choose any positive integer \(C\) divisible by every \(hN_j\), and
   define the metrized line bundle

   \[
    \overline{\mathcal L}
       =\bigotimes_{j=1}^h
          \bigl(\det\overline{\mathcal E_j}\bigr)^{\otimes C/(hN_j)}.
                                                               \tag{4.5}
   \]

   Then all powers are positive integers and

   \[
    C^{-1}\widehat{\deg}_K(\overline{\mathcal L})
       =\frac1h\sum_{j=1}^h
          \frac1{D_j}\log\mu_{B_j}(M_j^\rho).           \tag{4.6}
   \]

4. Tensoring every \(\overline{\mathcal E_j}\) by the same metrized
   line bundle \(\overline Q\) multiplies (4.5) by
   \(\overline Q^{\otimes C}\). Thus the normalization of the
   determinant operation has precisely the common-line-bundle scaling
   property required in Remark 3.9.5(vii)(Ob3-2), p.132.

**Proof.** A fractional ideal of a Dedekind domain is invertible, hence
projective of rank one. This proves the first assertion about the module.
Since \(K/\mathbb Q\) is Galois, every completion above \(p\) has the
same \(e,f,d\) as (2.2). Conjugating the finite etale field decomposition
identifies each local rank-\(N_j\) bundle with \(N_j\) copies of
\(\mathcal O_{K_w}\). In those coordinates (2.5) has depth \(\eta_j\)
in every component, which is exactly (4.3). Only uniformizer ideals
are used, so unit ambiguities in roots and conjugation do not change
the lattice. The ideal \(\mathfrak a_j\) itself is Galois-stable because
the same exponent is assigned at every place over \(p\). This does
not require a global extension beyond \(K\).

Let \(g\) be the number of places of \(K\) above \(p\). Galoisness gives
\([K:\mathbb Q]=g e f\), and \(N(\mathfrak p_w)=p^f\). Since
\(\det\mathcal E_j=\mathfrak a_j^{N_j}\), equation (4.2) gives

\[
 \widehat{\deg}_K(\overline{\mathcal E_j})
   =-\frac{g f N_j\eta_j}{[K:\mathbb Q]}\log p
   =-N_j\frac{\eta_j}{e}\log p.                       \tag{4.7}
\]

All infinite contributions in this computation are exactly zero:
the rational determinant section is the standard coordinate wedge,
whose norm is 1 at every embedding. This is a chosen, stated
trivialization for the computation, not an invariant assertion that
all possible metrics have zero infinite contribution. Independence of
the final degree from replacement of that rational section was proved
in (4.1).

On the local side, the residue field of \(E\) has \(p^f\) elements,
and \(B_j\) has \(N_j\) field factors. Translation invariance and the
index of a uniformizer ideal give

\[
 \mu_{B_j}(M_j^\rho)=p^{-fN_j\eta_j}.
\]

Division by \(D_j=dN_j=efN_j\) proves (4.4), including negative
\(\eta_j\). Additivity of degree on tensor products proves (4.6).
Finally \(\det(\mathcal E_j\otimes Q)
=\det\mathcal E_j\otimes Q^{\otimes N_j}\); the total exponent of
\(Q\) in (4.5) is
\(\sum_j N_j C/(hN_j)=C\). This proves the last assertion. \(\square\)

The precise all-place weighting behind (4.4) can also be written

\[
 \sum_{w\mid p}\frac{[K_w:\mathbb Q_p]}{[K:\mathbb Q]}
          \left(-\frac{\eta_j}{e}\log p\right)
       =-\frac{\eta_j}{e}\log p,                      \tag{4.8}
\]

because the weights sum to 1. Thus extending the single selected
place to all of its Galois conjugates introduces no extra factor of
\([K:\mathbb Q]\), \(d\), or \(m_j\). Equation (4.8) is the global
arithmetic-degree convention; the source's selected-place convention
(3.3) gives the same value in this rational branch.

The reference determinant has not been omitted. In these coordinates
it is \(\det\mathcal O_K^{N_j}\) with the same standard metric and
degree zero. More invariantly, replace each factor in (4.5) by the
relative determinant
\(\det\mathcal E_j\otimes(\det\mathcal O_K^{N_j})^{-1}\).
This is the subtraction stipulated in (Ob3-1-2), p.132. If one instead
computes a covolume after restriction of scalars to \(\mathbb Q\), the
discriminant factor from the reference lattice appears on both sides
of this relative determinant and cancels. It is not a new theta
contribution.

### 4.3 Exact label average, without a number-theoretic asymptotic

**Corollary 4.2.** Let

\[
 R_\ell=\sum_{j=1}^h (2j^2\bmod\ell),                 \tag{4.9}
\]

where each residue is in \(\{1,\ldots,\ell-1\}\). The global bundle in
(4.5) has normalized degree

\[
 \frac{\widehat{\deg}_K(\overline{\mathcal L})}{C\log p}
   =\frac{\ell+1}{12}-\frac{\ell+5}{60\ell}
                +\frac{2R_\ell}{\ell(\ell-1)}.         \tag{4.10}
\]

Each label's value in (4.4) is strictly positive. These signs are
statements about (4.3), not about the complete source quantity
\(L_\Theta\).

**Proof.** The sum of \(m_j\) is \(h(\ell+5)/4\), and

\[
 \sum_{j=1}^h\left\lfloor\frac{2j^2}{\ell}\right\rfloor
     =\frac{\ell^2-1}{12}-\frac{R_\ell}{\ell}.
\]

Substitute these identities into
\(h^{-1}\sum_j(\kappa m_j-k_j)\), using \(e=15\ell\), to obtain
(4.10). For the pointwise sign, \(2j^2/\ell<j\) for \(j\le h\), so
\(k_j\le j\). Consequently

\[
 \kappa m_j-k_j\ge 1-\frac{j+1}{e}>0.
\]

No class-number formula or distribution of quadratic residues is used.
\(\square\)

As a finite check, \(\ell=43\) gives \(R_{43}=473\),
\(\sum_j k_j=164\), and the value \(18836\log p/4515\) in (4.6).
This checks the exact finite expression; it is not evidence for an
unproved global comparison.

### 4.4 The tensor-order/maximal-order correction is explicit

**Proposition 4.3.** In (2.4), if \(\mu_{A_j}(A_j)=1\), then for every
measurable finite-positive-volume region \(H\subset T_j\),

\[
 \frac1{D_j}\log\mu_{A_j}(H)
  =\frac1{D_j}\log\mu_{B_j}(H)
       +\frac{(m_j-1)\kappa}{2}\log p.                 \tag{4.11}
\]

**Proof.** The local extension is tame, so the discriminant exponent
of \(\mathcal O_E/\mathbb Z_p\) is \(f(e-1)\). For an integral basis
of \(\mathcal O_E\), the trace Gram matrix on its \(m_j\)-fold tensor
basis is the tensor product of the Gram matrices. The formula for
the determinant of a tensor product matrix therefore gives

\[
 v_p\operatorname{disc}(A_j)
       =m_jd^{m_j-1}f(e-1).
\]

The product algebra order \(B_j\) has \(N_j=d^{m_j-1}\) copies of
\(\mathcal O_E\), so its discriminant exponent is
\(d^{m_j-1}f(e-1)\). Trace determinants under a finite-index change
of integral basis multiply by the square of that index. Hence

\[
 \log[B_j:A_j]
      =\frac{m_j-1}{2}d^{m_j-1}f(e-1)\log p.
\]

Finally \(\mu_{A_j}=[B_j:A_j]\mu_{B_j}\). Dividing the preceding
display by \(D_j=efd^{m_j-1}\) proves (4.11). \(\square\)

This is a reference-lattice correction, separate from a change of
Bloch--Kato coordinate. It must not be dropped when comparing the
literal tensor prescription in Joshi III (9.10.3.1) with the
maximal-order normalization used above.

### 4.5 The weighted determinant descends to the actual field of moduli

**Corollary 4.4.** The realified metrized line
\(\overline{\mathfrak a_j}\) in (4.3) is the pullback from
\(F_{\rm mod}=\mathbb Q\) of the realified arithmetic line with finite
ideal exponent \(\eta_j/e\) at \(p\) and standard ambient infinite
metric. More concretely, choose the integer \(C\) in Theorem 4.1 to
be divisible by every \(ehN_j\), and put

\[
                   t=\frac{C}{eh}\sum_{j=1}^h\eta_j\in\mathbb Z.
                                                               \tag{4.12}
\]

Then \(\overline{\mathcal L}\) in (4.5) is the isometric pullback of
the actual metrized line \(p^t\mathbb Z\subset\mathbb Q\), with the
ordinary ambient absolute-value metric at infinity. In particular the
weighted determinant object, not just its degree, can be placed over
the original field of moduli after a sufficiently divisible positive
power.

**Proof.** Unique ideal factorization and the common ramification
index \(e\) above \(p\) give

\[
        \mathfrak a_j^e
           =\prod_{w\mid p}\mathfrak p_w^{e\eta_j}
           =p^{\eta_j}\mathcal O_K .                   \tag{4.13}
\]

Multiplication identifies the tensor metric on the left with the
ambient standard metric on the right, since the modulus of a product
is the product of the moduli at each embedding. This proves the
realified statement. In (4.5), the exponent of every
\(\mathfrak p_w\), \(w\mid p\), is
\(\sum_j\eta_jN_j C/(hN_j)=(C/h)\sum_j\eta_j=et\).
There is no finite support elsewhere. Thus its lattice is exactly
\(p^t\mathcal O_K\), with the metric just described. This is the
pullback of \(p^t\mathbb Z\) with its stated metric. Its normalized
degree is \(-t\log p\), consistent with (4.6). \(\square\)

If an additional tensor power is needed to clear the rational
exponents of the q-pilot at other places, \(C\) may be made more
divisible, exactly as allowed in (Ob3-2). The corollary proves descent
of our explicit determinant object. It does not identify its
prime-strip link with the source's particular link to that q-pilot.

## 5. New normalization lemmas, with all slots and metrics tracked

### 5.1 A change at one rational prime

**Proposition 5.1.** Replace every entry of the length-\(m_j\) native
cohomology tuple (2.6) by its standard Bloch--Kato logarithm, including
all background entries and the active entry. Keep the same actual
arrows, source classes, and ambient reference \(B_j\). Then

\[
 \begin{split}
 M_j^{\rm std}&=p^{m_j}M_j^\rho
      =\beta^{\eta_j+em_j}B_j
      =\beta^{e k_j+m_j}B_j,\\
 V^B_j(M_j^{\rm std})&=V^B_j(M_j^\rho)-m_j\log p.
                                                               \tag{5.1}
 \end{split}
\]

For the global realization (4.3), if the change is made only at the
chosen rational prime \(p\), with the standard infinite metrics kept
fixed, then

\[
 \mathcal E_j^{\rm std}=p^{m_j}\mathcal E_j^\rho,
 \qquad
 \frac{\widehat{\deg}_K(\overline{\mathcal E_j^{\rm std}})
       -\widehat{\deg}_K(\overline{\mathcal E_j^\rho})}{N_j}
      =-m_j\log p.                                    \tag{5.2}
\]

The label-averaged change is \(- (\ell+5)\log p/4\).
If instead the infinite metrics are **transported** along multiplication
by \(p^{m_j}\), that map is an isometry of the metrized bundles and
their degrees are equal.

**Proof.** The two logarithms differ by exactly the scalar \(p\).
Every permitted arrow is \(\mathbb Q_p\)-linear, and the tensor map is
multilinear, so changing all \(m_j\) inputs multiplies each point of
the tensor source by \(p^{m_j}\). Closure and module span commute with
this fixed invertible scalar. Multiplication by \(p^{m_j}\) on a
\(D_j\)-dimensional \(\mathbb Q_p\)-space has determinant of absolute
value \(p^{-m_jD_j}\), which proves (5.1).

At every finite place away from \(p\), multiplication by \(p^{m_j}\)
is by a unit. At every place above \(p\), its uniformizer exponent
is \(em_j\). Equation (4.7) therefore proves (5.2) with the fixed
metrics. The average of \(m_j=j+1\) is \((\ell+5)/4\).

For the last assertion, the transported infinite norm is
\(\|y\|_\sigma'=p^{-m_j}\|y\|_\sigma\). On the determinant this
contributes \(+m_jN_j\log p\) to the normalized degree, because
\(\sum_{\sigma\mid\infty}n_\sigma=[K:\mathbb Q]\). It cancels exactly
the finite change in (5.2). Equivalently the complete map is an
isometry, and (4.1) is independent of rational section. \(\square\)

Thus changing a finite coordinate relative to a fixed reference and
transporting an entire metrized global object are different operations.
Neither is allowed to change only the active q-root while silently
leaving the other \(m_j-1\) source coordinates in the old scale.

### 5.2 A change at every rational prime is not a finite divisor

**Proposition 5.2 (the almost-everywhere reference test).** Fix one
member of (2.1) and one label \(j\). Outside a finite set of rational
primes, consider its declared fixed-native background class
\({\rm Kum}(1+p)\) at the selected place, its \(m_j\)-fold tuple, and
the native integral Kummer arrows preserving \(I\). Then the
\(B\)-hull in the \(\rho\)-coordinate is \(B\), whereas after replacing
all coordinates by \(\log_{\rm BK}^{\rm std}\), keeping \(B\) as
reference, it is \(p^{m_j}B\). Consequently the product of these
standard-coordinate local volumes, with that unchanged reference,
is zero. The corresponding sum of local log-volumes is \(-\infty\).
It is not the degree of a finite-support fractional-ideal modification
of a fixed arithmetic bundle.

**Proof.** Exclude 2, primes ramified in \(K\), bad primes of the curve,
and the other finitely many initially distinguished primes. At every
remaining \(p\), the local field \(E_p/\mathbb Q_p\) is unramified,
and

\[
 \log\mathcal O_{E_p}^{\times}=p\mathcal O_{E_p},
 \qquad I=\mathcal O_{E_p},\qquad
 u_p=p^{-1}\log(1+p)\in\mathbb Z_p^\times.              \tag{5.3}
\]

These follow from the logarithm/exponential isomorphism on
\(1+p\mathcal O_{E_p}\); the residue-root-of-unity part has logarithm
zero. In the unramified case the tensor product of the integral orders
is finite etale over \(\mathbb Z_p\), and is already its maximal
product order \(B\).

An integral automorphism of \(I\) preserves primitive vectors.
Because \(E_p\) is unramified, a primitive element of
\(\mathcal O_{E_p}\) is a unit. Every permitted image of \(u_p\) is
therefore a unit. Its tensor has unit value in every field component,
and the identity arrow is present. Hence the \(B\)-span of the native
tuple images is exactly \(B\). Applying (5.1) gives \(p^{m_j}B\)
in standard coordinates, with normalized log-volume
\(-m_j\log p\), independently of the local degree.

There are infinitely many remaining rational primes. Therefore
\(\sum_p m_j\log p=+\infty\), already since each term is at least
\(m_j\log2\). The volume product is zero. A coherent fractional
ideal or finite-rank lattice in a fixed \(K\)-vector space agrees
with a fixed integral reference away from finitely many primes; the
depth \(m_j\) at infinitely many distinct rational primes violates
this property. Any fixed finite archimedean metric contribution
cannot cancel the divergence. \(\square\)

An equivalent elementary warning is that the collection of local
scalars \((p)_p\) is not an idele: its inverse is nonintegral at
infinitely many primes. It cannot be treated as an automorphism of
the ordinary restricted adelic space with its unchanged integral
reference. There is no obstruction to consistently replacing the
reference at the same time. Relative to \(p^{m_j}B\) itself, the local
standard-coordinate volume is again 1. One must then specify the new
restricted product/reference and its comparison with the old one.

The proposition concerns this explicit native Ind1/Ind2 branch only.
It does not identify the complete Ind3 family with that branch, and
does not prove divergence for the full published locus. The reference
test explains why the coordinate switch alone cannot be spliced into
the almost-everywhere-volume-one assertion of Joshi IV, p.65. The
source's existing normalization and its Ind3 comparisons must be
tracked, rather than silently kept or discarded.

## 6. What is now proved at the global interface

Theorem 4.1 does more than assign a name to a real number. It gives
finitely generated projective modules over the **actual** \(\mathcal O_K\),
their localizations at all finite places, explicit infinite metrics,
their determinant bundles, positive integral tensor powers clearing
all label/rank weights, and the normalized degree. The construction
is simultaneous in all labels and needs no further field extension.
It has exactly the common-line-bundle scaling property stipulated in
the source's determinant discussion. Corollary 4.4 additionally gives
descent of the sufficiently powered determinant to the actual field
of moduli \(\mathbb Q\), as an explicit metrized line rather than
only an equality of degrees.

This settles existence of a global arithmetic bundle and its degree
for the specified \(p\)-supported native hulls. It also supplies a
source-correct accounting of the extension from one selected place
to all places of \(K\), the tensor-order correction, and the two
different ways of transporting a coordinate scale. These are genuine
positive constructions, not counterexamples to the global comparison.

The entries set to the standard integral lattice away from \(p\),
and the standard infinite metrics in (4.3), are **part of our stated
construction**. They have not been proved to be the other components
of the full theta-pilot output. Existence of the bundle does not make
those arbitrary choices into source-permitted choices. This is the
precise limitation of using (4.6) as a global theta quantity.

## 7. The smallest remaining comparison requirement

For this family there is no remaining need to seek an initial curve,
core, auxiliary cover, nonzero cusp, place section, level field, or
local full-Galois witness for (2.5). Nor is it necessary to posit
independent automorphisms at repeated labels. Those issues have been
resolved in the stated scope.

The next source-level task is to prove a **marked-family membership
statement**, beginning at one fixed bad rational prime but retaining
the global input:

1. Specify the image of the native principal preideal \(z_jB_j\),
   or of the equivalent native point-ideal family, under the actual
   labeled Kummer correspondence of Theorem 3.11(ii). Record which
   vertical level and which 1-column reference it uses. Show that
   its allowed images are a subfamily of the particular
   \(^{1,\circ}U_{j,p}\) in Corollary 3.12, rather than merely fitting
   inside the larger linear container of IUT IV.
2. Show that these identifications, for all labels at once, retain
   the value-group prime-strip link to the same fixed global q-pilot.
   If the other places or infinite metrics change, give their actual
   changes and their degree contribution. Apply the stipulated Ind3
   maps with their inclusion/surjection direction; do not replace
   them by an assumed equality of native lattices.
3. Only then compare the **same** componentwise hulls and global
   normalizations on the lower and upper sides. For the Joshi version,
   give an explicit correspondence of the source classes, collation
   arrows, references, and weights across \(\varphi\) sufficient for
   the middle equality in (3.7).

Even the local subfamily statement in item 1 must be stated with its
marking: merely observing that \(z_j\) has the same native valuation
as the scalar in IUT IV's upper container does not give that statement.
If it is established, Theorem 4.1 supplies the previously missing
ordinary arithmetic-bundle/degree part of the comparison, while the
remaining global components and IPL/SHE relation still have to be
transported in the indicated source category.

No theorem in this note proves (3.5) or the middle equality of (3.7).
No strict counterexample to either full source assertion has been
constructed. The only strictly refuted assertion recorded here is
the literal sign display (3.8); the global reference test refutes a
different, explicitly described naive coordinate substitution. The
IUT route therefore remains active at the marked-family and Ind3
comparison gate, with a more concrete global arithmetic input now
available.
