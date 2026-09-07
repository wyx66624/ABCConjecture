# Independent review of the split-progression compatibility theorem

Date: 2026-09-07. Status: AC1--AC3 complete ordinary review PASS.
No mathematical correction was required. Only this review was written;
the author's source and the frozen eighth-round files were not edited.

Reviewed in full:
`2026_09_07_critical_bottleneck/ninth_round/split_progression_compatibility.md`,
SHA256 at review
`ca6fa8518f1d3ab2b25727e10432d3ffc2b90a307fc25895c5223699b3a63696`.
The SA1 quotient definitions, the CE1--CE3 full-valuation allocation,
and the exact homogeneous rank law H1 in `next_signed_tail.md` were
also reread at their relevant statements and proofs.

## Exact power root, units, and the selected arm

The primitive actual element a+b*zeta contains neither an inert
rational factor nor both orientations of a split prime. If its norm
is divisible by 3, primitivity forces a=b!=0 modulo 3, and writing
a=b+3k gives norm 3(b^2+3bk+3k^2), of 3-adic valuation exactly one.
This is incompatible with the pure norm R^p for p>=5. The element
is therefore unramified. Every remaining oriented exponent is
divisible by p, so Eisenstein unique factorization gives u*w0^p.

The unit removal is valid because gcd(p,6)=1: the p-th power map
on mu_6 is bijective. Absorbing a unit p-th root gives the exact
identity w^p=a+b*zeta, not only equality up to a unit. The root
remains primitive and unramified and has norm R. It is a nonunit;
the established primitive split support then implies R>=7 and
nonzero input boundary arms. This argument does not extend merely
by replacing p>=5 with an arbitrary odd exponent divisible by 3.

The arm correspondence was checked separately in both cases:

* If p=1 modulo six, SA1's normalized output is w^p=(a,b), so its
  sum arm is c and its input divisor is ell=x+y, namely D3.
* If p=5 modulo six, that output is bar(w)^p=bar(a+b*zeta)
  =(c,-b). Its first arm is c, with input divisor ell=x, namely D1.

Thus c=ell*D_j is an actual integer identity in either case. Signs
of ell and D_j are allowed, and all valuations mean valuations of
their absolute values. There is no further independent rotation
that might change which input arm occurs.

## New excluded primes, rank one, and full depths

A prime in J is 1 modulo p but not 1 modulo 6p. Since p is odd,
it is at least 2p+1, so it is neither 2, 3, nor p. If it were split,
it would also be 1 modulo 3. Its oddness and gcd(p,6)=1 would then
force it to be 1 modulo 6p. Hence it is inert. Also gcd(M,c)=1
forces q not to divide the root norm R, so the residue ratio and
the unramified local valuation law are both available.

The cubic boundary identity gives d_q dividing p. Since p is prime,
d_q is 1 or p. In the inert case q+1 is divisible by 3, and for
alpha=w/bar(w) one has alpha^(q+1)=1. Therefore the order of
alpha^3 divides (q+1)/3. If d_q=p, then p divides q+1, contrary
to q+1=2 modulo p. This excludes the new-rank case without treating
inert and split residue groups as interchangeable.

Consequently d_q=1. The exact homogeneous LTE formula applies with
q>3, q not dividing R, and q not dividing the exponent p. It gives

    v_q(T_p)=v_q(T_1)+v_q(p)=v_q(T_1).

The SA product identity then says the sum of the three nonnegative
quotient valuations is zero. Every D_i is q-free. In particular
c=ell*D_j gives v_q(c)=v_q(ell), at the complete depth. Multiplying
over all distinct primes in J proves J divides |ell|. This is
stronger than radical divisibility and retains arbitrary old depths.

The norm bound for the selected arm is exact. When ell=x+y,
4R-3ell^2=(x-y)^2; when ell=x, it is (x+2y)^2. Thus
|ell|<=2sqrt(R)/sqrt(3), proving all of AC3. The prime p exception
from CE has not been discarded: it belongs to c_bad(p), not to J.
The same is true of primes 2 and 3.

## Exact support partition and constants

CE applies to precisely the same actual common-power equations and
retains its exceptional single p in the cyclotomic factor. It gives
c_bad(p)<=2R/3. The two conditions defining c_bad(p) and J partition
the primes outside 1 modulo 6p, with disjoint support and their full
valuations unchanged. Their product is exactly c_bad(6p).

Multiplication therefore gives

    c_bad(6p)<=4R^(3/2)/(3sqrt(3)),
    c_good(6p)>=3sqrt(3)c/(4R^(3/2)).

Because M=R^p=c^2-ab<c^2, the latter is strictly greater than
(3sqrt(3)/4)c^(1-3/p). Its constant is greater than one and its
power of c is positive for p>=5. The good part is consequently
greater than one and has an actual prime divisor q=1 modulo 6p,
which must satisfy q>=6p+1. The theorem does not say that every
prime dividing c lies in that progression.

The logarithm of the good part is exactly the full weighted
valuation sum in AC7. The strict sign and the constant term are
preserved when taking logarithms. For chosen common primes tending
to infinity, the normalized sum lies between 1-3/p and one, so
the claimed limit follows by squeezing. This is a statement about
the actual seeds, not a density or independence assertion.

Equivalent integer certificates, useful for later formalization, are

    3J^2<=4R,
    27*c_bad(6p)^2<=16R^3.

They follow from J dividing ell, the displayed norm identities,
and the squared CE bound 9*c_bad(p)^2<=4R^2. They do not add a
new existence claim or a formalization claim to this review.

## Unequal exponents and scope

For M=A^h and F=B^g, each common prime p>=5 yields the required
positive integer roots A^(h/p) and B^(g/p). Applying the theorem
separately to each such p is legitimate, even when p is neither
whole exponent. Its assumptions do not justify applying it to
relatively prime exponents, the first norm 3*A^h, or nonunit residuals.

The progression loss is paid by one actual input arm; it was not
obtained by multiplying unrelated congruence probabilities. Full
depths at that input arm remain in the bound. Existence or general
membership of the simultaneous pure-power class, control of its
surviving large primes, a sufficient radical lower bound, and a
uniform upper bound on actual point height remain unproved.

The dependencies used here are the established ordinary Eisenstein
factorization, the exact homogeneous rank/LTE law, SA1, and CE1--CE3.
No modularity, prime-density theorem, finite search, or claimed Lean
formalization is needed for this ordinary review. No ABC proof or
disproof follows from these necessary compatibility conditions.
