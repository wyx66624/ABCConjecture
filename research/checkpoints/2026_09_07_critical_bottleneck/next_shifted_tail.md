# Next research node: shifted rank lattices for the shared-generator tail

Author: ChatGPT. Date: 2026-09-07.

This file continues research after the integrated shared-generator results were
frozen. The overlap, shifted-residue and finite signed-discrepancy arguments
were independently reviewed by the adversarial research agent. The subsequent
tower classification was proposed by that reviewer and is proved explicitly
below. This is not a change to the reviewed manuscript or Lean files, and not
a proof of standard ABC.

## 1. Why the homogeneous rank budget needs a successor

The parallel adversarial group derives, for a homogeneous orbit w^n, a signed
rank product and the sufficient rankwise hypothesis

    A_d(Y;w)<= (Q*d)^kappa,

where Q=N(w), the products use actual first depths, and kappa is uniform. Summing
over d|n and using tau(n)<=2sqrt(n) bounds the POSITIVE PART of the logarithmic
tail by o(log c), uniformly in Q>=7. It does not assert that a possibly negative
signed tail divided by log c converges to zero. This is a positive conditional
bridge; its hypothesis is still open.

The shared-generator theorem instead uses z_n=v*w^n. Repeated divisibility in
this shifted sequence need not be ordinary divisibility of the index n. The
exact successor below keeps the actual residue class at every depth.

## 2. Arithmetic setup and exact overlap

Let O=Z[zeta] with zeta^2-zeta+1=0, P(x+y*zeta)=x*y*(x+y). Let w,v be actual
algebraic integers such that:

- N(w)=Q>=7 and w has no ramified or conjugate-paired factors;
- v is primitive and nonunit, and its split factors have orientations compatible
  with those of w; its ramified exponent is at most one;
- hence every v*w^n and w^n is primitive, and P(v*w^n)!=0 for n>=0.

Put A_n=|P(v*w^n)| and B_n=|P(w^n)|. The already proved full boundary gcd
identity gives, for n>=m>=0,

    gcd(A_m,A_n)=gcd(A_m,B_{n-m}).                         (G)

Indeed apply that identity with the primitive base v*w^m and multiplier
w^(n-m). No coprimality of their prime supports is needed.

This identity is a valuation-sensitive fact, not an estimate of A_n's radical.
It already tells us that repeated boundary divisibility is governed by a step
orbit rather than by n itself.

## 3. Exact shifted residue classes at every good prime and depth

Fix p>3 with p not dividing N(v)Q. Define

    alpha=(w/bar(w))^3,  beta=(v/bar(v))^3,
    d_p=ord(alpha mod p),  s_p=v_p(B_{d_p}).

The residue algebra O/pO is an unramified quadratic field or a product of two
fields. The elements alpha,beta belong to its norm-one unit group. If
chi_p=1 for p congruent to 1 modulo 3 and chi_p=-1 otherwise, this group has
order p-chi_p, and alpha is a cube. Consequently

    d_p divides (p-chi_p)/3,      p does not divide d_p.

The usual odd-prime binomial argument gives the exact step-orbit law

    v_p(B_n)=0                   if d_p does not divide n,
    v_p(B_n)=s_p+v_p(n/d_p)       if d_p divides n.         (L)

To see the valuation assertion without a logarithmic-form input, write
alpha^d=1+p^s*u at an unramified place. Raising to a p-coprime power preserves
the valuation; raising to p increases it by one because the linear binomial
term is uniquely least. The cubic identity identifies this valuation with
v_p(P(w^n)), since 3*sqrt(-3) and bar(w) are units at p. The two split
components have the same valuations by norm-one conjugacy.

**Lemma 1 (actual residue lattice).** For each integer e>=1, the set

    {n>=0 : p^e divides A_n}

is either empty or a single residue class modulo

    D_{p,e}=d_p*p^max(e-s_p,0).                            (D)

In the latter case let a_{p,e} be its unique representative in [0,D_{p,e}).
When both successive levels are nonempty,

    a_{p,e+1} = a_{p,e} mod D_{p,e}.

**Proof.** At modulus p^e the cubic identity gives

    p^e|A_n  iff  beta*alpha^n=1 mod p^e.

All denominators are units. If one solution n0 exists, another n is a solution
exactly when alpha^(n-n0)=1 in the finite unit group. Formula (L) says its
exact multiplicative order is (D). Therefore all solutions form the displayed
residue class, including its least nonnegative representative. Projection
from depth e+1 to e proves coherence. This argument does not replace a shifted
class by the zero class.

