# Global abc and the moving-squarefree generalized-Pythagorean interface

## 0. Audited conclusion

Let `rad` denote the product of the distinct prime divisors.  The following
uniform assertion is **equivalent** to the full abc conjecture:

> For every `eta > 0` there is a constant `C_eta` such that every positive
> quadruple `(D,X,Y,Z)` satisfying
>
> * `D` is squarefree,
> * `X^2 + D Y^2 = Z^2`, and
> * `gcd(X,DY)=1`
>
> obeys
>
> ```text
> 2 log Z <= (1+eta) log rad(DXYZ) + C_eta.       (UGP)
> ```

The condition `gcd(X,DY)=1` is the correct abc-ready primitive condition.  It
makes `(X^2,DY^2,Z^2)` a primitive abc triple without any hidden repair.
Under the displayed equation and squarefreeness of `D`, it is equivalent to
the more customary coordinate condition `gcd(X,Y,Z)=1`; without
squarefreeness that equivalence fails.

Every primitive abc triple is sent to this locus with

```text
rad(DXYZ) <= 2 rad(abc) c,             Z >= c/2.  (0.1)
```

Consequently the converse coefficient ledger is

```text
(1-eta) log c <= (1+eta) log rad(abc) + O_eta(1), (0.2)
```

and the exact substitution

```text
eta = epsilon/(2+epsilon)                         (0.3)
```

recovers the abc coefficient `1+epsilon`.

Thus the moving-`D` map is a complete and loss-controlled reduction, but
`(UGP)` is not an accepted weaker input: proving it uniformly is precisely
another formulation of abc.  This note is an equivalence/no-go audit, not a
proof of `(UGP)`.

## 1. Canonical squarefree-square decomposition

For every positive integer `n`, write uniquely

```text
n = S(n) t(n)^2,
```

where `S(n)` is squarefree.  Prime by prime, if `e_p=v_p(n)`, set

```text
v_p(S(n)) = e_p mod 2,       v_p(t(n)) = floor(e_p/2).
```

Uniqueness follows from uniqueness of prime factorization and the requirement
that every exponent in `S(n)` is either zero or one.  Notice an easy point
that must not be misstated:

```text
gcd(S(n),t(n)) need not be 1.
```

For example, a prime occurring to exponent three occurs in both factors.
What is true, and what the radical ledger uses, is the support identity

```text
Supp(S(n)t(n)) = Supp(S(n)t(n)^2) = Supp(n).       (1.1)
```

Now let `a+b=c` be a positive primitive abc triple.  Pairwise primitivity is
equivalent here to `gcd(a,b)=1`.  Put

```text
a = A u^2,        b = B v^2,        D = AB,        (1.2)
```

using the decomposition above.  The supports of `a` and `b` are disjoint, so
`gcd(A,B)=1`.  Since `A` and `B` are squarefree, their coprime product `D` is
squarefree.

## 2. The parity-normalized map

Assume first that `a != b` and put `Delta=|a-b|`.  Since a primitive pair
cannot be simultaneously even, there are only two parity cases.  Define

```text
delta = 1  if a,b have opposite parity,
delta = 2  if a,b are both odd,                         (2.1)

X = Delta/delta,       Y = 2uv/delta,       Z = c/delta. (2.2)
```

All three quotients are positive integers.  In the odd--odd case, `Delta`
and `c` are even and `Y=uv`; in the opposite-parity case no division occurs.
The elementary identity

```text
(a-b)^2 + 4ab = (a+b)^2
```

and `D(uv)^2=ab` give

```text
X^2 + D Y^2 = Z^2.                                  (2.3)
```

This construction is symmetric in `a,b`; the absolute value only chooses a
positive `X`.

### 2.1 Direct primitivity proof

We prove

```text
gcd(X,DY)=1.                                         (2.4)
```

Suppose a prime `p` divided both factors.

* If `delta=1`, then `Delta` and hence `X` are odd, so `p != 2`.  From
  `p | DY=2ABuv` and (1.1), it follows that `p | ab`.
* If `delta=2`, then `a,b,A,B,u,v,D,Y` are all odd.  Thus again `p != 2`,
  and `p | DY=ABuv` implies `p | ab`.

