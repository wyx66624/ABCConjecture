# Uniform-estimate increment: validation record

Research date: 2026-08-30. Author: ChatGPT.

The standard unconditional `IUTThreeClosures.ABCConjecture` is neither
proved nor disproved by this increment. This record accepts five new
modules with 89 public theorems and a 34-page partial-results manuscript.
Subsequent Jannsen--Wingberg minimum-layer research is outside this
acceptance scope unless separately audited.

## Reproduction

Run in the repository's `Lean` directory with the pinned toolchain:

```powershell
lake build
lake env lean IUTThreeClosures/ResearchUniformGate20260830Audit.lean
lake env lean IUTThreeClosures/ResearchContinuation20260830Audit.lean
```

The recorded runs all exited successfully. `build-output.txt` reports
**9121 jobs**, **265 pre-existing warning entries**, and **zero warnings
in the new modules or their audit**. The initial run's style warnings
are retained in `build-initial-with-style-warnings.txt`; they were fixed
by narrowing an import, removing needless typeclass assumptions and
formatting the audit, without disabling any linter.

`axioms.txt` contains a checked type and dependency report for every
public theorem listed in `declarations.json`. The module counts are
18, 53, 8, 4 and 6, totaling **89**. Each dependency list is a subset of
`[propext, Classical.choice, Quot.sound]`; no `sorryAx` or new mathematical
axiom occurs. The independently rerun previous audit has **43** such
declarations, recorded in `previous-continuation-axioms.txt`.

The audits print the standard target definition but contain no proof
of it. External theorems used in the mathematical papers are not
silently inserted into Lean. In particular, the complete S-unit,
Pasten, Siegel, local class field theory, Galois reconstruction and
IUT comparison inputs are outside this formalization.

## Environment and protected files

`environment.json` records the repository HEAD, Lean/Lake versions,
package revisions, exit codes and SHA-256 hashes of:

- `Lean/lean-toolchain`;
- `Lean/lakefile.toml` and `Lean/lake-manifest.json`;
- `Lean/IUTThreeClosures/ABCStatement.lean`;
- `Lean/IUTThreeClosures/NonCircularDownstream.lean`.

These five files match the previous continuation's recorded hashes.
The new work did not modify the target, the protected downstream
interface or dependency pins. Existing unrelated working-tree changes
were preserved. No commit, push, external message or submission was made.

## Mathematical and document review

The exact proof files and their formalization boundaries are indexed in
`DOC_REVIEW.md`. Mathematical proofs preceded their Lean components.
Independent route agents and the root agent checked formulas and source
uses. These are internal AI checks, not external human peer review.

The English manuscript's author is **ChatGPT**. Tectonic produced a
**34-page**, **330296-byte** PDF with **zero final TeX warnings**.
Its SHA-256 is

```text
f4a8109109153b9445015af7de14d7dd2e4c9d969a0ced405fab9ee699d0452d
```

All 34 pages were rendered and visually inspected. `PDF_QA.md` indexes
the three page-range reviews. `pdf-metadata.json` and
`validation_summary.json` identify the same exact PDF; the latter also
records all declaration/build checks. The source text states that abc
remains open in this repository and distinguishes paper proofs from
Lean declarations.

## Historical replay and snapshot integrity

The previous continuation's manifest remains unchanged. Its 447 entries
were replayed with zero failures after ten documented logical paths
were remapped to byte-for-byte captures in `previous_paper_snapshot/`
and `previous_mutable_snapshot/`. See `previous-manifest-map.json` and
`previous-snapshot-verification.json`. This preserves the former
22-page manuscript, old status documents and aggregate Lean imports
without pretending that the mutable canonical paths are unchanged.

The first increment's ten-page paper and original verification record
are also retained. Original source PDFs and user-uploaded PDFs were
not edited. The snapshot verifier in this directory checks the new
manifest and replays the previous one through the recorded map.

No proof gap is closed by the presence of a checksum, a successful
build, or an internally reviewed manuscript. The final unconditional
ABC target remains active and unachieved.
