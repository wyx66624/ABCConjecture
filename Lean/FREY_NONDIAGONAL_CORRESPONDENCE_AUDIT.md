# Non-diagonal correspondences among the three Frey two-isogeny targets

**Author: ChatGPT**

## Abstract

Let

\[
 E_b:y^2=x(x-1)(x+b),\qquad b=3r^2-2,
\]

and let the three nonzero rational two-torsion points define cyclic
two-isogenies

\[
 \phi_i:E_b\longrightarrow E_i,
 \qquad i\in\{0,1,-b\}.
\]

For the Pell point

\[
 Q=(2,r\sqrt6),\qquad P_i=\phi_i(Q),
\]

the diagonal product polarization has height

\[
 \sum_i\widehat h_{E_i}(P_i)
 ={3\over2}\log b+O(1).
\]

The preceding cyclic-isogeny audit showed that its complete leading local
ledger is

\[
 \text{odd bad }1+\text{ good finite }{1\over2}
   +\text{ archimedean }0
 =\text{ height }{3\over2}.                 \tag{A}
\]

This note tests the remaining possibility that an honest non-diagonal
correspondence on

\[
 A=E_0\times E_1\times E_{-b}
\]

might retain the three selected odd local masses while paying less than the
three diagonal heights.

The global geometry is completely explicit.  For distinct targets the
primitive Hom generator is

\[
 \psi_{ij}=\phi_j\widehat\phi_i:E_i\longrightarrow E_j,
 \qquad \deg\psi_{ij}=4.
\]

After pullback by \(F=\prod_i\phi_i:E_b^3\to A\), a symmetric Rosati
matrix has diagonal entries \(2a_i\) and off-diagonal entries \(4k_{ij}\).
The selected graph is the diagonal vector \((1,1,1)\).  Transporting the
three selected points by the dual isogenies gives

\[
 \widehat\phi_i(P_i)=[2]Q,
\]

so their Neron--Tate Gram matrix is exactly a scalar multiple of the all-one
matrix.  Its eigenvalues are \(3\widehat h([2]Q),0,0\).  There is only one
Mordell--Weil direction.

There nevertheless exists a genuine low-cost non-diagonal nef
correspondence.  Put

\[
 \ell_{ij}=\widehat\phi_i\operatorname{pr}_i-
             \widehat\phi_j\operatorname{pr}_j:A\to E_b
\]

and sum the three pullbacks \(\ell_{ij}^*\mathcal O(O)\).  Its pullback
matrix is

\[
 4(3I-J),
\]

with eigenvalues \(0,12,12\).  It is an honest integral nef line bundle,
but every \(\ell_{ij}\) vanishes on the selected graph.  Thus its canonical
height there is zero.  After normalization by four it has the same degree
on every coordinate axis as the product polarization, yet it carries none
of the selected graph height.  The cross terms have cancelled the diagonal
mass; they have not shared it at lower cost.

For \(0\le t\le1\), interpolation gives the exact matrix

\[
 M_t=(1-t)2I+t(3I-J)=(2+t)I-tJ.             \tag{B}
\]

It keeps every coordinate axis equal to \(2\), has transverse eigenvalue
\(2+t\), and has diagonal eigenvalue \(2(1-t)\).  Rational \(t=p/q\) is
honest after multiplying by \(4q\).  With the canonical trivialization of
the difference factors on the selected graph, the full Pell ledger becomes

\[
 (1-t)+{1-t\over2}+0={3(1-t)\over2}.         \tag{C}
\]

The odd-bad-to-height ratio remains exactly \(2/3\).  At \(t=1\) every
row is zero.  If one instead changes rational sections so as to call the
old unit bad row “retained”, then the omitted good-plus-archimedean row is
forced to be

\[
 {1over2}-{3t\over2}.
\]

It is negative precisely when the reduced height falls below the retained
bad mass.  That negative product-formula compensation is the old obstacle
in a different trivialization.

Thus ordinary products, dual-isogeny fiber products, Rosati matrices,
Poincare difference bundles, and Kani--Rosen projectors do not supply the
missing shared-height inequality.  They do expose the exact remaining
requirement: a new metrized correspondence together with a proved local
positivity theorem that preserves the selected odd row while controlling
the complete good and archimedean compensation.  Neron--Severi linear
algebra alone cannot prove such a theorem.

