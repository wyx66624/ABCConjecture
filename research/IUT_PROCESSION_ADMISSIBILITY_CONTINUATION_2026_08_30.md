# What the Ind1 procession retains, and an exact removal of Ind2 from fixed holomorphic module hulls

**Author:** ChatGPT  
**Research date:** 2026-08-30  
**Status:** source reconstruction and proved local statements; no unconditional ABC result and no disproof of an IUT theorem.

This note continues the proved Ism classification and cyclotomic trace
constraint in `IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md`.
It resolves two more specific interfaces. The mono-analytic procession
used by Ind1 does not retain the curve fundamental groups needed for
strict Belyi reconstruction. On the other hand, on a fixed marked
finite etale carrier, the actual Ind2 action does not enlarge its
holomorphic B-module hull at all.

## 1. The original definitions, before any linear model

All page numbers below are PDF page numbers; in the cited IUT versions
they agree with the printed page numbers.

| Original location | Retained object or arrow |
|---|---|
| IUT I, May 2020, Section 0, pp. 33–34 | An isomorphism of categories is an equivalence up to natural isomorphism. A capsule-full poly-morphism has a fixed injection of indices and contains the collections of arbitrary constituent isomorphisms. |
| IUT I, Example 3.2(i), p. 70 | At a bad nonarchimedean place, D_v is a tempered-covering category of a curve, whereas D_v^perp = B(K_v)^0. The latter sits in the former by pullback from the base field. |
| IUT I, Example 3.3(i), pp. 77–78 | At a good nonarchimedean place, D_v is the finite-etale-covering category of the specified curve, whereas D_v^perp is again B(K_v)^0. |
| IUT I, Definition 4.1(iii),(iv), p. 96 | A mono-analytic prime-strip consists of categories equivalent to these B(K_v)^0 at the nonarchimedean places. Morphisms are collections of constituent morphisms indexed by the place set. The operation taking D to D^perp forgets the larger curve category. |
| IUT I, Definition 4.10, pp. 119–120 | A procession is a sequence of capsules. Its connecting arrow is the collection of all capsule-full poly-morphisms. A procession morphism specifies a monotone injection of the stages and a capsule-full poly-morphism at each stage. |
| IUT I, Proposition 6.9(ii), pp. 169–170 | The functor producing mono-analytic processions is the holomorphic-procession functor followed by the preceding forgetful operation. |
| IUT III, May 2020, Theorem 3.11(i), pp. 153–154 | The Ind1 object is precisely the output mono-analytic procession of IUT I 6.9(ii). Ind1 uses its automorphisms, not just images of automorphisms of the original bridge. Ind2 acts separately on the local direct summands of each of the j+1 tensor factors. |

Here `D^perp` is a plain-text stand-in for the source's D with the
mono-analytic turnstile superscript. It does not mean an orthogonal
complement. The local category B(K_v)^0 is the category of connected
finite etale covers of Spec(K_v).

The pages defining capsule-full maps, prime-strips and processions
(IUT I pp. 34, 96, 120) were checked in rendered page images as well
as by text extraction. IUT III p. 12 also describes the passage as
forgetting the arithmetic holomorphic structure. The assertions below
use the actual definitions, rather than relying only on this description.

## 2. The exact local range is a range of representatives

Let E be one of the local fields K_v in the fixed initial data, and put
C_E = B(E)^0. Choose a separable closure of E and write G_E for its
absolute Galois group.

### Proposition 2.1. Self-equivalences of the retained local category

The isomorphism classes of self-equivalences of C_E correspond to
continuous outer automorphisms of G_E. In particular, each continuous
automorphism alpha of G_E gives an allowed isomorphism of the retained
local category.

**Proof.** Identify C_E with the category of finite transitive continuous
G_E-sets. Pullback of the action along alpha is an equivalence of this
category, with inverse the pullback along alpha inverse. Inner
automorphisms give naturally isomorphic equivalences. Conversely,
adjoining finite disjoint unions recovers the finite G_E-set category;
its fibre functor reconstructs G_E up to inner automorphism. A category
equivalence therefore induces an outer automorphism. These two
constructions are inverse. This is the usual Galois-category
reconstruction, also used in the conventions on fundamental groups
in IUT I, Section 0, pp. 34–35. QED.

### Proposition 2.2. A procession does not reduce this local range to geometric arrows

Fix a nonarchimedean place v and a labelled occurrence of its category
in the mono-analytic procession of IUT III 3.11(i). The set of local
outer isomorphisms represented among the constituent maps of the
allowed capsule-full poly-automorphisms is all of Out(G_E).
Every such outer isomorphism can be represented while keeping all
place and capsule labels fixed. Repeated occurrences of the chosen
source can use the same outer automorphism.

**Proof.** At every labelled copy of C_E choose an equivalence with
the same standard category C_E. Given alpha, conjugate its pullback
equivalence from Proposition 2.1 by these choices. Use those conjugate
equivalences at the v-components, and the identity at other places.
Definition 4.1(iv) makes this a constituent prime-strip isomorphism.

