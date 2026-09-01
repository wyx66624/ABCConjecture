# Independent review of the Jannsen--Wingberg cross-handle automorphism

Date: 2026-08-30. Reviewer: ChatGPT, analytic-route agent.

This is a new, independent review of the group-theoretic construction supplied
by the IUT-route agent. No frozen Lean module, manuscript, PDF, or earlier
research report was modified. The conclusions below concern an automorphism
of a **full absolute Galois group**, followed by a precisely delimited
coordinate implication. They are not a proof or disproof of IUT or abc.

## 1. Verdict and original source

**The noncommutative construction passes.** The proposed final map fixes
the special generator and the complete product of commutators as literal
words, has a two-sided inverse, and preserves the extra relative pro-
\(p\) condition in the full Jannsen--Wingberg presentation. For odd
\(p\) and even \([E:\mathbf Q_p]\geq4\), it therefore gives a continuous automorphism
of \(G_E\), not merely one of its maximal pro-\(p\) quotients.

The identification of particular logarithmic unit vectors with a suitably
normalized Jannsen--Wingberg basis is a separate arithmetic step. Section 7
states exactly the basis facts needed for the proposed simultaneous
minimum-layer argument. That section does not silently infer those facts
from the free-word computation.

Original source consulted:

- U. Jannsen and K. Wingberg, *Die Struktur der absoluten Galoisgruppe
  p-adischer Zahlkörper*, Invent. Math. **70** (1982), 71--98.
- Original PDF: <https://epub.uni-regensburg.de/26689/1/jannsen17.pdf>.
- Local file: `research/sources/galois_lift_2026_08_30/Jannsen_Wingberg_1982_Inventiones.pdf`.
- Length: 1,283,712 bytes.
- SHA-256: `54b303960baa182f4b7770b734e90da8d8ae48dde1708736af87bc100ea9f048`.
- PDF pages 1, 4, 5, 6, respectively printed pages 71, 74, 75, 76, were
  individually rendered and visually read. The relevant statements are
  the introductory conditions A/B/C, the construction in Section 1.2,
  Theorem 2, and Section 1.4(a).
- Review renders: `tmp/jw_cross_handle_review_2026_08_30/jw-page-01.png`,
  `jw-page-04.png`, `jw-page-05.png`, `jw-page-06.png`.

The source uses \([x,y]=xyx^{-1}y^{-1}\), explicitly stated on printed
page 74. All compositions below act from right to left.

## 2. The first free-group automorphism

Work first in the discrete free group on \(a,b,c,d\), and put

\[
 r_1=[a,b],\qquad r_2=[c,d],\qquad
 \Delta=r_1r_2,\qquad k=b^{-1}cdc^{-1}.
\]

Define

\[
 C(a)=ak,\quad C(b)=k^{-1}bk,\quad
 C(c)=k^{-1}c,\quad C(d)=d.
\]

First,

\[
 C(k)=(k^{-1}b^{-1}k)(k^{-1}c)d(c^{-1}k)
      =k^{-1}(b^{-1}cdc^{-1})k=k.
\]

The candidate inverse \(D\) sends

\[
 a\mapsto ak^{-1},\quad b\mapsto kbk^{-1},\quad
 c\mapsto kc,\quad d\mapsto d.
\]

Likewise \(D(k)=k\). Substitution on each generator now gives
\(CD=DC=1\), so \(C\) is an automorphism.

Its preservation of the boundary word is exact:

\[
\begin{aligned}
 C([a,b])&=aba^{-1}k^{-1}b^{-1}k,\\
 C([c,d])&=k^{-1}cdc^{-1}kd^{-1},\\
 C(\Delta)
 &=aba^{-1}k^{-1}b^{-1}cdc^{-1}kd^{-1}\\
 &=aba^{-1}kd^{-1}\\
 &=aba^{-1}b^{-1}cdc^{-1}d^{-1}=\Delta.
\end{aligned}
\]

Here the middle cancellation uses \(b^{-1}cdc^{-1}=k\).
This is stronger than preservation of the conjugacy class of \(\Delta\).

## 3. Conjugation and the final map

