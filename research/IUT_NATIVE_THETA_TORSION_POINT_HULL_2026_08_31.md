# Standard-type theta values in a declared native additive carrier

**Author:** ChatGPT  
**Date:** 2026-08-31  
**Status:** Mathematical continuation; no new Lean or TeX declarations.

This note proves a smaller-source version of the local equality \(M=P\).
The source consists of numerical representatives of standard-type theta
values, with their actual \(\mu_{2\ell}\)-ambiguity, placed in an
explicitly declared **additive** native carrier. For every independent
choice of these representatives, one actual full-Galois Kummer operator
on that additive carrier attains all the previous point-hull bounds.
An arbitrary \(\mathcal O_E^\times\)-multiple is not substituted for
the source's normalized ambiguity.

The theta evaluation class \(\operatorname{Kum}(\zeta a)\), the
scalar \(\zeta a\in E\), and the unit-cohomology class
\(\operatorname{Kum}_p(1+p\zeta a)\) are different objects.
Sending the scalar through the declared additive operator is not,
by definition alone, the same as applying a source-permitted arrow
to the original multiplicative theta class. Section 8 records
the exact source arrows and the remaining membership requirement
for IUT III, Corollary 3.12.

The already constructed global initial theta data are retained. No
initial-data condition is reopened, no global IUT comparison is used
as an axiom, and no ABC proof or counterexample is claimed. The accepted
66-page manuscript, its TeX inputs, and its verification record are
unchanged.

## 1. Original sources and the precise source restriction

Page numbers are one-based physical PDF pages. At the passages used
here they agree with the printed folios.

| Source | Archived bytes and SHA-256 | Original URL; title-page version |
| --- | --- | --- |
| Mochizuki, Etale Theta | [Archived PDF](<E:/AImath/abc猜想/research/sources/initial_data_2026_08_30/Mochizuki_Etale_Theta_2009_author.pdf>); 42c5d9180c69bc9fa6596ce1a11662494315954ed74301060bf1819f955a7406 | [Author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/The%20Etale%20Theta%20Function%20and%20its%20Frobenioid-theoretic%20Manifestations.pdf); December 2008, 112 pages. The local filename's 2009 is not the title-page date. |
| Mochizuki, IUT I | [Archived PDF](<E:/AImath/abc猜想/research/sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf>); 7360e3ed27c235b5497a0743d3ed1646fbb97688547d16b7c784fc7f127f1f03 | [Author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20I.pdf); May 2020, 186 pages |
| Mochizuki, IUT II | [Archived PDF](<E:/AImath/abc猜想/research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_II_December2020.pdf>); 180bfa6aaddc4ae37af37acaad51f61e0a47b33b8255ad3169e28a970ae39b7c | [Author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20II.pdf); December 2020, 174 pages |
| Mochizuki, IUT III | [Archived PDF](<E:/AImath/abc猜想/research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf>); 9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9 | [Author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf); May 2020, 199 pages |

The decisive original passages are:

1. **EtTh, Proposition 1.4(ii)--(iii), pp.20--21.** This gives the
   classical theta series, its functional equation, and its relation to
   Kummer evaluation. At this earlier stage arbitrary constant units
   occur; one must not stop at that unnormalized description.
2. **IUT I, Example 3.2(ii), pp.70--71, and (iv), p.71.** The function
   \(\Theta_v\) is the reciprocal of the normalized \(\ell\)-th root
   of the theta function. Its constant ambiguity is \(\mu_{2\ell}\);
   its value at \(\sqrt{-q_v}\) is
   \(\underline q_v=q_v^{1/(2\ell)}\), with that same ambiguity.
   The period-translation ambiguity in (ii) is distinct from the
   finite ambiguity after fixing the evaluation labels below.
3. **IUT II, Remark 1.12.2(i)--(ii), pp.58--59.** Standard-type
   normalization reduces the older constant-unit ambiguity to
   \(\mu_{2\ell}\). Thus an arbitrary unit twist is not an
   additional freedom of this normalized evaluation.
4. **IUT II, Corollary 2.5(ii)--(iii), pp.71--72, and
   Remark 2.5.1(i), p.72.** In the standard cyclotomic rigidity
   marking and its Kummer map, with the indicated \(\delta\) chosen
   to be the identity, the unperfected evaluation set at label \(j\)
   is exactly the Kummer image of
   \[
      \mu_{2\ell}\,\underline q_v^{\,j^2},
      \qquad j=0,1,\ldots,(\ell-1)/2.                 \tag{1.1}
   \]
   These integer representatives are part of the description,
   not an arbitrary reduction of the exponent modulo \(\ell\).
