# PN1--PN4. Private norm support and higher-moment boundary coherence

Date: 2026-09-07. Complete ordinary candidate for independent review.
This is separate from the frozen MC finite Lean source. It proves
membership in an independent-ratio class for at least one half of an
actual root block asymptotically, and a stronger bounded-window
positive-excess estimate on that class. It does not control the
whole farther tail or every root.

Let B be a positive integer and for B<=k<2B put

    a_k=3k, w_k=a_k+zeta, Q_k=a_k^2+a_k+1,
    alpha_k=w_k/bar(w_k).

Define S_B to be the actual set of k for which Q_k has a prime
divisor r>12B. Later take n>=7 prime and B=n^4, with the actual
boundary T_n(k) and height t_k=log c_n(k) as in MC.

## PN1. A proved positive-density class of independent ratios

As B tends to infinity,

    |S_B| >= B/2-O(B log log B/log B).              (PN1)

For each k in S_B, there is exactly one prime r_k>12B dividing Q_k,
its valuation in Q_k is one, and it divides no Q_l for another
l in the entire block. The algebraic numbers alpha_k, k in S_B,
are multiplicatively independent.

Proof of the count. Uniformly on the block,

    9B^2 <= Q_k <49B^2,
    sum_k log Q_k=2B log B+O(B).

The norm polynomial 9X^2+3X+1 is never divisible by two or three.
Every supported prime is 1 modulo three. At such a prime r>=7 it
has exactly two simple roots, and exactly two lifts at every depth.
Its discriminant is -27, nonzero at r, so this statement also
follows directly from the derivative and elementary lifting.
With H_r=floor(log(49B^2)/log r), the actual interval count gives

    sum_k v_r(Q_k) log r
       <= 2B log r/(r-1)+2H_r log r.

Sum only over r<=12B with r=1 modulo three. The prime number theorem
for this fixed progression, with partial summation, gives

    sum_{r<=x, r=1 mod3} log r/(r-1)
       = (1/2)log x+O(log log x).

One sufficient primary input is the explicit bound
theta(x;3,1)=x/2+O(x/log x), obtained by specializing Theorem 1.2
of Bennett--Martin--O'Bryant--Rechnitzer. The paper and the exact
theorem were independently opened for this note:
https://arxiv.org/pdf/1802.00085 , printed page 5, (1.12).
Replacing 1/r by 1/(r-1) costs a convergent series. Partial summation
integrates the error O(1/(x log x)), yielding the displayed
O(log log x). This uses a fixed modulus, with no moving-field
uniformity assertion.

The endpoint error is O(B), because pi(12B)=O(B/log B) and
2H_r log r<=2log(49B^2). Thus the whole small-norm-prime mass is at most

    B log B+O(B log log B).

The remaining mass at primes >12B is consequently at least
B log B-O(B log log B). Each participating root contributes at most
log(49B^2)=2log B+O(1). This proves (PN1).

Proof of uniqueness and independence. Since (12B)^2>49B^2, a norm
can contain at most one prime >12B, with valuation exactly one.
If r>12B divided Q(a) and Q(b) at two distinct root parameters, then

    r divides Q(a)-Q(b)=(a-b)(a+b+1).

But 0<|a-b|<3B<r and 0<a+b+1<12B<r, a contradiction.
Thus r_k is private to that root in the entire block.
The primitive unramified element w_k has exactly one orientation
over r_k, of depth one. At that prime ideal, alpha_k has valuation
one or minus one, whereas every other alpha_l from the block has
valuation zero. Taking this valuation in a multiplicative relation
among the alpha_k's forces its k-th exponent to be zero. Doing this
for every k in S_B proves independence. This is actual ideal
factorization, not a random-prime assumption. QED.

## PN2. Higher moments at sufficiently deep boundary primes

Fix an integer nu>=2. There is a constant C_nu such that, for all
sufficiently large prime n, B=n^4, and every boundary prime q>B,

    #{k in S_B: q^(2nu) divides T_n(k)}
       <= (3 nu! n)^(1/nu).                       (PN2)

Proof. At a supported q, the ratios reduce to the finite norm-one
group and have order dividing 3n modulo q^(2nu). The split/inert
lifting proof of MC1 applies at this depth and gives a group of
size at most 3n. It is legitimate because q>B>n.

We make the height comparison for two ordered nu-tuples explicit.
Write

    z=prod_j(a_j+zeta)=R+S zeta.

Each |a_j+zeta|<=7B, so |R|<=2(7B)^nu by the quadratic norm
coordinate bound. A telescoping product expansion gives

    |z-prod_j a_j|<=nu(7B)^(nu-1).

The product of the a_j's is real. Taking imaginary parts therefore
gives |S|<=2nu(7B)^(nu-1). For a second tuple z'=R'+S'zeta,
the absolute value of its integer cross determinant is at most

    |RS'-R'S|<=8nu 7^(2nu-1) B^(2nu-1)=:C_nu B^(2nu-1).

For B>C_nu and q>B this is smaller than q^(2nu). If the two tuple
products have the same image in the finite group, their conjugate
cross difference shows that q^(2nu) divides this determinant.
The determinant must be zero. Thus the actual algebraic ratio
products are equal, not merely congruent.

