# Moving-prime windows from exact shifted ranks

Author: ChatGPT. Date: 2026-09-07.

Status: ordinary proofs for the next research round. The initial moving-window
argument was independently checked by the parent and adversarial research
agents. Section 6 strengthens it using an elementary height cap, and includes
the parent's improvement retaining the complete norm in the denominator.
No change to the already reviewed manuscript or Lean files is made here.
This is a uniform average theorem on explicitly defined exponent blocks,
not a proof of the full signed tail or a pointwise ABC theorem.

## 1. Actual objects and the two inputs

Use the compatible primitive Eisenstein factors v,w of `next_shifted_tail.md`,
with Q=N(w)>=7, V=N(v)>=1, and no conjugate pair in any product v*w^n. The
ramified exponent of v is at most one, and w is unramified. A unit residual v
is allowed in this note because every index below is positive. Put

    A_n=|P(v*w^n)|,  c_n=height of its positive rotation,
    h=max(1,log V),  N>=2,  L_N=log(4+2N).

Within the block N<=n<2N the SAME v and w are used. They may change when N
changes; the constants in the statements are independent of their heights and
prime supports. The norm comparison gives

    log c_n >= (n/2)log Q >= (N/2)log Q.                  (1)

There is an effective absolute K>=1 such that, for all boundary primes p and
all n in this block,

    v_p(A_n) <= K*p^2*h*log Q*L_N.                        (2)

This is precisely the previously proved two-place logarithmic-form estimate
with the actual fixed factors v,w and exponents 1,n (or one column for a unit
residual), with all harmless fixed ramified/unit factors absorbed into K. It
uses the first, unconditional p-adic estimate of Bugeaud, not a conditional
refinement. The p-adic prefactor from the cubic identity has nonnegative
valuation and does not invalidate the upper bound for the boundary valuation.

For p>3 not dividing VQ, use the actual step rank and first depth

    d_p=ord((w/bar(w))^3 mod p),
    s_p=v_p(P(w^d_p)),
    D_{p,e}=d_p*p^max(e-s_p,0).

The proved shifted-rank lemma says each set of n with p^e|A_n is either empty
or a single residue class modulo D_{p,e}. Thus its count in this block is at
most N/D_{p,e}+1. No assertion that these are the zero residue classes is used.
Primes dividing VQ divide none of the A_n, by the full norm-boundary gcd.

## 2. Uniform control of the rank-density main term

**Lemma 1.** For every good prime p,

    [(s_p+1/(p-1))/d_p]*log p <= 2*log Q.                 (3)

**Proof.** For every real pair x,y,

    |P(x+y*zeta)| <= N(x+y*zeta)^(3/2).

For example, the exact cubic identity gives the stronger constant
2/(3sqrt(3)). Hence

    s_p*log p <= log|P(w^d_p)| <= (3d_p/2)*log Q.

For p>=5, the elementary inequality log p<=(p-1)/2 gives
log p/(d_p*(p-1))<=1/2<=(log Q)/2, since log Q>=log 7>1. For completeness,
(x-1)/2-log x is positive at x=5 and has positive derivative for x>=5.
Adding this lifting bound proves (3).

The first-depth term was controlled by the actual size at its own first rank.
No uniform bound on individual first depths, no prime-number theorem, and no
unproved rankwise packet budget was used.

## 3. The moving-prime mass theorem

For a real Z>=5 define the full nonnegative boundary mass

    F_Z(n)=sum_{3<p<=Z} v_p(A_n)*log p.

Unlike a signed excess, F_Z includes the entire prime-power contribution. Its
control therefore also controls any signed subset of this same prime range.

**Theorem 2 (uniform block average).** With an effective absolute K as in (2),

    (1/N)*sum_{n=N}^{2N-1} F_Z(n)/log c_n
       <= 4Z/N + 4K*h*L_N*Z^3*log Z/N^2.                (4)

**Proof.** For each good p choose

    H_p=ceil(K*p^2*h*log Q*L_N).

By (2), it covers every actual valuation in the block. Count its layers:

    sum_{n=N}^{2N-1}v_p(A_n)
       <= N*sum_{e=1}^{H_p}1/D_{p,e}+H_p
       <= N*(s_p+1/(p-1))/d_p+H_p.

Empty layers have zero count and can only improve this upper bound. The
geometric series is exact; finite tower existence is not presumed.

Multiply by log p and sum over p<=Z. By Lemma 1, the density main term is
at most 2N*pi(Z)*log Q<=2NZ*log Q. Since K>=1, h>=1, Q>=7 and N>=2,
the quantity rounded upward in H_p is at least one, so

    H_p <= 2K*p^2*h*log Q*L_N.

The elementary bound sum_{p<=Z}p^2 log p<=Z^3 log Z yields

    sum_n F_Z(n)
       <=2NZ*log Q+2K*h*log Q*L_N*Z^3 log Z.

Use (1), divide by N, and cancel log Q. This proves (4).

**Corollary 3 (an explicit moving cutoff and sparse exceptional indices).** Put

    Z_N=floor[(N^2/(h*L_N^3))^(1/3)]

