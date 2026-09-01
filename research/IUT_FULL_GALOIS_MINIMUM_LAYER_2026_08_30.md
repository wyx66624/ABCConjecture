# A full local Galois lift reaching a native minimum layer

Author: ChatGPT  
Research date: 2026-08-30  
Status: local mathematical proofs independently reviewed; no new Lean claim in this report.

## 1. Result and scope

Put
\[
 p=19,\qquad K_0=\mathbf Q_{19}(\mu _5),\qquad
 E=K_0(\varpi),\qquad \varpi^5=19.
\]
Use the native valuation \(v(19)=1\), and put
\[
 I=19^{-1}\log\mathcal O_E^\times=\varpi^{-4}\mathcal O_E,\qquad
 u={\log(20)\over19},\qquad
 \tau={\log(1+19\varpi)\over19},\qquad t={\tau\over19}.
\]
The main result below constructs an automorphism of the **full absolute
Galois group** \(G_E\) whose canonical action \(M\) on \(E^+\) satisfies
\[
                 v(Mu)=v(Mt)=-4/5.                         \tag{1.1}
\]
The same valuation statement holds for a source-admissible integral
Kummer transport: one uses the inverse Galois automorphism and accounts
for the unit in the integral local Tate pairing. The conversion is proved
in Section 7; the covariance directions are not silently identified.

This removes the full-\(\operatorname{Aut}_{\mathbf Z_p}(I)\) hypothesis
from a particular, explicitly defined, repeated-label local hull
calculation. In particular, it proves a concrete failure of preservation
of the native sublattice \(\mathcal O_E\) by all bare local Galois
automorphisms. It does **not** prove that every integral linear map is
Galois-induced.

The result uses one native local root \(\tau\). It does not identify
\(\tau\) with the \(j^2\)-scaled source families in Joshi III, establish
global initial theta data, prove a Frobenius hull comparison, or prove
any version of ABC. The distinction between a local representative of
an Ind1 arrow and a compatible global family is retained in Section 10.

## 2. Primary sources and exact version boundary

All page numbers below refer to the archived PDF unless a printed page
number is also given. The three PDFs are in
[sources/galois_lift_2026_08_30](sources/galois_lift_2026_08_30/).

