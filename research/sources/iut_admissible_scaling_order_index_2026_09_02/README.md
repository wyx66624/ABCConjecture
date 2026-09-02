# Source ledger: admissible scaling and integral-order index

This directory freezes the primary-source state used by
`research/ABC_IUT_ADMISSIBLE_SCALING_ORDER_INDEX_2026_09_02.md`.

The upstream snapshot is Project LANA `iut` commit
`c65b28c9f9631635e742294c3a5df15759e7c74c`, observed at both `HEAD` and
`refs/heads/main` on 2 September 2026.  It contains two facts that must be
kept separate:

* `Iut/Concrete/Existence.lean` is a real positive advance: it constructs
  `ConcreteThetaDataExistence` from curve data, standard providers, and the
  still-explicit `AnabelianExistence` input.
* `Iut/Cor312/LogVolume.lean` and `Iut/Concrete/LocalTheory.lean` still assert
  the prime-preimage log-volume shift for every set.  The empty set proves
  that literal field inconsistent.

`iut-c65b28c-admissible-scaling.patch` makes a narrow source-level repair. It
adds a finite, nonzero-volume component-admissibility predicate, proves that
admissible regions are nonempty and closed under prime preimage, and restricts
the shift law to that class. The patch touches exactly three files. It does
not construct the local Haar measure, the multiradial map, or the same-pilot
comparison.

The `original/` tree contains exact upstream files. The `patched/` tree
contains the three exact results of applying the patch to those originals.
The build log records a clean patched build of both upstream targets:

```text
lake build Iut Iut4Sec1
Build completed successfully (8767 jobs).
```

One pre-existing `Iut4Sec1.Real.LogError` unused-instance linter warning is
recorded in the log; the new and changed IUT modules build without an error.

Run

```text
python verify_source_metadata.py
```

to verify all byte lengths and SHA-256 hashes, replay the patch from the
frozen originals in a temporary directory, compare the exact patched bytes,
and check the source and build boundary. `SHA256SUMS` seals the ledger files.