## 1. The actual Pell family and the complete diagonal ledger

Use the infinite subfamily

\[
 q_0+p_0\sqrt3=(2+\sqrt3)^{2j+1},\qquad
 r=2p_0q_0,\qquad b=3r^2-2,\qquad c=b+1.      \tag{1.1}
\]

Then

\[
 v_2(r)=2,\qquad v_2(b)=1,\qquad 3\nmid bc,
\]

and, with \(H=\log b\),

\[
 \log c=H+O(1),\qquad \log r={1\over2}H+O(1). \tag{1.2}
\]

Everything is defined over the fixed field

\[
 K=\mathbf Q(\sqrt6),\qquad |\operatorname{Disc}K|=24. \tag{1.3}
\]

The three quotient images have abscissae

\[
 {b+2\over2},\qquad 2(b+2),\qquad {2\over b+2}.       \tag{1.4}
\]

Their leading local rows are

\[
\begin{array}{c|ccc}
 &P_0&P_1&P_{-b}\\ \hline
 \text{odd bad finite}&5/12&5/12&1/6\\
 \text{good finite}&0&0&1/2\\
 \text{archimedean}&1/12&1/12&-1/6\\ \hline
 \widehat h&1/2&1/2&1/2.
\end{array}                                             \tag{1.5}
\]

All entries are coefficients of \(H\), with uniform \(O(1)\) errors.  The
third good row is the denominator \(b+2=3r^2\); it is not a conductor and
cannot be omitted.  Summing (1.5) gives (A).

The two-target subledgers are also useful:

\[
\begin{array}{c|rrrr}
 \text{targets}&\text{bad}&\text{good}&\infty&\text{height}\\ \hline
 (0,1)&5/6&0&1/6&1\\
 (0,-b)&7/12&1/2&-1/12&1\\
 (1,-b)&7/12&1/2&-1/12&1.
\end{array}                                             \tag{1.6}
\]

Thus passing to a two-factor product either keeps a positive archimedean
cost or keeps the growing good denominator.  A fiber product does not alter
these identities.

## 2. Pairwise Hom groups on the actual family

Write the quotient equations as

\[
\begin{aligned}
 E_0 &:Y^2=X^3+2(1-b)X^2+c^2X,\\
 E_1 &:Y^2=X^3-2(b+2)X^2+b^2X,\\
 E_{-b}&:Y^2=X^3+2(2b+1)X^2+X.
\end{aligned}                                           \tag{2.1}
\]

At an odd prime with \(e=v_\ell(b)>0\), the multiplicative depths of
\((E_0,E_1,E_{-b})\) are

\[
 (e,4e,e).                                               \tag{2.2}
\]

At an odd prime with \(e=v_\ell(c)>0\), they are

\[
 (4e,e,e).                                               \tag{2.3}
\]

Because \(v_2(b)=1\), both \(b/2>1\) and \(c>1\) have odd prime
divisors.  Equations (2.2)--(2.3) distinguish every pair of target
\(j\)-invariants: at a multiplicative place \(v(j)\) is minus the fibre
depth.  In particular, no two targets are geometrically isomorphic.

The same negative \(j\)-valuation also shows that these curves have no
complex multiplication: a CM \(j\)-invariant is an algebraic integer.
Consequently

\[
 \operatorname{End}_{\overline{\mathbf Q}}(E_i)=\mathbf Z
\]

and every \(\operatorname{Hom}(E_i,E_j)\) is a free rank-one group.

For \(i\ne j\), define

\[
 \psi_{ij}=\phi_j\widehat\phi_i:E_i\to E_j.             \tag{2.4}
\]

It has degree four.  If \(\psi_{ij}=m\theta\) in the rank-one Hom group,
then

\[
 4=m^2\deg\theta.                                       \tag{2.5}
\]

The only possible proper divisibility is \(m=2\) and
\(\deg\theta=1\), which would make \(E_i\) and \(E_j\) isomorphic.
Equations (2.2)--(2.3) exclude this.  Therefore

\[
 \boxed{\operatorname{Hom}(E_i,E_j)=\mathbf Z\psi_{ij}}. \tag{2.6}
\]

This primitivity matters integrally, although rational Neron--Severi
classes still permit denominators.

## 3. Rosati and Neron--Severi matrices

Let

\[
 A=E_0\times E_1\times E_{-b}
\]