Define a handle exchange \(S\) and a second-handle rotation \(R\) by

\[
\begin{array}{c|cccc}
 &a&b&c&d\\ \hline
 S&c&d&r_2^{-1}ar_2&r_2^{-1}br_2\\
 R&a&b&d^{-1}&dcd^{-1}.
\end{array}
\]

The explicit inverses are

\[
 S^{-1}:(a,b,c,d)\mapsto
 (r_1cr_1^{-1},r_1dr_1^{-1},a,b),
\]

\[
 R^{-1}:(a,b,c,d)\mapsto(a,b,cdc^{-1},c^{-1}).
\]

These are verified directly on the four generators. Also

\[
 S(r_1)=r_2,\qquad S(r_2)=r_2^{-1}r_1r_2,
 \qquad [d^{-1},dcd^{-1}]=[c,d],
\]

so both \(S\) and \(R\) fix \(\Delta\). Put

\[
 P=R\circ S,\qquad A=P^{-1}\circ C\circ P.
\]

Since \(P(a)=d^{-1}\) and \(C(d)=d\), we have \(A(a)=a\).
All three constituent maps preserve \(\Delta\), and hence so does \(A\).

Finally let \(T_a\) send \(b\) to \(ba\), and let \(T_d\) send
\(c\) to \(cd^{-1}\), with all other generators fixed. The identities

\[
 [a,ba^{\pm1}]=[a,b],\qquad [cd^{\pm1},d]=[c,d]
\]

show that both twists and their inverses fix \(a\) and \(\Delta\).
Thus

\[
 F=A\circ T_a^{-1}\circ T_d^{-1},\qquad
 F^{-1}=T_d\circ T_a\circ P^{-1}\circ C^{-1}\circ P
\]

are inverse free-group automorphisms with

\[
 F(a)=a,\qquad F(\Delta)=\Delta.
\]

Only the final maps and the twists need to descend through the arithmetic
presentation. In particular, no claim is made that \(C\) or \(P\)
individually fixes the special arithmetic generator \(a\).

For an alternative short description, set \(r=bab^{-1}\) and
\(z=drd^{-1}\). Direct reduction gives

\[
 \boxed{F(a)=a,\quad F(b)=db,\quad
 F(c)=zr^{-1}cz^{-1},\quad F(d)=zdz^{-1}.}
\]

An equally explicit inverse is

\[
 F^{-1}(a)=a,\quad F^{-1}(b)=r^{-1}d^{-1}rb,\quad
 F^{-1}(c)=r^{-1}d^{-1}rdcr,\quad
 F^{-1}(d)=r^{-1}dr.
\]

In particular, \(F(d)\) is generally a conjugate of \(d\), not
literally \(d\). The literal fixed-generator claim is about \(a\).

## 4. Abelianization

Write the free abelianization additively. The actions of the intermediate
maps are

\[
\begin{array}{c|cccc}
 &a&b&c&d\\ \hline
 C&a-b+d&b&c+b-d&d\\
 P&-d&c&a&b\\
 A&a&b+a+d&c-a-d&d.
\end{array}
\]

Precomposition with \(T_a^{-1}\) subtracts \(a\) from the image
of \(b\), and precomposition with \(T_d^{-1}\) adds \(d\) to
the image of \(c\). Therefore

\[
 \boxed{a\mapsto a,\quad b\mapsto b+d,\quad
 c\mapsto c-a,\quad d\mapsto d.}
\]

These formulas also follow immediately from the compact words in Section 3.
They induce the corresponding action on every subsequent abelian quotient.
They do not on their own assert that the images of all these generators
form a specified integral logarithmic-unit basis.

Independent signed-word reduction checked both composites of each proposed
inverse, preservation of \(\Delta\), \(C(k)=k\), \(P(a)=d^{-1}\),
\(A(a)=a\), \(F(a)=a\), and the four abelianization columns. Every
check passed. The mathematical proofs above do not depend on that finite
computation.

## 5. Descent through the full Jannsen--Wingberg presentation

