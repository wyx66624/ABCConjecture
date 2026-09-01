# Selected-place projections, product-order hulls, and the finite global sum

Author: ChatGPT. Date: 2026-08-31.

## 0. Status and exact scope

This note starts with the source-checked membership theorem in
IUT_IDENTITY_LOG_LINK_LOCAL_MEMBERSHIP_2026_08_31.md: in one fixed
coric column and one specified basic Kummer branch, the canonical
transfer image of the marked local point belongs to the corresponding
raw possible-image set. When there is more than one selected place
above a rational prime, that theorem gives membership in a **block
projection**, not membership of a zero extension.

The new result below proves that this projection statement is exactly
enough after formation of the source's maximal-product-order
holomorphic hull. Central idempotents of the product order separate
the blocks. Thus no zero-extension claim, no common point realizing
all block projections, and no independence of the choices in different
blocks is needed for a finite weighted log-volume lower bound.

This is a positive finite-place result. It does not identify a
horizontal theta/q comparison, does not prove that the finite data
extend to the source's complete adelic metrized object, and does not
prove the global inequality in IUT III, Corollary 3.12.

## 1. Original-source dictionary

The page numbers below refer to the archived author PDFs:

* Mochizuki, *Inter-universal Teichmüller Theory III*, May 2020:
  research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf.
* Mochizuki, *Inter-universal Teichmüller Theory IV*, April 2020:
  research/sources/continuation_2026_08_30/Mochizuki_IUT_IV_April2020.pdf.

| Source | Exact input used here |
|---|---|
| IUT III, Proposition 3.1(i)--(ii), pp. 92--97 | The local holomorphic tensor packet is a tensor product of direct sums of selected local fields. It carries the direct-sum field decomposition, its product measure, and the integral structures formed from the local rings. |
| IUT III, Proposition 3.2, pp. 97--99 | The mono-analytic packet at a rational place \(v_{\mathbb Q}\) is the tensor product of the direct sums over selected \(v\mid v_{\mathbb Q}\). Thus it decomposes into ordered tensor words. |
| IUT III, Proposition 3.9(i)--(iii), pp. 115--117 | Log-volumes are first attached locally to the tensor packets and then assembled into the global arithmetic-degree convention. |
| IUT III, Remark 3.9.5(i)--(iii), pp. 126--128 | For a relatively compact region, the holomorphic hull is the smallest set \(\lambda\mathcal O\), with every field component of \(\lambda\) nonzero, that contains the region. It is monotone under inclusion. |
| IUT III, Theorem 3.11(i)--(ii), pp. 153--156 | Ind1 and Ind2 enter the possible-image union; Ind3 is the upper-semicompatibility through vertical log-links. This note does not replace any of them by an arbitrary linear group. |
| IUT III, Corollary 3.12, pp. 173--175 | For each label and rational place the source forms the union of possible images, then its holomorphic hull. The notation is a collection of component sets; p. 174 explicitly calls its inclusion notation a slight abuse. |
| IUT IV, Proposition 1.4(i), p. 13 | Local log-volume on a finite extension is normalized by its local degree; on a tensor product it is normalized so that \(p\) times the integral product order has log-volume \(-\log p\). |
| IUT IV, Remark 1.7.1, p. 17 | After the normalization of Proposition 1.4(i), an ordered word \(\boldsymbol v=(v_0,\ldots,v_j)\) has weight proportional to \(\prod_i[(F_{\rm mod})_{v_i}:\mathbb Q_p]\). |
| IUT IV, Theorem 1.10, proof step (iv), p. 27 | For fixed \(p,j\), every ordered collection of selected places is estimated separately and the weighted average over these collections is taken afterwards. |

The claims below use only these definitions and the already proved
base-branch memberships. They do not use the asserted comparison
between the theta-pilot and q-pilot volumes.

## 2. The finite product algebra

Fix a rational prime \(p\), a label \(j\), and put \(m=j+1\). Let
\(V_p\) be the finite set of selected places of the field of moduli
above \(p\). The local packet has a canonical finite decomposition