At a capsule, keep the injection of indices equal to the identity.
By Section 0's definition, the capsule-full poly-isomorphism with that
index map contains every collection of constituent isomorphisms, hence
the chosen one. Make the same choice at every stage, and for each
repeated source label use the same transported alpha. The stage
injection is the identity; the stipulated capsule-full maps are exactly
the data required by Definition 4.10.

No retained arrow demands an extension to the curve covering category.
Moreover, conjugating a full collection of constituent isomorphisms
by the chosen self-equivalences leaves that full collection unchanged.
Thus even an explicit naturality check against the full connecting
poly-morphisms introduces no such extension requirement.

This constructs every requested local outer representative. The
reverse containment follows from Proposition 2.1: each local category
isomorphism is some outer Galois isomorphism. QED.

This proposition deliberately concerns **representatives inside
poly-morphisms**. A capsule-full poly-automorphism is already a set of
ordinary morphisms. It would be incorrect to claim that every chosen
representative is a different automorphism of the resulting coarse
one-category, or to assign one unique outer automorphism to an entire
full poly-morphism.

The conclusion also does not say that every element of GL(I_E) occurs.
The local linear image is still the image of the genuine Galois/Kummer
construction; Proposition 4.1 of the preceding note gives its trace
constraint.

## 3. Consequence for the proposed strict Belyi shortcut

The holomorphic category D_v before mono-analyticization carries a
curve fundamental group, and relevant strict Belyi theorems may constrain
automorphisms which actually lift to that category. The source of
Ind1 is the output D_v^perp, however. Neither the embedding
D_v^perp into D_v nor the global bridge is part of the automorphism
datum in Proposition 2.2.

For a fixed E, saying that all these representatives are geometric
would therefore require the separate assertion

    Out(G_E) = image(Aut(E) ---> Out(G_E)).              (3.1)

This is not a consequence of the procession construction. There are
local fields for which (3.1) is false; Hoshi's original
*Introduction to Mono-anabelian Geometry*, Theorem 2.2(ii), PDF
p. 14, states this non-surjectivity. Theorem 2.3, PDF pp. 14–15,
specifies the extra ramification-filtration or additive-completion
conditions which characterize the geometric subgroup. Those conditions
are not inserted into Definition 4.1(iii),(iv).

We do not assert from this existential local-field example that a
particular named Frey curve satisfies every global initial-data
condition with that field. The stronger point needed here is already
proved directly from the source: for whatever E occurs, the procession
adds no local geometric-lift requirement to its category isomorphisms.
Thus the proposed derivation of such a requirement from retained curve
data cannot be used. This withdraws that candidate shortcut, not the
IUT route.

Joshi IIhalf 7.4.1 and Mochizuki's procession have different definitions
and should not be identified wholesale. The present conclusion concerns
the latter's exact local representative set. The separate audit of
Joshi's cohomology collation still has to use the isomorphisms actually
supplied by its theorem, rather than arbitrary matrices.

## 4. A positive interface: actual Ind2 does not enlarge a fixed B-module hull

Fix a rational prime p, a finite nonempty set of tensor slots i, and
finite sets J_i of local direct summands. Write

    E_i = product_(v in J_i) E_(i,v),
    O_i = product_(v in J_i) O_(E_(i,v)),
    T   = tensor_(i,Q_p) E_i,
    A   = tensor_(i,Z_p) O_i.

Each E_(i,v) is a finite extension of Q_p. View A as its integral
tensor order in T, and let B be the product of the integer rings of
the field factors of the finite etale Q_p-algebra T. Then A is a
subring of B. All identifications in this section are fixed native
field markings; no change of absolute-value normalization occurs.

IUT III 3.11(i), p. 154, assigns independent Ism actions to the
direct summands in each of the j+1 factors used for its tensor
packet. Theorem 3.3 of the preceding note proves for the actual
all-open-subgroup definition of Ism that such an action, in a local
logarithmic model, is multiplication by a scalar in Z_p units.

### Proposition 4.1. Ind2 is multiplication by an integral tensor unit

Under the preceding fixed markings, every nonarchimedean Ind2
operator on T is multiplication by an element of A units, hence
by an element of B units.

**Proof.** In factor i, let lambda_(i,v) in Z_p units be the scalar
on the summand v. Set c_i = (lambda_(i,v))_v. This is a unit of O_i,
with inverse (lambda_(i,v)^(-1))_v. The corresponding map on E_i
is multiplication by c_i. Its tensor product over all slots is
multiplication by

    c = tensor_i c_i in A.

The tensor of the inverse c_i's is an inverse to c, by multiplication
of pure tensors. Thus c belongs to A units. The inclusion A into B
sends it and its inverse into B, proving the last assertion. QED.

The independent indices in the source are exactly those used in
this proof: a scalar for each direct summand of each tensor factor.
If an additional coherence convention forces some of these scalars
to coincide, the conclusion is unchanged. Products of scalar units
remain units, and the identity operator is still allowed.

