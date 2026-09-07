# RC1--RC4. Reciprocal depth budgets for the three actual arms

Date: 2026-09-07. Ordinary proof submitted for independent review.
This extends the signed compensation mechanism without altering the
frozen ninth-round SA proof. The new sufficient subclasses include one
squarefree quotient with two entirely unrestricted quotient arms.
General membership in any such subclass is not assumed.

Keep the exact actual SA domain: w=a+b*zeta is primitive and unramified,
Q=N(w)>=7, 3 does not divide Q; n>=5 is coprime to 6. The normalized
power A+B*zeta and the three nonzero pairwise-coprime integer quotients
D1=A/a, D2=B/b, D3=(A+B)/(a+b) are those of SA1. Put

    T_n=|P(w^n)|, T_1=|P(w)|,
    c=max(|A|,|B|,|A+B|), t=log c,
    c_1=max(|a|,|b|,|a+b|), Delta=3t-log T_n.

For real Y>=5 write

    S_i=sum_{q>Y}v_q(D_i)log q,
    R_i=sum_{q>Y,q|D_i}log q,
    L_i=sum_{q<=Y}v_q(D_i)log q,
    L=sum_{q<=Y}v_q(T_n)log q.

All sums are over primes; signed integer valuations mean absolute-value
valuations. In particular L_i>=0, sum_i L_i<=L, and the actual height
relations are

    t-Delta-log c_1-L_i<=S_i<=t.                       (RC1)

The input-boundary overlap is retained: for nonzero integers U,V,
log W_Y(UV)<=log W_Y(V)+log|U|. No coprimality between T_1 and the
quotient product is required.

## RC1. Exact finite compensation with arbitrary integer depth caps

Choose caps h_i in the positive integers together with the symbol
infinity. An infinite cap means no depth restriction on that quotient.
Let I be the indices with finite cap and define

    beta_i=3/h_i for i in I, beta_i=0 otherwise,
    E_i^(h_i)=sum_{q>Y}(v_q(D_i)-h_i)_+ log q  (i in I),
    C=sum_i beta_i,
    A=sum_i (beta_i-1)_+,
    B=max_i (beta_i-1)_+.

Thus 0<=A<=6 and 0<=B<=2, even if the chosen caps vary with the
actual root and exponent. Empty sums are zero. Then the exact bound is

    log W_Y(T_n)
      <= (3-C)t + A(Delta+log c_1)+B L+log T_1
         +sum_{i in I} beta_i E_i^(h_i)
         -3sum_{i not in I}R_i.                       (RC2)

Proof. For a finite cap h_i, each supported prime depth e satisfies
e<=h_i+(e-h_i)_+. Hence

    3R_i>=beta_i(S_i-E_i^(h_i)).

Pairwise coprimality makes the signed cost on the quotient product
exactly sum_i(S_i-3R_i). The preceding inequality therefore gives

    log W_Y(D1D2D3)
      <=sum_i(1-beta_i)S_i
          +sum_{i in I}beta_i E_i^(h_i)
          -3sum_{i not in I}R_i.                     (RC3)

For beta_i<=1, the coefficient of S_i is nonnegative and (RC1) bounds
its contribution by (1-beta_i)t. For beta_i>1, use the lower bound in
(RC1); its contribution is at most

    (1-beta_i)t+(beta_i-1)(Delta+log c_1+L_i).

Summation gives (3-C)t+A(Delta+log c_1)+B L, since sum_i L_i<=L.
Finally append T_1 using the stated exact overlap inequality and
T_n=T_1|D1D2D3|. This proves (RC2) with every uncontrolled arm's
radical contribution retained.

## RC2. Uniform signed-tail subclasses

Let E denote

    E=sum_{i in I}beta_i E_i^(h_i)-3sum_{i not in I}R_i.

There are absolute effective constants A_1,A_2 such that

    log W_Y(T_n)/t <=3-C+epsilon(n,Y;A,B)+E/t,         (RC4)

where

    epsilon=A A_1 log(4n)/n+(2A+3)/n
               +B A_2 Y^3 log Y log^2(4n)/n.         (RC5)

For Y=n^(1/6), this error tends to zero uniformly in all actual moving
roots and all caps. In particular suppose C>=3, equivalently

    sum_{i in I}1/h_i>=1.                            (RC6)

If every finite-cap arm actually has v_q(D_i)<=h_i for all q>Y,
then (log W_Y(T_n))_+/t tends to zero uniformly in that class as
n tends to infinity. Every infinite-cap arm may have arbitrary depth.
More generally it suffices that E_+/t tends to zero. If C>=3+delta
for a fixed delta>0 and the caps are met, the stronger upper bound

    limsup log W_Y(T_n)/t <=-delta                    (RC7)

holds along such sequences.

Proof. The independently reviewed all-prime two-place theorem applies
after the same sector normalization as in SA3. Its ramified exponent is
zero, the residual is a unit, the actual exponent is n and lambda=1/n.
Thus

    Delta/t<=A_1 log(4n)/n,
    L/t<=A_2 Y^3 log Y log^2(4n)/n.

