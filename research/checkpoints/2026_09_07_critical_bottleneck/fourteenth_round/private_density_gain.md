# A strict gain over the half-density private-norm domain

Fourteenth-round ordinary proof, 2026-09-07. The complete argument and
the Ford sieve input received full independent PASS from root,
adversarial_audit and independent_route before formalization or publication.
This is a new norm-support argument; it does not change any frozen
UM/PN source. No estimate for the unbounded boundary-prime tail is
asserted.

## DG1. Fixed discriminant after extracting a small cofactor

Let B be a positive integer and

    I_B={k in Z:B<=k<2B},   Q(k)=9k^2+3k+1.

Every prime dividing Q(k) is 1 modulo 3. Write rho(m) for the number
of roots of Q modulo m. It is multiplicative, rho(1)=1,
rho(p^j)=2 for p=1 modulo 3 and j>=1, and rho(p^j)=0 otherwise.

For any m with rho(m)>0 and any chosen root b modulo m, 0<=b<m, put

    f_(m,b)(t)=Q(b+mt)/m
             =9m t^2+(18b+3)t+Q(b)/m.

This polynomial is integral with discriminant exactly -27. For a
prime ell not dividing m, it has rho(ell) roots modulo ell. For
ell|m it has exactly one root: its linear coefficient is nonzero
modulo ell, because Q(b)=0 modulo ell is a simple root and
ell does not divide 3. In particular the polynomial has no fixed
prime divisor. Its only nonzero local root counts are

    rho_m(ell)=2  if ell=1 (mod 3), ell does not divide m;
    rho_m(ell)=1  if ell divides m.               (DG1)

These counts do not depend on which root b was chosen. For every
squarefree d, counting the allowed residue classes of t in the real
interval [ (B-b)/m, (2B-b)/m ) gives

    #{t: d|f_(m,b)(t)}
       = (B/m) rho_m(d)/d + R_d,
    |R_d|<=rho_m(d).                            (DG2)

No estimate for primes represented by this polynomial is assumed.

## DG2. The uniform Selberg bound and its denominator

We use the finite upper-bound Selberg sieve in the following precise
form. If a sequence has local density g(d) and remainder R_d as in
DG2, with 0<=g(ell)<1, then for z>=2 the number of entries avoiding all
sieving primes up to z is at most

    X/J(z) + sum_(d1,d2<=z) |R_[d1,d2]|,          (DG3)

where d1,d2 are squarefree on the sieving support and

    J(z)=sum_(d<=z, d squarefree) h(d),
    h(ell)=g(ell)/(1-g(ell)).

This is Kevin Ford, Sieve Methods Lecture Notes, Spring 2023,
Theorem 4.1, printed page 45, with D=z^2. Its preceding equations
(4.2)--(4.5) give the minimizing weights, their bound |lambda_d|<=1,
and the stated remainder. The author-hosted source was actually
opened and read:

https://ford126.web.illinois.edu/sieve2023.pdf

Set h0(ell)=2/(ell-2) on primes ell=1 modulo 3 and zero otherwise,
extending multiplicatively on squarefree integers. Write

    J0(z)=sum_(d<=z) h0(d),
    A(m)=product_(ell|m) (1+h0(ell))
        =product_(ell|m) ell/(ell-2).

There is an absolute c>0 such that

    J0(z)>=c log z   (z>=2).                    (DG4)

Here is a direct proof, so no uniform asymptotic for a moving
singular series is being invoked. The previously used fixed-modulus
prime estimate implies by partial summation

    sum_(ell<=y, ell=1 (mod3)) 1/ell
         = (1/2) log log y + O(1),
    sum_(ell<=y, ell=1 (mod3)) log ell/ell
         = (1/2) log y + O(log log(3y)).          (DG5)

The first error is bounded because the integrated prime-counting
error has an extra log in the denominator. These are consequences
of the established fixed-modulus theta estimate used in PN/NC.

The total h0-weight on all squarefree divisors of the product of
these primes through y is

    E(y)=product_(ell<=y)(1+h0(ell)) asymp log y.

The weighted average of log d under this finite product measure is
exactly

    sum_(ell<=y) [h0(ell)/(1+h0(ell))] log ell
      =sum_(ell<=y, ell=1 (mod3)) 2log ell/ell.

Choose y=z^(1/4). For sufficiently large z this average is at most
(1/2)log z. Markov's elementary weighted inequality shows that at
least half the weight has d<=z. Thus J0(z)>=E(y)/2>>log z.
Changing c covers the remaining bounded interval 2<=z.

For the polynomial f_(m,b), let J_m(z) be DG3's denominator. Its
local weights outside m are exactly h0; those on m are nonnegative.
Hence it is at least the h0-sum restricted to (d,m)=1. Decomposing
any squarefree d into its part supported on m and its coprime part
gives the exact comparison

    J0(z)
      <= A(m) sum_(d<=z,(d,m)=1) h0(d)
      <= A(m) J_m(z).

