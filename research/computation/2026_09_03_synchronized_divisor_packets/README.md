# Reproducing the synchronized-divisor-packet audit

Run from the repository root with Python 3.10 or later:

```powershell
python research/computation/2026_09_03_synchronized_divisor_packets/search_synchronized_packets.py `
  --limit 5000 --exhaustive 1000 --top-quality 200 `
  --quality-threshold 1.0 --family-limit 100000 `
  --output research/computation/2026_09_03_synchronized_divisor_packets/OUTPUT.json
```

The program uses deterministic integer arithmetic for factorization, divisor enumeration, packet membership, divisibility, and all asserted bounds. At the default (or explicitly supplied) `--quality-threshold 1.0`, it selects `q_s >= 1` by the equivalent exact integer test `c >= rad(abc)`. Floating-point logarithms are used to rank triples and to report quality, Sankaran's packing efficiency, DGM quality, and synchronization energy; thresholds other than `1.0` retain the original floating-point comparison.

The scan covers every normalized primitive triple `2 <= a <= b`, `a + b = c`, `c <= 5000`. Packet enumeration is exhaustive for all such triples through `c <= 1000`, for the top 200 standard-quality triples through `c <= 5000`, and for all scanned triples of standard quality at least one.

The output contains full-premise counterexamples to corner uniqueness and to the candidate cubic, quartic, product-square, and constant-one quintic bounds. It also checks the proved pair-max and sixth-power bounds on every enumerated packet, checks canonical-orientation rigidity in the finite domain, verifies the explicit exact-gap family for `2 <= t <= 100000`, and compares two triples with identical prime support but different packet spectra.

SHA-256 checksums for the archived run are:

```text
0bc623ef7f19251a6db6f98378ed064e4236ad70e393a7affddd4cba44aa2b50  search_synchronized_packets.py
2ceabeae8caadde6775e04fadbd05358e089046017d8eb91c7be64ba790c373f  OUTPUT.json
2ceabeae8caadde6775e04fadbd05358e089046017d8eb91c7be64ba790c373f  RUN.log
```

`RUN.log` is the UTF-8 console rendering of the same JSON object stored in `OUTPUT.json`, hence the identical archived checksum.
