# Actual exponent realizations and the boundary of direct residue tests

Date: 2026-09-07. Ordinary proofs, independently reviewed by both the
critical-bottleneck and independent-route agents.
This file begins the fourth round and does not alter the frozen third round.

For positive coprime integers a,b, write

    M0=a^2+ab+b^2, U=ab, M1=U^2+UM0+M0^2=F(a,b),
    F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4.

The associated actual Eisenstein integers are z0=a+b*zeta and
z1=U+M0*zeta, where zeta^2-zeta+1=0. Both are primitive. The second
primitivity follows from gcd(ab,M0)=1. The first mixed output is the
primitive positive triple (ab,M0,(a+b)^2).

## LP1. Direct fixed-modulus power tests cannot exclude the whole branch

Fix integers m,n>=2 and any finite collection of positive integer moduli.
Let L be their least common multiple. There are infinitely many primitive
positive seeds, balanced in the limit, whose M0 is an m-th power residue
and whose M1 is an n-th power residue modulo every specified modulus.

Proof: for any integer k>=1 choose (a,b)=(Lk,Lk+1). Then gcd(a,b)=1,
a+b tends to infinity and a/(a+b) tends to 1/2. Since (a,b)=(0,1)
modulo L, one has M0=M1=1 modulo L. The integer one is both specified
power residues. This proves all assertions simultaneously.

This is a precise limitation on direct tests of the original two norm
integers against finitely many fixed residue moduli. It is not a limitation
on every argument using local information. In particular, the successful
QG3 descent passes to finitely many auxiliary covering classes and excludes
them using additional global information. Nor are the integers in LP1
claimed to be actual powers. LP1 applies even to the square/square branch
that QG3 already proves globally impossible for positive seeds.

## LP2. Primitive nonzero p-adic solutions exist for all fixed exponents

For any m,n>=2 and any prime p, there are a,b in Z_p, both nonzero,
with ab(a+b) nonzero, at least one coordinate a p-adic unit, such that
M0 is an m-th power and M1 is an n-th power in Z_p. The same system has
a positive real solution.

Proof: set s=2*max(v_p(m),v_p(n))+1, a=p^s and b=a+1. These are actual
positive integers and b is a p-adic unit. On consecutive seeds one has

    N_c(a)=M0=1+3a+3a^2,
    F_c(a)=M1=1+7a+20a^2+26a^3+13a^4.

