# Actual prime-log compensation: ordinary proof before formalization

For a positive integer N and a natural cutoff Y, let

    S_Y(N)=sum_{p>Y} v_p(N) log p,
    R_Y(N)=sum_{p>Y,p|N} log p,
    E_h,Y(N)=sum_{p>Y} (v_p(N)-h)_+ log p,
    L_Y(N)=sum_{p<=Y} v_p(N) log p,
    W_Y(N)=S_Y(N)-3R_Y(N).

These sums are over actual prime divisors and use natural integer
factorizations and real logarithms. W denotes the signed logarithmic
cost, not its exponential. The intended Lean definitions use
Nat.factorization, Nat.primeFactors and Real.log.

The following are already implicit in the reviewed SA finite proof;
this note states the actual arithmetic bridge explicitly.

1. S and L are nonnegative and S+L=log N, by prime factorization.
2. For every positive integer h, S<=h R+E_h. At each supported
prime, e<=h+(e-h)_+, and log p>=0; sum this finite inequality.
3. S(UV)=S(U)+S(V) for positive U,V, by additivity of valuations.
Also R(UV)>=R(V), since every prime divisor of V divides UV.
If U,V are coprime, their prime supports are disjoint and
R(UV)=R(U)+R(V), hence W(UV)=W(U)+W(V).
4. For arbitrary positive U,V, W(UV)<=W(V)+log U. Combine item 3
with S(U)<=log U. This retains all overlap and its negative credits.
5. For positive pairwise-coprime actual integers D1,D2,D3, the
finite signed cost of their product is the sum of their signed costs.
The h=2 instance of item 2 on D1,D2 therefore gives

    W(D1D2D3)<=S3-(S1+S2)/2+3(E2(D1)+E2(D2))/2-3R3.

If real height parameters satisfy S3<=t and
t-delta-l1<=S1, t-delta-l2<=S2, this is at most

    delta+(l1+l2)/2+3(E2(D1)+E2(D2))/2-3R3.

Adjoining a positive old-boundary factor U costs at most log U by
item 4. In the actual SA application, Di=|quotient_i|,
delta=Delta+log c1, li are the actual small-prime masses, and the
ordinary height and primitivity theorems discharge these antecedents.

This bridge is intended to remove the integer-weight-only limitation
of the earlier finite ledger. It still does not prove the universal
height antecedents, the analytic two-place theorem, arbitrary-root
membership or ABC. No ordinary input is promoted to an axiom.

The next height bridge discharges the finite logarithmic-height premises
from positive integer input/output data. Let the inputs be a,b,d and the
quotients A,B,C, all positive, and suppose aA,bB,dC<=H and a,b<=H1.
Put U=abd, T=(aA)(bB)(dC), delta=3log H-log T. Then
log H-delta<=log(aA), because the other two output logarithms are each
at most log H. Similarly for bB. Subtract log a<=log H1 and use
S(A)+L(A)=log A. Also S(C)<=log C<=log H. Thus the previous finite
height interface applies with defect delta+log H1 and small masses L(A),
L(B). Additivity and nonnegativity give L(A)+L(B)<=L(T), without any
coprimality premise involving U. Finally T=UABC. If A,B,C are pairwise
coprime, the complete finite SA inequality follows:

    W(T)<=delta+log H1+log U+L(T)/2
           +3(E2(A)+E2(B))/2-3R(C).

This is an actual natural-number factorization theorem. In the intended
application the inputs and quotients are absolute boundary arms from SA.
Their reconstruction and primitivity supply the elementary hypotheses;
no two-place estimate or asymptotic membership is used in this finite step.
