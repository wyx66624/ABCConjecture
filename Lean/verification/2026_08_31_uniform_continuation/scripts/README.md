# Reproduction and evidence writing

The bundled Python used here is
`C:/Users/Admin/.cache/codex-runtimes/codex-primary-runtime/dependencies/python/python.exe`.
Use UTF-8 mode (`-X utf8`) on Windows. Scripts derive the repository
root from their own location. None publishes, commits, sends messages,
or invokes an older stage's manifest writer.

Routine integrity checking is **read-only**:

```text
python -X utf8 Lean/verification/2026_08_31_uniform_continuation/verify_manifest.py
```

It checks accepted bytes, actual dependency reports, run inputs, source
PDFs, complete visual records, pair pixels and all three frozen historical
manifests. There is no --write option. After freezing, write new
reproduction logs into a new record directory rather than modifying
this accepted evidence.

The workflow used before acceptance was:

1. prepare_audit.py generated the five-module 97+9 scope and central audit.
2. run_check.py build/audit ran the real commands and retained output,
   exit status and eight input hashes before/after. Other modes reran
   the three older audits or explicitly named component builds.
3. validate_audit.py parsed all scoped reports. verify_proofs_and_history.py
   independently parsed four audits, compared warnings and replayed history.
4. capture_environment.py and collect_sources.py checked protected files,
   package revisions/clean tracked worktrees and 13 original PDFs.
5. compile_pdf.py captured all 20 inputs and used Tectonic 0.17.0 in a
   fresh staging directory. It retained the final log and copied the
   successful PDF to its dated path without altering the user's WPS session.
6. render_pdf.py produced 93 single pages and 47 pairs. Four agents
   actually viewed their assigned images and wrote detailed records.
   record_root_visual_review.py recorded the root's already completed
   inspection; it is not an automated substitute for seeing the images.
7. finalize_record.py rechecked PDF properties, image hashes, pair pixels,
   actual review coverage and proof/history data, then wrote the summary.
8. freeze_manifest.py created the new manifest once with explicit guards,
   pre-write path/hash verification and exclusive file creation. It refuses
   an existing manifest and never rewrites an older stage.

The snapshot helpers are one-time operations. interim_four_modules/
retains the earlier 79-report scope, initial_five_module_build/ the build
with two docstring warnings, and interim_height_tex_build/ a failed
intermediate publication attempt. None is substituted for final checks.

The PDF helpers initially derived from older helpers, as recorded in
pdf-helper-provenance.json. Current additions capture compile inputs,
use fresh staging and a dated output, close the PDF reader, and hash
pair images. The old helpers remain unchanged. Source-extraction helpers
do not themselves assert that an extracted or rendered page was viewed;
actual source inspection is identified in the mathematical reviews.