By PN1's multiplicative independence, the two tuples have exactly
the same multiplicity of every root index. Each image fiber therefore
contains at most nu! ordered tuples, including repeated entries.
If M is the actual set size in (PN2), all its M^nu tuples land in a
group of size at most 3n, whence M^nu<=3n nu!. This proves (PN2).
The constants and the sufficiently-large-n condition depend on fixed
nu; no variable-nu uniformity is asserted here.

The corresponding result without the private-norm premise has not
been proved at higher moments. Rational ideal cancellations in
general tuple products cannot be discarded. PN1 is what discharges
that issue for the actual positive-density class.

## PN3. Positive excess in a farther interval

Fix nu>=3 and 0<delta<1-1/nu, and put

    Z=floor(B n^(1-1/nu-delta)).

For sufficiently large prime n this exceeds B. For k in S_B define
the actual nonnegative bounded-window excess

    F_(B,Z)(k)=sum_{B<q<=Z} (v_q(T_n(k))-3)_+ log q.

Then

    (1/B) sum_{k in S_B} F_(B,Z)(k)/t_k
       = O_(nu,delta)(n^(-delta)/log n).            (PN3)

Proof. Use the exact layer identity
(e-3)_+=sum_{j>=4} 1_(e>=j). For a fixed prime q, the layers
4<=j<2nu have at most sqrt(6n) actual roots in S_B, by PN2 with
nu=2. All layers j>=2nu have at most (3nu!n)^(1/nu) roots.
The elementary actual boundary height caps the number of layers by

    H_q<=3n L/log q,       L=log(6B+1).

Consequently

    sum_{k in S_B}(v_q(T_n(k))-3)_+ log q
       <= (2nu-4)sqrt(6n) log q
          +3n L (3nu!n)^(1/nu).                   (PN4)

This is an upper bound even when a displayed group of layers is
empty. Also t_k>=n log(3B). Since q<=Z<=Bn, one has
log q/log B<=5/4, and L/log(3B) is bounded. After division by
B*n*log(3B), (PN4) is at most C_nu n^(1/nu)/B.

A prime making this excess nonzero has exact homogeneous rank n.
The rank-one alternative would put q^2 in one of a,a+1, each
smaller than 6B+1<q^2. Hence q is in a class +/-1 modulo 3n.
The reviewed two-progression Brun--Titchmarsh estimate gives at most

    2Z/[(n-1)log(Z/(3n))]

eligible primes. Multiply the preceding per-prime bound by this
number. It is

    O_nu[Z n^(1/nu)/(B n log n)]
       =O_(nu,delta)(n^(-delta)/log n),

as asserted. The normalization is by the entire block size B;
we have not silently changed it to |S_B|.

This argument counts depths, rather than requiring zero positive
excess in the whole interval. It retains the actual large-prime
rank restriction and the private-norm source of tuple independence.

## PN4. A genuine positive-density domain and its remaining signed gate

For sufficiently large prime n, there is a set P_(n,nu,delta)
of actual roots of relative size at least 1/2-o(1) such that

    k in S_B,
    F_(B,Z)(k)/t_k <= n^(-delta/2),
    L_B(T_n(k))/t_k <= (log n)^(-1/2).             (PN5)

Indeed Markov in PN3 removes at most
O_(nu,delta)(n^(-delta/2)/log n) of the whole block.
The already reviewed prime-index FM and elementary EA estimates
at cutoff B give mean L_B/t=O(1/log n); Markov at (log n)^(-1/2)
removes at most O((log n)^(-1/2)). Intersect these two actual sets
with S_B and use PN1. All constants here concern fixed nu,delta.

Let W_Z(k) be the signed contribution of primes above Z. On this
set the finite prime decomposition gives

    J(T_n(k))/t_k
      <= W_Z(k)/t_k + (log n)^(-1/2)+n^(-delta/2).  (PN6)

The middle interval's signed contribution is bounded above by its
positive excess; its actual negative credits need not be omitted
in a sharper application. No assumption that its full mass is
small was used. The elementary angular bound then gives

    log rad(T_n(k))/t_k
      >=1-4/(3n)
          -[(log n)^(-1/2)+n^(-delta/2)]/3
          -(W_Z(k))_+/(3t_k).                     (PN7)

Thus a sequence in these sets with (W_Z)_+/t_k tending to zero
satisfies the restricted ABC estimate at every fixed tolerance
eventually. The condition on the unbounded farther tail is still
open. The result establishes a stronger finite interval on a proved
positive-density class; it does not settle the other roots or the
farther private top-rank packet.

For arbitrarily large FIXED nu, the exponent 1-1/nu-delta can be
made arbitrarily close to one. This statement does not interchange
the fixed-nu limit with n tending to infinity. A variable-nu version
would require a separate uniform audit of all constants.
No general higher-phase divisor-fiber conjecture, universal
small-prime simplicity premise, or unproved point-height bound
has been used. No Lean formalization of PN1--PN4 is claimed here.
