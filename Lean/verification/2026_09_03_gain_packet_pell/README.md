# Gain / packet / Pell checkpoint verification

This directory replays and audits the September 3, 2026 canonical-gain,
packet-radical-excess, and signed-Pell-trace checkpoint.

Run from this directory with the repository's Python:

```text
python run_checkpoint.py
python verify_checkpoint.py
```

`run_checkpoint.py` directly compiles the three principal Lean modules and
their one-for-one axiom audits with warnings as errors, builds the umbrella
target, refreshes the preceding synchronized-packet module and its 70-query
audit, and replays the three independent computation/certificate bundles.
It records every command, exit code, output byte count, and elapsed time.

`verify_checkpoint.py` then checks:

- exactly 41 + 37 + 36 = 114 declarations and 114 axiom queries;
- all 70 queries in the preceding synchronized-packet audit;
- the preceding packet scan's three-file SHA manifest, identical JSON/log
  bytes, headline counts, proved-bound flag, four named first-counterexample
  records, and the exact constant-one quintic witness;
- no `sorry`, `admit`, custom axiom, or `sorryAx`;
- axiom union exactly `propext`, `Classical.choice`, and `Quot.sound`;
- PASS markers for every route verifier and exact Pell collision certifier;
- UTF-8, TAB, and C0 safety of reports, paper fragments, status files, and Lean;
- unique fragment labels, resolved bibliography keys, and main-paper inputs;
- a warning-free 246-page final PDF authored by ChatGPT, with all three new
  sections located by full-document text extraction.

The retained PDF QA package contains contact sheets spanning all 246 pages,
17 representative full-resolution page renders, and a signed-off PASS summary.

The finite searches retain their literal domains.  This package verifies the
formal reductions, exact counterexample boundaries, and recorded computations;
it does not assert `ABCConjecture` or its negation.

`SHA256SUMS` seals the integrated Lean sources, reports, computations, replay
logs, final PDF, and retained visual-QA evidence.  The manifest deliberately
excludes itself and transient compiler caches.
