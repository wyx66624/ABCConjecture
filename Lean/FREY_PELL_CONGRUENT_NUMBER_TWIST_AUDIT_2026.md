# The Pell square-base family as integral points on congruent-number twists

## 1. Scope and outcome

This note audits a relation-specific elliptic-curve route to the remaining
Pell square-base problem.  Write

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad
 c_n=s_n^2-2=3r_n^2-1=A_ny_n^2,
\]

where `A_n` is positive and squarefree.  The required estimate is

\[
 \log y_n=o(H_n),
 \qquad H_n=n\log(97+56\sqrt3),
\]

or, equivalently,

\[
 \log A_n\geq (1-o(1))H_n.                       \tag{1.1}
\]

The audit gives a genuine unconditional structural advance, but not (1.1):

1. the two Pell equations map *exactly* to a non-torsion integral point on a
   congruent-number curve;
2. Bennett's 1999 theorem on three consecutive prescribed square classes
   proves that the squarefree coefficients `A_n` are pairwise distinct;
3. Chan's 2024 theorem then proves the new counting consequence
   \[
    \#\{n:3A_n\leq X\}
       \ll_\epsilon X(\log X)^{-1/4+\epsilon};    \tag{1.2}
   \]
4. the desired pointwise estimate is exactly an eventual exclusion of the
   “large integral points” in Chan's terminology.  Chan proves that exclusion
   only under `abc`; unconditionally she bounds their number in each fixed
   `2E_D(Q)` coset, which does not control a sequence in which `D=3A_n` moves.

Thus modularity, Galois representations, Thue--Mahler algorithms, and finite
CAS certificates do not currently close (1.1).  The smallest remaining input
is an **orbitwise no-large-integral-point theorem**, stated precisely in
Section 9.  No form of `abc`, Szpiro, Frey--Mazur, BSD, Hall--Lang, or another
open conjecture is used as a conclusion here.

## 2. Exact simultaneous-Pell and elliptic-curve identities

The square-base factorization gives the two consecutive equations

\[
 s_n^2-3r_n^2=1,
 \qquad
 3r_n^2-A_ny_n^2=1.                              \tag{2.1}
\]

Equivalently, the three consecutive positive integers are

\[
 A_ny_n^2,\qquad 3r_n^2,\qquad s_n^2.            \tag{2.2}
\]

Since `3` does not divide `3r_n^2-1`, it does not divide `A_n`.  Hence

\[
 D_n:=3A_n
\]

is squarefree.  Define

\[
 X_n:=9A_nr_n^2,
 \qquad
 Y_n:=9A_n^2s_nr_ny_n.                            \tag{2.3}
\]

Then

\[
 \begin{aligned}
 X_n-D_n&=3A_n^2y_n^2,\\
 X_n+D_n&=3A_ns_n^2,
 \end{aligned}                                   \tag{2.4}
\]

and therefore

\[
 Y_n^2=X_n(X_n-D_n)(X_n+D_n)
      =X_n^3-D_n^2X_n.                            \tag{2.5}
\]

Thus

\[
 P_n=(X_n,Y_n)\in E_{D_n}(\mathbf Z),
 \qquad
 E_D:Y^2=X^3-D^2X.                                \tag{2.6}
\]

Here `Y_n>0`, so `P_n` is not one of the rational `2`-torsion points
`O,(0,0),(D,0),(-D,0)`.  It is consequently a non-torsion integral point.

This is not merely a Jacobian up to an unspecified torsor.  Equations
(2.3)--(2.5) are an integral map with no denominator and are independently
checked in the companion Lean file.

The `2`-descent square classes are also explicit:

\[
 (X_n-D_n,X_n,X_n+D_n)
 \equiv (3,A_n,3A_n)
 \pmod{\mathbf Q^{\times2}}.                      \tag{2.7}
\]

For a fixed `A`, all simultaneous-Pell solutions therefore land in one fixed
coset of `2E_{3A}(Q)`.

## 3. Bennett's uniform uniqueness theorem: a real consequence

Michael Bennett proved the following theorem.

> **Bennett 1999, Theorem 1.2.**  If `a,b,c` are positive integers, then
> \[
>  ax^2-by^2=1,\qquad by^2-cz^2=1
> \]
> has at most one solution `(x,y,z)` in positive integers.

The quantifiers are important: `a,b,c` are arbitrary positive integers; no
finite set of coefficients is fixed in advance.  The conclusion is uniqueness,
not a height estimate.  The proof uses linear forms in logarithms.

