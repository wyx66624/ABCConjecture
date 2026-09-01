# Independent review of the common minimum layer for three square labels

Reviewer: ChatGPT, analytic-route agent. Date: 2026-08-30.

Reviewed report:
`research/IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md`,
especially Sections 7--10, after the ordered-product convention was made
explicit. This review does not modify an earlier report, a frozen Lean
module, the aggregate imports, or the manuscript/PDF.

## 1. Verdict and precise scope

**The stated local simultaneous-reachability proof passes.** The same
actual full local Galois automorphism can be used for the four specified
vectors \(u,T_1,T_4,T_9\). The central correction is a valid identity
of their linear actions, the choice of inertia exponent is common to
all three labels, and the finite-field avoidance argument leaves a
nonempty set in both cases for the distinguished vector.

The result concerns the explicitly defined native local family in
\(E=\mathbf Q_{139}(\mu_{210},\pi)\), \(\pi^{105}=139\).
It does not by itself identify that family with a published global
holomorphic collation or pilot, establish global initial theta data,
or prove/disprove IUT or abc. The source report keeps these distinctions.

The underlying integral JW basis and trace-kernel inputs were previously
audited in
`research/IUT_MINIMUM_LAYER_ARITHMETIC_CROSS_REVIEW_2026_08_30.md`.
The full noncommutative cross-handle lift was independently proved in
`research/JW_CROSS_HANDLE_AUTOMORPHISM_CROSS_REVIEW_2026_08_30.md`
and its discrete free-group part was formalized separately. This review
checks their use in the finite family, including the extra composition
step needed to allow arbitrary integer coordinate vectors.

## 2. Full-group lifts and the central correction

Let \(W_{\mathbf Z}\) be the free integer module with the displayed
remaining-handle basis \(e_1,\ldots,e_{208}\), and let \(\omega\)
be the integral alternating form, with \(\omega(v_3,v_4)=1\).
Use coordinates

\[
 z=Aa+Bb+x,\qquad x\in W_{\mathbf Z}.
\]

The linear operations under review are

\[
 N_w(A,B,x)=(A+\omega(w,x),B,x+Bw),
 \qquad C_c(A,B,x)=(A+cB,B,x).
\]

For any \(w,v\), substitution gives

\[
\begin{aligned}
 N_wN_v(A,B,x)
 &=\bigl(A+\omega(v,x)+\omega(w,x+Bv),
          B,x+Bv+Bw\bigr)\\
 &=\bigl(A+\omega(w+v,x)+B\omega(w,v),
          B,x+B(w+v)\bigr).
\end{aligned}
\]

Consequently

\[
 \boxed{N_wN_v=C_{\omega(w,v)}N_{w+v}.}
\]

Also \(C_cC_d=C_{c+d}\) and \(C_cN_w=N_wC_c\).
Alternation gives \(\omega(w,w)=0\), so \(N_w^{-1}=N_{-w}\)
and \(N_w^n=N_{nw}\) for every integer \(n\), including negative
integers. If \(w=\sum_{i=1}^{208}n_i e_i\), induction using the
displayed composition law gives

\[
 \prod_{i=1}^{208}N_{e_i}^{n_i}
 =C_{\sum_{i<j}n_i n_j\omega(e_i,e_j)}N_w.
\]

The factors here have increasing \(i\) from left to right; functions
act rightmost first. Thus the correction needed to obtain \(N_w\) is
the **negative** of this sum, exactly as in equation (8) of the report.
Reversing the product without changing the sign convention would be an
error; the final report fixes the order.

For each basis direction there is a proved full JW cross-handle lift.
The actual word \(x_2\mapsto x_2x_1\), with other generators fixed,
lifts \(C_1\). Its integer powers lift every \(C_c\). Compose these
actual automorphisms and their inverses in the ordered expression above.
Functoriality of their action on logarithmic abelianization proves that
the resulting actual automorphism has linear action \(N_w\).

