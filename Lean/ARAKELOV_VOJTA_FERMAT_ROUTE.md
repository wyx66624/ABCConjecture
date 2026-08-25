# An Arakelov--Vojta/Fermat-cover route to `abc`

**Status:** offline research note; no form of Vojta's conjecture or the
`abc` conjecture is assumed.  All equalities below are either elementary or
are explicitly labelled as geometric input still to be constructed.

## 1. Audit of the present formalization

The relevant unconditional Lean results already in the repository are:

1. `ABCPoint.normalizedLogHeight_lambda` and
   `ABCPoint.normalizedLogHeight_one_sub_lambda`: for a primitive positive
   triple `a+b=c` and `lambda=a/c`,

   ```text
   h(lambda) = h(1-lambda) = log c.
   ```

2. `abcFrey_Δ` and the theorems in `FreyDiscriminantConductor`: the integral
   Frey model has discriminant `16 a^2 b^2 c^2`, and its radical differs from
   `rad(abc)` only by a bounded factor supported at `2`.  This is a genuine
   support comparison, not a proof of an elliptic conductor estimate.

3. `ConcreteGenEllTripodCover`: over
   `K[t,t^{-1},(1-t)^{-1}]`, adjoining `x^n=t` and then
   `y^n=1-t` gives a finite etale algebra, free of rank `n^2`.

4. `ConcreteFermatBelyiRamification`: the coordinate fibres of
   `beta[X:Y:Z]=[X^n:Z^n]` lie over `0,1,infinity`; away from them the cover is
   finite etale of rank `n^2`, while locally its parameters satisfy
   `t=x^n`, `1-t=y^n`, and `1/t=(Z/X)^n`.

5. `ConcreteProjectiveFermatScheme` and its chart modules construct the
   homogeneous Fermat `Proj` and identify the standard affine charts.  The
   current smoothness module proves smoothness in odd positive degree.  The
   generic theorem `LocalPowerRamificationIndex` computes ramification index
   `n` from a power law **once** honest DVR local rings and uniformizers have
   been supplied.  At the time of this audit, the three global boundary
   instances and their assembly into a ramification divisor are not yet a
   proved dependency of the height theory.

6. The GenEll modules prove the scalar and finite-prime-counting part of the
   printed prime-selection argument, with an explicit PNT interface.  They do
   not construct a global Belyi descent, a discriminant bound, or a height
   comparison on the Fermat compactification.

Thus none of these results contains a hidden `abc` or Vojta conclusion, but
the missing arithmetic second-main-theorem estimate is not supplied by the
existing geometry.

## 2. Exact logarithmic reformulation of `abc`

Put

```text
X = P^1_Q,                 D = [0]+[1]+[infinity],
lambda = a/c,             1-lambda = b/c.
```

For a primitive positive triple, pairwise coprimality implies that every
finite prime meets at most one component of the integral closure of `D`.
The finite truncated counting function is therefore exactly

```text
N_D^(1)(lambda)
  = sum_{p | abc} log p
  = log rad(abc).
```

There is no finite-place multiplicity on the right: this is precisely what
the superscript `(1)` means.  Since `a,b<c`, the standard absolute
logarithmic height is

```text
h_O(1)(lambda) = log c.
```

On `P^1`, `K_X+D` has degree `-2+3=1` and is linearly equivalent to
`O(1)`.  With compatible Weil-height normalizations,

```text
h_{K_X+D}(lambda) = h_O(1)(lambda) + O(1).
```

Consequently the logarithmic `abc` inequality is exactly the rational-point
truncated second-main-theorem inequality on the log curve `(X,D)`:

```text
h_{K_X+D}(lambda)
  <= (1+epsilon) N_D^(1)(lambda) + O_epsilon(1).
```

The usual Vojta-shaped form is

```text
h_{K_X+D}(lambda)
  <= N_D^(1)(lambda) + eta h_O(1)(lambda) + O_eta(1).
```

Choosing `eta=epsilon/(1+epsilon)` and moving `eta*h` to the left gives
`1/(1-eta)=1+epsilon`.  Hence the small coefficient must enter through a
genuinely sublinear height error (or an equivalent arithmetic estimate); it
cannot be manufactured merely by renaming the radical.

## 3. The Fermat cover and its global numerical geometry

Let `n>0`, in characteristic zero, and let

```text
C_n : X^n + Y^n = Z^n,
beta_n : C_n -> P^1,       [X:Y:Z] |-> [X^n:Z^n].
```

Over the punctured tripod this is the two-step Kummer cover already
formalized, so `deg(beta_n)=n^2`.  Over an algebraic closure the three
boundary fibres each consist of `n` points and every such point has
ramification index `n`:

```text
beta_n^{-1}(0)       : X=0,  (Y/Z)^n=1,
beta_n^{-1}(1)       : Y=0,  (X/Z)^n=1,
beta_n^{-1}(infinity): Z=0,  (Y/X)^n=-1.
```

Therefore, writing `D_n=(beta_n^{-1}D)_red`,

```text
deg D_n = 3n,
R_beta = (n-1)D_n,
deg R_beta = 3n(n-1).
```

Riemann--Hurwitz gives

