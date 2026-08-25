# The rational S-unit/tripod reformulation of abc

## 1. Scope

This note is entirely elementary and offline.  It proves an exact change of
coordinates between positive primitive `abc` triples and rational points of
the tripod

```text
0 < x < 1,                 x + (1-x) = 1.
```

It also isolates the uniform statement which an S-unit, Baker, or Subspace
Theorem argument would actually have to prove.  No finiteness theorem for
S-unit equations, no linear-forms estimate, and no instance of abc is assumed
below.

## 2. Prime support of a rational tripod point

Write a rational number in lowest terms as `q=m/d`, where `d>0`.  Define

```text
supp_Q(q) = primeFactors(|m|) union primeFactors(d),
supp_T(x) = supp_Q(x) union supp_Q(1-x).
```

Thus `q` is an elementary rational S-unit outside a finite prime set `S`
exactly when `supp_Q(q) subset S`.  Consequently both terms in
`x+(1-x)=1` are S-units exactly when `supp_T(x) subset S`.

Let `(a,b,c)` be positive, pairwise coprime, and satisfy `a+b=c`, and put
`lambda=a/c`.  Since `gcd(a,c)=1`, the reduced numerator and denominator of
`lambda` are `a,c`.  Also

```text
1-lambda = b/c,
```

and `gcd(b,c)=1`, so its reduced numerator and denominator are `b,c`.
Therefore

```text
supp_T(lambda)
  = (pf(a) union pf(c)) union (pf(b) union pf(c))
  = pf(a) union pf(b) union pf(c)
  = pf(abc).
```

The last equality uses positivity, so none of the three factors is zero.
Taking the product of this finite set gives exactly `rad(abc)`, and hence

```text
log(prod supp_T(lambda)) = log(rad(abc)).                 (2.1)
```

This is an equality of supports, not merely an inequality of radicals.

## 3. Height and the converse construction

For `0<x<1`, write the reduced fraction as `x=m/d`.  Positivity implies
`m>0`, and `x<1` implies `m<d`.  Set

```text
a=m,       b=d-m,       c=d.
```

Then `a,b,c` are positive and `a+b=c`.  Reducedness gives `gcd(a,c)=1`.
The elementary identities

```text
gcd(a,c-a)=gcd(a,c),       gcd(c-a,c)=gcd(a,c)
```

give pairwise coprimality.  Finally `a/c=x`.  This construction is inverse,
at the rational-coordinate level, to `(a,b,c) |-> a/c`.

The absolute logarithmic Weil height of a reduced positive fraction `m/d`
is `log(max(m,d))`.  In the range `0<m<d` this is `log d`; hence for the
associated abc point

```text
h(x) = log c.                                             (3.1)
```

Equations (2.1) and (3.1) prove the following exact equivalence.

### Uniform rational tripod statement

For every real `epsilon>0`, there is a real constant `C_epsilon`, independent
of `x` and of its prime support, such that every rational `0<x<1` satisfies

```text
h(x) <= (1+epsilon) log(prod supp_T(x)) + C_epsilon.       (3.2)
```

The logarithmic abc conjecture for positive primitive triples holds if and
only if (3.2) holds.  The forward implication uses the converse construction
above.  The reverse implication evaluates (3.2) at `x=a/c` and uses the two
exact identities.

This equivalence is useful diagnostically but does not make (3.2) easier:
the coefficient `1+epsilon` and, crucially, a constant independent of the
varying support are the whole unresolved content.

## 4. Fixed S is not the required quantifier order

For a fixed finite `S`, the classical S-unit question has quantifier shape

```text
for every finite S, the set of solutions supported in S is finite.          (F)
```

Even if (F) is available, abc needs the uniform assertion (3.2), in which the
support varies with the solution and the additive constant is independent of
that support.  The logical gap is not a technicality.

Here is a deliberately abstract countermodel to the invalid implication from
fixed-support finiteness to a uniform linear bound.  Take points `n in N`, set

```text
toySupport(n) = {n},       toyHeight(n)=n.
```

For every fixed finite set `S`, the points with `toySupport(n) subset S` are
exactly the elements of `S`, hence form a finite set.  Nevertheless there are
no real `A,B` for which

```text
toyHeight(n) <= A * card(toySupport(n)) + B
```

for all `n`: the right side is the constant `A+B`, while natural numbers are
unbounded.  The Lean module formalizes both facts.

This countermodel does **not** refute any theorem about actual S-units.  It
only refutes the bare logical inference `(F) => a uniform bound` without an
additional quantitative theorem controlling how constants depend on `S`.

## 5. Offline Baker/Subspace dependency audit

No literature theorem is invoked here; the following is only a dependency
audit of what a successful implementation must deliver.

1. A fixed-`S` Baker reduction may yield an effective height bound, but its
   constants can depend on the number and sizes of primes in `S`, on local
   normalization data, and on auxiliary regulators or determinants.  Setting
   `S=supp_T(x)` after the fact is useful only if all those dependencies are
   bounded by

   ```text
   epsilon * h(x) + (1+epsilon) log(prod S) + O_epsilon(1)
   ```

   with the final additive term independent of `S`.  A dependence merely
   described as "effective in S" is insufficient and may be circular.

2. A fixed-place Subspace Theorem statement likewise has constants and
   exceptional subspaces attached to the chosen places and linear forms.
   To imply (3.2), one needs a version uniform while the place set varies,
   together with uniform control of every exceptional family.  Finiteness for
   each separately chosen place set does not commute with the universal
   quantifier over rational `x`.

3. Any proposed route should therefore be audited for one precise output:
   after all support-dependent terms are exposed, can they be absorbed into
   `epsilon*h(x)` plus `log(prod supp_T(x))` with coefficient at most
   `1+epsilon`, leaving only `C_epsilon`?  If not, the route has established a
   fixed-support result rather than abc.

The exact support/height equivalence remains a valid interface for a future
genuinely uniform Baker, Subspace, determinant-method, or Arakelov estimate.
The present result neither proves nor disproves that missing estimate.