and suppose Z_N>=5. There is an effective absolute C1 such that

    (1/N)*sum_{n=N}^{2N-1} F_{Z_N}(n)/log c_n <= C1/L_N. (5)

Consequently, except for at most C1*N/sqrt(L_N) indices in the block,

    F_{Z_N}(n) <= log c_n/sqrt(L_N).                     (6)

The bound for an exceptional count may of course be replaced by its minimum
with N when the displayed upper bound is larger than N.

**Proof.** We have Z_N<=N and
Z_N^3<=N^2/(hL_N^3). Therefore the second term of (4) is at most 4K/L_N.
The first is at most

    4N^(-1/3)/(h^(1/3)*L_N) <=4/L_N.

This proves (5) with C1=4+4K. Apply Markov's inequality to the nonnegative
numbers F_{Z_N}(n)/log c_n with threshold 1/sqrt(L_N), obtaining (6).

For fixed v, the cutoff has scale N^(2/3)/log N. More generally, if
h<=N^(1-delta) for a fixed 0<delta<=1, it is at least a constant multiple of
N^((1+delta)/3)/log N. These statements concern the prime cutoff, not a bound
on the height: log c_n is of order at least N log Q.

The condition Z_N>=5 is eventually satisfied on any family with

    h*L_N/N -> 0,

because N^2/(hL_N^3) then dominates N/L_N^2, which tends to infinity. This
includes the small-rho shared-generator regime, now uniformly for each fixed
residual over its exponent block.

## 4. Exactly what this does to the signed-tail gate

Define rho_N=h*L_N/N. On a family with rho_N->0, the shared-generator theorem
already supplies uniformly small angular cost and small-prime mass for the
fixed primes two and three (indeed for a growing initial prime range). Equation
(6) adds, for all but o(N) indices in each block, the complete mass of every
prime 3<p<=Z_N.

Consequently the only remaining signed product on those indices can be placed
beyond the larger explicit cutoff Z_N:

    W_{Z_N}(A_n)=product_{p|A_n,p>Z_N}p^(v_p(A_n)-3).

For example, if an independently established uniform delta_N->0 satisfies

    log W_{Z_N}(A_n)<=delta_N*log c_n

on a chosen sequence of nonexceptional indices from these blocks, then the
exact compensated cubic height identity proves the usual 1+epsilon inequality
on that sequence for every fixed epsilon>0, eventually. The proof adds the
three error ratios: the angular cost, the complete mass up to Z_N, and
delta_N. Their sum tends to zero, so the existing 3epsilon/(1+epsilon)
absorption applies. This is a conditional consequence; the displayed remaining
large-prime bound has not been proved here.

Three boundaries are essential:

1. The exceptional indices are not eliminated. A specially chosen exponent
   could be exceptional in every block.
2. A distinct residual v_n chosen separately for every index is not a single
   fixed-residual block. An additional bounded-family union argument, such as
   Section 7 below, is required to handle such a choice.
3. Primes p>Z_N are not controlled by (4)--(6). Replacing them by all primes
   would discard exactly the unresolved error.

The adversarial small-rho CRT family with one deeply divisible fixed prime is
compatible with this theorem: it chooses individual exponents and residuals,
and a finite or sparse collection of exceptional rows is permitted.

## 5. Dependency chain and next targets

    actual primitive orbit and norm-boundary gcd
      -> exact shifted residue lattice at each good prime and depth
      -> first-rank size bound (3)
      -> established two-place local cap (2)
      -> finite layer counting with every endpoint error retained
      -> uniform moving-prime block estimate (4)
      -> explicit density-one prime range (6).

No step in this chain assumes ABC or the rankwise signed-packet hypothesis.
The main new gain is the factor N obtained by averaging exact progressions;
this changes the admissible prime scale in the error from a pointwise cubic
budget to the N^2 budget in (4).

Next independent arithmetic tasks are to constrain the large-prime remainder,
to control the exceptional indices rather than silently deleting them, and to
combine the residual-height constraint with first-rank data in a way that
improves the number of endpoint errors. A proof of any such strengthening must
use its actual arithmetic premises; no null computation retires these routes.

## 6. A stronger elementary cap, uniform over arbitrary residual height

The previous bound is valid, but its use of the external p-adic cap is
unnecessary for an average statement. The following stronger result relies only
on the actual shifted progression counts, first-rank norm bound, and elementary
size estimates. In particular the constant is uniform for arbitrary V.

**Theorem 4 (elementary uniform moving-prime bound).** For every compatible
primitive orbit and every N>=2, Z>=5,

    (1/N)*sum_{n=N}^{2N-1}F_Z(n)/log c_n <= 10*pi(Z)/N.    (7)

No small-rho or upper bound on V is required.

**Proof.** Write q=log Q, v0=log V. The complete norm comparison is

    log c_n >= (v0+N*q)/2.

Meanwhile the elementary cubic bound gives, throughout the block,

    log A_n <= (3/2)(v0+n*q) <= Hmax:=1.5*v0+3*N*q.

