# A synchronized identity log-link and a local base branch of the theta-pilot possible-image set

**Author:** ChatGPT  
**Research date:** 2026-08-31  
**Status:** a mathematical construction in specified concrete source representatives; independent source audit pending. No unconditional ABC result, no disproof of an IUT theorem, and no use of the global assertion of IUT III Theorem 3.11 as an axiom.

This note isolates a smaller claim than the comparison in IUT III
Corollary 3.12. Fix a concrete Hodge theater from one of the previously
constructed global initial-data examples. Use distinct tagged copies of
that theater, a single copy-identity on its entire D-Hodge theater, and
the corresponding synchronized tautological log-link representative.
There is then a specific local fractional-ideal representative of one
global theta-pilot, sitting in the *preceding* log-field. Its image in
the vertically coric packet contains the images of the native pure
tensors considered below.

The subsequent local action is the actual, contravariant action on the
source's canonically reconstructed log module. It is induced by
transfer on abelianizations. It is not identified without qualification
with a cohomology action having an arbitrarily chosen Tate-module
isomorphism. Three different multiplicative structures, and hence
three different cyclotomes, must be distinguished even in this
copy-identity example.

The result concerns a specified base branch of the **raw union of
possible images** in Corollary 3.12. It does not prove the compatibility
of all branches, the cross-horizontal comparison, an equality with the
entire holomorphic hull, or the upper estimate in IUT IV. In particular,
the one-prime arithmetic bundle constructed in the earlier global
comparison note is not thereby identified with the complete global
theta-pilot.

## 1. Fixed data and the exact quantifiers

Take one of the globally constructed initial-data members in
[the power-free-family construction](FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md)
and
[the initial-data extension](IUT_INITIAL_DATA_POWERFREE_FAMILY_2026_08_31.md).
The initial-data conditions (a)--(f), global core, auxiliary cover,
epsilon, and place section have already been addressed there. They are
not left as new hypotheses to be solved in this note. We use only
members with the local configuration established in
[the general tame-label proof](IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md).

More explicitly, at its distinguished rational prime \(p\), write
\[
\ell\geq7,\qquad p\equiv-1\pmod {30\ell},\qquad
e=15\ell,\qquad d=30\ell,\qquad h=(\ell-1)/2.
\]
Let
\[
v_p(b_0)=2,\quad q=b_0^2,\quad
K_0=\mathbb Q_p(\mu_{30\ell}),\quad
\varpi^e=b_0,\quad E=K_0(\varpi).
\]
Here \(b_0\in\mathbb Q_p^\times\), \(K_0/\mathbb Q_p\) is unramified
quadratic, \(E/\mathbb Q_p\) is Galois, and the actual selected completion
of the global torsion field is \(E\). Put
\[
\gamma=p^2/b_0\in\mathbb Z_p^\times,\quad
\beta=\varpi^{(e+1)/2}/p,\quad
r_0=\varpi^{15}=\gamma^{15}\beta^{30},\quad
\kappa=1-1/e.
\tag{1.1}
\]
Thus \(\beta\) is a uniformizer, \(r_0^{2\ell}=q\), and
\[
I=p^{-1}\log\mathcal O_E^\times
  =\beta^{1-e}\mathcal O_E.
\tag{1.2}
\]
The inequality \(e\leq p-2\) ensures that logarithm and exponential
are inverse on \(\mathfrak m_E\) and \(1+\mathfrak m_E\).

For \(1\leq j\leq h\), let
\[
s_j=j^2,\quad m_j=j+1,\quad
a_j=r_0^{s_j},\quad x_j=\zeta_j a_j,\qquad
\zeta_j\in\mu_{2\ell}\subset K_0^\times.
\tag{1.3}
\]
Use the order of tensor slots prescribed by the procession, with \(j\)
the distinguished last slot, and put
\[
T_j=E^{\otimes_{\mathbb Q_p}m_j},\qquad
Z_j(x_j)=1^{\otimes j}\otimes x_j.
\tag{1.4}
\]
The repeated symbols \(E\) denote the concretely marked copies belonging
to those slots; they are not independently re-marked after an operator
has been chosen.

Let \(\mathscr H_{n,r}\) be distinct tagged copies of the same concrete
theater, for \(n,r\in\mathbb Z\). Retain the full vertical and horizontal
poly-arrows required by IUT III Definition 3.8(iii). Within the vertical
arrow from \(\mathscr H_{0,-1}\) to \(\mathscr H_{0,0}\), select the
representative produced by one global copy-identity
\[
\Xi:\mathscr H^{D}_{0,-1}\longrightarrow
       \mathscr H^{D}_{0,0}.
\tag{1.5}
\]
This does not replace a full poly-arrow by a singleton.

We will fix, before choosing any local Galois operator, maps
\[
\iota_j:T_j\xrightarrow{\sim}
 I^{\mathbb Q}(S^\pm_{j+1};{}^{0,\circ}D^\perp_p).
\tag{1.6}
\]
Here \(D^\perp\) is a typographical name for the mono-analytic
turnstile-superscript object in the source. It is not an orthogonal
complement. Because the field of moduli in this rational family is
\(\mathbb Q\), the selected place set above \(p\) is a singleton; there
is no suppressed extra direct summand in (1.6).

This uses the source's selected set \(V\), which maps bijectively
to the places of \(F_{\rm mod}\). It does not assert that the
torsion field has only one prime above \(p\). The other primes
of that field are not extra entries of this selected set.
For general initial data with several selected places above
\(p\), the packet would instead be
\(\bigotimes_{\rm slots}(\bigoplus_{v\mid p}E_v)\).
Then (1.4) is the projection to the all-\(v\) block, and the
corresponding claim must be membership in the projection of
the full possible-image set. Zero extension into that full
packet is not justified by the present argument.

