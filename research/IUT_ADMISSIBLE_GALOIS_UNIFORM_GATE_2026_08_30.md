# Admissible local arrows, the full Ism condition, and a cyclotomic trace obstruction

**Author:** ChatGPT  
**Research date:** 2026-08-30  
**Status:** mathematical proofs of local statements; no unconditional proof or disproof of ABC, and no disproof of an IUT theorem.

This continuation does not assume that every automorphism of a finite
logarithmic lattice comes from a permitted source arrow. Its two main
results concern the actual arrow definitions:

1. The group Ism(G) in Mochizuki II, Example 1.8(iv), is scalar on the
   torsion-free logarithmic module. The hypothesis involving every open
   subgroup of G, rather than only the base field's lattice, is decisive.
2. Integral Galois/Kummer transport preserves the p-adic valuation of the
   absolute trace of a logarithmic coefficient. For a specified local
   Tate-root family this invariant distinguishes the input with exponent
   1 from the inputs with exponents j squared.

The second statement also applies after the Ism indeterminacy classified
in the first statement. It does not by itself distinguish holomorphic
hulls: multiplication by the maximal order and the upper-semicompatible
operations of Ind3 are additional operations.

## 1. Exact source objects and arrows

All page numbers in this note are PDF page numbers unless explicitly
called printed page numbers.

| Source and location | Data or permitted arrow used here |
|---|---|
| Joshi I, arXiv:2106.11452v4, pp. 45–46, Theorem 8.4.1 and Corollary 8.5.1 | Cohomology isomorphisms induced by anabelomorphisms, including the induced cyclotome isomorphism; collation over the resulting isomorphisms. |
| Joshi IIhalf, arXiv:2305.10398v12, pp. 46–49, 7.2.2, 7.4.1, 7.5.1 | Local Kummer cohomology and its integral unit submodule; the adelic comparison is reduced to local absolute Galois groups. |
| Joshi III, arXiv:2401.13508v4, pp. 110–112, 9.7.2.2 and 9.7.5.1 | The normalized local coefficient log(1+p a)/p, and the isomorphisms supplied by IIhalf 7.4.1. |
| Mochizuki II, December 2020, pp. 37–39, Example 1.8(iii),(iv) | O× is the actual multiplicative unit object, Oμ its torsion subgroup, and O×μ=O×/Oμ. Ism(G) preserves a specified unit-image lattice for every open H in G. |
| Mochizuki III, May 2020, p. 32, Proposition 1.2(vi); p. 154, Theorem 3.11(i) | Ind1 comes from procession automorphisms; Ind2 uses independent copies of the entire Ism(G) on the indicated local summands. |
| Mochizuki III, p. 156, Theorem 3.11(ii) | Ind3 concerns upper semicompatibility along log-links. It is not a group of automorphisms of one fixed integral Kummer module. |

The following three distinctions are essential.

First, a field isomorphism gives an absolute Galois isomorphism, but the
converse is false. Second, an absolute Galois isomorphism gives a
cohomology isomorphism, but this does not prove that every integral
linear automorphism is so induced. Third, an automorphism of the
torsion-free quotient O×μ need not initially be treated as an
automorphism of O×. Section 3 below proves the required statement for
the quotient directly; it does not silently assume a lift.

Hoshi's Introduction to Mono-anabelian Geometry, Theorem 7.6, PDF
pp. 36–37, printed pp. 39–40, concerns the full unit object:
isomorphisms of pairs G acting on O× project onto isomorphisms of G,
with fibres that are torsors under the power action of the units of
the profinite integers. This theorem supplies genuine Galois-induced
lifts. It is not, on its own, a classification of the quotient group
Ism(G).

For the latter group, the exact condition on p. 39 of Mochizuki II is
preservation, for every open H in G, of the lattice given by the image
of the H-invariants of O× in the H-invariants of O×μ. The source says
lattice, not its rational span. A page image was checked at
tmp/iut_admissible_2026_08_30/Mochizuki_IUT_II_p39.png.

## 2. A fixed local model, including the torsion quotient