\[
 T_{j,p}
 =\bigotimes_{i=0}^{j}\left(\bigoplus_{v\in V_p}E_v\right)
 \ \simeq\
 \bigoplus_{\boldsymbol v\in V_p^m}T_{\boldsymbol v},
 \qquad
 T_{\boldsymbol v}=\bigotimes_{i=0}^{j}E_{v_i}.
 \tag{2.1}
\]

Semisimplifying each finite étale tensor algebra gives a product of
fields. Write

\[
 B_{j,p}=\prod_{\boldsymbol v\in V_p^m}B_{\boldsymbol v}
 \subset T_{j,p}
 \tag{2.2}
\]

for the maximal product order, and let
\(e_{\boldsymbol v}\in B_{j,p}\) be its central idempotent supported on
the word \(\boldsymbol v\). For a subset \(S\subset T_{j,p}\), write
\(\pi_{\boldsymbol v}S\) for its word projection.

We use \(\operatorname{Span}_{B}(S)\) for the \(B\)-submodule generated
by \(S\), and an overline for topological closure.

### Proposition 2.1 (projection is exact after product-order span)

For every subset \(S\subset T_{j,p}\),

\[
 \operatorname{Span}_{B_{j,p}}(S)
 =
 \prod_{\boldsymbol v\in V_p^m}
 \operatorname{Span}_{B_{\boldsymbol v}}
       (\pi_{\boldsymbol v}S),
 \tag{2.3}
\]

inside the finite direct product (2.1). Consequently,

\[
 \overline{\operatorname{Span}_{B_{j,p}}(S)}
 =
 \prod_{\boldsymbol v\in V_p^m}
 \overline{\operatorname{Span}_{B_{\boldsymbol v}}
       (\pi_{\boldsymbol v}S)} .
 \tag{2.4}
\]

**Proof.** Projection of a \(B_{j,p}\)-linear combination is a
\(B_{\boldsymbol v}\)-linear combination, so the left side of (2.3)
is contained in the right side.

Conversely, fix a word \(\boldsymbol v\). An element of the
\(\boldsymbol v\)-factor span is a finite sum

\[
 y_{\boldsymbol v}
 =\sum_{r=1}^N b_r\pi_{\boldsymbol v}(s_r),
 \qquad b_r\in B_{\boldsymbol v},\ s_r\in S.
\]

View \(b_r\) as the element \(e_{\boldsymbol v}b_r\) of the full
product ring. Then

\[
 \sum_{r=1}^N(e_{\boldsymbol v}b_r)s_r
\]

belongs to \(\operatorname{Span}_{B_{j,p}}(S)\), has
\(\boldsymbol v\)-coordinate \(y_{\boldsymbol v}\), and has all other
coordinates zero. Summing this construction over the finite set of
words proves the reverse inclusion in (2.3).

The topology is a finite product topology. Closure of a finite product
of subsets is the product of their closures. Applying this to (2.3)
proves (2.4). \(\square\)

This proposition does **not** say that a zero extension of a projected
point belongs to \(S\). It says that it belongs to the module span of
\(S\), because the hull ring itself contains the required central
idempotent.

### Proposition 2.2 (the source holomorphic hull factorizes)

Let \(S\subset T_{j,p}\) be relatively compact and satisfy the
finite-positive-volume hypothesis under which IUT III, Remark
3.9.5(i), defines its holomorphic hull. Then

\[
 \operatorname{Hull}_{B_{j,p}}(S)
 =
 \prod_{\boldsymbol v\in V_p^m}
 \operatorname{Hull}_{B_{\boldsymbol v}}
       (\pi_{\boldsymbol v}S).
 \tag{2.5}
\]

Here the right-hand factors mean the smallest product fractional
ideals containing the indicated projections.

**Proof.** Decompose every field factor of \(T_{j,p}\), and write
\(\mathcal O_a\) for its valuation ring. A source hull is
\(\lambda B_{j,p}=\prod_a\lambda_a\mathcal O_a\), with
\(\lambda_a\ne0\). Such a product contains \(S\) if and only if its
\(a\)-th factor contains the \(a\)-th projection of \(S\). Therefore
the componentwise smallest choices are simultaneously the globally
smallest choice. Grouping the field factors by ordered words gives
(2.5). \(\square\)

The compactness hypothesis matters. Remark 3.9.5(i) declares the hull
of a non-relatively-compact set to be the whole ambient space. We do
not silently extend (2.5) to that different convention. Corollary
3.12, p. 175, explicitly invokes compactness for the possible-image
sets used there.

