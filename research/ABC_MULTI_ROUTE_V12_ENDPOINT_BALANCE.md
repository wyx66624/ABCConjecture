# ABC multi-route research note v12: endpoint balance transfer

**Author:** ChatGPT  
**Date:** 2026-08-29  
**Base commit:** `ef2d07dda02fe02b60933c3f586df947c3ad5444`

## Status

This note proves an unconditional transfer theorem that connects the current
coefficient-three symmetric-product route to the endpoint/smooth-neighbour
route. It does **not** assert a parameter-free proof or disproof of the abc
conjecture. The new theorem removes the previously stated coefficient-two
requirement on every quantitatively balanced abc triple and proves that any
remaining obstruction must be endpoint-degenerate.

The accompanying Lean module formalizes the elementary arithmetic and all
coefficient calculations. It introduces no arithmetic-existence axiom and no
field whose conclusion is `ABCConjecture`.

## 1. Setup

Let `(a,b,c)` be a positive primitive abc triple:

\[
a+b=c, \qquad \gcd(a,b)=\gcd(b,c)=\gcd(c,a)=1.
\]

Write

\[
h=\log c, \qquad
m=\min(a,b), \qquad
S=\log(abc), \qquad
R=\log\operatorname{rad}(abc).
\]

The previous v11 audit used only the universal lower bound

\[
2h-\log 2\le S.
\]

The new observation retains the smaller endpoint `m` and therefore detects
balance.

## 2. The balance-sensitive product lower bound

### Theorem 2.1

For every positive abc triple,

\[
\boxed{m c^2\le 2abc}
\]

and consequently

\[
\boxed{2h+\log m-\log 2\le S.}
\]

### Proof

Assume first that `a <= b`, so `m=a`. Since

\[
c=a+b\le 2b,
\]

multiplication by the nonnegative quantity `ac` gives

\[
a c^2\le 2abc.
\]

The case `b <= a` is symmetric. All factors are positive, so applying the
increasing function `log` yields

\[
\log m+2\log c\le \log 2+\log(abc),
\]

which is the asserted logarithmic inequality. ∎

This lower bound interpolates between two regimes:

- endpoint triples such as `(1,N,N+1)` have `log m = 0`, recovering only the
  coefficient-two lower corridor;
- balanced triples with `m = c^{1-o(1)}` have
  `S >= (3-o(1))h`.

## 3. General coefficient transfer with balance

### Theorem 3.1

Let `tau`, `lambda`, `eta`, and `K` be real numbers satisfying

\[
\eta<2+\tau.
\]

Suppose an abc point satisfies the balance condition

\[
\tau h\le \log m
\]

and a symmetric-product estimate

\[
S\le \lambda R+\eta h+K.
\]

Then

\[
\boxed{
h\le
\frac{\lambda R+K+\log 2}{2+\tau-\eta}.
}
\]

### Proof

Theorem 2.1 and the balance condition give

\[
(2+\tau)h-\log2
\le 2h+\log m-\log2
\le S.
\]

Combining this with the assumed upper estimate gives

\[
(2+\tau-\eta)h
\le
\lambda R+K+\log2.
\]

The denominator is positive by hypothesis, so division proves the theorem.
∎

This is an exact scalar formula: no asymptotic notation and no hidden
constant are used.

## 4. Coefficient three closes the balanced region

### Theorem 4.1

Fix `0 < epsilon <= 1`. Assume

\[
\left(1-\frac{\epsilon}{2}\right)h
\le
\log m
\]

and

\[
S
\le
3R+\frac{\epsilon}{2}h+K.
\]

Then

\[
\boxed{
h
\le
(1+\epsilon)R+
\frac{K+\log2}{3-\epsilon}.
}
\]

### Proof

Apply Theorem 3.1 with

\[
\tau=1-\frac{\epsilon}{2},
\qquad
\eta=\frac{\epsilon}{2},
\qquad
\lambda=3.
\]

This gives

\[
h
\le
\frac{3R+K+\log2}{3-\epsilon}.
\]

Since `0 < epsilon <= 1`,