Let E be a finite extension of Q_p, let Ebar be an algebraic closure,
and put G=Gal(Ebar/E). For every finite extension K/E in Ebar write

    U_K = O_K×,
    L_K = log(U_K) contained in K,
    I_K = p^(-1) L_K.

The branch of the logarithm on nonunits is irrelevant here. Its
restriction to U_K has kernel the finite group of roots of unity in K.
Consequently L_K is a free Z_p-module of rank [K:Q_p], open and compact
in the additive group of K. The same statements hold at p=2. The
choice p^(-1) is convenient for the odd-prime convention in Joshi III;
uniformly replacing it by the source's other fixed normalization does
not change any scalar classification.

For completeness, the logarithm induces a G-equivariant isomorphism

    O_Ebar× / mu(Ebar)  --->  (Ebar,+).                 (2.1)

Its injectivity follows from the kernel statement in each finite K.
For surjectivity, given x in Ebar choose a finite K containing x and an
integer n large enough that exp(p^n x) converges in K. Choose a p^n-th
root y of exp(p^n x) in Ebar. This root is a unit, and
p^n log(y)=p^n x, so log(y)=x.

If H=Gal(Ebar/K), the H-invariants on the right of (2.1) are K, whereas
the image of (O_Ebar×)^H is exactly L_K. The distinction between the
invariants of the quotient and the image of the invariants is important:
the former is K and the latter is a lattice in K.

Under this fixed-model identification, an element F of Ism(G) is an
additive G-equivariant automorphism of Ebar satisfying

    F(L_K)=L_K for every finite K/E in Ebar.           (2.2)

It restricts to a Q_p-linear map F_K on each K. One can either use the
ind-topological condition in the definition, or deduce this as follows.
Preservation of L_K gives preservation of all p^n L_K, so an additive
restriction is continuous in the p-adic topology. It commutes with
integer scalars, then with Z_p scalars by continuity, and with Q_p
scalars by inverting p. The inverse satisfies the same properties.

## 3. Norm subgroups classify the actual Ism group

### Proposition 3.1. Every open logarithmic sublattice is a trace of a unit lattice

Let J be a finite-index Z_p-submodule of L_E. There exists a finite
abelian extension K/E such that

    Tr_(K/E)(L_K)=J.                                  (3.1)

**Proof.** The subgroup

    V = {u in U_E : log(u) belongs to J}

is open and of finite index in U_E. It contains all torsion of U_E.
Choose a uniformizer pi of E and form the subgroup

    N = pi^Z V  contained in E×.

The decomposition E×=pi^Z U_E shows that N is open and of finite
index. By the local existence theorem of class field theory there is
a finite abelian extension K/E with

    Norm_(K/E)(K×)=N.

Moreover,

    Norm_(K/E)(U_K) = N intersect U_E = V.             (3.2)

Indeed, if Norm(x) is a unit, the equality of integer-normalized
valuations v_E(Norm(x))=f_(K/E) v_K(x) forces x to be a unit; the
reverse inclusion follows by the same formula. This argument does not
need an extra unramifiedness or total-ramification assumption.

Logarithm commutes with the norm:

    log Norm_(K/E)(u) = Tr_(K/E)(log u).

This follows by writing the norm as the product of conjugates and
using that log is a Galois-equivariant homomorphism on units. Thus
(3.2) gives Tr(L_K)=log(V)=J. This proves (3.1). QED.

The class field theory input is the ordinary local existence theorem,
not an IUT claim. See Milne, Class Field Theory, v4.03, Chapter I,
Theorem 1.4 and Lemma 1.3, PDF p. 31, printed p. 22.

### Lemma 3.2. An automorphism preserving every finite-index sublattice is scalar

Let L be a nonzero finite free Z_p-module, and let A be a Z_p-linear
automorphism of L. Suppose A(J)=J for every finite-index submodule J
of L. Then

    A=lambda id_L for a unique lambda in Z_p×.         (3.3)

**Proof.** Choose a basis e_1,...,e_d. For each i and n>=1 the lattice

    Z_p e_i + p^n L

