# Odd Chebyshev Quotient: Endpoint and GCD Ledger

## Scope

This note records the pure Lean-kernel part of the Chebyshev endpoint and
gcd ledger used in the prime-index five-split route.  The companion module is

    IUTThreeClosures/FreyPellChebyshevOddQuotientGcdLedger.lean

It imports the repository definition

\[
  \operatorname{pellChebyshev}(n,X)
    = T_n(X),
\]

where the right-hand side is Mathlib's first-kind Chebyshev polynomial over
\(\mathbf Z\), evaluated at the integer \(X\).  No primality, positivity,
number-field, class-group, ideal-factorization, or BHV hypothesis occurs in
the Lean statements below.

## Exact odd quotient

For \(m\geq 0\), define the integer-valued quotient \(H_m(X)\) by

\[
\begin{aligned}
  H_0(X)&=1,\\
  H_1(X)&=4X^2-3,\\
  H_{m+2}(X)&=(4X^2-2)H_{m+1}(X)-H_m(X).
\end{aligned}
\]

The companion module first derives, solely from the repository Chebyshev
recurrence,

\[
  T_{n+4}(X)=(4X^2-2)T_{n+2}(X)-T_n(X).
\]

Two-step induction then proves the exact identity

\[
  T_{2m+1}(X)=XH_m(X)
  \qquad(m\in\mathbf N,\ X\in\mathbf Z).
\]

Thus \(H_m\) is not an abstract or assumed quotient: it is connected by a
proved equality to the actual generic Chebyshev evaluation already used by
the repository.

## Congruence at the central endpoint

Set

\[
  c_m=(-1)^m(2m+1).
\]

The coefficients satisfy

\[
  c_{m+2}=-2c_{m+1}-c_m.
\]

Since

\[
  4X^2-2\equiv -2\pmod {X^2},
\]

the same two-step induction gives the stronger central congruence

\[
  H_m(X)\equiv (-1)^m(2m+1)\pmod {X^2}.
\]

Equivalently, if the paper notation is
\(H_p(X)=T_p(X)/X\) for \(p=2m+1\), then the formally proved statement is

\[
  H_p(X)\equiv (-1)^m p\pmod {X^2}.
\]

This includes all edge cases.  In particular, when \(X=0\), integer
congruence modulo zero means equality, and the theorem says exactly
\(H_m(0)=(-1)^m(2m+1)\).

Reducing further modulo \(X\) and using that \((-1)^m\) is a unit gives the
normalized integer gcd identity

\[
  \gcd(X,H_m(X))=\gcd(X,2m+1).
\]

No assumption that \(2m+1\) is prime is needed.  Consequently, for an odd
prime \(p=2m+1\), this specializes to the paper ledger

\[
  \gcd(X,H_p(X))=\gcd(X,p),
\]

where \(H_p\) denotes the quotient \(T_p(X)/X\), equivalently \(H_m\) in the
half-index notation used in the Lean module.

## Congruence at the Pell endpoints

Modulo \(X^2-1\), the recurrence coefficient satisfies

\[
  4X^2-2\equiv 2\pmod {X^2-1}.
\]

Starting from \(H_0\equiv H_1\equiv 1\), induction proves

\[
  H_m(X)\equiv 1\pmod {X^2-1}.
\]

This also handles \(X=\pm1\): the modulus is then zero, so the Lean theorem
asserts the exact endpoint values \(H_m(\pm1)=1\).

If \(X\) is odd, write \(X=2k+1\).  Because \(k(k+1)\) is even,

\[
  X^2-1=4k(k+1)
\]

is divisible by \(8\).  Restricting the preceding congruence therefore gives

\[
  H_m(X)\equiv 1\pmod 8
  \qquad(X\ \text{odd}).
\]

## Lean theorem ledger

The companion module proves:

- pellChebyshev_add_four: the exact four-step Chebyshev recurrence;
- pellChebyshev_odd_eq_mul_quotient: \(T_{2m+1}(X)=XH_m(X)\);
- pellOddChebyshevQuotient_mod_sq: the congruence modulo \(X^2\);
- pellOddChebyshevQuotient_mod_base: its reduction modulo \(X\);
- gcd_pellOddChebyshevQuotient: the exact gcd identity;
- pellOddChebyshevQuotient_mod_sq_sub_one: the endpoint congruence;
- eight_dvd_sq_sub_one_of_odd: the elementary parity bridge;
- pellOddChebyshevQuotient_mod_eight_of_odd: the modulo-eight result.

The file ends with #print axioms for the principal theorems.  A successful
target build must show no sorryAx.

## Trust boundary and remaining paper steps

Everything claimed above is internal scalar algebra over \(\mathbf Z\), tied
to the repository's generic Chebyshev definition.  The module deliberately
does not claim:

- a formal polynomial object in \(\mathbf Z[X]\) separate from the exact
  integer-valued recurrence \(H_m(X)\);
- the five-split number-field factorization or class-number-one argument;
- support-prime splitting conditions in \(\mathbf Q(\sqrt5)\);
- a Lucas primitive-divisor theorem or the BHV accepted interface;
- any uniform exclusion of the residual prime-index family.

Those are logically later steps.  In particular, the kernel ledger here is a
necessary algebraic component, not a proof of the full Diophantine
conjecture.
