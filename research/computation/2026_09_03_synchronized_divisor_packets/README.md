# Reproducing the synchronized-divisor-packet audit

Run from the repository root with Python 3.10 or later:

```powershell
python research/computation/2026_09_03_synchronized_divisor_packets/search_synchronized_packets.py `
  --limit 5000 --exhaustive 1000 --top-quality 200 `
  --quality-threshold 1.0 --family-limit 100000 `
  --output research/computation/2026_09_03_synchronized_divisor_packets/OUTPUT.json
```

The program uses deterministic integer arithmetic for factorization, divisor enumeration, packet membership, divisibility, and all asserted bounds. Floating-point logarithms are used only to rank triples and to report quality, Sankaran's packing efficiency, DGM quality, and synchronization energy.

The scan covers every normalized primitive triple `2 <= a <= b`, `a + b = c`, `c <= 5000`. Packet enumeration is exhaustive for all such triples through `c <= 1000`, for the top 200 standard-quality triples through `c <= 5000`, and for all scanned triples of standard quality at least one.

The output contains full-premise counterexamples to corner uniqueness and to the candidate cubic, quartic, product-square, and constant-one quintic bounds. It also checks the proved pair-max and sixth-power bounds on every enumerated packet, checks canonical-orientation rigidity in the finite domain, verifies the explicit exact-gap family for `2 <= t <= 100000`, and compares two triples with identical prime support but different packet spectra.

SHA-256 checksums for the archived run are:

```text
55a322658e930587fda58d07dd3c84ee3c42b5795da3c2a94be6d58e980cb28e  search_synchronized_packets.py
977cdea6e1460f3c32e450fe9f99ab056af8e2870f1053bbc7162892657fc83a  OUTPUT.json
977cdea6e1460f3c32e450fe9f99ab056af8e2870f1053bbc7162892657fc83a  RUN.log
```

`RUN.log` is the UTF-8 console rendering of the same JSON object stored in `OUTPUT.json`, hence the identical archived checksum.
