# Pell polynomial/Hensel specialization replay

This directory supports
`research/ABC_PELL_POLYNOMIAL_HENSEL_SPECIALIZATION_2026_09_02.md`.

The producer builds Fibonacci/Lucas polynomials by recurrence and evaluates
Pell coordinates by binary multiplication in `Z[sqrt(2)]`.  The verifier
does not import it: it uses the closed Fibonacci coefficient formula, a
`2 x 2` matrix powering engine, an exhaustive small CRT check, and a separate
deterministic primality test.

The exact finite scope is:

* the actual transverse collision `F_7(2)=13^2`, its nonzero derivative,
  and its level-two exit to `T=171`;
* simultaneous index-three lifts at `7` and `5`, their CRT parameter
  `T=282`, complete displayed factorizations, squarefree coefficient
  `D=19882`, and the exact negative-Pell identity;
* the three level-two exit digits for the rare balancing-Wieferich primes
  `13`, `31`, and `1546463` found in the preceding exhaustive scan; and
* all `43,355,470` canonical powerful representations relevant to even
  index-three parameters `0<T<=20,000,000`; the only squarefull `F3` value
  is at `T=682`, and its opposite channel has five simple factors; and
* seven explicit logical-boundary flags preventing either counterexample
  from being misreported as a full squarefull Pell packet or an abc
  counterexample.

No bounded absence is interpreted as an unbounded theorem.
