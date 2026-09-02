# Reproduce the Pell--Lucas all-order packet

Run from the repository root with Python 3.11 or later:

```powershell
python research/computation/2026_09_01_pell_lucas_all_order/produce_lucas_all_order_packet.py
python research/computation/2026_09_01_pell_lucas_all_order/verify_lucas_all_order_packet.py
```

The producer uses direct integer recurrences and a linear modular
recurrence.  The verifier independently uses binary powering in
`Z[T]/(T^2-6T+1)` for the local counterexample and binary Binet/Pell
powering for the all-order samples.

Expected terminal conclusions:

```text
fixed-zero counterexample: PASS
all five local residues: PASS
all-order and splitter samples: PASS
{"local_method": "binary powering in Z[T]/(T^2-6T+1)", ... "verification": "PASS"}
```

The finite packet checks the exact counterexample at `k=2451`, realizes all
five correction residues modulo five, and checks the all-order staircase and
channel splitter at `ell = 3,5,7,11`.  It does not prove a uniform Pell
exclusion or any form of abc.