\[
\frac3{3-\epsilon}
\le 1+\epsilon,
\]

because this is equivalent to

\[
0\le\epsilon(2-\epsilon).
\]

The conductor logarithm `R` is nonnegative, so the coefficient can be enlarged
to `1+epsilon`, proving the result. ∎

### Corollary 4.2: endpoint localization

Under the same coefficient-three product estimate, any point violating the
conclusion of Theorem 4.1 must satisfy

\[
\boxed{
\log\min(a,b)
<
\left(1-\frac{\epsilon}{2}\right)
\log c.
}
\]

Equivalently,

\[
\min(a,b)<c^{1-\epsilon/2}.
\]

Thus the coefficient-three route and the endpoint route are complementary:
coefficient three already handles the balanced locus; only a quantitatively
short additive endpoint remains.

## 5. Uniform sublinear-error form

Define the concrete statement:

> For every `eta>0`, there are constants `H_eta,K_eta` such that every abc
> point with `h>=H_eta` satisfies
> \[
> S\le3R+\eta h+K_\eta.
> \]

No abc conclusion occurs in this definition. Theorem 4.1 immediately implies
that, for every `0<epsilon<=1`, one uniform constant controls every sufficiently
large point in the balanced region

\[
\log m
\ge
\left(1-\frac{\epsilon}{2}\right)h.
\]

This implication is formalized as

```lean
eventual_balanced_abc_of_uniformCoefficientThreeSublinearProduct
```

in `EndpointBalanceCoefficientTransfer.lean`.

## 6. Relation to the announced IUT coefficient-three estimate

ArXiv:2503.14510 states the explicit inequality

\[
S\le3R+8\sqrt{S\log S}
\qquad(S\ge700).
\]

The repository does not certify the IUT proof of that statement, so it is not
used as a Lean assumption or accepted theorem here. Nevertheless, the new
transfer identifies its exact potential consequence.

For positive abc points, `a,b<=c`, hence

\[
S=\log(abc)\le3\log c=3h.
\]

Therefore

\[
\sqrt{S\log S}=o(h).
\]

Consequently, **if** the announced coefficient-three inequality is valid with
the displayed quantifiers, then it supplies the uniform sublinear product
statement above, and Theorem 4.1 proves standard abc on every eventual balanced
locus. The unresolved part is forced into the endpoint region

\[
\min(a,b)<c^{1-\delta}
\]

for a fixed positive `delta` depending on the target epsilon.

This is stronger than the v11 verdict that coefficient three “only gives
3/2”: that verdict is sharp without balance information, but the smaller
endpoint supplies exactly the missing third height unit on balanced triples.

## 7. Updated multi-route frontier

The four routes now interact as follows.

| Route | Remaining theorem after the endpoint-balance transfer |
|---|---|
| IUT / coefficient-three product | Verify or independently prove a uniform coefficient-three estimate with `o(h)` error. This would close every eventual balanced triple. |
| Endpoint / smooth-neighbour | Treat only triples with `min(a,b)<c^{1-delta}`. The small summand is now an explicit power-saving short gap rather than an arbitrary abc point. |
| Frey--modified-Szpiro | A source-uniform slope-six estimate still closes all points directly; alternatively it may be targeted only at the endpoint locus left by the product estimate. |
| S-unit / Arakelov | The uniform height problem may now be restricted to the endpoint-degenerate locus if the coefficient-three product theorem is established. |

## 8. What remains open

The new theorem is a genuine unconditional mathematical advance in the
reduction architecture, but it is not a complete abc proof. A parameter-free
closure still requires at least one of:

1. an independently verified coefficient-three product estimate with uniform
   sublinear error, together with an endpoint theorem;
2. a direct slope-six Frey modified-Szpiro estimate;
3. a direct coefficient-one S-unit/Arakelov height estimate;
4. an unbounded low-radical endpoint family disproving abc.

The important reduction is that a coefficient-three product estimate no longer
needs to be improved to coefficient two everywhere: its remaining failure set
is now rigorously localized to a power-saving endpoint region.
