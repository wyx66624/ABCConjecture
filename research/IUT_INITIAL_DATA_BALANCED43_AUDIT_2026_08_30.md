# Constructing initial theta data for the balanced ell=43 curve

Author: ChatGPT. Research date: 2026-08-30.

Status: mathematical proof, with explicit classical source dependencies; no
new Lean declaration is asserted. This note constructs the data required by
Mochizuki I, Definition 3.1(a)--(f), for the balanced rational curve below.
It does not use Joshi IV's finite-exception existence theorem. Constructing
initial data does not prove any theta-volume comparison, identify different
native and holomorphic pilot sets, or prove or disprove abc.

The arithmetic calculations to which this note adds the missing covering,
core, place, and cusp constructions are in
`FREY_43_1289_BALANCED_LEGENDRE_REALIZATION_2026_08_30.md`, sections 1--6.
The statements below distinguish the definition of initial data from the
subsequent, still unresolved comparison arguments.

## 1. Fixed arithmetic data and the precise conclusion

Set

\[
 \ell=43,\qquad p=1289,\qquad A=p(p^{16}+428),
\]
\[
 a=A^2,\quad b=A^2+1,\quad c=2A^2+1,\qquad
 D:\ y^2=x(x-a)(x+b).
\]

The change of variables \(x=A^2X,\ y=A^3Y\) identifies this curve over
\(\mathbb Q\) with the Legendre curve of parameter
\(\lambda=-1-A^{-2}\). Define

\[
 F=\mathbb Q(i,D[30]),\qquad K=F(D[43])
       =\mathbb Q(i,D[1290]),\qquad X_F=D_F\setminus\{O\},
 \qquad C_F=[X_F/\{\pm1\}].                     \tag{1.1}
\]

Choose an algebraic closure \(\overline F\) containing these fields. All
group quotients of curves in this note mean stack quotients when fixed
points are present. Let

\[
 S=\{r:\ r\text{ is an odd rational prime and }r\mid abc\}.
                                                               \tag{1.2}
\]

In particular \(1289\in S\), and \(43\notin S\). We shall prove the
following existence statement.

**Theorem 1.1.** For every nonempty subset \(S_0\subseteq S\), there are
a hyperbolic orbicurve \(\underline C_K\), a cusp \(\epsilon\) of it,
and a section \(\mathbb V\subseteq V(K)\) of
\(V(K)\longrightarrow V(\mathbb Q)\), such that

\[
 (\overline F/F,X_F,43,\underline C_K,\mathbb V,S_0,\epsilon)
                                                               \tag{1.3}
\]

satisfies precisely Mochizuki I, Definition 3.1(a)--(f).

The source definition is on author-PDF pages 61--63 of
[Mochizuki I](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20I.pdf).
The geometric and local constructions it invokes are EtTh Definition 2.1,
Proposition 2.2, and Definition 2.5(i), not a global volume inequality.
The theorem includes \(S_0=S\); a minimal example uses just
\(S_0=\{1289\}\).

## 2. Conditions (a), (b), and (c)

The already verified arithmetic facts are collected here with their roles.
They can be checked without factoring the large endpoints.

* \(a+b=c\), and the three positive endpoints are pairwise coprime.
* \(D[2]\) is rational over \(\mathbb Q\).
* With \(S_D=3A^4+3A^2+1\),
  \(\Delta=16(abc)^2\), \(c_4=16S_D\),
  \(j(D)=256S_D^3/(abc)^2\), and \(\gcd(S_D,abc)=1\).
* At each odd \(r\mid abc\), the equation is minimal and split
  multiplicative. Its Tate order is \(2v_r(abc)\).
* At \(p=1289\), \(v_p(A)=1\), so \(v_p(q)=4\) and
  \(v_p(j(D))=-4\).
* At 2, \(v_2(b)=1\) and \(v_2(j(D))=6\). At every other rational
  prime not in \(S\cup\{2\}\), the displayed discriminant is a unit.

