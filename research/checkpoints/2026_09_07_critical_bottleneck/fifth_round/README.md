# Fifth round: actual cyclotomic rank packets

The CP1--CP5 ordinary proof in `cyclotomic_rank_packets.md` has passed
independent review by the parent and adversarial agents. The manuscript
input is `paper/cyclotomic_rank_packets.tex`, which has passed final
independent transcription review. The actual integer factorization and its first-depth totient
budget are unconditional; the signed saving and sparse-rank membership
conditions remain explicitly separate hypotheses.

`review.md` records the reviews and the actual fourth-round PDF page QA.
The finite exact arithmetic replay is

```text
python research/checkpoints/2026_09_07_critical_bottleneck/fifth_round/replay.py --check
```

It has been run successfully in generation and check mode. The canonical
payload SHA-256 is
`81941c0830df549d9998b5e75d8687d82534ba328522e318e25ab2303edaf5db`.
The checks use six actual roots, 180 integer factorizations, 16,560 exact
rank/cyclotomic valuation comparisons, and 540 signed packet assembly
rows over explicitly retained primes up to 499. Cyclotomic values are
evaluated from integer polynomials directly in the Eisenstein ring.
No missing prime is declared absent and no full-tail bound is inferred.

The earlier rounds are frozen. None of these ordinary or finite results
is labeled as a new Lean theorem or a proof of ABC.
