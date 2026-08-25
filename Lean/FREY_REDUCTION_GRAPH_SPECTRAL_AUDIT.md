# Frey reduction-cycle spectral and Arakelov audit

## 1. Outcome

Let

\[
 E_{a,b}:y^2=x(x-a)(x+b),\qquad a+b=c,
\]

with a primitive positive abc triple.  At an odd prime
\(p\mid abc\), put

\[
 e_p=v_p(abc).
\]

The geometric semistable fibre is of type \(I_{2e_p}\).  Its unit-edge
dual graph is the cycle \(C_{2e_p}\).  This audit gives all of the basic
spectral and electrical invariants of that cycle exactly.

There is one genuinely positive, non-circular consequence.  Among the
three *fixed global pairs* of nonzero rational two-torsion sections, one
pair captures at least one third of the total weighted graph-energy excess

\[
 X(E)=\sum_{p\mid abc,\ p\ne2}(e_p-1)\log p.
\]

The selected pair is still a two-torsion divisor.  Its Neron--Tate height is
zero.  Faltings--Hriljac therefore forces its positive graph energy to be
cancelled exactly by the remaining finite horizontal terms and the
archimedean Green term.  The arithmetic Hodge index is saturated, rather
than strict, on this torsion class.  Thus the selection lemma is real, but
does not supply a global upper bound for \(X(E)\).

No proof of abc, Szpiro, a uniform height inequality, or a new case of the
Faltings--Hriljac theorem is claimed.

## 2. Normalizations and the cycle Laplacian

Fix one odd bad prime and write \(e=e_p\), \(n=2e\).  First use the
combinatorial cycle with unit edge resistances.  The physical local factor
\(\log p\) is inserted only after the unit calculation.  Equivalently, one
may give every edge length \(\log p\); then all resistances and Green values
below are multiplied by \(\log p\).

Index the vertices by \(\mathbf Z/n\mathbf Z\).  For \(n=2\), the two
edges are parallel, as required for the Kodaira polygon \(I_2\).  The
unnormalized Laplacian is

\[
 (Lf)(j)=2f(j)-f(j-1)-f(j+1).
 \tag{2.1}
\]

For

\[
 \chi_k(j)=\exp(2\pi i k j/n),\qquad 0\le k<n,
\]

one has

\[
 L\chi_k=\lambda_k\chi_k,
 \qquad
 \lambda_k=2-2\cos\frac{2\pi k}{n}
          =4\sin^2\frac{\pi k}{n}.
 \tag{2.2}
\]

Consequently

\[
 \lambda_1=4\sin^2\frac{\pi}{2e}
           \sim \frac{\pi^2}{e^2}.
 \tag{2.3}
\]

There is no uniform spectral gap.  In normalized-Laplacian convention the
gap is divided by two.  The conductance of \(C_{2e}\) is \(1/e\), which
records the same failure of expansion.

This already prevents a common shortcut: a Poincare inequality on these
graphs has a constant of order \(e^2\), so it cannot turn support-only data
into an exponent-independent estimate.

## 3. Matrix tree, pseudo-determinant, and Kirchhoff index

Using

\[
 \prod_{k=1}^{n-1}\sin\frac{\pi k}{n}
   =\frac{n}{2^{n-1}},
\]

the nonzero spectral determinant is

\[
 \det{}'L
 =\prod_{k=1}^{n-1}4\sin^2\frac{\pi k}{n}
 =n^2=4e^2.
 \tag{3.1}
\]

Kirchhoff's matrix-tree theorem then gives

\[
 \tau(C_n)=\frac1n\det{}'L=n=2e.
 \tag{3.2}
\]

This can also be seen directly: a spanning tree is obtained by deleting
exactly one of the \(n\) cycle edges.

The Kirchhoff index is

\[
 \operatorname{Kf}(C_n)
 =\sum_{0\le i<j<n}R(i,j)
 =\frac{n^3-n}{12}
 =\frac{4e^3-e}{6}.
 \tag{3.3}
\]

