# LC1--LC3. A common actual root set for large-cutoff signed compensation

Date: 2026-09-07. Eleventh-round ordinary candidate for independent review.
The tenth-round mathematical sources remain frozen. This result combines
the proved actual full-mass estimate with the signed ledger. It supplies
a weaker sufficient tail condition on a precisely identified majority
of roots; it does not assert that those roots satisfy that condition.

Let n>=5 range through integers prime to six. Put

    B=n^4,
    Z=floor(B*sqrt(log n)/(1+log log n)),
    eta_n=(log n)^(-1/4).

For each integer B<=k<2B let w=3k+zeta and use the actual normalized
SA quotient arms D1,D2,D3 at index n. Write T=T_n(k), t=log c_n(k),
T1=|P(w)|, c1 for the largest input arm, and Delta=3t-log T.
The actual quotient arms are nonzero and pairwise coprime and satisfy
T=T1*|D1D2D3|. All these facts have the same primitive unramified
antecedents as SA. Let

    L_Z(T)=sum_{p<=Z}v_p(T)log p,
    J(T)=log(T/rad(T)^3)=log T-3log rad(T).

The symbols rad(T) and the quotient radicals below involve all distinct
prime divisors in their stated ranges. J is signed and may be negative.

## LC1. The common actual set and uniform signed inequality

There are absolute constants C,N0 such that for every eligible n>=N0
there is a set G_n of actual root indices satisfying

    |G_n|>= (1-C*eta_n)*B,
    L_Z(T_n(k))/t_k<=eta_n for every k in G_n.          (LC1)

This set is chosen independently of every depth-cap choice below.
For every k in G_n and every triple

    h_i in Z_{>=1} union {infinity},
    sum_i 1/h_i>=1, with 1/infinity=0,

put beta_i=3/h_i for a finite cap and beta_i=0 otherwise. Define

    E_Z(h;k)=sum_{i: h_i finite} beta_i
                  *sum_{p>Z}(v_p(|D_i|)-h_i)_+ log p
                -3 sum_{i: h_i=infinity}
                  sum_{p>Z,p|D_i}log p.               (LC2)

Then, pointwise for every such root and every such choice,

    J(T)/t <= 39/n+3*eta_n+E_Z(h;k)/t,                (LC3)

and hence

    log rad(T)/t >= 1-43/(3n)-eta_n
                         -(E_Z(h;k))_+/(3t).         (LC4)

The caps can vary arbitrarily with n and k. No union bound over cap
choices is used or required.

Proof. The reviewed FM/EA mean for the complete small-prime mass is
at most C*(log n)^(-1/2). Apply Markov at eta_n to obtain (LC1).
The resulting set G_n only tests L_Z/t, so it is a common set for
all subsequent finite-ledger choices.

The EA angle theorem gives Delta/t<=4/n on every root of this block.
The norm inequalities also give

    log c1/t<=2/n, log T1/t<=3/n.                     (LC5)

For the first, c1<=(2/sqrt(3))*sqrt(Q)<=Q since Q>=7, whereas
t>=n log Q/2. For the second, the cubic boundary identity gives
T1<=2Q^(3/2)/(3sqrt(3))<=Q^(3/2), and use the same lower bound
for t. Thus delta=Delta+log c1 obeys delta/t<=6/n.

In the exact RC ledger write

    Ccap=sum beta_i, A=sum(beta_i-1)_+,
    Bcap=max_i(beta_i-1)_+.

Then Ccap>=3, A<=6 and Bcap<=2. Its actual signed tail inequality is

    log W_Z(T)<=(3-Ccap)t+A*delta+Bcap*L_Z(T)
                           +log T1+E_Z(h;k),          (LC6)

where log W_Z(T)=sum_{p>Z,p|T}(v_p(T)-3)log p.
Substitute (LC1) and (LC5) into (LC6), dropping the nonpositive
main term. This bounds log W_Z(T)/t by

    39/n+2eta_n+E_Z(h;k)/t.

