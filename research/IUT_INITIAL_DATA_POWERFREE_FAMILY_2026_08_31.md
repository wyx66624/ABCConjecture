# Initial theta data for the unbounded power-free Frey family

Author: ChatGPT. Date: 2026-08-31 (local date).

This note extends the mathematical construction in
`IUT_INITIAL_DATA_BALANCED43_AUDIT_2026_08_30.md` to every member of the
unbounded family proved in
`FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md`. The assertion is about
Mochizuki I, Definition 3.1(a)--(f), in the archived May 2020 original.
It uses neither an exceptional-set existence theorem nor an identification
of our chosen prime with the prime selected by such a theorem.

The result is a mathematical theorem with the explicitly cited classical
and source-theoretic dependencies below. It has not been formalized in
Lean. In particular it is not a proof of the later pilot comparison,
Ind3 bounds, a global theta inequality, or abc.

## 1. A general sufficient criterion

The conditions needed by the construction are independent of the
particular number 43. The following criterion isolates them.

**Theorem 1.1 (rational initial-data criterion).** Let \(D/\mathbb Q\)
be an elliptic curve and let \(\ell\ge7\) be a prime. Put

\[
 F=\mathbb Q(i,D[30]),\qquad
 K=F(D[\ell])=\mathbb Q(i,D[30\ell]),\qquad
 X_F=D_F\setminus\{O\},\qquad C_F=[X_F/\{\pm1\}].                 \tag{1.1}
\]

Assume the following four conditions.

1. The curve \(D_F\) has good or multiplicative reduction at every
   finite place of \(F\).
2. The image of \(G_F\) on \(D[\ell]\) contains
   \(\operatorname{SL}_2(\mathbb F_\ell)\).
3. There is a rational prime \(p_0>5\) with
   \(v_{p_0}(j(D))<0\).
4. A finite nonempty set \(S_0\) of odd rational primes, all different
   from \(\ell\), is specified. At every \(r\in S_0\), the curve
   \(D/\mathbb Q_r\) is split multiplicative, and, for each place
   \(w\mid r\) of \(F\), the positive integral Tate order
   \(\operatorname{ord}_w(q_w)\) is prime to \(\ell\).

For every line \(H\subset V=D[\ell](K)\) and every
\(0\ne\bar v\in V/H\), one can construct a single global orbicurve
\(\underline C_K\), a single global cusp \(\epsilon\), and a section
\(\mathbb V\subset V(K)\) of \(V(K)\to V(\mathbb Q)\), such that

\[
 (\overline F/F,X_F,\ell,\underline C_K,
                    \mathbb V,S_0,\epsilon)                         \tag{1.2}
\]

satisfies all of Mochizuki I, Definition 3.1(a)--(f). The global cover
and cusp depend on the one fixed pair \((H,\bar v)\); only the chosen
place above each \(r\in S_0\) is adjusted separately. The fields in
(1.1) are not enlarged.

Here and below the quotient by inversion is the stack quotient. The
assertions of finite etaleness are not assertions about coarse-space
ramification. The splitness assumption in item 4 is a convenient
sufficient hypothesis, not a claimed necessary condition for the source
definition.

### Proof of the arithmetic conditions (a)--(c)

The field \(F/\mathbb Q\) is Galois, contains \(i\) and the full
6-torsion, and satisfies

\[
 [F:\mathbb Q]\mid
 2\lvert\operatorname{GL}_2(\mathbb Z/30\mathbb Z)\rvert
 =276480=2^{11}3^3 5.                                                \tag{1.3}
\]

Consequently \(\ell\nmid[F:\mathbb Q]\). The original once-punctured
curve is defined over \(\mathbb Q\), so its field of moduli is exactly
\(F_{\rm mod}=\mathbb Q\). The full mod-\(\ell\) kernel over \(F\)
cuts out precisely \(K\), as required in Definition 3.1(c). The last
equality in (1.1) follows from the coprimality of 30 and \(\ell\).

Assumption 1 supplies stable reduction of the one-pointed curve: a
good elliptic model with its origin is stable, and a multiplicative
model contracts its unmarked two-valent components to the stable nodal
one-pointed model. Assumptions 2 and 4 give respectively the required
image, nonempty bad set, residue-characteristic, and Tate-order
conditions. The Tate-order condition here is over \(F\), as in the
definition. It is not imposed over \(K\), whose ramification may add
a factor \(\ell\).

