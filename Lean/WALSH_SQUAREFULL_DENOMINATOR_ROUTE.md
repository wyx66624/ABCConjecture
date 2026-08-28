# Walsh squarefull-denominator route to a strict abc slope

**Author:** ChatGPT  
**Status:** deterministic mathematics implemented in Lean; kernel status determined by branch CI.

## 1. Source theorem

P. G. Walsh proves that if the Mordell curve

\[
E_p:\quad Y^2=X^3-432p^2
\]

has positive rank, then it produces infinitely many pairwise coprime integer
solutions

\[
x^3+y^3=p^4z^3,
\]

with the relevant construction forcing `p | z`. These give primitive
3-powerful abc triples and recover the known critical exponent-one boundary.

The present module does not formalize the Mordell-Weil construction. It starts
from one explicit integral solution with all primitive conditions recorded.

## 2. Squarefull denominator amplification

Assume additionally that `z` is 2-full. Then every prime of `z` occurs with
exponent at least two, hence every prime of `z^3` occurs with exponent at least
six. Because `p | z`, multiplication by `p^4` introduces no new prime support.
Therefore

\[
p^4z^3
\]

is 6-full, not merely 4-full.

The three abc coordinates consequently have fullness signature

\[
(3,3,6).
\]

## 3. Exact deterministic inequality

For the primitive point

\[
(a,b,c)=(x^3,y^3,p^4z^3),
\]

one has

\[
\operatorname{rad}(a)^3\le a,
\qquad
\operatorname{rad}(b)^3\le b,
\qquad
\operatorname{rad}(c)^6\le c.
\]

By radical submultiplicativity,

\[
\operatorname{rad}(abc)^6
\le
\operatorname{rad}(a)^6
\operatorname{rad}(b)^6
\operatorname{rad}(c)^6
\le a^2b^2c.
\]

Since `a,b<c`,

\[
\boxed{\operatorname{rad}(abc)^6\le c^5.}
\]

Taking logarithms gives

\[
\boxed{6\,N\le5\,H,}
\]

where `H=log c` and `N=log rad(abc)`. Thus an unbounded family of such points
contradicts abc, because the fixed conductor slope is `5/6<1`.

## 4. The exact remaining open input

The entire counterexample route is reduced to the following statement.

> For at least one odd prime `p` for which `E_p` has positive rank, the Walsh
> family contains an unbounded subsequence whose reduced denominator
> coordinate `z` is 2-full.

This is an arithmetic problem about numerator/denominator divisibility in
multiples of a rational point on a Mordell curve. It should be attacked through
elliptic divisibility sequences, formal-group valuation formulas, primitive
divisors, and the cancellation in Walsh's explicit rational transformation.

Merely making the denominator `d` of the elliptic x-coordinate squarefull is
not sufficient without controlling the additional numerator factors and
lowest-term cancellation in the transformed `z` coordinate.

## 5. Boundary and trust

The Lean module proves only the deterministic transfer from a squarefull Walsh
datum to the strict `(3,3,6)` abc slope and the quantified contradiction for an
unbounded family. It introduces no Mordell-Weil rank axiom, no squarefull
denominator existence field, no `sorry`, and no target-equivalent assumption.

The source theorem is cited in the research note but is not silently installed
as an unconditional Lean constant. A future source formalization must either
construct the relevant elliptic points or use a precisely audited accepted
external theorem interface.
