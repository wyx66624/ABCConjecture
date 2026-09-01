# Independent review of the balanced level-43 initial-data construction

Author: ChatGPT. Review completed: 2026-08-31 (local date).

Reviewed file: `IUT_INITIAL_DATA_BALANCED43_AUDIT_2026_08_30.md`, in
particular sections 3--6. The checked snapshot has SHA256
`3aa847493036e8ed399675154166109d2b4cc08585ce03901f865d5a5d39cb24`.
The arithmetic prerequisites in its section 2 are the separately checked
balanced Frey calculations; this review does not rerun the large-integer
certificate. No existing report, Lean module, TeX file, or PDF was edited.

**Conclusion.** No substantive correction to sections 3--6 is required.
With the arithmetic prerequisites stated there, the construction supplies
the missing covering, core, place-section, and cusp data in Mochizuki I,
Definition 3.1(a)--(f). In particular, it does not require a further global
extension of the level-43 field. This conclusion concerns that definition
only. It neither identifies different pilot families nor establishes a
global theta-volume inequality, the later indeterminacy bounds, or abc.

## 1. The definition checked, including the underlines

I read the May 2020 author PDF of Mochizuki I, pages 61--65, and visually
checked pages 62--63. The distinction between the following objects is
material:

* Definition 3.1(d) specifies a single underlined orbicurve over the number
  field \(K\), of type \((1,\ell\text{-tors})^{\pm}\), with core \(C_K\).
* Its final paragraph specifies the double-underlined **geometric**
  coverings by their uniquely determined geometric open subgroups.
* Definition 3.1(e) requires a set of places mapping bijectively to the
  places of the field of moduli. At its selected bad places, the single
  underlined covering must have the graph-cover type; the same paragraph
  then invokes the local construction giving the double-underlined
  coverings models over the individual \(K_v\).
* Definition 3.1(f) specifies one global nonzero cusp and requires its
  local image to be the graph generator modulo sign at each selected bad
  place.

Thus the definition does not demand a preassigned place-section, one
Galois element acting on all its places, or a single arithmetic splitting
of the geometric double-underlined cover over \(K\) that agrees with every
local theta normalization. A construction making any of those stronger
claims would need an additional proof; the reviewed construction makes
none of them.

## 2. Arithmeticity and the core

CanLift Proposition 2.7 (author PDF pages 14--15) applies to punctured
hemi-elliptic orbicurves over an algebraically closed characteristic-zero
field. It both gives the core conclusion for a nonarithmetic such curve
and states that precisely four arithmetic isomorphism classes occur.
Proposition 2.3(i)--(ii), page 10, supplies the needed base-field change
and descent statements. These are statements about the same notion of
core as Remark 2.1.1, page 9.

I checked Sijsling Table 4, page 11, visually, and Takeuchi Theorem 4.1(i),
printed page 392 (PDF page 12), by extraction. The four invariants used in
the report are

\[
 2^{14}31^3/5^3,\qquad 2^2 73^3/3^4,\qquad 1728,\qquad 0.
\]

Their valuations at 1289 are nonnegative, including the infinite
valuation of zero. Since the actual balanced curve has

\[
 v_{1289}(j(D))=-4,
\]

its invariant is none of the four. After an embedding in the complex
numbers, the classification excludes arithmeticity; CanLift 2.3 transfers
this exclusion back to the chosen algebraic closure and then to the
finite fields in use. Proposition 2.7 therefore gives that

\[
 C_K=[(D_K\setminus\{O\})/\{\pm1\}]
\]

is a \(K\)-core. Arithmeticity and the core category are invariant under
the finite etale commensurability here. Consequently a finite etale cover
of this orbicurve has this same core. The report correctly uses the
specific four-class classification; non-CM alone would not prove this
step.

## 3. The cyclic covering has the correct isogeny direction

Let \(V=D[43](K)\), choose a line \(H\subset V\), and put

\[
 \phi:D_K\longrightarrow D_K/H,\qquad
 \psi:D_K/H\longrightarrow D_K,
 \qquad \psi\phi=[43].
\]