1. U. Jannsen and K. Wingberg, *Die Struktur der absoluten Galoisgruppe
   p-adischer Zahlkörper*, Inventiones Mathematicae 70 (1982), 71–98.
   [Original repository PDF](https://epub.uni-regensburg.de/26689/1/jannsen17.pdf).
   Archive: Jannsen_Wingberg_1982_Inventiones.pdf.
   SHA256:
   54b303960baa182f4b7770b734e90da8d8ae48dde1708736af87bc100ea9f048.
   PDF p.1/printed p.71 states the wild pro-\(p\) condition and the
   two relations; PDF p.4/printed p.74 defines the relative free
   operator-pro-\(p\) object and the commutator convention;
   PDF p.5/printed p.75, Theorem 2, gives the Galois presentation;
   PDF p.6/printed p.76, Section 1.4(a), specializes to an algebraic
   closure and explicitly retains the wild pro-\(p\) condition.

2. Y. Hoshi and Y. Nishio, *On the outer automorphism groups of the
   absolute Galois groups of mixed-characteristic local fields*,
   author version June 2022; published in Research in Number Theory
   8 (2022), article 56.
   [Author PDF](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1931revised.pdf).
   Archive: Hoshi_Nishio_2022_revised.pdf.
   SHA256:
   3789ba5014602506073c82889aa27bb9c9e7e22e763f0905c087cb2713cf497c.
   PDF pp.3–4 defines the principal-unit image and its additive
   perfection; p.4, Proposition 1.1, gives the word with \(g,h\);
   p.5, Lemma 1.3, proves a \(\mathbf Q_p\)-basis assertion and explains
   integral generation by \(y_0,\ldots,y_d\).
   PDF pp.7–8, Lemma 2.3, proves exact norm and trace compatibility
   of the canonical action. Their log shell uses \(1/(2p)\);
   since \(p=19\), this changes our lattice by a unit only.

3. K. Kondo, *Anabelian aspects of the outer automorphism groups of the
   absolute Galois groups of mixed-characteristic local fields*,
   arXiv:2512.09231v2, submitted 2025-12-12.
   [Version-pinned PDF](https://arxiv.org/pdf/2512.09231v2).
   Archive: Kondo_2512.09231v2_Dec2025.pdf.
   SHA256:
   376d2f3cf6df8ca944a6158349a3ccd50906b424537a84aaa512d1b42e0801bd.
   PDF p.8, Theorem 1.1, records the parity-dependent presentation;
   pp.8–10, Theorem 1.3, identifies the trace kernel;
   p.9 gives the adjacent-handle twist used to obtain the construction
   below; p.11, Lemma 1.5, treats \(x_2\mapsto x_2x_1\) in even degree.
   PDF p.12, Remark 1.10, records a remaining distinguished-vector
   problem in odd degree. PDF pp.19–20 explains full Galois lifts of
   boundary-preserving free-handle automorphisms.

The trace-kernel theorem and the basic Dehn twists are prior results,
not new claims of this report. The additional steps here are the
integral-basis upgrade in our tame range, a cross-handle lift fixing
\(x_1\), and the simultaneous valuation calculation for specified
vectors. No assertion of priority is made.

## 3. The relative full-Galois presentation

Let \(p>2\) and let \(E/\mathbf Q_p\) have even degree \(d\).
Write \(\mathfrak T=\operatorname{Gal}(E^{\rm tame}/E)\), with generators
\(\sigma,\theta\) satisfying
\[
                 \sigma\theta\sigma^{-1}=\theta^{p^f}.
                                                               \tag{3.1}
\]
Here \(\theta\) denotes the tame generator; it is unrelated to the
logarithmic vector \(\tau\) in Section 1.

One first takes the free profinite product of \(\mathfrak T\) and
a free profinite group on \(x_0,\ldots,x_d\).
Let \(Z\) be the closed normal subgroup generated by these \(x_i\);
quotient by the characteristic kernel of the maximal pro-\(p\)
quotient of \(Z\). This is the relative free operator-pro-\(p\)
object in JW Section 1.2. One then imposes the further relation
\[
 \sigma x_0\sigma^{-1}
   =W(x_0,\theta)\,x_1^{p^s}
      [x_1,x_2][x_3,x_4]\cdots[x_{d-1},x_d].                \tag{3.2}
\]
The right-hand factor \(W\) belongs to the closed subgroup generated by
\(x_0,\theta\). With the choices recorded in Hoshi–Nishio
Proposition 1.1 it can be written
\[
 W=\left(x_0^{h^{p-1}}\theta x_0^{h^{p-2}}\theta
                 \cdots x_0^h\theta\right)^{
                          \epsilon_p g/(p-1)},             \tag{3.3}
\]
where \(\epsilon_p\in\widehat{\mathbf Z}\) is the projector to
\(\mathbf Z_p\). The integers \(g,h\) lift the actions of the tame
generators on the \(p\)-power roots of unity in \(E^{\rm tame}\);
these roots have order \(p^s\). The exact lift choices will not matter.

The convention, visually verified on original JW PDF p.4, is
\[
                         [x,y]=xyx^{-1}y^{-1}.              \tag{3.4}
\]
All words and inverse calculations below use this convention.

There is no odd-degree special word \([x_1,x_1']\) in (3.2).
The extra odd-degree conditions and exceptional modifications discussed
by JW do not enter our even-degree application. In particular the
example has \(p=19,f=2,d=10\), which is permitted by the even branch.
Its tame root group has order \(19\), so \(s=1\): a \(19^2\)-th root of
unity would introduce ramification divisible by \(19\), whereas a
tame extension of a field of ramification degree \(5\) cannot do so.
The reduction of \(h\) modulo \(19\) has order \(18\); \(g\) is a unit
modulo \(19\). No numerical value of \(g\), and no choice of primitive
generator for \(h\), is used.

**Full-lift criterion.** A free-group automorphism of
\(x_1,\ldots,x_d\), extended to fix \(\sigma,\theta,x_0\), descends
to an automorphism of \(G_E\) if it fixes \(x_1\) and the ordered
commutator product in (3.2) exactly.

**Proof.** The free-word substitution and its inverse extend
continuously to the free profinite product. Both preserve \(Z\).
Hence both preserve its characteristic maximal-pro-\(p\) kernel,
and descend to the relative object. They preserve (3.1), the word
\(W\), and \(x_1^{p^s}\), and fix the remaining commutator product.
Thus they preserve the closed normal subgroup generated by the
remaining relator. Their compositions on every generator are the
identity, so the induced maps on the full quotient are inverse
continuous automorphisms. This argument does not replace \(G_E\)
by its maximal pro-\(p\) quotient. \(\square\)

## 4. A cross-handle automorphism with an explicit inverse

Work first in the free group on \(a,b,c,d_0\), and write
\[
 \delta=[a,b][c,d_0],\qquad
 r=bab^{-1},\qquad z=d_0rd_0^{-1}.
\]
The subscript on \(d_0\) distinguishes this generator from the field
degree. Define
\[
 \begin{array}{ll}
 F(a)=a,& F(b)=d_0b,\\
 F(c)=zr^{-1}cz^{-1},&
 F(d_0)=zd_0z^{-1}.                                      \tag{4.1}
 \end{array}
\]
Then \(F(r)=z\). Its inverse is
\[
 \begin{array}{ll}
 G(a)=a,&G(b)=r^{-1}d_0^{-1}rb,\\
 G(c)=r^{-1}d_0^{-1}rd_0cr,&
 G(d_0)=r^{-1}d_0r.                                      \tag{4.2}
 \end{array}
\]
To check the inverse, put
\[
 D=r^{-1}d_0r,\qquad s=D^{-1}rD.
\]
Then \(G(b)=D^{-1}b\), \(G(r)=s\), \(G(z)=r\), and
\(G(c)=sr^{-1}cr\). These identities immediately give
\(G(F(a))=a,\ G(F(b))=b,\ G(F(c))=c,\ G(F(d_0))=d_0\).
Conversely \(F(D)=d_0\) and \(F(s)=r\), so substitution in (4.2)
gives \(F(G(a))=a,\ F(G(b))=b,\ F(G(c))=c,\ F(G(d_0))=d_0\).

The boundary word is fixed exactly. Indeed,
\[
 \begin{split}
 F([a,b])&=a d_0r^{-1}d_0^{-1},\\
 F([c,d_0])&=zr^{-1}c d_0c^{-1}r d_0^{-1}z^{-1}.
 \end{split}
\]
Since \(z=d_0rd_0^{-1}\), multiplication and cancellation give
\[
 F(\delta)
 =a r^{-1}c d_0c^{-1}d_0^{-1}
 =[a,b][c,d_0]=\delta.                                   \tag{4.3}
\]
Thus the inverse fixes \(\delta\) as well.

On the abelianization this automorphism is
\[
 a\longmapsto a,\qquad b\longmapsto b+d_0,\qquad
 c\longmapsto c-a,\qquad d_0\longmapsto d_0.                \tag{4.4}
\]
Take \(a=x_1,b=x_2,c=x_3,d_0=x_4\) in (3.2), and fix the other
generators. The criterion of Section 3 now gives a full Galois
automorphism. In particular, the power \(x_1^{p^s}\) is fixed,
not merely its image in a class-two or pro-\(p\) quotient.

For comparison with the source, (4.1) was obtained from Kondo's
adjacent-handle twist. Here is a reproducible factorization.
Let \(k=b^{-1}cd_0c^{-1}\), \(\varepsilon=[c,d_0]\), and define
\[
 \begin{array}{ll}
 C(a)=ak,&C(b)=k^{-1}bk,\\
 C(c)=k^{-1}c,&C(d_0)=d_0,\\[2pt]
 S(a)=c,\quad S(b)=d_0,&
 S(c)=\varepsilon^{-1}a\varepsilon,\quad
 S(d_0)=\varepsilon^{-1}b\varepsilon,\\[2pt]
 R(a)=a,\quad R(b)=b,&
 R(c)=d_0^{-1},\quad R(d_0)=d_0cd_0^{-1}.
 \end{array}
\]
Also let \(T_a(b)=ba\) and \(T_d(c)=cd_0^{-1}\), with their other
generators fixed. With compositions acting right to left, set
\[
 P=R\circ S,\qquad A=P^{-1}\circ C\circ P,\qquad
 F=A\circ T_a^{-1}\circ T_d^{-1}.                         \tag{4.5}
\]
This reduces to (4.1). All these are free-group automorphisms
fixing \(\delta\), but intermediate maps \(C,S,R,P\) need not
fix \(a\), and are not individually being asserted to descend
to the same full Galois presentation.

The exact reduced-word checker
[check_cross_handle_words.py](../tmp/iut_admissible_2026_08_30/check_cross_handle_words.py)
checks both inverses, both boundary identities, and the
abelianization for every map in (4.5). It also prints the reduced
words (4.1). It is an auxiliary computational check, not a
replacement for the proof above or a Lean certificate.

## 5. The logarithmic JW basis is integral in the tame range

Suppose \(2\leq e(E/\mathbf Q_p)\leq p-2\).
Then the logarithm and exponential are inverse on
\(1+\mathfrak m_E\) and \(\mathfrak m_E\), because
\[
                  1/e>1/(p-1).
\]
In particular there is no nontrivial \(p\)-power torsion in
\(1+\mathfrak m_E\), and
\[
 L=\log\mathcal O_E^\times=\mathfrak m_E,\qquad I=L/p.
                                                               \tag{5.1}
\]

Let \(y_i\in L\) be the logarithm of the image of \(x_i\) under
local reciprocity. Hoshi–Nishio Lemma 1.3 states that
\(y_1,\ldots,y_d\) are a \(\mathbf Q_p\)-basis of \(E\);
its proof also shows that \(y_0,\ldots,y_d\) generate \(L\)
as a \(\mathbf Z_p\)-module.
We now verify the extra integral step instead of attributing
it to that lemma.

The reduction of the tame cyclotomic character is nontrivial
on inertia in this range. Otherwise adjoining \(\mu_p\) would
be unramified over \(E\), forcing its absolute ramification
degree \(p-1\) to divide \(e(E/\mathbf Q_p)\), which is impossible.
Thus the reduction of the \(h\) in (3.3) is different from \(1\).
It follows that
\[
        \sum_{r=1}^{p-1}h^r\equiv0\pmod p.
\]
The tame relation kills the image of \(\theta\) in the
torsion-free abelianization. Abelianizing (3.2)–(3.3) and
then taking logarithms gives
\[
 \left(1-\frac{g}{p-1}\sum_{r=1}^{p-1}h^r\right)y_0
                      =p^s y_1.                           \tag{5.2}
\]
The parenthesized coefficient belongs to
\(\mathbf Z_p^\times\): its reduction is \(1\).
Consequently \(y_0\in\mathbf Z_p y_1\). Therefore
\(y_1,\ldots,y_d\) already generate \(L\) integrally.
Their known \(\mathbf Q_p\)-independence makes them a
\(\mathbf Z_p\)-basis of \(L\). Thus
\[
                         v_i=y_i/p\quad(1\leq i\leq d)
                                                               \tag{5.3}
\]
is a \(\mathbf Z_p\)-basis of \(I\).

For even degree, Kondo Theorem 1.3 gives
\[
 \ker\operatorname{Tr}_{E/\mathbf Q_p}
      =\langle v_1,v_3,\ldots,v_d\rangle_{\mathbf Q_p}.       \tag{5.4}
\]
Here one can also recover the vanishing traces directly from
Hoshi–Nishio's exact trace compatibility: the full lift
\(x_2\mapsto x_2x_1\) forces \(\operatorname{Tr}v_1=0\).
The two boundary-preserving twists in each free handle force
\(\operatorname{Tr}v_i=0\) for \(i\geq3\).
Since (5.3) is integral, (5.4) implies
\[
 I\cap\ker\operatorname{Tr}
                  =\mathbf Z_pv_1\oplus
                    W_0,\qquad
 W_0=\bigoplus_{i=3}^d\mathbf Z_pv_i.                       \tag{5.5}
\]
Whenever \(\operatorname{Tr}I=\mathbf Z_p\), it follows also
that \(\operatorname{Tr}v_2\in\mathbf Z_p^\times\).

## 6. A simultaneous minimum-layer lemma using actual lifts

Assume the even-degree integral basis of Section 5, with \(d\geq4\),
and suppose
\[
 \operatorname{Tr}I=\operatorname{Tr}(\varpi I)=\mathbf Z_p.
                                                               \tag{6.1}
\]
Let \(u_0,t_0\in I\) satisfy
\[
 \begin{split}
 &u_0\in\varpi I,\qquad
       \operatorname{Tr}u_0\in\mathbf Z_p^\times,\\
 &t_0\notin\varpi I,\qquad
       \operatorname{Tr}t_0\in p\mathbf Z_p.               \tag{6.2}
 \end{split}
\]
Then some full Galois automorphism has a canonical action \(M\)
satisfying
\[
                        Mu_0,Mt_0\in I\setminus\varpi I.
                                                               \tag{6.3}
\]

**Proof.** Let \(B_u,B_t\in\mathbf Z_p\) be the respective
\(v_2\)-coordinates of \(u_0,t_0\). By (5.4) and (6.1),
\[
                  B_u\in\mathbf Z_p^\times,\qquad B_t\in p\mathbf Z_p.
                                                               \tag{6.4}
\]

If \(v_1\notin\varpi I\), use the full lift
\(x_2\mapsto x_2x_1\), fixing the other generators.
Its canonical action is
\[
                 Mu_0=u_0+B_uv_1,\qquad Mt_0=t_0+B_tv_1.
 \]
The first vector is outside \(\varpi I\), and the second remains
outside it because \(pI\subseteq\varpi I\).

It remains to treat \(v_1\in\varpi I\).
By (6.1), the reduction map
\[
                I\cap\ker\operatorname{Tr}
                          \longrightarrow I/\varpi I
                                                               \tag{6.5}
\]
is surjective: subtract from a representative any element of
\(\varpi I\) with the same trace. By (5.5), some \(v_j\), \(j\geq3\),
has nonzero image in \(I/\varpi I\); otherwise the image of the
entire trace kernel would be zero.
Put \(w=v_j\).

There is a full Galois lift, fixing \(x_1,x_2\), whose action
on \(W_0\) sends \(v_4\) to \(w\). No assertion about the
whole symplectic group is needed. Adjacent free handles can be
interchanged by the map \(S\) in Section 4, now applied only
to generators \(x_3,\ldots,x_d\). Within a free handle the map
\[
                  c\mapsto d_0^{-1},\qquad
                  d_0\mapsto d_0cd_0^{-1}
 \]
sends the second homology vector to the first.
Compositions of these maps send \(v_4\) to any chosen free-handle
basis vector. Each fixes the ordered free-handle boundary
word exactly and fixes \(x_1\), so the full-lift criterion applies.

Conjugating (4.4) by such a lift gives an actual action \(M_w\)
with
\[
 \begin{split}
 &M_w(v_1)=v_1,\qquad M_w(v_2)=v_2+w,\\
 &(M_w-\operatorname{id})(W_0)\subseteq\mathbf Z_pv_1.
                                                               \tag{6.6}
 \end{split}
\]
The last integrality statement follows because the conjugating
maps and their inverses act by integral matrices on the basis
\(v_3,\ldots,v_d\).
Consequently, for some \(A_u,A_t\in\mathbf Z_p\),
\[
 \begin{split}
 M_wu_0-u_0&=B_uw+A_uv_1,\\
 M_wt_0-t_0&=B_tw+A_tv_1.
 \end{split}
\]
Modulo \(\varpi I\), the first resulting vector is the nonzero
class \(B_uw\), and the second is the nonzero class of \(t_0\).
This proves (6.3). The same automorphism is used for both
vectors. \(\square\)

## 7. Canonical covariance, Kummer contravariance, and Ind1

For an automorphism \(\alpha:G_E\to G_E\), let \(M_\alpha\)
denote the canonical covariant action obtained from its action
on the image of wild inertia in \(G_E^{\rm ab}\), followed by
logarithm and perfection. Hoshi–Nishio's diagrams identify
this with the action used on the \(y_i\) above.

In contrast, integral Kummer transport uses pullback of
cohomology and an equivariant integral Tate-module
isomorphism. Such an isomorphism exists because the
cyclotomic character is preserved by an isomorphism of
local absolute Galois groups; its choices differ by
\(\mathbf Z_p^\times\).
For the original group-theoretic cyclotomic statement see
Mochizuki, *A Version of the Grothendieck Conjecture for
p-adic Local Fields* (1997), Proposition 1.1, PDF p.3:
[author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/A%20Version%20of%20the%20Grothendieck%20Conjecture%20for%20p-adic%20Local%20Fields.pdf).
The exact integral cup-product conventions and the
torsion-free unit passage are also recorded in Section 4
of
[the preceding admissibility audit](IUT_ADMISSIBLE_GALOIS_UNIFORM_GATE_2026_08_30.md).
Let \(F_\alpha\) be one resulting Kummer transport.
The integral invariant map identifies
\(H^2(G_E,\mathbf Z_p(1))\) with \(\mathbf Z_p\).
The induced automorphism of this rank-one integral module
is multiplication by a unit \(c_\alpha\).

For \(\lambda\in H^1(G_E,\mathbf Z_p)\) and a Kummer class
\(z\), naturality of cup product gives
\[
 \langle\lambda\circ\alpha^{\rm ab},F_\alpha z\rangle
                       =c_\alpha\langle\lambda,z\rangle.
                                                               \tag{7.1}
\]
Under reciprocity, the pairing is evaluation of the continuous
character \(\lambda\) on the pro-\(p\) completion of \(E^\times\).
After taking torsion-free unit classes and logarithms,
these characters separate the vector space. Hence
\[
                         F_\alpha=c_\alpha M_\alpha^{-1}.
                                                               \tag{7.2}
\]
In particular, to realize the valuations of \(M_\alpha\) in
Section 6 by Kummer transport, use the group arrow
\(\alpha^{-1}\), not \(\alpha\). Multiplication by the
remaining unit does not change the native valuation.
This also shows that all the transports used preserve \(I\).

The earlier source audit
[IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md](IUT_PROCESSION_ADMISSIBILITY_CONTINUATION_2026_08_30.md)
records why the bare local Galois representatives in the
procession output permit such outer automorphisms.
The exact source locations are Mochizuki I Section 0, printed
pp.33–34; Definition 4.1, p.96; Definition 4.10, p.120;
Proposition 6.9, pp.169–170; and Mochizuki III pp.153–154
for Ind1 on the output data. The covariance conversion (7.2)
is an additional check, not an identification of a full
polymorphism with a unique outer automorphism.

We do not assert that this representative extends to a
strictly Belyi-marked curve automorphism, nor that arbitrary
representatives selected at separate local labels form a
compatible global family. The present construction uses one
fixed local carrier \(E\), and one and the same automorphism
for every repeated occurrence of that carrier.

## 8. Verification for the degree-ten field

The order of \(19\) modulo \(5\) is \(2\), so
\(K_0/\mathbf Q_{19}\) is unramified of degree \(2\).
The polynomial \(X^5-19\) is Eisenstein over \(K_0\),
and \(K_0\) contains all fifth roots of unity.
Thus \(E/K_0\) is totally ramified cyclic of degree \(5\),
and \(E/\mathbf Q_{19}\) is the splitting field of \(X^5-19\).
It is Galois of degree \(10\), with ramification index \(5\)
and residue degree \(2\).

The integral power basis over \(\mathcal O_{K_0}\) gives
\[
 I=\varpi^{-4}\mathcal O_E
     =\bigoplus_{r=-4}^{0}\mathcal O_{K_0}\varpi^r.
                                                               \tag{8.1}
\]
For \(-4\leq r\leq-1\),
\(\operatorname{Tr}_{E/K_0}(\varpi^r)=0\), while
\(\operatorname{Tr}_{E/K_0}(1)=5\). It follows that
\(\operatorname{Tr}_{E/\mathbf Q_{19}}I=\mathbf Z_{19}\).
Furthermore \(1/10\in\mathcal O_E\subseteq\varpi I\) has
absolute trace \(1\). Thus (6.1) holds. This explicit
calculation avoids needing an unproved discriminant or
inverse-different identification.

The logarithm of a point in \(1+\mathfrak m_E\) has the
valuation of its first term in our tame range. Hence
\[
 v(u)=0,\qquad v(\tau)=1/5,\qquad v(t)=-4/5.
                                                               \tag{8.2}
\]
Since \(\varpi I\) has native depth \(-3/5\), we have
\[
                 u\in\varpi I,\qquad t\in I\setminus\varpi I.
 \]
Also \(u\in\mathbf Z_{19}^\times\) and
\(\operatorname{Tr}u=10u\in\mathbf Z_{19}^\times\).

For the other trace, the norm identity is exact:
\[
 \operatorname{Nm}_{E/K_0}(1+19\varpi)
   =\prod_{\zeta\in\mu_5}(1+19\zeta\varpi)=1+19^6.
 \]
Compatibility of logarithm with norm and trace gives
\[
 \operatorname{Tr}_{E/\mathbf Q_{19}}(t)
                ={2\over19^2}\log(1+19^6).                 \tag{8.3}
\]
The right-hand side has \(19\)-adic valuation \(4\), so
\(\operatorname{Tr}t\in19^4\mathbf Z_{19}^\times\).
In the integral JW basis this means more precisely
\[
 B_u\in\mathbf Z_{19}^\times,\qquad
 B_t\in19^4\mathbf Z_{19}^\times.
 \]
All hypotheses of Section 6 are verified, proving (1.1).

Every field automorphism of \(E\) preserves native valuations.
Since \(v(u)=0\) but \(v(Mu)=-4/5\), the resulting full
Galois outer automorphism is not field-induced.
This conclusion concerns a specified vector and its
valuation; it is stronger than inferring non-geometricity
merely from a failure of a Hodge–Tate property.

## 9. Exact native repeated-label \(B\)-hull

Fix a positive integer \(m\). Put
\[
 T_m=E^{\otimes_{\mathbf Q_{19}}m},\qquad
 B_m=\prod_{\operatorname{Gal}(E/\mathbf Q_{19})^{m-1}}
                         \mathcal O_E.
 \]
We identify \(T_m\) with the corresponding product of copies
of \(E\) by
\[
 x_1\otimes\cdots\otimes x_m
       \longmapsto
       \big(x_1\sigma_2(x_2)\cdots\sigma_m(x_m)\big)_
                                     {(\sigma_2,\ldots,\sigma_m)}.
                                                               \tag{9.1}
\]
Thus \(B_m\) is the maximal integral order in the fixed
finite étale carrier. In the expression
\(\varpi^r B_m\), \(\varpi\) means its image from the first
tensor factor, which has valuation \(1/5\) in every component.

Let \(\Gamma\) be the set of integral Kummer transports
arising from automorphisms of this same \(G_E\), and set
\[
 \begin{split}
 S_m&=\{F(\tau)\otimes F(u)\otimes\cdots\otimes F(u):
                                              F\in\Gamma\},\\
 H_m&=\operatorname{span}_{B_m}(S_m).
 \end{split}
\]
There is only one \(F\) in each displayed tensor:
the occurrences of the local carrier have coherent repeated
markings. Then
\[
                         H_m=\varpi^{\,5-4m}B_m.           \tag{9.2}
\]
The same statement holds for the topological closure of
the indicated span.

**Proof.** Every \(F\) preserves \(I\), is
\(\mathbf Q_{19}\)-linear, and satisfies
\(F(\tau)=19F(t)\). In each field component of (9.1),
the native valuation of a tensor generator is at least
\[
                   (1-4/5)+(m-1)(-4/5)=1-4m/5.
 \]
Field embeddings preserve this valuation. Consequently
\(H_m\subseteq\varpi^{5-4m}B_m\).

By Sections 7–8 some single \(F\in\Gamma\) has
\(v(Fu)=v(Ft)=-4/5\). Its tensor generator has valuation
exactly \(1-4m/5\) in **every** component. It is therefore
\(\varpi^{5-4m}\) times a unit of \(B_m\), and its
principal \(B_m\)-span is all of
\(\varpi^{5-4m}B_m\). This proves the reverse inclusion.
The resulting fractional product lattice is compact and
closed, proving the assertion about closure. \(\square\)

**Stability under an intermediate product convex hull.**
Let
\[
 P_m=\{(F\tau,Fu,\ldots,Fu):F\in\Gamma\}
       \subseteq 19I\times I^{m-1},
\]
and let \(C_m\) be any set with
\[
                 P_m\subseteq C_m\subseteq19I\times I^{m-1}.
\]
Then the \(B_m\)-span of the tensors formed from tuples
in \(C_m\) is still (9.2). The upper containment follows
from the same componentwise valuation bound; the original
attaining tuple in \(P_m\) proves the reverse containment.
In particular this applies to the closed
\(\mathbf Z_{19}\)-convex hull of \(P_m\) in the product:
the containing product lattice is itself closed and
\(\mathbf Z_{19}\)-convex. The assertion is about these
specified native product inputs; it does not identify
an unrelated source family with \(P_m\).

For the native length-three tensor this gives
\[
                         H_3=\varpi^{-7}B_3.               \tag{9.3}
\]
This is a positive exact reachability computation, not a
claim that a particular global theta container is violated.
It uses the actual \(B_m\)-module hull, and does not
replace a \(\mathbf Z_{19}\)-convex hull by that module hull.
It also does not identify normalization relative to the
tensor order with normalization relative to \(B_m\).

## 10. What is resolved and what remains

The full-Galois lift and the native simultaneous minimum
layer have been established for the specified degree-ten
local example. The earlier abstract use of the full
integral linear group is unnecessary for this example.
The source-sensitive improvement is the explicit word
automorphism preserving the tame/wild presentation and
the distinguished power \(x_1^{p^s}\), together with the
integral-basis and trace-coordinate calculation.

The odd-degree field
\(\mathbf Q_{11}(11^{1/5})\) remains a separate case.
The integral-basis argument still applies, but the odd
presentation has a special \([x_1,x_1']\) term.
Its free-handle twists act on a trace-zero subspace
while fixing \(y_1\). Kondo Remark 1.10 explicitly records
the absence, in that argument, of an automorphism known
to move the distinguished \(y_1\). We have neither produced
the required odd-degree full lift nor proved it impossible.

The actual \(j^2\)-labeled source family has not been
collapsed to \(S_m\). For example, replacing \(\tau\) by
\(\log(1+19\varpi^4)/19\) changes its native depth and
its trace depth. The minimum-layer hypothesis (6.2)
for its normalized vector must be checked anew;
it is not supplied by the present proof.
Nor does (9.2) supply the cross-Frobenius equality, the
global product weights, or the same-set hypothesis
needed to compare Joshi IV's upper bound with a
native lower bound.

No unconditional ABC statement or IUT global estimate
is derived here. These local successes do not justify
discarding any whole route.

## 11. Verification and formalization boundary

The mathematical proof precedes any proposed Lean work.
The auxiliary reduced-word checker has been executed
successfully, with exact integer words and no numerical
tolerance. Original JW p.4 was also rendered and visually
checked against the commutator convention used in (4.1).

The new integral-basis, local class field, Galois-presentation,
and native tensor-hull arguments are **not yet formalized
in Lean**. No previously certified theorem count or frozen
validation snapshot is changed by this report.

The complete mathematical statement has now received
independent review:

- [The free-group/full-quotient review](JW_CROSS_HANDLE_AUTOMORPHISM_CROSS_REVIEW_2026_08_30.md)
  checks the two-sided word inverses, exact boundary
  fixing, preservation of the relative pro-\(p\) kernel
  and full relator, and the abelianized cross action.
  Its final review was checked against the actual words
  (4.1)–(4.2) in this report.
- [The local-arithmetic review](IUT_MINIMUM_LAYER_ARITHMETIC_CROSS_REVIEW_2026_08_30.md),
  Section 7, checks the complete Sections 1–11, including
  the integral basis, the simultaneous minimum layer,
  the inverse/unit conversion, and the exact
  componentwise \(B_m\)-hull calculation.
- The coordinating agent separately checked the full
  proof, in particular the covariance direction in
  Section 7 and the common-set hypotheses in Section 9.

These reviews certify their stated mathematical scope;
they do not upgrade the local construction to global
initial theta data or to a Lean proof of local class
field theory.
