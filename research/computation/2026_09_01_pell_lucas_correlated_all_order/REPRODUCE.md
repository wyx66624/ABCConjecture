# Reproduction commands

From this directory, run:

```powershell
python -m py_compile produce_correlated_all_order_packet.py verify_correlated_all_order_packet.py
python produce_correlated_all_order_packet.py | Tee-Object producer_stdout.txt
python verify_correlated_all_order_packet.py | Tee-Object verifier_stdout.txt
python verify_manifest.py
```

Expected verifier status: `PASS` with an empty `errors` array.

From the repository's `Lean` directory, kernel-check the formal core with:

```powershell
lake env lean -DwarningAsError=true IUTThreeClosures\PellLucasCorrelatedAllOrderExclusion20260901.lean
```

The output files are:

* `correlated_all_order_packet.json`, produced evidence;
* `correlated_all_order_verification.json`, independent verification result;
* `producer_stdout.txt` and `verifier_stdout.txt`, frozen console summaries.

The verifier uses deterministic Miller--Rabin bases for integers below
`2^64`.  The larger divisor at index 59 is checked by a full Pocklington
certificate whose complete factorization of `q-1` is stored in the packet.
