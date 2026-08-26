# Generalized perfect-power gaps as an abc disproof route

## 1. Purpose

The same-exponent neighbouring-power repair of the smooth-number construction
is impossible: consecutive `k`-th powers are too far apart.  Different
exponents behave differently.  This note gives the exact threshold at which
an infinite family of close perfect powers would rigorously disprove `abc`.

The square--cube case recovers the critical exponent in Hall's conjecture.
Thus the route is not discarded; it is identified with a classical and highly
concrete Diophantine approximation problem.

## 2. The general criterion

Fix integers

\[
  m,n\ge2
\]

and a real number `theta>=0`.  Suppose there are infinitely many coprime
positive integer pairs `(x,y)` such that

\[
  0<y^n-x^m\le (y^n)^\theta.
  \tag{2.1}
\]

Put

\[
  a=y^n-x^m,
  \qquad b=x^m,
  \qquad c=y^n.
\]

### Theorem 2.1 (perfect-power gap disproof criterion)

If

\[
  \theta+\frac1m+\frac1n<1,
  \tag{2.2}
\]

then the `abc` conjecture is false.

### Proof

Since `gcd(x,y)=1`, we have `gcd(b,c)=1`.  Moreover

\[
 \gcd(a,b)=\gcd(c-b,b)=1,
 \qquad
 \gcd(a,c)=\gcd(c-b,c)=1.
\]

Thus `(a,b,c)` is primitive and `a+b=c`.

The radical satisfies

\[
 \operatorname{rad}(a)\le a,
 \qquad
 \operatorname{rad}(x^m)=\operatorname{rad}(x)\le x,
 \qquad
 \operatorname{rad}(y^n)=\operatorname{rad}(y)\le y.
\]

Since `x^m<y^n=c`,

\[
  x<c^{1/m},
  \qquad y=c^{1/n}.
\]

Using (2.1),

\[
 \operatorname{rad}(abc)
 \le axy
 \le c^{\theta+1/m+1/n}.
 \tag{2.3}
\]

Set

\[
 \alpha=\theta+\frac1m+\frac1n<1.
\]

Choose `epsilon>0` with

\[
  \alpha(1+\epsilon)<1.
\]

Then every member of the infinite family satisfies

\[
 \operatorname{rad}(abc)^{1+\epsilon}
 \le c^{\alpha(1+\epsilon)}<c.
\]

The excess for this fixed positive `epsilon` is unbounded as `c` tends to
infinity, contradicting `abc`.

## 3. The square--cube threshold

Take

\[
  m=2,
  \qquad n=3.
\]

The criterion becomes

\[
  \theta<1-\frac12-\frac13=\frac16.
\]

### Corollary 3.1

If there are infinitely many coprime positive integers `x,y` and a fixed
`delta>0` such that

\[
  0<y^3-x^2\le y^{1/2-3\delta},
\]

or equivalently

\[
  0<y^3-x^2\le (y^3)^{1/6-\delta},
\]

then `abc` is false.

The exponent `1/6` is the classical Hall threshold.  The `abc` conjecture
predicts, up to an arbitrarily small power, that it cannot be beaten
infinitely often.  Thus a strict fixed power saving below the Hall horizon is
not merely related to `abc`; it supplies an explicit disproof.

## 4. Why the same-exponent route fails

For `m=n=k` and integers `y>x>0`,

\[
 y^k-x^k=(y-x)
  (y^{k-1}+y^{k-2}x+\cdots+x^{k-1})
 \ge kx^{k-1}.
\]

For neighbouring comparable powers this has size at least

\[
  c^{1-1/k+o(1)}.
\]

But the disproof budget would require

\[
  \theta<1-\frac2k.
\]

Since

\[
  1-\frac1k>1-\frac2k,
\]

same-exponent perfect powers cannot satisfy the required inequality.  This
recovers and strengthens the earlier prime-base no-go theorem.

## 5. Surviving subroutes

The theorem retains several concrete routes.

1. **Square--cube search.**  Search for an infinite family with a fixed power
   saving below `c^(1/6)`.
2. **Higher unequal exponents.**  For `(m,n)` with `1/m+1/n<1`, target the
   horizon

   \[
     c^{1-1/m-1/n}.
   \]

3. **Parametric curves.**  Study rational or integral points on

   \[
     Y^n-X^m=Z
   \]

   where `Z` has height below the critical exponent and controlled radical.
4. **Polynomial identities.**  A polynomial identity whose degree data beat
   the same inequality would specialize to a disproof family, provided
   primitivity and radical control survive specialization.
5. **Pell and recurrence approximations.**  Exponential recurrences may give
   unusually close unequal powers; their primitive divisor growth must be
   included rather than ignored.

No surviving route is removed without a lower-bound theorem that rules out its
critical parameter range.

## 6. Relation to proof routes

A theorem asserting that for every fixed `delta>0` only finitely many coprime
solutions satisfy

\[
  0<|y^n-x^m|<(\max\{x^m,y^n\})^{1-1/m-1/n-\delta}
\]

would close this particular disproof route.  Such a theorem is itself an
`abc`-strength generalized Hall estimate in the relevant uniformity.

The route is therefore best used in parallel:

- computationally, to search for genuine counterexample patterns;
- theoretically, to test any proposed proof against its consequences for
  generalized perfect-power gaps.

## 7. Lean plan

1. Formalize the radical bound
   `rad((y^n-x^m)*x^m*y^n) <= (y^n-x^m)*x*y` under coprimality.
2. Formalize the exponent-budget lemma producing one positive `epsilon` from
   `theta+1/m+1/n<1`.
3. Combine these with `ABCDisproofCriterion.not_abc_of_unbounded_excess`.

No step assumes the existence of the required infinite family.
