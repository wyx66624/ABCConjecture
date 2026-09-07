# SQ1--SQ3. Joint squarefreeness beyond the actual root interval

Date: 2026-09-07. Eleventh-round ordinary candidate for independent review.
This proves actual simultaneous first-depth membership on a growing
prime interval, rather than assuming those primes are usually shallow.
The remaining larger-prime tail and the exceptional roots are not resolved.

Let n>=5 be prime and B=n^4. For integers B<=k<2B put

    a=3k, w_k=a+zeta, Q_k=a^2+a+1,
    T_n(k)=|P(w_k^n)|, t_k=log c_n(k),
    T_1(k)=a(a+1).

These are actual primitive unramified roots. At supported primes q>=5
use the reviewed exact rank d_q=ord((w_k/bar(w_k))^3 mod q).

## SQ1. A quantitative union bound for actual repeated primes

For every real U>B, let Bad(n,U) consist of actual k in the block
for which some prime B<q<=U satisfies q^2|T_n(k). Then

    |Bad(n,U)|/B
      <=3n/B+6U/[B log(U/(3n))].                     (SQ1)

Here U>B=n^4>3n, so the denominator is positive. In particular set

    U_n=floor(B log n/log log n).

For all sufficiently large prime n, U_n>B and

    |Bad(n,U_n)|/B=O(1/log log n).                   (SQ2)

Outside this actual exceptional set, every supported prime in the
entire interval (B,U_n] has exact depth one simultaneously.

Proof. A supported prime cannot divide Q_k. Since q>B>n, the
homogeneous valuation law has no exponent-lifting term, and its rank
divides n. The only possibilities are rank one and rank n.

Rank one cannot give a repeated prime here. Its valuation is the
valuation in T_1=a(a+1). The two factors are coprime, so q^2 dividing
their product would force q^2 to divide one of them. Both a and a+1
are less than 6B+1, whereas q^2>B^2>6B+1 because B>=625. This is
impossible. The comparison is with each individual old factor, not
with their product.

Thus every bad prime has exact rank n. The established finite-field
rank calculation gives at most 3phi(n) simple roots in the k-variable
modulo q at this rank. Every such root has exactly one lift modulo
q^2, and the rank is unchanged after lifting. Counting actual integers
k in the interval, not sampling uniform residues, gives

    #{k: exact rank n at q and q^2|T_n(k)}
       <=3phi(n)(B/q^2+1).                           (SQ3)

Every eligible q is in one of the progressions q=1,-1 modulo 3n.
Union-bound (SQ3) over B<q<=U. The first part after division by B
is at most

    3phi(n) sum_{m>B}1/m^2<=3n/B,

using the integral bound sum_{m>B}m^-2<=1/B for integer B.
For the second part the established two-progression Brun--Titchmarsh
bound is

    #{eligible q<=U}<=4U/[phi(3n)log(U/(3n))].

Since n>=5 is prime, phi(3n)=2phi(n). This gives the second term
in (SQ1). No independence of primes or uniform actual-root measure
has been assumed. Finally U_n/B is asymptotic to log n/log log n,
and log(U_n/(3n)) to 3log n. The first term is 3/n^3 and the
second O(1/log log n), proving (SQ2).

The conclusion is joint: the exceptional set was defined by the
existence of any repeated prime in the interval. On its complement,
all primes in that interval satisfy the depth-one statement at once.
It is not a separate almost-all statement for each fixed prime.

## SQ2. The window supplies actual signed credit, with no mass lower bound

For a root outside Bad(n,U_n), define

    M_window(k)=sum_{B<q<=U_n}v_q(T_n(k))log q,
    H_low(k)=sum_{q<=B}(v_q(T_n(k))-3)log q,
    W_far(k)=sum_{q>U_n}(v_q(T_n(k))-3)log q,

with all sums restricted to supported primes. Actual squarefreeness
in the window gives exactly

    M_window=sum_{B<q<=U_n,q|T_n(k)}log q,
    J(T_n(k))=W_far(k)-2M_window(k)+H_low(k),         (SQ4)

