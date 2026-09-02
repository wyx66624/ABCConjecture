# Audit boundary

The producer imports only frozen finite witness and factorization data from
`../2026_09_01_pell_lucas_correlated_all_order/correlated_all_order_packet.json`.
Its SHA-256 hash is embedded in the new packet.

The verifier does not trust the stored arithmetic conclusions.  It:

1. recomputes every Pell coordinate by an independently organized binary
   powering loop;
2. verifies every exponent-one witness modulo the square of its prime;
3. proves primality deterministically below `2^64` and replays the stored
   Pocklington certificate above that boundary;
4. rebuilds the Lucas coefficients from the closed binomial formula rather
   than the producer's product formula;
5. rebuilds `(K,C,H)` recursively rather than by tuple enumeration;
6. checks the exact endpoint determinant, its coprime curvature quotient,
   both quotient jets, the complete third-order ledger, and all incidence
   products.

The local counterexample satisfies every premise of the explicitly local
claim L3.  It fails the global negative-Pell equation and therefore does not
refute the actual packet route.  The index-seven example is genuine Pell data
and refutes only the stronger `U^3` endpoint-divisibility claim.

