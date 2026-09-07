# Totient stratification of an actual moving-root interval

Date: 2026-09-07. Ordinary strengthening of the adversarial agent's
actual root-height block; independently reviewed. This note
does not modify any previously frozen manuscript source.

Fix integers n>=1 and B>=1, and real cutoffs 5<=Y<=Z. For the B actual
integer parameters B<=k<2B put

    w_k=3k+zeta,   Q_k=N(w_k),   T_n(k)=|P(w_k^n)|,
    t_k=log c_n(k),

where c_n(k) is the largest side of the primitive positive triple
obtained from w_k^n. These roots and all their powers are primitive,
unramified, and have nonzero boundary. One has

    t_k>=(n/2)log Q_k>=n log(3B).                                (R1)

Define the actual positive window cost

    F_(Y,Z)(k)=sum_{Y<p<=Z}(v_p(T_n(k))-3)_+ log p.

The following strengthens the previous count whose discrepancy was
proportional to n*pi(Z)/B. The improvement uses both exact rank
root counts and the arithmetic progression forced by that rank.

## RW1. Exact rank roots and their lifting

Fix p>3. Write chi_p=1 if p splits in O and -1 if it is inert, and
N_p=p-chi_p. For a residue a in F_p with a+zeta of nonzero norm,

    a -> R=(a+zeta)/(a+bar(zeta))

is a bijection onto the norm-one group minus its identity. The group
is cyclic of order N_p. Consequently the number of a (and also the
number of k, since a=3k) for which R^3 has exact order d is

    r_p(d)=3 phi(d)-1_{d=1}        if d divides N_p/3,
    r_p(d)=0                      otherwise.                    (R2)

Proof. The inverse fractional-linear formula is
a=(R*bar(zeta)-zeta)/(1-R). Conjugation and norm R=1 show that this
inverse belongs to F_p in the inert case; the split case is immediate
under its two embeddings. The two expressions a+zeta and a+bar(zeta)
are nonzero at these inverse points. Thus the image is exactly the
norm-one group with the identity excluded. Since 3 divides N_p, the
cube map has kernel three and image of order N_p/3. There are phi(d)
elements of order d in that image. Remove R=1 precisely when d=1.

Put G_d(T)=P((3T+zeta)^d). Every residue in (R2) is a simple root of
G_d modulo p. Indeed p does not divide 3d. At such a residue the
identity

    3(zeta-bar(zeta))G_d(T)
       =(3T+zeta)^(3d)-(3T+bar(zeta))^(3d)

has nonzero derivative: the ratio has nonzero derivative and its
3d-th power is one. This argument holds in either the split algebra
or the quadratic residue field. Every such root therefore lifts
uniquely to each modulus p^e, preserving its exact rank modulo p.
The actual interval count is at most

    r_p(d)(B/p^e+1)<=3 phi(d)(B/p^e+1).                         (R3)

This is a count of actual k, not an assumed residue distribution.

## RW2. The total error loses its exponent factor

**Theorem.** With the actual data above,

    (1/B)sum_{B<=k<2B} F_(Y,Z)(k)/t_k
      <=10 log Y/[Y^3 log(3B)]
        +12(Z+1)/B+log n/[n log(3B)].                           (R4)

Proof. At a supported p>3 let d=d_p(k) be its exact rank and let
s=s_p(k)=v_p(T_d(k)) be its first depth. Then d|n and the homogeneous
rank law gives v_p(T_n(k))=s+v_p(n). Since
(s+v_p(n)-3)_+ <=(s-3)_+ +v_p(n), the sum of additional lifting
costs at each k is at most log n. It remains to count first-depth
positive excess. If a prime divides Q_k it cannot divide any boundary,
so no supported state is omitted from this rank partition.

For fixed d and k the elementary height cap is

    log|G_d(k)|<=3d log(6B+1).

Thus when counting depths e>=4, at most
H=floor(3d log(6B+1)/log p) levels can contribute. Sum (R3) over
these levels and multiply by log p. The first-depth cost for this
rank-prime pair, summed over k, is at most

    3 phi(d) B log p/[p^3(p-1)]
      +9 phi(d)d log(6B+1).                                    (R5)

For the first term, at a fixed p the possible ranks satisfy
d|gcd(n,N_p/3), so

    sum phi(d)=gcd(n,N_p/3)<=n.

The total first term is therefore at most
3Bn sum_{p>Y} log p/[p^3(p-1)]. For Y>=5, an elementary integral
comparison gives

    3 sum_{p>Y} log p/[p^3(p-1)]<=10 log Y/Y^3.                 (R6)

For example, use p/(p-1)<=5/4, replace primes by integers greater
than Y, and integrate the decreasing function log x/x^4 from
floor Y. This leaves a constant smaller than three in place of ten.

For the second term in (R5), the exact-rank condition forces
p=1 or -1 modulo 3d. The number of such positive primes at most Z
is at most

    2(Z+1)/(3d).                                               (R7)

This upper bound follows by counting the two progressions with their
positive integer parameter; it uses no prime-distribution estimate.
It is valid also for d=1 and for d>Z. Summing the second term by
rank now gives

    sum_{d|n}9 phi(d)d log(6B+1)*2(Z+1)/(3d)
      =6n(Z+1)log(6B+1),                                     (R8)

because sum_{d|n}phi(d)=n. The d from the height cap cancels the
progression spacing. This is the step absent from the unstratified
count of roots of G_(n/p^v_p(n)).

Divide the two bounds by Bn log(3B), which is allowed by (R1) and
nonnegativity of the costs. Since 6B+1<=(3B)^2 for B>=1,
the second bound is at most 12(Z+1)/B. Add the lifting contribution
to obtain (R4).

## RW3. A window that includes more of the top-rank primes

For n large enough that Y=n^(1/6)>=5, take B=n^4 and Z=n^3. Then

    mean F_(Y,Z)/t
      <=5/(12sqrt(n))+12/n+12/n^4+1/(4n)=O(n^(-1/2)).

Markov's inequality gives an exceptional proportion O(n^(-1/4))
outside of which this positive window cost is at most n^(-1/4)
times the actual height. The actual roots have norm comparable to n^8
and homogeneous lambda=1/n. This window contains possible top-rank
primes even when n is prime; it is not a window lying below the first
possible prime of rank n.

More generally, any Z=o(B) makes the discrepancy term vanish, provided
the first term and exponent-lifting term also vanish. For example
B=n^4 and Z=floor(B/(log n)^2) yield a larger prime window with error
of order (log n)^(-2)+n^(-1/2). These are actual interval averages.
They do not settle a specified exceptional root or primes above Z,
and do not prove a complete net top-layer saving for any prescribed
single orbit.

## Review and scope

The complete strengthening passed the adversarial agent's independent
ordinary review, including the exact rank count and cap/spacing
cancellation. It uses the earlier actual
rank/LTE theorem, the elementary norm-one finite group, simple-root
lifting, exact interval counting, and the totient divisor identity.
There is no claim that a power map preserves a uniform output law,
no assumption about simple depth at actual primes, and no Lean claim.
