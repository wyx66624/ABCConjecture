# September 5, 2026: FCRT and signed-endpoint research checkpoint

**Author of the two papers: ChatGPT.**

This checkpoint imports the main results from the two September 5 research supplements based on commit `6118955d20b4edd32e577e06d1060f3945358dd9`. It contains ordinary mathematical arguments, exact finite computations, counterexamples to auxiliary assertions, and two **uncompiled partial Lean drafts**. It does **not** prove or disprove the standard ABC conjecture.

## Read the results

| Supplement | Full paper source | Research note |
| --- | --- | --- |
| Prime-power obstructions and exact divisor-gap reduction | [LaTeX paper](paper/ChatGPT_ABC_FCRT_UnitGap_2026_09_05.tex) | [Definitions, proofs and remaining target](research/ABC_FCRT_UNIT_GAP_OBSTRUCTION_2026_09_05.md) |
| Signed endpoint selection and sharp difference thresholds | [LaTeX paper](paper/ChatGPT_ABC_Signed_Endpoints_2026_09_05.tex) | [Loss identity, selection theorem and noncollapse witness](research/ABC_SIGNED_ENDPOINT_SELECTION_2026_09_05.md) |

The first supplement establishes the sharp full-prime-power no-face threshold, constructs balanced positive-defect no-flag families, and identifies the full optimization with a divisor-gap problem on the stated stratum. The second introduces the genuine difference endpoint, proves the exact loss identity and endpoint-selection inequality, and gives sharp signed thresholds. It includes a certified 39-digit repair of a large auxiliary loss and the complete-premise counterexample `1 + 3024 = 3025` to universal pointwise scalar collapse. Neither finite counterexample is a disproof of ABC or of the remaining uniform bound.

The papers' statements and proofs retain their original hypotheses and limitations. Novelty and independent peer review are not asserted by this import.

## Historical statements versus repository integration

The nine primary source files are copied without content changes from `ABCConjecture_2026_09_05_combined_research.zip`; their hashes are in [SOURCE_SHA256SUMS](SOURCE_SHA256SUMS). In particular, passages in the original notes and papers saying that no remote write or merge was performed refer to the **earlier research-production sessions**. They do not describe this later repository import. The pull request and Git commit history are the authority for integration status.

Original relative paths mentioned inside those historical documents refer to the old standalone supplement layout. This directory preserves the same layout for the primary sources, but not every old supporting artifact. Use the links and commands on this page for this import.

The import includes both complete LaTeX sources rather than the binary PDFs. Full experiment JSON outputs are reproducible from the exact programs; their expected sizes and SHA-256 values are recorded instead of duplicating the large raw outputs. The original conversation archive also retains those PDFs, raw JSON files, prior reports, and the older additive patch. This checkpoint is a primary-source import, not a byte-for-byte copy of that entire archive.

## Reproduce the finite computations

From the repository root, with Python 3.10 or later:

```sh
python3 research/checkpoints/2026_09_05_chatgpt/verify.py
```

To retain both full JSON outputs and logs, choose a directory that does not already exist:

```sh
python3 research/checkpoints/2026_09_05_chatgpt/verify.py --output-dir /tmp/abc-sept5-replay
```

The verifier checks the nine original source hashes, runs both programs with their original default bounds, and compares each full result with its recorded SHA-256 and byte count. The programs use Python integers and rational arithmetic. The [recursive prime certificate](research/verification/2026_09_05_signed/prime_certificate.json) is included; its verifier uses integer arithmetic rather than a probable-prime oracle.

The [integration validation record](verification/merge_validation.json) and [first](verification/fcrt_replay.log) / [second](verification/signed_replay.log) local replay logs record actual runs in the merge session. Both full outputs matched the original archived results byte for byte. In particular, the second run filtered 1,368,094 normalized primitive triples, but fully optimized only the explicitly recorded hard subsets; the larger number is not a count of full optimizer runs.

These are finite computation and reproducibility checks, not a Lean kernel verification or independent peer review.

## Papers and Lean

The two paper sources can be rebuilt with a LaTeX installation providing the packages declared in their preambles. For example, from this checkpoint directory, run `pdflatex -interaction=nonstopmode -halt-on-error paper/ChatGPT_ABC_FCRT_UnitGap_2026_09_05.tex` twice, and likewise for the signed-endpoint paper. This import does not claim a new PDF build.

The files in [Lean/drafts](Lean/drafts) are deliberately outside the repository's established Lean source tree. No Lean compiler was available for this merge session; no compilation or `#print axioms` execution is claimed. The drafts do not formalize the complete arithmetic optimizers or an unconditional `ABCConjecture` theorem. They must not be promoted to verified status merely because this research checkpoint has been merged.

No existing verified-status ledger, Lean import, toolchain, dependency lock, workflow, or source file is changed by this checkpoint.

## The unresolved decisive estimate

For `R = rad(abc)` and the signed-endpoint selector `E`, the remaining sufficient target is:

```text
for every epsilon > 0, there exists C_epsilon independent of (a,b,c)
such that E(a,b,c) <= epsilon * log(R) + C_epsilon
for every primitive positive triple a+b=c.
```

The papers prove the appropriate height bridge, not this uniform estimate. The scalar radical defect and the necessary uniformity are still unresolved in this work. No unconditional ABC Lean closed term, rigorous ABC disproof family, or completed IUT/Pell/geometric bridge is claimed.
