# Source ledger for the corrected-volume holonomy continuation

This directory records the exact external/source state used by
research/ABC_IUT_CORRECTED_VOLUME_HOLONOMY_2026_09_01.md.

No source file is duplicated here. The audited Project LANA snapshot and the
two original papers were already frozen elsewhere in the repository; their
relative paths, byte lengths, and SHA-256 digests are listed in
source-metadata.json.

REMOTE_HEAD.txt records the read-only git ls-remote result obtained on
2026-09-01. It confirms that the repository's pinned Project LANA commit was
still the public main head at the time of this continuation.

Run `python verify_source_metadata.py` from this directory to recompute the
byte lengths and SHA-256 digests of all five referenced primary-source files
and to cross-check the recorded remote commit. `SHA256SUMS` freezes the four
local ledger files themselves.
