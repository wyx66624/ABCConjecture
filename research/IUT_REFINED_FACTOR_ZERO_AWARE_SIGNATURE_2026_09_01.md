# Refined-factor zero-aware signatures for the IUT packet bridge

**Author:** ChatGPT
**Date:** 1 September 2026
**Status:** finite-stage algebraic bridge proved; source-level covariance
through all IUT indeterminacies remains open

## 1. Scope and source correction

This note continues the all-place prime-unit-label route in
`ABC_IUT_PRIME_UNIT_LABEL_VECTOR_BRIDGE_2026_09_01.md`.  It repairs two type
boundaries before any global comparison is attempted.

First, the published tensor packet is initially indexed by a tuple of
places, but the tensor algebra belonging to one tuple need not be a field.
IUT III, Proposition 3.1, printed pp. 92--93, uses an inductive system of
finite-dimensional objects.  After fixing one finite-dimensional stage, it
expands the tensor packet by place tuples and describes the resulting rings
as direct sums of fields.  At such a fixed stage, the correct element-level
component type is

\[
 \mathcal D=\coprod_c\operatorname{MaxSpec}(A_c),
 \qquad
 A_c=\bigotimes_{\alpha\in S_{j+1}}K_{c(\alpha)},          \tag{1.1}
\]

not merely the tuple type `c`.  Compatibility of these signatures through
the full inductive system is an additional open seam.  The repository
formalizes the generic fixed-stage decomposition, once the required
finite/etale packet instances are supplied, through
`TupleFiniteEtalePacket.RefinedComponent`, `Summand`, and
`allTupleCoordinates`.

Second, IUT III, Proposition 3.1(ii), includes zero in the integral packet
structure.  The previous field-scale coordinate was defined only for a
nonzero element.  A complete packet signature therefore needs a zero tag.

This correction does not prove IUT III, Corollary 3.12.  It identifies a
faithful finite-stage carrier on which a genuine source transport theorem
could act, and states exactly which multiplicative and valuation data that
transport must preserve.

## 2. One refined field factor

Let `K` be a field, choose `pi in K` with `pi != 0`, and let

\[
 e:K^\times\longrightarrow\mathbb Z                         \tag{2.1}
\]

be any exponent function.  For nonzero `x`, define

\[
 u(x)=x/\pi^{e(x)}.                                        \tag{2.2}
\]

Define the zero-aware coordinate

\[
 C_{\pi,e}(x)=
 \begin{cases}
  \mathtt{none},&x=0,\\
  \mathtt{some}(e(x),u(x)),&x\ne0.
 \end{cases}                                               \tag{2.3}
\]

The word ``unit'' denotes a genuine valuation unit only when `e` is the
normalized valuation and `pi` is a uniformizer.  The algebraic reconstruction
below needs only `pi != 0`.

### Theorem 2.1 (zero-aware reconstruction and injectivity)

For every `x in K`,

\[
 \operatorname{reconstruct}_\pi(C_{\pi,e}(x))=x,           \tag{2.4}
\]

where `none` reconstructs to zero and `(n,u)` reconstructs to `pi^n u`.
Consequently `C_(pi,e)` is injective.

#### Proof

If `x=0`, both sides of (2.4) are zero.  If `x!=0`, then the denominator
`pi^(e(x))` is nonzero and

\[
 \pi^{e(x)}\frac{x}{\pi^{e(x)}}=x.                         \tag{2.5}
\]

Applying the reconstruction map to an equality of coordinates proves
injectivity.  ∎

No analytic or IUT statement is used in this theorem.

## 3. Covariance under a genuine field equivalence

Let `phi : K ~= K'` be a field equivalence.  On zero-aware coordinates,
define

\[
 \operatorname{map}_\phi(\mathtt{none})=\mathtt{none},
 \qquad
 \operatorname{map}_\phi(\mathtt{some}(n,u))
   =\mathtt{some}(n,\phi(u)).                              \tag{3.1}
\]

Choose the target scale to be `pi'=phi(pi)`, and suppose the exponent maps
are covariant:

\[
 e'(\phi(x))=e(x)\qquad(x\ne0).                            \tag{3.2}
\]

