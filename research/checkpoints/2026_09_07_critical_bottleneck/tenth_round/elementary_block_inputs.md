# EA1--EA3. Elementary archimedean and small-prime control on actual root blocks

Date: 2026-09-07. Ordinary proof submitted for independent review.
This supplement does not change the RC or FM TeX currently under final
review. It replaces the only logarithmic-form inputs in FM2--FM3 on
the actual blocks B>=n. It does not improve a signed-tail bound.

Let zeta=(1+sqrt(-3))/2, O=Z[zeta], P(A+B*zeta)=AB(A+B).
For integers B>=n>=1 and B<=k<2B set

    a=3k, w=a+zeta, Q=a^2+a+1,
    T_d=|P(w^d)|,
    c_d=max(|A_d|,|B_d|,|A_d+B_d|), t=log c_n,
    Delta=3t-log T_n.

Every root is primitive and unramified. The usual elementary norm
bounds imply

    Q^(n/2)<=c_n<=(2/sqrt(3))*Q^(n/2),
    t>=n log(3B),
    log T_d<=3d log(6B+1) whenever T_d is nonzero.       (EA1)

The relevant T_d are nonzero. This follows for all d from the primitive
nonunit ratio not being a root of unity, and for d=n below directly
from the strictly positive angle. In the small-prime proof T_1,T_2
are also positive from their displayed explicit factorizations.

## EA1. An elementary angular gap bound

For every such actual root,

    T_n >= [2n/(pi*(12B+1))]*Q^(3n/2),                (EA2)
    0<=Delta/t<=4/n.                                  (EA3)

Proof. Write w=sqrt(Q)*exp(i*theta), where

    theta=atan(sqrt(3)/(6k+1)).

For 0<=x<=1, x/2<=atan x<=x. Consequently

    sqrt(3)/(2*(12B+1)) <= theta,
    0<3n*theta < sqrt(3)/2 < pi/2,

using k>=B>=n in the upper bound. On this interval sin u>=2u/pi,
so sin(3n*theta)>=3n*sqrt(3)/(pi*(12B+1)). The exact cubic boundary
identity, valid for all Eisenstein integers z, is

    z^3-bar(z)^3=3*sqrt(-3)*P(z).

Applied to w^n, it gives

    T_n=2/(3*sqrt(3))*Q^(3n/2)*sin(3n*theta),

and proves (EA2). Every absolute arm is at most c_n, so Delta>=0.
The upper norm bound in (EA1) and (EA2) give

    Delta<=log(4*pi*(12B+1)/(3*sqrt(3)*n)).             (EA4)

Since 12B+1<=13B, pi<4 and sqrt(3)>1, the argument on the right
is at most 81B/n, and hence at most (3B)^4. Divide (EA4) by
n log(3B)<=t to obtain (EA3). All constants are absolute, and
no approximation by logarithmic forms occurs in this proof.

## EA2. Exact valuations at two and three

Writing v_p for the ordinary normalized rational-prime valuation,

    v_3(T_n)=v_3(T_1)+v_3(n),                         (EA5)

and

    v_2(T_n)=v_2(T_1)                    if n is odd,
    v_2(T_n)=v_2(T_2)+v_2(n/2)           if n is even. (EA6)

In particular, pointwise on every actual block B>=n,

    [v_2(T_n)log2+v_3(T_n)log3]/t <=20/n.             (EA7)

Proof of the elementary lifting fact used here. In a field with a
nonarchimedean valuation v above p normalized by v(p)=1, suppose
u=1+delta and e=v(delta)>1/(p-1). For 1<j<p,

    v(binomial(p,j)*delta^j)=1+je>1+e,
    v(delta^p)=pe>1+e.

The linear term p*delta uniquely has smallest valuation, so
v(u^p-1)=e+1. The same threshold continues to hold after this step.
For a positive integer r prime to p, if merely e>0, the linear
term r*delta has valuation e and all higher terms have valuation
strictly larger than e. Thus v(u^r-1)=e. Decomposing any exponent
into its p-power part and its prime-to-p part proves

    v(u^m-1)=v(u-1)+v_p(m)

under the first threshold, and proves the prime-to-p assertion under
the weaker e>0. This uses only a binomial expansion and the unique
minimum rule for a valuation; no p-adic logarithmic-form estimate
is an input. The argument also applies to normalized valuations in
the quadratic Eisenstein field, including the ramified place at 3.

