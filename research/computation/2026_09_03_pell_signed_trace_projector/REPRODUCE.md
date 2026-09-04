# Reproduction commands

Run the following from
research/computation/2026_09_03_pell_signed_trace_projector:

~~~powershell
python .\search_signed_trace_projector.py --max-index 800000 --prime-bound 2000000 --output .\signed_trace_projector_search.json
python .\verify_signed_trace_projector.py --input .\signed_trace_projector_search.json --output .\signed_trace_projector_verification.json
python .\certify_exact_collisions.py --output .\exact_collision_certificates.json
python .\validate_text_artifacts.py --report ..\..\ABC_PELL_SIGNED_TRACE_PROJECTOR_2026_09_03.md --paper ..\..\..\paper\pell_signed_trace_projector_2026.tex --main-paper ..\..\..\paper\ChatGPT_ABC_Uniformity_2026.tex --output .\text_artifact_validation.json
python .\audit_formalization.py --main ..\..\..\Lean\IUTThreeClosures\PellSignedTraceProjector20260903.lean --audit ..\..\..\Lean\IUTThreeClosures\PellSignedTraceProjector20260903AxiomAudit.lean --audit-output .\lean_axiom_audit_stdout.txt --evidence-dir . --output .\formalization_audit.json
~~~

Run the following from the Lean directory:

~~~powershell
lake env lean -DwarningAsError=true IUTThreeClosures/PellSignedTraceProjector20260903.lean
lake build IUTThreeClosures.PellSignedTraceProjector20260903
lake env lean -DwarningAsError=true IUTThreeClosures/PellSignedTraceProjector20260903AxiomAudit.lean
~~~

Compile the fragment through its isolated wrapper from the latex plugin root:

~~~powershell
python scripts/compile_latex.py 'E:\AImath\abc猜想\output\latex_2026_09_03_pell_signed_trace_projector\pell_signed_trace_projector_wrapper.tex' --output-directory 'E:\AImath\abc猜想\output\latex_2026_09_03_pell_signed_trace_projector' --json
~~~

Each recorded exit-code file contains zero.  The hashes are relative to the
repository root and can be replayed with Get-FileHash -Algorithm SHA256.
