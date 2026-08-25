# Multiple derivations, exterior rank, entropy, and the second energy layer

This is an offline analysis of the free prime-weight derivative route.  It
separates a complete first-order no-go theorem from a genuinely new
second-order local invariant.  No abc estimate, Vojta statement, small-vector
selector, or desired height bound is assumed as data.

Throughout, `a+b=c` is a primitive positive triple.  Write

```text
a=A r_a,  b=B r_b,  c=C r_c,
r_n=rad(n),  A=n/r_a, B=n/r_b, C=n/r_c,
R=r_a r_b r_c=rad(abc).
```

The three powerful parts `A,B,C` and the three radicals `r_a,r_b,r_c` are
pairwise coprime in their respective triples.

## 1. Exact first-order rank

For integer prime weights `x_p`, put

```text
D_x(n)=sum_{p|n} (n/p) v_p(n) x_p.
```

Set

```text
tau(n)=gcd_{p|n} ((r_n/p)v_p(n)).
```

Since `(n/p)v_p(n)=(n/r_n)(r_n/p)v_p(n)`, Bezout's identity gives the exact
image

```text
{D_x(n): x_p in Z}= (n/r_n) tau(n) Z.                  (1.1)
```

The supports of `a,b,c` are disjoint.  Consequently every collection of
first-order prime-weight derivations factors through three cyclic value
groups.  Extra prime coordinates only enlarge the internal kernel of the
evaluation map; they do not add new coordinates visible to a Wronskian.

Discarding the realization factors `tau` gives the relaxed value lattice

```text
L_0={(x,y,z) in Z^3: A x+B y=C z}.                     (1.2)
```

The original abc equation is

```text
A r_a+B r_b=C r_c.                                     (1.3)
```

For `(x,y,z) in L_0`, subtracting suitable multiples of (1.2) and (1.3),
then cancelling `gcd(A,C)=1`, gives a unique integer `k` such that

```text
r_a y-r_b x=C k.                                       (1.4)
```

Conversely, `k=1` is attainable.  Choose `z` satisfying
`r_a z=B (mod r_c)`, which is possible because `gcd(r_a,r_c)=1`, and put

```text
x=(r_a z-B)/r_c,     y=(r_b z+A)/r_c.                  (1.5)
```

The first quotient is integral by construction.  Multiplying the defining
congruence by `r_b` and using (1.3) proves that the second is integral.  Direct
substitution proves both (1.2) and (1.4) with `k=1`.

If `k=0`, coprimality of `r_a,r_b`, followed by (1.2), gives

```text
(x,y,z)=t(r_a,r_b,r_c).
```

Thus there is an exact sequence

```text
0 -> Z(r_a,r_b,r_c) -> L_0 -> Z -> 0,                  (1.6)
```

where the last map is `k`.  The lattice has rank two, but after quotienting
by the Wronskian-degenerate line it has rank **one**, not a rank growing with
the number of prime factors.

For normalized values `u=x/r_a`, `v=y/r_b`, (1.4) says

```text
v-u=(c/R) k.                                            (1.7)
```

Hence every nondegenerate value obeys

```text
|u|+|v| >= c/R.                                        (1.8)
```

For the `k=1` solution, translating by the degenerate line replaces
`(u,v)` by `(u+t,v+t)`.  If `c/R>=1`, an integer `t` lies between `-u` and
`-v`, so equality holds in (1.8).  In general a nearest integer to
`-(u+v)/2` gives cost at most `c/R+1`.  Therefore the relaxed optimum is

```text
mu_0=c/R                 if c/R>=1,
c/R <= mu_0 <= c/R+1     in general.                   (1.9)
```

This is stronger than a generic obstruction example: random weights,
entropy minimization, matroid basis selection, Smith normal form, and
successive minima applied only to first-order values are optimizing the abc
quality itself.  A bound `mu_0 <<_epsilon R^epsilon` is equivalent, up to the
harmless `+1`, to the desired abc estimate.  For actual integral weights the
`tau` conditions give a sublattice, so the optimum can only be larger.