**Corollary 2 (spacing and counting).** Two distinct depth-e hits differ by at
least D_{p,e}. In any interval of N consecutive integers n>=0, their number
differs from N/D_{p,e} by at most one, if the level is nonempty; it is zero
when the level is empty.

**Proof.** A single arithmetic progression has that spacing and that elementary
interval-counting property.

Neither result alone says that every depth is nonempty. In a shifted orbit,
local membership can fail at a higher level. The next theorem establishes the
precise threshold after which that failure is impossible.

**Theorem 3 (tower classification).** At a fixed good prime p, precisely one of
the following occurs:

1. Every depth is empty.
2. The nonempty depths are exactly 1,...,t_p for some 1<=t_p<s_p.
3. Every depth is nonempty.

**Proof.** Emptiness persists under lifting, by projection. It suffices to show
that any hit at depth s=s_p lifts to every larger depth.

Let G_e be the norm-one subgroup of (O/p^e O)^*. For j>=1, the kernel of
G_{j+1}->G_j consists of 1+p^j*u with u modulo p of trace zero. Indeed its norm
is 1+p^j*Tr(u) modulo p^(j+1). The trace map O/pO->F_p is a surjective linear
map on a two-dimensional algebra: Tr(1)=2 is nonzero. Its kernel therefore has
p elements. The reduction map is surjective as well: an arbitrary lift of a
norm-one element has norm 1+p^j*a, and multiplication by 1+p^j*u with
Tr(u)=-a corrects its norm. This argument works for both the split and inert
quadratic algebra.

It follows by successive reduction that ker(G_e->G_s) has size p^(e-s). The
element alpha^d lies in this kernel and, by (L), has exact order p^(e-s).
Thus it generates the entire kernel. If n0 is a depth-s hit, then
beta*alpha^n0 is in this kernel at depth e. Some integer k therefore satisfies
beta*alpha^(n0+d*k)=1 modulo p^e. Choose a nonnegative representative for k.
This gives a hit at every depth e>=s, proving the classification.

## 4. A finite deterministic signed-density formula

For a good prime p and cap H>=1 define

    D_{p,H}(n)=sum_{e=1}^H 1_{p^e|A_n} - 3*1_{p|A_n}.

For H>=v_p(A_n), this is zero if p is unsupported and equals v_p(A_n)-3
otherwise. Thus it retains the negative credit from first and second powers.
Set delta_{p,e}=1/D_{p,e} when the level is nonempty and zero otherwise.

**Proposition 4 (finite signed discrepancy).** For every N>=1,

    |sum_{n=0}^{N-1} D_{p,H}(n)
       -N*(sum_{e=1}^H delta_{p,e}-3*delta_{p,1})| <= H+3.  (SD)

For any finite set S of good primes, multiply each summand by log p and sum:
the error is at most sum_{p in S}(H_p+3)*log p with individually selected caps.

**Proof.** Apply Corollary 2 to each of the H indicators and to the first-depth
indicator, with coefficient -3. Sum the absolute errors. Empty levels have
exactly zero error and are allowed. This is an exact deterministic finite
statement, not a model of independent random primes.

By Theorem 3 the limiting signed density is explicitly one of

    mu_p=0                             (all levels empty),
    mu_p=(t_p-3)/d_p                    (finite tower t_p<s_p),
    mu_p=(s_p-3+1/(p-1))/d_p            (full tower).       (M)

For the last case,

    sum_{e>=1}delta_{p,e}-3delta_{p,1}
      = (s_p-3+1/(p-1))/d_p.

Indeed the first s_p levels have density 1/d_p and the later geometric series
has total 1/(d_p*(p-1)). In a finite tower all existing levels have density
1/d_p, because t_p<s_p. The formulas use the actual classification; they do
not assert full-tower membership for arbitrary beta.

For s_p<=2 every nonempty tower has negative mean. For s_p=3, the only
possible positive mean is 1/(d_p*(p-1)). In all cases

    mu_p <= max(0,s_p-3+1/(p-1))/d_p.                     (MU)

Thus changing the residual can alter the phase or terminate a tower, but does
not increase the local mean beyond the displayed step-orbit bound. This is a
signed average statement, not the false pointwise lifting-divides-n rule.

**Theorem 5 (fixed-finite-prime Cesaro law).** For each fixed finite set S of
good primes, with v,w fixed as above,

    (1/N)*sum_{n=0}^{N-1} log product_{p in S,p|A_n}p^(v_p(A_n)-3)
       -> sum_{p in S} mu_p*log p.                       (CL)