More literally, Remark 3.9.5(i), p. 127, assumes first that the input
contains a relatively compact subset with finite log-volume, where
“finite” is glossed there as \(>-\infty\). If the input itself is
relatively compact, its hull is the smallest \(\lambda\mathcal O\)
described above; otherwise the source declares the hull to be the
entire ambient \(\mathbb Q\)-span. Proposition 2.2 uses the first
branch only. Remark 3.9.5(ii), pp. 127--128, then records precisely
extensivity and monotonicity, properties (P2) and (P3). No equality
between the input and its hull is being assumed.

## 3. From projection membership to a finite weighted volume bound

For each ordered word let \(P_{\boldsymbol v}\subset T_{\boldsymbol v}\)
be a full-rank product fractional ideal. Assume only that

\[
 P_{\boldsymbol v}
 \subset
 \overline{\operatorname{Span}_{B_{\boldsymbol v}}
          (\pi_{\boldsymbol v}S)}
 \qquad(\boldsymbol v\in V_p^m).
 \tag{3.1}
\]

This is exactly the form supplied when projected members of one raw
possible-image set, possibly represented by different allowed arrows,
have already been shown to attain the local principal ideals. No one
member of \(S\) is required to attain all words.

### Theorem 3.1 (finite selected-place product lower bound)

Assume the hypotheses of Proposition 2.2: in particular, `S` is relatively
compact, contains a relatively compact finite-log-volume subset, and its
source holomorphic hull is therefore in the first branch of IUT III,
Remark 3.9.5(i), rather than the convention that assigns the whole ambient
space to a non-relatively-compact set.  Under (3.1),

\[
 \prod_{\boldsymbol v\in V_p^m}P_{\boldsymbol v}
 \subset
 \overline{\operatorname{Span}_{B_{j,p}}(S)}
 \subset
 \operatorname{Hull}_{B_{j,p}}(S).
 \tag{3.2}
\]

Normalize additive Haar measure by
\(\mu_{\boldsymbol v}(B_{\boldsymbol v})=1\), and put

\[
 D_{\boldsymbol v}=\dim_{\mathbb Q_p}T_{\boldsymbol v},
 \qquad
 V_{\boldsymbol v}(H)
 =D_{\boldsymbol v}^{-1}\log\mu_{\boldsymbol v}(H).
 \tag{3.3}
\]

For
\[
 h_v=[(F_{\rm mod})_v:\mathbb Q_p],\qquad
 \omega_{\boldsymbol v}
 =\frac{\prod_{i=0}^{j}h_{v_i}}
        {[F_{\rm mod}:\mathbb Q]^m},
 \tag{3.4}
\]
the weights are positive and sum to one. Hence

\[
 \begin{split}
 V_{j,p}\bigl(\operatorname{Hull}(S)\bigr)
 &:=
 \sum_{\boldsymbol v\in V_p^m}
 \omega_{\boldsymbol v}
 V_{\boldsymbol v}
   \bigl(\pi_{\boldsymbol v}\operatorname{Hull}(S)\bigr)\\
 &\ge
 \sum_{\boldsymbol v\in V_p^m}
 \omega_{\boldsymbol v}
 V_{\boldsymbol v}(P_{\boldsymbol v}).
 \end{split}
 \tag{3.5}
\]

If
\[
 P_{\boldsymbol v}
 =\prod_{a}\varpi_a^{\,c_a}\mathcal O_a,
 \qquad q_a=\#k_a,
\]
over the field factors \(a\) of the word algebra, then the right side
of (3.5) is the explicit finite number

\[
 -\sum_{\boldsymbol v}\omega_{\boldsymbol v}
       \frac1{D_{\boldsymbol v}}
       \sum_{a}c_a\log q_a .
 \tag{3.6}
\]

