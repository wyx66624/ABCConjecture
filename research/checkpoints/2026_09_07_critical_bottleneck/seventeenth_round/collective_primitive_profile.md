# CP1--CP4. The primitive collective norm has a controlled powerful part

Complete ordinary candidate, 2026-09-07. This strengthens the exact norm
profile of the reviewed collective-content construction. It is separate
from CC1--CC4 and does not alter that reviewed source. It concerns input
norms, not the boundary radical of an ABC triple.

Keep B>=2, K_B={B,...,2B-1}, w_k=3k+zeta and Q_k=N(w_k). Let J be an
interval in K_B of length H, and put W_J=product_(k in J)w_k and
N_J=N((W_J)_prim). All products are actual integers as in CC.
Define the squarefree private norm product and a finite small-prime cap

    R_J=product_(p>12B, p divides some Q_k with k in J) p,
    h_p=floor(log(36B^2)/log p),
    M_B=product_(p<=12B,p=1 mod3) p^h_p.

## CP1. Exact localization after primitive cancellation

There is a positive integer D_J with

    N_J=R_J D_J,   gcd(R_J,D_J)=1,   D_J | M_B.       (CP1)

In particular

    N_J/rad(N_J) | D_J | M_B,
    0<=log N_J-log rad(N_J)<=log M_B=O(B).            (CP2)

The implied constant is absolute, and the finite divisibilities hold
also when J is empty.

Proof. At a split prime p<=12B, let N_j^+,N_j^- count the two oriented
root residue classes modulo p^j inside the same interval J. Each count
is either floor(H/p^j) or ceil(H/p^j), so

    |N_j^+-N_j^-|<=1.

No depth exceeds h_p. The exact CC1 profile therefore gives

    v_p(N_J)=|E_p^+-E_p^-|
             =|sum_(j=1)^h_p (N_j^+-N_j^-)|<=h_p.   (CP3)

At p>12B there is at most one root in the entire block whose norm p
divides, by the factorization of Q_k-Q_l in CC2. Its norm depth is one,
since p^2>(12B)^2>36B^2>Q_k. Its sole orientation cannot be cancelled.
Consequently all primes above 12B in N_J have depth exactly one and
are precisely those in R_J. There are no inert or ramified norm primes.
The resulting prime factorization proves (CP1) and the divisibilities
in (CP2).

Finally

    log M_B<=pi(12B) log(36B^2)=O(B)

by the elementary Chebyshev upper bound on pi(x). This step needs no
prime number theorem in a progression; it is only a bound on the finite
small-prime remainder. QED.

## CP2. Almost all aggregate norm mass is radical mass

Fix delta>0. Uniformly on intervals J with H>=delta B, as B tends to
infinity,

    log N_J=H log B+O(H log log B+B),
    log R_J=H log B+O(H log log B+B),                  (CP4)
    log rad(N_J)/log N_J >= 1-O_delta(1/log B).       (CP5)

The first formula is the reviewed CC3 theorem. The second follows by
subtracting log D_J=O(B), and the last follows from (CP2), using
log N_J>= (delta/2) B log B for sufficiently large B. The only fixed-
progression analytic input here is exactly that already stated in CC3;
the stronger O(B) powerful-part bound itself was proved in CP1.

This is a concrete radical conclusion about the primitive INPUT NORM.
It neither replaces rad(T_k) nor makes the boundary-prime signed gate
true. Such a replacement would mix two different arithmetic objects.

## CP3. A uniform obstruction to using this aggregate as a compressed seed

Suppose positive integers V,Q,g satisfy

    N_J=V Q^g,   Q>1,   g>=2.                        (CP6)

Then

    R_J | V,   Q^g | D_J.                            (CP7)

In particular D_J>1 and

    log V/g >= (log 2)(log R_J)/(log D_J).            (CP8)

Proof. A prime in R_J has total norm depth one. Its exponent in Q must
therefore be zero, and its exponent in V is one. Every prime of Q is
instead a prime of D_J, and its g-fold exponent is at most that in D_J.
This proves both divisibilities. Since Q>=2, (CP7) gives
g log 2<=g log Q<=log D_J. Combining this with log V>=log R_J proves
(CP8). No power-free or coprimality condition on V and Q is needed.

For every fixed delta>0 there are c_delta>0 and B_delta such that, for
all B>=B_delta, all intervals H>=delta B, and EVERY representation
(CP6),

    max(1,log V)/g >= c_delta log B.                  (CP9)

Indeed CP1 supplies log D_J<=C B with one absolute C, while CP2 gives
log R_J>=(delta/2)B log B. If D_J=1 there is no representation (CP6);
otherwise substitute these two bounds into (CP8).

Thus the primitive collective product has a real coefficient-height gain,
but it cannot itself provide a sequence of small-lambda compressed norm
seeds on these macroscopic intervals. This excludes only that proposed
use of this specific aggregate, not small-lambda representations of the
original roots or any other combined construction. Boundary signed sums,
exceptional roots, the independent-domain complement and general ABC
coverage remain unresolved.

Finite formalization candidates after ordinary review are (CP3), the
actual prime-power divisibilities in (CP1)/(CP7), and the logarithmic
consequence (CP8) with explicit positive hypotheses. The distributional
CC input and the asymptotic universal quantifiers are not claimed as Lean.

## CP4. A sharper exponent ceiling from an actual prime of Q

Under (CP6), the existing pointwise depth bound yields the stronger

    g <= log(36B^2)/log 7,
    log V/g >= (log 7)(log R_J)/log(36B^2).           (CP10)

Proof. Choose an actual rational prime p dividing Q, possible since Q>1.
By (CP7) it divides D_J, so p is split and p>=7. The exponent comparison
and (CP3) give

    g <= g v_p(Q) <= v_p(D_J) <= h_p
         <= log(36B^2)/log 7.

All quantities are positive except that log R_J may be zero; the latter
case gives the valid zero lower bound. Since R_J divides V, the second
inequality in (CP10) follows. This argument does not bound g merely by
the total log D_J: it uses one actual prime and its exact residual depth.

For fixed delta>0 and all sufficiently large B, uniformly on all intervals
H>=delta B and all representations (CP6), it follows that

    max(1,log V)/g >= (delta log 7/6) B.              (CP11)

Indeed CP2 supplies log R_J>=(delta/2)B log B, and B>=36 gives
log(36B^2)<=3 log B. Thus CP11 strengthens CP9. The improvement was
identified in adversarial review of CP1--CP3. It has exactly the same
input-norm and specific-aggregate scope, without a new ABC implication.