```text
2g(C_n)-2 = -2n^2 + 3n(n-1) = n^2-3n,
g(C_n)    = (n-1)(n-2)/2.
```

More importantly, the logarithmic ramification cancels exactly:

```text
K_{C_n}+D_n
 = beta_n^* K_X + R_beta + D_n
 = beta_n^* K_X + nD_n
 = beta_n^*(K_X+D).
```

Taking degrees gives

```text
deg(K_{C_n}+D_n) = (n^2-3n)+3n = n^2
                  = deg(beta_n) deg(K_X+D).
```

This identity is the global form of the three local power laws.  The Lean
theorem introduced with this note proves its complete integer arithmetic
and connects the cover degree to the already formalized rank `n^2`; it does
not pretend that Mathlib already has the divisor/genus theory needed to turn
the numerical identity into a scheme-level Riemann--Hurwitz theorem.

## 4. Height pullback: what is gained and what is not

For an affine point `(x,y)` over a number field `L`, with
`x^n+y^n=1`, set `t=x^n`.  Absolute logarithmic height satisfies the exact
identities

```text
h_L(t)   = n h_L(x),
h_L(1-t) = n h_L(y).
```

These are unconditional consequences of the product formula and are the
first new Lean height-pullback theorems on this route.  If `t=lambda` is
rational, one additionally needs extension-invariance of the normalized
height to identify `h_L(t)` with `h_Q(lambda)`; that theorem is not presently
available in the local `Heights` package and must be added separately.

Functoriality must be normalized carefully.  It says

```text
h_{beta_n^*(K_X+D)}(P) = h_{K_X+D}(beta_n(P)) + O(1),
```

not `n^2` times the height of the image.  The factor `n^2` is the degree of
the pulled-back divisor and appears only when comparing it with a fixed
degree-one height on `C_n`.

## 5. Different, field discriminant, and conductor terms

At a geometric boundary point in residue characteristic prime to `n`, the
power law is tame.  Its local different exponent is `n-1`.  Thus the
geometric different has degree `3n(n-1)`, exactly the ramification term in
Riemann--Hurwitz.

For an arithmetic lift of `lambda`, the field

```text
L = Q(x,y),       x^n=lambda,       y^n=1-lambda
```

has degree at most `n^2`.  At a prime `p` not dividing `n`, a Kummer equation
with valuation `m` has ramification index `n/gcd(n,m)` (after the standard
tame/root-of-unity base hypotheses).  In particular, when `gcd(n,m)=1`, the
normalized different contribution is of size `(1-1/n) log p`, rather than
an error tending to zero.  Primes dividing `n` add wild terms.  Globally the
relative discriminant is supported on primes dividing `nabc`, but obtaining
the sharp normalized bound requires an actual number-field/Kummer different
calculation, not just the geometric fibre equations.

The analogous elliptic/Frey statement is also sharply delimited: the current
Lean code controls the radical of the displayed Weierstrass discriminant,
but has not identified the minimal conductor at every place, especially at
`2`.

## 6. Why the cover alone cannot create `epsilon`

The tempting argument is to let `n` grow and hope that division by the cover
degree makes the coefficient of the counting term small.  The log-canonical
identity rules out that mechanism:

```text
deg(K_{C_n}+D_n) / deg(beta_n) = 1
```

for every `n>0`.  Both the main logarithmic divisor and its pullback scale by
the same `n^2`.  Hence an inequality whose counting coefficient is a fixed
`alpha>1` retains coefficient `alpha` after degree normalization; only its
additive constant is divided by `n^2`.  For any
`0<epsilon<alpha-1`, no choice of `n` turns `alpha` into `1+epsilon`.

There is a second obstruction: lifting rational `lambda` produces algebraic
points of degree up to `n^2`, and the normalized field-discriminant term
records the Kummer ramification at the same primes counted by
`rad(abc)`.  Omitting this term is exactly the invalid step in a naive
covering proof.

Therefore the Fermat cover is useful for organizing ramification and for
possibly diluting a *separately proved* ample-height error, but it cannot by
itself prove `abc`.  The required `epsilon` must come from a uniform
arithmetic theorem: a truncated second main theorem/Vojta inequality with
controlled algebraic degree and discriminant, or a genuinely new substitute
with the same strength.

## 7. First formal target and the exact next gap

The accompanying Lean module will prove, without any conjectural field:

1. `log rad(abc)` is exactly the sum of `log p` over the finite truncated
   tripod support;
2. normalized Weil height is exactly multiplicative under `x |-> x^n`;
3. the two Fermat coordinates satisfy the corresponding exact height
   pullback identities;
4. the complete Riemann--Hurwitz and log-canonical **numerical** identities;
5. the ratio of log-canonical degree to cover degree is identically one, so
   the bare covering-degree trick has an explicit coefficient lower bound.

After these results, the first missing implication toward `abc` is precise:
construct and prove a uniform arithmetic inequality on the lifted Fermat
points that controls the normalized field discriminant and truncated
boundary count while contributing an arbitrarily small multiple of a
degree-one height.  That statement is essentially the unresolved arithmetic
second-main-theorem content; none of the existing Frey, GenEll, or IUT-local
modules supplies it.
