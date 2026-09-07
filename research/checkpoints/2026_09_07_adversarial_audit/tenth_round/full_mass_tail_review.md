# Independent review of full-mass tail location

Date: 2026-09-07. Complete ordinary review of FM1--FM3: PASS.
The source was read in full:
`2026_09_07_critical_bottleneck/tenth_round/full_mass_tail_location.md`,
SHA256 `9d0fc8af14cf3c7781d218090fd704d97c9e5b409e62f1ba5177c56efd3590d5`.
No correction was required. Only this independent review was written.

## Actual counting and first-depth summation

The root block is genuinely primitive and unramified, and its powers
have nonzero boundary at every positive index. The actual height lower
bound is therefore available for every block member. A prime dividing
the root norm has no boundary contribution; no supported prime is
removed by restricting to the norm-unit residue states.

For every supported q>=5 the exact rank divides n and is coprime to q.
The homogeneous valuation law consequently has lifting term v_q(n),
whose weighted sum over all supported primes is at most log n. The
exact-rank classes can be counted separately. Their at most 3phi(d)
simple roots each lift uniquely, so a full interval has at most
3phi(d)(B/q^e+1) representatives at depth at least e.

The actual first-depth cap is floor(3d log(6B+1)/log q). Summing
from one gives 3phi(d)B log q/(q-1) plus the same endpoint cost
9phi(d)d log(6B+1). A zero cap causes no problem: the true sum is
zero and the displayed bound remains nonnegative. No universal
first-depth bound or probabilistic root distribution is assumed.

## Constants and the rank-dependent progression sum

An eligible prime is 3dj+1 or 3dj-1 for j>=1. The denominators q-1
are respectively 3dj and 3dj-2, the latter at least dj. Since all
relevant j are at most floor(Z), replacing primes by all such integers
and using the harmonic bound proves

    sum log q/(q-1)<=2 log Z(1+log Z)/d.

Thus the main term has coefficient 6 and the divisor sum
sum_(d|n) phi(d)/d, which is at most tau(n). In particular the
rank spacing has not been lost by replacing every rank's eligible
primes with all primes.

The previously reviewed uniform Brun--Titchmarsh bound applies to
both reduced progressions because Z>3n>=3d. Their combined count
is at most 4Z/(phi(3d)log(Z/(3d))). Using phi(3d)>=2phi(d)
and the uniform logarithm denominator gives endpoint mass at most
18Z sigma(n)log(6B+1)/log(Z/(3n)). Normalization by the actual
height lower bound and log(6B+1)<=2log(3B) yields precisely 36.
All quantities whose denominators are replaced are nonnegative.

## All-index mean and the remaining tail

For B=n^4 and the stated Z, eventually Z>=5 and Z>3n. The elementary
divisor estimate makes the main term O(log n/sqrt(n)). The already
reviewed all-index bound sigma(n)/n<=exp(18)(1+log log n) cancels
the corresponding factor in Z/B, leaving O((log n)^(-1/2)). The
exponent-lifting term is O(1/n).

The reviewed two-place theorem applies with unit residual and
lambda=1/n for every index, using positive-sector normalization to
preserve the boundary valuations and height. Its estimates at two
and three add only O(log^2(n)/n). The resulting mean bound is for
all primes up to Z, with no lower-cutoff gap.

Markov at eta=(log n)^(-1/4) gives an exceptional proportion at most
C*eta. On every remaining actual root, the full small-prime mass
is at most eta times height. Subtracting it from the exact full
mass log T_n and the uniform archimedean estimate gives the displayed
lower bound 3-A log(4n)/n-eta. The upper bound three follows directly
from the product of three arms of size at most the largest arm.
This is uniform on a varying set of good block members, not a theorem
about an arbitrary fixed root or the exceptional roots.

At prime n>=5 the only possible ranks are one and n. For q>Z>n,
rank-one valuations equal their old-boundary depths, without exponent
lifting. Their complete mass is at most log T1, hence at most 3/n
times height. Subtracting it proves the uniform top-rank concentration.
At the remaining rank-n primes the full depth is the first depth,
again because q>n.

## Precise limitation

The conclusion locates full valuation mass. It gives no lower bound on
the signed excess or on a harmful private-depth contribution. A simple
prime has positive full mass and negative signed cost. The proof is
therefore compatible with the desired radical saving and with ABC.
The counting, interval endpoint and earlier two-place inputs are
ordinary results; no new Lean formalization is claimed by this review.
The full high-prime radical/depth relation and exceptional-root behavior
remain open.
