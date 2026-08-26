# Dual two-isogeny images and the genuine short-point obstruction

**Author: ChatGPT**

## Abstract

Let

\[
 E=E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

for a primitive positive abc triple.  At the three odd collision types, a
single Kummer packet for a half of a rational point is equivalent to
membership of that point in one of the three rational dual two-isogeny
images.  This note resolves the *image-membership* part of the adaptive
heavy-type proposal exactly.

If \(E(\mathbf Q)\) has positive rank and \(R\) is a shortest non-torsion
rational point, then

\[
 P=[2]R
\]

lies simultaneously in all three dual two-isogeny images.  Its rational
half \(R\) has trivial Kummer orbit, hence packet number one at every
collision type, and

\[
 \widehat h(P)=4\widehat h(R)=4\mu _1(E(\mathbf Q)/E(\mathbf Q)_{\rm tors}).
\]

More precisely, if \(H_i\) is any one of the three dual images and
\(H_*=H_0\cap H_a\cap H_b\), then

\[
 \boxed{\quad
 \mu _1(E)\leq\mu _1(H_i)\leq\mu _1(H_*)\leq4\mu _1(E).
 \quad}
\]

Thus neither Selmer theory nor geometry of numbers is needed merely to hit
the heaviest Kummer line: after positive rank is known, the exact remaining
height problem is the first **integral-coefficient** Mordell--Weil minimum,
up to the universal factor four supplied solely by the doubled-lattice
containment.

This does not prove the selector required for abc.  The actual primitive
curve for \((a,b,c)=(1,8,9)\) has rank zero and positive odd exponent excess,
so a universal rational non-torsion selector is impossible.  Even in positive
rank, one packet is not an identity-component or local-sign certificate.  On
a split \(I_4\) Tate curve a rational half on component \(1\) and all of its
rational two-torsion translates lie on components \(1\) or \(3\), and

\[
 B_2(1/4)=B_2(3/4)=-1/48.
\]

The dual-image problem is therefore reduced, not solved: the surviving
requirements are a useful upper bound for \(\mu _1(E)\), exact component
control, and compensation of the places over \(2\) and infinity.

## 1. Three dual images contain the same doubled lattice

Let \(T_i\in\{T_0,T_a,T_b\}\), let

\[
 \phi_i:E\longrightarrow E_i=E/\langle T_i\rangle
\]

be the quotient isogeny, and let
\(\widehat\phi_i:E_i\to E\) be its dual.  The defining factorization is

\[
 \widehat\phi_i\circ\phi_i=[2].                 \tag{1.1}
\]

Consequently

\[
 [2]E(\mathbf Q)\subset
 \widehat\phi_i(E_i(\mathbf Q))=:H_i            \tag{1.2}
\]

for every \(i\).  Intersecting the three inclusions gives

\[
 [2]E(\mathbf Q)\subset H_*:=H_0\cap H_a\cap H_b. \tag{1.3}
\]

This elementary containment changes the quantifiers in the proposed
selector.  One does not need to solve three unrelated isogeny descents after
the heaviest collision type is known.  A single doubled rational point works
for every possible choice of the heaviest type.

Let \(\Lambda=E(\mathbf Q)/E(\mathbf Q)_{\rm tors}\), equipped with the
Neron--Tate norm, and assume \({\rm rank}\,E(\mathbf Q)>0\).  The free
abelian group \(\Lambda\), embedded in its real span by the positive-definite
Neron--Tate pairing, is a Euclidean Mordell--Weil lattice.  Hence its first
minimum

\[
 \mu _1(E)=\min_{0\ne R\in\Lambda}\widehat h(R) \tag{1.4}
\]

is attained.  Choose a representative \(R\in E(\mathbf Q)\).  Then \(2R\)
is non-torsion, belongs to \(H_*\), and

\[
 \widehat h(2R)=4\widehat h(R)=4\mu _1(E).       \tag{1.5}
\]

Because \(H_*\subset H_i\subset E(\mathbf Q)\), taking minima and using
(1.5) proves

\[
 \mu _1(E)\leq\mu _1(H_i)\leq\mu _1(H_*)
 \leq4\mu _1(E).                               \tag{1.6}
\]

Here the minima ignore torsion.  Equation (1.6) is invariant under every
change of Mordell--Weil basis; no real Gram eigenvalue occurs.
The factor four is optimal if one uses only the abstract containment
\(2\Lambda\subset H_*\): in rank one the abstract case
\(H_*=2\Lambda\) attains equality.  This is not a claim that equality occurs,
or that the factor is sharp, for every individual Frey isogeny image; extra
descent information can improve it.

## 2. Exact Kummer interpretation

Put \(P=2R\) and choose the displayed half \(Q=R\).  Because \(R\) is
rational, its halving difference cocycle is zero:

\[
 H_Q=\{\sigma Q-Q:\sigma\in G_{\mathbf Q}\}=0. \tag{2.1}
\]

The packet classification then gives

\[
 d_a=d_b=d_c=1.                                \tag{2.2}
\]

Equivalently, \(P\) belongs to all three dual images, as already follows
from (1.1).  In terms of the three descent squareclasses, the three
quantities

\[
 x(P),\qquad x(P)-a,\qquad x(P)+b
\]

are all rational squares when \(P\in2E(\mathbf Q)\), with the usual limiting
interpretation at two-torsion.

This construction has the minimal possible branch-field ledger:

* the half is rational, so its field degree is one and its field
  discriminant is one;
* the elliptic curve is unchanged, so no new conductor is introduced;
* the packet number is one at all odd collision types;
* the half has height \(\mu _1(E)\), while the point being halved has height
  \(4\mu _1(E)\).

Accordingly, the phrase “construct a short point in the dual image of the
heaviest line” contains no extra global image obstruction once a short
rational point exists.  The nontrivial word is *short*.

## 3. Rank zero is a strict global obstruction

The factor-four construction requires positive rank, and that hypothesis
cannot be removed.  The companion weighted Poitou--Tate audit gives a full
two-descent, not a database assertion, for

\[
 E_{1,8}:y^2=x(x-1)(x+8).                      \tag{3.1}
\]

Its rational points form a rank-zero group.  The corresponding primitive abc
point is

\[
 (a,b,c)=(1,8,9),                              \tag{3.2}
\]

and the only odd bad support is the \(c\)-collision prime \(3\), with

\[
 v_3(abc)=2,\qquad (v_3(abc)-1)\log3=\log3>0.  \tag{3.3}
\]

Thus the heaviest odd type is unambiguously the \(c\)-type, yet no
non-torsion rational point exists in its dual image or anywhere else on the
curve.  This one actual curve already disproves every selector quantified
over all primitive Frey curves.

There is a useful larger pattern, but its infinitude must not be overstated.
If \(p\) and \(p-2\) are twin primes with \(p\equiv7\pmod8\), the theorem of
Hatley gives rank zero for

\[
 y^2=x(x-p)(x-2).
\]

After translating \(X=x-2\), this is the Frey curve for

\[
 (a,b,c)=(p-2,2,p).                            \tag{3.4}
\]

Every such \(p\) is therefore another strict example; \(p=7\) gives
\((5,2,7)\).  However, claiming infinitely many examples from (3.4) would
claim infinitely many twin primes in the indicated congruence class, which
is not known.

Nor do general theorems producing infinitely many rank-zero quadratic
twists immediately give an infinite primitive Frey family.  Twisting a
fixed \(E_{a,b}\) by a squarefree \(d\) scales the three root differences to
\(da,db,dc\); their common factor \(d\) violates primitivity, while dividing
it out removes the twist.  Equivalently, a fixed twist has fixed \(j\) and
fixed root cross-ratio, leaving only finitely many primitive integral root
difference triples up to the six cross-ratio symmetries.  This audit therefore
claims the unconditional individual obstruction (3.2), not a new
unconditional infinite rank-zero Frey family.

## 4. The exact first-minimum reduction

For any proposed bound \(B(E)\), (1.6) gives the implication

\[
 \mu _1(E)\leq B(E)
 \quad\Longrightarrow\quad
 \mu _1(H_*)\leq4B(E).                         \tag{4.1}
\]

Conversely, since \(H_i\subset E(\mathbf Q)\), any short point in a dual
image is already a short point of the full Mordell--Weil lattice.  Hence the
dual-image version and the ordinary first-minimum version differ by at most
the constant factor four.

Geometry of numbers does not make (4.1) effective at the abc scale without
new arithmetic input.  If \(r={\rm rank}\,E(\mathbf Q)\) and
\({\rm Reg}(E)\) is the determinant of a height Gram matrix, Hermite's
inequality gives

\[
 \mu _1(E)\leq\gamma_r\,{\rm Reg}(E)^{1/r}.     \tag{4.2}
\]

This is a valid upper bound for the integral minimum, unlike a small
eigenvalue of a displayed basis.  But neither an abc-scale regulator upper
bound nor rank-uniform control of \(\gamma_r\) is available from the rational
two-isogeny alone.  The near-singular Gram audit remains decisive: an
integral shear can make a displayed real eigenvalue arbitrarily small while
leaving \(\mu _1\) and the regulator unchanged.

The same observation clarifies the role of Selmer theory.  A two-isogeny
descent can determine whether a particular class lies in \(H_i\), can bound
the rank, and can sometimes prove rank zero.  It cannot create a non-torsion
class on (3.1), and it is unnecessary for the coarse factor-four containment
\([2]E(\mathbf Q)\subset H_i\).  Selmer information becomes useful again only
if one tries to improve the factor four, prove positive rank, or obtain a
genuine upper bound for \(\mu _1(E)\).

## 5. One packet does not control the local component

The most important remaining separation is local.  Packet number one says
that all Galois conjugates of the half occupy one component coset.  It does
not say that this coset is the identity component.

Take a split Tate curve over \(\mathbf Q_p\) with

\[
 q=p^4.
\]

Its component group is \(\mathbf Z/4\mathbf Z\).  A rational Tate parameter
\(u=\alpha p\), with \(\alpha\in\mathbf Z_p^\times\), represents component
\(1\).  The rational two-torsion has component images \(0\) and \(2\), so all
four rational two-torsion translates of this point have component \(1\) or
\(3\), never \(0\).

The component-depth term in the local Neron function uses

\[
 B_2(r)=r^2-r+\frac16.
\]

Both possible normalized components are adverse:

\[
 B_2(1/4)=B_2(3/4)=-\frac1{48}<0.              \tag{5.1}
\]

Choose, for example, \(\alpha=1+p\) for odd \(p\).  Then the class of
\(\alpha p\) in \(\mathbf Q_p^\times/q^{\mathbf Z}\) is non-torsion: if its
\(n\)-th power lay in \(q^{\mathbf Z}\), valuations would first force
\(4\mid n\), and then \((1+p)^n=1\), impossible in the torsion-free principal
unit group.  On the basic annulus the theta/intersection term is zero for
these representatives.  Thus (5.1) is an actual non-torsion local Tate
example, not only a component-group cartoon.

The point is rational over the local field, so its Galois-difference orbit is
trivial and its packet number is one.  Nevertheless no rational two-torsion
translation gives the identity component or a positive Bernoulli depth term.
Therefore

\[
 d_p=1\centernot\Longrightarrow
 \text{identity packet}\centernot\Longrightarrow
 \text{positive local contribution}.          \tag{5.2}
\]

Repeated doubling does not uniformly repair this.  At an \(I_{2e}\) fiber a
point on component \(1\) moves to component \(2^m\bmod 2e\) after \(m\)
doublings.  If \(e>1\) has an odd factor, no power of two kills that
component.  Multiplication by the full component exponent would work, but it
multiplies canonical height by the square of that exponent; doing this at
many primes requires a global least common multiple and destroys the desired
height ledger.

## 6. Field and conductor control do not control infinity

The doubled-lattice construction introduces no number field and no new
curve, so its branch discriminant and auxiliary conductor costs are zero.
This is optimal, but it does not bound the separate archimedean local height.
The identity

\[
 \widehat h(2R)=4\widehat h(R)
\]

is global.  Under duplication, finite division-polynomial terms and the
archimedean Neron function can redistribute substantially before their sum
recovers the global identity.

The fixed-field Pell example in the adelic packet-compensation audit makes
this strict: the field discriminant stays \(24\), all odd finite packet data
are favorable, yet the real place contributes
\(-\frac1{12}\log b+O(1)\).  A radical-sensitive lower bound at exactly that
coefficient is equivalent to abc on the Pell subfamily.  Hence the factor-four
selector does not bypass the archimedean obstruction.

## 7. Precise surviving theorem

The heavy dual-image question now has a complete conditional answer.

> **Factor-four theorem.**  On every positive-rank primitive Frey curve, a
> shortest non-torsion rational point \(R\) produces \(P=2R\), which lies in
> all three dual two-isogeny images.  The rational half \(R\) has one packet
> at every collision type, no field or conductor cost, and
> \(\widehat h(P)=4\mu _1(E)\).

What remains genuinely open is not membership in the selected Kummer line.
It is the conjunction of:

1. positive rank, or a controlled auxiliary replacement, for rank-zero
   curves such as (3.1);
2. an abc-useful upper bound for the integral minimum \(\mu _1(E)\);
3. exact identity-component retention on enough of the heavy support, beyond
   the one-packet statement;
4. lower bounds for the places over \(2\) and infinity, or cancellation among
   several globally compatible branches.

The adaptive pair-square selector solves a different problem: it supplies a
non-torsion point after a quadratic extension with linear-size squareclass.
Its point is anti-invariant under the quadratic involution (the two conjugates
have the same rational abscissa and opposite ordinates), so its trace is zero;
it does not automatically supply a rational point to which the factor-four
theorem applies.

No abc estimate, uniform rank statement, regulator bound, or archimedean
Green-function inequality is proved in this note.

## 8. Lean boundary

`IUTThreeClosures/FreyDualIsogenyShortPointAudit.lean` formalizes only:

1. the abstract factorization \(\widehat\phi\phi=[2]\) and containment of a
   doubled point in one or three dual images;
2. the factor-four height transfer from an explicitly supplied short
   non-torsion point;
3. the existing trivial-orbit packet row \((1,1,1)\);
4. the exact \(I_4\) component calculation and
   \(B_2(1/4)=B_2(3/4)=-1/48\);
5. the heaviest odd type and positive exponent excess of \((1,8,9)\);
6. the abstract rank-zero logical no-go.

Lean does not formalize elliptic curves, dual isogenies, canonical heights,
Mordell--Weil finite generation, Tate curves, local heights, rank, the full
descent proof, conductor/discriminant statements, or abc.  Those
interpretations are paper mathematics and are not represented by axioms or
opaque structure fields.

## References

1. J. H. Silverman, *The Arithmetic of Elliptic Curves*, second edition,
   Springer GTM 106, 2009, Chapters VIII and X.
2. J. Hatley, *On the Rank of the Elliptic Curve
   \(y^2=x(x-p)(x-2)\)*, 2009,
   <https://arxiv.org/abs/0909.1614>.
3. J. W. S. Cassels, *An Introduction to the Geometry of Numbers*, Springer,
   1959.
