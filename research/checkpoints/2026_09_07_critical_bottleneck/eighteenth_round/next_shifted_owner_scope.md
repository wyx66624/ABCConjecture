# Quantifiers and the original-tail boundary of SR

Next-only addendum to the complete candidate
next_shifted_boundary_resultants.md, SHA
3c7f8cce60282796ec07df5cc5f079c8958efff8eb3bdea048f9472633a51e03.
It does not alter a reviewed source or any publication input.

## A proved matched-cost consequence with its exact quantifier

Fix an original prime n>324, B=n^4 and a nonzero integer shift
|h|<B. Write t_k=n log|3k+zeta| and

    C_n(h)=2(3n-1)n log64+(3n-1)^2 log(1+|h|)+log3.

Let P be ANY finite set of distinct primes. For each p, select
ONE actual pair (k_p,k_p+h) in the block, and put

    b_p=min(v_p(T_{k_p}),v_p(T_{k_p+h}))>=1.

This may in particular be the pair attaining the maximum common
depth of that prime, with ties broken by the least integer k.
Define the assigned matched positive cost on an actual owner by

    L_h(k)=sum_{p in P:k_p=k} max(b_p-3,0) logp.

Then the following finite, unconditional inequalities hold:

    sum_k L_h(k) <= C_n(h),

    #{k: L_h(k)>epsilon*t_k}
          < C_n(h)/(epsilon*n log(3B))               (SO1)

for every real epsilon>0.

Proof. Each selected common depth is at most its corresponding
exponent in the literal integer C_T(h) of SR2. Distinctness of
the primes gives

    sum_p max(b_p-3,0)logp <= sum_p b_p logp
                         <= log C_T(h) <= C_n(h).

This positive-cost consequence is an upper bound, not a replacement
of the exact signed formula SR8. For an owner counted in SO1, the
cost exceeds epsilon*t_k>=epsilon*nlog(3B). Sum over this finite
set and use the first inequality to prove SO1. The same argument
for finitely many shifts uses the sum of their resultant costs
and restores prime three once, as in SR10. QED.

For fixed h, SO1 is O_h(n/(epsilon log n)) owners. Taking
epsilon_n=1/n makes this O_h(n^2/log n)=o(B), while the matched
positive cost at every other assigned owner is at most t_k/n.
This statement applies to actual roots of the complete block
without assuming multiplicative independence.

The quantifier is

    for EVERY specified prime/pair assignment,
    there EXISTS its corresponding small exceptional owner set.

It is not the assertion of one common good set valid for all
possible assignments simultaneously. A prime is assigned once;
the bound does not sum its common depth over every available
owner pair. No bound for the full depth v_p(T_{k_p}) follows if
it exceeds b_p.

## Why this does not close the original signed tail

1. Missing coverage is quantitative, not a small endpoint issue.
   For the original assigned label at k, a partner k+h can have
   smaller depth or no hit. The difference
   v_p(T_k)-min(v_p(T_k),v_p(T_{k+h})) remains unpaid. SR8
   retains this entire excess and all labels without a partner,
   with the depth-one/two negative contributions on their
   respective supports. No positive proportion of the original
   deep-label mass is proved to lie in the matched part.

2. The strongest independent-domain tail is particularly important.
   The already proved US3 uses L=log(8B), r=ceil(sqrt(n/2)).
   For q>8B with logq>=(r/2)L, at most one root of its
   multiplicatively independent domain I has depth at least four.
   Therefore, if BOTH endpoints of an SR pair are required to
   belong to I, its common depth at such q is at most three:
   the common positive cost is already zero there.
   Under the stronger condition logq>=2rL, q has at most one
   positive-depth root in I, so there is no common support at all.
   SR applies to the full block and permits a partner outside I,
   but supplies no theorem that such a partner exists, carries
   enough depth, or can be chosen with few shifts. It does not
   replace the unproved control of the complement.

3. The quadratic cost is global, not a per-root estimate.
   For a fixed shift, C_n(h)=O_h(n^2) is small compared with
   the complete block scale BnlogB, but is larger than the
   individual scale t_k of order nlogB. Only a finite Markov
   argument for the specified matched allocation yields SO1.
   It does not prove every original root satisfies an ABC bound.

4. An unrestricted collection of shifts removes the saving.
   Summing the proved bound for all |h|<B costs
   O(Bn^2logB), a factor of order n above BnlogB. The required
   few-shift covering or cancellation has not been proved.
   A chosen shift depending on each prime is allowed by SR10
   only with the explicit sum over the distinct shifts used.

5. Full ABC still requires more than a signed subpacket bound.
   Even a successful full-tail estimate on this special family
   must handle its exceptional roots and independent-domain
   complement and then justify the reduction or representation
   covering every primitive ABC triple. SR neither supplies
   that reduction nor disproves the parent routes.

The actual advance is a new coprime second polynomial with modulus-
independent degree and height, and a simultaneous all-prime common-
depth bound for the entire original block. Its unchanged bottleneck
is the genuinely unmatched or singleton prime-depth mass.