has finite index. Therefore A(e_i) belongs to its intersection over n.
Inspection of the other basis coordinates, using
intersection_n p^n Z_p={0}, shows that this intersection is Z_p e_i.
Write A(e_i)=lambda_i e_i. Since A is invertible, every lambda_i is a
unit. For i distinct from j, applying the same argument to

    Z_p(e_i+e_j)+p^n L

shows that lambda_i e_i+lambda_j e_j belongs to Z_p(e_i+e_j), whence
lambda_i=lambda_j. The rank-one case needs no second step.
Uniqueness follows by evaluating at e_1. QED.

### Theorem 3.3. Classification of Ism(G) in Example 1.8(iv)

With the precise Ism definition of Section 1, the map

    Z_p× ---> Ism(G),  lambda |-> (x |-> lambda x)

under (2.1) is an isomorphism. In particular

    Ism(G) = image(Zhat× ---> Ism(G)) = Z_p×.          (3.4)

**Proof.** Let F belong to Ism(G). For a finite abelian K/E, equivariance
implies

    F_E Tr_(K/E)(x) = Tr_(K/E)(F_K(x)).

Here the trace is the sum of the action of Gal(K/E); commutation with
this action follows from G-equivariance on Ebar. Combining (2.2) with
Proposition 3.1 shows that F_E preserves every finite-index submodule
J of L_E. Lemma 3.2 therefore gives F_E=lambda_E id_E with
lambda_E in Z_p×.

Apply the same argument with E replaced by any finite K/E. The map
F commutes with Gal(Ebar/K) and preserves L_M for every finite M/K,
because all the corresponding subgroups are open in G. Hence
F_K=lambda_K id_K. Since the restrictions of these maps to E agree
and E is nonzero, lambda_K=lambda_E. Every element of Ebar lies in a
finite K, so F=lambda_E id on Ebar.

Conversely, multiplication by any lambda in Z_p× commutes with G,
is continuous on each finite extension, and preserves every L_K,
because L_K is a Z_p-lattice. It therefore defines an element of
Ism(G). Its multiplicative interpretation in O×μ is the p-adic unit
power action. Any lambda in Z_p× is the p-component of a unit of
Zhat; the other components act trivially after the full torsion
quotient. This proves (3.4). QED.

Only finite abelian extensions were needed in the proof, but the
quantifier over all open subgroups in the source includes them. If
one retains only the base lattice L_E, the conclusion is false:
its automorphism group is GL_[E:Qp](Z_p). This is exactly why a
base-lattice calculation alone cannot establish source admissibility.

Theorem 3.3 also explains how the full-unit result of Hoshi is related
to this quotient problem. It proves, rather than assumes, that every
element of the actual quotient Ism group is induced by a unit power
automorphism of the full unit object.

### Corollary 3.4. Ism cannot produce the common minimum-layer displacement

Suppose p>2, 1<e<=p-2, and E/Q_p has ramification index e. Then

    I_E = p^(-1) log(U_E) = pi^(1-e) O_E

for a choice of uniformizer, with minimum nonzero valuation
-(1-1/e), using v(p)=1. Let u=log(1+p)/p. Its valuation is zero.
Every Ism image of u still has valuation zero, so no Ism element
sends u to the minimum layer of I_E.

**Proof.** The usual log and exp are inverse on the maximal ideal
when 1/e>1/(p-1), giving the displayed lattice identity.
The logarithm series gives v(u)=0. Theorem 3.3 says that an Ism
image is lambda u with lambda in Z_p×. Its valuation is therefore
also zero. Since e>1, the minimum layer has negative valuation. QED.

For example, E=Q_7(pi), pi^3=7, has minimum layer -2/3, which no
Ism image of log(8)/7 reaches. This is a source-level nonreachability
statement for Ism. It is not a proof that no Ind1 Galois
automorphism reaches that layer.

## 4. A cyclotomic trace constraint for Galois-induced arrows

Let E and E' be finite extensions of Q_p. A coefficient-compatible
Galois arrow means a continuous isomorphism

    alpha: G_E' ---> G_E

together with an isomorphism of integral Tate modules

    beta: alpha^* Z_p(1)_E ---> Z_p(1)_E'.

Let F^i denote the induced maps on continuous cohomology. The
construction preserves integral coefficients; beta is an isomorphism,
not multiplication by p.

