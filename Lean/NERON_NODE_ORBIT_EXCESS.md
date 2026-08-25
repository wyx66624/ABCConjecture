# Neron node-orbit excess: a genuine `p`-weighted carrier and its exact boundary

## 1. Result

There is a natural local module which supplies the missing bad-prime weight.
It is not obtained from an `ell`-primary Hecke congruence module.

Let `p` be odd, let `K/Q_p` be a finite extension with residue field `k`,
and let an elliptic curve have multiplicative reduction of Kodaira type
`I_(2e)`.  Let `X` be its minimal regular model and let

```text
Sigma = Sing(X_k)
```

be the node scheme of the special fiber.  Inversion extends to `X` and acts
freely on the `2e` geometric nodes.  Hence

```text
Q = Sigma / <[-1]>
```

is a finite etale `k`-scheme of degree `e`.  Define

```text
M_node(E/K) = Gamma(Q,O_Q) / k,                    (1.1)
```

where `k` is embedded as the constant functions.  Then

```text
dim_k M_node(E/K) = e - 1.                         (1.2)
```

For `K=Q_p` this gives

```text
# M_node(E/Q_p) = p^(e-1),
adeg M_node(E/Q_p) = (e-1) log p,
Fitt_0,Z_p(M_node) = (p^(e-1)).                    (1.3)
```

Thus this construction really is supported at the removed prime `p`, and
its arithmetic degree has the requested linear exponent and `log p` weight.
It does not put `p^(e-1)` into a modulus by definition: the exponent is the
dimension of the nonconstant functions on a geometrically defined finite
scheme.

For the primitive Frey curve

```text
y^2 = x(x-a)(x+b),       a+b=c,
```

an odd `p | abc` has type `I_(2e_p)`, where `e_p=v_p(abc)`.  Consequently

```text
adeg M_node,p = (e_p-1) log p.                     (1.4)
```

The direct sum over the odd bad primes therefore has degree exactly

```text
E_node^odd = sum_(p|abc, p odd) (e_p-1) log p.      (1.5)
```

This closes the *lower-carrier construction problem*.  It does not prove a
radical-level upper bound.  Section 5 shows that the required upper bound is
exactly the odd Frey discriminant--conductor inequality of slope `6+eps`.

The companion Lean file formalizes only the finite node pairing, the
coordinate-difference module, its cardinality and degree, the exact scalar
equivalence, and a strict fixed-support countermodel.  The regular-model
statements in Sections 2--4 are paper mathematics and are not inserted as
assumptions or structure fields.

## 2. Why inversion produces exactly half the contact excess

Over an algebraic closure, an `I_n` fiber is an `n`-gon.  Label its
components by `C_i`, with indices in `Z/nZ`, and label by `s_i` the node
joining `C_i` to `C_(i+1)`.  On the smooth locus, inversion sends the
component index `i` to `-i`.  On the compactified polygon it also exchanges
zero and infinity on each rational component.  Therefore

```text
[-1](s_i) = s_(-i-1).                               (2.1)
```

For `n=2e`, a fixed node would give

```text
2i = -1  (mod 2e),                                  (2.2)
```

which is impossible.  The `2e` nodes consequently form `e` free orbits.
This argument is geometric, so it also applies to nonsplit multiplicative
reduction after descent: the node scheme and its free quotient are defined
over `k`, even though individual nodes need not be `k`-rational.

Because `Q` is finite etale of degree `e`, its coordinate algebra `A` is an
`e`-dimensional `k`-vector space.  The constant embedding `k -> A` is
injective, so `A/k` has dimension `e-1`.  For a split fiber one can see the
quotient concretely.  A function `f` on `e` node orbits is normalized by

```text
f(i) |-> f(i)-f(0),                                  (2.3)
```

and its `e-1` nonzero-index differences give all coordinates of (1.1).
The Lean module proves the surjectivity of this normalization and that its
kernel is precisely the constant functions.

The restriction to even `n` is essential.  When `n` is odd, (2.2) has one
solution and inversion has a fixed node.  The Frey multiplicity `n=2e_p`
is exactly what makes the free quotient available.  The prime `2` is left
out because quotient and minimal-model behavior in residue characteristic
two require a separate analysis.

## 3. Relation with Neron components and the discriminant section

There are two nearby constructions which must be distinguished.

1. The geometric component group of an `I_n` fiber has order `n`.  Taking
   the logarithm of its group order gives only `log n`.
2. The coordinate algebra of a degree-`n` finite scheme is an
   `n`-dimensional residue-field vector space.  If `#k=q=p^f`, its additive
   group has order `q^n=p^(fn)`, so its arithmetic degree is `n log q`.
   In the global rational case `k=F_p`, this specializes to `n log p`.

The second observation is the source of the missing weight.  Rational
Tamagawa points are irrelevant to its rank.  In particular, the nonsplit
Frey family whose rational Tamagawa number at three is constantly two does
not collapse the geometric node algebra.

For an `I_n` fiber, the number of geometric nodes is

```text
deg_k Sigma = n = v_K(Delta_min),                   (3.1)
```

where `v_K` is the normalized discrete valuation on `K` (and is the usual
`v_p` when `K=Q_p`).

