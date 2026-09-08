# AP1--AP2. All-owner paired depth above the original block length

New ordinary candidate, outside the 600-page publication. This consequence
of the fully reviewed SR resultant bound removes a prime-assignment
quantifier for its explicitly restricted paired part. It leaves the
unmatched-depth and singleton problems open.

Let n>324 be prime, B=n^4, d=3n-1, and use the actual positive integers
T_k and primitive F_n=T_n/3 from CG and SR. For a nonzero integer h with
|h|<B, put I_h={k: B<=k<2B and B<=k+h<2B} and

    b_q(k,h)=min(v_q(T_k),v_q(T_(k+h))),
    b_q(h)=max_(k in I_h) b_q(k,h),
    C_T(h)=lcm_(k in I_h) gcd(T_k,T_(k+h)),
    C_n(h)=2dn log64+d^2 log(1+|h|)+log3.

The reviewed SR theorem gives log C_T(h)<=C_n(h). In particular all
quantities below are finite sums, supported on literal boundary primes.

## AP1. A simultaneous sum over every actual owner

Define, without choosing one owner for each prime,

    L_h^>(k)=sum_(q>B prime) max(b_q(k,h)-3,0) log q.

Then

    sum_(k in I_h) L_h^>(k)
      <= d sum_(q>B prime) max(b_q(h)-3,0) log q
      <= d log C_T(h)
      <= d C_n(h).                                  (AP1)

Proof. The leading coefficient of F_n is n*3^(3n-2). Every q>B
is distinct from three and n, so reduction modulo q retains degree d.
Consequently F_n mod q has at most d distinct roots in F_q. The B
consecutive integer indices in [B,2B) give distinct residues modulo q.
Hence at most d original indices k can have q dividing T_k, because
T_k=3F_n(k) and three is a q-unit. Requiring the shifted index to be
in the block and also divisible can only reduce this number.

For each q, at most d summands max(b_q(k,h)-3,0) are nonzero,
and each is at most max(b_q(h)-3,0). Sum over the complete finite
prime support. The prime exponent of C_T(h) is b_q(h), so the
next inequality follows term by term. The final inequality is SR. QED.

This is an upper bound for the positive portion of a specified paired
ledger. It does not replace the full signed identity SR8, nor transfer
its negative contributions to a different support. The extra factor d
pays for counting the same prime at every actual owner instead of one.

## AP2. One exceptional set for all these primes

Let t_k=n log|3k+zeta| and epsilon>0. Define the actual exceptional set

    E_h(epsilon)={k in I_h: L_h^>(k)>epsilon*t_k}.

Then

    #E_h(epsilon) < d C_n(h)/(epsilon*n log(3B)).     (AP2)

Indeed |3k+zeta|^2=9k^2+3k+1>(3B)^2 throughout the block, so
t_k>=n log(3B). Summing the strict inequality defining the finite
exceptional set and applying AP1 proves AP2; if the set is empty,
the displayed strict bound also holds because its right side is positive.

For fixed nonzero h, C_n(h)=O_h(n^2). With epsilon=1/n, the same
actual ledger on every nonexceptional owner is at most t_k/n and

    #E_h(1/n)=O_h(n^3/log n)=o(B).

Unlike SO1, E_h is not chosen after an arbitrary prime/pair assignment:
it is defined directly by all actual common depths above B. It still
depends on h, and it controls only owners for which k+h is also in
the block. For fixed h there are |h| missing endpoints, which can be
included explicitly if one states a conclusion about the whole block.

For a finite set H of allowed shifts, define at each k the largest
L_h^>(k) over its valid shifts (zero if none). It is at most their sum.
Thus one exceptional set for this maximum satisfies the corresponding
non-strict bound with d*sum_(h in H)C_n(h) on the right. The bound is
strict when H is nonempty. If H is empty, both the maximum and the
exceptional set are zero. This assertion does not produce a valid
shift at a desired depth for any singleton.

## Remaining limitation

There is no proved lower bound on the fraction of the original full
positive prime-depth cost contained in AP1. In particular a prime may
have large v_q(T_k) while every available partner has a smaller depth
or no hit. All that excess remains outside L_h^>. In the previously
isolated independent-domain very large prime range, two endpoints in
that domain cannot even have common depth greater than three. AP1
permits other original endpoints but proves neither their existence nor
adequate depth. It does not provide a per-root full signed estimate,
the exceptional-root complement, or coverage of arbitrary ABC triples.

The q>B restriction is essential to the stated d-owner bound: smaller
primes can repeat their residues many times across the block. No bound
for those repeated residues is silently included. The result advances
the exact paired part of the arithmetic route; it neither completes
nor rules out its parent uniformity problem.