### Proposition 4.1. Trace is transported up to a p-adic unit

There is c in Z_p× such that the induced map on logarithmic
coefficients, denoted F_log:E--->E', satisfies

    Tr_(E'/Qp)(F_log(x)) = c Tr_(E/Qp)(x)
    for all x in E.                                  (4.1)

This applies both to ordinary logarithmic coordinates and, after
uniform division by p, to the normalized coordinates I_E used
above. In particular, trace zero and the valuation of any nonzero
trace are invariant.

**Proof.** We spell out the normalization and integral argument.

First, the logarithmic map in the statement is well-defined on the
unit submodule. Inertia is characteristic under alpha by Mochizuki
1997, Corollary 1.3, PDF p. 3. Under local reciprocity the image of
inertia in the abelianization is the unit subgroup. Consequently
the induced integral Kummer isomorphism carries the pro-p completed
unit subgroup onto its counterpart. Quotienting its torsion gives
an isomorphism of the actual free logarithmic lattices; scalar
extension gives the Q_p-linear map F_log:E--->E'. No assertion
about preservation of higher unit filtrations is used here.
One can express this consequence without identifying Kummer
transport with a chosen reciprocity map: the completed unit subgroup
is the kernel of cup product with a generator of the unramified
Z_p-valued characters, since its reciprocity evaluation on z is
v_E(z). Characteristic inertia transports this generator up to a
Z_p unit; cup naturality and the integral H^2 isomorphism in Step 3
therefore preserve the kernel.

1. The p-adic cyclotomic characters obey

       chi_E composed with alpha = chi_E'.

   For the given arrow this follows already from the equivariance
   of the integral Tate-module isomorphism beta. More generally,
   group-theoretic recovery of the cyclotomic character guarantees
   that a Galois isomorphism admits such a coefficient isomorphism;
   this is not a field-isomorphism assumption. One verification uses
   local Tate duality: among cyclic modules of order p^n, the Tate
   twist is characterized by having H^2 of order p^n. The resulting
   compatible characters recover chi. This is also Mochizuki,
   A Version of the Grothendieck Conjecture for p-adic Local Fields,
   Proposition 1.1, PDF p. 3.

2. Put h_E=log_p composed with chi_E, an element of
   H^1(G_E,Z_p) with trivial coefficient action. It has a compatible
   reduction modulo p^n for every n. The preceding equality gives
   alpha^*(h_E)=h_E'.

3. Kummer theory and the local invariant maps give

       H^2(G_E,mu_(p^n)) = (1/p^n)Z/Z,

   with the standard identification with Z/p^n. The induced F^2_n
   is an isomorphism of these cyclic groups, hence multiplication
   by a unit c_n modulo p^n. These units are compatible with the
   transition maps, so they define c in Z_p×. Equivalently,

       H^2(G_E,Z_p(1)) = Z_p

   and its integral transport is multiplication by this unit.
   This step is where an arbitrary nonzero Q_p multiplier is
   excluded.

4. Use the arithmetic-Frobenius convention for local reciprocity,
   rec_E:E×--->G_E^ab. For an integral character h and a unit z,
   the local cup-product identity is

       inv_n((h mod p^n) cup kappa_n(z))
              = h(rec_E(z)) mod p^n.                 (4.2)

   Here inv_n includes the identification of (1/p^n)Z/Z with
   Z/p^n. The formula follows from the cyclic-algebra description
   of the cup product and reciprocity. See Milne, Chapter III,
   Proposition 3.6 and Section 4, Steps 2–3, PDF pp. 118–122.

5. Norm compatibility with reciprocity and the cyclotomic action
   for Q_p give, for z in U_E,

       h_E(rec_E(z))
          = -log_p Norm_(E/Qp)(z)
          = -Tr_(E/Qp)(log_p z).                     (4.3)

   The minus sign is the arithmetic-Frobenius convention; using
   the opposite convention changes both sides' pairing conventions
   consistently and leaves (4.1) unchanged.

6. Cup-product naturality, Step 2, and Step 3 now give

       inv_E'(h_E' cup F^1(kappa(z)))
           = c inv_E(h_E cup kappa(z)).

   By (4.2)–(4.3), this is exactly (4.1) on the logarithmic
   image of U_E. If an integral unit class has torsion, first
   quotient by that torsion: log kills it, F^1 preserves it,
   and the cup value in the torsion-free H^2 is zero. Thus the
   equality is well-defined on the actual free log lattice.
   This lattice spans E over Q_p, so linearity proves (4.1)
   on all E. Dividing coordinates on both sides by the same p
   preserves the equality. QED.

