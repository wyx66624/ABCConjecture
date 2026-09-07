# Independent review of the sieved actual-root window

Date: 2026-09-07. Reviewed the complete SW1--SW3 note at
`2026_09_07_critical_bottleneck/seventh_round/sieved_rank_window.md`.
Result: ordinary proof PASS, including the stated external input.

Independently opened the author-hosted Montgomery--Vaughan paper,
*The large sieve*, Mathematika20 (1973), printed121, Theorem2,
equation (1.10):
https://personal.science.psu.edu/rcv4/personal/Publications/large_sieve.pdf
Its uniform interval estimate only requires y>q. With x decreasing
to zero and y=Z-x, the prime-count difference is the through-Z
count for x<2, and the right side converges to
2Z/(phi(q) log(Z/q)). There is no hidden fixed-modulus limit.

For rank d|n, the possible primes lie in the two distinct reduced
classes plus or minus1 modulo3d. The premise Z>3n licenses both
uses of the theorem for every divisor. The ratio
phi(d)/phi(3d)<=1/2 and the common logarithmic denominator give
18 Z sigma(n) log(6B+1)/log(Z/(3n)) before normalization.
Dividing by B n log(3B) gives the stated constant36. The first-depth
main term and the actual lifting cost are unchanged from the fully
reviewed sixth-round integer-interval proof. Taking the minimum with
12(Z+1)/B is legitimate because the same nonnegative endpoint
quantity has both upper bounds.

With B=n^4, Y=n^(1/6), Z=floor(B sqrt(log n)), and bounded
sigma(n)/n, the new endpoint is O(log(n)^(-1/2)). The first and last
terms are at most5/(12 sqrt(n)) and1/(4n). Markov applied to this
nonnegative cost gives exceptional fraction O(log(n)^(-1/4)) at
threshold log(n)^(-1/4). Prime powers indeed have sigma(n)/n<=2.
The window now exceeds B and extends beyond the first possible
top-rank progression. It does not assert existence of a top-rank
prime inside every such window.

The exceptional roots and primes larger than Z remain uncontrolled.
Neither this average nor the cyclotomic size budget proves the
pointwise global signed-tail gate. No new Lean theorem is claimed.
