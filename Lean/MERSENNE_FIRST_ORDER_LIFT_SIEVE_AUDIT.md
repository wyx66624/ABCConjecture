# First-order Mersenne blocks: lift density, sieve quantifiers, and the fixed-base barrier

**Author:** ChatGPT

**Status:** offline research note. This note separates exact finite theorems,
standard analytic input, and heuristics. It does not prove the abc conjecture,
`sum_{d<=X} log E_d=o(X)`, or a power saving for `E_d`.

The finite Taylor/lift criterion and the uniqueness of the good correction
class are formalized in
`IUTThreeClosures/MersenneFirstOrderLiftSieve.lean`.

## 1. The nonredundant target

For an odd prime `p`, put

```text
d_p=ord_p(2),             w_p=v_p(2^d_p-1).
```

At level `d`, the first-order excess block is

```text
E_d=product_{d_p=d} p^(w_p-1),
e_d=log E_d.
```

The two surviving sufficient targets are

```text
S(X):=sum_{d<=X} e_d=o(X),                            (1.1)
```

or, for some fixed `delta>0`,

```text
e_d=O(d^(1-delta)).                                  (1.2)
```

The exact prime form of the cumulative mass is

```text
S(X)=sum_{ord_p(2)<=X} (w_p-1) log p.                 (1.3)
```

Only base-two Wieferich primes occur in (1.3). In particular, (1.1) has the
following necessary consequence along every infinite sequence of such
primes:

```text
log p / ord_p(2) -> 0.                               (1.4)
```

Indeed, the single prime contributes `log p` at
`X=ord_p(2)`. The block estimate (1.2) is stronger pointwise: it would imply
`log p=O(ord_p(2)^(1-delta))` for every order-level Wieferich prime. Neither
statement follows from a standard order theorem for almost all primes,
because the Wieferich primes may lie entirely in its exceptional set.

## 2. Exact roots modulo `p^2`

Let `p` be an odd prime, let `p` not divide `a`, and suppose `d|p-1`. Every root of

```text
X^d=1 mod p
```

is simple, since the derivative is `d X^(d-1)` and `p` divides neither
factor. Hensel lifting therefore gives exactly one root modulo `p^r` above
each root modulo `p`, for every `r>=2`.

Equivalently, because `(Z/p^r Z)^*` is cyclic of order
`p^(r-1)(p-1)`, there are exactly `d` roots of `X^d=1` modulo `p^r` and
exactly `phi(d)` roots of exact order `d`. For each exact-order-`d` class
modulo `p`, there are `p^(r-1)` lifts modulo `p^r`, and exactly one of them
still has exact order `d`. Thus the conditional density among those lifts is
precisely

```text
p^(-(r-1)).                                           (2.1)
```

At `r=2`, only one of the `p` lifts of each nonzero residue is the
Teichmuller lift.

There is also an elementary affine formula. If

```text
a^n-1=p q,
```

then the first-order Taylor expansion modulo `p^2` gives

```text
(a+p k)^n-1
  = p(q+n a^(n-1) k) mod p^2.                         (2.2)
```

Consequently

```text
p^2 | (a+p k)^n-1
  <-> p | q+n a^(n-1) k.                              (2.3)
```

If `gcd(n a^(n-1),p)=1`, the right side has exactly one correction class
`k mod p`. The Lean module proves the Taylor divisibility, (2.3), and
existence/uniqueness modulo `p` of this correction.

For the Fermat exponent `n=p-1`, the coefficient is invertible whenever
`p` is odd and `p` does not divide `a`. Hence the heuristic probability
`1/p` for a square lift is an exact density **when the integer lift of the
base is varied through the `p` possibilities**.

This does not say that the fixed lift `a=2` is generic. At `p=1093`, the
unique good correction happens to be the correction class of the literal
integer `2`, as certified by

```text
1093^2 | 2^364-1.
```

Thus the root count is correct but has the wrong averaging variable for the
Mersenne problem.

## 3. Why a large sieve over bases does not specialize to base two

For a fixed prime `p`, the set

```text
{a mod p^2 : a^(p-1)=1 mod p^2}
```

has `p-1` elements among the `p(p-1)` units. A large sieve or second-moment
argument which varies `a` can exploit this density `1/p`. It may prove that
most bases have little Wieferich mass.