This proof uses neither a claim that alpha preserves higher
ramification groups nor a claim that alpha is geometric.

### Proposition 4.2. A concrete integral linear map excluded by the source

Take E=Q_7(pi), pi^3=7. The lattice I_E has Z_7-basis

    1, pi/7, pi^2/7.

The automorphism that swaps 1 with pi/7 and fixes pi^2/7 is not
induced by any coefficient-compatible Galois arrow from E to itself.

**Proof.** The trace of 1 is 3, whereas the trace of pi/7 is zero,
as follows either from the polynomial X^3-7 or from summing its
three conjugates. Proposition 4.1 would preserve trace zero,
which this swap does not. QED.

This excludes a specific element of GL_3(Z_7), even though the
source Galois automorphism group can be larger than the group
induced by field automorphisms. It does not exclude all
minimum-layer automorphisms: preservation of trace alone is a
weaker condition than full source admissibility.

### How far this reaches Ind1 and Ind2

Under a fixed local model, an Ind1 arrow gives an isomorphism of
the relevant Galois groups. Hoshi's Theorem 7.6 supplies its
unit-object lift, with the indicated unit-power ambiguity.
Theorem 3.3 classifies the additional Ism action actually present
in III 3.11(i). Thus (4.1), with a possibly different unit c,
holds for the composite local Ind1/Ind2 arrow.

No converse is claimed: a matrix satisfying (4.1) need not have
an absolute Galois lift, a compatible procession lift, or any
prescribed global realization.

## 5. Exact trace depth of a Tate-root family

### Theorem 5.1. Distinct native root powers have distinct admissible orbits

Let p and ell be distinct odd primes. Let b be an element of Q_p
with

    N=v_p(b)>0,   N an integer,   ell does not divide N.

Let E/Q_p be a finite extension containing mu_ell and a with
a^ell=b, and let d=[E:Q_p]. For each positive integer s not
divisible by ell put

    tau_s = log(1+p a^s)/p.

Then

    Tr_(E/Qp)(tau_s)
       = (d/ell) log(1+p^ell b^s)/p,                 (5.1)

and this trace is nonzero, with

    v_p(Tr_(E/Qp)(tau_s))
       = v_p(d/ell) + ell - 1 + s N.                (5.2)

Consequently, if s differs from t, no integral
coefficient-compatible Galois arrow, even followed by Ism,
sends tau_s to tau_t in the fixed native normalization.
The same conclusion holds for two marked copies of E.

**Proof.** Put F=Q_p(mu_ell). Because p differs from ell,
F/Q_p is unramified. Since v_F(b)=N is not divisible by ell,
b is not an ell-th power in F. As F contains mu_ell and ell
is prime, K=F(a) has degree ell over F. Its conjugates over
F are zeta a, for zeta ranging over mu_ell.

Multiplication by s permutes the exponents modulo ell, so

    Norm_(K/F)(1+p a^s)
       = product_(zeta in mu_ell) (1+p zeta a^s)
       = 1+p^ell b^s.                               (5.3)

The final sign is plus because ell is odd. All factors are
principal units. Applying log to (5.3) and dividing by p
gives

    Tr_(K/F)(tau_s)=log(1+p^ell b^s)/p.

This lies in Q_p. Taking the trace from E to K and from F
to Q_p multiplies it by [E:K][F:Q_p]=d/ell, proving (5.1).

The quantity x=p^ell b^s has valuation ell+sN, a positive
integer greater than 1. In the logarithm series, for k>=2,

    v_p(x^k/k)-v_p(x)
       = (k-1)(ell+sN)-v_p(k)>0.