### Proof of the core condition

The four geometric arithmetic once-punctured elliptic curves in
Takeuchi's classification have the following invariants, as listed in
Sijsling's Table 4:

\[
 \frac{2^{14}31^3}{5^3},\qquad
 \frac{2^2 73^3}{3^4},\qquad1728,\qquad0.                           \tag{1.4}
\]

Every entry is integral at every prime greater than 5. Assumption 3
therefore excludes all four. Arithmeticity is invariant under finite
etale commensurability, so the punctured hemi-elliptic quotient is
nonarithmetic too. Mochizuki, *Canonical Curves*, Proposition 2.7 gives
its core over an algebraic closure. Proposition 2.3(i)--(ii) of the same
paper transfers this statement through algebraically closed base
extension and descent. It follows that \(C_K\) is a \(K\)-core, and
also a core after passage to every completion. This argument uses the
specific four-class exclusion, not merely non-CM reduction behavior.

### Construction of the single global cover and cusp in (d)

For the fixed \(H\) take the quotient isogeny and its dual:

\[
 \phi:D_K\longrightarrow D_K/H,
 \qquad \psi:D_K/H\longrightarrow D_K,
 \qquad \psi\phi=[\ell].                                          \tag{1.5}
\]

All of \(V\) is rational over \(K\), so these maps and the exact
sequence

\[
 0\longrightarrow H\longrightarrow V
   \xrightarrow{\phi} Q:=\ker\psi\longrightarrow0                   \tag{1.6}
\]

are over \(K\). The group \(Q\cong V/H\) is constant cyclic of
order \(\ell\). Set

\[
 \underline X_K=(D_K/H)\setminus Q,
 \qquad \underline C_K=[\underline X_K/\{\pm1\}].                   \tag{1.7}
\]

The map \(\psi\) gives a cyclic finite etale degree-\(\ell\) cover
\(\underline X_K\to X_K\). It extends etale over the completed
elliptic curve, and every point in the fiber at the origin is
\(K\)-rational. Thus its fundamental-group quotient is trivial on
the **full** cusp decomposition group, is surjective on geometric
monodromy, and factors through the abelian elliptic quotient. These
are the quotient conditions immediately before EtTh Definition 2.1.

Equivariant descent under inversion gives the cartesian square with
lower arrow \(\underline C_K\to C_K\), finite etale as a morphism
of orbicurves. It is not in general a Galois cover. This is the source
type \((1,\ell\text{-tors})^\pm\). The core is \(C_K\), since
finite etale commensurable orbicurves have the same core. The nonzero
element \(\bar v\) gives a nonzero cusp in \(Q\), whose inversion
orbit is the one globally fixed \(\epsilon\).

### Simultaneous local interpretations through the place section

The following linear statement works for every \(\ell\), not only
43: \(\operatorname{SL}(V)\) acts transitively on the pairs
\((H,0\ne\bar v\in V/H)\). Given such a pair, lift \(\bar v\)
to \(v\). For a chosen nondegenerate alternating form, there is a
unique \(h\in H\) with \(\omega(h,v)=1\). The pair \((h,v)\)
is symplectic; the map between two such bases has determinant one
and carries the decorated quotients to one another.

For each \(r\in S_0\), start from any place \(w\mid r\) of \(K\).
Split Tate uniformization gives, in the global module \(V\), a
multiplicative line and a distinguished quotient class:

\[
 H_w=\mu_\ell,\qquad
 0\ne\bar v_w=[q_w^{1/\ell}]\in V/H_w.                            \tag{1.8}
\]

The notation uses the chosen Tate marking. Changing the root changes
it by \(\mu_\ell\); reversing the orientation changes the quotient
class by sign. All the torsion classes come from \(V\), since the
finite etale group \(D[\ell]\) is already split over \(K\).

For the action on valuations \((gw)(x)=w(g^{-1}x)\), the map of
completions \(g:K_w\to K_{gw}\) transports the Tate data. Hence