The determinant does not itself carry the desired linear arithmetic mass.
Indeed \(\log\det{}'L=2\log(2e)\), whereas the local exponent mass is of
order \(e\log p\).  Conversely, using \(1/\sqrt{\lambda_1}\) or a resistance
does recover \(e\), but then the missing exponent has simply been put back
into the input.  No conductor upper bound follows from (3.1)--(3.3).

## 4. Effective resistance

If two vertices are separated by \(d\) edges, with \(0\le d\le n\), the
two arcs of lengths \(d\) and \(n-d\) are resistors in parallel.  Therefore

\[
 R_n(d)=\left(\frac1d+\frac1{n-d}\right)^{-1}
       =\frac{d(n-d)}n.
 \tag{4.1}
\]

At the antipode of \(C_{2e}\),

\[
 R_{2e}(e)=\frac e2.
 \tag{4.2}
\]

After restoring the local length, this is \((e/2)\log p\).  Thus electrical
resistance really sees the full multiplicative depth.  The issue is not a
failure of local detection; it is the global sign and selection problem.

## 5. Discrete Moore--Penrose Green versus metric/Tate Green

Two Green normalizations must not be conflated.

### 5.1 Discrete cycle

Let \(G=L^+\) be the Moore--Penrose inverse of the combinatorial Laplacian,
normalized by zero sum over the vertices.  If the vertex separation is
\(d\), then

\[
 G_n(d)=\frac{n^2-1}{12n}-\frac{d(n-d)}{2n}.
 \tag{5.1}
\]

For \(n=2e\),

\[
 G_{2e}(0)=\frac e6-\frac1{24e},
 \qquad
 G_{2e}(e)=-\frac e{12}-\frac1{24e}.
 \tag{5.2}
\]

In particular, the discrete diagonal is not exactly \(e/6\).

### 5.2 Metrized circle and the Tate local-height term

Now view the same polygon as a metric circle of total length \(n\), with
uniform admissible measure.  With

\[
 B_2(x)=x^2-x+\frac16,
\]

the mean-zero Green kernel is

\[
 g_n(d)=\frac n2 B_2(d/n)
       =\frac n{12}-\frac{d(n-d)}{2n}.
 \tag{5.3}
\]

Thus

\[
 g_n(d)=G_n(d)+\frac1{12n}.
 \tag{5.4}
\]

The constant in (5.4) vanishes from every degree-zero pairing, but it
matters when individual kernel values are quoted.  For \(n=2e\),

\[
 g_{2e}(0)=\frac e6,
 \qquad
 g_{2e}(e)=-\frac e{12}.
 \tag{5.5}
\]

These, not the discrete values (5.2), are the Bernoulli terms appearing in
the odd Tate local-height calculation.  In a nonsplit multiplicative fibre,
one passes to the unramified quadratic splitting extension; the Galois
reflection preserves the resistance and the multiset (5.5).

For the degree-zero charge \(\delta_0-\delta_e\), either Green
normalization gives

\[
 \langle\delta_0-\delta_e,\delta_0-\delta_e\rangle
 =g(0,0)+g(e,e)-2g(0,e)
 =\frac e2,
 \tag{5.6}
\]

because the additive constant cancels.

## 6. The three nonzero rational two-torsion points

Write

\[
 T_0=(0,0),\qquad T_a=(a,0),\qquad T_b=(-b,0).
\]

At an odd bad prime, one of these points is in the identity component and
the other two lie at the antipode.  In the ordering \((T^+,T^-,T^-{}')\),
the component positions are \((0,e,e)\).

For the centered component charges \(D_x=\delta_x-\mu\), the complete
metric Green Gram matrix is

\[
 \bigl(g(D_i,D_j)\bigr)
 =\frac e{12}
 \begin{pmatrix}
  2&-1&-1\\
 -1& 2& 2\\
 -1& 2& 2
 \end{pmatrix}.
 \tag{6.1}
\]

Hence each centered point charge has self-energy \(e/6\), while the
pair-difference energies are

\[
 \left\{\frac e2,\frac e2,0\right\}.
 \tag{6.2}
\]

The zero in (6.2) occurs because the two distinct nonidentity-component
points have the same graph specialization.  Horizontal intersection data,
which the graph forgets, still distinguishes them.

The local-height row based at the identity component is instead

\[
 \left\{\frac e6,-\frac e{12},-\frac e{12}\right\}\log p,
 \tag{6.3}
\]

and therefore

\[
 \sum_{T\in E[2]\setminus\{O\}}\lambda_p(T)=0.
 \tag{6.4}
\]

Equations (6.2) and (6.4) are different statements.  The first is a
positive resistance ledger on *pairs*; the second is a signed Green row.
Replacing (6.4) by positive parts is not a canonical-height operation.

The collision labels are explicit:

* if \(p\mid a\), then \(T_0,T_a\) collide and \(T_b\) is the positive
  identity-component point;
* if \(p\mid b\), then \(T_0,T_b\) collide and \(T_a\) is positive;
* if \(p\mid c\), then \(T_a,T_b\) collide and \(T_0\) is positive.

At each place, the colliding pair has resistance zero and the other two
pairs each have resistance \(e/2\).  Their sum is exactly \(e\).

## 7. A non-circular one-third energy selector

Partition the odd bad primes into three sets \(S_0,S_1,S_2\) according to
which branch pair collides.  Define nonnegative excess masses

\[
 w_i=\sum_{p\in S_i}(e_p-1)\log p,
 \qquad W=w_0+w_1+w_2=X(E).
 \tag{7.1}
\]

Subtracting the baseline \(I_2\) contribution at every bad prime, define
the three **renormalized excess energies**

\[
 \mathcal E_0=\frac{w_1+w_2}{2},\qquad
 \mathcal E_1=\frac{w_0+w_2}{2},\qquad
 \mathcal E_2=\frac{w_0+w_1}{2}.
 \tag{7.2}
\]

They obey the exact conservation law

\[
 \mathcal E_0+\mathcal E_1+\mathcal E_2=W.
 \tag{7.3}
\]

Therefore

\[
 \boxed{\max_i\mathcal E_i\ge\frac13X(E).}
 \tag{7.4}
\]

The same formulas with \(e_p\) in place of \(e_p-1\) select one third of
the full, literal effective-resistance depth.  The quantities in (7.2) are
the difference between that literal energy and its conductor-scale
\(I_2\) baseline; they are nonnegative scalar excesses, but are not by
themselves a new canonical Arakelov pairing.  This distinction matters in
Section 8.  Importantly, (7.4) does not choose a different
torsion pair at every prime.  It chooses one of the three globally defined
pairs after summing all places.  Thus (7.4) is a genuine local-to-global
selection fact, not a relabeling at each fibre.

## 8. Why Faltings--Hriljac cancels the selected energy

For a fixed pair \(i\ne j\), let

\[
 D_{ij}=(T_i)-(T_j).
\]

Its Jacobian class is the nonzero point \(T_i-T_j\in E[2](\mathbf Q)\), so

\[
 \widehat h(D_{ij})=0.
 \tag{8.1}
\]

This torsion statement is also visible directly.  If \(r_i,r_j\) are the
corresponding roots of the cubic, then

\[
 \operatorname{div}\!\left(\frac{x-r_i}{x-r_j}\right)
 =2(T_i)-2(T_j)=2D_{ij}.
 \tag{8.2}
\]

Faltings--Hriljac expresses the canonical height as an arithmetic
self-pairing after the necessary vertical and archimedean admissible
corrections.  Decompose that identity schematically, but with all terms
retained, as

\[
 0=\widehat h(D_{ij})
  =\mathcal E^{\rm graph}_{ij}
   +\mathcal R^{\rm horizontal}_{ij}
   +\mathcal R^\infty_{ij}.
 \tag{8.3}
\]

The overall signs of the intersection terms vary with convention; the
convention-independent content is

\[
 \mathcal R^{\rm horizontal}_{ij}+\mathcal R^\infty_{ij}
 =-\mathcal E^{\rm graph}_{ij}.
 \tag{8.4}
\]

Thus the positive *literal* graph energy of the pair selected in Section 7
is not a positive lower bound for a global canonical height.  It is exactly
compensated.  Its renormalized excess differs from the literal energy by an
explicit conductor-scale baseline; subtracting that baseline does not
create a new height identity or remove the compensating source-height term.

Equation (8.2) explains why the compensation cannot be discarded.  The
arithmetic divisor of a rational function contains both its finite divisor
and its archimedean metric term.  Its arithmetic intersection is zero by
the product formula.  Finite collisions measure valuations of the branch
differences \(a,b,c\), while the archimedean term contains the corresponding
real logarithms.  Removing either side changes the arithmetic divisor and
breaks the product formula.

The arithmetic Hodge index theorem gives the expected sign for a
degree-zero arithmetic divisor.  On a torsion class it is an equality case:
the canonical self-pairing is zero.  It therefore cannot turn (7.4) into a
strict global surplus.

There is a second formulation of the same obstruction.  One may choose
vertical divisors independently on all bad fibres so that their negative
self-intersections record the effective resistances.  But a purely vertical
arithmetic divisor has no horizontal rational point carrying those local
choices, and the Hodge index only confirms its negative self-intersection.
Adding a horizontal correction restores a global divisor and introduces
exactly the adverse terms in (8.3).

## 9. Strict local no-go

Suppressing all valence-two vertices turns every \(C_{2e}\) into the same
topological circle, with first Betti number one.  On the actual primitive
family

\[
 (a_n,b_n,c_n)
 =\left(3^{2n+2},2,3^{2n+2}+2\right),
\]

the reduced local profile at three is constantly

\[
 (\text{present},b_1)=(1,1),
\]

while

\[
 e_3=2n+2,\qquad e_3-1=2n+1\longrightarrow\infty.
\]

Therefore, for every function \(F\) of that reduced profile, some member of
the family satisfies

\[
 F(1,1)<e_3-1.
\]

This is a full-quantifier obstruction.  A spectral invariant which retains
the subdivision length does see \(e\); one which retains only the stable
topological graph does not.  Merely reading \(e\) back from
\(R_{\rm antipode}\) or \(\lambda_1\) is detection, not an upper bound.

## 10. The minimum surviving open proposition

The one-third selector (7.4) reduces the combinatorial selection loss to an
absolute constant.  What remains is genuinely arithmetic.

A sufficient new theorem would construct, for every Frey curve, a
non-torsion global degree-zero class \(D_E\) (or a class on a controlled
auxiliary curve) and constants \(\kappa>0\) such that

\[
 \kappa X(E)\le \mathcal E_{\rm graph}(D_E),
 \tag{10.1}
\]

while retaining the full Faltings--Hriljac remainder and proving, for every
\(\varepsilon>0\),

\[
 \mathcal E_{\rm graph}(D_E)
 \le \widehat h(D_E)+\mathcal A_E
 \le \kappa\varepsilon\log N_E+C_\varepsilon.
 \tag{10.2}
\]

Here \(\mathcal A_E\) denotes all adverse horizontal, finite, and
archimedean terms, with no positive-part deletion.  Equations
(10.1)--(10.2) would imply

\[
 X(E)\le\varepsilon\log N_E+O_\varepsilon(1),
\]

which is the exponent-excess form of abc.

The word **non-torsion** is essential: the selected classes in Section 7
make (10.2) collapse to the exact cancellation (8.4).  A universal
Mordell--Weil construction on \(E\) is also impossible without an additional
idea because Frey curves of rank zero occur: the primitive triple
\((1,1,2)\) gives \(y^2=x^3-x\), whose Mordell--Weil group has rank zero.
An auxiliary twist, cover, or abelian variety would have to come with
quantitative control of its new conductor, discriminant, descent obstruction,
and archimedean cost.  This weighted non-torsion spectral globalization is
the smallest opening left by the present route.

## 11. What each method actually contributes

| Input | Exact output | Why it stops |
|---|---|---|
| Cycle spectrum | \(\lambda_k=4\sin^2(\pi k/2e)\) | Gap collapses like \(e^{-2}\) |
| Matrix tree | \(\det' L=4e^2\), \(\tau=2e\) | Log determinant is only \(O(\log e)\) |
| Effective resistance | Antipodal energy \(e/2\) | Contains depth but no conductor cap |
| Metric Green/Tate height | \(e/6,-e/12,-e/12\) | Signed row sums to zero |
| Three-pair selection | One fixed pair captures \(X/3\) | Selected divisor is torsion |
| Faltings--Hriljac | Exact global height identity | Positive graph term is exactly cancelled |
| Arithmetic Hodge index | Correct global sign | Equality is saturated on torsion |

## 12. Lean boundary

`IUTThreeClosures/FreyReductionGraphSpectralAudit.lean` formalizes:

1. the finite cyclic second-difference operator and its constant kernel;
2. the exact scalar eigenvalue identity
   \(2-2\cos(2x)=4\sin^2x\), and the quadratic gap upper bound;
3. the resistance, metric-circle Green, and discrete Green formulas, with
   their exact constant difference;
4. the antipodal charge energy and the signed two-torsion conservation;
5. scalar Kirchhoff-index, matrix-tree cofactor, and pseudo-determinant
   formulas, with the spanning-tree count represented by edge-deletion
   choices;
6. the exact three-pair energy conservation and one-third selection lemma;
7. the actual primitive-family obstruction to every reduced-profile-only
   exponent bound;
8. a fully quantified zero-global-ledger countermodel;
9. the exact scalar implication supplied by a hypothetical non-torsion
   selector with all adverse terms exposed.

Lean does not formalize the regular model, its geometric dual graph, the
Fourier eigenbasis or spectral completeness, a determinant of an actual
Laplacian matrix, Kirchhoff's theorem, the admissible measure, Tate
uniformization, Neron local heights, the specialization of the three
two-torsion sections, Arakelov intersections, Faltings--Hriljac, the
arithmetic Hodge index, or abc.  The matrix-tree and Kirchhoff definitions in
Lean are explicitly named `...Formula`; they record scalar outputs rather
than claiming those missing identifications.

Standard paper references for the interpretation are Zhang's admissible
pairing on a curve, Faltings' arithmetic-surface intersection theory,
Hriljac's height/intersection theorem, and the semistable/Tate-curve
calculations in the literature on Neron models.  This audit used those
standard formulas only at paper level and made no online query.