**This is not a claim that the displayed central relations hold in the
full nonabelian automorphism group.** Different full-group lifts can
differ by an automorphism acting trivially on abelianization. Only the
image calculation is needed. Likewise, to realize a prescribed residue
vector in \(W_{\mathbf F_{139}}\), choose an integer coordinate lift
and use this finite product; no assertion of surjectivity onto a whole
\(139\)-adic linear group is required.

## 3. Source check for the remaining symplectic operation

The additional operation is one integer symplectic transvection on
\(W_{\mathbf Z}\). The precise source used for its full-group lift is
K. Kondo, *Anabelian aspects of the outer automorphism groups of the
absolute Galois groups of mixed-characteristic local fields*,
[arXiv:2512.09231v2](https://arxiv.org/pdf/2512.09231v2),
12 December 2025, PDF pages 19--20.

Local original:
`research/sources/galois_lift_2026_08_30/Kondo_2512.09231v2_Dec2025.pdf`.
SHA-256:
`376d2f3cf6df8ca944a6158349a3ccd50906b424537a84aaa512d1b42e0801bd`.
Both original pages were individually rendered and visually checked;
the renders are in `tmp/three_label_cross_review_2026_08_30/`.

Page 19 explicitly treats **both parities**. For even degree it assigns
the punctured-surface handles to \(x_3,\ldots,x_d\), and fixes
\(\sigma,\tau,x_0,x_1,x_2\). Theorem 2.17 on page 20 states the
surjectivity of the surface homology action onto the integral symplectic
group. Together these statements provide an individual full-group lift
of each required integral symplectic matrix on the remaining handles.

The odd-degree restriction begins **after** Theorem 2.17. We do not use
the subsequent odd-degree theorem to infer an even-degree statement.
Nor do we assume a homomorphic section from the mapping class group
into the outer Galois automorphism group: the original text itself
distinguishes that unproved section property from individual lifting.

For any integer vector \(r\), the map

\[
 S_r(x)=x+\omega(r,x)r
\]

has inverse \(x\mapsto x-\omega(r,x)r\), since \(\omega(r,r)=0\).
Expanding the pairing gives

\[
 \omega(S_rx,S_ry)
 =\omega(x,y)+\omega(r,y)\omega(x,r)
   +\omega(r,x)\omega(r,y)=\omega(x,y).
\]

The omitted quadratic term is zero by \(\omega(r,r)=0\), and the
two displayed cross terms cancel by alternation. Therefore this is
an integral symplectic automorphism even when \(r\) is not primitive.
For degree 210 the remaining genus is \((210-2)/2=104\), so the
relevant group is \(\operatorname{Sp}_{208}(\mathbf Z)\).

## 4. The finite-field avoidance fact and its application

Over a field with \(q\) elements, fewer than \(q\) proper linear
subspaces cannot cover a finite-dimensional vector space. Indeed, if
the ambient dimension is \(D\), each proper subspace has at most
\(q^{D-1}\) elements, so the union has strictly fewer than \(q^D\).
The zero-dimensional case cannot have a proper subspace, and the empty
family is immediate.

The same statement for an arbitrary vector space and a finite family
follows by choosing a witness outside each proper subspace and restricting
to the finite-dimensional span of these witnesses. Each intersection
remains proper. In particular a finite family of nonzero linear forms
has a common vector on which all forms are nonzero, provided its size
is less than \(q\). Adding the kernel of a nonzero vector-valued
linear map costs at most one further proper subspace.

In the application, let

\[
 V=I/pI,\quad L=\pi I/pI,\quad
 V=\mathbf F_pa\oplus\mathbf F_pb\oplus W,
 \quad \dim W=208,\quad \dim(V/L)=2.
\]

Let \(B\) be the \(b\)-coordinate. The available inputs are

\[
 U,T_j\in L,\quad B(U)\ne0,\quad B(T_j)=0,
 \quad T_j\notin\mathbf F_pa\quad(1\leq j\leq3),
\]

and \(\ker B\to V/L\) is onto. Write
\(T_j=A_ja+w_j\); all \(w_j\) are nonzero.

**Case \(a\notin L\).** Nondegeneracy of \(\omega\) makes each
\(w\mapsto\omega(w,w_j)\) a nonzero linear form. Avoid their three
kernels. The union bound is \(3\cdot139^{207}<139^{208}\).
For the chosen \(w\),

\[
 N_w(T_j)+L=\omega(w,w_j)(a+L)\ne0
 \quad\text{for every }j.
\]

If \(N_w(U)\notin L\), use this same map without further change.
Otherwise apply \(C_1\). It adds the nonzero class \(B(U)(a+L)\)
to \(N_w(U)\), while it leaves all \(N_w(T_j)\) unchanged because
their \(B\)-coordinates are zero. Thus one composition works for
all four vectors.

**Case \(a\in L\).** The map \(\lambda:W\to V/L\) is onto;
this follows from the stated surjectivity of \(\ker B\), as the
\(a\)-line now has zero image. Also \(\lambda(w_j)=0\) because
\(T_j\) and \(a\) are in \(L\). Choose \(r\) with

\[
 \lambda(r)\ne0,\qquad \omega(r,w_j)\ne0\quad(1\leq j\leq3).
\]

The kernel of \(\lambda\) has dimension 206, so the excluded union
has at most \(139^{206}+3\cdot139^{207}<139^{208}\) elements.
The coarser bound using four proper subspaces also suffices, since
\(4<139\).

Use an integer lift of \(r\) in the source operation \(S_r\).
Because the original projections vanish, the single parameter 1 gives

\[
 S_r(T_j)+L=\omega(r,w_j)\lambda(r)\ne0
 \quad\text{for all }j.
\]

There is no possible cancellation with an original nonzero term in
this family: the original term is zero. If \(S_r(U)\notin L\),
stop. Otherwise choose a displayed basis vector \(e\) with
\(\lambda(e)\ne0\), which exists by surjectivity. Apply \(N_e\).
It adds \(B(U)\lambda(e)\ne0\) to the zero projection of
\(S_r(U)\), and preserves every \(S_r(T_j)\) projection because
\(B(T_j)=0\) and \(a\in L\).

Every operation used is chosen once for the whole finite family.
These arguments do not replace a simultaneous assertion by separate
existence assertions for different labels.

## 5. The one common inertia choice and the exact arithmetic inputs

Put \(p=139\), \(K_0=\mathbf Q_p(\mu_{210})\),
\(\pi^{105}=p\), and \(E=K_0(\pi)\). The multiplicative order
of 139 modulo 210 is 2, so \(K_0\) is unramified quadratic.
The Eisenstein polynomial gives \((d,e,f)=(210,105,2)\). Since
\(1/105>1/138\), the logarithm identifies principal units with
\(\pi\mathcal O_E\), and

\[
 I=p^{-1}\log\mathcal O_E^\times=\pi^{-104}\mathcal O_E,
 \qquad pI=\pi\mathcal O_E.
\]

For the precise local family, set

\[
 u=\frac{\log(1+p)}p,\qquad
 \tau_s=\frac{\log(1+p\pi^{15s})}p,
 \quad T_s=p^{-k_s}\tau_s,
 \quad k_s=\left\lfloor\frac{s}{7}+\frac{104}{105}\right\rfloor,
 \quad s\in\{1,4,9\}.
\]

The directly checked data are

| \(s\) | \(k_s\) | \(v_p(T_s)\) | \(v_p(\operatorname{Tr}T_s)\) |
|---|---|---|---|
| 1 | 1 | \(-90/105\) | 6 |
| 4 | 1 | \(-45/105\) | 9 |
| 9 | 2 | \(-75/105\) | 13 |

For every such \(s\), the seven distinct conjugates of
\(\pi^{15s}\) occur fifteen times in the relative norm. Hence

\[
 \operatorname{Tr}_{E/\mathbf Q_p}(T_s)
 =\frac{30}{p^{k_s+1}}\log(1+p^{s+7}).
\]

All trace valuations in the table are equalities. Also
\(\operatorname{Tr}(u)=210\log(1+p)/p\) is a unit. The established
integral JW basis and trace-kernel description therefore imply
\(B(U)\ne0\) and \(B(T_s)=0\) in \(\mathbf F_p\).

The logarithm tail is in \(pI\). For its term of degree \(n\geq2\),
the bound \(v_p(n)\leq n-2\) gives

\[
 n(1+s/7)-(k_s+1)-v_p(n)
 \geq 1+ns/7-k_s\geq1+2s/7-k_s.
\]

The three last bounds are \(2/7,8/7,11/7\), all larger than
\(1/105\). It follows that

\[
 T_s\equiv\pi^{15s}/p^{k_s}\pmod{pI}.
\]

Use the actual inertia automorphism
\(\sigma(\pi)=\zeta_{105}\pi\), fixing \(K_0\). For
\(0\leq h<7\),

\[
 \sigma^h(T_s)\equiv
 \zeta_7^{sh}\pi^{15s}/p^{k_s}\pmod{pI}.
\]

For a fixed \(s\), these seven vectors lie on seven different
\(\mathbf F_{139}\)-lines. Indeed, the reduction of \(\zeta_7\)
has order seven, while \(7\nmid138\), so its cyclic group meets
\(\mathbf F_{139}^\times\) only in 1. A nonzero residue difference
of leading coefficients is a unit; multiplying it by
\(\pi^{15s}/p^{k_s}\) has the negative valuation in the table,
and cannot lie in \(pI\). Finally \(s\) is prime to seven, so
equality of the two lines forces equality of the two exponents modulo
seven.

For each of the three labels, at most one \(h\) sends it to the
fixed line \(\mathbf F_pa\). At most three of the seven choices are
forbidden. Select one common remaining \(h\). This one field
automorphism fixes \(u\), preserves \(L\), preserves trace, and
puts **all three** normalized labels off the fixed line. Section 4
then supplies a single further composition. This verifies the common
automorphism required by the result.

## 6. Consequences and limits

The constructed action \(M\) satisfies, simultaneously,

\[
 v_p(Mu)=v_p(MT_1)=v_p(MT_4)=v_p(MT_9)=-104/105.
\]

Its \(\mathbf Q_p\)-linearity gives respective valuations
\(1/105,1/105,106/105\) for the images of
\(\tau_1,\tau_4,\tau_9\). For the contravariant integral Kummer
convention, use the inverse source automorphism and the unit scalar
from local Tate duality. This changes none of the four valuations,
and uses one choice of arrow for every occurrence.

For the explicitly defined local tensor blocks with \(m=j+1\),
one theta factor \(\tau_{j^2}\), and \(m-1\) background factors
\(u\), the attained fractional-ideal exponents are

\[
 105k_{j^2}-104(j+1)=-103,-207,-206
 \quad (j=1,2,3).
\]

Each field component has this same value: the tensor factors are copies
of the Galois field \(E\), and its embeddings preserve its valuation.
The common witness has nonzero components, and its multiples by the
maximal order fill the corresponding product fractional ideal. The
universal bound in the other direction follows from preservation of
\(I\) and of the integer powers \(p^{k_s}I\) by the permitted
integral action. These assertions verify the local hull calculation for
the source family stated in the report; they do not identify a different
published source family with this one.

No mandatory correction remains in the reviewed mathematical argument.
The fixed product order, the restriction of the central identities to
linear images, and the distinction between individual surface lifts and
a group-theoretic section are essential and are present in the report.
The global arithmetic and source-identification audits remain separate.

## 7. Arithmetic stability under the subsequent parameter generalization

After Sections 1--6 of this review were written, the source report added
Section 11. Its linear and inertia arguments are stable under the
following replacement, independently checked here: take any
\(b_0\in\mathbf Q_{139}\) with \(v_{139}(b_0)=1\), and replace
\(\pi^{105}=p\) by \(\pi^{105}=b_0\).

The polynomial remains Eisenstein, the same unramified quadratic field
contains \(\mu_{105}\), and the degrees and fractional ideals above
are unchanged. The factor \(b_0/p\) is a rational unit. The trace
formula becomes

\[
 \operatorname{Tr}(T_s)=
 \frac{30}{p^{k_s+1}}\log(1+p^7b_0^s).
\]

Its valuation is still \(s+6-k_s\), giving \(6,9,13\). The logarithm
leading terms and inertia characters remain
\(\pi^{15s}/p^{k_s}\) and \(\zeta_7^{sh}\). Thus every group,
coordinate, and finite-field step audited here applies to this more
general parameter as well. The separate identification of \(b_0\)
as a rational square root of an actual Tate parameter is a local
uniformization input, checked in the source/root arithmetic audit;
it is not inferred from the linear-algebra proof.

## 8. Lean verification after completion of the mathematical proof

New standalone module:

`Lean/IUTThreeClosures/IUTThreeLabelMinimumLayer20260830.lean`.

Final source SHA-256:

`89554847efa9e1a88868ec80a1bd47642bd9fb54f4c00065ef37901cf616ca76`.

The module proves the linear central law and its negative correction,
both inverse identities, and constructs `crossEquiv` as an actual linear
equivalence. It also constructs `transvectionEquiv`, proves preservation
of the alternating form, proves common avoidance for a finite family
of proper subspaces, and obtains one transvection making all initially
zero projections nonzero. The final theorem specializes this to exactly
three vectors over `ZMod 139`; primality and the strict bound
\(3+1<139\) are proved internally.

The module does not assert the central law in a full Galois automorphism
group or formalize a local field, its logarithm, its inertia group, or
global initial theta data. The relationship of its variables to those
arithmetic objects remains the proved mathematical application above.

From the `Lean` directory the direct command

```text
lake env lean IUTThreeClosures/IUTThreeLabelMinimumLayer20260830.lean
```

finished with exit code 0 and no errors or warnings. A second run
compiled the identical source through `lean --stdin` and printed axiom
dependencies for **all 15 public theorems**, plus the two displayed
linear-equivalence definitions. These are 17 checked declarations, not
a claim that the module has only 17 definitions in total.

All declaration names in the table have prefix
`IUTThreeClosures.IUTThreeLabelMinimumLayer20260830.`.

| Declaration | Axiom dependencies |
|---|---|
| `cross_comp` | `propext`, `Quot.sound` |
| `central_comp` | `propext`, `Quot.sound` |
| `central_cross_comm` | `propext`, `Quot.sound` |
| `central_zero` | `propext`, `Quot.sound` |
| `cross_zero` | `propext`, `Quot.sound` |
| `central_corrected_cross_comp` | `propext`, `Quot.sound` |
| `cross_neg_comp` | `propext`, `Quot.sound` |
| `cross_comp_neg` | `propext`, `Quot.sound` |
| `transvectionMap_apply` | `propext`, `Quot.sound` |
| `transvection_preserves` | `propext`, `Quot.sound` |
| `exists_outside_subspaces` | `propext`, `Classical.choice`, `Quot.sound` |
| `exists_common_nonzero` | `propext`, `Classical.choice`, `Quot.sound` |
| `exists_common_nonzero_with_projection` | `propext`, `Classical.choice`, `Quot.sound` |
| `exists_common_transvection_projection` | `propext`, `Classical.choice`, `Quot.sound` |
| `three_labels_common_transvection` | `propext`, `Classical.choice`, `Quot.sound` |
| `crossEquiv` | `propext`, `Quot.sound` |
| `transvectionEquiv` | `propext`, `Classical.choice`, `Quot.sound` |

Representative commands for the integrated audit are

```lean
#print axioms IUTThreeClosures.IUTThreeLabelMinimumLayer20260830.cross_comp
#print axioms IUTThreeClosures.IUTThreeLabelMinimumLayer20260830.central_corrected_cross_comp
#print axioms IUTThreeClosures.IUTThreeLabelMinimumLayer20260830.crossEquiv
#print axioms IUTThreeClosures.IUTThreeLabelMinimumLayer20260830.transvection_preserves
#print axioms IUTThreeClosures.IUTThreeLabelMinimumLayer20260830.exists_common_transvection_projection
#print axioms IUTThreeClosures.IUTThreeLabelMinimumLayer20260830.three_labels_common_transvection
```

No `sorry`, `admit`, new axiom declaration, or unsafe proof mechanism is
used. The old modules, aggregate imports, and frozen manuscript/PDF
were not changed by this verification task.