For each good p take H_p=floor(Hmax/log p), which can be zero. It bounds
every valuation in the block, and H_p*log p<=Hmax. Counting the H_p layers
as before and using Lemma 1 yields

    sum_{n=N}^{2N-1}v_p(A_n)*log p
       <=2N*q+H_p*log p <=5N*q+1.5*v0.

This includes H_p=0. Primes dividing VQ have zero boundary support, so they
need not be counted. Sum over the remaining primes, bound their number by
pi(Z), and divide by the full height lower bound and by N. The result is

    [pi(Z)/N]*(10N*q+3v0)/(N*q+v0) <=10*pi(Z)/N.

Every endpoint error was retained. Keeping v0 in the height denominator is
what removes the residual-height restriction from this average theorem.

**Lemma 5 (elementary prime-counting bound).** For every real x>=2,

    pi(x)<=8*x/log x.                                    (8)

**Proof.** For an integer m>=1, every prime in (m,2m] divides binom(2m,m).
Consequently theta(2m)-theta(m)<=2m log2. Summing over powers of two gives
theta(2^k)<2^(k+1)log2, hence theta(x)<=4x log2 for x>=2. Separate the primes
at sqrt(x):

    pi(x)<=sqrt(x)+2theta(x)/log x
          <=sqrt(x)+8(log2)*x/log x.

The inequality log x<=sqrt(x) holds for x>=2: sqrt(x)-log x has its minimum
at x=4, and that minimum is positive. Thus sqrt(x)<=x/log x. Finally
1+8log2<8, giving (8). For example log2<=3/4 follows by integrating 1/t
under its trapezoid on [1,2].

**Corollary 6 (linear prime range with sparse exceptions).** With Z=N, (7)
gives a mean at most 80/log N. Apart from at most

    80*N/sqrt(log N)

indices in the block, the entire prime-power mass from 3<p<=N satisfies

    F_N(n)<=log c_n/sqrt(log N).                          (9)

**Proof.** Apply (8), then Markov's inequality to the nonnegative normalized
mass. The conclusions are asymptotic when the displayed exceptional bound
exceeds N at small N. More generally pi(Z)=o(N) suffices in (7); the theorem
does not require taking a limit with a fixed prime set.

## 7. Controlling exceptions simultaneously over small residuals and roots

The uniformity in V permits a finite union over actual residuals, so a
residual chosen separately at every index can be handled on a precise range.

**Lemma 7 (number of actual small-norm factors).** For B>=1, there are at most
25B integer pairs v=x+y*zeta with 0<N(v)<=B.

**Proof.** Completing the square in each coordinate gives |x|,|y|<=2sqrt(B).
Thus the number is at most (4sqrt(B)+1)^2<=25B. Requiring primitivity,
compatible orientations, or a specified ramification pattern only decreases
this number.

**Theorem 8 (simultaneous residual window).** Fix w and N. Let V_B be the
actual residuals with norm at most B whose positive-index products with w
remain primitive and nonzero. For eta>0, the proportion of indices
N<=n<2N for which SOME v in V_B has

    F_Z(v*w^n)>eta*log c(v*w^n)

is at most

    250*B*pi(Z)/(N*eta).                                 (10)

**Proof.** By (7) and Markov, each fixed residual has at most
10*pi(Z)/eta bad indices. There are at most 25B residuals by Lemma 7.
Take the union of their actual bad-index sets and divide its cardinality by N.

For example fix 0<=beta<1, put B=N^beta and Z=N^(1-beta), and use
eta=1/sqrt(log N). For all sufficiently large N, (8) gives an exceptional
proportion at most

    2000/[(1-beta)*sqrt(log N)].                          (11)

At every remaining index the bound holds SIMULTANEOUSLY for every compatible
residual of norm at most N^beta. Such a residual may now be chosen after the
index is specified, within this proved bound. This is stronger than applying
the earlier fixed-residual theorem to unrelated rows without justification.

**Corollary 9 (simultaneous roots and residuals).** If the roots are also
restricted to the actual pairs with 7<=N(w)<=C, the proportion of indices
bad for some compatible pair (v,w), with N(v)<=B, is at most

    6250*B*C*pi(Z)/(N*eta).                              (12)

**Proof.** Apply Lemma 7 to the roots as well. There are at most 625BC ordered
factor pairs. The uniform bound (7) applies to every compatible pair, with no
dependence on Q. Sum the Markov bounds over those pairs.

In particular, for fixed beta>=0, gamma>0 with beta+gamma<1, put
B=N^beta, C=N^gamma, Z=N^(1-beta-gamma), eta=1/sqrt(log N). The exceptional
proportion is at most

    50000/[(1-beta-gamma)*sqrt(log N)],                   (13)

for all sufficiently large N. This gives a single density-one index set on
which the mass estimate holds for all actual compatible factors in both
specified norm ranges. It does not quantify over roots or residuals of
unbounded norm at a fixed N.

The range in Theorem 8 has log V<=beta log N, so its residual contribution
to rho is O(log^2 N/N), uniformly. Thus the previously proved archimedean
balance and the treatment of primes two and three are compatible with these
simultaneous good indices. The signed tail beyond Z is still a separate open
arithmetic condition, as are the exceptional indices themselves. No claim of
standard ABC follows from (7)--(13) alone.