### Theorem 3.1 (factorwise covariance)

Under (3.2),

\[
 C_{\phi(\pi),e'}(\phi(x))
 =\operatorname{map}_\phi(C_{\pi,e}(x))                   \tag{3.3}
\]

for every `x in K`.

#### Proof

The zero case follows because a field equivalence preserves and reflects
zero.  For `x!=0`, use (3.2) and preservation of integer powers and division:

\[
 \frac{\phi(x)}{\phi(\pi)^{e'(\phi x)}}
 =\frac{\phi(x)}{\phi(\pi)^{e(x)}}
 =\phi\left(\frac{x}{\pi^{e(x)}}\right).                  \tag{3.4}
\]

The exponent and complement coordinates therefore agree.  ∎

If the target uniformizer `pi'_0` is fixed independently, define

\[
 \eta=\phi(\pi)/\pi'_0.
\]

When `eta` has valuation zero, the correct complement formula includes the
unit twist

\[
 u'_0(\phi x)=\phi(u(x))\eta^{e(x)}.                       \tag{3.5}
\]

Raw unit equality without this twist is generally false.

## 4. The complete refined packet signature

Let `D` be an index type, let `K_d` be a field for every `d in D`, and choose
nonzero scales and exponent maps on every factor.  Define

\[
 \Sigma(x)_d=C_{\pi_d,e_d}(x_d),
 \qquad x\in\prod_{d\in D}K_d.                             \tag{4.1}
\]

### Theorem 4.1 (all-factor faithfulness)

The map

\[
 \Sigma:\prod_dK_d\longrightarrow
   \prod_d\operatorname{Option}(\mathbb Z\times K_d)      \tag{4.2}
\]

is injective.

#### Proof

An equality of dependent functions gives equality in every coordinate.
Theorem 2.1 then reconstructs `x_d=y_d` for every `d`; function extensionality
gives `x=y`.  ∎

Now let `P` be a tuple-indexed finite-etale packet over a field `k`.  Its
canonical semisimple equivalence is

\[
 \prod_c A_c\ \simeq_k\
 \prod_{d\in P.\operatorname{RefinedComponent}}P.\operatorname{Summand}(d).
                                                               \tag{4.3}
\]

### Corollary 4.2 (all-tuple refined signature)

Compose (4.3) with the signature (4.2) on all primitive summands.  The
resulting zero-aware prime-unit signature on `prod_c A_c` is injective.

#### Proof

The map (4.3) is an algebra equivalence and hence injective.  Theorem 4.1 is
injective on its target.  The composition of injective maps is injective.  ∎

### Theorem 4.3 (component-reindexed covariance)

Let `sigma : D ~= D'` reindex the refined components.  Suppose each `d`
carries a field equivalence

\[
 \phi_d:K_d\simeq K'_{\sigma(d)}                           \tag{4.4}
\]

which transports the chosen scale and satisfies exponent covariance.  If
`y_(sigma d)=phi_d(x_d)`, then

\[
 \Sigma'(y)_{\sigma(d)}
 =\operatorname{map}_{\phi_d}(\Sigma(x)_d)                 \tag{4.5}
\]

for every refined component `d`.

#### Proof

Apply Theorem 3.1 independently in each component.  ∎

For any subset `A` of a packet, (4.5) immediately gives equality of the
transported signature images.  If the genuine output region merely contains
the transported input region, one obtains the corresponding signature-image
containment.  This one-sided formulation is enough for a sound possible-
output encoding; it does not assume every syntactic output is realized.

## 5. What the source currently transports

IUT III, Theorem 3.11(ii)(a), printed pp. 155--156, supplies chosen-branch
poly-isomorphisms between the stated local mono-analytic tensor packets and
states compatibility with the respective log-volumes.  Therefore the
all-`(j,v_Q)` vector of source log-volumes is preserved componentwise on that
chosen branch.  Proposition 3.9(i), printed p. 116, supplies label-permutation
invariance, and the proof of Corollary 3.12, printed p. 181, uses normalized
volume invariance under Ind1 and Ind2.  Ind3 is different: Theorem 3.11(ii),
printed p. 156, describes nonarchimedean inclusions and archimedean
surjections.  Its honest signature semantics is therefore a relation,
saturation, or image containment rather than componentwise equality.

The fixed-label source core that is directly supported is smaller.  IUT I,
Corollary 6.10(iii), printed p. 171, identifies the zero-labelled first
`D`-prime strip across spokes; IUT III, Theorem 1.5(iv), printed p. 50,
supplies the corresponding bi-coric mono-analytic shell poly-isomorphisms.
Together with Theorem 3.11(ii)(a) and Proposition 3.9(ii), this preserves the
object/isomorphism class and volume family of that core across all rational
places.  It does not assert equality of every pilot element or of every unit
coordinate.

The missing source theorem is now precise:

> refine the actual packet arrows to a component reindexing together with
> semilinear or field-equivalence maps on the primitive factors, and prove
> scale/exponent covariance (or the twisted form (3.5)); encode Ind3 by its
> actual inclusion/surjection relation.

A module or poly-isomorphism together with volume compatibility does not, by
itself, imply that theorem.

## 6. Integral order versus maximal factor orders

Let `R` be a discrete valuation ring with fraction field `F`; let `K_i/F`
be finite separable fields, and put

\[
 A=\bigotimes_FK_i\simeq\prod_mL_m.                        \tag{6.1}
\]

Let

\[
 T=\bigotimes_R\mathcal O_{K_i},
 \qquad
 B=\prod_m\mathcal O_{L_m}.                               \tag{6.2}
\]

### Proposition 6.1 (finite-index integral-order seam)

Under the natural map into `A`,

\[
 T\subseteq B,
 \qquad B/T\text{ is finitely generated torsion, hence of finite length.}
                                                                  \tag{6.3}
\]

#### Proof

Every generator of `T` is integral over `R`, so the image of `T` is
contained in the integral closure `B`.  Both modules are finite over `R`.
After localization from `R` to `F`, both become the same finite-dimensional
`F`-algebra `A`.  Hence they have the same rank and `(B/T) tensor_R F=0`;
the quotient is torsion.  A finitely generated torsion module over a DVR has
finite length, proving the claim.  ∎

The Fitting/determinant ideal of `B/T` records the finite-index correction.
Identifying it with a different or conductor contribution requires a
separate theorem.  Replacing (6.3) by the equality `T=B` loses real arithmetic
information.

## 7. Full-premise counterexamples and their exact scope

### Proposition 7.1 (one tuple need not be one field)

For a separable quadratic field extension `E/F`,

\[
 E\otimes_FE\simeq E\times E.                              \tag{7.1}
\]

#### Proof

Write `E=F[T]/(f)` with `f` separable quadratic.  Over `E`, the polynomial
splits into two distinct linear factors, so the Chinese remainder theorem
gives (7.1).  The product contains the nontrivial idempotent `(1,0)` and is
not a field.  ∎

This refutes only the tuple-only one-field interface.  It agrees with IUT
III's direct-sum decomposition and does not refute IUT.

### Proposition 7.2 (tensor integers need not fill the maximal product)

Let `p` be odd, `F=Q_p`, and `E=F(alpha)` with `alpha^2=p`.  The image of

\[
 \mathcal O_E\otimes_{\mathbb Z_p}\mathcal O_E
 \longrightarrow\mathcal O_E\times\mathcal O_E           \tag{7.2}
\]

consists of pairs congruent modulo `alpha`; in particular `(1,0)` is not in
the image.

#### Proof

Use the two embeddings of the right tensor factor, sending `alpha` to
`alpha` and `-alpha`.  In the basis `{1,alpha}`, the comparison matrix has
determinant `-2alpha`.  Since `2` is a unit and `alpha` is not, the image has
positive index and is characterized by the stated congruence.  ∎

This refutes `T=B`, while retaining Proposition 6.1.

### Proposition 7.3 (volume-preserving module maps need not preserve valuation)

The map

\[
 T:\mathbb Q_p^2\to\mathbb Q_p^2,
 \qquad T(x,y)=(x+y,y),                                    \tag{7.3}
\]

has determinant one, preserves the lattice `Z_p^2` and Haar volume, but

\[
 T(1,-1+p)=(p,-1+p),                                      \tag{7.4}
\]

so the first-coordinate valuation changes from zero to one.

#### Proof

The matrix is unimodular upper triangular, proving the lattice and volume
claims.  Equation (7.4) is direct, and the two valuations follow because
`1` is a unit while `v_p(p)=1`.  ∎

Thus additive/module transport plus lattice and volume compatibility is not
enough for Theorem 4.3.  A refined multiplicative/valuation premise is
necessary.

### Proposition 7.4 (raw labels are not invariant under label permutation)

The packet `(1,2)` and its transposition `(2,1)` have the same transported
orbit signature but unequal raw labelled vectors.  This refutes raw
componentwise equality after an allowed permutation and retains the
equivariant/orbit formulation.

#### Proof

Transposition is an allowed permutation of the two labels, so `(1,2)` and
`(2,1)` determine the same orbit by the definition of the transported orbit
signature.  Their raw ordered vectors are unequal because equality would
force equality of the first coordinates, namely `1=2`.  Thus passage to the
orbit is necessary and sufficient for this example.  ∎

### Proposition 7.5 (determinant data are not faithful)

For a DVR uniformizer `pi`, let

\[
 L_0=Re_1\oplus Re_2,
 \qquad
 L_1=\pi Re_1\oplus\pi^{-1}Re_2.                           \tag{7.5}
\]

Then `L_0!=L_1`, while their determinant lines coincide.  Taking identical
lattices at every other place produces an all-place example with the same
determinant/log-volume signature but different packets.  This refutes
reconstruction of the full packet from determinant data; it does not refute
the scalar determinant comparison used after taking hulls.

#### Proof

The vector `pi^(-1)e_2` belongs to `L_1` but not to `L_0`, since a DVR
uniformizer is a nonunit and hence `pi^(-1)` is not in `R`; therefore
`L_0!=L_1`.  On the top exterior power, however,

\[
 (\pi e_1)\mathbin\wedge(\pi^{-1}e_2)=e_1\mathbin\wedge e_2.
\]

Thus both lattices generate the same determinant line.  Equal choices at all
remaining places preserve equality of every local determinant line and of
their summed log-volume signature, while the distinguished local lattices
remain different.  ∎

### Proposition 7.6 (component projections do not diagonalize an inclusion)

Let

\[
 V=\{(x,y)\in R^2:x-y\in\pi R\}\subsetneq R^2.             \tag{7.6}
\]

Both coordinate projections of `V` equal `R`, but `V` is not
`pi^aR times pi^bR` for any `a,b`.

#### Proof

Surjectivity of both projections is immediate from diagonal pairs.  If a
product description existed, the two full projections would force
`a=b=0`, giving `V=R^2`, contrary to `(1,0) notin V`.  ∎

This refutes deriving independent exponent enlargement from a bare Ind3
inclusion.  An actual diagonalization theorem would still be usable if the
source supplies one.

## 8. Formalization and remaining gate

The companion Lean module
`IUTRefinedFactorZeroAwareSignature20260901.lean` formalizes Theorems 2.1,
3.1, 4.1, 4.3 and Corollary 4.2.  For the generic
`TupleFiniteEtalePacket` interface, once the required finite/etale instances
are supplied, it composes the canonical semisimple equivalence with the
factorwise zero-aware reconstruction.  It does not construct an instance for
the complete actual IUT packet.  Every theorem's
axiom audit contains only standard Lean quotient/extensionality principles;
there is no `sorry`, external covariance axiom, or Corollary 3.12 premise.

The finite-index theorem of Section 6 and the source-specific all-place
volume/orbit statements remain separate formalization tasks.  More
substantively, the existing IUT and LANA sources do not yet provide the
refined-factor multiplicative/valuation covariance required by Theorem 4.3
through the horizontal link and Ind3.  The LANA repository at pinned commit
`ddaddc274281adb5674d647e24fa478745ac6d40` describes its Corollary 3.12
strand as a specification and does not construct the multiradial output
algorithm.  Therefore no unconditional same-pilot identification, IUT
Corollary 3.12 proof, or abc proof is claimed here.