## 2. Modular compatibility does not evade the rank obstruction

Exact equality with a derivative value at `c` is stronger than necessary.
Suppose

```text
A | D_a,  B | D_b,  C | D_a+D_b.
```

For `W=aD_b-bD_a`, the first two divisors are immediate, while

```text
W=cD_b-b(D_a+D_b)
```

shows `C|W`.  Pairwise coprimality gives `ABC|W`, and the previous
height--radical argument goes through unchanged.  But after writing
`D_a=Ax,D_b=By`, the modular condition is exactly

```text
A x+B y=0 (mod C),
```

which is the `(x,y)` projection of (1.2).  It removes the realization factor
`tau(c)` but leaves the rank-one spacing (1.7) unchanged.

`MultiDerivationExteriorEnergy.lean` proves this stronger modular theorem and
its specialized free-weight height consequence.

## 3. Several first derivatives and exterior minors

Let `(D_{ia},D_{ib})`, `i=1,2`, satisfy the local divisibilities and modular
compatibility.  Define

```text
Delta=D_{1a}D_{2b}-D_{1b}D_{2a}.                        (3.1)
```

The factors `A` and `B` divide the two columns.  Moreover

```text
Delta=D_{1a}(D_{2a}+D_{2b})
      -D_{2a}(D_{1a}+D_{1b}),                           (3.2)
```

so `C|Delta`.  Hence

```text
ABC | Delta.                                            (3.3)
```

This cannot be strengthened uniformly to `(ABC)^2 | Delta`.  For the
primitive triple `(a,b,c)=(8,1,9)`, the powerful parts are `(A,B,C)=(4,1,3)`.
The two value pairs

```text
(D_{1a},D_{1b})=(4,2),       (D_{2a},D_{2b})=(0,3)
```

satisfy all four local divisibilities and both congruences modulo `C`, while
`Delta=12=ABC` is not divisible by `144=(ABC)^2`.  This sharpness example is
a paper calculation; the Lean theorem asserts the one-copy divisibility.
If `W_i=aD_{ib}-bD_{ia}`, then the exact identity

```text
a Delta=D_{1a}W_2-D_{2a}W_1                            (3.4)
```

exhibits the same one-dimensional transverse quotient.  If three derivative
triples satisfy `D_{ia}+D_{ib}=D_{ic}`, their `3 x 3` determinant is zero,
because all three rows lie in the same plane.  Thus adding first derivatives
copies the same constraint; it does not manufacture independent normals.

In the relaxed lattice a degenerate vector and a `k=1` vector have normalized
area exactly `c/R`.  Consequently a product-of-successive-minima argument is
saturated: the degenerate sublattice supplies all but one cheap direction,
and exactly one transverse direction bears the full `c/R` cost.

These divisibility, rank, and exterior identities are formalized in the Lean
module.

## 4. What a large-support split would actually require

Let `s=omega(abc)`.  Suppose, as a *new theorem to be proved*, that for
`s>=3` there were a compatible nondegenerate weight vector with

```text
||x||_infinity <= K_s H^(1/(s-1)),                      (4.1)
```

where `H` is the largest coefficient of the compatibility row.  Since

```text
H <= c log_2(c)/2,
sum_{p|ab} v_p(abc)/p <= s log_2(c)/2,
```

the proved Wronskian inequality would imply

```text
c^((s-2)/(s-1))
 <= R K_s s 2^(-1-1/(s-1))
      (log_2 c)^(1+1/(s-1)).                            (4.2)
```

The main radical exponent is

```text
(s-1)/(s-2)=1+1/(s-2),                                  (4.3)
```

so `s>=3` is essential.  To make (4.2) uniform for all sufficiently large
`s`, the constants must satisfy at least

```text
log K_s=o(s log s).                                     (4.4)
```