\[
 (H_{gw},\bar v_{gw})=g(H_w,\bar v_w)                               \tag{1.9}
\]

with compatible orientations, or modulo sign without choosing them.
The actual \(\operatorname{SL}_2(\mathbb F_\ell)\) in
\(\operatorname{Gal}(K/F)\)'s image supplies an element \(g_r\)
carrying (1.8) to the one previously fixed \((H,\bar v)\). Select
the place \(v_r=g_rw\).

At this place the isogenies (1.5) have the concrete Tate forms

\[
 \phi:E(q)\longrightarrow E(q^\ell),\quad[z]\longmapsto[z^\ell],
 \qquad
 \psi:E(q^\ell)\longrightarrow E(q),\quad[z]\longmapsto[z].          \tag{1.10}
\]

The kernel of \(\psi\) is generated by \([q]\), and
\(\phi([q^{1/\ell}])=[q]\). Therefore our cover is the degree-
\(\ell\) graph cover obtained from the natural infinite Tate
graph cover by the subgroup \(\ell\mathbb Z\subset\mathbb Z\).
Its chosen cusp is the generator modulo sign. This proves the exact
type \((1,\mathbb Z/\ell\mathbb Z)^\pm\) and the specified
\(\pm1\) cusp of Definition 3.1(e)--(f).

Choose an arbitrary place of \(K\) over every remaining rational
place, including infinity. Together with the finitely many \(v_r\)
these choices give \(\mathbb V\). Definition 3.1(e) requests a
section of the place map. It imposes no common-conjugating-element,
equivariance, continuity, or preassigned-section condition. Thus the
independent \(g_r\) are allowed, while the global pair, cover, and
cusp remain fixed. The surjectivity statement concerns actual finite
Galois elements, not arbitrary linear maps added to the source.

### The auxiliary theta and oriented covers

The argument for these covers is also uniform. EtTh Proposition 2.2
gives the canonical geometric inversion eigensubgroups for odd
\(\ell\). They give the double-underlined geometric covers in
Definition 3.1(d). The arithmetic splitting choices form the stated
torsor under \(H^1(G_k,\mu_\ell)=k^\times/(k^\times)^\ell\).
Part (e) requests the natural local models at selected bad places,
not one arithmetic splitting over \(K\) matching all local choices.

Let \(k=K_{v_r}\). It has odd residue characteristic prime to
\(\ell\), contains \(i\) and rational full 2-torsion, and the
curve is split multiplicative and nonarithmetic. If \(b_0^2=q\), its
Tate class is a rational 2-torsion point. Thus every Galois conjugate
satisfies \(\sigma(b_0)/b_0\in q^{\mathbb Z}\); valuation zero
forces the ratio to be one. Consequently

\[
 k=k(\mu_2,q^{1/2})=\ddot k,                                       \tag{1.11}
\]

as required by EtTh Definition 2.5. Rational \(D[3]\) and the Weil
pairing give \(\mu_3\subset F\), and \(i\in F\) gives
\(\mu_4\subset F\). Hence \(\mu_{12}\subset k\), including the
root-of-unity condition recalled in EtTh Remark 1.10.1(ii).
The rational \(\ell\)-torsion similarly gives \(\mu_\ell\subset k\).

The theta series of EtTh Proposition 1.4 has value \(2i\) plus terms
of positive valuation at the indicated point represented by \(i\).
It is a unit in odd residue characteristic. An allowed \(k\)-unit
multiple normalizes its value to one, giving the standard type of
Definition 1.9. Theorem 1.10(iii) supplies the compatible cuspidal
\(\{\pm1\}\)-structure. Its two representatives have the same
class in \(k^\times/(k^\times)^\ell\), since
\((-1)^\ell=-1\). Proposition 2.2 and Definition 2.5(i) therefore
give the required natural local theta models.

For the oriented covers in the last part of Definition 3.1(f),
Mochizuki I, section 1 requires \(\ell\ge5\), prime to 6, a
nonzero cusp, and trivial action on the mod-\(\ell\) abelianization
of the **original un-underlined** once-punctured curve. All hold:
in particular the last assertion follows from \(K=F(D[\ell])\).
No rationality claim for all \(\ell\)-torsion of \(D/H\), and no
adjoining of \(\ell^2\)-torsion, is needed. Definition 1.1 and
Remark 1.1.2 of that paper supply the oriented covers. This finishes
the proof of Theorem 1.1. \(\square\)