Thus the first term alone has minimum valuation and
v_p(log(1+x))=ell+sN. Formula (5.2) follows.

For s distinct from t, the difference of the trace valuations
is (s-t)N, which is nonzero. Proposition 4.1 and Theorem 3.3
therefore rule out the claimed arrow. QED.

The degree equality is also automatic if the source and target
are different p-adic fields with isomorphic absolute Galois
groups, by Mochizuki's Proposition 1.2. Accordingly, the same
proof applies to such fields containing the corresponding
marked roots of the same b, provided their root powers and
native p-normalizations are as stated.

### A small fully specified local example

Take p=11, ell=5, E=Q_11(pi) with pi^5=11, and a=pi.
The field Q_11 contains mu_5, so E/Q_11 is cyclic of degree
5. The input b=11 has N=1 and corresponds to q=b^2=121.
The two relevant coefficients are

    tau_1=log(1+11 pi)/11,
    tau_4=log(1+11 pi^4)/11.

Their trace valuations are respectively 5 and 8. Therefore
no local Ind1/Ind2 arrow of the type above identifies these
coefficients. This is a local Tate-root example, not an
assertion that a global initial theta datum or the auxiliary
prime window has been constructed for this example.

### Lemma 5.2. The square root required for a rational Frey curve

Suppose a curve over Q_p has split Tate uniformization

    C(Qpbar) = Qpbar× / q^Z,   v_p(q)>0,

and all its 2-torsion is rational over Q_p. Then q=b^2 for
some b in Q_p with v_p(b)>0.

**Proof.** Choose b in Qpbar with b^2=q. Its class [b] is
a nontrivial 2-torsion point. Rationality implies [g(b)]=[b]
for every g in G_Qp. But g(b)/b is either 1 or -1, and
membership in q^Z is then possible only for 1: valuation
forces the exponent of q to be zero. Thus g(b)=b for every
g, proving b is in Q_p. Its valuation is v_p(q)/2>0. QED.

For a primitive rational Frey curve the three nonzero
2-torsion points are rational. Thus, at a split multiplicative
prime where a Tate uniformization is used, this lemma applies.
If an auxiliary extension E rationalizes the ell-torsion,
then it rationalizes the 2ell-torsion as well. The same
valuation argument applied to the class of a 2ell-th root
of q shows that one may take a in E with a^ell=b.
Full ell-torsion also gives mu_ell in E by the Weil pairing.

Accordingly, Theorem 5.1 applies to these actual local
ingredients whenever p differs from ell and ell does not
divide v_p(q)/2. No claim is made here that every bad prime
satisfies the last condition, or that these local checks
verify the full global initial-data hypotheses.

### Tensor and repeated-label consequence

Let u=log(1+p)/p and fix a block with m factors, one of which
has coefficient tau_s and the other m-1 of which have
coefficient u. A repeated label may require the same
Galois arrow in several factors; allowing different arrows
only enlarges the possible set, and still does not affect
the following obstruction.

Since v_p(u)=0, the background trace has valuation v_p(d).
The trace of a pure tensor in the finite etale algebra
E tensor_Qp ... tensor_Qp E is the product of the traces
of its factors. Hence the pure tensor for this block has
nonzero trace of valuation

    (m-1)v_p(d) + v_p(d/ell) + ell-1+sN.             (5.4)

Any composite of local Galois/Kummer arrows, Ism actions,
and permutations of the factors preserves this valuation.
It cannot send the block with s=1 to the block with
s=j^2 for j>1 and j<ell. This remains valid with the
source's repeated-label constraint.

It is essential that (5.4) is a statement about pure tensors
and their allowed arrows. Passing to a B-module hull allows
multiplication by coefficients that need not preserve the
trace filtration. Thus pure-orbit separation alone is not
a proof that two resulting B-hulls are unequal.

## 6. What can and cannot be inferred about unit filtrations

The source Galois group determines inertia, wild inertia,
degree, and the cyclotomic character. It need not determine
all higher ramification groups. Mochizuki's 1997 theorem
identifies filtration-preserving outer isomorphisms with
field isomorphisms; Hoshi, Theorems 2.2–2.3 and
Remark 3.15.2, records the existence of nongeometric
automorphisms and explains why the full filtration is
not group-theoretic.