**Proof.** The first inclusion of (3.2) is (2.4) and (3.1).
The second holds because the source hull is a closed
\(B_{j,p}\)-module containing \(S\). Haar measure is monotone, so each
word inclusion gives
\[
 V_{\boldsymbol v}
  (\pi_{\boldsymbol v}\operatorname{Hull}(S))
 \ge V_{\boldsymbol v}(P_{\boldsymbol v}).
\]
Multiplication by the positive weights and summation prove (3.5).
The identity
\[
 \sum_{\boldsymbol v}\prod_i h_{v_i}
 =\left(\sum_{v\mid p}h_v\right)^m
 =[F_{\rm mod}:\mathbb Q]^m
\]
proves that the weights sum to one, exactly as in IUT IV, Remark
1.7.1. Finally
\(\mu_a(\varpi_a^{c_a}\mathcal O_a)=q_a^{-c_a}\);
product measure gives (3.6). \(\square\)

### 3.1.1 There is no word factorial or tensor-length divisor

The denominator in (3.4) is exactly the denominator printed in IUT IV,
Remark 1.7.1, p. 17:

\[
 \sum_{\{w_i\}_{i=0}^{j}}\prod_{i=0}^{j}h_{w_i}.
 \tag{3.7a}
\]

The collections are indexed by the \(m=j+1\) tensor slots and are
explicitly allowed to repeat places; IUT IV, step (iv), p. 27, again
calls them “not necessarily distinct”. Thus they form the ordered
Cartesian power \(V_p^m\), and (3.7a) is
\((\sum_{v\mid p}h_v)^m=[F_{\rm mod}:\mathbb Q]^m\).
There is no quotient by \(m!\).

There is also no further quotient by \(m\). IUT IV, Proposition 1.7,
pp. 16--17, defines the word statistic
\(\beta_{\boldsymbol e}=\sum_{i=1}^{m}\beta_{e_i}\) and proves that
its weighted average is \(m\beta_{\rm avg}\). The tensor log-volume is
this sum over slots. The separate source normalization in IUT III,
Proposition 3.9(i), p. 116, is the average over the procession labels.
Accordingly (3.5) first averages the full word log-volumes with
\(\omega_{\boldsymbol v}\), while Corollary 3.2 then contributes the
sole factor \(1/h\) from the label average.

### Corollary 3.2 (finite primes and the procession average)

Let \(\Sigma\) be any finite set of rational primes. For every label
\(j=1,\ldots,h\), suppose (3.1) holds for the final raw
possible-image set \(S_{j,p}\) at every \(p\in\Sigma\). Then

\[
 \frac1h\sum_{j=1}^{h}\sum_{p\in\Sigma}
 V_{j,p}\bigl(\operatorname{Hull}(S_{j,p})\bigr)
 \ge
 \frac1h\sum_{j=1}^{h}\sum_{p\in\Sigma}
 \sum_{\boldsymbol v}
 \omega_{j,\boldsymbol v}
 V_{\boldsymbol v}(P_{j,\boldsymbol v}).
 \tag{3.7}
\]

**Proof.** This is the finite sum of (3.5). All sums are finite, so
no restricted-product, convergence, common-global-member, or
interchange-of-limit assertion is involved. \(\square\)

Equation (3.7) is the strongest unconditional numerical conclusion
that follows from the projected local inclusions alone. It matches
the order used in IUT IV: component hull, degree-normalized local
log-volume, word weights, label average, and only then the sum over
rational places.

## 4. Application to the reviewed identity branch

Let \(S_{j,p}={}^{0,\circ}U^{\rm raw}_{j,p}\) be the raw union in the
fixed column and fixed basic branch of the reviewed membership theorem.
The compactness input needed in Theorem 3.1 is the one explicitly invoked
for the actual possible-image sets in the proof of IUT III, Corollary 3.12,
PDF page 175; it is not being inferred from the projected membership alone.
For the power-free family already constructed in this repository,
\(F_{\rm mod}=\mathbb Q\). Thus \(V_p\) is a singleton, there is one
word, and \(\omega=1\). The proved canonical-orbit ideal

\[
 P_j=\beta^{e k_j-(e-1)m_j}B_j
\]

satisfies (3.1), so Theorem 3.1 recovers, now inside the actual source
holomorphic hull,

\[
 P_j\subset
 \operatorname{Hull}_{B_j}
   ({}^{0,\circ}U^{\rm raw}_{j,p}),
\qquad
 \frac1{D_j}\log\mu_{B_j}
 \bigl(\operatorname{Hull}({}^{0,\circ}U^{\rm raw}_{j,p})\bigr)
 \ge
 \frac1{D_j}\log\mu_{B_j}(P_j).
 \tag{4.1}
\]