Indeed `R` is at least the product of the first `s` primes, and even the
elementary bound `R >= (s+1)!` gives `log R` of order `s log s`.  Exponential
growth `K_s=exp(O(s))` can be absorbed after choosing a threshold depending
on epsilon.  Growth `exp(C s log s)` cannot in general be absorbed into an
arbitrarily small epsilon.

The complementary statement is not the ordinary fixed-`S` unit theorem.  It
would have to be

```text
s<=S_epsilon
 ==> log c <= (1+epsilon) log R+C(epsilon,S_epsilon),    (4.5)
```

uniformly while the primes in `S` vary.  Fixed-`S` finiteness has constants
depending on the primes themselves, and standard Baker bounds do not supply
the coefficient `1+epsilon` in (4.5).  Therefore the proposed
large-support/bounded-support split does not close until both (4.1), with
the growth (4.4), and the genuinely uniform estimate (4.5) are proved.

Moreover, Sections 1--3 show why (4.1) cannot follow from a naked first-order
successive-minima argument: its transverse conclusion already controls
`c/R`.

## 5. Algebraic weights and embedding entropy

Passing from integer weights to algebraic-integer weights does not alter the
first-order obstruction.  Let `K` have degree `d`.  In the relaxed
`O_K`-lattice the same calculation gives

```text
r_a y-r_b x=C k,       k in O_K.                        (5.1)
```

For `k!=0`, taking the field norm gives

```text
product_sigma |r_a sigma(y)-r_b sigma(x)|
  = C^d |N_{K/Q}(k)| >= C^d.                            (5.2)
```

After normalization and the triangle inequality, the product of the
archimedean costs is at least `(c/R)^d`.  Units may redistribute the cost
among embeddings, but cannot lower its product.  Matrix-valued weights give
the same determinant statement.  Thus random-embedding or unit-entropy
versions of the *same first-order operator* are also norm copies of the
rank-one spacing, not a new route.

## 6. A genuinely new second-order local invariant

Encode `n` by the prime monomial

```text
M_n(X)=product_{p|n} X_p^{v_p(n)}
```

and evaluate at `X_p=p`.  For directions `x,y`, let `D_x(n)` be the first
directional derivative and `H_{x,y}(n)` the mixed Hessian.  Direct
differentiation gives

```text
D_x(n)D_y(n)-n H_{x,y}(n)
 = Gamma_{x,y}(n)
 = sum_{p|n} v_p(n) (n/p)^2 x_p y_p.                    (6.1)
```

Every `n/p` is divisible by `pow(n)`, so

```text
pow(n)^2 | Gamma_{x,y}(n).                              (6.2)
```

For `x=y`, `Gamma_{x,x}(n)>=0`.  A two-direction Gram determinant has four
copies of the powerful part.  The Lean module formalizes the energy, its
symmetry and positivity, (6.2), and the fourth-power exterior divisibility.

If first and second derivative values both satisfy

```text
D_a+D_b=D_c,       H_a+H_b=H_c,                         (6.3)
```

write `Gamma_n=D_n^2-nH_n`.  Expanding and using `a+b=c` proves the exact
second-jet identity

```text
bc Gamma_a+ac Gamma_b-ab Gamma_c=W^2,                   (6.4)
W=aD_b-bD_a.
```

This is also formalized in Lean.  When the `Gamma_n` are the nonnegative
diagonal energies and `W!=0`, (6.2), the ordinary Wronskian divisibility, and
(6.4) imply

```text
(ABC)^2 <= W^2 <= bc Gamma_a+ac Gamma_b,
abc/R^2 <= Gamma_a/a+Gamma_b/b,
ab/R^2 <= Gamma_a/a^2+Gamma_b/b^2.                      (6.5)
```

Thus for balanced triples `a,b>=theta c`, a second-compatible direction
would give

```text
c <= theta^(-1) R
       sqrt(Gamma_a/a^2+Gamma_b/b^2).                   (6.6)
```