Because all of \(V\) is \(K\)-rational, the quotient, both isogenies, and
the exact sequence

\[
 0\longrightarrow H\longrightarrow V
   \xrightarrow{\phi}\ker\psi\longrightarrow0
\]

are over \(K\). Removing the kernel of \(\psi\) from its source gives a
cyclic finite etale degree-43 cover of \(D_K\setminus\{O\}\), with
constant deck group \(V/H\). It extends unramified across the removed
point with an entirely \(K\)-rational fiber. Its monodromy is therefore
trivial on the cusp decomposition group, not merely on cusp inertia.
The geometric monodromy factors through the mod-43 abelian elliptic
quotient. This checks both conditions on the quotient \(Q\) immediately
before EtTh Definition 2.1 (pages 32--33).

Inversion commutes with \(\psi\). Equivariant descent yields the cartesian
square of stack quotients in the reviewed report. The bottom morphism
is finite etale by base change along the finite etale atlas

\[
 D_K\setminus\{O\}\longrightarrow C_K.
\]

Its being generally non-Galois agrees with EtTh Remark 2.1.1; no
nonexistent bottom deck group is used.

For the local identification, if \(D=E(q)\) and \(H=\mu_{43}\), then

\[
 D/H=E(q^{43}),\qquad
 \phi([z])=[z^{43}],\qquad \psi([z])=[z].
\]

The latter map has kernel generated by \([q]\), and

\[
 \phi([q^{1/43}])=[q].
\]

It is precisely the quotient of the infinite Tate graph cover by

\[
 43\mathbb Z\subset\mathbb Z.
\]

Using the power map as the graph cover would give the wrong direction;
the reviewed report uses the identity-on-parameters map \(\psi\).
The natural graph quotient and its sign ambiguity are explicitly given
in EtTh page 11.

## 4. One global cusp and separately chosen places

The elementary transitivity statement is correct in the necessary
decorated form. Given a line \(H\) and \(0\ne\bar v\in V/H\), choose a
lift \(v\). There is a unique \(h\in H\) for which

\[
 \omega(h,v)=1.
\]

Doing the same for a second decorated quotient gives two symplectic
bases; the linear map between them has determinant one and carries the
first decorated quotient to the second. This proves transitivity on
the pairs, not just on the undecorated lines.

At a selected bad rational prime \(r\), choose a place \(w\mid r\) of

\[
 K=F(D[43]).
\]

Tate uniformization defines in the fixed global module \(V\) the line of
multiplicative torsion and the nonzero quotient class of \(q_w^{1/43}\).
The root is ambiguous only by that line; reversing the graph orientation
changes the quotient generator by sign. For the action on valuations

\[
 (gw)(x)=w(g^{-1}x),
\]

the induced map of completions transports these data by the action of

\[
 g\in\operatorname{Gal}(K/F).
\]

Thus, because the already established image contains

\[
 \operatorname{SL}_2(\mathbb F_{43}),
\]

one may choose \(g_r\) taking this local decorated pair to a single
preselected global pair \((H,\bar v)\). The place \(g_rw\) has the desired
interpretation for that same global covering and cusp. Doing this for
each \(r\) and choosing arbitrary places above all other rational places
gives the requested section. There is no simultaneous-conjugacy
requirement in Definition 3.1(e), so the independent choices \(g_r\) are
valid. No local choice changes the number field \(K\).

## 5. Local theta splittings and the auxiliary covers

I read EtTh pages 12--13, 16, 20--21, 25--29, and 32--36. In
particular, I visually checked Proposition 2.2, Theorem 1.10(iii), and
Definition 2.5(i). They have the scopes used in the report.

At each selected bad place let \(k=K_v\). The field is a finite
extension of a \(p\)-adic field with odd residue characteristic different
from 43. It contains \(i\), and \(D\) is split Tate with full rational
2-torsion. The latter really implies \(\sqrt q\in k\): the class of
a chosen square root is a rational torsion point; the ratio of a Galois
conjugate to itself is both a power of \(q\) and of valuation zero,
and hence is one. Therefore

