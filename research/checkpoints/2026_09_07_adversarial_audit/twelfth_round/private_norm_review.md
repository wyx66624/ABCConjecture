# Independent PN1--PN4 review

Reviewer: adversarial_audit. Date: 2026-09-07. Status: complete ordinary
mathematical and specified primary-source review PASS.
Source: critical_bottleneck/twelfth_round/private_norm_support.md,
SHA256 `473ba572cdbf69f74c9e0673762fe37913e3a919c23e9c692870c9da2897daa6`.

I read the full proof, including all depth layers in PN3. The actual
private-norm set is proved to have relative size at least one half
asymptotically; this membership is not assumed from a heuristic about
polynomial values. The proof does not claim density one or all roots.

For PN1, the polynomial has two simple roots at every supported prime
other than the excluded 2,3. The finite interval count includes every
valuation layer through the height cap. Each prime's endpoint error is
O(log B), so summing through 12B costs O(B), not O(B log B). Partial
summation of the fixed progression estimate gives the half coefficient
in the small-norm mass. The actual total mass is 2B log B+O(B), yielding
the claimed half-size bound after division by the per-root norm height.

I independently opened [Bennett--Martin--O'Bryant--Rechnitzer,
Explicit bounds for primes in arithmetic progressions](https://arxiv.org/pdf/1802.00085),
Theorem 1.2, printed page 5, equation (1.12), including its q=3
specialization. It supplies theta(x;3,1)=x/2+O(x/log x). Partial
summation has integrated error O(log log x), and replacing 1/p by
1/(p-1) adds a convergent series. This uses one fixed progression;
there is no moving-modulus PNT assertion here.

A prime r>12B is unique within its norm, of exponent one, and cannot
divide another block norm because both nonzero factors in
(a-b)(a+b+1) have absolute value less than r. Its actual oriented ideal
valuation isolates the corresponding ratio in every multiplicative
relation. This fully proves independence on S_B; general tuple ratios
outside that set are not assumed independent.

For fixed nu, the product-coordinate bound and telescoping estimate
give an explicit determinant of order B^(2nu-1). The condition B>C_nu
is necessary and is explicitly absorbed only into sufficiently large n
for fixed nu. Congruence at depth 2nu then yields exact algebraic ratio
equality. Independence forces equal index multiplicities; the ordered
fiber size is at most nu!, including tuples with repeated indices.

PN3 includes all intermediate positive layers 4<=j<2nu, bounded using
the nu=2 result. It charges the remaining layers through the actual
3n L/log q cap. After normalization the intermediate contribution is
O_nu(1/(B sqrt(n))) per prime and is bounded by the displayed
O_nu(n^(1/nu)/B). The actual rank-one exclusion uses q^2>6B+1, and
q>B>n excludes exponent lifting. Thus the two progressions modulo 3n
and the stated Brun--Titchmarsh count apply. Normalization remains by
the whole block B, not by the subset size.

The PN4 Markov intersections remove the stated fractions from a set
already known to have size at least B/2-o(B). The whole middle signed
mass is bounded above by its positive excess without needing a small
full-mass assertion. The far signed contribution remains explicit.
The exponent nu may be chosen arbitrarily large but must remain fixed
before taking n to infinity. The result does not supply a uniform
variable-nu bound, a whole-tail estimate, or an ABC proof.

## Independent arithmetic compatibility check

I separately factored, by exact trial division with primality checks,
the ten root norms in the two PF repeated-phase examples. Every factor
is <=12B=28812. The largest primes are respectively 18217 and 19309.
For example

    N(7668+zeta)=19*103*151*199,
    N(12828+zeta)=7*31*37*103*199,
    N(8922+zeta)=7*19*31*19309,
    N(10386+zeta)=37*151*19309.

This is consistent with the exact private-prime argument: a nontrivial
relation involving distinct indices cannot contain any index whose
norm prime is private to the entire block. These finite factorizations
do not prove the asymptotic density theorem, and they do not assert any
common fourth-depth boundary hit for the examples. No new compiler or
formalization claim is included in this review.

## Independent run of the author's finite replay

I subsequently read the complete `replay_private_norm.py` and actually
ran it with `--check`, read-only. It returned PASS for 3522 full norm
factorizations, 2502 private-prime witnesses and 7700 ordered pair/triple
tuples on its explicitly listed subsets. The sieve supplies every trial
prime through a bound exceeding the square root of every norm, so the
remaining factors are proved prime by complete trial division. The
split-root witnesses and whole-block uniqueness checks are actual.

- Canonical payload SHA256:
  `fcd8227dff68842b8feacef9a11281babc2594644b2a0ded2b968b1cd9b47f45`.
- JSON file byte SHA256:
  `42b72e6f95b1822f9bce3b708bcfdf5cc876641725a469d9f71365979955313a`.

These two hashes have different scopes and are not interchangeable.
The tuple checks exhaust their declared finite subsets, not every tuple
in every block. The replay claims neither common deep-boundary hits nor
the asymptotic density or farther-tail theorem, matching the proof's
scope.
