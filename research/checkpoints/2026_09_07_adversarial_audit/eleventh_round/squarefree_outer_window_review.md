# Independent ordinary review of SQ1--SQ3

Date: 2026-09-07. Full ordinary proof review PASS.
Source: `2026_09_07_critical_bottleneck/eleventh_round/squarefree_outer_window.md`.
Reviewed SHA256:
`040b66359c95d61ac4de5ecb3d9c378531000c62c748bfecfbb14e3df6b7e162`.

SQ1 concerns prime indices n>=5 and actual integers k in [B,2B),
B=n^4. For every q>B, q>n eliminates exponent lifting, so a supported
prime has rank one or n. Rank one with depth at least two would force
q^2 to divide one of the coprime individual factors a,a+1. Both factors
are smaller than q^2. The proof correctly compares each factor, not
their product, and therefore rules out the old-rank exception completely.

The actual rank-n residue count is at most 3 phi(n). Simplicity and
Hensel lifting preserve that count at precision q^2. Counting the actual
integer interval gives 3 phi(n)(B/q^2+1), without any assumption of
uniform actual-root distribution. The union bound divides by B exactly
once. The summable first term is at most 3n/B, while the two-progression
Brun--Titchmarsh input and phi(3n)=2phi(n) yield precisely
6U/[B log(U/(3n))]. Its denominator is positive throughout the stated
U>B domain. No per-prime exceptional set is mistaken for a joint result.

For U=floor(B log n/log log n), the asserted O(1/log log n) fraction
follows with the given sufficiently-large-prime qualification. SQ2's
global identity retains all supported small primes and has the correct
negative coefficient -2 on the proved squarefree window mass. No lower
bound for that mass is asserted.

SQ3 uses the already reviewed full-mass mean at U: its prime-index terms
are respectively O(log n/n), O(1/log log n), and O(1/n), with the separate
elementary 2/3 contribution O(1/n). Markov at epsilon=(log log n)^(-1/2)
and intersection with the joint squarefree set give one actual set of
the claimed size. The angular lower bound then locates between
3-4/n-epsilon and 3 units of normalized full mass beyond U. Eventually
U>6B+1 excludes all old-rank support there, and q>n makes its remaining
depth exactly its first depth at rank n.

The final signed consequence remains conditional on the positive part
of the actual far cost minus the proved window credit. The window credit
itself is o(height) on this set, so it cannot pay a positive linear far
cost. The remaining primes, individual exceptional roots, and arbitrary
root membership remain open. This review introduces neither a new
finite experiment nor a claim of Lean formalization of the analytic
theorem. The sieve version used is the same previously reviewed uniform
real-endpoint theorem, not a stronger unverified prime-counting estimate.
