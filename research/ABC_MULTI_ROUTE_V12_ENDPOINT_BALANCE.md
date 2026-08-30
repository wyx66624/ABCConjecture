# ABC multi-route research note v12: endpoint balance transfer

**Author:** ChatGPT  
**Date:** 2026-08-29  
**Base commit:** `ef2d07dda02fe02b60933c3f586df947c3ad5444`

## Status

This note proves an unconditional transfer theorem connecting the current
coefficient-three symmetric-product route to the endpoint/smooth-neighbour
route. It does **not** assert a parameter-free proof or disproof of the abc
conjecture. The theorem removes the previously stated coefficient-two
requirement on every quantitatively balanced abc triple and proves that any
remaining obstruction must be endpoint-degenerate.

The accompanying Lean module formalizes the elementary arithmetic and every
coefficient calculation. It introduces no arithmetic-existence axiom and no
structure field whose conclusion is `ABCConjecture`.

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

The v11 audit used only the universal lower bound

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

## 4. Coefficient three closes a balanced region

### Theorem 4.1: convenient specialization

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

### Corollary 4.2: convenient endpoint localization

Under the same coefficient-three product estimate, any point violating the
conclusion of Theorem 4.1 must satisfy

\[
\log\min(a,b)
<
\left(1-\frac{\epsilon}{2}\right)
\log c.
\]

## 5. The exact critical balance exponent

The preceding specialization is simple but is not coefficient-optimal. The
general transfer formula identifies the exact frontier.

### Definition 5.1

For target abc coefficient `1+epsilon` and relative product error `eta`, put

\[
\boxed{
\tau_*(\epsilon,\eta)
=
\frac{3}{1+\epsilon}-2+\eta.
}
\]

### Theorem 5.2: exact critical transfer

Let `epsilon>0`. Assume

\[
\tau_*(\epsilon,\eta)h\le\log m
\]

and

\[
S\le3R+\eta h+K.
\]

Then

\[
\boxed{
h
\le
(1+\epsilon)R+
\frac{(1+\epsilon)(K+\log2)}{3}.
}
\]

### Proof

Apply Theorem 3.1 with

\[
\tau=\tau_*(\epsilon,\eta),
\qquad
\lambda=3.
\]

By definition,

\[
2+\tau_*(\epsilon,\eta)-\eta
=
\frac{3}{1+\epsilon}.
\]

Therefore

\[
h
\le
\frac{3R+K+\log2}{3/(1+\epsilon)}
=
(1+\epsilon)R+
\frac{(1+\epsilon)(K+\log2)}3.
\]

No coefficient enlargement is used, so this frontier is exact for the scalar
transfer argument. ∎

### Corollary 5.3: sharp endpoint localization

Under the coefficient-three estimate above, every violation of the resulting
`1+epsilon` abc bound must satisfy

\[
\boxed{
\log\min(a,b)
<
\left(
\frac3{1+\epsilon}-2+\eta
\right)
\log c.
}
\]

For `eta=o(1)`, the exponent is

\[
\frac3{1+\epsilon}-2+o(1)
=
1-3\epsilon+O(\epsilon^2)+o(1).
\]

Thus coefficient three closes substantially more than the convenient
`1-epsilon/2` region.

## 6. Uniform sublinear-error form

Define the concrete statement:

> For every `eta>0`, there are constants `H_eta,K_eta` such that every abc
> point with `h>=H_eta` satisfies
> \[
> S\le3R+\eta h+K_\eta.
> \]

No abc conclusion occurs in this definition.

Choosing `eta=epsilon^2`, Theorem 5.2 gives one uniform constant on the eventual
region

\[
\boxed{
\left(
\frac3{1+\epsilon}-2+\epsilon^2
\right)h
\le
\log\min(a,b).
}
\]

The corresponding Lean theorem is

```lean
eventual_criticalBalanced_abc_of_uniformCoefficientThreeSublinearProduct
```

The simpler but weaker specialization is retained as

```lean
eventual_balanced_abc_of_uniformCoefficientThreeSublinearProduct
```

in `EndpointBalanceCoefficientTransfer.lean`.

## 7. Relation to the announced IUT coefficient-three estimate

ArXiv:2503.14510 announces the explicit inequality

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
statement above. Theorem 5.2 would then prove standard abc on every eventual
balanced locus, and the unresolved part would be forced into

\[
\log\min(a,b)
<
\left(
\frac3{1+\epsilon}-2+o(1)
\right)
\log c.
\]

This sharpens the v11 verdict that coefficient three “only gives 3/2”: that
verdict is sharp without balance information, but the smaller endpoint
supplies the missing third height unit on balanced triples.

## 8. Updated multi-route frontier

| Route | Remaining theorem after the exact endpoint-balance transfer |
|---|---|
| IUT / coefficient-three product | Verify or independently prove a uniform coefficient-three estimate with `o(h)` error. This closes every eventual point outside the sharp endpoint region above. |
| Endpoint / smooth-neighbour | Treat only triples whose smaller summand has exponent below `3/(1+epsilon)-2+o(1)`. The remaining problem is now a power-saving additive-endpoint problem. |
| Frey--modified-Szpiro | A source-uniform slope-six estimate still closes all points directly; alternatively it may be targeted only at the sharp endpoint locus. |
| S-unit / Arakelov | A uniform height theorem may likewise be restricted to the endpoint-degenerate locus once the coefficient-three product estimate is established. |

## 9. What remains open

The new theorem is a genuine unconditional advance in the reduction
architecture, but it is not a complete abc proof. A parameter-free closure
still requires at least one of:

1. an independently verified coefficient-three product estimate with uniform
   sublinear error, together with an endpoint theorem;
2. a direct slope-six Frey modified-Szpiro estimate;
3. a direct coefficient-one S-unit/Arakelov height estimate;
4. an unbounded low-radical endpoint family disproving abc.

The central reduction is now sharper: a coefficient-three product estimate
need not be improved to coefficient two everywhere. Its remaining failure set
is rigorously localized to the exact endpoint exponent

\[
\frac3{1+\epsilon}-2+o(1).
\]