Let \(p\ne2\), and let \(E/\mathbf Q_p\) have even degree
\(n\geq4\). Write \(\mathcal G\) for the full tame Galois group.
The source constructs the relative group as follows (printed page 74):

\[
 V=\widehat F_{n+1}*\mathcal G,
 \qquad Z=\ker(V\longrightarrow\mathcal G),
 \qquad J=\ker(Z\longrightarrow Z^{(p)}),
 \qquad \mathcal F=V/J.
\]

Here \(\widehat F_{n+1}\) is the free profinite group on
\(x_0,\ldots,x_n\), and \(Z^{(p)}\) is the maximal pro-\(p\)
quotient of \(Z\). The source denotes \(J\) by \(I\); a different
letter is used here to avoid confusion with the logarithmic lattice.

Apply the free-word map \(F\) to
\((a,b,c,d)=(x_1,x_2,x_3,x_4)\), and fix \(x_0\), all
\(x_i\) with \(i\geq5\), and every element of \(\mathcal G\).
The same rule with the inverse words defines its continuous inverse on
the free profinite product \(V\). Continuity follows from its universal
property, and the two-sided finite-word identities still hold in \(V\).

The projection to \(\mathcal G\) is unchanged, so both maps preserve
\(Z\). The subgroup \(J\) is characteristic in \(Z\), since it is
the kernel of its canonical maximal pro-\(p\) quotient. Consequently
both maps preserve \(J\) and descend to inverse automorphisms of
\(\mathcal F\). This explicitly verifies the extra **wild normal
subgroup is pro-\(p\)** requirement; it is not replaced by taking the
maximal pro-\(p\) quotient of the whole absolute Galois group.

For even \(n\), the remaining relator in Section 1.2 has the form

\[
 \mathfrak r=
 x_0^{-\sigma}(x_0,\tau)_\beta^{\,\beta(\sigma)^{-1}}
 x_1^{p^s}[x_1,x_2][x_3,x_4]\cdots[x_{n-1},x_n].
\]

Every part is preserved:

1. The whole tame factor is fixed, so its relations, including
   \(\sigma\tau\sigma^{-1}=\tau^q\), remain valid.
2. The expression involving \(\sigma,\tau,x_0\), including its
   profinite powers and its fixed numerical parameters, is fixed.
3. The special power \(x_1^{p^s}\) is fixed because \(F(x_1)=x_1\).
4. The first two commutators are preserved **as their exact product**.
5. All later commutators are fixed term by term.

Thus \(F(\mathfrak r)=\mathfrak r\), and the same is true for its
inverse. They preserve the closed normal closure of \(\mathfrak r\)
and descend to inverse continuous automorphisms of
\(\mathcal F/\overline{\langle\!\langle\mathfrak r\rangle\!\rangle}\).
Theorem 2 (printed page 75), with the algebraic closure as the extension,
and Section 1.4(a) (printed page 76) identify this group with **\(G_E\)**.

There is no additional unspecified relation being ignored here: the
relative construction retains the entire tame factor, the maximal
pro-\(p\) condition on the wild normal subgroup, and the displayed
remaining relator. No odd-degree presentation is used.

The resulting automorphism is not inner. Indeed the assignment
\(x_4\mapsto1\in\mathbf Z_p\), with every other generator and the
tame factor sent to zero, satisfies the relative presentation and defines
a continuous character \(\varphi_4:G_E\to\mathbf Z_p\). But

\[
 \varphi_4(F(x_2))=1\ne0=\varphi_4(x_2).
\]

An inner automorphism acts trivially on every abelian character. This
argument does not require an unproved identification of the unit basis.

The same reasoning permits a twist \(x_2\mapsto x_2x_1\) and handle
exchanges or rotations wholly within \(x_3,\ldots,x_n\), as long as
their full product of commutators is fixed. Adjacent exchanges can be
implemented by the explicit \(S\) above, and rotations by \(R\).
Hence conjugation can replace the added vector \(x_4\) by either
signed generator from any of the remaining handles without losing the
full-group lift.

## 6. The proposed local field satisfies the presentation hypotheses

