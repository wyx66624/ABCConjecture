# Incidence / endpoint / shared-CRT checkpoint verification

This package independently replays the September 3, 2026 continuation from
the labelled valuation-incidence complex through the shared CRT-incidence
successor. It certifies exact reductions and obstruction boundaries; it does
not claim a proof or disproof of the standard `ABCConjecture`.

Run from this directory with the repository's Python:

```text
python refresh_endpoint_checksums.py
python refresh_successor_checksums.py
python refresh_pbt_checksums.py
python run_checkpoint.py
python build_paper_and_seal.py --driver-script C:/Users/Admin/.codex/plugins/cache/openai-bundled/latex/0.2.6/scripts/compile_latex.py
# From the repository root:
pdftoppm -png -r 110 output/pdf/ChatGPT_ABC_Uniformity_2026.pdf output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/pages/page
python -B output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/render_audit.py --pdf output/pdf/ChatGPT_ABC_Uniformity_2026.pdf --pages output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA/pages --output output/pdf/ChatGPT_ABC_Incidence_Endpoint_Literature_2026_09_03_QA
# Back in this verification directory:
python verify_checkpoint.py
python make_manifest.py
python verify_manifest.py
```

The replay runs 30 recorded commands. It builds the `IUTThreeClosures`
umbrella target, directly elaborates eleven principal Lean modules and eleven
separate axiom audits with `-DwarningAsError=true`, and then runs an independent
compiled-environment audit. The source inventory is fixed at
`85 + 18 + 34 + 77 + 65 + 37 + 44 + 40 + 39 + 27 + 30 = 496` public
declarations, with exactly one `#print axioms` query per declaration. The
verifier rejects `sorry`, `admit`, custom axioms, `unsafe`, `partial`, and
`native_decide`; the only permitted transitive axioms are `propext`,
`Classical.choice`, and `Quot.sound`.

Three computations are replayed. The endpoint search enumerates every
normalized primitive nonunit triple through `c=5000` and is checked again by
an independent Hall-tail implementation. The three-arm successor search is
replayed through `c=1200`. The prime-packet boundary search enumerates every
normalized primitive triple through `c=3000`, regenerates its structured
families, and is checked by an independent full-scope validator. Frozen
outputs must be byte-identical and their exact headline counts and checksums
must agree.

The paper must be compiled and fully rendered before `verify_checkpoint.py`;
that final verifier refuses a deferred or stale paper audit. The exact-set
manifest includes the Lean import closure, all eleven source files and all
eleven axiom-audit files, the research reports and route ledger, the recursive TeX input
closure of the journal paper, the validation evidence, the final PDF, and its
QA report and 17 contact sheets. `PAPER_SEAL.md` records the measured page
count, metadata, visual inspection, byte count, and SHA-256 digest after the
paper is compiled. The recorded runtimes are Lean 4.32.0 and CPython 3.12.14
for the replay, plus bundled Tectonic 0.17.0, Poppler 26.07.0, CPython 3.13.5,
pypdf 6.10.0, and Pillow 11.1.0 for the final PDF build and QA. See
`PDF_VALIDATION.md` in the QA directory for the exact artifact procedure.
