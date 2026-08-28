# Common k-power core gap obstruction

**Author:** ChatGPT  
**Status:** mathematical proof implemented in Lean; kernel status determined by branch CI.

## 1. Statement

Let

\[
b=sx^k,\qquad c=sy^k,
\]

where `s>0`, `x<y`, and `k>0`. Then

\[
c-b=s(y^k-x^k)\ge s x^{k-1}.
\]

More precisely, the Lean theorem proves the denominator-free height form

\[
\boxed{s\,b^{k-1}\le(c-b)^k.}
\]

For `k>=2`, this rules out

\[
(c-b)^k<b^{k-2}.
\]

That strict inequality is exactly the integral form of a gap exponent below

\[
1-\frac{2}{k},
\]

the margin required after charging the two endpoint radical costs
`1/k+1/k`.

## 2. Proof

Since `x<y`, one has `x+1<=y`. Also

\[
x^{k-1}\le y^{k-1}.
\]

Therefore

\[
x^k+x^{k-1}
=x^{k-1}(x+1)
\le y^{k-1}y
=y^k,
\]

so

\[
x^{k-1}\le y^k-x^k.
\]

Multiplication by `s` gives

\[
sx^{k-1}\le sy^k-sx^k=c-b.
\]

Raising to the `k`th power and using

\[
(sx^{k-1})^k=s(sx^k)^{k-1}=s b^{k-1}
\]

yields the boxed inequality.

If `(c-b)^k<b^{k-2}`, then positivity of `s` gives

\[
b^{k-2}\le b^{k-1}\le s b^{k-1}\le(c-b)^k,
\]

a contradiction.

## 3. Route consequence

A proposed abc counterexample construction using two nearby k-full numbers
cannot keep the same residual k-power core. For cubefull endpoints this gives

\[
(c-b)^3\ge b,
\]

so the required strict cubic gap `(c-b)^3<b` is impossible. For fourth-power
endpoints it gives

\[
(c-b)^4\ge b^2.
\]

Thus any surviving k-full-neighbour route must vary the residual core, use
unequal fullness exponents, or obtain additional radical saving not explained
by bare k-fullness.

## 4. Boundary

The theorem eliminates only the common-core subroute. It does not exclude all
nearby powerful numbers, does not assume a distribution theorem, and does not
prove or disprove abc by itself. No target-equivalent axiom or existence field
is introduced.
