# Independent ordinary review of HB1--HB4

Date: 2026-09-07. Status: complete ordinary arithmetic review PASS.

Reviewed in full:
`2026_09_07_cm_image/pure_power_height_budget.md`, SHA256
`36fea83f6f5380ccdcaae93c90ba4958ab2894c8fd9e5a39ee1dfae2f82c9bab`.

The precise prerequisites are positive primitive integers a,b,
F(a,b)=Q^p, integer Q>1, prime p>7, and the stated actual boundary
support conditions. The trace t_q is an integer. No density estimate,
new local q=p argument, or uniform rational-point upper bound is used.

HB1: splitting in Q(sqrt(-3)) forces each support prime to exceed
three, hence q>=7. If q=p, p<2q is immediate. Otherwise prime
divisibility of (q+1-t_q)(q+1+t_q) puts p into one factor. For q>=7,
(q-1)^2-4q=q(q-6)+1>0. The Hasse inequality therefore gives
|t_q|<q-1, making both factors positive and strictly less than 2q.
A positive integer multiple of p is at least p, proving p<2q.
Since Q has a prime divisor at most Q, p<2Q follows. Below 19 the
only split primes are 7 and 13; their separate exclusions imply Q>=19.

HB2--HB3: with H=max(a,b), positivity bounds each monomial by its
coefficient times H^4, and the coefficient sum is 13. Raising
p/2<Q to the positive integer power p preserves strictness, giving
(p/2)^p<Q^p=F<=13H^4. Taking logarithms is valid throughout, since
H>=1 and p/2>0. This yields precisely p log(p/2)<T and the strict
lower bound on log H, where T=log(13)+4 log H.

HB4: for T>=e^2, put z=log T>=2. The function T/log T is increasing
there, so 2T/log T>=e^2>2. Also z-2log z is positive at z=2 and
nondecreasing thereafter. Consequently

    (2T/log T) log(T/log T)
       = 2T(1-log z/z) > T.

The function x log(x/2) increases for x>=2. If p>=2T/log T, this
contradicts HB3, proving p<2T/log T. The explicit threshold is
retained; the rearrangement is not asserted for smaller T. As
H tends to infinity, T is asymptotic to 4log H, so the effective
O(log H/log log H) exponent bound follows. Conversely p tending to
infinity implies log H/(p log p) has lower limit at least 1/4.

No correction was needed. The BT1--BT4 review in
`twist_sturm_review.md` separately discharges the boundary-support
premise for every actual pure p-th power, retaining its complete
ordinary and exact modular-software dependencies. This arithmetic
review neither formalizes those dependencies nor extends the result
to arbitrary moving residual V>1.