5. **IUT II, Remark 2.5.1(ii)--(iii), p.73.** The evaluation points
   are the specified period translates of \(\pm i\). The
   \(\mu_{2\ell}\)-ambiguities are independent across labels.
   All representatives need not be multiplied by one common root.
6. **IUT III, Proposition 3.1(ii), p.93, and Proposition 3.3(ii),
   p.100.** The single-field inclusion in a tensor packet inserts
   literal \(1\)'s in the other factors. These statements concern
   ring structures and embeddings; they do not alone identify a
   final possible image in Corollary 3.12.
7. **IUT III, Proposition 3.4(ii), pp.102--103, and
   Proposition 3.5(ii)(c), pp.105--106.** LGP monoids are formed by
   pulling Gaussian monoids back through the specified log-link
   and inserting the result in the distinguished tensor slot.
   The unit subgroup of the unperfected splitting submonoid is
   the \(2\ell\)-torsion subgroup. The perfected version has a
   larger torsion ambiguity and is not identified with this
   fixed finite field source.

EtTh p.20, IUT II pp.72--73, and IUT III p.105 were rendered and
visually checked. The page images are cached in
[the local source-render directory](<E:/AImath/abc猜想/tmp/iut_native_theta_torsion_2026_08_31>).
They confirm the reciprocal, the square exponent, the order \(2\ell\),
and the explicit independence statement.

## 2. Direct proof of the normalized value formula

Let \(q\) be a Tate parameter in a nonarchimedean field of odd residue
characteristic, with \(|q|<1\), and suppose \(i^2=-1\) is available.
The series in EtTh, Proposition 1.4, may be written
\[
 \vartheta(U)=
 \sum_{n\in\mathbf Z}(-1)^nq^{n(n+1)/2}U^{2n+1}.    \tag{2.1}
\]
It converges at each of the points below: term valuations grow
quadratically in \(|n|\).

For \(a\in\mathbf Z\), reindexing by \(n+a\) gives
\[
 \vartheta(q^{a/2}U)
   =(-1)^a q^{-a^2/2}U^{-2a}\vartheta(U).             \tag{2.2}
\]
Also \(\vartheta(-U)=-\vartheta(U)\). At \(U=i\), the terms with
\(n=0,-1\) sum to \(2i\), and every other term has positive
valuation. Hence \(\vartheta(i)\) is a unit. Define
\(f(U)=\vartheta(U)/\vartheta(i)\). Since \(i^{-2a}=(-1)^a\),
\[
          f(iq^{a/2})=q^{-a^2/2},\qquad
          f(-iq^{a/2})=-q^{-a^2/2}.                 \tag{2.3}
\]
Taking reciprocals of \(\ell\)-th roots and including the two signs
gives exactly
\[
          \mu_{2\ell}\bigl(q^{1/(2\ell)}\bigr)^{a^2}.
                                                               \tag{2.4}
\]
Indeed their \(\ell\)-th powers are
\(\pm q^{a^2/2}\), and all roots of these two values comprise
the displayed coset.

This proves the scalar formula directly. IUT II, Remark 2.5.1(i),
identifies it with the group-theoretic evaluation orbit relative to
that remark's cyclotomic and Kummer marking. Its reconstruction
statement is not replaced here by an assertion about arbitrary
isomorphisms of the additive native field.

## 3. Local fields supplied by the constructed global family

The following local assumptions suffice:
\[
 \ell\ge7,\quad \ell,p\ \text{prime},\quad
 p\equiv-1\pmod{30\ell},\quad
 b_0\in\mathbf Q_p,\quad v_p(b_0)=2.
                                                               \tag{3.1}
\]
Put
\[
 \begin{gathered}
 e=15\ell,\quad d=2e=30\ell,\quad h=(\ell-1)/2,\qquad
 K_0=\mathbf Q_p(\mu_{30\ell}),\\
 \varpi^e=b_0,\quad E=K_0(\varpi),\quad q=b_0^2,\quad
 \beta=\varpi^{(e+1)/2}/p,\quad r_0=\varpi^{15},\\
 \kappa=(e-1)/e,\qquad I=\beta^{1-e}\mathcal O_E.
 \end{gathered}                                                   \tag{3.2}
\]
Thus \(r_0^\ell=b_0\), and \(r_0=q^{1/(2\ell)}\) is a permitted
root in (1.1). The letter \(\varpi\) does **not** denote a
uniformizer. With \(\gamma=p^2/b_0\in\mathbf Z_p^\times\),
\[
 \beta^e=p\gamma^{-(e+1)/2},\qquad
 \varpi=\gamma\beta^2,\qquad
 r_0=\gamma^{15}\beta^{30}.                         \tag{3.3}
\]
The first equation is Eisenstein over the unramified quadratic field
\(K_0\). The extension \(E/\mathbf Q_p\) is Galois, with
ramification index \(e\), residue degree \(2\), and
\(v_p(\beta)=1/e\). In particular
\[
                 \mu_{2\ell}\subset K_0.            \tag{3.4}
\]