Apply it with

\[
 (a,b,c;x,y,z)=(1,3,A_n;s_n,r_n,y_n).             \tag{3.1}
\]

If `A_m=A_n`, both triples solve the same fixed system.  Bennett gives
`s_m=s_n`, and strict growth of the Pell sequence gives `m=n`.  Hence

\[
                 m\ne n\quad\Longrightarrow\quad A_m\ne A_n. \tag{3.2}
\]

This is stronger than a bounded-multiplicity statement and was not obtained
from ordinary radical or Lucas-sequence arguments.

Source: Michael A. Bennett, *On consecutive integers of the form
`ax^2`, `by^2` and `cz^2`*, Acta Arith. 88 (1999), 363--370,
[DOI 10.4064/aa-88-4-363-370](https://doi.org/10.4064/aa-88-4-363-370).
The author's [paper PDF](https://personal.math.ubc.ca/~bennett/paper14.pdf)
states the theorem on its first page.

## 4. Accepted integral-point theorems and their exact quantifiers

### 4.1 Chan 2022: fixed-twist counting, not height exclusion

For squarefree positive `D`, Stephanie Chan studies

\[
 E_D:Y^2=X^3-D^2X.
\]

Her Theorem 1.2 says that, for sufficiently large `D` and every
`R in E_D(Q)`, the number of integral points in

\[
 E_D(\mathbf Z)\cap(R+2E_D(\mathbf Q))
\]

is less than

\[
 30+(1.89)^r+19r^{1/3},
 \qquad r=\operatorname{rank}E_D(\mathbf Q).      \tag{4.1}
\]

More sharply for height, fix the small positive constant used in that paper
and put

\[
 L_D(R)=\{P\in E_D(\mathbf Z)\cap(R+2E_D(\mathbf Q)):
              X(P)>D^{2(1+\epsilon)}\}.
\]

Theorem 1.3 proves unconditionally

\[
 \#L_D(R)\leq30                                  \tag{4.2}
\]

for every sufficiently large `D` and every coset `R`.  It proves

\[
 L_D(R)=\varnothing                               \tag{4.3}
\]

only **assuming the `abc` conjecture**.

As printed, Theorem 1.3 uses one fixed sufficiently small positive
\(\epsilon\).  Consequently the bare statement (4.3), by itself, gives only
one fixed exponent gap and does **not** imply an estimate with every
\(\eta>0\).  The proof of its conditional branch has a stronger adjustable
form: rerunning the argument with an arbitrary sufficiently small abc
parameter \(\delta>0\) gives

\[
 X\ll_\delta D^{2(1+\delta)/(1-3\delta)}.                 \tag{4.3a}
\]

The exponent on the right tends to \(2\) with \(\delta\).  Thus, for each
\(\eta>0\), choosing \(\delta\) so that
\(2(1+\delta)/(1-3\delta)\leq2+\eta\) yields the required
\(\eta\)-dependent constant.  It is this reparameterized abc argument, not
the single fixed-\(\epsilon\) assertion (4.3), that has the full quantifier
strength of the target below.

Theorem 2.1 translates (4.1) to simultaneous Pell equations.  For pairwise
coprime positive `a,b,c,d`, with `D=abcd` sufficiently large, it bounds the
number of positive solutions to

\[
 aX^2-bY^2=d,\qquad bY^2-cZ^2=d
\]

by

\[
 15+(1.89)^r+19r^{1/3}
 \leq 15+(3.58)^{\omega(D)}+12\omega(D)^{1/3}.    \tag{4.4}
\]

Our case has `(a,b,c,d)=(1,3,A,1)`.  Bennett's theorem gives the stronger
bound `1`, but neither result bounds the size of that one solution.

Source: Stephanie Chan, *Integral points on the congruent number curve*,
Trans. Amer. Math. Soc. 375 (2022), 6675--6700,
[DOI 10.1090/tran/8732](https://doi.org/10.1090/tran/8732), especially
Theorems 1.2, 1.3, and 2.1.  The
[accepted manuscript](https://discovery.ucl.ac.uk/id/eprint/10213469/1/2004.03331v2.pdf)
contains the displayed quantifiers.

### 4.2 Chan 2024: a uniform sparse-set theorem

Let

\[
 \mathcal D(X)=\{D\leq X:D>0\text{ squarefree}\}
\]

and let `E_D^*(Z)` denote integral points with nonzero `Y`-coordinate.  Chan's
2024 Theorem 1.3 states that for every `epsilon>0` and every real `k>0`,

\[
 \sum_{D\in\mathcal D(X)}\#E_D^*(\mathbf Z)^k
 \ll_{\epsilon,k}X(\log X)^{-1/4+\epsilon}.       \tag{4.5}
\]

Theorem 1.4 gives, in particular,

\[
 \#\{D\in\mathcal D(X):E_D^*(\mathbf Z)\ne\varnothing\}
 \ll_\epsilon X(\log X)^{-1/4+\epsilon}.         \tag{4.6}
\]

Every `D_n=3A_n` is squarefree and carries the explicit point `P_n`.  By
Bennett injectivity, the map `n -> D_n` is injective.  Substitution into
(4.6) gives the unconditional relation-specific consequence

\[
 \boxed{\#\{n:3A_n\leq X\}
 \ll_\epsilon X(\log X)^{-1/4+\epsilon}.}         \tag{4.7}
\]

This is a genuine global restriction on the moving parity cores.  It is a
counting statement in the ordering by `A`, not a pointwise estimate in the
Pell index `n`.  An injective sequence can visit sparse small values at very
late indices, so (4.7) does not imply `log A_n` is comparable to `n`.

Source: Stephanie Chan, *The average number of integral points on the
congruent number curves*, Adv. Math. 457 (2024), Article 109946,
[DOI 10.1016/j.aim.2024.109946](https://doi.org/10.1016/j.aim.2024.109946),
Theorems 1.3 and 1.4.

## 5. Exact translation of the abc-critical target

Using `c_n+1=3r_n^2`, formula (2.3) becomes

\[
 X_n=3A_n(c_n+1)=3A_n(A_ny_n^2+1),
 \qquad D_n=3A_n.                                 \tag{5.1}
\]

Consequently

\[
 \frac{X_n}{D_n^2}
  =\frac{A_ny_n^2+1}{3A_n}
  =\frac{y_n^2}{3}+\frac1{3A_n},                 \tag{5.2}
\]

and

\[
 \log X_n-2\log D_n
 =2\log y_n-\log3+\log\!\left(1+\frac1{A_ny_n^2}\right).
                                                               \tag{5.3}
\]

Since `log c_n=H_n+O(1)`, the desired estimate is equivalent to either of
the following orbitwise statements:

\[
 \log X_n=(2+o(1))\log D_n,                       \tag{5.4}
\]

or, in epsilon-constant form,

\[
 \forall\eta>0\ \exists C_\eta\ \forall n,
 \qquad \log X_n\leq(2+\eta)\log D_n+C_\eta.     \tag{5.5}
\]

Thus Chan's threshold `X>D^{2(1+epsilon)}` lies at the relevant critical
scale, but one fixed value of `epsilon` is only one member of the family of
estimates in (5.5).  Her unconditional theorem (4.2) says that a fixed
twist/coset contains at most 30 such failures.  In our family every index has
a different twist, so “at most 30 per `D`” permits every `P_n` to be large.
The reparameterized abc argument behind (4.3), summarized in (4.3a), would
close the route for every `eta`; using it would be circular.

## 6. Modular/Frey and Galois-representation audit

### 6.1 Why the usual generalized-Fermat exponent is absent

The relation is of fixed signature `(2,2,1)`:

\[
 3r^2-Ay^2=1.
\]

There is no variable prime exponent `p>=3` whose divisibility removes the
solution primes from a residual conductor.  Treating `A` as a coefficient
leaves its support in the level; treating `y^2` as the power fixes the
residual characteristic at `2`, where the standard high-exponent
level-lowering mechanism is unavailable.

The 2026 preprint of Cazorla García--Koutsianas--Villagra Torcomian develops
Frey hyperelliptic curves for

\[
 Ax^2+By^r=Cz^p
\]

with a fixed prime `r>=5` and a variable prime `p` (their application takes
`p>=7`).  It is a preprint, not an accepted theorem as of this audit, and its
quantifiers do not include `(2,2,1)`.  Even its arbitrary squarefree `A`
conductor calculation does not supply a point-height estimate uniform in
`A`.

### 6.2 What modularity of the actual curve does and does not give

The curves `E_D` are quadratic twists of the CM curve

\[
 E_1:Y^2=X^3-X,
 \qquad j=1728.
\]

Their modularity and compatible Galois representations are accepted.  But
the curve/level changes with `D`, and a Galois representation of `E_D`
contains no unconditional upper bound for the height of a specified
integral point `P in E_D(Z)`.  The local conductor records bad-prime support;
it does not record the multiple of a Mordell--Weil generator represented by
`P`.

For this family Chan proves the explicit unconditional lower canonical-height
bound

\[
 \widehat h(P)\geq\tfrac14\log D-\tfrac12\log2
                                                               \tag{6.1}
\]

for every non-torsion rational point.  This is a lower bound and therefore
has the wrong direction for (5.5).  An upper bound of the required strength
for every relevant integral point is precisely the missing large-point
theorem.  Chan's direct use of `abc` to obtain (4.3) is an exact published
marker of that boundary.

Results on perfect powers in a fixed Lucas sequence via Galois
representations likewise concern an exact `q`-th power and, in their general
uniform form, may assume Frey--Mazur.  Here the exponent is `2`, the
squarefree coefficient moves, and exact-power exclusion sees only `A=1` (or
a separately fixed coefficient).

## 7. Thue--Mahler and logarithmic-form audit

For each fixed `A`, equations (2.1) define a fixed simultaneous-Pell problem
or, equivalently, a fixed genus-one integral-point problem.  Effective
Thue--Mahler and elliptic-logarithm algorithms can in principle solve many
such fixed instances after the binary form, coefficient field, and finite
prime set have been fixed.

That order of quantifiers is

\[
 \forall A\quad\exists C(A)\quad
       \text{all solutions for this `A` have height at most `C(A)`}. \tag{7.1}
\]

The required order and dependence are

\[
 \forall\epsilon>0\quad\exists C_\epsilon\quad\forall A
 \quad \log X\leq(2+\epsilon)\log(3A)+C_\epsilon              \tag{7.2}
\]

for the points selected by the Pell orbit.  A theorem whose constant is an
arbitrary function of `A` cannot be substituted into (7.2).

Bennett's theorem is already a striking uniform use of logarithmic forms:
it improves (7.1) to *at most one solution for every `A`*.  It still makes no
assertion about the height of that solution.  Real quadratic fields can have
fundamental units exponentially large relative to their discriminants, so
uniqueness alone does not impose the coefficient-one dependence in (7.2).

## 8. Accepted computational certificates

For a fixed `A`, Magma/Sage/PARI can verify (2.5), compute local data, perform
descent, and in favorable cases certify all integral points once the needed
Mordell--Weil information is proved.  Bennett's theorem makes a positive
certificate especially clean: after one positive simultaneous-Pell solution
is checked, no second one exists for that `A`.

This does not reduce the asymptotic problem to a finite computation:

* the values `A_n` are pairwise distinct, so there are infinitely many
  moving twists;
* Chan's 2024 theorem proves that these twists lie in a sparse exceptional
  set, not in a finite set;
* no accepted theorem supplies a finite bound `A<=A_0` or `n<=n_0` for all
  possible failures of (5.5);
* a transcript covering `n<=N` or `A<=B` therefore certifies only that finite
  range.

`native_decide` or a CAS kernel may safely certify scalar identities and any
explicit finite range, but it cannot convert (4.2), (4.6), or (7.1) into the
uniform pointwise quantifiers of (7.2).

## 9. Strict boundary and smallest remaining proposition

The new unconditional output of this route is:

\[
 A_m=A_n\Longrightarrow m=n,                      \tag{9.1}
\]

the exact integral-point embedding (2.3)--(2.6), and the sparse-core count
(4.7).  None has the strength of (1.1).

The smallest relation-specific statement which would close the route is:

> **Orbitwise no-large-point proposition.**  For every `eta>0` there is a
> constant `C_eta`, independent of `n`, such that the explicit point (2.3)
> satisfies
> \[
>  \log X_n\leq(2+\eta)\log(3A_n)+C_\eta
>  \qquad\text{for every }n.                       \tag{9.2}
> \]

By (5.2)--(5.3), (9.2) is equivalent, after rescaling epsilon and bounded
terms, to `log y_n=o(H_n)` and to (1.1).  It is strictly narrower than a
Hall--Lang statement for all integral points on all quadratic twists: it asks
only about the single explicit Pell-orbit point on each twist.  It is also
strictly stronger than every accepted counting, rank, modularity, or
fixed-coefficient result audited above.

Accordingly, the modular/Frey, Galois-representation, Thue--Mahler, and
finite-CAS routes are not proofs of the required coefficient-one estimate at
present.  Their exact surviving target is (9.2), not an ordinary-radical
estimate and not merely a bound on the number of solutions.