Consequently

    J_m(z)>=c log z/A(m)                         (DG6)

uniformly in every m and every allowed root b. In particular there
is no extra uncontrolled log log m in this estimate.

For the endpoint in DG3, rho_m([d1,d2])<=d1 d2, so the complete
remainder is at most

    (sum_(1<=d<=z) d)^2 <= z^4                  (DG7)

for z>=1. We deliberately use this coarse bound to keep the
cofactor uniformity explicit. DG2--DG7 prove that the number of
t in the relevant interval for which f_(m,b)(t) is prime and
larger than z is at most

    C (B/m) A(m)/log z + z^4.                   (DG8)

## DG3. Very large norm primes occupy a small actual subset

There is an absolute C0 such that, uniformly for 0<epsilon<=1/10,

    #{k in I_B : P+(Q(k))>B^(2-epsilon)}
       <= C0 epsilon B
          +O(B/log B+B^(3/5))                  (DG9)

as B tends to infinity. All constants and the sufficiently-large
threshold in this statement are independent of epsilon.

Proof. Let r=P+(Q(k)) be such a prime and m=Q(k)/r. Since
Q(k)<49B^2, it follows that 1<=m<X=49B^epsilon. Each k is counted
among the rho(m) residue classes considered in DG8. Choose
z=B^(1/10). The prime r>B^(2-epsilon)>z is among the sifted entries.
An upper bound may overcount these entries, which is harmless.

We need the following elementary cofactor weight bound:

    sum_(m<=X) rho(m) A(m)/m << log(3X).          (DG10)

Indeed, rho(p^j)A(p^j)=2p/(p-2) for p=1 modulo 3 and j>=1.
The unrestricted Euler product on primes through X gives an upper
bound for the sum, and its factor is

    1+2p/[(p-2)(p-1)] = 1+2/p+O(1/p^2).

Taking logarithms and using DG5 proves DG10. This includes m=1
and all higher prime powers; no squarefree restriction on m is made.

Summing DG8 over m<=X and its rho(m) classes, the main term is at
most

    C B log(3X)/log z
       <= C0 epsilon B+O(B/log B).

The full error is at most

    z^4 sum_(m<=X) rho(m) <= z^4 sum_(m<=X) m
       << X^2 z^4 << B^(2epsilon+2/5)
       <= O(B^(3/5)).

The constants 49 and log(147) are absolute. This proves DG9 without
assuming uniform prime-value asymptotics for any quadratic polynomial.

## DG4. A private independent domain strictly larger than one half

Let

    S_B={k in I_B : some prime r>12B divides Q(k)}.

There exist absolute delta0>0 and B0 such that

    |S_B| >= (1/2+delta0) B      (B>=B0).         (DG11)

Proof. The reviewed PN full norm-mass calculation gives

    sum_(k in I_B) sum_(r>12B) v_r(Q(k)) log r
       >= B log B-O(B log log B).                (DG12)

Every such r is unique to its root and has depth one. In fact each
root has at most one such prime, since two would have product above
144B^2 while Q(k)<49B^2. Denote the prime of a member of S_B by r_k.

Fix a sufficiently small epsilon in (0,1/10] so that C0 epsilon<=1/4.
Let E_B be the number on the left of DG9. The private roots outside
this exceptional subset have log r_k<=(2-epsilon)log B. The others
have log r_k<=2log B+log49. Therefore DG12 is at most

    (2-epsilon)|S_B| log B
       +epsilon E_B log B + B log49.

Using DG9 and dividing by B log B shows

    liminf_(B->infinity) |S_B|/B
       >= (1-C0 epsilon^2)/(2-epsilon)
       >= (1-epsilon/4)/(2-epsilon)
       = 1/2 + epsilon/[4(2-epsilon)].

For example delta0=epsilon/[8(2-epsilon)] is positive and is
valid for all sufficiently large B. No optimized numerical value
of the absolute sieve constants is claimed.

The same actual S_B already has mutually private oriented norm
valuations and hence independent ratios by PN. All the UM, adaptive
precision and owner-concentration statements continue to apply to it.
In particular the established UM logarithmic window now has a
proved domain fraction at least 1/2+delta0-o(1), with exactly the
same finite-window errors and the same unproved far signed term.

This proof does not iterate the norm-mass bound on a discarded
subset. It first bounds a specific extreme-prime subset by an
independent upper sieve, and then applies the original full-block
mass inequality once. The remaining complement and the far tail
are not excluded.

Primary inputs: Ford's finite Selberg upper bound as located above;
the fixed-modulus BMOR prime estimate already used and reviewed in
PN/NC; the previously reviewed PN actual norm-mass identity and
private-prime uniqueness. The density gain DG11 is a new application
with three independent full ordinary reviews. The complete analytic
density theorem is not claimed as a Lean theorem; its selected finite
algebra and finite mass-cut consequences are separately formalized
in root's PrivateDensityMass module.