As proved in the [general tame-label report](<E:/AImath/abc猜想/research/IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md>),
Sections 2 and 4,
\[
 p^{-1}\log(\mathcal O_E^\times)
    =I=\mathfrak D_{E/\mathbf Q_p}^{-1},\qquad
 \operatorname{Tr}_{E/\mathbf Q_p}(I)=\mathbf Z_p.   \tag{3.5}
\]
For completeness, \(e\le p-2\), so logarithm and exponential are
valuation-preserving inverses on the first principal-unit layer.
The different of the tame extension is
\(\beta^{e-1}\mathcal O_E\). Also \(p\nmid d\), so
\(1/d\in\mathcal O_E\) has trace \(1\).

This is the actual completion of the level field at the distinguished
split Tate place of every member of the already constructed
[unbounded global family](<E:/AImath/abc猜想/research/FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md>),
with the [initial theta data already supplied](<E:/AImath/abc猜想/research/IUT_INITIAL_DATA_POWERFREE_FAMILY_2026_08_31.md>).
The application uses its valuation-four Tate parameter, not a
replacement parameter of valuation two. The local proof itself
does not require \(\ell\equiv43\bmod60\).

Let \(\Gamma_E\) denote the actual integral Kummer operators supplied
by automorphisms of the **full** absolute Galois group \(G_E\),
with integral Tate-module identifications, as in the preceding
reports. They are \(\mathbf Z_p\)-linear automorphisms of \(I\),
extended \(\mathbf Q_p\)-linearly to \(E\).
The subgroup used below comes from the checked full relative
Jannsen--Wingberg presentation and field inertia. No equality
\(\Gamma_E=\operatorname{GL}_{\mathbf Z_p}(I)\) is assumed.

## 4. Torsion twists and the finite-layer conditions

For \(1\le j\le h\), choose \(\zeta_j\in\mu_{2\ell}\)
independently and set
\[
 \begin{gathered}
 s_j=j^2,\quad a_j=r_0^{s_j},\quad x_j=\zeta_j a_j,\quad
 r_j=v_p(x_j)=2s_j/\ell,\\
 n_j=\lfloor r_j\rfloor,\quad k_j=n_j+1,\quad
 T_j=x_j/p^{k_j},\qquad
 V=I/pI,\quad V_0=\beta I/pI .
 \end{gathered}                                                   \tag{4.1}
\]
An overbar denotes reduction in \(V\). The quotient \(V/V_0\)
has dimension two over \(\mathbf F_p\).

### Proposition 4.1. Exact trace, content, and inertia character

For every independent choice of the \(\zeta_j\),
\[
 \begin{gathered}
 k_j=\lfloor r_j+\kappa\rfloor,\qquad
 T_j\in\beta I\setminus pI,\qquad
 \operatorname{Tr}_{E/\mathbf Q_p}(T_j)=0,\\
 1\in\beta I\setminus pI,\qquad
 \operatorname{Tr}_{E/\mathbf Q_p}(1)=d\in\mathbf Z_p^\times .
 \end{gathered}                                                   \tag{4.2}
\]
If \(\sigma\in\operatorname{Gal}(E/K_0)\) satisfies
\(\sigma(\beta)=\epsilon\beta\), with \(\epsilon\) of order \(e\),
then
\[
                 \sigma(T_j)=\epsilon^{30j^2}T_j.  \tag{4.3}
\]
The projective orbit of \(\overline{T_j}\) under \(\sigma\),
in the \(\mathbf F_p\)-projective space of \(V\), has exactly
\(\ell\) elements.

**Proof.**
Since \(\ell\nmid2j^2\), write
\[
              2j^2=\ell n_j+\delta_j,\qquad 1\le\delta_j\le\ell-1.
                                                               \tag{4.4}
\]
Then \(k_j=n_j+1=\lfloor r_j+\kappa\rfloor\), since
\(0<\delta_j/\ell-1/e<1\). Furthermore
\[
      v_p(T_j)=\delta_j/\ell-1,\qquad
      e\,v_p(T_j)=15\delta_j-e.                     \tag{4.5}
\]
The minimum valuation exponents of \(\beta I\) and \(pI\)
are respectively \(2-e\) and \(1\), whereas
\[
                  2-e<15-e\le15\delta_j-e\le-15<1.
                                                               \tag{4.6}
\]
This proves \(T_j\in\beta I\setminus pI\), and hence
\(x_j\in p^{k_j}I\setminus p^{k_j+1}I\).
The layer assertion for \(1\) follows from \(2-e<0<1\).