Let \(p=19\), let \(F_0=\mathbf Q_{19}(\mu_5)\), and choose
\(\pi^5=19\). Since \(19\equiv-1\pmod5\), the multiplicative
order of 19 modulo 5 is 2. The prime-to-19 roots of unity therefore give
the unramified quadratic field \(F_0\). The polynomial
\(X^5-19\) is Eisenstein over \(F_0\), so

\[
 E=F_0(\pi),\qquad [E:\mathbf Q_{19}]=10,
 \qquad e(E/\mathbf Q_{19})=5,
 \qquad f(E/\mathbf Q_{19})=2.
\]

It is the splitting field of \(X^5-19\), hence Galois. More explicitly,
the inertia generator sends \(\pi\) to \(\zeta_5\pi\); the
unramified involution extends by fixing \(\pi\) and acts on
\(\zeta_5\) by inversion. Thus its Galois group over
\(\mathbf Q_{19}\) is the dihedral group of order 10.

In particular, \(p\ne2\), \(n=10\) is even and at least four,
and the argument of Section 5 applies to its actual absolute Galois
group. Computing the auxiliary parameters \(s,g,h\) is unnecessary
for this preservation proof, because the entire expression in which
they occur is fixed.

## 7. Precise arithmetic bridge, kept distinct from the word theorem

The supplied minimum-layer argument uses the following additional facts
about the normalized logarithmic lattice
\(I_E=19^{-1}\log\mathcal O_E^\times=\pi^{-4}\mathcal O_E\):

\[
 I_E=\bigoplus_{i=1}^{10}\mathbf Z_{19}v_i,
 \qquad \ker(\operatorname{Tr}_{E/\mathbf Q_{19}}|_{I_E})
 =\mathbf Z_{19}v_1\oplus
 W,\qquad W=\bigoplus_{i=3}^{10}\mathbf Z_{19}v_i,
\]

with \(\operatorname{Tr}(v_2)\) a unit, and with the maps on these
\(v_i\) matching the abelianization formulas from the actual full
presentation (up to the stated Kummer contravariance and a scalar unit).
The freeness, the **integral** normalization, this kernel description,
and the covariance convention need their arithmetic proofs; they are
not consequences of preserving a surface word. They are being
independently checked by the arithmetic-geometry agent.

Given those facts, the remaining simultaneous-layer step is valid.
Set

\[
 u=\frac{\log20}{19},\qquad
 t=\frac{\log(1+19\pi)}{19^2}.
\]

Here \(u\in\pi I_E\), \(t\in I_E\setminus\pi I_E\),
\(\operatorname{Tr}(u)=10u\) is a unit, and

\[
 \operatorname{Tr}(t)=
 \frac{2\log(1+19^6)}{19^2},\qquad
 v_{19}(\operatorname{Tr}(t))=4.
\]

Indeed the five conjugates of \(\pi\) give
\(\prod_{j=0}^4(1+19\zeta_5^j\pi)=1+19^6\), and
\([F_0:\mathbf Q_{19}]=2\). The local logarithm converges in this
range and commutes with trace and norm. The valuations of \(u,t\)
are respectively 0 and \(-4/5\).

Write the \(v_2\)-coordinates of \(u,t\) as \(B_u,B_t\).
The displayed kernel and trace normalization give
\(B_u\in\mathbf Z_{19}^\times\) and \(B_t\in19\mathbf Z_{19}\).

- If \(v_1\notin\pi I_E\), use the lifted twist
  \(v_2\mapsto v_2+v_1\). It sends \(u\) to a vector congruent
  to \(B_uv_1\ne0\pmod{\pi I_E}\), while its change on \(t\)
  belongs to \(19I_E\subset\pi I_E\).
- If \(v_1\in\pi I_E\), the trace of \(\pi I_E\) is all
  \(\mathbf Z_{19}\): it contains 1, whose trace is 10. Hence
  \(\ker\operatorname{Tr}\to I_E/\pi I_E\) is onto. Some basis
  vector \(w\) of \(W\) therefore has nonzero image in this quotient.
  A conjugate of the proved cross-handle map has
  \(v_2\mapsto v_2+w\), and changes the \(W\)-coordinates only
  by multiples of \(v_1\). Modulo \(\pi I_E\), it sends \(u\)
  to \(B_uw\ne0\), and leaves \(t\) unchanged because
  \(B_t w\in19I_E\).