The principal assertion has the form
\[
\forall(\zeta_1,\ldots,\zeta_h)\quad
\exists\text{ one allowed procession representative }\Phi
\quad\forall j:
\quad
\iota_j\!\left(F^{\otimes m_j} Z_j(x_j)\right)
 \in{}^{0,\circ}U^{\rm raw}_{j,p}.
\tag{1.7}
\]
The same \(F\) occurs in every slot and at every label; at every other
place the representative is the identity. In fact the membership
argument works for every canonical local core operator \(F\).
The existential choice in (1.7) can additionally realize the common
minimum-layer property proved earlier. The quantifier is not
\(\exists F\,\forall(\zeta_j)\).

## 2. Source locations which determine the construction

All page numbers here are PDF page numbers, agreeing with the printed
page numbers of these author versions.

| Source | Exact role here |
|---|---|
| IUT I, Corollary 5.3(ii), p. 144 | The map from isomorphisms of F-prime-strips to isomorphisms of their D-prime-strips is bijective. |
| IUT III, Definition 1.1(i), pp. 23--25; Remark 1.1.2(i), pp. 29--30 | Standard logarithm creates a new field structure on perfected old units. Its Frobenioid is naturally isomorphic to the old one. The tautological log-link covers the tautological identification of the local fundamental groups. The log-shell is the pre-log-shell divided by \(p^\ast\), with \(p^\ast=p\) at odd \(p\). |
| IUT III, Proposition 1.3(i), p. 42; Remark 1.3.1, p. 43 | One D-Hodge-theater isomorphism \(\Xi\) determines the entire synchronized collection of log-link representatives in the two bridges. |
| IUT II, Remark 2.5.1(i),(iii), pp. 72--73 | In a standard marked model the unperfected theta values are the \(\mu_{2\ell}\)-orbits of \(r_0^{j^2}\); the torsion ambiguities at different labels need not be synchronized. |
| IUT II, Corollary 3.6(ii),(iii), pp. 99--100; Corollary 4.6(iii),(iv), pp. 138--139 | Gaussian monoids are obtained from the theta value-profiles. Their splitting is the monoid generated by the value-profile, up to torsion. Constant monoids and conjugate choices are synchronized across labels. |
| IUT III, Proposition 3.1(ii), p. 93 | A distinguished factor enters a tensor packet by tensoring with the **new field units \(1\)** in all the other slots. |
| IUT III, Proposition 3.2(i),(ii), pp. 97--99 | The holomorphic log-carrier and the mono-analytic log-carrier are related by natural poly-isomorphisms; the integral structure is the tensor of the actual log-shells. |
| IUT III, Proposition 3.4(i),(ii), pp. 101--103 | Current Gaussian monoids are pulled back along the given isomorphism from the **preceding** log-field, inserted in the distinguished slot, and regarded both as subsets and as multiplicative operators on the packet. |
| IUT III, Proposition 3.5(i), pp. 103--104 | The core LGP construction uses the same recipe. The comparison explicitly involves the two indices \(r'=r,r-1\), not an identification of just one H1 object at level \(r\). |
| IUT III, Proposition 3.5(ii)(a)(1), pp. 104--105 | The basic Kummer image is one of the images considered before the additional positive log-iterates. This is the branch used here. |
| IUT III, Example 3.6(ii), pp. 107--108; Proposition 3.7(ii),(v), pp. 110--112; Definition 3.8(i), p. 112 | A pilot has a local fractional-ideal realization. Collections of bad-place splitting generators yield one global pilot object; their local generators need not come from one element of the global number field. |
| IUT III, Proposition 3.10(i), pp. 147--148 | The corresponding global fractional-ideal and rational-function-torsor recipes also explicitly use both adjacent indices \(r,r-1\). Only their specified concrete base representative is used here. |
| IUT III, Theorem 3.11(i),(ii), pp. 153--156 | These statements specify the output object, its allowed Ind1/Ind2 operations, and the Kummer branches used to define the possible-image union. We do not assume their global multiradial conclusions. |
| IUT III, Corollary 3.12, pp. 173--175 | The raw local set is the union of the possible pilot images. The holomorphic hull is taken subsequently. The q-pilot is expressly not subjected to Ind1/Ind2/Ind3. |
| Topics in Absolute Anabelian Geometry III, Definition 5.4(ii),(iii), pp. 125--126; Proposition 5.8(i),(ii), p. 139 | The global log construction re-embeds the same global object by its natural local isomorphisms. The canonical mono-analytic module is reconstructed from local-class-field-theoretic unit images. Its functoriality is **contravariant**, induced by transfer on abelianizations. |
| Topics in Absolute Anabelian Geometry III, Corollary 5.10(iv)(c),(d), p. 148, and its proof, p. 149 | The natural comparison of the Kummer reconstruction with the abelianization reconstruction is the local reciprocity comparison, obtained using the fundamental class and cyclotomic isomorphisms. It preserves the actual shells. |

The use of Theorem 3.11 in this table is to locate the objects and
operations appearing in the definition of \(U^{\rm raw}\). Below, the
one base branch is evaluated directly in fixed concrete copies.
No inequality, invariance under changing every vertical index, or
horizontal compatibility assertion from that theorem is used to
prove its membership.

## 3. The standard log-field, its shell, and three cyclotomes

### 3.1 The field is not rescaled when its shell is divided by p

Write \(E_{\rm old}\) for the predecessor local field and let
\(L_{\rm old}\) denote the field which Definition 1.1 constructs on
the perfection of its multiplicative unit group. In a concrete model
the standard logarithm gives a unital field isomorphism
\[
\mathcal L:L_{\rm old}\xrightarrow{\sim}E.
\tag{3.1}
\]
The addition and multiplication on \(L_{\rm old}\) are the ones
transported from \(E\) by \(\mathcal L\). They are not both the old
operations of \(E_{\rm old}\).

For \(x\in E\), choose \(N\) sufficiently large that \(\exp(p^N x)\)
converges. In the perfected old unit group, put
\[
y(x)=p^{-N}\,[\exp(p^N x)].
\tag{3.2}
\]
The bracket is written additively in the unit perfection. Formula (3.2)
is independent of sufficiently large \(N\), since
\(\exp(p^{N+1}x)=\exp(p^Nx)^p\). It satisfies
\(\mathcal L(y(x))=x\). In particular, if \(x\in I\), one may use
\(N=1\).

The pre-log-shell has standard-log coordinates
\(\log\mathcal O_E^\times\). The shell of Definition 1.1 has coordinates
\(p^{-1}\log\mathcal O_E^\times=I\). Its division by \(p\) does not
change the field multiplication, its unit \(1\), or the embedded
\(\mathbb Q_p\).

The ring unit of \(L_{\rm old}\) is \(y(1)\), whose coordinate is \(1\).
The old multiplicative unit \(1\in E_{\rm old}^\times\), on the other
hand, gives zero in the old unit perfection. These are different
objects. Thus the other slots in (1.4) do not represent the old
multiplicative identity before taking logarithms.

For comparison, changing the *entire field chart* by
\(C(x)=x/p\) would give ordinary coordinates \(u=x/p\) with
\[
u\star v=p\,uv,\qquad
1_{\rho}=1/p,\qquad
\mathbb Q_p\ni t\longmapsto t/p,\qquad
v_{\rho}(u)=v_E(pu).
\tag{3.3}
\]
In that chart the integral ring is \(\mathcal O_E/p\), and the canonical
shell has coordinates \(I/p\), not \(I\). A root equation must also
be transported: \(a^N=b\) becomes
\[
p^{N-1}a_\rho^N=b_\rho .
\tag{3.4}
\]
In a packet of \(m\) slots, both the pure tensor and its reference
integer module are transported by \(p^{-m}\). This is distinct from
replacing only a cohomological output \(\rho=p^{-1}\log_{\rm BK}\)
by \(\log_{\rm BK}\) while keeping a native field and reference module
fixed. The latter operation, applied to all \(m\) entries, multiplies
those entries' tensor by \(p^m\). Neither operation is made in (3.1).

### 3.2 The cohomology objects are not identified across the log wall

Let \(\mu_{\rm prev}\) be the Tate module from the multiplication
of \(E_{\rm old}\). Let \(\mu_{\log}\) be the Tate module from the
new multiplication of \(L_{\rm old}\). Let \(\mu_{\rm current}\)
be the Tate module of \(E_{\rm current}\). Even when concrete
fundamental-group representatives have been chosen, keep these
coefficient objects separately named.

The linear old-unit Kummer coordinate is
\[
\kappa^{\rm lin}_{\rm prev}(x)
 =p^{-N}\operatorname{Kum}_{\mu_{\rm prev}}
                   (\exp(p^N x))
 \in H^1_f(G_E,\mathbb Q_p(1)_{\rm prev}).
\tag{3.5}
\]
It is the inverse of the standard Bloch--Kato logarithm on this
unit subspace. It has valuation component zero. On \(I\) it has
values in \(p^{-1}H^1_f(G_E,\mathbb Z_p(1)_{\rm prev})\).

There is also the *new multiplicative* Kummer map
\[
L_{\rm old}^{\times,\log}\longrightarrow
 H^1(G_{L_{\rm old}},\mathbb Q_p(1)_{\log}).
\tag{3.6}
\]
For a unital field isomorphism
\(\lambda:L_{\rm old}\longrightarrow E_{\rm current}\), its ordinary
field-theoretic Kummer naturality says that
\[
\operatorname{Kum}_{\mu_{\log}}(y(x))
\longmapsto
\operatorname{Kum}_{\mu_{\rm current}}(\lambda(y(x))).
\tag{3.7}
\]
The groups and their pullback directions in (3.7) are those induced
by this field isomorphism. This is the only multiplicative Kummer
naturality asserted here. The map (3.6) is not linear with respect
to the old unit-H1 addition implicit in (3.5).

The necessary new multiplication is not invented for this argument:
Definition 1.1(i), p. 24, defines it, and Proposition 3.4(i), p. 102,
uses its monoid, units and multiplicative action to form the
Frobenioid of the preceding log-field.

For clarity, there is a strict obstruction to omitting this distinction.
If \(v_E(x)>0\), the raw class
\(\operatorname{Kum}_{\mu_{\rm current}}(x)\) has nonzero valuation
component, whereas (3.5) has zero valuation component. Any same-field
Galois-induced H1 isomorphism with integral compatible Tate
coefficients preserves the unit subspace: it is the annihilator
of unramified characters under local Tate duality. Such an
isomorphism therefore cannot directly send (3.5) to that raw class.
Formula (3.7) does not assert this impossible identification.

## 4. One global identity gives the required local field pullbacks

### Proposition 4.1. Synchronized standard-log representatives

The copy-identity \(\Xi\) in (1.5) determines allowed log-link
representatives whose finite local field map, in the standard-log
chart, is
\[
\lambda_v=\operatorname{copy}_v\circ\mathcal L_v:
 L_{0,-1,v}\longrightarrow E_{0,0,v}.
\tag{4.1}
\]
They can be used simultaneously at every label, every place and
every occurrence of a prime-strip in the two bridges.
At the distinguished place, the pullback of \(x_j\) has coordinate
\(x_j\), and the background field units have coordinate \(1\).

**Proof.** Definition 1.1 constructs the natural isomorphism from
the tautological log-Frobenioid to the original Frobenioid. Its
group action is the same one on all the monoids in that definition.
Remark 1.1.2 identifies the underlying local fundamental group by
the tautological identity. Thus composing this natural isomorphism
with the copy map covers the D-prime-strip isomorphism induced by
\(\Xi\).

Corollary 5.3(ii) of IUT I makes the lift of that D-prime-strip
isomorphism unique. Proposition 1.3(i) of IUT III defines all the
log-link representatives by these unique lifts of the *one*
isomorphism \(\Xi\). Therefore the maps (4.1) are the prescribed
representatives simultaneously, not independently selected local
isomorphisms whose global compatibility remains to be supplied.
The same argument applies to archimedean constituents with their
standard tautological log construction.

The original marked model identifies the labeled local fields with
the same completion. Its constant-monoid identifications and
conjugate choices are synchronized as in IUT II Corollary 4.6(iii).
The copy-identity does not permute the labels or change those choices.
Under (4.1) the standard-log coordinate is the identity field map,
so inverse images of \(x_j\) and of the unit have coordinates
\(x_j\) and \(1\), respectively. This proves the claim. \(\square\)

This proposition says nothing about every possible \(\Xi\).
Other theater isomorphisms can change label markings.
Even if a merely unital finite-field isomorphism is considered,
its fixing \(\mathbb Q_p\) only preserves the root coset defined by
\(X^{2\ell}=q^{j^2}\); it does not by itself establish synchronization.
Here synchronization was supplied first by (1.5).

### Local exponentials impose no false global-principality condition

The element \(\exp(px)\) in (3.2) need only belong to the selected
completion. It is a coordinate for a *local* log-field point.
It is not being declared an element of the global number field,
and it is not used as a global rational-function torsor generator.

The source's global field localization in Proposition 3.3 is defined
by pulling back its local images along the chosen log-field
isomorphisms. The same globally specified \(\Xi\) supplies those
isomorphisms here. Example 3.6(ii) and Proposition 3.7(v) separately
allow local fractional ideals to define the global pilot object.
Neither construction requires a global exponential of \(x\).
Indeed, Topics in Absolute Anabelian Geometry III Remark 5.4.1,
p. 129, explicitly warns that local logarithm diagrams do not
extend as logarithms on the global number field.
Its Definition 5.4(ii), pp. 125--126, separately constructs
the global log-Frobenius functor by composing the old global
embedding with the natural local isomorphisms. That procedure
keeps the underlying global Galois theater unchanged. It is
the relevant re-embedding operation, not a global exponential.

## 5. The adjacent-layer core diagram and its actual linear action

### 5.1 A canonical unit-perfection model of the core carrier

Use the local reciprocity convention of the canonical unit reconstruction,
\(\operatorname{rec}_E:E^\times\to G_E^{\rm ab}\).
Let \(C_E\) be the finite Galois-invariant part of the canonical
module \(k^\sim(G_E)\) of Topics in Absolute Anabelian Geometry III
Proposition 5.8(ii). Its concrete model is the rationalized
old unit group with all finite torsion removed. The standard
comparison is
\[
\sigma_E:E\xrightarrow{\sim}C_E,\qquad
\sigma_E(x)
 =p^{-N}\,[\operatorname{rec}_E(\exp(p^Nx))].
\tag{5.1}
\]
Here the bracket means its class in that unit-perfection module.
The proof of independence of \(N\) is exactly the proof after
(3.2). The usual log isomorphism on a sufficiently small unit
subgroup proves additivity, \(\mathbb Q_p\)-linearity and bijectivity.
The shell on the right is precisely \(\sigma_E(I)\), because the
source defines it by dividing the image of the units by \(p\).
There is no additional division by \(p\) in (5.1).

For comparison with (3.5), the unit Kummer isomorphism gives a
linear isomorphism
\[
\eta_E:H^1_f(G_E,\mathbb Q_p(1)_{\rm prev})
             \xrightarrow{\sim} C_E,\qquad
\eta_E(\operatorname{Kum}(u))=[\operatorname{rec}_E(u)].
\tag{5.2}
\]
This is well defined on the torsion-free rationalized unit group;
the Kummer identification follows from the usual Kummer sequence
and Hilbert 90. Consequently
\[
\sigma_E=\eta_E\circ\kappa^{\rm lin}_{\rm prev}.
\tag{5.3}
\]
Equation (5.3) is a comparison of specified concrete unit
constructions. It is not a declaration that arbitrary H1
coefficient choices are equivariant for the canonical core action.

The source of this comparison can be checked independently of
IUT III's main theorem. Topics in Absolute Anabelian Geometry III
Corollary 5.10(iv)(c),(d), p. 148, constructs the natural comparison
from the field-theoretic shell to the canonical mono-analytic
shell and states its compatibility with the shells and volumes.
The proof on p. 149 explicitly compares the base-field
reconstruction inside abelianizations with its Kummer
reconstruction. It uses the fundamental-class isomorphism
of Corollary 1.10(a) and the cyclotomic isomorphism of
Corollary 1.10(c), and describes the resulting comparison
as the local reciprocity map. On the concrete unit \(u\)
this is precisely (5.2). Thus (5.3) is the specified
source comparison, not an arbitrary vector-space identification.

### 5.2 The source branch uses the preceding carrier

Let \(k_{-1}^{\times}\) and \(k_0^{\times}\) denote the original-field
constant-monoid reconstruction maps in IUT II Corollary 4.6(iii),
for the two copied theaters. They have one common core target.
In the chosen concrete copy model they reconstruct the same
field with the same labeled constant monoids. Before forgetting
multiplication, the relevant diagram is
\[
\begin{array}{ccc}
 L_{0,-1}
   &\xrightarrow{\lambda}& E_{0,0}\\
 \downarrow\,\log(k_{-1}^{\times})
   &&\downarrow\,k_0^{\times}\\
 L_{\rm core}
   &\xrightarrow{\lambda_{\rm core}}& E_{\rm core}.
\end{array}
\tag{5.4}
\]
The lower field isomorphism is the corresponding tautological
standard-log representative. Both paths send \(y(x)\) to the
constant-field element with coordinate \(x\). The left arrow is
formed from the old-unit map before imposing the new log-field
multiplication; its value in the underlying core additive module
is (5.1). The right arrow concerns the current multiplicative
constant monoid, and is not the left arrow on the old H1 group.

**Verification of (5.4).** On sufficiently small old units the
constant-monoid comparison sends \(u\) to its actual reconstructed
constant. The logarithm of this constant is computed by the
standard convergent series. Its compatibility with this
copy-identity reconstruction follows term by term, since the
underlying marked field map is the identity. Division by \(p^N\)
extends the equality to the entire perfected unit carrier.
Thus on the left-hand path \(y(x)\) has log coordinate \(x\).
The upper map has that same coordinate by Proposition 4.1;
the right-hand constant reconstruction is the marked copy map.
This proves the equality on every \(x\in E\), and hence on the
entire finite carrier. It also proves the equality on the local
integer monoids and on every distinguished-slot tensor embedding.

Applying the recipe of Proposition 3.4 to this diagram gives
the core LGP recipe of Proposition 3.5(i). This last proposition
explicitly names both \(r'=r\) and \(r'=r-1\). Thus, for the
level \(r=0\) theta-pilot, the local inclusion in the core is
computed with the level \(-1\) log-carrier, as follows:
\[
\begin{array}{ccc}
 \Psi^\perp_{FLGP}(\mathscr H_{0,0})_p
   &\longrightarrow& T_j\text{ in the log-field of }\mathscr H_{0,-1}\\
 \downarrow\,k_{{\rm LGP},0}
   &&\downarrow\,\iota_j=\sigma_E^{\otimes m_j}\\
 \Psi^\perp_{LGP}(\mathscr H^{D}_{0,\circ})_p
   &\longrightarrow&
 I^{\mathbb Q}(S^\pm_{j+1};{}^{0,\circ}D^\perp_p).
\end{array}
\tag{5.5}
\]
The upper map is the distinguished-slot map of Proposition 3.4,
restricted to its label-\(j\) component. The bottom map is the
subset realization prescribed by that same recipe in the core.
The commutativity just checked for (5.4), followed by the tensor
operation, proves (5.5) on this specified base representative.

The maps \(\iota_j\) in (1.6) are these maps. They are determined
before any Ind1 action by the concrete model and its canonical
unit comparison. They have not been selected from the set of
all vector-space isomorphisms to force a desired point image.

The same diagram at all places, together with the copy-identity
of the global field, gives the base fractional-ideal comparison:
both constructions use the same local ideals and the same
global rational-function monoid acting upon them. Proposition
3.10(i), pp. 147--148, records exactly this recipe and again
specifies both adjacent indices. We only use this one concrete
copy representative; the non-interference and all-vertical
compatibility assertions later in that proposition are not
invoked.

This verification does **not** assert that a single Kummer map
commutes with all vertical log-links. No class at level \(0\)
is equated to its additive Kummer class at level \(-1\).
The full upper-semi-compatibility assertions of Proposition
3.5(ii) and Theorem 3.11(ii) are not needed for (5.5).

### Proposition 5.1. Canonical core action and its variance

For a continuous automorphism \(\alpha\) of \(G_E\), define
\(M_\alpha\) on \(E\) by its action on the torsion-free unit
abelianization:
\[
M_\alpha(\log u)
 =\log\!\left(\operatorname{rec}_E^{-1}
                   \alpha^{\rm ab}(\operatorname{rec}_E(u))\right),
\tag{5.6}
\]
first for units \(u\) and then by rational linear extension.
The canonical contravariant core map associated to \(\alpha\)
satisfies
\[
\Phi_\alpha\circ\sigma_E
   =\sigma_E\circ M_\alpha^{-1}.
\tag{5.7}
\]
It preserves \(\sigma_E(I)\).

**Proof.** Proposition 5.8(i) of Topics in Absolute Anabelian
Geometry III constructs the relevant unit images inside
abelianizations and specifies contravariant functoriality by
transfer. If the group map is an isomorphism, this transfer is
the inverse of the induced isomorphism on abelianizations; the
index is one. Applying this to (5.1) gives
\[
\Phi_\alpha(\sigma_E(x))
 =p^{-N}\,[\alpha^{-1,{\rm ab}}
       (\operatorname{rec}_E(\exp(p^N x)))]
 =\sigma_E(M_\alpha^{-1}x).
\]
The functor preserves the unit image and its rational
perfection. It therefore preserves the unit image divided by
\(p\), which is the actual shell. \(\square\)

A cohomology action with a compatible integral Tate-module
isomorphism \(\delta\) instead has the formula
\[
F_{\alpha,\delta}=c_{\alpha,\delta}M_\alpha^{-1},
\qquad c_{\alpha,\delta}\in\mathbb Z_p^\times,
\tag{5.8}
\]
as proved by the local Tate-pairing calculation in
[the full Galois lift report](IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md).
We do not set \(c_{\alpha,\delta}=1\) silently. The pointwise
formula below uses (5.7), and no freedom to rescale coefficients
is needed. To realize a previously constructed matrix \(M\),
use the inverse of its full Galois lift: if
\(M_{\alpha_0}=M\), then \(M_{\alpha_0^{-1}}^{-1}=M\).

## 6. One global pilot, local points, and its raw possible images

### Proposition 6.1. Points in one fixed pilot object

For the synchronized representative of Proposition 4.1, there
is one theta-pilot object \(\mathscr P\), in the local
fractional-ideal realization of Definition 3.8(i), whose
label-\(j\) component at the distinguished place contains
\[
Z_j(\zeta_j a_j)
\qquad\text{for every }\zeta_j\in\mu_{2\ell}.
\tag{6.1}
\]
All labels belong to that same global object.

**Proof.** Choose a standard normalized theta-evaluation
representative. By IUT II Remark 2.5.1(i), its label-\(j\)
value is a \(\mu_{2\ell}\)-multiple of \(a_j\). Corollary
3.6(ii),(iii) constructs the Gaussian splitting monoid from
the resulting value-profile; Corollary 4.6(iv) supplies it in
the chosen theater.

Proposition 3.4(ii) pulls this monoid back by (4.1). The
resulting scalar in the preceding log-field has standard
coordinate the same \(\mu_{2\ell}\)-multiple of \(a_j\).
Proposition 3.1(ii) then inserts it by tensoring with the new
field unit \(1\) in the other slots.

In the local fractional-ideal realization, the ideal generated
by this splitting generator contains the generator times the
unit. Changing its torsion factor does not change that local
ideal, because \(\mu_{2\ell}\) consists of units in this new
log-field. Hence (6.1) holds for every torsion choice.

Choose splitting generators at the other bad places of the
same global theater as prescribed in Proposition 3.7(v).
There are only finitely many such places; the good-place
constituents are the prescribed standard ones. Proposition
3.7(v) is precisely the construction from these local ideals
to a global object, and Definition 3.8(i) calls that object
a theta-pilot. Changing the elements selected within its
local ideals does not change the object. No global
principality of the local generators is required. \(\square\)

In particular, this argument does not assert that every
independent torsion tuple comes from a single strictly chosen
global theta-function evaluation. It uses the stronger
availability of local **ideal elements within the same
pilot object**, not that extra assertion about evaluation
representatives.

### Proposition 6.2. A p-only core representative is allowed

Fix a continuous automorphism \(\alpha\) of \(G_E\). In the
output mono-analytic procession used for Ind1, choose its
induced local category equivalence at every repeated
occurrence above \(p\), and choose the identity elsewhere.
Keep all place, stage and capsule indices fixed. This
collection occurs as a representative inside an allowed
procession poly-automorphism.

**Proof.** At a nonarchimedean place the retained object is
the category of finite transitive continuous \(G_E\)-sets.
Pullback along \(\alpha\) is an equivalence, with inverse
the pullback along \(\alpha^{-1}\). IUT I Definition
4.1(iii),(iv) makes the place-indexed collection a
prime-strip isomorphism. Section 0's capsule-full
poly-isomorphisms contain the chosen constituent
equivalences with the identity index map. Definition
4.10 makes these the data of a procession
poly-automorphism. Reusing the same transported
\(\alpha\) at every repeated occurrence is permitted;
conjugation leaves the full connecting collections
unchanged.

The retained category is the output of the
mono-analyticization in IUT I Proposition 6.9(ii),
not the earlier curve category. Therefore this
step does not require an extension of \(\alpha\)
to the original global curve or Hodge theater.
The exact representative statement and its source
definitions were proved in
[the procession audit](IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md).
\(\square\)

This action transports the associated data, including
its embedded number field and local ideal. It is not
required to stabilize their old native presentations.
In particular, it is not required to fix \(1\) as a
vector in the additive carrier.

### Theorem 6.3. Membership in the specified base branch

Let \(F=M_\alpha^{-1}\) and use the representative of
Proposition 6.2. With \(\iota_j\) fixed by (5.5), one has,
simultaneously for every \(1\leq j\leq h\) and every
chosen tuple \((\zeta_j)\),
\[
\iota_j\!\left(F^{\otimes m_j}Z_j(\zeta_j a_j)\right)
 \in{}^{0,\circ}U^{\rm raw}_{j,p}.
\tag{6.2}
\]
Here membership means the image of the fixed pilot
\(\mathscr P\) along its concrete adjacent-layer
Kummer branch (5.5), followed by this allowed
Ind1 representative. Ind2 is the identity.

**Proof.** Proposition 6.1 puts \(Z_j(\zeta_j a_j)\)
in the local fractional ideal of \(\mathscr P\).
The commutative construction (5.5), applied to
that local ideal as in Proposition 3.7(ii),(v),
therefore puts its image \(\iota_j Z_j(\zeta_j a_j)\)
in the core realization of the same pilot.

Under Proposition 6.2 the local additive packet map is
\(\Phi_\alpha^{\otimes m_j}\). Proposition 5.1 gives
\[
\Phi_\alpha^{\otimes m_j}\iota_j Z_j(\zeta_j a_j)
 =\iota_j F^{\otimes m_j}Z_j(\zeta_j a_j).
\]
The left side is thus an element of the image of that
actual local ideal. It is one of the possible images
whose union is defined on p. 174 of Corollary 3.12.
The Kummer branch is the basic one of Proposition
3.5(ii)(a)(1); we have not precomposed with a
positive log-iterate. Passing to the union of
branches does not remove this specified image.

There is no group called Ind3 for which an identity
element must be postulated. We have selected one
allowed base representative before including the
further images from the other vertical branches.
The proof uses the concrete construction of
Propositions 3.4--3.8 and the definition of the
union, not the global compatibility or
inequality asserted later. \(\square\)

### The operator formulation gives the same image only with a transported test vector

If the local ideal is presented as \(J=m_z(R)\),
where \(R\) is its specified local integer module
and \(1\in R\), a carrier isomorphism \(\Phi\)
gives
\[
\Phi J=(\Phi m_z\Phi^{-1})(\Phi R),\qquad
(\Phi m_z\Phi^{-1})(\Phi 1)=\Phi z.
\tag{6.3}
\]
These equalities follow by applying both sides to
each element of \(R\). They are valid for any
invertible additive map \(\Phi\), without
multiplicativity.

Equation (6.3) is exactly the interpretation of
the source's simultaneous subset and
multiplicative-action data in Theorem 3.11(i)(b).
Using \(\Phi m_z\Phi^{-1}\) on a *fixed* native
test vector \(1\), or a fixed native integer
module, would be a different operation. No such
replacement occurs in Theorem 6.3.

## 7. Consequence of the already proved full-Galois minimum-layer construction

Let
\[
k_j=\left\lfloor 2j^2/\ell+\kappa\right\rfloor
    =\left\lfloor2j^2/\ell\right\rfloor+1.
\]
The result of
[the torsion-point hull proof](IUT_NATIVE_THETA_TORSION_POINT_HULL_2026_08_31.md),
Sections 4--7, supplies, for each tuple \((\zeta_j)\), a matrix
\(M\) from a genuine full-Galois lift which sends \(1\) and all
\(\zeta_j a_j/p^{k_j}\) to the minimum layer
\(I\setminus\beta I\). Its construction uses tame inertia and
the explicit parabolic full-Galois lifts; it does not assume
arbitrary \({\rm GL}_{\mathbb Z_p}(I)\)-reachability.

By taking the inverse of that full-Galois lift in Proposition
5.1, this same \(M\) is an actual canonical core operator.
Consequently Theorem 6.3 proves (1.7) with the additional
valuation conditions
\[
v_E(F(1))=-\kappa,\qquad
v_E(F(\zeta_j a_j))=k_j-\kappa
\quad(1\leq j\leq h).
\tag{7.1}
\]
No Tate-coefficient scalar is needed to obtain (7.1).

Let \(B_j\) be the normalization of the tensor order
\(\mathcal O_E^{\otimes m_j}\) in \(T_j\). In the fixed
standard-log field chart it is a product of rings
\(\mathcal O_E\). The earlier hull proof now also
applies to the canonical-core subgroup:
\[
\overline{\operatorname{span}}_{B_j}
\left\{
F^{\otimes m_j}Z_j(\zeta_j a_j):
F\text{ canonical core operator}
\right\}
 =
P_j:=\beta^{e k_j-(e-1)m_j}B_j.
\tag{7.2}
\]
Indeed, every such \(F\) preserves \(I\), so the
content argument gives the upper inclusion.
The one simultaneous operator in (7.1) gives
in every field component a generator of the
ideal on the right, proving the lower inclusion.

Theorem 6.3 therefore gives the rigorously typed
inclusion, in this fixed local chart,
\[
P_j\subseteq
\overline{\operatorname{span}}_{B_j}
  \bigl(\iota_j^{-1}({}^{0,\circ}U^{\rm raw}_{j,p})\bigr).
\tag{7.3}
\]
Equation (7.3) is a local lower inclusion. It
does not identify the right side with \(P_j\);
other Ind1 representatives, other vertical
branches and further source operations may
enlarge the set. It also does not supply the
global upper estimate for that same full set.

## 8. A strict typed distinction surviving the earlier logarithmic approximation

This elementary lemma records why equality of
pointwise principal ideals is not equality of
cohomology points.

### Lemma 8.1. Pure and one-plus-log points have different trace behavior

For \(s=j^2\), \(\zeta\in\mu_{2\ell}\), set
\[
a=r_0^s,\quad k=\lfloor2s/\ell+\kappa\rfloor,\quad
t=p^{-1}\log(1+p\zeta a),\quad
\varepsilon=\zeta^\ell\in\{1,-1\}.
\]
Then
\[
\operatorname{Tr}_{E/\mathbb Q_p}(\zeta a/p^k)=0,
\tag{8.1}
\]
whereas
\[
\operatorname{Tr}_{E/\mathbb Q_p}(t/p^k)
 =\frac{30}{p^{k+1}}\log(1+\varepsilon p^\ell b_0^s)
 \ne0,
\tag{8.2}
\]
and the valuation of (8.2) is exactly
\[
\ell-1+2s-k\geq\ell.
\tag{8.3}
\]

**Proof.** The order of the tame character on \(r_0^s\)
is \(\ell\): \(1\leq j<\ell\) implies \(\ell\nmid j^2\).
The \(\ell\) conjugates have zero sum, each occurs
fifteen times in the degree-\(e\) extension over
\(K_0\), and \(\zeta\) is fixed by that inertia.
This proves (8.1).

Multiplying those conjugates instead gives
\[
N_{E/K_0}(1+p\zeta r_0^s)
  =(1+\zeta^\ell p^\ell b_0^s)^{15}.
\]
Here \(\ell\) is odd, so the displayed sign is
positive. The right side belongs to \(\mathbb Q_p\);
the norm from the unramified quadratic \(K_0\)
squares it. Taking logarithms on principal
units and dividing by \(p^{k+1}\) proves (8.2).

Since \(p\nmid30\) and the logarithm's first
term has valuation \(\ell+2s>0\), the valuation
is \(\ell+2s-k-1\), and the logarithm is nonzero.
Finally \(k=\lfloor2s/\ell\rfloor+1\leq s\)
for every integer \(s\geq1\), because \(\ell\geq7\).
Thus \(\ell-1+2s-k\geq\ell\). \(\square\)

Every allowed integral-coefficient Galois/Kummer
map preserves the trace-zero kernel, and the
canonical source maps are among these up to
unit normalization. Hence the two displayed
points cannot literally be in the same such
orbit. This does not contradict the previous
per-operator equality of principal tensor
ideals, proved from the higher-filtration
logarithmic error. In particular, (6.2) was
proved for the pure local ideal points via
the actual log-field pullback, not by
substituting the point \(t\) for them.

## 9. What stays fixed, and the remaining comparison gate

The construction keeps the following choices
separate.

| Datum | Choice and resulting limitation |
|---|---|
| Initial data, \(\ell\), places, curve, \(q\) | Fixed from one already constructed member. No new prime selected by an existence theorem is equated with this \(\ell\). |
| Vertical log-link | One global copy-identity representative, synchronized at all labels and places; full poly-arrows are retained around it. |
| Local field multiplication | The standard-log multiplication; unit \(1\), native \(q\), and shell \(p^{-1}\log\mathcal O_E^\times\). |
| Core carrier comparison | The preceding-level unit-perfection map (5.1), and its tensor powers (5.5). |
| Local Ind1 action | Transfer on abelianizations, giving \(M_\alpha^{-1}\); same \(\alpha\) at every repeated slot, identities elsewhere. |
| Pilot realization | One global pilot and its actual local fractional ideals. Elements chosen inside those ideals need not be global principal elements. |
| Multiplicative operator | Transport operator and test module together as in (6.3). |
| Ind3 | One base Kummer branch is used. Neither a group structure nor compatibility of all branches is assumed. |
| q-pilot | The original value-group pilot from Definition 3.8 is retained; it is not subjected to the chosen Ind1 map. |

Before Ind1, the copy-identity preserves the current root equation
and its marked value-group generator. After Ind1, one must not
conclude that \(F\) fixes the native scalar \(q\), the native
embedding of the global field, or the native ring unit.
Indeed, a common-minimum operator sends \(1\) outside
\(\beta I\), and hence need not fix \(\mathbb Q_p\) as a
subfield of the fixed native carrier. The source's
transported multiplicative data keep their abstract
value-group generator by transport; their *native*
coordinate valuations are a different datum.

Corollary 3.12 explicitly leaves the q-pilot outside
Ind1/Ind2/Ind3. Keeping that object fixed in the present
notation is not a proof of the source's full
horizontal compatibility theorem. In particular,
Theorem 6.3 is an assertion about a same-column
raw possible-image set. It is not a map sending
that set through a horizontal theta-link while
preserving all the coordinates used in (7.2).

The smallest comparison gate which remains is to
relate the *complete globally synchronized pilot
family*, including its other places and all
required vertical branches, to the precise
holomorphic reference and global weighting in
the subsequent upper bound. The present local
inclusion does not identify the one-prime
bundle of the global comparison note with that
global family. It also does not justify the
restriction to prime-strip-interpretable
regions made later in the proof on p. 175.
There is no counterexample to IUT or ABC here,
and no reason to abandon the IUT route.

## 10. Original files and verification scope

The IUT sources reused in this note are the following
unchanged author PDFs.

* [IUT I, May 2020](sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf),
  [original URL](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20I.pdf),
  SHA256 7360e3ed27c235b5497a0743d3ed1646fbb97688547d16b7c784fc7f127f1f03.
* [IUT II, December 2020](sources/uniform_gate_2026_08_30/Mochizuki_IUT_II_December2020.pdf),
  [original URL](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20II.pdf),
  SHA256 180bfa6aaddc4ae37af37acaad51f61e0a47b33b8255ad3169e28a970ae39b7c.
* [IUT III, May 2020](sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf),
  [original URL](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf),
  SHA256 9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9.
* Topics in Absolute Anabelian Geometry III, November 2015,
  [archived author PDF](sources/iut_membership_2026_08_31/Mochizuki_AbsTopIII_November2015_author.pdf),
  [original URL](https://www.kurims.kyoto-u.ac.jp/~motizuki/Topics%20in%20Absolute%20Anabelian%20Geometry%20III.pdf),
  1132226 bytes, 164 pages,
  SHA256 e8115df30a86dea26e2ebf60cb333558ff28fe3e4d57017a80421787b53421a9.
  The reviewing agent obtained this author PDF in the present
  continuation and the parent archived it without changing
  its contents. The temporary review copy is only a cache.

This note adds no Lean declarations. The local-class-field
reconstruction, adjacent-layer source diagrams and actual
membership assertion above have not been formally verified
in Lean. The existing finite-group word identities and
linear-algebra results do not constitute such a formalization.
The previously frozen reports, TeX files, PDF, Lean sources
and acceptance records were not modified.
