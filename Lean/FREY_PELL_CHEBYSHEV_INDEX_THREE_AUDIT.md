# The Chebyshev shifted-square residual: exact elimination of index three

## Abstract

In the four-consecutive-product Pell construction, let

\[
 \eta=Z+W\sqrt D=\varepsilon_D^k,
 \qquad Z=\mathcal T_k(T),
\]

where \(T>1\) is the first coordinate of the fundamental norm-one unit and
\(\mathcal T_k\) is the first-kind Chebyshev polynomial.  The extra identity

\[
 4Z+5=(2b+3)^2
\]

leaves the shifted-square equation

\[
 y^2=4\mathcal T_k(T)+5.                              \tag{0.1}
\]

This note makes one genuine reduction.  For \(k=3\), (0.1) is equivalent,
under \(X=4T\), \(Y=2y\), to the integral-point problem

\[
 E:\quad Y^2=X^3-12X+20,                              \tag{0.2}
\]

the elliptic curve 216a1.  A complete Magma `IntegralPoints` computation,
independently corroborated by LMFDB, gives

\[
 X\in\{-4,-2,1,2,4,10,22,89\}.                       \tag{0.3}
\]

The only positive member divisible by four is \(X=4\), hence \(T=1\).
Consequently (0.1) has no solution at index three for \(T>1\).  Chebyshev
composition then gives the stronger scalar conclusion

\[
 3\nmid k                                                     \tag{0.4}
\]

for every positive-index solution of (0.1) with \(T>1\).

This is an external exact-computation result, not a Lean-kernel proof of
elliptic integral-point completeness.  The companion Lean file verifies the
algebra, the finite-list filter, Chebyshev composition and the implication
from an explicit external-completeness proposition to (0.4).  It introduces
no unproved arithmetic assertion as a constant.

Index five remains open in this audit.  Its genus-two model has Jacobian rank
bound equal to the genus in the reported Magma run, and
`RationalPointsGenus2` explicitly returned `false` for completeness.  No
claim that \(k=1\) universally is made, and no `abc`, GRH, BSD or other open
conjecture is used.

## 1. The residual equation and prime composition

The first-kind Chebyshev polynomials satisfy

\[
 \mathcal T_0(X)=1,\qquad \mathcal T_1(X)=X,
 \qquad \mathcal T_{n+2}(X)=2X\mathcal T_{n+1}(X)-\mathcal T_n(X), \tag{1.1}
\]

and

\[
 \mathcal T_{mn}(X)=\mathcal T_m(\mathcal T_n(X)).     \tag{1.2}
\]

For integers \(T>1\), (1.1) shows inductively that

\[
 1\le \mathcal T_n(T)<\mathcal T_{n+1}(T)\quad(n\ge0). \tag{1.3}
\]

Suppose (0.1) holds and a prime \(p\mid k\).  Write \(k=pm\).  If
\(k>0\), then \(m>0\), and (1.2)--(1.3) turn the same equation into

\[
 y^2=4\mathcal T_p(X)+5,
 \qquad X=\mathcal T_m(T)>1.                          \tag{1.4}
\]

Thus the universal problem reduces exactly to prime indices.  In the
four-consecutive-product route the preceding parity argument already makes
\(k\) odd.  After the present computation, a counterexample therefore has a
prime divisor \(p\ge5\), and in fact \(3\nmid k\).

This reduction is uniform and elementary.  It must not be confused with a
fixed-parameter integral-point theorem: both the prime \(p\) and the base
\(X\) in (1.4) may move.

## 2. Index three and the curve 216a1

The cubic is

\[
 \mathcal T_3(T)=4T^3-3T.
\]

Hence (0.1) at index three is

\[
 y^2=16T^3-12T+5.                                    \tag{2.1}
\]

Putting \(X=4T\) and \(Y=2y\) gives, in both directions subject to the
obvious divisibility conditions,

\[
 Y^2=4y^2=64T^3-48T+20=X^3-12X+20.                  \tag{2.2}
\]

Equation (2.2) is the minimal and simplified equation of Cremona curve
216a1 (LMFDB label 216.a1).  The exact integral-point list (0.3) immediately
gives

\[
 X>0,\quad 4\mid X \quad\Longrightarrow\quad X=4.     \tag{2.3}
\]