Now set eta=(w/bar(w))^3. The norm Q is prime to 2 and 3, so w and
bar(w) are local units at both. The exact boundary identity yields

    eta^d-1=3*sqrt(-3)*P(w^d)/bar(w)^(3d).             (EA8)

At 3 its valuation is v_3(T_d)+3/2. Since
T_1=a(a+1) is divisible by 3, v_3(eta-1)>=5/2>1/2.
The lifting fact proves (EA5) after subtracting 3/2.

At 2 the factor 3*sqrt(-3) is a unit, so the valuation in (EA8)
is v_2(T_d). Here T_1=a(a+1) is even. The prime-to-two part of
the lifting fact proves the odd-n assertion. For even n, direct
integer multiplication gives

    T_2=a(a-1)(a+1)(a+2)(2a+1).                      (EA9)

The four consecutive integers a-1,a,a+1,a+2 have product divisible
by eight. Therefore v_2(eta^2-1)=v_2(T_2)>=3>1, and applying the
lifting fact to eta^2 with exponent n/2 proves the second assertion
of (EA6). No assumption on the parity of a or k was omitted.

Put L=log(6B+1). The odd case of (EA6) has cost at most log T_1<=3L;
the even case has cost at most log T_2+log n<=6L+log n. Equation
(EA5) has cost at most 3L+log n. Thus the two-prime cost is at most
9L+2log n. For B>=n>=1, L<=2log(3B) and log n<=log(3B).
Division by t>=n log(3B) proves (EA7).

## EA3. Logarithmic-form-free mass-location theorem

Take, through all sufficiently large integers n,

    B=n^4,
    Z=floor(B*sqrt(log n)/(1+log log n)),
    eta_n=(log n)^(-1/4).

The proved FM1 actual full-mass interval estimate, its Brun--Titchmarsh
endpoint, and the elementary all-index sigma bound imply, after using
(EA7) instead of LR2, that

    (1/B) sum_{B<=k<2B}
       [sum_{p<=Z} v_p(T_n(k))log p]/t_k
         <= C*(log n)^(-1/2).                        (EA10)

Consequently outside at most a proportion C*eta_n of actual roots,

    3-4/n-eta_n
       <= [sum_{p>Z}v_p(T_n(k))log p]/t_k <=3.         (EA11)

Proof. FM1 involves only primes at least five and does not use a
logarithmic-form bound. Its first term is O(log n/sqrt(n)), its
endpoint O((log n)^(-1/2)), and its exponent-lifting term O(1/n),
by the already proved elementary divisor estimates. Adding (EA7)
gives (EA10). Markov's inequality at eta_n bounds the exceptional
proportion. At each remaining root use

    log T_n/t_k=3-Delta/t_k

and (EA3), then subtract its full small-prime mass. This is (EA11).

If n tends to infinity through primes at least five, the same set
also obeys

    3-7/n-eta_n
      <= [sum_{p>Z, d_p(k)=n}v_p(T_n(k))log p]/t_k
      <=3.                                          (EA12)

Indeed p>Z>n eliminates exponent lifting. The only ranks are one
and n, and the total rank-one mass is at most log T_1<=3t_k/n.
Subtracting this cost from (EA11) proves (EA12). In (EA12) every
included valuation is its actual first depth at top rank n.

## Dependency and unresolved scope

Actual root block and exact cubic identity -> elementary angle bound
and binomial local lifting -> exact-rank simple lifting plus integer
interval counts -> rank-dependent harmonic sum and Brun--Titchmarsh
endpoint -> elementary all-index divisor estimates -> full-mass
location (EA11), and prime-index top-rank location (EA12).

The only non-elementary analytic input retained by this chain is the
established Brun--Titchmarsh estimate already cited and source-reviewed
in SW and FM. No Bugeaud theorem, modularity statement, uniform random
residue assumption or conjectural radical saving is used. The earlier
FM proof remains correct on its larger domain; this is an independent
replacement of its archimedean and fixed-prime steps for B>=n.

As in FM, full mass is not signed cost. An exponent-one prime has
positive full mass but signed credit -2log p. Nothing here bounds the
radical, controls a single exceptional root, or proves the actual
reciprocal-depth/compensation membership gate. This is an ordinary
proof submitted for review, not a Lean formalization.