Thus the full node algebra is another realization of the discriminant
contact multiplicity.  The free inversion quotient specializes, for
`n=2e_p`, to half that contact, and quotienting by constants removes the one
reduced bad-prime copy.  This explains geometrically the identity

```text
e_p log p = log p + adeg M_node,p.                  (3.2)
```

Equivalently, for a curve over `Q`, the global `Z`-Fitting ideal of the
direct sum is

```text
product_p p^(e_p-1).                                (3.3)
```

This is the same ideal obtained abstractly from the powerful part, but here
it is recovered from the singular fibers and the intrinsic inversion
symmetry of the Frey curve.

Arithmetic Noether identities, the discriminant section, and Deligne
pairings can rewrite the full node degree.  They do not bound it by the
degree of the reduced bad divisor.  Positivity of an effective contact
divisor points in the lower-bound direction and does not delete its
multiplicity.

## 4. Why ordinary higher congruence depth cannot supply this module

Let a Hecke congruence contribution be primary at `lambda | ell`, while
`M_node,p` is killed by `p`.  In the Tate level-lowering range one has
`p != ell`.  Hence the two rational supports are comaximal.  In particular,

```text
M_node,p tensor C_lambda = 0,
Tor_1^Z(M_node,p,C_lambda) = 0,                     (4.1)
```

and every `Z`-linear homomorphism between a `p`-primary module and an
`ell`-primary module is zero.  An ordinary intersection or Fitting operation
therefore cannot turn `lambda`-adic length into (1.3).

A modular parametrization can extend to Neron or regular models and can
induce maps on component data.  That is a different, genuinely geometric
input.  It does not imply that the Fitting ideal in (1.3) divides a Hecke
congruence ideal.  Such a divisibility would assert new `p`-primary
information of size `p^(e_p-1)`; higher `ell^k` level lowering away from `p`
only detects divisors of the integer `e_p`.

Similarly, a map from a modular curve model to the Frey model can pull back
the node divisor, but an arithmetic Bezout or Hilbert--Samuel estimate then
contains the degree/height/ramification of that map.  Obtaining the needed
radical-scale bound for those terms is the missing global theorem, not a
formal consequence of the existence of the map.

## 5. The radical upper bound is exactly slope-six Szpiro

Let the sums below range over the odd bad primes of a primitive Frey curve:

```text
R = sum_p log p,
T = sum_p e_p log p,
E = adeg M_node^odd = sum_p (e_p-1) log p.           (5.1)
```

Then

```text
T = R+E,
D_Delta^odd = 2T = 2(R+E).                          (5.2)
```

Consequently, for every real `eps,C`, one has the exact equivalence

```text
E <= (2+eps/2)R+C
iff
D_Delta^odd <= (6+eps)R+2C.                        (5.3)
```

No positivity hypothesis on `eps` is needed for this algebraic equivalence.
Uniformly over the Frey family, its right side is precisely the odd
semistable discriminant--conductor estimate of slope `6+eps`.  The prime two
and any archimedean/minimal-model corrections must be handled separately;
none is silently absorbed here.

Thus the node-orbit construction solves the support and lower-degree
problem, but attaching the label "intersection module" does not prove its
upper bound.  Any claimed proof of the left side of (5.3) must be audited for
an abc-, Szpiro-, Vojta-, truncated-counting-, or equivalent modular-height
input.

## 6. Strict local and Frey-family counterexamples

Fix an odd prime `p`.  For every integer `B` there is an `e` such that

```text
# M_node(I_(2e)) = p^(e-1) > B,                    (6.1)
```

while the reduced bad divisor remains the single point `[p]`.  These fibers
are not merely formal polygons: a Tate curve with parameter of valuation
`2e` realizes type `I_(2e)`.  Equivalently, for all real `A,C`,

```text
there exists e>=1 such that
(e-1)log p > A log p+C.                            (6.2)
```

This disproves any local theorem bounding the node-orbit degree by reduced
support alone.

There is also a global Frey realization at a fixed bad prime.  For

```text
(a,b,c)=(3^e,2,3^e+2),                             (6.3)
```

the fiber at three is type `I_(2e)`, so its node-orbit module has degree
`(e-1)log 3`, unbounded with `e`.  Therefore no per-place bound depending
only on the label `3`, rational Tamagawa data, or a fixed unweighted
congruence depth can hold even on the actual Frey locus.

This does **not** refute a global bound by the full radical of (6.3): the
other primes dividing `3^e+2` may compensate.  That cross-prime global
interaction is exactly the still-open content of (5.3).

## 7. Lean boundary

`IUTThreeClosures/NeronNodeOrbitExcess.lean` proves:

1. a fixed-point-free involution on an abstract set of `2e` paired nodes;
2. the concrete quotient-by-constants normalization of orbit functions;
3. that the resulting finite module has cardinality `p^(e-1)`;
4. that its arithmetic degree is `(e-1)log p`;
5. the exact equivalence (5.3), including its finite-profile version;
6. unbounded carrier size at the fixed support prime three, and hence no
   bound depending on that reduced support alone.

It does not formalize the Kodaira classification, minimal regular models,
extension of inversion, quotient existence or descent, finite-etale
coordinate algebras, Neron models, Fitting ideals, modular parametrizations,
Deligne pairings, Hecke congruence ideals, Szpiro, or abc.  None of those
appears as a hypothesis packaged inside a structure.