Since \(X=4T\), every positive integral solution of (2.1) has \(T=1\),
where indeed \(y=\pm3\).  There is therefore no solution for \(T>1\).

Combining this with Section 1 proves (0.4): if \(3\mid k\), put
\(X=\mathcal T_{k/3}(T)>1\) and obtain a forbidden index-three solution.
Notice that this conclusion does not need the earlier fact that \(k\) is
odd; it holds for every positive \(k\).

## 3. Exact external computation and trust boundary

### 3.1 Magma transcript

The following input was run in the official University of Sydney online
Magma calculator.  The reported version was **Magma V2.29-9**, with random
seed `3576775659`; the completed job reported 0.450 seconds and 85.16 MB.

```magma
Q := Rationals();
E := EllipticCurve([ Q | 0, 0, 0, -12, 20 ]);
print CremonaReference(E);
lo, hi := RankBounds(E); print [lo, hi];
gens, rank_proved, saturated := Generators(E);
print gens; print rank_proved; print saturated;
pts := IntegralPoints(E : FBasis := gens);
xs := Sort([ Integers() | Integers()!(P[1]/P[3]) : P in pts ]);
print xs;
assert xs eq [ -4, -2, 1, 2, 4, 10, 22, 89 ];
assert [ x : x in xs | x gt 0 and IsDivisibleBy(x,4) ] eq [4];
```

Output:

```text
216a1
[ 1, 1 ]
[ (-2 : 6 : 1) ]
true
true
[ -4, -2, 1, 2, 4, 10, 22, 89 ]
```

There was no assertion failure.  The rank interval is exactly \([1,1]\),
the displayed free generator is \((-2:6:1)\), and the two booleans report
that the rank is proved and that the supplied Mordell--Weil basis is
saturated.  Magma's `IntegralPoints` handbook entry states the completeness
semantics of the returned integral points (with the documented sign
convention) and explains the `FBasis` input.