The required assertion has the quantifiers

```text
fixed a=2;  all sufficiently large X.                 (3.1)
```

An average over `a` does not isolate (3.1). This is not a technical issue
about a lost logarithm. For every finite set of primes, the Chinese
remainder theorem produces base classes modulo the product of their squares
which select the good lift at every one of those primes simultaneously.
Therefore the separate marginal `1/p` densities alone cannot give a
finite-range assertion uniform in every base. This does not exclude a
fixed-base asymptotic argument which uses additional correlations or special
arithmetic of the integer `2`.

The small numerical value of the chosen base also supplies no classical
large-sieve parameter: the sieve needs a long family of bases, whereas the
family here consists of the single point `2`.

## 4. A sieve over exponents has perfect block correlations

Suppose `d=d_p`. The order of `2` modulo `p^2` is

```text
d       if p^2 | 2^d-1,
p d     otherwise.                                   (4.1)
```

Hence for an order-level Wieferich prime,

```text
p^2 | 2^n-1  <->  d | n.                             (4.2)
```

Every Wieferich prime in the same block `E_d` imposes the identical
condition `d|n`. They are perfectly correlated from the viewpoint of a
sieve over exponents. A large sieve can see one residue class modulo `d`,
but it cannot recover how many primes, how large they are, or how much
valuation mass is stored in that class. The grouping by `E_d` is exactly
the quotient by this correlation.

There is also a scale obstruction. From

```text
p^2 | 2^d-1
```

one gets only `p^2<2^d`; thus relevant square moduli can have size almost
`2^d`. For an exponent interval of length `X`, a schematic classical
large-sieve cost `X+Q^2` with `Q` of exponential size is much larger than
the desired `o(X)` bound. Restricting to polynomial-size primes leaves the
possibly decisive exponential-size prime factors untreated.

## 5. Why Frobenius does not encode the repeated fixed value

For fixed `d`, the condition

```text
ord_p(2) | d
```

means `p|2^d-1`; it selects the finite prime divisors of one fixed integer.
It is not an unramified Chebotarev class in a fixed extension, since a
nonempty Chebotarev class contains infinitely many primes.

Artin/Kummer extensions can instead study divisibility of the index
`(p-1)/ord_p(2)` and yield distribution results for large order at almost
all primes. They do not control the valuation of `2^d-1` at the primes which
already divide that fixed value.

The base-two Wieferich condition can be expressed using a `p`-dependent
Kummer extension, but then the prime being tested is the same residue
characteristic `p`; it is ramified rather than represented by an ordinary
unramified Frobenius element. Effective Chebotarev therefore does not turn
the local condition into an independent density estimate. A theorem saying
that almost all primes have large order is also insufficient quantitatively:
the unknown Wieferich set may be contained in the exceptional primes, and a
zero-density exceptional set up to `Y` can still carry weight enormously
larger than `X` when `Y` is exponential in `X`.

## 6. Cyclotomic values and the transposed squarefree-sieve quantifier

For an exact-order prime,

```text
v_p(Phi_d(2))=w_p,
R_d E_d | Phi_d(2),
log Phi_d(2)=phi(d) log 2+O(1).                       (6.1)
```

The archimedean budget therefore gives only

```text
e_d<=phi(d) log 2+O(1).                               (6.2)
```

A repeated prime satisfies `p<=2^(d/2)`, but a single squared prime of size
`exp(theta d)` contributes `theta d` to `e_d`. Thus even the square-root
restriction leaves a positive linear coefficient. Higher valuations can
consume an even larger proportion of the block.

This identifies a precise necessary exclusion: for every fixed `eta>0`,
there can be only finitely many order-level Wieferich primes satisfying

```text
log p >= eta ord_p(2).                                (6.3)
```

Indeed, any infinite sequence satisfying (6.3) gives
`S(d_p)/d_p>=eta` at its own first orders and contradicts (1.1). No
resultant between different cyclotomic levels addresses this finiteness
requirement.
Polynomial discriminants detect multiple roots of `Phi_d(X)` modulo `p`,
whereas (6.3) concerns a simple root whose fixed integer lift lands on its
Hensel lift. The certified prime `1093` strictly separates these notions.