## 2. Application to every power-free CRT member

Let \(\ell\equiv43\pmod {60}\) be a sufficiently large prime, let
\(p\) be the least prime congruent to \(-1\pmod {30\ell}\), and
let \(A\) be **any** of the integers supplied by Theorem 1 of
`FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md`. Thus

\[
 \begin{gathered}
 A\equiv1\pmod2,\quad A\equiv1\pmod{5\ell},\quad
 A\equiv p\pmod{p^2},\\
 A,\ A^2+1,\ 2A^2+1\text{ are all }\ell\text{-power-free},\\
 D_A:y^2=x(x-A^2)(x+A^2+1),\qquad
 (a,b,c)=(A^2,A^2+1,2A^2+1).
 \end{gathered}                                                     \tag{2.1}
\]

Let \(S_A\) be the set of odd rational primes dividing \(abc\).
It is finite and contains \(p\).

**Theorem 2.1 (initial data throughout the unbounded family).** For
every such \((\ell,p,A)\), every nonempty \(S_0\subseteq S_A\),
every line \(H\subset D_A[\ell](K_A)\), and every nonzero
\(\bar v\in D_A[\ell](K_A)/H\), Theorem 1.1 supplies initial theta
data (1.2) with exactly

\[
 F_A=\mathbb Q(i,D_A[30]),\qquad
 K_A=F_A(D_A[\ell])=\mathbb Q(i,D_A[30\ell]).                       \tag{2.2}
\]

In particular one may take \(S_0=S_A\). No additional largeness
threshold is needed for the initial-data construction beyond the
threshold ensuring existence of the integers in (2.1).

**Proof.** We check each hypothesis of Theorem 1.1 and the numerical
statements that must not be copied literally from the isolated
level-43 example.

Put \(T_A=3A^4+3A^2+1\). The rational equation has

\[
 \Delta=16(abc)^2,\quad c_4=16T_A,\quad
 j(D_A)=\frac{256T_A^3}{(abc)^2},\quad\gcd(T_A,abc)=1.               \tag{2.3}
\]

At every odd \(r\mid abc\), unit \(c_4\) proves multiplicative
reduction and minimality. It is split: for \(r\mid A\) or
\(r\mid A^2+1\) the node has slopes \(\pm1\); for
\(r\mid2A^2+1\), translating the node at \(x=A^2\) gives slopes
\(\pm A\). All other odd primes are good. At 2, odd \(A\) gives
\(v_2(j(D_A))=6\). Over every completion of \(F_A\) at 2 the full
3-torsion is rational, so the good-reduction lemma proved in the
balanced43 audit, section 2.1, applies. Its proof uses the minimal
model over that actual finite extension of \(\mathbb Q_2\):
\(E_1\) has no 3-torsion; the additive quotient \(E_0/E_1\) has no
3-torsion; and an additive component group has at most four elements.
Rational full 3-torsion would inject a group of order nine into it.
Multiplicative reduction is excluded by integral \(j\), leaving good
reduction. Thus hypothesis 1 holds at every finite place.

The large-image assertion in the power-free family report proves
hypothesis 2 for every member. Its two inputs are uniform: at 5 the
Frobenius polynomial is \(T^2-2T+5\), with discriminant \(-16\)
nonsquare modulo \(\ell\equiv3\pmod4\); at \(p\) the positive
Tate order is 4, giving a nontrivial order-\(\ell\) transvection.
This element and its Frobenius conjugate have different fixed lines
and generate the elementary root groups. Their generated subgroup
contains \(\operatorname{SL}_2(\mathbb F_\ell)\). Passing to
\(F_A\) retains both order-\(\ell\) elements, since its Galois
degree divides (1.3) and is prime to \(\ell\).

The prescribed prime satisfies \(p\ge30\ell-1>5\). Since
\(v_p(A)=1\), (2.3) gives

\[
 v_p(q)=4,\qquad v_p(j(D_A))=-4.                                  \tag{2.4}
\]

Thus the same four-class exclusion proves hypothesis 3 for every
member; no separate exceptional subset of parameters is being
discarded for the core.