This strengthens the wording of the earlier projection caveat: for
general \(F_{\rm mod}\), blockwise projected memberships would suffice
for the **product-order hull and its weighted volume**, even though
they would still not be literal zero-extended raw members. The
repository has not yet constructed the required full-Galois attaining
arrows for every local field in a general multi-place initial datum, so
we do not assert (3.1) for such an arbitrary datum.

## 5. Why no Arakelov-degree inequality follows from these data alone

The finite quantity (3.7) is not automatically the degree of a global
metrized vector bundle. There are two independent missing inputs:

1. local lattices at all but finitely many primes must equal a fixed
   integral reference and must be localizations of one projective
   module;
2. the infinite metrics and their trivializations must be specified
   and transported with that same object.

The logical necessity of the second input has a strict elementary
counterexample. Let \(L=\mathbb Z\subset\mathbb Q\) have its usual
finite local lattices. For any real \(t\), give \(L_{\mathbb R}\) the
metric
\[
             \|x\|_{\infty,t}=e^{-t}|x|.
\]
Every finite projection, product-order hull, Haar volume, and weight is
independent of \(t\), whereas
\[
             \widehat{\deg}(\overline L_t)=t.
\]
Thus the same finite-place data admit arbitrarily large positive or
negative Arakelov degree. No inequality for the complete degree can
be deduced until the archimedean source metric is fixed. This refutes
only the proposed implication from finite projections alone; it is not
a counterexample to the IUT comparison, whose source includes
archimedean constituents.

When actual global projective modules and metrics have separately been
constructed, additivity of determinant degree turns the corresponding
finite equalities into an Arakelov equality. That construction was
carried out for the rational one-prime branch in
IUT_GLOBAL_COMPARISON_NEXT_GATE_2026_08_31.md, Theorem 4.1. The
present theorem neither assumes that its arbitrarily completed
components are source outputs nor transfers that construction to a
general multi-place datum.

## 6. Indeterminacies and reference transport: exact boundary

* **Ind1.** The theorem may use different permitted members of the raw
  union to witness different word projections. Central idempotents
  combine them only after taking the \(B\)-span. It does not construct
  a single Ind1 arrow attaining every word.
* **Ind2.** The identity Ind2 branch already suffices for the
  inclusion. Enlarging the raw union cannot destroy it. No claim that
  all Ind2 maps preserve one native presentation is needed.
* **Ind3.** The input \(S\) must be the raw union in the one fixed
  final carrier in which Corollary 3.12 forms its hull. The theorem
  does not turn an Ind3 inclusion into equality and does not transport
  \(P_{\boldsymbol v}\) across an unspecified vertical reference
  change.
* **Tensor reference.** Equations (2.3)--(3.7) use the maximal product
  order \(B_{j,p}\). If one instead uses the tensor order, the
  finite-index/discriminant correction must be retained. If one
  changes from the native \(p^{-1}\log_{\rm BK}^{\rm std}\) coordinate
  to the standard Bloch--Kato coordinate, all slots and the reference
  must be transported together.
* **Horizontal link.** Neither a module span nor a finite weighted
  volume proves that its components are related to the unchanged
  q-pilot by the source's one-column IPL/SHE comparison.

## 7. Smallest remaining global gate

The projection/zero-extension issue is no longer an obstruction
**after the product-order hull**. What remains is narrower:

1. for a genuinely multi-place datum, prove the blockwise source
   memberships (3.1) for every ordered word, using actual local
   full-Galois arrows and the same marked theta-pilot;
2. identify the other finite places and infinite metrics of these
   hulls with one globally projective, source-permitted arithmetic
   vector bundle, rather than an arbitrary completion;
3. apply the actual Ind3 inclusions and preserve their reference
   lattices;
4. prove that this complete marked family is the one connected, through
   the source's one-column log-Kummer and value-group links, to the
   fixed q-pilot.

Only after these steps may the finite lower bound (3.7) be inserted
into the full adelic comparison. No result here proves or disproves
the abc conjecture, and no source comparison theorem has been taken as
an axiom.