In either case `p | X` implies `p | delta X=Delta`, because `p` is odd.
Since `p` is prime and divides `ab`, it divides `a` or `b`; together with
`p | a-b`, either alternative forces it to divide both `a` and `b`.  This
contradicts `gcd(a,b)=1`, proving (2.4).

There is also a divisor-only formulation of the same argument.  The
difference `a-b` is coprime to both `a` and `b`; hence every divisor `X` of
the difference is coprime to every factor supported on `ab`.  The only extra
factor in the opposite-parity case is `2`, and `X` is odd.

### 2.2 Why this primitive definition is abc-ready

Let

```text
alpha=X^2,       beta=D Y^2,       gamma=Z^2.
```

From `gcd(X,DY)=1` one gets `gcd(alpha,beta)=1`.  Equation (2.3) then gives

```text
gcd(beta,gamma)=gcd(beta,alpha+beta)=1,
gcd(gamma,alpha)=gcd(alpha+beta,alpha)=1.            (2.5)
```

Thus `(alpha,beta,gamma)` is a positive pairwise-coprime abc triple.  This is
the exact condition needed in the forward implication from abc to `(UGP)`.

## 3. Audit of the competing coordinate definition

Some literature calls a solution of (2.3) primitive when

```text
gcd(X,Y,Z)=1.                                        (3.1)
```

For a **squarefree** `D`, (2.3) makes (3.1) equivalent to (2.4).  The easy
direction is `(2.4) => (3.1)`.  For the converse, suppose a prime `p` divides
`X` and `DY`.

* If `p | Y`, equation (2.3) gives `p | Z`, contradicting (3.1).
* Otherwise `p` divides `D` but not `Y`.  Reducing (2.3) modulo `p` gives
  `p | Z`.  Therefore `p^2` divides both `X^2` and `Z^2`, hence also
  `D Y^2=Z^2-X^2`.  Since `p` does not divide `Y`, this forces `p^2 | D`,
  contrary to squarefreeness.

The squarefree hypothesis is essential.  One small explicit failure is

```text
D=12, X=2, Y=1, Z=4:
2^2 + 12*1^2 = 4^2,       gcd(2,1,4)=1,
gcd(2,12*1)=2.                                      (3.2)
```

Correspondingly `(X^2,DY^2,Z^2)=(4,12,16)` is not primitive.  To keep every
application local and unambiguous, `(UGP)` is stated with the strong condition
`gcd(X,DY)=1`, even though (3.1) would be equivalent on its fully quantified
squarefree locus.

## 4. Exact radical and height ledger

From (1.1)--(2.2),

```text
Supp(DY) = Supp(2ab)  if delta=1,
Supp(DY) = Supp(ab)   if delta=2.                    (4.1)
```

Moreover `X | Delta` and `Z | c`.  Therefore, uniformly in both cases,

```text
Supp(DXYZ) subset Supp(2abc Delta).                  (4.2)
```

Using submultiplicativity of the radical, `rad(2)=2`, and
`rad(Delta)<=Delta<c`, we obtain

```text
rad(DXYZ)
  <= rad(2abc Delta)
  <= 2 rad(abc) rad(Delta)
  <= 2 rad(abc) Delta
  <= 2 rad(abc) c.                                   (4.3)
```

No factor depending separately on `A`, `B`, `u`, `v`, or `D` has been
discarded: all of their prime support is already contained in `ab`.  This is
the decisive improvement over a generic moving-coefficient estimate.

Since `delta` is either one or two,

```text
Z=c/delta >= c/2.                                    (4.4)
```

Writing

```text
H=log c, R=log rad(abc), N=log rad(DXYZ), L=log Z,
```

(4.3)--(4.4) become

```text
N <= R+H+log 2,       2H-log 4 <= 2L.                (4.5)
```

These are uniform inequalities; their additive constants do not depend on
the source triple.

## 5. `(UGP)` is equivalent to abc

### Proposition 5.1: abc implies `(UGP)`

Assume abc and take data in `(UGP)`.  By Section 2.2,

```text
X^2 + D Y^2 = Z^2
```

is a primitive abc triple.  Its height is `Z^2`, and prime supports give the
exact equality