Both differences from one have valuation at least s. For f(T)=T^m-M0,
v_p(f(1))>=s>2*v_p(f'(1)); the analogous statement holds for n and M1.
The usual strong Hensel lemma gives roots in Z_p, necessarily units.
The nonzero and primitive assertions follow from the chosen integers.
Over R choose any positive seed and the positive real m-th and n-th roots.

Different primes can use different seeds and roots. This statement does
not give a common rational or integer power solution, and it does not
assert that a prescribed arithmetic orbit equidistributes. Its coexistence
with QG3 shows why local norm-power solubility alone misses that global
descent obstruction. Hensel's lemma is an ordinary external local-field
input; no Lean verification of LP2 is claimed here.

## LP3. Arbitrary actual extraction depths with two nonsquare residuals

For every two integers g0,g1>=2, there are infinitely many primitive
positive seeds, again consecutive and balanced in the limit, with actual
Eisenstein representations

    z0=v0*(1+2*zeta)^g0,
    z1=v1*(2+7*zeta)^g1,

where the norms V0=N(v0), V1=N(v1) are positive nonsquares,

    M0=V0*7^g0,  M1=V1*67^g1,
    v_7(V0)=0,  v_67(V1)=0,  v_13(V0)=1,  v_31(V1)=1.

In particular both exponents can be arbitrary odd numbers, or arbitrary
numbers congruent to two modulo four. This is an actual infinite integer
family with the complete extraction premises, not merely congruence data.

Proof: use the consecutive seed (a,a+1). At a=1,

    N_c(1)=7,  N_c'(1)=9,
    F_c(1)=67, F_c'(1)=177=43 (mod 67).

Thus N_c has a simple root at one modulo seven and F_c has a simple root
at one modulo sixty-seven. A simple root modulo p lifts uniquely to a
root modulo p^e for every e. Of its p extensions modulo p^(e+1), exactly
one remains a root; choose any of the others. This gives an integer
residue A7 modulo 7^(g0+1) with v_7(N_c(A7))=g0, and a residue A67
modulo 67^(g1+1) with v_67(F_c(A67))=g1. In both cases the original
residue modulo the prime is one.

Impose also

    a=5 (mod 13^2),  a=14 (mod 31^2).

Here N_c(5)=91=7*13 has exact thirteen-adic depth one, while
F_c(14)=574771=31*18541 has exact thirty-one-adic depth one
(18541=3 mod 31). The four moduli are pairwise coprime. CRT therefore
gives one progression containing infinitely many positive a satisfying
all four exact valuation requirements. All these seeds are primitive.

The norm of 1+2*zeta is seven and that of 2+7*zeta is sixty-seven.
Both are prime Eisenstein integers. At a=1 modulo seven, z0 reduces to
1+2*zeta, so it is divisible by that prime, with its chosen orientation.
At a=1 modulo sixty-seven, z1 reduces to 2+7*zeta. Primitivity prevents
the conjugate prime from dividing the same z_i. Unique factorization and
the exact norm valuations therefore give exactly the displayed powers
of these fixed prime elements in z0 and z1. Their quotients v0,v1 are
actual Eisenstein integers; no factorization of the remaining norm is
assumed or needed. The quotients remain primitive and use only the
compatible oriented prime factors of each z_i.

Because a and a+1 are consecutive, M0=1 modulo three, so no ramified
factor occurs in the first representation; the second norm is always
prime to three. The specified thirteen and thirty-one valuations survive
division by 7^g0 and 67^g1 and prove that both residual norms are
nonsquares. Exact extraction-root valuations prove their coprimality
with their own displayed root norms. Positivity and the limiting balance
are as in LP1.

This refutes the proposed exclusion based on exponent parity alone,
including its nonsquare-residual variant. It does not establish the small
lambda gate. For fixed g0,g1 along the CRT progression, both log V_i grow
without bound, so both displayed lambda_i=max(1,log V_i)/g_i diverge.
For varying exponents the fixed-first-root lambda obstruction from LR4
continues to apply whenever its bounded-first-lambda premise holds.
Neither high ABC quality nor the required radical compression is inferred.

## Existing necessary conditions and scope of finite evidence

The previously proved thirteen-adic theorem remains useful: if thirteen
divides F(a,b) for a primitive seed, its valuation is exactly one. Hence
an actual extraction with exponent h>=2 must retain that occurrence in
its residual. It excludes a specific residue branch from pure powers,
not all primitive seeds. The LP3 consecutive family has a-b=-1, so it
does not enter that branch for M1.

An exploratory exact scan of all primitive 1<=a<=b<=500 found ten first
norm cubes and no second norm cubes. This is only finite diagnostic data;
the null result is not a proof of nonexistence or finiteness. The explicit
LP3 construction instead supplies exact simultaneous nontrivial extraction
depths for every chosen exponent pair, with nonsquare residuals retained.

The independent route's new fixed-residual power-class finiteness arguments
are reviewed separately. Those global covering arguments are compatible
with LP1--LP3: the true residual classes of the CRT progression may move,
and local models do not imply rational points on a fixed auxiliary cover.

## LP4. Residual support escape on the actual realization family

Along each LP3 progression at fixed g0,g1, for every fixed finite prime
set S, eventually the support of V1 is not contained in S. This is a
stronger conclusion than growth of log V1, with no effective prime-growth
rate asserted.

Proof: the independently reviewed PL6 total-support theorem states that
F(a,b) supported on any fixed finite prime set admits only finitely many
primitive positive seeds. If V1 were supported in S, then
M1=V1*67^g1 would be supported in S union {67}. PL6 gives finitely many
such seeds, while the progression's height tends to infinity. Therefore
the support condition eventually fails. This uses the ordinary global
finite-descent/Faltings input of PL6, not just the local CRT construction.

The earlier LP1--LP3 arguments themselves use no Faltings theorem. LP4
is a separate consequence joining an actual realization family to the
independent global finiteness boundary.