where J(T)=log T-3log rad(T) is the global signed cost.
Thus

    J(T_n(k))<=W_far(k)-2M_window(k)+L_B(T_n(k)).     (SQ5)

This retains a proved negative credit, rather than treating it as an
unverified generic property. It does not give a positive lower bound
on M_window. Squarefreeness alone is compatible with no supported
primes in the window at all.

## SQ3. The remaining top-rank packet still carries almost all full mass

Put epsilon_n=(log log n)^(-1/2). There is an actual set H_n of
indices, of relative size at least 1-C epsilon_n for all sufficiently
large prime n, such that every k in H_n has the SQ1 joint squarefree
property and also

    L_{U_n}(T_n(k))/t_k<=epsilon_n,                  (SQ6)
    0<=M_window(k)/t_k<=epsilon_n,                   (SQ7)
    3-4/n-epsilon_n
       <= [sum_{q>U_n}v_q(T_n(k))log q]/t_k<=3.      (SQ8)

For every prime in the sum in (SQ8), its actual rank is n and its
valuation is its first depth. Thus the uncontrolled object is still
the primitive top-rank packet, now beyond U_n.

Proof. Apply the already proved FM1 full-mass mean at U_n. Since
n is prime, tau(n)=2 and sigma(n)/n=1+1/n. Its three terms are
respectively O(log n/n), O(1/log log n), and O(1/n). The elementary
EA estimate adds at most 20/n for primes two and three. Therefore

    (1/B)sum_k L_{U_n}(T_n(k))/t_k<=C/(log log n).

Markov at epsilon_n removes at most C epsilon_n of the actual
roots. Intersect its complement with the SQ1 good set. The latter
has exceptional fraction O(epsilon_n^2), so the resulting set has
the asserted size and (SQ6). Inequality (SQ7) is immediate.
The EA angular estimate gives log T_n/t_k>=3-4/n; subtract (SQ6)
to obtain (SQ8). The upper bound is the elementary log T_n<=3t_k.

For sufficiently large n, U_n>6B+1. No q>U_n can divide either
of the old input factors a,a+1, both less than 6B+1. Hence rank
one does not occur at all in (SQ8). Also q>n eliminates exponent
lifting. The homogeneous law therefore identifies every such
valuation with its rank-n first depth exactly.

For roots in H_n, (SQ4)--(SQ7) give a sufficient signed condition:
if along an actual sequence in these sets

    (W_far-2M_window)_+/t_k ->0,

then J(T_n)/t_k has nonpositive limsup. Combining with the same
angle bound gives the restricted ABC conclusion, for each fixed
epsilon>0 at sufficiently large indices. This remains a conditional
consequence. In fact the proved window credit is itself o(t_k) on
H_n, so it cannot be presented as an unconditional payment for a
positive linear far-tail cost. No linear amount of radical credit
has been proved in the remaining packet.

## Dependencies and the next pointwise question

Actual primitive root blocks -> exact homogeneous ranks and simple
lifting -> integer interval counts at depth two -> two-progression
Brun--Titchmarsh -> joint window squarefreeness. The ordinary proof
of each input is in the sixth/seventh-round rank-window notes. The
source is the already independently opened Montgomery--Vaughan
Theorem 2 (1973), equation (1.10), with its reviewed real-endpoint
specialization; no new unverified version of the sieve is used.

The mass-location addendum then uses only FM1, the exact prime-index
divisor functions and the elementary EA bounds. No logarithmic-form
or modular representation theorem is used in this chain.

This proves a nontrivial actual first-depth membership range beyond
the root interval. It does not prove an analogous statement for
all larger primes, bound W_far, or control the excluded roots.
The core question remains whether deep private primes beyond U_n
are forced to come with enough actual shallow credit, including on
exceptional roots. No finite experiment or completed Lean proof is
asserted for the analytic theorem in this note.
