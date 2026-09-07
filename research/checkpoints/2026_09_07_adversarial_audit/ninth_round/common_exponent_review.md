# Independent ordinary review of common-exponent compatibility

Date: 2026-09-07. Status: CE1--CE4 complete ordinary review PASS.
No mathematical correction was required.

Read the complete
`2026_09_07_independent_route/ninth_round/common_exponent_compatibility.md`.
The proof concerns actual positive primitive seeds with M=R^p and
F=Q^p for the same odd prime p>=3 and positive integer roots. It
does not assert existence of any such seed.

## The cyclotomic factor and its exceptional prime

The actual identity F-M^2=ab(a+b)^2 is exact. Primitivity makes
M coprime to each of a,b,a+b, so gcd(M,F)=1 and gcd(Q,R)=1.
Since F>M^2, D=Q-R^2 is a positive integer. The geometric sum
S=Phi_p(Q,R^2) satisfies DS=ab(a+b)^2.

For a prime q dividing S, neither Q nor R vanishes modulo q: an
extreme term would be the only nonzero term of the sum. For q!=p,
the ratio Q/R^2 has p-th power one and cannot be one, since then
the sum would be p. Its order is exactly p, giving q=1 modulo p.

In characteristic p the sum is D^(p-1), so p divides S exactly
when it divides D. This remains valid when p divides one root.
If p divides D, coprimality forces both roots to be p-units. The
binomial expansion has first term p R^(2p-2) of valuation one.
Every subsequent intermediate term has both a binomial factor p
and a factor D, and the last term D^(p-1) has valuation at least
two. Thus the exceptional valuation is exactly one, not merely
bounded by a quantity depending on the exponent.

## Full valuations, constants and the actual good support

For every prime outside 1 modulo p other than p, all its valuation
in DS is in D. At p there is at most one extra valuation from S.
Therefore the full bad part U of ab(a+b)^2 divides pD. Its equality
to a_bad b_bad c_bad^2 uses additivity of valuations and does not
require any unproved radical decomposition. Removing p as well
leaves a full part dividing D itself.

The positivity Q>R^2 gives S>=p R^(2p-2). The uniform norm-ratio
bound is correct. An equivalent direct integer certificate is

    4M^2-9ab(a+b)^2
      = (a-b)^2 (4a^2+7ab+4b^2) >= 0.

It gives D<=4R^2/(9p), and then U<=pD<=4R^2/9. Since c_bad^2
divides U, c_bad<=2R/3. The strict inequality M<c^2 yields
R<c^(2/p), so c_good>(3/2)c^(1-2/p)>1. Consequently at least
one actual prime dividing c lies in 1 modulo p. Every such prime
is at least 2p+1, since the positive multiplier in kp+1 must be
even for an odd prime p. The assertion is not that all primes of c
lie in that progression.

Taking logarithms gives the precise full-valuation mass inequalities
CE8--CE9, including their strict signs and constants log(3/2) and
log(4/9). D>=1 gives R^2>=9p/4, and M<c^2 gives the strict
height bound log c>(p/4)log(9p/4). The negative constant in CE9
causes no inconsistency: this same height restriction ensures the
upper bound is nonnegative wherever such an actual seed exists.

## Unequal exponents and the remaining scope

For M=A^h, F=B^g, a common odd prime p dividing both h and g
provides the actual positive integer roots A^(h/p), B^(g/p).
All the preceding conclusions therefore apply separately to every
chosen common odd prime divisor. For p tending to infinity the
good-mass ratio is at most one and strictly greater than 1-2/p;
the stated limit follows, while CE10 forces the height to infinity.

This is a uniform valuation-mass statement on the actual seed, not
a density theorem for arbitrary primes. It supplies no sharp lower
bound on the radical, no upper bound on seed height and no general
ABC conclusion. Relatively prime exponents, the ramified first norm
3R^p, and nonunit residuals do not fit the displayed difference of
two p-th powers and remain separate open branches.

This review is of the ordinary elementary proof. No finite search
or computational example was needed or presented as a substitute,
and no Lean formalization of CE1--CE4 is claimed by this record.