In either case the **same** lifted group automorphism gives two vectors
in \(I_E\setminus\pi I_E\). Using the inverse group automorphism
handles an inverse convention on Kummer transport; multiplication by
an overall \(\mathbf Z_{19}^\times\) scalar does not alter the
valuation. Thus no independent choice of automorphism for the two
vectors is hidden in this last linear argument.

This review establishes the full-group lift and checks that the supplied
integral-basis bridge, if established as stated, suffices for the claimed
common minimum layer. It does not certify that basis bridge merely by
reference to the Jannsen--Wingberg presentation. Nor does this example
by itself verify the hypotheses of an entire global IUT construction or
settle an abc estimate.

## 8. Lean verification added after the mathematical proof

After this review and its complete word proofs were on disk, the root
agent explicitly authorized one new standalone Lean module:

`Lean/IUTThreeClosures/IUTFullGaloisWordLift20260830.lean`.

It was written without changing an old module, an aggregate import, or
a frozen validation snapshot. The final source SHA-256 is

`3a6b5db0bb21ecc47223d92ebe3b5dd8b261a1e688fb915dd18057e2aaad93d7`.

The formalization includes:

- The displayed forward and inverse substitutions in an arbitrary
  `Group`, with both orders proved equal to the original four-tuple.
- Exact preservation of the distinguished coordinate and of the
  ordered commutator product; no commutativity assumption is used.
- Naturality under every group homomorphism, and the four specified
  coordinates under every homomorphism to a `CommGroup`.
- `crossHandleAut : FreeGroup Letter ≃* FreeGroup Letter`, built from
  two genuine group homomorphisms via `FreeGroup.lift`, with both
  composites proved equal to the identity on the entire free group.
- The actual free-group automorphism fixes the first generator and
  the boundary word, and has the asserted abelian image.

The four-tuple equivalence is explicitly not called a homomorphism for
coordinatewise multiplication. The separate free-group construction
supplies the group automorphism.

Validation, from the `Lean` directory:

```text
lake env lean IUTThreeClosures/IUTFullGaloisWordLift20260830.lean
```

Final run: exit code 0, no warnings or errors. A second run compiled the
identical source through `lean --stdin` and printed the following eleven
axiom dependencies. All names have prefix
`IUTThreeClosures.IUTFullGaloisWordLift20260830.`.

| Declaration | Axiom dependencies |
|---|---|
| `forward_backward` | `propext` |
| `backward_forward` | `propext` |
| `forward_boundary` | `propext` |
| `backward_boundary` | `propext` |
| `abelian_image` | `propext` |
| `backwardHom_comp_forwardHom` | `propext`, `Quot.sound` |
| `forwardHom_comp_backwardHom` | `propext`, `Quot.sound` |
| `crossHandleAut` | `propext`, `Quot.sound` |
| `crossHandleAut_fixes_first` | `propext`, `Quot.sound` |
| `crossHandleAut_fixes_boundary` | `propext`, `Quot.sound` |
| `crossHandleAut_abelian_image` | `propext`, `Quot.sound` |

For example, the corresponding audit commands are

```lean
#print axioms IUTThreeClosures.IUTFullGaloisWordLift20260830.forward_backward
#print axioms IUTThreeClosures.IUTFullGaloisWordLift20260830.forward_boundary
#print axioms IUTThreeClosures.IUTFullGaloisWordLift20260830.crossHandleAut
#print axioms IUTThreeClosures.IUTFullGaloisWordLift20260830.crossHandleAut_fixes_boundary
#print axioms IUTThreeClosures.IUTFullGaloisWordLift20260830.crossHandleAut_abelian_image
```

No `sorry`, `admit`, new axiom declaration, or unsafe proof mechanism is
used. The formalization ends at the discrete free-group theorem. The
full topological Jannsen--Wingberg descent in Section 5 and the arithmetic
unit-basis bridge in Section 7 have not been promoted to Lean conclusions.