\[
 k=k(\mu_2,q^{1/2})=\ddot k.
\]

This is the required field of EtTh pages 12 and 16, not a claim that an
even valuation by itself supplies a square root. Nonarithmeticity over
this local field follows by the base-field results already checked.

For the standard-type theta class, the series in Proposition 1.4 has
value at the indicated 4-torsion point \(\ddot U=i\)

\[
 \ddot\Theta(i)=2i+\text{terms of positive valuation}.
\]

Indeed, after the \(q^{-1/8}\) prefactor, the exponent of \(q\) in the
term indexed by \(n\) is \(n(n+1)/2\); only \(n=0,-1\) contribute to
the constant term. The value is a \(k\)-unit. Multiplication by its
inverse is consequently among the allowed \(\mathcal O_k^\times\)
normalizations. It gives the standard type required by Definition 1.9.
Theorem 1.10(iii) then supplies the cuspidal \(\{\pm1\}\)-structure.
At the mod-43 level the two representatives determine the same class,
since \(-1=(-1)^{43}\). This supplies the compatible local splitting
used by Proposition 2.2 and Definition 2.5(i).

Two potentially hidden conditions were also checked:

1. EtTh Remark 1.10.1(ii), page 28, records a primitive 12th-root
   hypothesis omitted in an earlier cited result. Here it causes no
   gap: \(i\in F\) and the Weil pairing on \(D[3]\subset D(F)\)
   gives \(\mu_3\subset F\), hence \(\mu_{12}\subset F\subset k\).
2. The assumption \((*)\) in Mochizuki I, section 1, page 37, is about
   the abelianization modulo 43 of the original **un-underlined**
   once-punctured curve. It follows from \(K=F(D[43])\). Together with
   \(43\ge5\), \(\gcd(43,6)=1\), and the nonzero cusp, this verifies
   the assumptions preceding Definition 1.1 and Remark 1.1.2 for the
   oriented covers invoked at the end of Definition 3.1(f).

The auxiliary covers are therefore obtained with the global/geometric
and local/arithmetic distinction that the original definition requires.
There is no need to add global 43rd roots of arbitrary constants to

\[
 F=\mathbb Q(i,D[30])
\]

in this argument.

## 6. Source record and limits of the review

| Original source | Checked author-PDF pages | Bytes | SHA256 |
|---|---|---:|---|
| Mochizuki I, May 2020 | 37--39, 61--65 | 1280589 | `7360e3ed27c235b5497a0743d3ed1646fbb97688547d16b7c784fc7f127f1f03` |
| Canonical Curves / CanLift | 9--10, 14--15 | 246691 | `dcf986ecbb06d4e9cb49f6ff92d7417d7e63ce946fd1403b1128e416d9ac807a` |
| The Etale Theta Function | 10--13, 16, 20--21, 24--29, 32--36 | 814566 | `42c5d9180c69bc9fa6596ce1a11662494315954ed74301060bf1819f955a7406` |
| Takeuchi, arithmetic Fuchsian groups | 12 = printed 392 | 2125644 | `6c4f44cf6abc2b75d5433f594d2d9b1d4407a3fea934c5149c13fb62d2f6223f` |
| Sijsling, arXiv:1707.01158v2 | 10--12, especially Table 4 | 230319 | `b483753b248795227de800c9f004cbcf077c502092140d3ac4c1e84b6b7df60f` |

Original URLs and local archive paths are in section 8 of the reviewed
report. The Mochizuki I and EtTh author URLs were also reopened during
this review. Reading images are in
`tmp/pdfs/initial_data_analytic_review_2026_08_30/`.

This review does not assert that the chosen prime 43 is a prime returned
by Joshi's separate existence theorem. It does not assert membership
outside a proof-dependent exceptional set, or turn a finite example into
an unbounded family. In particular, the local logarithmic hulls studied
elsewhere still require their own exact carrier and normalization
statements. None of the anabelian, elliptic, local-field, or theta results
used here is claimed as a newly checked Lean theorem.