By (3.3), \(T_j\) is a \(K_0\)-multiple of
\(\beta^{30j^2}\). Since \(e\nmid30j^2\), the geometric
sum of its tame inertia conjugates is zero. Thus
\(\operatorname{Tr}_{E/K_0}(T_j)=0\), and the absolute trace
vanishes as well. This holds for every \(\zeta_j\in K_0\).

Equation (4.3) is exact, not merely a leading-term statement:
\(\zeta_j,\gamma,p\) are fixed by \(\sigma\).
The character has order
\[
                   e/\gcd(e,30j^2)=\ell.           \tag{4.7}
\]
These roots reduce injectively, and
\(\mu_\ell\cap\mathbf F_p^\times=\{1\}\), because
\(p\equiv-1\bmod\ell\).
If two vectors \(\sigma^a\overline{T_j}\) and
\(\sigma^b\overline{T_j}\) differ by an
\(\mathbf F_p^\times\) scalar, reduction of (4.3) therefore
forces \(\ell\mid a-b\). To justify reduction at this layer,
different Teichmuller residues have a unit difference in \(K_0\);
multiplying \(T_j\notin pI\) by such a unit cannot put it in
\(pI\). Conversely \(\ell\mid a-b\) gives equality already
in \(E\). This proves the orbit assertion. \(\square\)

A nonzero root-of-unity multiplier cannot cancel a leading term.
This argument does **not** commute multiplication by \(\zeta_j\)
with \(F\in\Gamma_E\): such an \(F\) need not be \(K_0\)-linear.

## 5. One full-Galois arrow for all the declared points

The previously established integral wild-generator basis gives
\[
 I=\mathbf Z_p a_{\mathrm{JW}}\oplus
   \mathbf Z_p b_{\mathrm{JW}}\oplus W,\qquad
 \ker\operatorname{Tr}=\mathbf Z_p a_{\mathrm{JW}}\oplus W,\qquad
 \operatorname{Tr}(b_{\mathrm{JW}})\in\mathbf Z_p^\times.
                                                               \tag{5.1}
\]
The \(b_{\mathrm{JW}}\)-coordinate \(B\) is
\(\operatorname{Tr}/\operatorname{Tr}(b_{\mathrm{JW}})\).
The integral symplectic basis on \(W\) gives its nondegenerate
alternating form \(\omega\).

The checked full-group lifts have canonical linear actions
\[
 \begin{aligned}
 C_c(Aa_{\mathrm{JW}}+Bb_{\mathrm{JW}}+w)
     &=(A+cB)a_{\mathrm{JW}}+Bb_{\mathrm{JW}}+w,\\
 N_z(Aa_{\mathrm{JW}}+Bb_{\mathrm{JW}}+w)
     &=(A+\omega(z,w))a_{\mathrm{JW}}
         +Bb_{\mathrm{JW}}+w+Bz,\\
 S_z(w)&=w+\omega(z,w)z,\qquad
 S_z(a_{\mathrm{JW}})=a_{\mathrm{JW}},\quad
 S_z(b_{\mathrm{JW}})=b_{\mathrm{JW}} .
 \end{aligned}                                                   \tag{5.2}
\]
Integer-coordinate parameters suffice. Arbitrary such crosses
are finite compositions of the checked cross-handle words with
a central correction. The \(S_z\) have individual symplectic
handle lifts. These are full absolute-Galois-group lifts, not
just automorphisms of a maximal pro-\(p\) quotient.

The original inputs and the integral strengthening are recorded in
the [full-Galois report](<E:/AImath/abc猜想/research/IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md>),
the [independent group-word review](<E:/AImath/abc猜想/research/JW_CROSS_HANDLE_AUTOMORPHISM_CROSS_REVIEW_2026_08_30.md>),
and Section 4 of the general tame-label report. They use the
full Jannsen--Wingberg relative presentation (printed pp.74--76),
Hoshi--Nishio Proposition 1.1 and Lemma 1.3, and Kondo's
even-degree trace-kernel and handle-lift results (PDF pp.19--20).
They do not assume every trace-preserving linear map lifts.

### Theorem 5.1. Common attainment for independent torsion representatives

For every tuple
\((\zeta_1,\ldots,\zeta_h)\in\mu_{2\ell}^{\,h}\), there exists
one \(F\in\Gamma_E\) such that
\[
          v_p(F(1))=v_p(F(T_j))=-\kappa
          \quad\text{for every }1\le j\le h.        \tag{5.3}
\]
The quantifier is \(\forall(\zeta_j)\,\exists F\,\forall j\).
An \(F\) independent of every possible tuple \((\zeta_j)\)
is not asserted.