For the remaining input-height term, use

    log c_1<=(1/2)log Q+log(2/sqrt3),
    log T_1<=(3/2)log Q, t>=(n/2)log Q, Q>=7.

It follows that

    (A log c_1+log T_1)/t
      <=[A+3+2A log(2/sqrt3)/log7]/n
      <=(2A+3)/n,

because 2log(2/sqrt3)<log7 and A>=0. This proves (RC4)--(RC5).
The bounds A<=6, B<=2 make its convergence uniform even for moving
caps. If their finite-depth requirements hold, all their excess terms
are zero and E<=0. Therefore (RC6) implies the claimed one-sided
sublinear upper cost. The more general E condition and the fixed
negative margin follow from the same inequality. There is no claim
of a two-sided limit for the signed quantity.

As in SA4, the earlier absorption yields the restricted ABC estimate
uniformly for sufficiently large n for each fixed target epsilon. No
bounded-n, moving-root conclusion is obtained by counting exponents.

## RC3. Concrete distinct subclasses

Any permutation of the following caps satisfies the equality in (RC6):

    (1,infinity,infinity),
    (2,2,infinity),
    (2,3,6),
    (2,4,4),
    (3,3,3).                                        (RC8)

These are actual depth requirements, not assumptions that independent
random factors obey those requirements. The second line recovers SA.
The first line proves that one squarefree quotient above Y suffices
to compensate the complete depths in both other quotient arms.
The third and fourth lines allow positive signed prime contributions
at depths above three and compensate them using another actual arm.
The last line is the elementary case in which each prime already has
nonpositive signed cost.

More precisely, for a chosen single arm i define

    E_i^(1)=sum_{q>Y}(v_q(D_i)-1)_+log q.

Equation (RC2) at (1,infinity,infinity) becomes

    log W_Y(T_n)
      <=2Delta+2log c_1+2L+log T_1
           +3(E_i^(1)-R_j-R_k).                     (RC9)

Thus the squarefree hypothesis can be weakened to the actual net
condition (E_i^(1)-R_j-R_k)_+/t ->0. This preserves both other
arms' radical contributions, while placing no upper bound on either
of their individual depths.

For the caps (2,3,6) and (2,4,4), A=B=1/2. Their height error is
smaller than the generic bound, but no optimization claim is needed.
Examples with C>3, such as (2,3,3), give the negative margin of (RC7).

The five patterns in (RC8) are precisely the maximal integer-cap
patterns under componentwise enlargement that satisfy (RC6), up to
permutation. To see this, sort h1<=h2<=h3, with infinity largest. If
h1=1, the pattern is below (1,infinity,infinity). If h1=2 and h2=2,
it is below (2,2,infinity). If h1=2 and h2=3, the reciprocal condition
forces h3<=6. If h1=2 and h2>=4, it forces h2=h3=4. If h1=3, both
others must equal three; h1>=4 is impossible. Each displayed maximal
pattern has reciprocal sum exactly one. This is a classification of
the proved coarse depth-cap criteria, not of all actual signed-tail
solutions.

## RC4. Sharpness only for the abstract finite ledger

If fixed caps satisfy C<3, their depth restrictions together with equal
arm masses do not imply a sublinear signed ledger. This assertion has
an explicit counterexample family in the finite integer-weight model.
It is not an actual Eisenstein counterexample.

Let H be the least common multiple of the finite caps, with H=1 when
there are none, and put t_m=mH for positive integers m. For a finite
cap h_i, take a one-entry list with depth h_i and integer weight
t_m/h_i. For an infinite cap take depth t_m and weight one. All
weights are nonnegative integers, every finite cap is met, and each
total depth mass is exactly t_m. Small-prime and height-defect budgets
may both be zero in this abstract model. If r is the number of
infinite caps, its exact signed sum is

    sum_i(S_i-3R_i)=(3-C)t_m-3r.                    (RC10)

Consequently its normalized value tends to the strictly positive
number 3-C. This satisfies all the finite-list depth and balanced-mass
premises, so additional information is necessary to go beyond (RC6)
using that model. The three lists are not asserted to be prime
factorizations, to satisfy the actual arm additive relation, or to
have a common Eisenstein norm. Therefore (RC10) does not disprove
an actual arithmetic subclass with smaller reciprocal sum, and it
does not refute the general signed-tail target.

## Remaining membership question

The proof gives rigorously established classes with an explicit path
to the needed one-sided tail estimate. It does not prove that every
actual orbit has an admissible cap pattern, or that such patterns hold
on a density-one set. A construction forcing large private depths in
all three arms can disprove automatic cap membership without refuting
(RC2), (RC4), or their net-credit sufficient conditions. Complete signed
budgets must still be checked in any such construction.

The principal unresolved object is therefore the actual excess-minus-
radical term E, coupled through the common power, additive arm relation
and norm. This result neither assumes its smallness nor claims that a
change of notation proves it. It adds proved, distinct sufficient
subclasses to the previous two-cubefree-arm mechanism. No global ABC
proof, radical theorem or general prime-depth bound is asserted.

This is currently an ordinary proof. The existing ninth-round Lean
module proves the special two-arm finite integer-weight ledger, not
the entire new parameter family or its logarithmic-form inputs.
