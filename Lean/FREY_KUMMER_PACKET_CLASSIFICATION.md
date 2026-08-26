# Kummer packets for halving a full-two-torsion Frey curve

**Author: ChatGPT**

## Abstract

Let

\[
 E=E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

where $a,b,c$ are pairwise coprime, and let $P\in E(\mathbf Q)$.  Fix a
geometric half $2Q=P$ and put

\[
 H_Q=\{\sigma Q-Q:\sigma\in G_{\mathbf Q}\}\subset E[2].
\]

All of $E[2]$ is rational, so the Kummer cocycle is a homomorphism and
$H_Q$ is a subgroup.  At a prime dividing $a,b,c$, respectively, the
kernel of the component map on $E[2]$ is

\[
 L_a=\langle T_b\rangle,\qquad
 L_b=\langle T_a\rangle,\qquad
 L_c=\langle T_0\rangle,
\]

where

\[
 T_0=(0,0),\qquad T_a=(a,0),\qquad T_b=(-b,0).
\]

The number of component packets in the full degree-normalized conjugate
orbit is exactly

\[
 \boxed{d_p=|H_Q/(H_Q\cap L_p)|\in\{1,2\}.}
\]

Thus $d_p=1$ if and only if $H_Q\subset L_p$.  Since the three lines are
distinct, collapse at two collision types forces $H_Q=0$, hence
$Q\in E(\mathbf Q)$.  A genuinely quadratic half can privilege at most
one of the three supports.

This is precisely rational $2$-isogeny descent.  If
$\phi_i:E\to E/\langle T_i\rangle$ is the quotient isogeny, then

\[
 H_Q\subset\langle T_i\rangle
 \Longleftrightarrow
 \phi_i(Q)\in(E/\langle T_i\rangle)(\mathbf Q)
 \Longleftrightarrow
 P\in\widehat\phi_i(E/\langle T_i\rangle)(\mathbf Q).
\]

For a non-two-torsion point $P=(x,y)$, the three conditions are that
$x,x-a,x+b$, respectively, be rational squares.

An explicit primitive family makes the obstruction strict.  For odd
$s\ge5$ with $(s,6)=1$, put

\[
 (a,b,c)=(6,s^2-8,s^2-2),\qquad P_s=(8,4s).
\]

Then $P_s$ is a non-torsion rational point and its Kummer coordinates have
squareclasses

\[
 [x]=[2],\qquad [x-a]=[2],\qquad [x+b]=[1].
\]

Every half of $P_s$ therefore has $H_Q=\langle T_b\rangle$: only the
fixed $a=6$ support has one packet, while both growing supports have two.
This disproves a uniform “choose the heaviest type among the halves of a
prescribed point” lemma, even for a bounded-abscissa non-torsion point.  It
does not disprove an adaptive construction of a different point.

## 1. The global halving cocycle

Assume $E[2]\subset E(\mathbf Q)$ and $2Q=P\in E(\mathbf Q)$.  Define

\[
 \delta_Q(\sigma)=\sigma Q-Q.
\]

Then $2\delta_Q(\sigma)=\sigma P-P=0$.  Since Galois acts trivially on
$E[2]$,

\[
 \delta_Q(\sigma\tau)
 =\sigma(\tau Q-Q)+(\sigma Q-Q)
 =\delta_Q(\tau)+\delta_Q(\sigma).
\]

Hence $\delta_Q:G_{\mathbf Q}\to E[2]$ is a homomorphism, and

\[
 H_Q=\operatorname{im}\delta_Q
 \in\{0,\langle T_0\rangle,\langle T_a\rangle,
          \langle T_b\rangle,E[2]\}.
\tag{1.1}
\]

The Galois orbit of $Q$ is exactly $Q+H_Q$.  If
$F=\mathbf Q(Q)$, its embeddings send $Q$ once to every point of this
orbit.  Translating $Q$ by a rational two-torsion point changes neither
$\delta_Q$ nor $H_Q$.  All four halves of a fixed $P$ have the same
packet-image sizes.

## 2. The three local identity-torsion lines

Let $p$ be an odd prime dividing exactly one of $a,b,c$, and put
$e=v_p(abc)>0$.  The displayed integral equation has

\[
 \Delta=16a^2b^2c^2,\qquad
 c_4=16(a^2+ab+b^2).
\]

The invariant $c_4$ is a $p$-adic unit.  Thus the reduction is
multiplicative of type $I_{2e}$.  Passing, if necessary, to the unramified
quadratic extension that splits the torus does not change the kernel
calculation or a degree-normalized rational-prime sum.

For a minimal Weierstrass model, the identity subgroup consists of the
origin and points with nonsingular reduction.  At a collision prime two
roots reduce to the node, while the remaining rational two-torsion point
is nonsingular.  Consequently:

- if $p\mid a$, the roots $0,a$ collide and
  $L_p=E[2]\cap E_0=\langle T_b\rangle$;
- if $p\mid b$, the roots $0,-b$ collide and
  $L_p=\langle T_a\rangle$;
- if $p\mid c$, the roots $a,-b$ collide and
  $L_p=\langle T_0\rangle$.

The two torsion points specializing to the node have the same nonzero
order-two component, because their sum is the third, nonsingular torsion
point.  We call $L_p$ the local identity-torsion line.

## 3. The exact component-packet image

Let

\[
 \operatorname{comp}_p:E(\overline{\mathbf Q}_p)\longrightarrow\Phi_p
\]

be the component map after splitting the multiplicative reduction.  For
every $\sigma\in G_{\mathbf Q}$,

\[
 \operatorname{comp}_p(\sigma Q)-\operatorname{comp}_p(Q)
 =\operatorname{comp}_p(\delta_Q(\sigma)).
\tag{3.1}
\]

On $E[2]$, the kernel on the right is $L_p$.  The distinct component
packets in $Q+H_Q$ are therefore a coset of the image of
$H_Q\to E[2]/L_p$, and

\[
 \boxed{
 d_p=\left|\operatorname{im}(H_Q\to E[2]/L_p)\right|
     =\left|H_Q/(H_Q\cap L_p)\right|.}
\tag{3.2}
\]

Every fiber has size $|H_Q\cap L_p|$, so the packets have equal
multiplicity.  Averaging over embeddings of $F$ is the same as the
degree-normalized sum over all places of $F$ above $p$.  Thus (3.2) is the
packet number relevant to the global height, not a calculation at a
single selected completion.

In particular,

\[
 \boxed{d_p=1\Longleftrightarrow H_Q\subset L_p.}
\tag{3.3}
\]

This asserts a single component coset.  Whether it is the positive identity
coset or the adverse opposite coset is an additional local condition.
Two-torsion translation can exchange cosets but cannot change $d_p$.

## 4. Complete table and two-type rigidity

Write $d_a,d_b,d_c$ for the packet numbers at the corresponding collision
types.  The complete table is

\[
\begin{array}{c|ccc}
H_Q&d_a&d_b&d_c\\ \hline
0&1&1&1\\
\langle T_0\rangle&2&2&1\\
\langle T_a\rangle&2&1&2\\
\langle T_b\rangle&1&2&2\\
E[2]&2&2&2.
\end{array}
\tag{4.1}
\]

The three nonzero lines in the two-dimensional $\mathbf F_2$-space
$E[2]$ have pairwise zero intersection.  If $d_p=1$ at primes from two
different collision types, then $H_Q$ is contained in two distinct lines,
so $H_Q=0$ and $Q$ is rational.  Conversely a rational half has one packet
at all three types.  A nonrational half with $d=1$ anywhere has a quadratic
orbit and privileges exactly one type.

## 5. Exact relation with the three rational 2-isogenies

For $i\in\{0,a,b\}$, let

\[
 \phi_i:E\longrightarrow E_i=E/\langle T_i\rangle
\]

be the rational quotient isogeny, with dual
$\widehat\phi_i:E_i\to E$.  Put $R_i=\phi_i(Q)$.  Since
$[2]=\widehat\phi_i\circ\phi_i$,

\[
 \widehat\phi_i(R_i)=P,\qquad
 \sigma R_i-R_i=\phi_i(\sigma Q-Q).
\]

The kernel of $\phi_i$ is $\langle T_i\rangle$, whence

\[
 H_Q\subset\langle T_i\rangle
 \Longleftrightarrow R_i\in E_i(\mathbf Q)
 \Longleftrightarrow P\in\widehat\phi_i(E_i(\mathbf Q)).
\tag{5.1}
\]

For the last implication in the reverse direction, choose
$R\in E_i(\mathbf Q)$ with $\widehat\phi_i(R)=P$ and lift it geometrically
through $\phi_i$.  The lift is a half of $P$ and differs from $Q$ by a
rational two-torsion point, so its cocycle is the same.

The precise nonzero-line refinement is

\[
 H_Q=\langle T_i\rangle
 \Longleftrightarrow
 \left\{
 \begin{array}{l}
 R_i\in E_i(\mathbf Q),\\
 \widehat\phi_i(R_i)=P,\\
 R_i\notin\phi_i(E(\mathbf Q)).
 \end{array}\right.
\tag{5.2}
\]

Indeed, the fiber $\phi_i^{-1}(R_i)=\{Q,Q+T_i\}$ is a degree-two torsor.
It has a rational point exactly when its $\phi_i$-Kummer class vanishes,
which is exactly $H_Q=0$.  Thus a nonzero line is a rational quotient
point whose pullback cover is a nontrivial rational torsor.

For reference, write

\[
 E:y^2=x^3+(b-a)x^2-abx.
\]

The standard quotient formula gives

\[
 E_0:Y^2=X^3+2(a-b)X^2+c^2X,
\qquad
 \phi_0(x,y)=
 \left(\frac{y^2}{x^2},
       \frac{y(-ab-x^2)}{x^2}\right).
\tag{5.3}
\]

After translating $T_a$ or $T_b$ to the origin, the other quotient models
are

\[
\begin{aligned}
 E_a &:Y^2=X^3-2(2a+b)X^2+b^2X,\\
 E_b &:Y^2=X^3+2(a+2b)X^2+a^2X.
\end{aligned}
\tag{5.4}
\]

## 6. Kummer squareclasses

The function $x-r_i$ has divisor $2(T_i)-2(O)$.  The standard
isogeny-descent map sends $P=(x,y)$, away from the exceptional
two-torsion values, to

\[
 \alpha_i(P)=[x-r_i]\in\mathbf Q^\times/\mathbf Q^{\times2},
\]

and its kernel is $\widehat\phi_i(E_i(\mathbf Q))$.  Therefore

\[
\begin{array}{c|c|c}
i&H_Q\subset\langle T_i\rangle&\text{square condition}\\ \hline
0&H_Q\subset\langle T_0\rangle&x\in\mathbf Q^{\times2}\\
a&H_Q\subset\langle T_a\rangle&x-a\in\mathbf Q^{\times2}\\
b&H_Q\subset\langle T_b\rangle&x+b\in\mathbf Q^{\times2}.
\end{array}
\tag{6.1}
\]

Because $x(x-a)(x+b)=y^2$, the product of the three squareclasses is
trivial.  If one is trivial, the other two agree.  If two are trivial, all
three are trivial, which is the full-two-torsion criterion
$P\in2E(\mathbf Q)$.  If none is trivial, the three distinct nontrivial
classes span a two-dimensional squareclass space and $H_Q=E[2]$.

Combining (6.1) with the collision lines gives the crossed rule

\[
\begin{array}{c|c}
\text{single-packet collision type}&\text{required rational square}\\ \hline
p\mid a&x+b\\
p\mid b&x-a\\
p\mid c&x.
\end{array}
\tag{6.2}
\]

## 7. A strict prescribed-point counterfamily

Let $s\ge5$ be odd and coprime to $6$, and set

\[
 a=6,\qquad b=s^2-8,\qquad c=s^2-2.
\tag{7.1}
\]

Then $a+b=c$.  Since $s^2\equiv1\pmod {24}$, both $b,c$ are odd and
prime to $6$.  Every common divisor of $b,c$ divides $c-b=6$, so the
triple is pairwise coprime and positive.

On

\[
 E_s:y^2=x(x-6)(x+s^2-8),
\]

the point $P_s=(8,4s)$ is rational because

\[
 (4s)^2=8(8-6)(8+s^2-8)=16s^2.
\tag{7.2}
\]

Its Kummer coordinates are

\[
 8=2\cdot2^2,\qquad 8-6=2,\qquad 8+(s^2-8)=s^2.
\tag{7.3}
\]

Their squareclasses are $[2],[2],[1]$.  Thus every half has
$H_Q=\langle T_b\rangle$: containment follows from the last square, while
$H_Q\ne0$ follows from the nonsquareness of $2$.

The point is non-torsion.  The duplication formula on the Frey model is

\[
 x(2P)=\frac{(x(P)^2+ab)^2}
              {4x(P)(x(P)-a)(x(P)+b)}.
\]

At $P_s$ this gives

\[
 x(2P_s)=\frac{(3s^2+8)^2}{16s^2}.
\tag{7.4}
\]

Choose a prime $p\mid s$.  Then $p\ge5$ and
$p\nmid6(s^2-8)(s^2-2)$, so the displayed equation is minimal with good
reduction at $p$.  Also $3s^2+8\equiv8\not\equiv0\pmod p$, and hence

\[
 v_p(x(2P_s))=-2v_p(s)<0.
\]

Thus $2P_s$ lies in the formal subgroup $E_1(\mathbf Q_p)$.  For
$p\ge5$, the formal logarithm embeds this group in the torsion-free
additive group $p\mathbf Z_p$.  Since $2P_s$ has a finite abscissa, it is
not the origin.  Therefore $2P_s$, and hence $P_s$, is non-torsion.

The odd multiplicative depth masses are

\[
 W_a=\log3,\qquad
 W_b=\log(s^2-8),\qquad
 W_c=\log(s^2-2).
\]

The last two tend to infinity, but (4.1) gives

\[
 d_a=1,\qquad d_b=d_c=2.
\tag{7.5}
\]

Every two-torsion translate of $Q$ has the same $H_Q$.  This is a strict
counterexample to the claim that, after fixing a rational non-torsion
point of bounded abscissa, one can choose one of its halves so that the
heaviest collision type has one packet.

## 8. The surviving selector theorem

The classification does not rule out choosing a different point after
the heaviest type is known.  To privilege types $a,b,c$, respectively,
one must construct a rational non-torsion point in the dual-isogeny image
attached to $T_b,T_a,T_0$, respectively, and then choose the identity
rather than opposite coset on the relevant primes.

Without a height condition the situation is degenerate.  If
$E(\mathbf Q)$ has positive rank, choose any non-torsion
$Q\in E(\mathbf Q)$ and put $P=2Q$; then $H_Q=0$ and all three types are
single-packet.  If $E(\mathbf Q)$ has rank zero, there is no non-torsion
rational $P$ at all, and all three isogenous curves have the same rank.
Thus unrestricted existence collapses to rank.  The version useful for
abc collapses to a uniform short-point/regulator problem.

A useful positive theorem would have to provide, for the heaviest type:

1. a non-torsion rational point in the corresponding dual-isogeny image;
2. a canonical-height bound strong enough for the abc ledger;
3. the positive identity coset on a fixed proportion of that support;
4. lower bounds for the complementary finite theta and archimedean terms.

Existence of the rational isogeny does not imply solubility of its Kummer
cover, and Selmer solubility does not imply the needed height bound.  No
such theorem is proved here.  What is closed is the packet ambiguity for
halving a fixed rational point.

## 9. Lean boundary

The companion module
IUTThreeClosures/FreyKummerPacketClassification.lean formalizes only
assumption-free finite and polynomial algebra:

1. a four-element model of $E[2]\cong\mathbf F_2^2$;
2. the three quotient packet maps and their kernels;
3. packet count one exactly when the orbit lies in the relevant line;
4. pairwise intersection and the two-type collapse theorem;
5. the complete five-row packet table;
6. the polynomial identities behind the three quotient models;
7. the abc, point, duplication, and Kummer-coordinate identities in
   (7.1).

Lean does not formalize Néron models, Tate's algorithm, component groups,
number-field embeddings, elliptic-curve isogenies, Galois cohomology, the
descent-map kernel theorem, formal-group torsion-freeness, canonical
heights, or the depth-mass interpretation.  Those are paper proofs, not
axioms or opaque fields in the Lean module.

## References

1. J. H. Silverman, *The Arithmetic of Elliptic Curves*, second edition,
   Springer GTM 106, 2009, Chapters VII and X.
2. J. W. S. Cassels, *Lectures on Elliptic Curves*, London Mathematical
   Society Student Texts 24, Cambridge University Press, 1991.
