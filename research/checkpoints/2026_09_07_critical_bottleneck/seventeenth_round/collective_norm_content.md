# CC1--CC4. Collective content from the actual nonrectangular norm incidence

Complete ordinary candidate, 2026-09-07, prepared for independent review.
All objects below are actual Eisenstein integers. This note gives a uniform
height reduction for products over a consecutive input-root block. It does
not yet turn that reduction into a bound on the boundary-prime signed tail.
The input norm primes and the boundary primes must remain distinguished.

Put zeta^2-zeta+1=0, O=Z[zeta], N(a+b zeta)=a^2+ab+b^2.
Let B>=2 be an integer, K_B={B,...,2B-1}, and w_k=3k+zeta,
Q_k=N(w_k)=9k^2+3k+1. For nonzero Z=A+C zeta define
cont(Z)=gcd(|A|,|C|)>0 and Z_prim=Z/cont(Z).
No multiplicative independence is assumed in CC1--CC3.

## CC1. Exact finite content and oriented incidence

Each Q_k is odd, is 1 modulo 3, and only has split prime factors p=1 mod 3.
For each such p fix the two conjugate prime ideals (pi_p), (bar pi_p).
Let d_(k,p)=v_(pi_p)(w_k)-v_(bar pi_p)(w_k). The two valuations cannot
both be positive: the coordinate pair (3k,1) is primitive. Consequently
|d_(k,p)|=v_p(Q_k). All these valuations are integral and finitely supported.

For arbitrary integers x_k of finite support in K_B, form the canonical
actual product

    Z_x = product_(x_k>0) w_k^(x_k)
          product_(x_k<0) bar(w_k)^(-x_k).

The empty product is 1. Set

    U_p(x)=sum_k |x_k| v_p(Q_k),
    D_p(x)=sum_k x_k d_(k,p).

Then the exact identities are

    2 v_p(cont(Z_x)) = U_p(x)-|D_p(x)|,             (CC1)
    log N((Z_x)_prim)=sum_p |D_p(x)| log p.         (CC2)

Proof. Let E_p^+,E_p^- be the two ideal valuations of Z_x. They have
sum U_p(x) and difference D_p(x). A rational power p^j divides the two
integer coordinates exactly when j<=E_p^+ and j<=E_p^-, so its maximum
such j is min(E_p^+,E_p^-). The identity 2 min(s,t)=s+t-|s-t| proves
(CC1). Since N(Z_x)=product Q_k^|x_k| and division by its positive
integer content divides its norm by the square of that content, summing
over primes gives (CC2). Neither 3 nor an inert prime occurs in these
products. This proves all zero-coordinate and empty-product cases too.

The right side uses the full actual signed incidence (k,p,d_(k,p)). It is
not a common-hit rectangle and does not replace different prime ideals by
one artificial shared label. It is a finite weighted absolute-value
identity suitable for separate formalization after ordinary review.

## CC2. An exact uniform bound on where content can occur

Let J be any subset of K_B and W_J=product_(k in J)w_k, with no conjugated
factors and no repetitions. Every rational prime dividing cont(W_J)
is at most 12B. In fact it is at most 12B-5.

Proof. Such a prime p is split and occurs with both orientations in the
product. Primitivity of each w_k forces occurrences in two different
indices k,l. If p>12B-5, then

    p | Q_k-Q_l = 3(k-l)(3(k+l)+1).

But p>3, 0<|k-l|<=B-1<p, and
0<3(k+l)+1<=12B-5<p (the weak bound suffices even before using k!=l).
This is impossible. There is no ramified or inert contribution. QED.

This statement only needs positive products with each root used once.
The same support argument also works for the canonical Z_x in CC1:
a private prime can occur at only one index, in only its chosen orientation.
Without that canonical restriction it is false for general products:
w_k bar(w_k)=Q_k can have a private prime above 12B. One must cancel
opposite occurrences of the same index before applying the canonical form.

## CC3. Half of the logarithmic norm disappears in a complete block

For every interval J={a,...,a+H-1} contained in K_B, with 0<=H<=B,

    log cont(W_J) = (H/2) log B
                     + O(H log log B+B),                  (CC3)
    log N((W_J)_prim) = H log B
                     + O(H log log B+B).                  (CC4)

The constants are absolute; neither the starting point a nor H affects
them. Interpret the bounds for B tending to infinity, so log log B causes
no small-B convention issue. In particular, for the whole block H=B,

    log cont(W_KB) = (1/2+o(1)) B log B,
    log N((W_KB)_prim) = (1+o(1)) B log B,                 (CC5)