For splitness, reducing at a prime dividing \(a\) or \(b\) gives
\(y^2=x^2(x+1)\), with tangent slopes \(\pm1\). At a prime dividing
\(c\), translating the node to zero gives \(y^2=X^2(a+X)\), with
tangent slopes \(\pm A\). All slopes are distinct units at the
respective odd primes. The formulas above then follow from the elementary
Weierstrass discriminant and tangent criteria and the split Tate theorem.

The field \(F\) contains \(i\) and all 6-torsion. It is Galois over
\(\mathbb Q\), and

\[
 [F:\mathbb Q]\mid
 2\,|\operatorname{GL}_2(\mathbb Z/30\mathbb Z)|
 =2\cdot6\cdot48\cdot480=276480.                 \tag{2.1}
\]

In particular its degree is prime to 43. Since \(X_F\) has a model over
\(\mathbb Q\), its field of moduli in \(\overline F\) is
\(F_{\rm mod}=\mathbb Q\): every automorphism of
\(\overline{\mathbb Q}/\mathbb Q\) fixes its geometric isomorphism
class, and every characteristic-zero number field contains
\(\mathbb Q\). The field \(F_{\rm sol}\) in the definition is simply
the maximal solvable extension of \(\mathbb Q\) inside
\(\overline F\); it imposes no additional condition on (1.1).

### 2.1. Good reduction above 2, with the finite torsion argument explicit

Let \(w\mid2\) be a place of \(F\). We justify the only reduction
condition not immediate from the displayed integral model. Here \(F_w\)
is a finite extension of \(\mathbb Q_2\), its ring of integers is a
complete discrete valuation ring, and its residue field is finite, hence
perfect. These are the hypotheses of Silverman VII (PDF201, printed185).
Use a minimal Weierstrass equation over this \(F_w\) to define
\(D_0(F_w)\), \(D_1(F_w)\), and the reduction group. The equation
need not be the original rational integral model. Suppose that
\(D/F_w\) had additive reduction. The formal subgroup \(D_1(F_w)\)
has no nonzero 3-torsion, and
\(D_0(F_w)/D_1(F_w)\) is the additive group of the residue field, which
also has no 3-torsion. Thus \(D_0(F_w)[3]=0\). The rational subgroup
\(D[3]\simeq(\mathbb Z/3\mathbb Z)^2\) would consequently inject
into \(D(F_w)/D_0(F_w)\). This is impossible: in the additive case
the Kodaira--Neron component-group bound is at most four, whereas
\(|D[3]|=9\).

These are the exact statements of Silverman, *The Arithmetic of Elliptic
Curves*, second edition, VII.2.1, VII.3.1(a), VII.5.1(c), and VII.6.1;
the archived PDF pages are 204, 208, 212, and 216. They are classical
mathematical inputs, not Lean axioms. In particular VII.6.1's bound in
the additive case has no exclusion of residue characteristic two and
applies over each finite extension \(F_w\) separately. It also follows
by injection into the geometric component group, whose order is at
most four. Finally, multiplicative reduction
would imply negative \(j\)-valuation, contrary to
\(v_w(j)=6e(w/2)>0\). Thus \(D\) has good reduction at every \(w\mid2\).

At all other places, good or split multiplicative reduction is preserved
under extension. The zero section gives a stable one-pointed model: a
smooth genus-one fiber with one marked point in the good case, and a
nodal genus-one fiber with the marked point in its smooth locus in the
multiplicative case. Equivalently, contract the unmarked two-valent
components of the semistable polygon. This verifies stable reduction of
the hyperbolic curve \(X_F\), rather than confusing the stability of
the pointed curve with the unpointed elliptic-curve terminology.

### 2.2. The actual mod-43 image