**Proof.**
The trace-zero subspace of \(V\) maps onto \(V/V_0\).
For \(x\in I\), subtract
\(\operatorname{Tr}(x)/d\in\mathcal O_E\subset\beta I\).
This kills trace without changing the image in \(I/\beta I\).

By Proposition 4.1, the first \(\ell\) elements of each
projective orbit of \(\overline{T_j}\) are distinct. At most
one exponent in \(\{0,\ldots,\ell-1\}\) can put it on the
line \(\mathbf F_p\overline{a_{\mathrm{JW}}}\).
There are \(h<\ell\) inputs. Choose one exponent outside all
these bad sets and apply that field inertia automorphism.
It fixes \(1\) and preserves \(V_0\) and trace. After this
common operation write
\[
       \overline{T_j}=A_j\overline{a_{\mathrm{JW}}}+w_j,
       \qquad 0\ne w_j\in W/pW.                    \tag{5.4}
\]
Put \(U=\overline1\in V_0\); it has \(B(U)\ne0\).
Write \(\lambda_0:V\to V/V_0\) for the quotient map.

If \(\overline{a_{\mathrm{JW}}}\notin V_0\), choose
\(z\in W/pW\) with \(\omega(z,w_j)\ne0\) for all \(j\).
The excluded sets are \(h<p\) proper hyperplanes, so they
cannot cover \(W/pW\). Formula (5.2) gives
\[
       \lambda_0(N_zT_j)
          =\omega(z,w_j)\lambda_0(a_{\mathrm{JW}})\ne0.
                                                               \tag{5.5}
\]
If \(N_zU\) remains in \(V_0\), follow by \(C_1\).
It moves this vector by the nonzero quotient vector
\(B(U)\lambda_0(a_{\mathrm{JW}})\), and changes none of
the other projections, whose \(B\)-coordinates vanish.
Otherwise no central correction is needed.