Thus one cannot prove admissibility by simply asserting
that all Galois isomorphisms preserve each subgroup
1+m_E^n or every conductor. Conversely, the preceding
proofs did not need such an assertion.

Theorem 3.3 does preserve unit depth for the Ism part.
It does not turn an arbitrary Ind1 Galois arrow into a
field isomorphism. In particular, the earlier full-GL
common-minimum-layer theorem is still not automatically
a theorem about the actual Ind1 image.

A separate, narrower branch is worth keeping explicit.
Joshi I, Proposition 5.9.1, pp. 29–30, invokes absolute
anabelian reconstruction for strictly Belyi curves.
If one requires an arrow to lift to the arithmetic
fundamental groups of the specified strictly Belyi
curves, its induced base-field arrow is geometric;
native unit depth is then preserved, up to the scalar
unit coefficient ambiguity. This does not supply such
a lift for every Galois arrow in IIhalf 7.4.1: that
proposition has arithmeticoids, not a retained curve
fundamental group, as its input. No such lift is added
to the actual source by assumption in this note.

## 7. The simultaneous normalization test

The comparison must use one set of variables. Let
a^ell=b, q=b^2, and keep the marked native field E
and the coefficient tau_1 fixed.

| Operation | Effect on the coefficient and on the trace test |
|---|---|
| A field marking or a fixed-source Galois/Kummer arrow, followed by Ism | The trace changes by a p-adic unit; its valuation in (5.2) is unchanged. |
| Replacing an untilt absolute value by a positive real power | Changes the auxiliary real-valued norm prescription; it does not change the native trace in E. Native Haar normalization must be computed using v_p(p)=1. |
| Sending a to a^(j^2) inside log(1+p a)/p | Changes tau_1 to tau_(j^2); Theorem 5.1 excludes realizing this change by an integral Galois/Kummer/Ism arrow under the stated local hypotheses. |
| Sending the principal unit 1+p a to its j^2-th power | Multiplies tau_1 by j^2. When p does not divide j this is an Ism scalar and keeps the trace valuation. It is not tau_(j^2). |
| Multiplication of the Kummer class by p | Is not an integral coefficient isomorphism and increases the trace valuation; it cannot be inserted into an isomorphism collation. |
| Ind3 or maximal-order module-hull formation | A separate set operation; none of the preceding pure-orbit invariants automatically survives it. |

Joshi III 4.2.2.2, p. 33, specifies j-squared rescaling
between labelled absolute values. The present argument
does not erase that prescription. It proves that one
cannot implement it instead by the corresponding
root-power substitution in a fixed native integral
Kummer module and claim that this is a permitted
cohomology reidentification.

The fixed-source target-reset covariance proved in the
previous continuation remains valid. It transports a
fixed family of classes; it does not identify the two
different families separated by (5.2). Joshi IV,
Remark 6.10.2, p. 66, explicitly makes the distinction
between the arithmeticoids relevant to its comparison.
To obtain a global estimate one must still verify how
the complete family, hull, normalization, and Ind3
are transported together. This note does not resolve
that comparison.

## 8. Formalization boundary and next exact problem

The proofs in Sections 2–5 precede any new Lean file.
The formal supplement is now
Lean/IUTThreeClosures/IUTAdmissibleGaloisUniformGate20260830.lean.
Its original seven trace/depth theorems are:

* trace_zero_iff;
* trace_kernel_comap;
* trace_transport_comp;
* trace_addValuation;
* not_maps_of_trace_addValuation_ne;
* affine_traceDepth_injective;
* no_transport_between_affine_trace_depths.

These check the algebraic consequences of a trace functional
transported up to a unit and the resulting separation of trace-depth
labels. The additive-valuation theorem explicitly requires the
transport scalar to have valuation zero: being a unit of the
fraction field alone would not imply this. The last theorem takes
the exact affine depth formulas as hypotheses, rather than
asserting the p-adic logarithm calculation without a proof.