### Theorem 4.2. Exact hull equality after Ind2

For any subset S of T, let Gamma_2 S be the union of its images
under the preceding Ind2 operators. Let Hull_B(S) denote its
B-module span, or instead its closed B-module span. Then

    Hull_B(Gamma_2 S) = Hull_B(S).                     (4.1)

The assertion holds for an arbitrary subset, not only for a singleton
or a pure tensor.

**Proof.** Every B-submodule containing S also contains c s for every
s in S and every c in B. Proposition 4.1 therefore gives
Gamma_2 S contained in span_B(S), and consequently
span_B(Gamma_2 S) contained in span_B(S). The identity Ind2 operator
gives S contained in Gamma_2 S and hence the reverse inclusion.
For the closed version, take closure of these equal spans, or repeat
the same argument with closed B-submodules. QED.

In particular, the earlier singleton lower bound t B is an equality
for the B-module hull of the pure Ind2 orbit of t. More generally,
(4.1) applies when S is already a specified collection of Ind1
images, with Ind2 then acting on the same fixed marked carrier.
There is no extra discriminant or lattice-index term caused by this
Ind2 step; those normalization terms arise from A versus B and
must still be handled separately as in the preceding continuation.

The theorem does not identify a B-module hull with a Z_p-convex
hull. It also does not assert that Ind1 preserves the B-module
structure, or that Ind3 is multiplication by a B-unit. In particular,
it does not prove the q-pilot/theta-pilot comparison of Corollary 3.12.

## 5. The remaining repeated-label problem, without a fictitious GL lift

For one fixed native field E, put I_E = log(U_E)/p. Define Gamma_E
to be the actual image on I_E of continuous outer automorphisms of
G_E together with integral compatible Tate-module isomorphisms.
By Proposition 2.2, passage to the mono-analytic procession itself
does not cut down the eligible outer representatives. By the preceding
note, every element F of Gamma_E obeys

    Tr(F x) = c_F Tr(x),     c_F in Z_p units.          (5.1)

The full Ism action only supplies scalar units. Consequently, it
cannot alter a minimum-layer question or enlarge a B-module hull
once the Ind1 image set has been specified.

In the tame setting p>2, 1<e<=p-2, write

    kappa = 1-1/e,       I_E = pi^(1-e) O_E,
    u = log(1+p)/p,
    tau = log(1+p a)/p,
    k = floor(v(a)+kappa).

The unresolved question needed by the earlier common-minimum
construction is the following simultaneous existence statement:

    Is there one F in Gamma_E for which
    F(u) not in pi I_E and F(tau/p^k) not in pi I_E?    (5.2)

The same F must be used at every occurrence of the repeated label.
The root agent has proved that the full integral trace stabilizer
satisfies (5.2); this is a statement about a larger explicitly defined
linear group, not a construction of an element of Gamma_E.
Conversely, distinct affine trace depths already exclude particular
specified maps tau_s to tau_t; they do not settle (5.2).

A presentation-based solution must produce an automorphism of the
full absolute Galois group with its cyclotomic action, and must check
the induced action on integral Kummer classes. An automorphism of
only a maximal pro-p Demushkin quotient is not yet such a solution:
its lift through the other finite quotients and the tame action would
remain to be proved. No complete lifting construction of that kind
has been obtained in this continuation.

## 6. Formalization scope and original files

The categorical representative result in Section 2 and the
source-to-unit identification in Proposition 4.1 are mathematical
proofs, not Lean declarations. The elementary span statement of
Theorem 4.2 has been checked for any module with a family
of scalar-unit operators that includes the identity. The definition
unitScalarOrbit and theorem span_unitScalarOrbit are appended to
`Lean/IUTThreeClosures/IUTAdmissibleGaloisUniformGate20260830.lean`,
after the mathematical proof was written here. Direct compilation
passed without warnings. The theorem's axiom audit reports only
propext and Quot.sound. This check does not formalize the Galois
reconstruction, the Ism theorem, the identification of actual Ind2
with tensor units, or a topological closure theorem.

Canonical originals used here:

* `research/sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf`,
  https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20I.pdf .
  Checked pp. 33–35, 70, 77–78, 95–96, 119–120, 169–170.
* `research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf`,
  https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf .
  Checked pp. 12–13 and 153–156.
* `research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_II_December2020.pdf`,
  https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20II.pdf .
  Checked Example 1.8(iii),(iv), pp. 37–39, as detailed in the preceding note.
* `research/sources/uniform_gate_2026_08_30/Hoshi_Introduction_Monoanabelian_PMB2021.pdf`,
  https://pmb.centre-mersenne.org/item/10.5802/pmb.42.pdf .
  Checked Theorems 2.2–2.3, PDF pp. 14–15, and Theorem 7.6,
  PDF pp. 36–37; journal year 2021, online publication 2022-03-04.

The parent agent maintains the shared source manifest. This note
does not alter any original PDF, aggregate Lean import, paper or
global verification record.
