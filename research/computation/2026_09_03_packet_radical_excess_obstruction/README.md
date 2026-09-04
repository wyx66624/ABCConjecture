# Reproducing the packet radical-excess audit

Run from the repository root with Python 3.10 or later:

```powershell
python research/computation/2026_09_03_packet_radical_excess_obstruction/search_packet_radical_excess.py `
  --limit 3000 --dyadic-limit 20 `
  --output research/computation/2026_09_03_packet_radical_excess_obstruction/OUTPUT.json `
  *> research/computation/2026_09_03_packet_radical_excess_obstruction/RUN.log
```

The script uses exact Python integers only.  It enumerates every normalized
primitive nonunit triple `2 <= a <= b`, `a+b=c`, `c <= 3000`, every divisor
triple, and every synchronized packet satisfying all positivity, divisor, and
square-gap congruence premises.  It separately factors and exhausts the
dyadic rows `(2^(k+4),3,2^(k+4)+3)` for `0 <= k <= 20`.

The archived run contains 1,365,095 primitive triples, 1,366,531 packets, and
1,436 proper packets.  It checks the new order-statistic identity, support
containment, full-packet envelope, radical-excess necessary condition, and
compensated implication on every packet.  Null counterexample fields are
finite-domain evidence only and are never treated as proofs.

The infinite dyadic obstruction is proved symbolically in Lean; the 21 rows
here are independent exact checks rather than the source of that theorem.

SHA-256:

```text
4c0b132cfcdd5dcc670573ad5e00a3b4d8b63ded51b1333f6648d3b25c319649  search_packet_radical_excess.py
94a213521f2a3d71626f50d2db9d8929a69942064fc9ac9f47d6ca722711e8a6  OUTPUT.json
94a213521f2a3d71626f50d2db9d8929a69942064fc9ac9f47d6ca722711e8a6  RUN.log
```