```text
rad(X^2 * D Y^2 * Z^2) = rad(DXYZ).                  (5.1)
```

Equality (5.1) does not itself require squarefreeness: both sides contain
exactly the primes dividing at least one of `D,X,Y,Z`.  Applying abc with
parameter `eta` yields

```text
log Z^2 <= (1+eta) log rad(DXYZ) + C_eta,
```

which is `(UGP)` because `log Z^2=2 log Z` for positive `Z`.

### Proposition 5.2: `(UGP)` implies abc

Assume `(UGP)` and take a positive primitive triple `a+b=c` with `a!=b`.
Apply the construction of Sections 1--2.  Combining `(UGP)` with (4.5) gives

```text
2H-log 4
  <= 2L
  <= (1+eta)N+C_eta
  <= (1+eta)(R+H+log 2)+C_eta.
```

Rearranging,

```text
(1-eta)H
  <= (1+eta)R + C_eta + log 4 + (1+eta)log 2.        (5.2)
```

For a requested `epsilon>0`, choose

```text
eta=epsilon/(2+epsilon).
```

Then `0<eta<1` and

```text
(1+eta)/(1-eta)=1+epsilon.                           (5.3)
```

Dividing (5.2) by the positive number `1-eta` gives

```text
log c <= (1+epsilon) log rad(abc) + O_epsilon(1),
```

which is abc.

If `a=b`, primitivity forces `(a,b,c)=(1,1,2)`.  This single exceptional
triple is absorbed by enlarging the constant.  Hence the converse covers all
positive primitive abc triples, not merely the nonsymmetric ones.

Together Propositions 5.1 and 5.2 prove

```text
ABCConjecture iff UniformGeneralizedPythagoreanCriticalBound. (5.4)
```

## 6. Finite counterexample search

A diagnostic exhaustive search was run independently of the proof.

1. For every ordered coprime pair `1<=a,b<=500`, `a!=b`, the canonical
   squarefree-square decomposition and parity-normalized construction were
   checked.  There were no failures of integrality, (2.3), or
   `gcd(X,DY)=1`.
2. For every squarefree `1<=D<=299`, `1<=X<=299`, and `1<=Y<=99` for which
   `X^2+DY^2` was a square, the search found no solution satisfying
   `gcd(X,Y,Z)=1` but failing `gcd(X,DY)=1`.
3. Removing squarefreeness immediately finds (3.2).

The finite search is only a transcription check.  Sections 2--3 supply the
proof for all integers.

## 7. Consequence for the remaining global gap

The map eliminates one possible concern: moving `D` does **not** impose an
extra radical-height loss when `D` is chosen as the product of the two
squarefree kernels.  Its entire support is charged to `ab`, and only the one
source-height term from `X` remains, giving the rescaling (0.3).

It does not turn fixed-`D` Pell theorems into a proof of abc.  The coefficient

```text
D=S(a)S(b)
```

moves through an unbounded family, and `(UGP)` requires one constant uniform
over every such squarefree `D` and every primitive point.  A theorem proved
separately for each fixed Pell conic may have a constant depending on `D`;
that dependence cannot be placed inside `O_epsilon(1)`.  Obtaining the
coefficient-one estimate uniformly is exactly the equivalent statement
(5.4).

The honest alternatives therefore remain:

* prove the uniform critical estimate `(UGP)` (and hence prove abc), or
* find a different global mechanism whose moving-data cost is proved to be
  absorbable in the epsilon budget.

## 8. Lean companion and honesty boundary

`IUTThreeClosures/GlobalABCMovingDPythagoreanEquivalenceAudit.lean` records:

* the conjectural interface as a definition, with no inhabitant assumed;
* the unnormalized and parity-scaled algebraic identities;
* the exact implication from `gcd(X,DY)=1` to pairwise primitivity of the abc
  target;
* the divisor-of-difference support proof for both parity cases;
* the explicit nonsquarefree counterexample (3.2);
* the scalar transfer (5.2) and exact rescaling (5.3).

The Lean file deliberately does not postulate `(UGP)`, abc, Szpiro, or an
equivalent bridge.  The canonical squarefree-kernel existence theorem and the
full natural-radical support equality remain paper-level in this minimal
companion; no missing formalization step is counted as a mathematical input.