The file passed direct `lake env lean` compilation without warnings.
An independent `#print axioms` check of all seven declarations
reported only propext, Quot.sound and, for the final theorem,
Classical.choice. No sorryAx or source-specific axiom occurs.
After the separate mathematical proof in
`IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md`, Section 4,
the same module was extended by the definition unitScalarOrbit and
the theorem span_unitScalarOrbit. This eighth theorem proves the
abstract module-span identity for a unit-scalar family containing
the identity. It also passed compilation and an axiom check using
only propext and Quot.sound. The source-to-unit identification for
Ind2 remains a mathematical proof, not an added Lean assumption
about IUT.
This supplement does not formalize local class field theory,
continuous Galois cohomology, the scalar classification
using all finite extensions, or the p-adic logarithm
calculation. No source assertion is installed as an
axiom of ABC.

The next actual reachability question is now narrower:
determine the image of the Ind1 absolute Galois
automorphism group on I_E, subject at least to the
cyclotomic trace constraint. Ind2 has been classified
above and cannot supply additional nonscalar matrices.
Preserving trace alone does not establish an Ind1 lift.
The theorem about tau_s already excludes specified
arrows without needing a full classification of that
image.

Ind3 and the holomorphic B-hull remain a distinct
interface. A proof of equality or comparison of those
sets must use their source definitions and cannot be
replaced by an assertion about one pure tensor.

## 9. Reproducible original sources

The following newly checked PDFs are archived under
research/sources/uniform_gate_2026_08_30/. The shared
source manifest is maintained by the parent agent,
not edited in this continuation.

* Hoshi_Introduction_Monoanabelian_PMB2021.pdf:
  https://pmb.centre-mersenne.org/item/10.5802/pmb.42.pdf .
  Journal year 2021; online publication 2022-03-04.
  Checked PDF pp. 14–15, 17–24, 26–37, especially
  Definition 5.1–5.5 and Theorem 7.6.
* Mochizuki_Local_Fields_IJM1997.pdf:
  https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Version%20of%20the%20Grothendieck%20Conjecture%20for%20p-adic%20Local%20Fields.pdf .
  International Journal of Mathematics 8 (1997), 499–506.
  Checked PDF pp. 1–5, especially Proposition 1.1,
  Proposition 1.2, Corollary 1.3, and Proposition 2.2.
* Joshi_I_2106.11452v4_Feb2025.pdf:
  https://arxiv.org/pdf/2106.11452v4 .
  arXiv revision 2025-02-24; PDF title date 2025-02-25.
  Checked pp. 29–30 and 45–46.
* Mochizuki_IUT_II_December2020.pdf:
  https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20II.pdf .
  Title date December 2020. Checked pp. 2–3, 37–39.
* Mochizuki_IUT_III_May2020.pdf:
  https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf .
  Title date May 2020. Checked pp. 32, 153–158, 173–174.
* Milne_CFT_v4.03_August2020.pdf:
  https://www.jmilne.org/math/CourseNotes/CFT.pdf .
  Version 4.03, 2020-08-06. Checked PDF pp. 29–31,
  118–122 for local norms, existence, and the cup pairing.
* Yamagata_Local_Counterexample_1976.pdf:
  https://www.jstage.jst.go.jp/article/pjab1945/52/6/52_6_276/_pdf/-char/ja .
  Proceedings of the Japan Academy 52 (1976), 276–278.
  The source was checked for the stated nongeometric
  phenomena, not substituted for a proof of any new
  unit-filtration claim about our particular field.
* Joshi_Anabelomorphy_2003.01890v7_June2026.pdf:
  https://arxiv.org/pdf/2003.01890v7 .
  arXiv revision 2026-06-21; PDF title date 2026-06-23.
  Checked pp. 12–14, 17–18, 30. It records the current
  author's treatment of amphoricity. The proofs above
  rely on the underlying original local-field results,
  not on treating this preprint's further claims as axioms.

Previously archived Joshi originals are
research/sources/continuation_2026_08_30/Joshi_IIhalf_2305.10398v12.pdf,
research/sources/iut_2026_08_30/Joshi_III_2401.13508v4.pdf,
and research/sources/iut_2026_08_30/Joshi_IV_2403.10430v2.pdf.
Their relevant sections are specified above.