Finally \((a,b,c)\equiv(1,2,3)\pmod\ell\), so \(\ell\notin S_A\).
For a place \(w\mid r\) of \(F_A\), the positive integral Tate
order is

\[
 \operatorname{ord}_w(q_w)=
 \begin{cases}
 4e(w/r)v_r(A),&r\mid A,\\
 2e(w/r)v_r(A^2+1),&r\mid A^2+1,\\
 2e(w/r)v_r(2A^2+1),&r\mid2A^2+1.
 \end{cases}                                                       \tag{2.5}
\]

The alternatives are disjoint because the three relevant factors
are pairwise coprime. Each valuation displayed on the right is
between 1 and \(\ell-1\). The ramification index divides
\([F_A:\mathbb Q]\), which is prime to \(\ell\). Since \(\ell\)
is odd, no order in (2.5) is divisible by \(\ell\). This is
hypothesis 4 for every \(S_0\subseteq S_A\).

It would be incorrect to assert from these inputs that
\(0<v_r(abc)<\ell\) for all \(r\in S_A\): the factor \(a=A^2\)
need not itself be \(\ell\)-power-free. Formula (2.5), rather than
that unnecessary stronger bound, proves exactly the source's order
condition. Theorem 1.1 now applies without any new restriction on
the already constructed family. \(\square\)

## 3. What remains unchanged at the distinguished local place

The place section in Theorem 2.1 may be chosen with \(p\in S_0\),
in particular by taking all of \(S_A\). The completion is then still
the exact full level field computed in the family report. A change
from \(w\) to \(g_pw\) is a field isomorphism over the local base,
so it changes neither its isomorphism class nor its native valuation.

Writing \(b_0^2=q\) with \(b_0\in\mathbb Q_p\) and \(v_p(b_0)=2\),
put

\[
 N=30\ell,\quad e=15\ell,\quad
 K_0=\mathbb Q_p(\mu_N),\quad\varpi^e=b_0,\quad
 u_0=b_0/p^2,\quad\beta=\varpi^{(e+1)/2}/p.                        \tag{3.1}
\]

The field \(K_0\) is unramified quadratic, contains \(i\), and
contains \(\mu_e\). The identity

\[
 \beta^e=p\,u_0^{(e+1)/2},\qquad \varpi=u_0^{-1}\beta^2             \tag{3.2}
\]

shows directly that \(\beta\), not \(\varpi\), is a uniformizer.
Tate uniformization identifies

\[
 (K_A)_v\cong K_0(\beta),\qquad
 e((K_A)_v/\mathbb Q_p)=15\ell,\quad f=2,\quad d=30\ell.           \tag{3.3}
\]

The native root used for the local squared labels has valuation

\[
 v_p(q^{1/(2\ell)})=2/\ell,                                       \tag{3.4}
\]

not \(1/\ell\). No step of the initial-data construction replaces
the actual Tate unit by 1. Therefore the arithmetic input of the
general tame square-label theorem remains available after choosing
the source-compatible section, for these explicitly typed native
local inputs.

## 4. Quantifiers and source boundaries

The new conclusion has the order

\[
 \begin{gathered}
 \forall(\ell,p,A)\in\mathcal F\quad
 \forall S_0\in\mathcal P(S_A)\setminus\{\varnothing\}\quad
 \forall(H,\bar v)\in\mathcal D(V)\quad\exists\mathbb V:\\
 \text{Definition 3.1(a)--(f) holds}.
 \end{gathered}                                                     \tag{4.1}
\]

Here \(\mathcal F\) is the proved power-free family, and
\(\mathcal D(V)\) consists of the pairs of a line \(H\subset V\)
and a nonzero element of \(V/H\), with \(V=D_A[\ell](K_A)\).
The cover and cusp are fixed from \((H,\bar v)\) before the selected
places are chosen. They are single global objects for each curve;
there is no claim that one cover or one number field works for
distinct members of the family.

The earlier family theorem also gives one fixed compactly bounded
domain in Mochizuki's original finite-extension-section sense and
unbounded heights. Hence a finite set fixed before the family varies
is eventually avoided. This is a separate assertion: neither it nor
the present initial-data construction identifies our \(\ell\) with
an existential prime selected in Joshi IV, Theorem 5.7.1. Nor do we
silently replace the literal ambient algebraic-closure compactness
wording of that source by the original finite-extension definition.

