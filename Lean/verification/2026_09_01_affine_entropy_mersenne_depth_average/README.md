# Affine-entropy and Mersenne-depth verification

This directory freezes the reproducible verification for the September 1,
2026 checkpoint joining three Lean modules:

- `AffineTemplateEntropy20260901.lean`;
- `MersenneWeightedOrderTail20260901.lean`;
- `MersenneSuperWieferichDepth20260901.lean`.

The validator freezes stage-zero Git-indexed inputs.  It checks that working
bytes equal their indexed blobs, scans comment-stripped Lean sources for
forbidden proof placeholders and declaration forms, resolves every theorem
and `#print axioms` target to its fully qualified name, and requires exact
one-for-one coverage.  Each module is compiled directly without warnings.
Only `propext`, `Classical.choice`, and `Quot.sound` are allowed.  The
aggregate import is checked, both `lake build IUTThreeClosures` and direct
aggregate compilation are run, and Lake dependencies must remain clean at
their pinned revisions.

The two computation bundles are verified against strict SHA-256 manifests.
The affine constant/counterexample verifier is replayed and compared with its
frozen output.  The super-Wieferich scan independently enumerates all 664,579
primes through `10^7`, and its generated scan and verification JSON files must
match the frozen bytes exactly.

The three modules contain 74 theorem or lemma declarations and 21 definitions,
for 95 counted top-level declarations.  Every theorem has an embedded
dependency report.  The aggregate build completes 9,209 jobs.

These checks certify the displayed finite algebra, asymptotic interfaces, and
exact auxiliary counterexamples.  They do not prove any missing fixed-base
distribution estimate, interpret a finite no-hit asymptotically, or close the
standard abc conjecture in either direction.

The frozen inputs include the main TeX file and the four new checkpoint
fragments.  They do not include every other file in the transitive TeX include
graph, and this validator does not compile the manuscript.  The integrated
145-page journal PDF is separately compiled, rendered, and structurally checked
in the retained PDF QA directory
`output/pdf/ChatGPT_ABC_Affine_Entropy_Mersenne_Depth_Average_2026_09_01_QA/`.

Ordinary validation writes to the ignored `tmp/verification` area.  The
recorded `logs/` and `validation-run.json` are produced only by the maintainer
`-Record` run and are then sealed by `SHA256SUMS`.