The right side is bounded above by the sum of (MU) times log p, independently
of the shifted residue classes.

**Proof.** The established first p-adic logarithmic-form estimate already used
in the manuscript, applied to the fixed beta,alpha with exponents 1,n, gives

    v_p(A_n)<=K_p*log(4+n)

for a constant K_p depending on the fixed p,v,w. The product beta*alpha^n is
never one, because A_n is nonzero, and all relevant numbers are local units.
No conjectural improvement of that established estimate is used.

Choose H_N at least every v_p(A_n) for p in S and n<N, with H_N=O(log N),
and, by enlarging it, H_N->infinity. Then each capped summand is exactly its
uncapped signed valuation. Divide (SD) by N; its total finite-S error is
O(log N/N). The finite densities increase termwise to the convergent geometric
series specified in (M). Therefore their sums tend to mu_p, and finite summation
over S proves (CL). The upper bound is (MU).

This use of an established p-adic bound is an ordinary external-input proof,
not a newly formalized Lean theorem.

The unresolved obstacle is the global discrepancy when the prime set and depth
caps grow with the height. In (SD), one unaveraged hit per prime can dominate.
No estimate allowing that total error to be discarded has been proved here.
Consequently the finite density formula is not a global W_Y bound.

## 5. Exact actual examples and the homogeneous transfer boundary

Every tower type occurs on actual primitive inputs. For a finite stopping
tower, take p=5, w=(1,50), v=(1,5). The norms are 2551 and 31, coprime and
not divisible by three. Both pairs are primitive, so their products have the
required compatible orientations. Here d_5=1 and
s_5=v_5(P(1,50))=v_5(2550)=2. But w=(1,0) modulo 25, so v*w^n=(1,5)
modulo 25 for every n. Its boundary is 30=5 modulo 25. Thus the tower stops
at t_5=1 and its signed mean is exactly -2 for every finite averaging window.

With the same w and v=(2,1), the norm of v is seven, again coprime to 2551.
Modulo five the boundary is constantly P(2,1)=6, so the tower is empty.
The next example is a full tower, because its s_5 is one and it has a first
hit; Theorem 3 then proves existence at every depth, beyond the finite replay.

The adversarial group identified the actual pair w=(2,1), v=(3,1). Here
N(w)=7, N(v)=13, p=5, d_5=2, s_5=1. Independent exact integer replay in this
agent gives:

| n | v_5(A_n) | P(v*w^n) mod 5^(v_5(A_n)+1) |
|---|---:|---:|
| 1 | 1 | 5 |
| 7 | 2 | 25 |
| 17 | 3 | 250 |
| 67 | 4 | 1875 |

The signed polynomial P was used for the residue column; the positive
valuation is unchanged by its sign. Scanning a full period at depths one
through five gives the unique residues

    (e,D_{5,e},a_{5,e}) =
    (1,2,1), (2,10,7), (3,50,17), (4,250,67), (5,1250,567).

All computations use actual integer-pair multiplication, not numerical logs.
The residues are coherent, but none has to be zero modulo D_{5,e}. In
particular 5 does not divide any of 7,17,67 despite the displayed growing
depth. This refutes transferring the homogeneous lifting-divides-n rule to
all shifted orbits. It does not refute the signed high-prime gate: this fixed
prime eventually lies below the moving cutoff.

The parallel adversarial group is also constructing a small-rho content-one
family with arbitrarily deep 5-adic boundary while 5 does not divide the chosen
exponent. That strengthens this transfer warning inside the new class, but
again concerns a fixed prime below the eventual cutoff.

## 6. Next proof obligations, kept distinct

1. For homogeneous v=1, independently prove the actual rankwise signed budget
   in the parallel note; its divisor aggregation is already a sufficient bridge.
2. For v!=1, use the actual phase lattices (D), not divisors of n. Seek a height
   bound for the total signed discrepancy with p>rho^(-1/6).
3. A possible arithmetic input is a joint bound on how a low-height residual v
   can select many exceptional high-depth residue classes for a large exponent
   n. The present local spacing theorem alone supplies no such bound.
4. In parallel, the independent geometric route studies whether successive
   mixed norm transforms can both admit compressed representations. That is a
   distinct compatibility question, not a consequence of a one-step rho bound.

The current exact equations identify the missing objects and preserve low-depth
credit. They do not solve the remaining global arithmetic estimate.