The actual initial-data interface is now supplied throughout this
unbounded family. It is no longer appropriate to list its global
core, cyclic cover, fixed nonzero cusp, or allowed section of places
as unconstructed for these members. The further interfaces remain:

* the complete published pilot source versus the specified native
  squared-label source on which the local hulls were computed;
* standard Bloch--Kato logarithmic normalization versus the
  \(p^{-1}\log\) coordinate in every tensor factor;
* label-dependent absolute-value rescaling versus an algebraic
  \(j^2\)-power in one fixed native field;
* the precise family, order of hull operations, Ind3, and global
  Frobenius comparison needed for one and the same upper/lower
  measured set.

The attained local identity between the transported pre-ideal hull
and the point hull, proved separately by the sharp trace-dual
argument, is valid with its stated integral-arrow and native-carrier
hypotheses. This note does not remove those hypotheses by invoking
initial data. No implication to a closed Lean proof of abc or a
counterexample to abc is asserted.

## 5. Source locations and reproducibility

The original definition was reread from its local PDF while preparing
this generalization, including the precise place-section quantifier
and the different global/geometric and local/arithmetic covers.
All source PDFs are already archived; no new download or source
modification is required.

| Source and exact original URL | Local archived file | Locations used |
|---|---|---|
| Mochizuki, IUT I, May 2020 author version: `https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20I.pdf` | `research/sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf` | Definition 3.1(a)--(f), PDF61--63; original mod-ell condition, Definition 1.1 and Remark 1.1.2, PDF37--39; the independent-place interpretation is also consistent with Remark 3.1.3, PDF65 |
| Mochizuki, Canonical Curves, 2003: `https://www.kurims.kyoto-u.ac.jp/~motizuki/Canonical%20Liftings.pdf` | `research/sources/initial_data_2026_08_30/Mochizuki_Canonical_Curves_2003_author.pdf` | Remark 2.1.1 and Proposition 2.3, PDF9--10; Proposition 2.7, PDF14--15 |
| Mochizuki, Etale Theta, 2009: `https://www.kurims.kyoto-u.ac.jp/~motizuki/The%20Etale%20Theta%20Function%20and%20its%20Frobenioid-theoretic%20Manifestations.pdf` | `research/sources/initial_data_2026_08_30/Mochizuki_Etale_Theta_2009_author.pdf` | Graph quotient PDF11; ddot-field PDF16; Proposition 1.4 PDF20--21; Definition 1.9, Theorem 1.10(iii), Remark 1.10.1(ii), PDF27--28; quotient construction, Definition 2.1, Proposition 2.2, Definition 2.5, PDF32--36 |
| Takeuchi, 1983: `https://www.jstage.jst.go.jp/article/jmath1948/35/3/35_3_381/_pdf/-char/en` | `research/sources/initial_data_2026_08_30/Takeuchi_1983_Arithmetic_1e_JMSJ.pdf` | Theorem 4.1(i), printed392/PDF12 |
| Sijsling, `https://arxiv.org/pdf/1707.01158v2`, v2 of 2017-07-06 | `research/sources/initial_data_2026_08_30/Sijsling_1707.01158v2_2017.pdf` | Section 3.1, Table 4, PDF11 |
| Silverman, Arithmetic of Elliptic Curves, second edition 2009 | `research/sources/global_uniform_gate_2026_08_30/Silverman_2009_Arithmetic_of_Elliptic_Curves_2nd.pdf` | Chapter VII hypotheses printed185/PDF201; 2.1 printed188/PDF204; 3.1(a) printed192/PDF208; 5.1(c) printed196/PDF212; 6.1 printed200/PDF216 |

The hashes and archival details of these exact primary PDFs are
recorded in the balanced43 initial-data audit and its independent
cross-review. The parameter-uniform existence theorem and its
least-prime input remain in the separate power-free family report;
the present note does not reprove that sieve or import it as a Lean
axiom. The mathematical extension here is the uniform construction
of the remaining Definition 3.1 data.