whereas log N(W_KB)=2B log B+O(B). The error in (CC3)--(CC4) is useful
uniformly on intervals of any fixed positive relative length.

Proof. The discriminant of 9X^2+3X+1 is -27. At every split prime p>=7
there are precisely two simple root classes modulo p, each lifting
uniquely at every p-power. Label these towers using the two orientations.
Let E_p^+(J),E_p^-(J) denote their total valuations in W_J. Since
9B^2<Q_k<36B^2, put

    h_p=floor(log(36B^2)/log p).

No individual depth exceeds h_p. An interval of H consecutive integers
contains H/p^j+epsilon points in either fixed root class modulo p^j,
with |epsilon|<=1. Thus for either orientation

    |E_p^sign(J)-H/(p-1)| <= h_p+1.                       (CC6)

Indeed, summing the first h_p errors costs at most h_p, and the omitted
geometric tail is H/[p^h_p(p-1)]<1: use p^(h_p+1)>36B^2, H<=B and p>=7.
For p<=12B, h_p>=1. The bound for min(E_p^+,E_p^-) has the same error.
By CC2, summation over these primes captures all the content, whence

    log cont(W_J)
      = H sum_(p<=12B,p=1 mod3) log p/(p-1)
        + O(sum_(p<=12B)(h_p+1)log p).                    (CC7)

The endpoint sum is O(B): each summand is at most log(36B^2)+log(12B),
and pi(12B)=O(B/log B). This includes primes not occurring in W_J;
their zero contribution and the error estimate (CC6) are still valid.

The fixed-modulus input

    theta(x;3,1)=x/2+O(x/log x)

gives, by partial summation and the convergent difference between 1/p
and 1/(p-1),

    sum_(p<=x,p=1 mod3) log p/(p-1)
       = (1/2)log x+O(log log x).

Substitution into (CC7) proves (CC3). Finally log Q_k=2 log B+O(1)
uniformly on K_B, and the identity N(W_J)=cont(W_J)^2 N((W_J)_prim)
proves (CC4)--(CC5). QED.

Primary analytic input actually reopened for this note: Bennett, Martin,
O'Bryant and Rechnitzer, *Explicit bounds for primes in arithmetic
progressions*, arXiv:1802.00085, Theorem 1.2, printed page 5, (1.12),
https://arxiv.org/pdf/1802.00085 . It is specialized only to fixed modulus
3; the same input was already used in PN1. No moving-modulus uniformity
or conjectural distribution of quadratic polynomial primes is used.

## CC4. Deletion, deterministic limits, and the remaining boundary bridge

For a disjoint decomposition K_B=J union F, the exact integer divisibility

    cont(W_KB) | cont(W_J) * N(W_F)/cont(W_F)              (CC8)

holds. The quotient on the right is an integer. For each split p write
(a,b) for the valuations of W_J and (c,d) for those of W_F. Then
min(a+c,b+d)<=min(a,b)+max(c,d), and max(c,d)=c+d-min(c,d).
This proves every primewise inequality in (CC8), hence the divisibility.
It implies the weaker but convenient bound

    log cont(W_J) >= log cont(W_KB)-sum_(k in F)log Q_k.   (CC9)

In particular removing o(B) arbitrary roots preserves the main term
(1/2)B log B of the full-block content. Removing a fixed positive
proportion has a genuine charged cost; (CC9) cannot establish this same
main term on the known roughly-half-sized independent domain.

The gain in (CC5) is an unconditional collective integer coefficient-height
gain on the complete actual block. It is not the ABC radical saving.
Its cancelled primes divide input norms Q_k, whereas a boundary prime
q dividing T_k=P(w_k^n) does not divide Q_k. No identity here identifies
input content with the negative credits (3-v_q(T_k))_+ log q.

Moreover, a prime hitting just one boundary T_k need not make the ratio
of W_J an n-torsion element: factors from the unhit roots remain. Thus
one cannot insert the lower height (CC5) into the US/JP torsion-target
argument without new simultaneous arithmetic premises. The full block
also need not be multiplicatively independent; that hypothesis is not
claimed or inferred from large content.

The next noncircular target is to relate the actual boundary incidence
(k,q,v_q(T_k)) to aggregate products whose oriented discrepancy in (CC2)
is controlled, while separately paying unhit-root factors. Until that
relation is proved, the far signed budget, exceptional individual roots,
independent-domain complement and general ABC representation remain open.