The exact [LMFDB page for 216.a1](https://www.lmfdb.org/EllipticCurve/Q/216/a/1)
independently records the same equation, rank one, generator \((-2,6)\), and
the integral \(X\)-coordinates in (0.3).

Primary software documentation:

* [Magma handbook: integral points on elliptic curves](https://magma.maths.usyd.edu.au/magma/handbook/text/1567).
* [Magma handbook: rational points on genus-two curves](https://magma.maths.usyd.edu.au/magma/handbook/text/1613).

### 3.2 What Lean does and does not certify

The companion file defines the proposition

```lean
def MagmaIntegralXCertificate216a1 : Prop :=
  ∀ X Y : ℤ, Y ^ 2 = X ^ 3 - 12 * X + 20 →
    X ∈ magma216a1XCoordinates
```

but supplies no proof term for it.  Every theorem that uses integral-point
completeness accepts this proposition explicitly as a hypothesis.  Lean then
kernel-checks:

1. the cubic substitution (2.2);
2. the finite filter (2.3), including `X % 4 = 0`;
3. strict growth for integer Chebyshev evaluations at \(T>1\);
4. the composition step; and
5. `MagmaIntegralXCertificate216a1 -> 3 ∤ k`.

Thus the logical interface is transparent.  Trusting (0.4) requires trusting
the cited exact external computation/database, while none of that trust is
silently placed inside Lean's kernel.

## 4. Index five: a documented non-complete boundary

For the next possible prime,

\[
 \mathcal T_5(T)=16T^5-20T^3+5T,
\]

so the affine curve is

\[
 C_5:\quad y^2=64T^5-80T^3+20T+5.                 \tag{4.1}
\]

The corresponding official-calculator input was:

```magma
Qx<x> := PolynomialRing(Rationals());
f := 64*x^5 - 80*x^3 + 20*x + 5;
C := HyperellipticCurve(f);
print Genus(C);
print RankBound(Jacobian(C));
pts, all_known, searched_to := RationalPointsGenus2(C);
print all_known;
print searched_to;
print pts;
```

Output under Magma V2.29-9:

```text
2
2
false
20000
{@ (1 : 0 : 0), (-1 : -1 : 1), (-1 : 1 : 1),
   (1 : -3 : 1), (1 : 3 : 1) @}
```

The decisive word is `false`: Magma did **not** certify that all rational
points were known.  The search found only the point at infinity and points
with affine \(T=\pm1\), but that observation is not a completeness theorem.
Moreover the returned Jacobian rank bound is \(2\), equal to the genus, so
the standard rank-strictly-less-than-genus Chabauty condition is not
available from this output.  This note therefore leaves \(p=5\) open.

## 5. Why the standard fixed-parameter theorems do not finish the problem

The computation above is a single-prime integral-point calculation.  It does
not become a proof for every prime by citing a finiteness theorem.

* Bennett--Walsh Theorem 1.2 fixes squarefree \(q,d>1\) before proving that
  at most one Pell coordinate is \(q\) times a square.  Its conclusion
  identifies a divisibility index for those fixed coefficients; it neither
  ranges uniformly over the moving prime degree in (1.4) nor treats the
  affine shift \(+5\).
* Cohn's classifications of square terms concern fixed Fibonacci/Lucas
  recurrences.  Here the recurrence itself varies with the integer base
  \(T\), and the target is not a square term but \(4\mathcal T_p(T)+5\).
* Ljunggren's classical theorem fixes the nonsquare coefficient \(D\) in
  \(x^2-Dy^4=1\) before bounding the number of positive solutions; its
  specialization giving the square Pell numbers fixes the recurrence
  parameters \((P,Q)=(2,-1)\).  Neither quantifier pattern contains the
  moving prime degree and affine shift in (1.4).
* Bilu--Hanrot--Voutier prove that every Lucas or Lehmer number of index
  \(n>30\) has a primitive divisor.  A primitive divisor records first
  appearance; it does not prevent the shifted value
  \(4\mathcal T_p(T)+5\) from being a square, nor does it force a new prime
  into that shifted value with odd valuation.
* A Thue, Thue--Mahler, Siegel or Baker theorem can handle each fixed prime
  \(p\) (and fixed support where relevant).  Its curve, degree, coefficient
  heights and constants then depend on \(p\).  Taking a union over moving
  \(p\) is not a uniform theorem and supplies no coefficient-one radical
  estimate.

The smallest remaining Chebyshev statement is therefore:

> **Prime-index residual proposition.**  For every odd prime \(p\ge5\) and
> every integer \(T>1\), the integer \(4\mathcal T_p(T)+5\) is not a square.

For the actual four-consecutive Pell orbit one may add its congruence
conditions on \(T\); the present audit did not find a local argument that
turns them into a proof.  Proving this proposition would force the unit index
to be \(k=1\).  The proposition is not proved here.

Finally, eliminating the factor three from \(k\) is structural but does not
alter the radical ledger.  It gives neither a height bound on a remaining
prime divisor of \(k\) nor the missing lower bound for the moving square-base
radical.  Therefore it does not by itself approach
\(\log\operatorname{rad}(b(b+1))\sim H\).

## 6. Formal companion

`IUTThreeClosures/FreyPellChebyshevIndexThreeAudit.lean` formalizes the
elementary and conditional statements listed in Section 3.2 and the exact
quintic expansion (4.1).  It does not formalize elliptic or genus-two
integral-point algorithms, the external Magma transcript, LMFDB, any theorem
from the cited literature, radicals, or `abc`.

## References

* M. A. Bennett and G. Walsh, *The Diophantine equation
  \(b^2X^4-dY^2=1\)*, Proc. Amer. Math. Soc. 127 (1999), 3481--3491,
  especially Theorem 1.2:
  <https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf>.

* J. H. E. Cohn, *Square Fibonacci numbers, etc.*, Fibonacci Quarterly 2
  (1964), 109--113:
  <https://www.fq.math.ca/Scanned/2-2/cohn.pdf>.

* W. Ljunggren, *Über die Gleichung \(x^4-Dy^2=1\)*, Arch. Math.
  Naturvid. 45 (1942), no. 5, 61--70.  The fixed-\(D\) theorem and its
  original bibliographic data are also summarized in the literature record
  at <https://eudml.org/doc/248894>.

* Yu. Bilu, G. Hanrot and P. M. Voutier, *Existence of primitive divisors of
  Lucas and Lehmer numbers*, J. reine angew. Math. 539 (2001), 75--122,
  DOI 10.1515/crll.2001.080:
  <https://doi.org/10.1515/crll.2001.080>.

* Magma Computational Algebra System, V2.29-9, University of Sydney; the
  exact handbook pages and LMFDB record are linked in Section 3.