Formula (6.6) has radical coefficient one before the energy loss, but the
global transverse term in (6.4) is exactly `W^2`.  Weighted Cauchy gives

```text
(L_b-L_a)^2 <= (Omega_a+Omega_b)(Gamma_a/a^2+Gamma_b/b^2),
```

while the first-order lattice already forces `|L_b-L_a|>=c/R`.  Thus a
subpower upper bound for the energy loss is itself at least as hard as abc;
it is not a second independent normal direction.  The new content is the
local square powerful-part divisibility and the useful quadratic coordinate
system.  No small-energy construction is hidden in the Lean statement.

## 7. Why arbitrary Hasse jets do not automatically solve selection

A genuine additive Hasse--Schmidt derivation on `Z` is trivial: its generating
series is a unital ring homomorphism `Z -> R[[t]]`, hence sends every integer
to the same constant integer and has all positive-degree coefficients zero.
The prime-monomial construction is intentionally not an additive derivation
on all integers; compatibility is imposed only along the selected abc
relation.

For a formal curve through the prime point on

```text
F=M_a+M_b-M_c=0,
```

the coefficient of order `j` has the form

```text
grad(F).x_j = -P_j(x_1,...,x_{j-1}).                    (7.1)
```

If a fresh acceleration `x_j` is allowed at every order, (7.1) is one affine
equation for a new vector.  Over `Q`, because the gradient is nonzero, every
first tangent extends; higher order has imposed no new condition on the
first transverse class.  Over `Z`, divisibility of the right side by the
gradient gcd is a real arithmetic obstruction, but it is not yet a height
bound.  Positivity of (6.1) can also be destroyed by the acceleration term.

If instead one insists on a straight prime-variable direction, the Hessian
condition in (6.3) is a genuine quadratic equation on the original weights.
It is not universally soluble.  A strict infinite counterexample eliminates
the most symmetric block-scaling version.  In the family

```text
(a,b,c)=(1,2^m-1,2^m),      m>=3,                       (7.2)
```

put `x_p=p lambda_b` on the primes of `b` and
`x_2=2 lambda_c`.  If `N=Omega(b)`, then

```text
D(b)=b N lambda_b,       H(b)=b N(N-1) lambda_b^2,
D(c)=c m lambda_c,       H(c)=c m(m-1) lambda_c^2.
```

Nonzero first and second compatibility would force

```text
N(b+m)=m(b+1),
N=m(b+1)/(b+m).                                          (7.3)
```

For `b=2^m-1` and `m>=3`,

```text
m-1 < m(b+1)/(b+m) < m;
```

the left inequality is equivalent to `b>m(m-2)`, which follows immediately
from `2^m-1>m(m-2)`.  Equation (7.3) is therefore impossible for the integer
`N`.  The block-scaling straight-jet scheme is retired by this infinite
family.  Arbitrary prime-dependent straight directions are not retired; the
remaining concrete problem is an integral nondegenerate zero of one linear
and one Hessian quadratic equation with subpower normalized energy.

## 8. Exact current boundary

The first-order multi-derivative, exterior, random-weight, algebraic-weight,
and entropy variants have been classified: after evaluation they possess one
transverse quotient of exact scale `c/R`.  They cannot be advertised as an
independent proof mechanism.

The second energy layer supplies genuine *local* square powerful-part
divisibility, but globally (6.4) closes onto the square of the same rank-one
Wronskian quotient.  The exact diagonalization and Cauchy obstruction are
continued in `SECOND_JET_QUADRATIC_SYSTEM_ROUTE.md`.  What is not proved is:

1. a uniformly small, nondegenerate integral prime direction satisfying both
   first and Hessian compatibility;
2. a replacement for straight compatibility which preserves the positivity
   needed in (6.5);
3. an unbalanced-triple analogue strong enough to control `c`, rather than
   only `sqrt(ab)`;
4. the uniform bounded-cardinality S-unit estimate (4.5).

These are explicit mathematical gaps, not fields containing the desired
conclusion.