with its product principal polarization \(\lambda_A\).  The standard map

\[
 \operatorname{NS}(A)_{\mathbf Q}\longrightarrow
 \operatorname{End}^0(A),\qquad
 L\longmapsto\lambda_A^{-1}\lambda_L                 \tag{3.1}
\]

identifies \(\operatorname{NS}(A)_{\mathbf Q}\) with the endomorphisms
fixed by the product Rosati involution.  This is the usual
Neron--Severi/Rosati dictionary; an author-maintained source is
[Milne's abelian-variety notes](https://www.jmilne.org/math/CourseNotes/av.html),
and the exact symmetric-endomorphism statement also appears in
[Milne's official Tate-conjecture notes, Section 2](https://www.jmilne.org/math/xnotes/TateAimv1.pdf).

Using (2.6), a symmetric matrix has the form

\[
 \alpha=
 \begin{pmatrix}
 a_0&k_{01}\psi_{01}^{\dagger}&k_{0,-b}\psi_{0,-b}^{\dagger}\\
 k_{01}\psi_{01}&a_1&k_{1,-b}\psi_{1,-b}^{\dagger}\\
 k_{0,-b}\psi_{0,-b}&k_{1,-b}\psi_{1,-b}&a_{-b}
 \end{pmatrix}.                                        \tag{3.2}
\]

For an integral line bundle, the displayed coefficients are integers; for
a rational line bundle they are rational.

Pull (3.2) back through

\[
 F=\phi_0\times\phi_1\times\phi_{-b}:E_b^3\to A.       \tag{3.3}
\]

Since

\[
 \widehat\phi_i\phi_i=[2],
\]

the resulting real height matrix is

\[
 M(\alpha)=
 \begin{pmatrix}
 2a_0&4k_{01}&4k_{0,-b}\\
 4k_{01}&2a_1&4k_{1,-b}\\
 4k_{0,-b}&4k_{1,-b}&2a_{-b}
 \end{pmatrix}.                                        \tag{3.4}
\]

The associated quadratic form is

\[
 2\sum_i a_ix_i^2+8\sum_{i<j}k_{ij}x_ix_j.             \tag{3.5}
\]

Nefness is equivalent to positive semidefiniteness of (3.4), and ampleness
to positive definiteness.

There is a useful integral boundary.  If two coordinate restrictions are
both the unit principal polarization and a single primitive cross
coefficient is \(k\in\mathbf Z\), the two-dimensional form is

\[
 2x^2+2y^2+8kxy
 =(1+2k)(x+y)^2+(1-2k)(x-y)^2.                          \tag{3.6}
\]

Every nonzero integral \(k\) makes one coefficient negative.  Thus an
integral primitive cross term cannot be added to two unit axes while
remaining nef.  This does **not** justify ignoring rational
correspondences: clearing denominators while scaling all axes produces
honest integral nef bundles, as Section 5 shows.

## 4. The selected-point Gram matrix is rank one

Define the selected graph

\[
 g:E_b\longrightarrow A,
 \qquad R\longmapsto(\phi_0R,\phi_1R,\phi_{-b}R).       \tag{4.1}
\]

At the Pell point \(Q\), dual transport gives

\[
 \widehat\phi_i(P_i)
 =\widehat\phi_i\phi_i(Q)
 =[2]Q.                                                 \tag{4.2}
\]

Put \(P=[2]Q\).  The transported Neron--Tate Gram matrix is

\[
 G_P=\widehat h_E(P)
 \begin{pmatrix}1&1&1\\1&1&1\\1&1&1\end{pmatrix}.    \tag{4.3}
\]

Its characteristic polynomial is

\[
 X^2\bigl(X-3\widehat h_E(P)\bigr),                   \tag{4.4}
\]

and its kernel is the plane \(x+y+z=0\).  Equivalently, its quadratic
form is

\[
 \widehat h_E(P)(x+y+z)^2.                              \tag{4.5}
\]

The rational quasi-inverses \(\widehat\phi_i/2\) send every \(P_i\) to
\(Q\), giving the same rank-one statement with
\(\widehat h(Q)\) in place of \(\widehat h(P)\).  But
\(\widehat\phi_i/2\) is not an honest morphism.  Clearing its denominator
returns (4.2); realizing it pointwise instead requires a division field and
belongs to the separately audited division-packet problem.

Thus the three targets do not contain three short directions waiting to be
combined.  They contain one direction displayed three times.

## 5. The honest transverse Laplacian

For each pair put

\[
 \ell_{ij}=\widehat\phi_i\operatorname{pr}_i-
             \widehat\phi_j\operatorname{pr}_j:A\to E_b. \tag{5.1}
\]

Let \(L_E=\mathcal O_{E_b}(O)\), with its canonical symmetric
rigidification, and set

\[
 L_{\Delta}=\bigotimes_{i<j}\ell_{ij}^*L_E.            \tag{5.2}
\]

Each factor is nef, so \(L_\Delta\) is nef.  Pulling (5.2) through \(F\)
gives

\[
 4\sum_{i<j}(x_i-x_j)^2.                                \tag{5.3}
\]

The matrix is

\[
 M_\Delta=4(3I-J)=
 \begin{pmatrix}
 8&-4&-4\\-4&8&-4\\-4&-4&8
 \end{pmatrix}.                                        \tag{5.4}
\]

Its eigenvalues are \(0,12,12\).  More importantly,

\[
 \ell_{ij}\circ g=0                                    \tag{5.5}
\]

for every pair.  Hence

\[
 \widehat h_{L_\Delta}(g(R))=0                         \tag{5.6}
\]

for every \(R\), not merely asymptotically on the Pell family.

On a coordinate axis \(E_i\subset A\), exactly two difference maps restrict
to \(\widehat\phi_i\).  Each has degree two, so
\(L_\Delta|_{E_i}\) has degree four.  Consequently

\[
 {1\over4}L_\Delta                                      \tag{5.7}
\]

has the same numerical coordinate restrictions as the product principal
polarization.  This is the precise counterexample to the informal claim
that equal coordinate restrictions force three copies of graph height.
They do not.  Cross terms can remove the graph height completely.

But (5.5) also says exactly what has happened: the line bundle is transverse
to the selected graph.  It has not retained three local carriers at zero
cost.  Its restriction to the graph is canonically trivial.

## 6. The complete interpolation spectrum

Let \(L_{\mathrm{prod}}\) denote the product principal polarization.  For
\(0\le t\le1\), consider the rational nef class

\[
 L_t=(1-t)L_{\mathrm{prod}}+{t\over4}L_\Delta.          \tag{6.1}
\]

Its pullback matrix is (B):

\[
 M_t=(1-t)2I+t(3I-J)=(2+t)I-tJ.                        \tag{6.2}
\]

The three exact spectral statements are:

\[
\begin{array}{c|c}
 \text{subspace}&\text{eigenvalue}\\ \hline
 \mathbf R(1,1,1)&2(1-t)\\
 x+y+z=0&2+t.
\end{array}                                             \tag{6.3}
\]

Every coordinate restriction remains \(2x^2\).  On the selected diagonal,

\[
 (x,x,x)M_t(x,x,x)^T=6(1-t)x^2.                        \tag{6.4}
\]

There is no integrality loophole.  If \(t=p/q\), with
\(0\le p\le q\), then

\[
 4(q-p)L_{\mathrm{prod}}+pL_\Delta                     \tag{6.5}
\]

is an honest integral nef line bundle.  Its coordinate scale is \(4q\)
times the standard one, and division by that common scale recovers (6.1).

Thus global Rosati positivity by itself allows the selected graph cost to
approach zero while all three normalized axes stay fixed.  Any proposed
no-go based only on principal minors or coordinate degrees would be false.
The correct no-go must use the restriction of the **metrized** line bundle
and its rational section to the selected graph.

## 7. The exact local ledger on the selected graph

Use the canonical cubical metrics and the canonical trivialization supplied
by (5.5).  The difference factors then contribute zero on the selected
graph.  Therefore (6.1) restricts there as \((1-t)\) times the product
metrized line bundle.  Multiplying every row of (A) by \(1-t\) gives

\[
\begin{array}{c|c}
 \text{row}&\text{leading coefficient of }H\\ \hline
 \text{odd bad finite}&1-t\\
 \text{good finite}&(1-t)/2\\
 \text{archimedean}&0\\
 \text{canonical height}&3(1-t)/2.
\end{array}                                             \tag{7.1}
\]

This proves (C), including the good denominator.  For every \(t<1\),

\[
 {\Lambda_{\rm bad}\over\widehat h_{L_t}}
 ={2\over3}.                                           \tag{7.2}
\]

At \(t=1\) all four rows are zero.

There is an important section dependence.  A local height is attached to a
metrized line bundle together with a rational local frame.  Replacing the
frame by a rational function adds its local logarithm.  The global sum is
zero by the product formula, but individual bad, good, and archimedean rows
move.

Suppose one chooses another frame and declares that the old unit bad row has
been retained while keeping the reduced graph height in (7.1).  The sum of
all other rows is then forced to be

\[
 \widehat h_{L_t}-1
 ={1\over2}-{3t\over2}.                                 \tag{7.3}
\]

If \(t>1/3\), the desired bad mass exceeds the global height, and (7.3) is
strictly negative.  Hence the apparent saving is exactly a negative
good-plus-archimedean compensation.  It cannot be discarded.  In
particular, if both the complete good row and the complete archimedean row
are known to be nonnegative, then the global identity immediately gives

\[
 \Lambda_{\rm bad}\le\widehat h_{L_t}.                  \tag{7.4}
\]

Equations (7.1)--(7.4) are the precise metric boundary.  Neron--Severi
classes determine the global quadratic form, but do not by themselves give
a sign for every local Poincare frame.  Neron's original framework for
local quasifunctions and their product-formula ambiguity is
[Néron, *Quasi-fonctions et hauteurs sur les variétés abéliennes*](https://doi.org/10.2307/1970644).

## 8. Fiber products do not create another direction

For distinct \(i,j\), form the dual-isogeny fiber product

\[
 B_{ij}=E_i\times_{E_b}E_j,
 \qquad \widehat\phi_i(R_i)=\widehat\phi_j(R_j).        \tag{8.1}
\]

The map

\[
 E_b\longrightarrow B_{ij},\qquad
 R\longmapsto(\phi_iR,\phi_jR)                         \tag{8.2}
\]

has kernel

\[
 \ker\phi_i\cap\ker\phi_j=0.
\]

It is therefore an isomorphism onto the identity component of (8.1).  The
product polarization pulls back to degree four and its selected height is
the sum of the two target heights, exactly the appropriate row of (1.6).

The simultaneous threefold fiber product has identity component equal to
the image of \(g\), hence again isomorphic to \(E_b\).  Its product
polarization pulls back to degree six and gives (A).  Other connected
components are torsors; the displayed selected triple lies on the identity
component and gains no Mordell--Weil direction from them.

Thus a fiber product either reconstructs the source elliptic curve or keeps
the full product ledger.  It does not turn three presentations of \(P\)
into three independent points.

## 9. Kani--Rosen and height polarization

Kani--Rosen idempotent relations decompose Jacobians up to isogeny.  The
original source is
[Kani--Rosen, *Idempotent relations and factors of Jacobians*](https://doi.org/10.1007/BF01442878),
with bibliographic and full-text metadata also at
[EuDML](https://eudml.org/doc/164555).

In the present rank-one situation, the rational orthogonal projector onto
the selected diagonal of \(E_b^3\) is

\[
 e_{\rm diag}={1\over3}J,                               \tag{9.1}
\]

and the transverse projector is \(I-J/3\).  The product form decomposes as

\[
 2I={2\over3}J+2\left(I-{1\over3}J\right).              \tag{9.2}
\]

On the selected diagonal the second summand vanishes, while the first has
exactly the same value \(6x^2\) as the product form.  Projecting away the
transverse factors therefore does not reduce the selected height.  Scaling
the diagonal projector down does reduce the height, but it scales down the
restricted metrized carrier as in Section 7.

The denominator three in (9.1) must be cleared in an integral
correspondence.  It records a finite isogeny kernel; it is not a license to
divide a canonical height without dividing the corresponding local line
bundle.  A higher curve and a Kani--Rosen decomposition could matter only if
it supplied a genuinely new abelian factor and a new independent point.
That is outside the ordinary correspondence algebra of the three existing
targets and would require a fresh field, conductor, and local-component
audit.

## 10. Field, conductor, and arithmetic-intersection costs

No variable field saving occurs here:

* the three curves and all isogenies are defined over \(\mathbf Q\);
* the selected points are defined over the fixed field
  \(K=\mathbf Q(\sqrt6)\);
* \([K:\mathbf Q]=2\) and \(|\operatorname{Disc}K|=24\) are constant;
* every dual-isogeny difference map is defined over \(\mathbf Q\).

All four elliptic curves lie in one rational isogeny class.  Their rational
\(\ell\)-adic representations are isomorphic, so their Neron conductors are
equal.  This prevents a new conductor penalty for one quotient, but it also
prevents a conductor saving.  If the full three-dimensional product is used
as a motive, its conductor exponents add across the three factors.  If one
projects to the diagonal factor, one returns to the source motive and loses
the threefold carrier.

The third target's \(H/2\) good-prime denominator in (1.5) is a point-height
intersection term, not a conductor.  It remains in (7.1) and cannot be
absorbed into the fixed field discriminant.

Faltings--Hriljac gives the same global conclusion in intersection
language.  A nef correspondence contributes a positive-semidefinite
arithmetic self-pairing.  The transverse difference classes have zero
restriction to the selected graph; a rational frame can redistribute their
local intersections, but the product formula restores the omitted rows.
Primary sources are
[Faltings, *Calculus on arithmetic surfaces*](https://annals.math.princeton.edu/1984/119-2/p04)
and
[Hriljac, *Heights and Arakelov's intersection theory*](https://doi.org/10.2307/2374455).

## 11. Exact conclusion and the smallest surviving theorem

The audit gives a strict no-go for the following ordinary constructions:

1. adding the three target canonical-height identities;
2. transporting the target points by dual isogenies and treating them as
   independent height directions;
3. dual-isogeny pair or triple fiber products;
4. the product polarization plus the three canonical difference
   pullbacks;
5. every rational interpolation (6.1), after honest denominator clearing;
6. Kani--Rosen or orthogonal-projector arguments which use only the existing
   three isogenous factors;
7. any argument that keeps only a bad row of a signed Poincare local height
   while omitting its good and archimedean product-formula compensation.

It also corrects an overly strong no-go statement: equal normalized
coordinate restrictions do **not** force product graph height.  The exact
Laplacian (5.4) is a counterexample.  What is true is that its saving is
transverse and its restricted carrier vanishes.

The smallest genuinely new statement that would reopen this route is:

> Construct a symmetric nef adelically metrized rational line bundle
> \(L\) on \(A\), together with a specified rational frame regular and
> nonzero at \(g(Q)\), such that its odd multiplicative local height retains
> the required selected mass, its restriction degree on \(g(E_b)\) is below
> the product degree, and the complete good-finite plus archimedean local
> height has a uniform lower bound within the radical budget.

Equivalently, one needs a new sign or lower-bound theorem for the Poincare
biextension metric on these Pell points.  Rosati positivity controls the
global quadratic form, not the sign of an arbitrarily chosen local frame.
No known dual-isogeny, Neron--Severi, Kani--Rosen, conductor, or arithmetic
Hodge-index identity supplies this missing local theorem.

This is a precise boundary, not an abc proof.  The natural non-diagonal
correspondences conserve the ratio (7.2); any apparent strict gain is a
negative omitted row as in (7.3).

## 12. Lean boundary

`IUTThreeClosures/FreyNonDiagonalCorrespondenceAudit.lean` verifies only the
scalar consequences used above:

1. the product form \(2I\) and normalized Laplacian form \(3I-J\);
2. equality of their coordinate axes and vanishing of the Laplacian on the
   selected diagonal;
3. the diagonal and transverse eigenvalues of the interpolation;
4. positive semidefiniteness for \(0\le t\le1\);
5. exact clearing of a rational parameter \(t=p/q\);
6. the rank-one transported Gram form and its two difference kernels;
7. the general Rosati scalar form and the primitive integral unit-axis
   obstruction;
8. the complete scaled Pell bad/good/archimedean ledger;
9. the fixed \(2/3\) boundary and the forced negative compensation after a
   putative retained-mass retrivialization;
10. the two exact pair ledgers.

Lean does not formalize elliptic curves, Tate fibres, dual isogenies, Hom
groups, Rosati involutions, Neron--Severi groups, Poincare biextensions,
fiber products, Kani--Rosen decompositions, local or canonical heights,
conductors, field discriminants, the Pell specialization, or abc.  Those
interpretations are explicit paper-level inputs and are not hidden as
axioms or structure fields.