If \(\overline{a_{\mathrm{JW}}}\in V_0\), the map
\(\lambda=\lambda_0|_{W/pW}\) is onto \(V/V_0\)
by the trace-kernel surjectivity. Each \(w_j\) lies in
\(\ker\lambda\). Choose \(z\) outside \(\ker\lambda\)
and all hyperplanes \(\omega(-,w_j)=0\).
There are \(h+1<p\) proper subspaces, so their union
has fewer than \(p^{\dim(W/pW)}\) elements. Then
\[
             \lambda_0(S_zT_j)
                 =\omega(z,w_j)\lambda(z)\ne0.      \tag{5.6}
\]
If \(S_zU\) remains in \(V_0\), choose \(z'\) with
\(\lambda(z')\ne0\) and apply \(N_{z'}\).
It moves that vector out of \(V_0\) by
\(B(U)\lambda(z')\), but leaves all other projections
unchanged: their \(B\)-coordinates vanish and
\(a_{\mathrm{JW}}\in V_0\).

Lift the selected residue coordinates to integers and compose
the actual full-group lifts. Together with the initial field
inertia, their canonical action \(M\) sends
\(1,T_1,\ldots,T_h\) into \(I\setminus\beta I\).
This is exactly native valuation \(-\kappa\).

The integral Tate-pairing calculation gives the Kummer action
of an arrow as \(c_\alpha M_\alpha^{-1}\), with
\(c_\alpha\in\mathbf Z_p^\times\).
Take the inverse of the actual group automorphism constructed
above. Its Kummer action is a unit multiple of \(M\), hence
has the same valuations. This proves (5.3). \(\square\)

The earlier rational background unit causes no new condition.
For
\[
                       u=p^{-1}\log(1+p)\in\mathbf Z_p^\times
                                                               \tag{5.7}
\]
and every \(F\in\Gamma_E\), \(\mathbf Q_p\)-linearity gives
\[
                       F(u)=uF(1).                \tag{5.8}
\]
The same \(F\) therefore works for tensor-slot units \(1\)
and for the earlier unit-cohomology backgrounds \(u\).
Equation (5.8) would not follow for arbitrary
\(\mathcal O_E^\times\)-backgrounds.

## 6. Fixed additive hull of standard-type theta values

For \(m=m_j=j+1\), put
\[
 \mathcal T_m=E^{\otimes_{\mathbf Q_p}m},\qquad
 A_m=\mathcal O_E^{\otimes_{\mathbf Z_p}m},\qquad
 B_m=\text{integral closure of }A_m\text{ in }\mathcal T_m .
                                                               \tag{6.1}
\]
Galoisness gives
\[
 \mathcal T_m\simeq
   \prod_{\operatorname{Gal}(E/\mathbf Q_p)^{m-1}}E,\qquad
 B_m\simeq
   \prod_{\operatorname{Gal}(E/\mathbf Q_p)^{m-1}}\mathcal O_E .
                                                               \tag{6.2}
\]
Thus \(B_m\) is the product of rings of integers, not
the generally smaller tensor order \(A_m\).

Insert \(x_j=\zeta_j a_j\) in the distinguished slot and \(1\)'s
in the other slots, using the ring embedding of III 3.1(ii):
\[
          Z_{j,\zeta_j}=1\otimes\cdots\otimes x_j
                      \in\mathcal T_m .           \tag{6.3}
\]
Let \(\Phi_{F,m}=F^{\otimes m}\) and define
\[
 H_{j,\zeta_j}
   =\overline{\operatorname{span}_{B_m}
       \{\Phi_{F,m}(Z_{j,\zeta_j}):F\in\Gamma_E\}} .
                                                               \tag{6.4}
\]
This acts on a declared additive tensor carrier. It is not a
definition of the image of the original multiplicative theta
Kummer class under a Galois-group automorphism.

### Theorem 6.1. The declared additive point-source hull

For every \(j\) and \(\zeta_j\in\mu_{2\ell}\),
\[
 H_{j,\zeta_j}
      =P_j:=\beta^{\,e k_j-(e-1)m_j}B_{m_j}.         \tag{6.5}
\]
Here \(\beta^\nu B_m\) means exponent \(\nu\) in each
field component of (6.2).
For any independent tuple of representatives, the same \(F\)
from Theorem 5.1 provides a generator for every \(j\).

**Proof.**
Every \(F\in\Gamma_E\) preserves \(I\) and all \(p^nI\).
Since \(x_j\in p^{k_j}I\) and \(1\in I\), every component of
\(\Phi_{F,m}(Z_{j,\zeta_j})\) has valuation at least
\[
                         k_j-m\kappa .             \tag{6.6}
\]
The component maps in (6.2) apply field embeddings to the
separate factors, and all embeddings preserve native valuation.
Thus the span and its closure are contained in the right
side of (6.5).

For the common \(F\) in Theorem 5.1,
\[
         v_p(F(x_j))=k_j-\kappa,\qquad
         v_p(F(1))=-\kappa .                        \tag{6.7}
\]
Every component of this tensor has valuation exactly
\(k_j-m\kappa\). Dividing by a componentwise uniformizer
of that valuation gives an element of \(B_m^\times\).
This one tensor therefore generates the product ideal in
(6.5), proving the reverse inclusion already for the
algebraic span. The ideal is closed, proving the assertion
about closure as well. \(\square\)

Taking the entire \(\mu_{2\ell}\)-orbit of the scalar point
in (6.3) gives the same hull \(P_j\).
The calculation does not require a source containing
\(a_jB_m\), or the larger product
\(a_jI\times I^{m-1}\).
The previously proved \(M=P\) remains valid, but the lower
inclusion here uses only a point source.

With \(\mu(B_m)=1\) and \(D_m=d^m\), the computed normalized
log-volume is
\[
       D_m^{-1}\log\mu(H_{j,\zeta_j})
                   =(m_j\kappa-k_j)\log p .         \tag{6.8}
\]
Indeed there are \(d^{m-1}\) field components, each of
residue degree two. Therefore
\(\log\mu(\beta^\nu B_m)=-2d^{m-1}\nu\log p\);
division by \(d^m=2e\,d^{m-1}\) gives
\(-\nu/e\log p\). There is no additional division by \(m_j\).

Consequently the local lattice in the arithmetic-bundle
construction of the [next global-comparison report](<E:/AImath/abc猜想/research/IUT_GLOBAL_COMPARISON_NEXT_GATE_2026_08_31.md>)
can be generated from these numerical theta-value representatives
in a native marked additive carrier. This supplies a more
specific local source for that construction. It does not
identify the assembled bundle with the final published
pilot-output family.

## 7. The separate logarithmic coefficient and its uniform tail

For \(x\in\mathcal O_E\setminus\{0\}\), define
\[
          \lambda(x)=p^{-1}\log(1+px),\qquad
          k(x)=\lfloor v_p(x)+\kappa\rfloor .
                                                               \tag{7.1}
\]
In the normalized Bloch--Kato coordinate
\(\rho=p^{-1}\log_{\mathrm{BK}}^{\mathrm{std}}\),
this is the coefficient of
\(\operatorname{Kum}_p(1+px)\). It is not the
theta evaluation class \(\operatorname{Kum}(x)\).

### Proposition 7.1. Uniform comparison for every actual arrow

Let \(r=v_p(x)\ge0\), \(k=k(x)\), and \(F\in\Gamma_E\).
Then
\[
 \begin{gathered}
 v_p(\lambda(x)-x)\ge1+2r\ge k+1-\kappa,\qquad
 \lambda(x)-x\in p^{k+1}I,\\
                    v_p(F(\lambda(x)))=v_p(F(x)).
 \end{gathered}                                                   \tag{7.2}
\]
These statements are uniform in all \(\zeta_j\) when
\(x=\zeta_j a_j\).

**Proof.**
The \(n\)-th term of \(\lambda(x)-x\), for \(n\ge2\),
has valuation
\[
                    (n-1)+nr-v_p(n).
                                                               \tag{7.3}
\]
For odd \(p\), \(v_p(n)\le n-2\) for every \(n\ge2\),
so (7.3) is at least \(1+2r\). Convergence and the
ultrametric inequality give the first bound. Since
\(k\le r+\kappa\),
\[
                      1+2r\ge k+1-\kappa ,
                                                               \tag{7.4}
\]
the latter being the minimum valuation in \(p^{k+1}I\).

By definition of \(k\),
\(x\in p^kI\setminus p^{k+1}I\).
An automorphism of \(I\) preserves both sublattices and
their difference. Consequently
\[
 v_p(F(x))<k+1-\kappa
                \le v_p(F(\lambda(x)-x)).
                                                               \tag{7.5}
\]
Strict ultrametricity proves (7.2).
When \(x=\zeta_j a_j\), both \(r\) and \(k\) are
independent of \(\zeta_j\), proving uniformity. \(\square\)

Set \(t_j=\lambda(\zeta_j a_j)\) and \(u=\lambda(1)\).
For every \(F\), the two tensors
\[
 F(1)^{\otimes(m_j-1)}\otimes F(\zeta_j a_j),
 \qquad
 F(u)^{\otimes(m_j-1)}\otimes F(t_j)
                                                               \tag{7.6}
\]
generate the same principal \(B_{m_j}\)-ideal.
Proposition 7.1 gives equality of active-factor valuations,
and (5.8) gives equality for the backgrounds.
The tensors themselves need not coincide.
Both orbit hulls equal \(P_j\).

Also
\[
                 (t_j-\zeta_j a_j)/p^{k_j}\in pI,
                                                               \tag{7.7}
\]
so their reductions in \(I/pI\) agree.
The same \(F\) from Theorem 5.1 attains the minimum for
\(t_j/p^{k_j}\) too. Exact trace zero was asserted for
the pure scalar \(T_j\); the coefficient \(t_j\) is not
incorrectly declared to have exact trace zero.

If every one of the \(m_j\) unit-cohomology coordinates
in (7.6) is changed from \(\rho\) to
\(\log_{\mathrm{BK}}^{\mathrm{std}}\), the tensor is
multiplied by \(p^{m_j}\). Its hull becomes
\[
 p^{m_j}P_j=\beta^{\,e k_j+m_j}B_{m_j},\qquad
 D_{m_j}^{-1}\log\mu(p^{m_j}P_j)
                   =-(k_j+m_j/e)\log p .
                                                               \tag{7.8}
\]
The change from (6.8) is \(-m_j\log p\).
This rescales all coordinates of the specified
unit-cohomology source. It does not rescale only one
side of the published comparison, and does not assert
that the original theta function has acquired an
extra factor \(p^{m_j}\).
Reference lattices, metrics, and other places must
be kept consistent, as in the separate global report.

## 8. The source arrows that have and have not been matched

| Object | Proven native description | Map or marking used | What is not inferred |
| --- | --- | --- | --- |
| Standard-type theta evaluation | \(\operatorname{Kum}(\mu_{2\ell}a_j)\), \(a_j=r_0^{j^2}\) | II 2.5.1(i), standard cyclotomic rigidity and its Kummer map; fixed labels | Equality to \(\operatorname{Kum}_p(1+p\zeta_j a_j)\) |
| Numerical representative | \(x_j=\zeta_j a_j\in E\) | The fixed classical field marking of the evaluation | \(E\)-linearity of a later mono-analytic operator |
| Single-slot logarithmic packet coefficient | \(\ell_j^{-1}(x_j)\otimes1\otimes\cdots\otimes1\) | The specified log-link field isomorphism \(\ell_j:\log(E_{\mathrm{prev}})\to E_{\mathrm{current}}\), followed by III 3.1(ii) | That \(\ell_j^{-1}(x_j)\) is automatically the same scalar \(x_j\) in an already fixed predecessor marking |
| Declared native additive model | \(Z_{j,\zeta_j}\) of (6.3) | A coherent local logarithmic marking; Theorems 5.1 and 6.1 compute its \(\Gamma_E\)-orbit hull | Membership in the global output union of III 3.12 |
| Normalized unit-cohomology point | \(t_j=p^{-1}\log(1+px_j)\), backgrounds \(u=p^{-1}\log(1+p)\) | The separately specified \(\rho\) coordinate; Proposition 7.1 | Equality of original multiplicative Kummer classes or of the point tensors |
| Standard unit-cohomology point | \(pt_j\), each background \(pu\) | Simultaneous coordinate change (7.8) | Permission to keep inconsistent global references and call the number the same published comparison |
| Perfected splitting monoid | Larger torsion orbits in an inductive-limit carrier | II 2.5(ii), III 3.5(ii)(c) | That every perfected representative lies in this finite \(E\) |

The expression involving \(\ell_j\) describes the required
pullback, not a new permission to choose all \(\ell_j\)
independently. IUT III, Proposition 1.3(i), pp.41--42,
constructs the Hodge-theater log-links from **one**
isomorphism of the corresponding D-Hodge theaters.
Remark 1.3.1, p.43, retains its synchronization.
A full poly-isomorphism does not remove that quantifier.

In the **tautological local** log-link of III, Definition
1.1(i), pp.23--25, the logarithmic field is by construction
identified with the native field through the \(p\)-adic
logarithm. If a successor field is marked through that
identification, the pullback coefficient has native coordinate
\(x_j\). With its single-slot embedding, Theorem 6.1 computes
the point hull for that marked local branch.
This uses logarithm to mark the codomain logarithmic field;
it does not assert that the log-link is a ring homomorphism
from the predecessor's original field.

The Kummer-class distinction is already visible from
\[
          v_p(x_j)=2j^2/\ell>0,\qquad
          v_p(1+px_j)=0.
                                                               \tag{8.1}
\]
Their multiplicative Kummer classes have different
valuation components. As a scalar in the normalized
logarithmic carrier, \(x_j\) instead corresponds to
the unit \(\exp(px_j)\) under normalized logarithm,
not to \(x_j\) under the original multiplicative
Kummer map. These are three separately typed
constructions. Proposition 7.1 is a connection between
two additive models, not an identification of the
three multiplicative inputs.

The original source explicitly retains these distinctions:

* III, Definition 1.1(i), pp.23--25, gives the local log-link;
  Remark 1.1.2, pp.29--30, distinguishes a tautological
  rigidifying path from the full poly-isomorphism.
* Proposition 1.2(iv), p.31, states the failure of the
  simple Kummer compatibility one might otherwise use.
* Remark 1.2.3(i), p.39, says a root-of-unity ambiguity
  at one level is killed by logarithm at the next.
  This does not say \(F(\zeta_j a_j)=F(a_j)\)
  in the same additive native field.
* Proposition 3.4(ii), pp.102--103, uses the specified
  pullbacks. Proposition 3.5(i)--(ii), pp.103--106,
  then uses Kummer isomorphisms at adjacent indices
  and precomposites with iterated log-links.
* Corollary 3.12, pp.173--175, takes possible images
  of a **global theta-pilot object** under these maps
  and Ind1, Ind2, and Ind3 before each holomorphic hull.

The finite constant ambiguity of the actual normalized
theta values therefore does not obstruct common attainment
in the declared additive carrier, and its point source
already generates \(P_j\).
The next membership question is to exhibit one compatible,
globally indexed choice of the log-Kummer maps and pilot
reference data for which these additive point images lie
in the relevant \(n,\circ U_{j,p}\) of Corollary 3.12,
and to retain those same data in comparison to the
unindetermined q-pilot.
A tautological local marking or equality of numerical
volumes alone is insufficient.

Initial theta data, local square powers, finite torsion
ambiguity, the literal tensor-slot units, and the actual
full-Galois common-attainment calculation in this declared
carrier are not missing ingredients of that next step.
Its simultaneous marked global-family membership and
treatment of Ind3 remain unproved here.

## 9. Reproducibility and boundary of the continuation

This is the only research report written for the theta-point
continuation. It leaves the previous global-comparison report
and the frozen manuscript unchanged.

The new mathematical content is the finite-source
restriction with the direct evaluation proof, Proposition
4.1 and Theorem 5.1 for every independent tuple of its
representatives, and the point-source equality of
Theorem 6.1. Proposition 7.1 supplies the uniform per-arrow
comparison with separately defined unit-cohomology
coefficients.

The checked full-Galois word lifts and integral
canonical/Kummer covariance are explicitly reused.
Their entire number-theoretic input is not claimed to
have been formalized in Lean. No source's global
log-volume inequality is added as an axiom or declared
to follow from these local calculations.
