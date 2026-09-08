# PA1–PA3. Legal paired packets and reciprocal adjacent divisors

Next-only complete ordinary candidate, 2026-09-07. Not in the frozen PDF.
All products in this note factor the actual squarefree Q=rad(c-1).
For c=2^e3^f retain NG0, A=2^(e-1), B=3^(f-1),
D=log(AB/Q)>0 and the original exact optimum D+Gamma.

## PA1. A constructive sufficient certificate using each prime once

Suppose one has an exact factorization of the actual integer Q as

    Q=R prod_{i=1}^m U_i V_i,       m>=1,

with R>=1 and 1<U_i<V_i positive integers. Since Q is squarefree,
all these nonunit factors are squarefree and pairwise coprime. They
may be composite packets; no prime is split or used twice.
Choose an actual divisor K|R and write

    h_min=K prod U_i,   h_max=K prod V_i,
    rho=max_i(V_i/U_i)>1.

If

    h_min<=A,              h_max>=Q/B,                       (PA1)

then the original exact central penalty satisfies

    Gamma <= max(0,log rho-D)/2,
    D+Gamma <= max(D,(D+log rho)/2).                          (PA2)

In particular rho<=AB/Q gives an actual central divisor and Gamma=0.

Proof. Consider only the genuine divisors

    H_J=K prod_{i notin J}U_i prod_{i in J}V_i,
    J_H=Q/H_J=(R/K) prod_{i notin J}V_i prod_{i in J}U_i.

These recover Q exactly and allocate each prime to exactly one output
packet. They are a legal subfamily of the original certificate; no
modified cost rule or repeated prime credit has been introduced.
In fact only m+1 of these genuine divisors are needed. Fix the given
order of the packets and put

    H_j=K prod_{i<=j}V_i prod_{i>j}U_i,       0<=j<=m.

This is a strictly increasing chain from h_min to h_max, and
H_j/H_(j-1)=V_j/U_j<=rho. Let j be the first index such that
H_j>=Q/B; existence follows from (PA1). If H_j<=A it is a central
divisor and Gamma=0. Otherwise j>=1, because H_0=h_min<=A, and

    H_(j-1)<Q/B<=A<H_j.

The central interval I=[log(Q/B),log A] has length D. Its distances
to these two actual divisors sum to

    log(H_j/H_(j-1))-D <= log rho-D.

Their minimum bounds the original penalty Gamma, since optimization
over all genuine divisors can only improve this legal choice. This
proves the first inequality in (PA2); adding D proves the second.
QED.

This also gives a bounded exact algorithm after the factor certificate
has been supplied. Starting with H_0, update H_j=(H_(j-1)/U_j)*V_j;
the division is exact because that packet has not previously been
replaced. At most m such updates, and integer comparisons H_j*B>=Q
and H_j<=A, find the central divisor or its two bracketing candidates.
For the latter case, compare the positive rational ratios
Q/(B*H_(j-1)) and H_j/A to choose the smaller logarithmic penalty.
No 2^m enumeration or floating-point comparison is needed. This is
not an efficient factorization algorithm or a universal supply theorem
for the paired packets.

## PA2. An actual nonsquare instance and a precise conditional gate

For the completely certified c=2^41 3^26 from NG3, take

    U_1=2729,  V_1=3073=7*439,
    R=857*292183*380261663,  K=380261663.

Their product is exactly Q. The exact checks

    K*2729 <= 2^40,
    K*3073*3^25 >= Q,
    3073*Q < 2729*(2^40)*(3^25)

prove (PA1) and rho<AB/Q. Therefore the original central penalty
is zero. This is outside DP because c is nonsquare. In this example
the global maximum divisor-gap parameter is Lambda=439/7, much
larger than AB/Q, so PA1 provides a strictly sharper sufficient test
than the uniform all-gap criterion. Its extra information is an
actual pair of close composite packets in the required location.

For a sequence of actual endpoints with Q tending to infinity, the
following is a true conditional implication: if D/log Q tends to
zero and one can supply certificates satisfying (PA1) with
log rho/log Q tending to zero, then the original optimum
(D+Gamma)/log Q tends to zero, by (PA2). A corresponding bound
D<=epsilon log Q+C and log rho<=epsilon log Q+C yields
D+Gamma<=epsilon log Q+C with the same constants.

Neither premise is established on all endpoints. In this stratum
D=log c-log rad(c(c-1)), so the first premise contains the restricted
scalar ABC problem. The paired-packet supply is a distinct additional
arithmetic condition, not a consequence of the finite example or of
having a moderately sized largest prime. This isolates a sufficient
gate without disguising its unproved input as a construction.

## PA3. General reciprocal adjacent-pair obstruction

Let Q=qR be squarefree, with q prime. Let d>1 divide R and let

    t=max{u:u|R, u<d}.

This maximum is well-defined because 1 is a divisor smaller than d.
If

    dtq <= R < d^2 q,                                         (PA3)

then R/d and dq are consecutive actual divisors of Q. If additionally
dq>max(A,B), then

    Gamma=log(dq/max(A,B)),
    D+Gamma=log(min(A,B)/(R/d)).                              (PA4)

Proof. A divisor H containing q but smaller than dq is qv with
v|R,v<d. Hence H<=qt<=R/d. A divisor H omitting q but larger than
R/d has R/H<d, so R/H<=t and H>=R/t>=dq. Both proposed endpoints
are divisors and are strictly ordered by (PA3). Their product is Q.
The central-interval computation from NG4 proves (PA4). QED.

There is a useful prime-prefix specialization avoiding a search for t.
Let d be a prime factor of R and let T be the product of all actual
prime factors of R smaller than d. If T<d, then t=T: a divisor below
d cannot contain any prime at least d, and T itself is below d.
Thus the fully explicit condition dTq<=R<d^2q suffices. NG4 is the
case T=p, where d is the second smallest prime factor of R.

This is a complementary-packet invariant involving the full actual
R=Q/q and a certified divisor threshold t. Largest-prime size alone
does not record it. Conversely an exact obstruction of this kind
means that PA1 cannot produce rho<=AB/Q for that same central
interval; otherwise the two proved conclusions would contradict.
It does not rule out a different legal certificate with different
proved rules, a finite useful family, or the parent ABC routes.

All statements here concern actual radicals and legal whole-prime
packets. The obstruction and sufficient certificate deliberately use
the same original optimum. No fixed-epsilon infinite counterexample,
new primality computation, Lean theorem or publication change is claimed.
