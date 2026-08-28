# K-full radical compression and the neighbour exponent budget

**Author:** ChatGPT  
**Status:** mathematical proof implemented in Lean; kernel status determined by branch CI.

## 1. K-full integers

For integers `k >= 1` and `n > 0`, call `n` **k-full** when every prime
`p | n` occurs with multiplicity at least `k`:

\[
v_p(n)\ge k.
\]

Equivalently, every prime divisor satisfies `p^k | n`.

## 2. Radical-compression theorem

The Lean module `IUTThreeClosures/KFullRadicalCompression.lean` proves

\[
\operatorname{rad}(n)^k\mid n,
\qquad
\operatorname{rad}(n)^k\le n,
\]

and consequently

\[
\log\operatorname{rad}(n)
   \le \frac{1}{k}\log n.
\]

### Proof

Since `n` is k-full, its prime factorization is

\[
n=\prod_{p\mid n}p^{e_p},\qquad e_p\ge k.
\]

The radical is

\[
\operatorname{rad}(n)=\prod_{p\mid n}p.
\]

Therefore

\[
\operatorname{rad}(n)^k
 =\prod_{p\mid n}p^k
 \mid \prod_{p\mid n}p^{e_p}=n.
\]

The Lean proof does not take this formula as a new axiom: it compares the
factorization of `rad(n)^k` with the factorization of `n`, using squarefreeness
of the radical and the ordinary factorization criterion for divisibility.
Taking logarithms gives the real inequality.

## 3. Two-endpoint budget

If `b` is r-full and `c` is s-full, then

\[
\operatorname{rad}(b)^r\operatorname{rad}(c)^s\le bc
\]

and

\[
\log\operatorname{rad}(b)+\log\operatorname{rad}(c)
 \le \frac{\log b}{r}+\frac{\log c}{s}.
\]

For coprime neighbours `b < c`, with gap `a=c-b`, the general deterministic
transfer already gives

\[
\operatorname{rad}(abc)
 \le a\operatorname{rad}(b)\operatorname{rad}(c).
\]

If `b` and `c` have the same scale `X` and `a <= X^{theta+o(1)}`, the bare
fullness budget is therefore

\[
\log\operatorname{rad}(abc)
 \le
 \left(\theta+\frac1r+\frac1s+o(1)\right)\log X.
\]

Thus the deterministic disproof threshold is

\[
\boxed{\theta+\frac1r+\frac1s<1.}
\]

## 4. Sharp route diagnostics

- **squarefull–squarefull:** `1/2+1/2=1`. The endpoints alone consume the
  whole abc exponent budget; every positive gap loses. Bare squarefull
  structure cannot prove a counterexample family.
- **squarefull–cubefull:** `1/2+1/3=5/6`. One needs a gap exponent
  `theta < 1/6`.
- **cubefull–cubefull:** `1/3+1/3=2/3`. One needs `theta < 1/3`.
- **r-full–s-full:** one needs a gap below `X^{1-1/r-1/s-o(1)}`.

This is a route-selection theorem, not merely a heuristic. It proves that
Pell constructions producing only two squarefull endpoints cannot reach the
abc-disproof threshold without an additional radical saving beyond
squarefullness. It also identifies square/cube and cube/cube near-collision
problems as the first nontrivial powerful-number targets.

## 5. Remaining Diophantine problem

A decisive counterexample route would establish an unbounded coprime family

\[
b<c,\qquad b\text{ r-full},\quad c\text{ s-full},
\]

with

\[
c-b\le b^{\theta+o(1)},
\qquad
\theta+\frac1r+\frac1s<1.
\]

The present result proves the radical and logarithmic transfer from such a
family to the strict abc exponent gap. It does not assert the existence of
that family.
