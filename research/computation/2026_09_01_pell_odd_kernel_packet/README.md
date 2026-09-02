# Pell odd-kernel packet computation

This directory supports Section 6 of
`research/ABC_PELL_ODD_KERNEL_THIRD_ORDER_PACKET_2026_09_01.md`.

The producer performs two related searches on the actual orbit

\[
(1+\sqrt2)^n=A_n+B_n\sqrt2.
\]

* For every odd prime index through 5000 it tests prime candidates
  `q <= 2,000,000` in the necessary classes `q = +/-1 mod 2*index`, and
  records an exact exponent-one divisor when it finds one.
* At every odd prime index through 191 it completely factors the exact two
  coordinates and selects an exponent-one divisor.

The verifier is independent of the producer's exact factorizations.  It
replays the bounded scan, recomputes every certified coordinate modulo
`q^2`, checks `q | coordinate` and `q^2 does not divide coordinate`, and
proves primality by exhaustive trial division or by the included complete
Pocklington certificate.

The frozen result is:

* 668 bounded-search prime indices;
* 481 exact simple-divisor hits;
* 187 unresolved bounded-search indices;
* 648,189 exhaustive repeated-factor candidate tests, with the sole hit
  `13^2 || B_7` and no depth-three hit;
* 42 exact certificates covering every odd prime index through 191;
* verifier status `PASS`.

An unresolved bounded-search row remains open.  It is not a squarefull
example, and the finite search is not extrapolated to larger indices.

## Files

* `search_prime_index_squarefull.py`: producer;
* `prime_index_squarefull_search.json`: complete producer output;
* `verify_prime_index_squarefull.py`: independent replay;
* `prime_index_squarefull_verification.json`: replay result;
* `REPRODUCE.md`: exact commands;
* `ENVIRONMENT.txt`: execution environment;
* `SHA256SUMS.txt`: frozen hashes.