Classical squarefree-value sieves normally fix a polynomial and vary its
argument. Here the argument is fixed at `2` and the polynomial `Phi_d`
varies with `d`. Transposing those quantifiers is precisely the unproved
step; ordinary root counts do not do it.

For prime `d`, `Phi_d(2)=2^d-1`. Therefore a power saving for every block
already supplies a near-full radical bound for the prime-exponent Mersenne
family. It should not be expected from a routine cyclotomic estimate.

## 7. Varying-prime p-adic linear forms

The elementary estimate is exact:

```text
w_p log p <= d_p log 2.                               (7.1)
```

Standard `p`-adic logarithmic-form estimates are effective when the prime
and algebraic numbers are fixed while the exponent varies. Here the relevant
term is the first exponent `d_p<p`, and `p` varies with the block. Constants
which grow polynomially or exponentially with `p` are weaker than (7.1)
after substitution.

Even a hypothetical constant ceiling `w_p<=B>1` leaves

```text
(w_p-1)log p <= (1-1/B) w_p log p,
```

so summing still permits a positive linear fraction of (6.1). A useful
`p`-adic theorem must control the weighted distribution

```text
sum_{ord_p(2)=d} (w_p-1)log p,                         (7.2)
```

not merely each valuation. Equivalently, writing

```text
T_{d,j}=sum_{ord_p(2)=d, w_p>=j+1} log p,
```

one has the exact layer decomposition

```text
e_d=sum_{j>=1} T_{d,j}.                               (7.3)
```

The root count modulo `p^2` concerns only the first layer and only after
averaging the base lift; it supplies no fixed-base bound for (7.3).

## 8. What a `d`-average currently gives

Summing the cyclotomic size budget gives only

```text
S(X)<=sum_{d<=X} log Phi_d(2)=O(X^2).                 (8.1)
```

This is one full power of `X` above the cumulative target (1.1). At the
pointwise level, (6.2) is only `O(d)`, whereas (1.2) asks for a fixed
power saving `O(d^(1-delta))`. Root counting, resultants, and the literal
`p`-adic budget do not improve these bounds for the fixed base.

The exact lift density nevertheless supplies a coherent heuristic. If the
base were uniformly random among the units modulo `p^2`, the probability of
having exact order `d` modulo `p` and retaining it modulo `p^2` would be

```text
phi(d)/(p(p-1)),       d|p-1.                         (8.2)
```

Summing (8.2) suggests a very sparse cumulative mass, plausibly polylogarithmic
rather than linear. This supports investigating (1.1), but it is explicitly
a vertical base-average heuristic, not a theorem about `2`.

A diagnostic enumeration of primes below two million finds the two hits
`1093` and `3511`; their orders are respectively
`364` and `1755`, and both have valuation two. This scan is not a computation
of `S(1755)`: a prime much larger than two million can have order at most
`1755`. The finite scan is a computational fact; using it as evidence for an
asymptotic sparsity law would be heuristic. It is not used by the Lean
module.

## 9. Verdict and surviving precise routes

The standard forms of the proposed tools do not prove either (1.1) or
(1.2):

1. roots modulo `p^2` give exact density `1/p` only after varying the lift of
   the base;
2. a sieve over exponents collapses all primes in one `E_d` to the same
   residue condition;
3. Frobenius controls unramified prime distributions, not the valuation of a
   fixed cyclotomic value at its own divisor;
4. cyclotomic size and resultants leave a possible linear-size repeated
   factor;
5. existing individual `p`-adic valuation bounds have the wrong varying-prime
   constants and the wrong aggregation.

No strict counterexample disproves the first-order cumulative estimate or a
genuinely new block power saving, so these routes remain open. A successful
argument must add at least one of the following genuinely new inputs:

* a fixed-base analogue of the lift-density heuristic, uniform for the
  exponentially large possible prime divisors;
* a theorem excluding the large repeated primitive factors in (6.3), plus a
  summable bound for the smaller factors and higher valuation layers;
* a structure-sensitive average over the varying cyclotomic index `d` which
  retains the fixed evaluation `2`, rather than averaging the base;
* a new varying-prime `p`-adic estimate directly for the weighted sum (7.2).

The research advance is a sharper quantifier boundary: Hensel root density
is real and exactly computable, but every standard sieve places the average
on the wrong variable or loses the entire block through perfect order
correlation.