Modulo 5, \(A=1\) and \(\#D(\mathbb F_5)=4\). Good-reduction
Frobenius therefore supplies an image element with characteristic
polynomial \(T^2-2T+5\). Its discriminant \(-16\) is a nonsquare in
\(\mathbb F_{43}\), so this element preserves no line.

At 1289, the Tate order four is prime to 43. Tate uniformization supplies
a nontrivial inertia transvection of order 43. Its fixed line and the
image of that line under the preceding irreducible element differ.
Relative to these two lines, the two conjugate transvections generate
the upper and lower elementary unipotents, hence
\(\operatorname{SL}_2(\mathbb F_{43})\).

The image over \(F\) is normal in the image over \(\mathbb Q\), with
index dividing (2.1). The order-43 transvection belongs to it, as does
its conjugate by every element of the larger image. The same elementary
generation proves

\[
 \operatorname{im}(G_F\longrightarrow
       \operatorname{GL}(D[43]))
       \supseteq\operatorname{SL}_2(\mathbb F_{43}).             \tag{2.2}
\]

The field cut out by the kernel is exactly the \(K\) in (1.1), not a
larger auxiliary extension.

### 2.3. Prime-to-43 orders at all selected places

Section 6 of the balanced arithmetic report proves
\(1\le v_r(abc)<43\) at every prime dividing \(abc\). Its exact
certificate is
`GEOMETRY_43_1289_ARITHMETIC_CERTIFICATE_2026_08_30.json`.
Briefly, \(a,b,c<2^{377}\), whereas \(r^{43}\ge2^{387}\) for
\(r\ge512\). Below 512, the product \(P\) of the 97 primes has
\(\gcd(a,P)=3\), \(\gcd(b,P)=2\), \(\gcd(c,P)=17\), with the
respective nonzero valuations 2, 1, and 1. The certificate records exact
Bezout identities and terminal nonzero residues for these statements.
Thus none of the positive orders \(2v_r(abc)\) is divisible by 43.

If \(w\mid r\) is a place of \(F\), then

\[
 \operatorname{ord}_w(q_w)=2e(w/r)v_r(abc).
\]

The ramification index divides the Galois degree (2.1), so this order
is still prime to 43. Also \(43\nmid abc\), since the endpoints are
\((1,2,3)\) modulo 43. All assertions in Definition 3.1(c) now hold
simultaneously for any \(S_0\subseteq S\). For the singleton choice
\(S_0=\{1289\}\), only the local order four and (2.1) are needed.

## 3. The K-core condition is verified, not left as a genericity assumption

Mochizuki, *The Absolute Anabelian Geometry of Canonical Curves*,
Proposition 2.7 (author-PDF pages 14--15), states that a nonarithmetic
punctured hemi-elliptic orbicurve in characteristic zero is its own
core. Proposition 2.3(i)--(ii), author-PDF page 10, identifies this
property after separable/algebraically closed field extensions and
provides descent of the core. The notion is the one in Remark 2.1.1,
author-PDF page 9.

There are exactly four geometric arithmetic once-punctured elliptic
curves, by Takeuchi, Theorem 4.1(i), published page 392, PDF page 12.
Sijsling computes their models and invariants in section 3.1, Table 4,
PDF page 11 of [arXiv:1707.01158v2](https://arxiv.org/abs/1707.01158v2):

\[
 \frac{2^{14}31^3}{5^3},\qquad
 \frac{2^2 73^3}{3^4},\qquad1728,\qquad0.          \tag{3.1}
\]

All four values are integral at 1289, whereas \(v_{1289}(j(D))=-4\).
Thus \(D\setminus\{O\}\) and its hemi-elliptic quotient are
nonarithmetic over an algebraic closure. The cited base-change and
descent proposition then proves that \(C_K=C_F\times_F K\) is a
\(K\)-core. This uses only the specific classification and core
theorems; it does not infer nonarithmeticity from non-CM or from the
presence of some unspecified bad prime.

The source PDFs are
[CanLift](https://www.kurims.kyoto-u.ac.jp/~motizuki/Canonical%20Liftings.pdf),
[Takeuchi](https://www.jstage.jst.go.jp/article/jmath1948/35/3/35_3_381/_pdf/-char/en),
and [Sijsling](https://arxiv.org/pdf/1707.01158v2).

## 4. One global cyclic covering and a nonzero global cusp

Put \(V=D[43](K)\). Fix a line \(H\subset V\), and let
\(\phi:D_K\longrightarrow D_K/H\) be the quotient isogeny.
Its dual \(\psi:D_K/H\longrightarrow D_K\) satisfies
\(\psi\phi=[43]\). Both isogenies are defined over \(K\), since
all of \(V\) is \(K\)-rational. There is an exact sequence

\[
 0\longrightarrow H\longrightarrow V
  \xrightarrow{\phi} Q:=\ker\psi\longrightarrow0,               \tag{4.1}
\]

so \(Q\cong V/H\) is a constant cyclic group of order 43. Define

\[
 \underline X_K=(D_K/H)\setminus Q,
 \qquad \underline C_K=[\underline X_K/\{\pm1\}].              \tag{4.2}
\]

The map \(\psi\) restricts to a finite etale cyclic cover
\(\underline X_K\to X_K\) of degree 43. Its deck group is \(Q\).
All its cusps are \(K\)-rational. The cover extends etale across the
origin of the completed base elliptic curve, so its quotient of the
fundamental group is trivial on the full decomposition group of the
chosen cusp: inertia is trivial, and the residue-field part acts
trivially on the rational fiber \(Q\).

The cover is an isogeny cover, hence its geometric monodromy factors
through the abelian elliptic quotient of the geometric fundamental
group. Thus it is exactly the construction preceding EtTh Definition
2.1, author-PDF pages 32--33: a cyclic rank-one quotient of the
elliptic fundamental group, surjective on its geometric portion and
trivial on the selected cusp decomposition group.

Quotienting by inversion gives the cartesian square

\[
 \begin{matrix}
 \underline X_K&\longrightarrow&X_K\\
 \downarrow&&\downarrow\\
 \underline C_K&\longrightarrow&C_K.
 \end{matrix}                                                   \tag{4.3}
\]

The bottom map is finite etale as an orbicurve map by descent along
\(X_K\to C_K\). In particular, it is of type
\((1,43\text{-tors})^\pm\) in the source's terminology. Although
the top cover is cyclic Galois, the bottom cover is generally not
Galois; no Galois assertion about the bottom cover is used.

Since \(C_K\) is a core and (4.3) is finite etale, it is also the
\(K\)-core of \(\underline C_K\): the categories of objects
commensurable with the two orbicurves coincide. Finally fix any
\(\bar v\ne0\) in \(V/H\). Its image under (4.1) gives a nonzero
cusp of \(\underline X_K\), and its inversion orbit gives a cusp
\(\epsilon\) of \(\underline C_K\). The remaining requirement is
to arrange its prescribed local interpretation at every selected bad
place; this is done next while keeping \(H\) and \(\bar v\) fixed.

## 5. Simultaneous local compatibility by choosing the section of places

**Lemma 5.1 (decorated quotients).** If \(V\) is a two-dimensional
vector space over a field with a fixed nondegenerate alternating form,
then \(\operatorname{SL}(V)\) acts transitively on pairs
\((H,\bar v)\), where \(H\) is a line and \(0\ne\bar v\in V/H\).

**Proof.** Choose a representative \(v\) of \(\bar v\). There is a
unique nonzero \(h\in H\) with \(\omega(h,v)=1\). For another
pair choose \(h',v'\) in the same way. The map sending
\((h,v)\) to \((h',v')\) preserves \(\omega\), has determinant
one, and sends the first decorated pair to the second. \(\square\)

For each \(r\in S_0\), initially choose an arbitrary place \(w\) of
\(K\) above \(r\). The curve is split Tate over \(F_{w|F}\), hence
over \(K_w\), with parameter \(q_w\). Tate uniformization gives

\[
 0\longrightarrow\mu_{43}\longrightarrow D[43](K_w)
   \longrightarrow\mathbb Z/43\mathbb Z\longrightarrow0.     \tag{5.1}
\]

The last map records the exponent of \(q_w^{1/43}\); its generator
is canonical up to reversal of the orientation, hence up to sign.
All torsion points in (5.1) come from \(V\). Thus it defines a
decorated pair \((H_w,\bar v_w)\) in \(V\), where \(H_w\) is the
multiplicative subgroup and \(\bar v_w\) is the class of
\(q_w^{1/43}\). Choices of the root change it only by \(\mu_{43}\).
Choose one of the two orientations to obtain an actual \(\bar v_w\).

These pairs are equivariant under \(\operatorname{Gal}(K/F)\).
More precisely, use the action on places
\((g w)(x)=w(g^{-1}x)\). The resulting map of completions
\(g:K_w\to K_{gw}\) transports Tate uniformization, its
multiplicative subgroup, and the quotient generator. Consequently

\[
 (H_{gw},\bar v_{gw})=g(H_w,\bar v_w)              \tag{5.2}
\]

after compatible orientation choices; the statement modulo sign is
independent of these choices. This is an action on places of the
fixed global field \(K\), not a change of \(F\), \(K\), or of the
global covering.

By (2.2) and Lemma 5.1, select \(g_r\in\operatorname{Gal}(K/F)\)
mapping \((H_w,\bar v_w)\) to the fixed global
\((H,\bar v)\). Select the place \(v_r=g_rw\) over \(r\).
At that place the covering and cusp of section 4 have exactly the
required local form. To check the direction, write the Tate curve as
\(D=E(q)\). When \(H=\mu_{43}\), the two isogenies are

\[
 \phi:E(q)\to E(q^{43}),\quad[z]\mapsto[z^{43}],
 \qquad
 \psi:E(q^{43})\to E(q),\quad[z]\mapsto[z].       \tag{5.3}
\]

The kernel of \(\psi\) is generated by the class of \(q\), and
\(\phi([q^{1/43}])=[q]\). The identity map in (5.3), not the
power map, is the chosen degree-43 graph cover. The universal
graph-cover quotient \(\Pi_X^{\rm tp}\twoheadrightarrow\mathbb Z\)
of EtTh, author-PDF page 11, has deck generator multiplication by
\(q\); reducing it modulo 43 gives exactly this cover and this
cusp. Its profinite completion is the \(\widehat{\mathbb Z}\)
quotient in Definition 2.5(i).

It follows that \(\underline C_{v_r}\) is of type
\((1,\mathbb Z/43\mathbb Z)^\pm\), and \(\epsilon_{v_r}\)
comes from the canonical \(\pm1\) in that quotient. These are
both local requirements of Definition 3.1(e)--(f).

For each remaining rational place, including the archimedean place,
choose any one place of \(K\) above it. Combining these choices with
the finite collection \(v_r\), \(r\in S_0\), gives the required
section \(\mathbb V\). The original Definition 3.1(e) imposes no
equivariance, continuity, preassigned section, or simultaneous
Galois conjugation condition on this set of places. Therefore the
independent choices \(g_r\) are allowed. The global \(H\), cover,
and cusp remain single fixed objects throughout the construction.

## 6. The auxiliary theta covers require no further global base extension

We record explicitly what is supplied by the local theta-cover
construction invoked in Definition 3.1, to avoid hiding an enlargement
of \(F\) with degree divisible by 43.

EtTh Proposition 2.2, author-PDF pages 34--35, constructs for odd
\(\ell\) the canonical geometric subgroups attached to inversion.
Choosing a splitting of the indicated cuspidal extension produces the
theta covering over the base field. The splittings form a torsor under
\(H^1(G_k,\mu_{43})=k^\times/(k^\times)^{43}\).
The geometric subgroups are independent of this extra arithmetic
splitting. They give the two geometric covers in Mochizuki I,
Definition 3.1(d). That definition does not require a single choice
of arithmetic splitting over \(K\) agreeing with all bad places.

At a selected bad place put \(k=K_v\). All the hypotheses for the
local construction are satisfied:

* the reduction is split multiplicative and the residue characteristic
  is odd and different from 43;
* the underlying punctured curve is non-\(k\)-arithmetic, by section 3
  and CanLift Proposition 2.3;
* \(i\in k\), and rational full 2-torsion gives
  \(k=k(\mu_2,q^{1/2})\), which is the condition
  \(k=\ddot k\) in EtTh (the definition of \(\ddot k\) is on
  author-PDF page 16);
* the cusps are \(k\)-rational, and \(k\) contains \(\mu_{43}\),
  the latter also following from the Weil pairing on \(D[43]\).

The auxiliary root-of-unity reminder in EtTh Remark 1.10.1(ii)
(author-PDF page 28) is also satisfied: the Weil pairing on the
rational \(D[3]\) gives \(\mu_3\subset F\), and \(i\in F\) gives
\(\mu_4\subset F\). Therefore \(\mu_{12}\subset F\subset k\).
No additional base extension is needed for this hypothesis either.

For completeness, the square root assertion in the third item does
not follow merely from the valuation being even. If \(b_0^2=q\),
its Tate class is a rational 2-torsion point. For every Galois element,
\(\sigma(b_0)/b_0\in q^{\mathbb Z}\); its valuation is zero, so
it equals 1. Hence \(b_0\in k\).

EtTh Proposition 1.4, author-PDF pages 20--21, relates its theta
class to the classical theta series. At the point represented by
\(i\), the leading value is \(2i\), a unit in odd residue
characteristic; the remaining terms have positive valuation.
Multiplication by a \(k\)-unit therefore normalizes this value to
one. This gives a theta class of standard type in Definition 1.9.
Theorem 1.10(iii), author-PDF pages 27--28, supplies the compatible
\(\{\pm1\}\)-structure on the cuspidal torsor. Modulo 43 this
determines the needed splitting class: changing a representative by
\(-1\) changes its class by a 43rd power, since
\((-1)^{43}=-1\). Applying Proposition 2.2 with this local splitting
is precisely the theta cover stipulated in Definition 2.5(i),
author-PDF page 36.

This is the local construction summarized in Mochizuki I, Definition
3.1(e), PDF page 63. It gives natural \(K_v\)-models of the
geometric theta covers at each selected bad place. No adjoining of
global 43rd roots of arbitrary constants to \(F\) has occurred.
The further oriented covers at the end of Definition 3.1(f) are
determined by the already fixed triple
\((X_K,\underline C_K,\epsilon)\), as in that paper's Definition
1.1 and Remark 1.1.2. Thus they do not add an unsatisfied arithmetic
existence condition. This completes the proof of Theorem 1.1.

## 7. What the construction does and does not identify

The new conclusion is stronger than a numerical prime-window check:
the core, a single global cyclic orbicurve covering, a single global
nonzero cusp, and all chosen local graph-cover interpretations have
been supplied. No membership claim about Joshi's proof-constructed
finite exceptional set is needed. The fixed prime 43 constructed here
is not identified with the existentially chosen prime in Joshi IV,
Theorem 5.7.1; hypotheses of any subsequent statement involving that
particular choice or an exceptional set must still be checked separately.

At the selected place above 1289, the completion remains the actual
level-1290 field already determined in the balanced arithmetic report:

\[
 K_v=\mathbb Q_{1289}(\mu_{1290},\varpi),\quad
 \varpi^{645}=\sqrt q,
 \quad e=645,\quad f=2,\quad [K_v:\mathbb Q_{1289}]=1290.
\]

Changing the selected place by an element of \(\operatorname{Gal}(K/F)\)
does not change this isomorphism class. The correct uniformizer is
\(\beta=\varpi^{323}/1289\), and the native root
\(q^{1/86}\) has valuation \(2/43\). In particular this construction
does not replace it by a root of valuation \(1/43\).

The assertions about full-Galois local logarithmic actions and exact
native point/whole-product hulls in the other reports remain statements
about their explicitly typed local carriers. Initial data alone does
not identify those carriers with the complete published pilot family.
The following comparisons still require separate proofs:

1. the normalized coefficient \(p^{-1}\log\) versus the standard
   Bloch--Kato logarithm at every tensor factor;
2. the native \(j^2\)-power family versus the holomorphic family with
   its label-dependent norm rescaling;
3. a principal integral-closure ideal formed before a Galois-linear
   transport versus the hull formed after transport;
4. the global Frobenius comparison and upper bound for one and the
   same measured set, including the remaining indeterminacies.

No equality between any of these differently typed objects is added
as an assumption in Theorem 1.1. No Lean proof of Definition 3.1 or of
the original analytic/anabelian theorems is supplied here.

## 8. Primary-source archive and reproducibility

Existing archive used:

* `research/sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf`:
  Definition 3.1, PDF pages 61--63.
* `research/sources/global_uniform_gate_2026_08_30/Silverman_2009_Arithmetic_of_Elliptic_Curves_2nd.pdf`:
  VII.2.1, VII.3.1, VII.5.1, VII.6.1, PDF pages 204, 208, 212, 216.

New originals saved in `research/sources/initial_data_2026_08_30/`:

| Local file | Exact original URL | Version / date and checked locations | SHA256 |
|---|---|---|---|
| `Mochizuki_Canonical_Curves_2003_author.pdf` | `https://www.kurims.kyoto-u.ac.jp/~motizuki/Canonical%20Liftings.pdf` | Author PDF of the 2003 article; Remark 2.1.1 and Propositions 2.3, 2.7; PDF 9--10, 14--15 | `dcf986ecbb06d4e9cb49f6ff92d7417d7e63ce946fd1403b1128e416d9ac807a` |
| `Mochizuki_Etale_Theta_2009_author.pdf` | `https://www.kurims.kyoto-u.ac.jp/~motizuki/The%20Etale%20Theta%20Function%20and%20its%20Frobenioid-theoretic%20Manifestations.pdf` | Author PDF of the 2009 article; graph quotient PDF11; the field ddot-k PDF16; Proposition 1.4 PDF20--21; Definition 1.9 and Theorem 1.10 PDF27--28; section 2 definitions/Proposition 2.2 PDF32--36 | `42c5d9180c69bc9fa6596ce1a11662494315954ed74301060bf1819f955a7406` |
| `Takeuchi_1983_Arithmetic_1e_JMSJ.pdf` | `https://www.jstage.jst.go.jp/article/jmath1948/35/3/35_3_381/_pdf/-char/en` | Journal of the Mathematical Society of Japan 35 (1983), 381--407; Theorem 4.1(i), published392/PDF12 | `6c4f44cf6abc2b75d5433f594d2d9b1d4407a3fea934c5149c13fb62d2f6223f` |
| `Sijsling_1707.01158v2_2017.pdf` | `https://arxiv.org/pdf/1707.01158v2` | arXiv v2, 2017-07-06; section 3.1 Table4, PDF11, visually checked; later published in Contemporary Mathematics 722 (2019) | `b483753b248795227de800c9f004cbcf077c502092140d3ac4c1e84b6b7df60f` |

The two Mochizuki source PDFs have respectively 34 and 112 author-PDF
pages; Takeuchi has 27 journal-PDF pages and Sijsling 19 pages.
The local text extractions and page images in
`tmp/iut_native_pilot_2026_08_30/` are disposable reading aids; the
hashed PDF originals are the source of record. No shared source
manifest, paper main file, Lean aggregate import, or frozen verification
artifact is changed by this note.
