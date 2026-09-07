# Ordinary proof and intended formal scope of the actual global signed bridge

Date: 2026-09-07. The ordinary finite arguments below are contained in
LC1 and its reviewed prime-log dependencies and precede formalization.
Compiler success is recorded separately in verification/global_log_validation.json.

Use the actual prime-log definitions from the frozen tenth-round
ActualPrimeLogCompensation module: mass S_Y, smallMass L_Y, radical
R_Y, excess E_h,Y and signedCost W_Y=S_Y-3R_Y. The cutoff is natural.
For positive N, R_0(N)=log rad(N) and W_0(N)=log N-3log rad(N).
The implementation uses the actual finite sum R_0, not an abstract
variable standing in for the radical.

1. If Y<=Z, the prime weight at Z is at most its weight at Y:
   either the prime exceeds Z and both weights are the same, or its
   Z-weight is zero and its Y-weight is nonnegative. Sum over the
   actual prime support to obtain R_Z(N)<=R_Y(N).
2. No prime is at most zero. Hence L_0(N)=0, S_0(N)=log N, and
   W_0(N)=log N-3R_0(N), by the proved exact mass partition.
3. The radical monotonicity and mass partition imply the actual
   global comparison

       W_0(N)<=W_Y(N)+L_Y(N).

   This retains all negative small-prime credits; it merely gives
   an upper bound by their full mass. No coprimality premise is used.
4. If 3t-delta<=log N, W_Y(N)<=cost and L_Y(N)<=low, item 3 gives

       t-(delta+cost+low)/3<=R_0(N).

   These are finite real inequalities. Their analytic availability
   is a separate statement, not an axiom or hidden definition.
5. For a nonzero natural n and positive real t, substitute
   delta=4t/n, cost=39t/n+2 eta t+net, low=eta t, and clear the
   nonzero denominators. This gives exactly

       1-43/(3n)-eta-net/(3t)<=R_0(N)/t.

   Thus the numbers in LC's actual radical transfer are checked
   against the genuine prime-factorization observable. No claim
   that every actual root has these budgets is made.
6. The already formal finite natural arm theorem bounds W_Y(T)
   by Delta+log H1+log U+L_Y(T)/2+3(E_A+E_B)/2-3R_C,
   with its explicit positive inputs, quotient coprimality, and
   three output bounds. Adding item 3 changes the small-mass
   coefficient from one half to three halves and proves the
   complete finite actual global arm inequality.

The proposed nine declarations implement these steps using Mathlib's
Nat.factorization, Nat.primeFactors and Real.log and import the two
frozen actual-prime-log modules. The exact generic statements permit
N=0 under Mathlib's empty factorization and Real.log 0 conventions;
this is not an ordinary valuation of zero. The actual arm theorem
keeps all six nonzero input and quotient assumptions.

Neither actual Eisenstein primitive-power preservation, the analytic
common-set mean, the angular estimate, the large-cutoff cap membership,
nor exceptional-root control is formalized here. In particular the
numerical transfer has explicit hlog, htail and hlow hypotheses. The
full LC asymptotic and ABC are not asserted as Lean theorems.