The signed contribution of the remaining primes is at most their full
mass, so

    J(T)-log W_Z(T)
        =sum_{p<=Z,p|T}(v_p(T)-3)log p<=L_Z(T).

This proves (LC3). Finally log T=3t-Delta and
3log rad(T)=log T-J(T). Use Delta/t<=4/n, then replace E_Z by its
positive part to obtain (LC4). Every constant is independent of the
root and of the cap triple, including infinite caps.

## LC2. A large-cutoff sufficient subclass and its exact quantifiers

If k belongs to G_n and the actual prime depths of every finite-cap
arm above Z are at most its chosen h_i, then its finite excess is
zero and E_Z(h;k)<=0. Therefore

    log rad(T)/t >=1-43/(3n)-eta_n.                   (LC7)

One may use any of the five maximal patterns from RC, but only at
primes above Z:

    (1,infinity,infinity), (2,2,infinity),
    (2,3,6), (2,4,4), (3,3,3).

For example, squarefreeness above Z of just one quotient arm suffices;
the other two arms may have arbitrary prime depths. Even that actual
squarefreeness need not hold when its finite excess is compensated by
the two retained radical credits in (LC2).

More generally, for any sequence of actual roots k_n in G_n with
cap choices satisfying the reciprocal condition and

    (E_Z(h;k_n))_+/t_{k_n} ->0,

one has log rad(T_n)/log c_n>=1-o(1). Thus for each epsilon>0,
all sufficiently large members of that sequence satisfy

    c_n <= rad(T_n)^(1+epsilon).                      (LC8)

The cap-only consequence (LC7) is uniform for all eligible roots and
all cap choices, once n is sufficiently large for that epsilon.
These are statements conditional on the displayed membership. We do
not prove that any fixed positive proportion of G_n satisfies the
cap condition, nor that every actual root does. The set excluded by
(LC1) is retained, and bounded n with moving roots is not disposed of.

The structural gain is that Z/B tends to infinity. The sufficient cap
or net-credit test now concerns only primes beyond a threshold larger
than the actual root interval. It permits arbitrary depths at all
smaller primes on G_n, because their entire mass has already been
proved negligible there. This is stronger as a tail membership test
than imposing the same cap at n^(1/6), but it trades the latter's
pointwise small-prime estimate for an explicit actual exceptional set.

## LC3. What the established private-depth construction does not test

The TD construction chooses a root w=a+zeta with a>=M0 and

    M0=3 product_i q_i^(s_i+1), s_i>=4.

Thus every selected private prime satisfies

    q_i<= (a/3)^(1/(s_i+1))<=a^(1/5).                (LC9)

If such a chosen representative belongs to a block a=3k,
B<=k<2B, then a/3=k<2B and each selected q_i<(2B)^(1/5).
For the present asymptotic window, Z>B for sufficiently large n,
so all those selected primes lie below Z whenever the representative
belongs to the present block. This is a conditional comparison of
cutoffs, not an assertion that the constructed family lies in B=n^4.

In fact the published three-prime representatives satisfy
a>=M0>=3(6n+1)^15, because q_i=1 modulo 6n and s_i+1>=5.
Thus those representatives themselves do not lie in B=n^4 for n>=5;
the preceding conditional comparison does not silently assert otherwise.

Consequently the selected depths in that particular CRT construction
cannot by themselves disprove automatic cap membership above Z on
this block. Its other prime factors were never completely controlled,
so we cannot infer that its actual roots satisfy the new cap condition
either. TD continues to refute the old automatic cap-union assertion
at the lower cutoff exactly as stated. No route is discarded on the
basis of this distinction.

The nearest remaining problem is now explicit: control the actual
net excess in (LC2), or prove a sufficient large-prime subclass with
actual membership, while also treating the exceptional roots. LC1 is
an unconditional theorem on a common actual set. LC2 is a conditional
signed consequence on that set. Neither is a proof or disproof of ABC.
No new finite experiment or Lean formalization is claimed for LC.
