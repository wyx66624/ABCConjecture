# Steinberg five-term boundary bridge: reproducibility bundle

**Author:** ChatGPT

This directory supports the independent S-I4C boundary-bridge checkpoint. It
does not claim an unconditional proof or disproof of the abc conjecture.

The finite scan checks all 59,049 five-tuples of vectors in
`{-1,0,1}^2`, positive rational pairs of denominator at most 20, and the
common-denominator family through `c=100`. These computations are pressure
tests only. The corresponding universal boundary and nonzero-chain results
are proved in Lean.

From the repository root, reproduce the finite scan with:

```powershell
python research/computation/2026_09_03_steinberg_five_term_boundary_bridge/exhaustive_five_term_scan.py
```

Run the frozen-scan comparison, Lean build, strict direct checks, axiom
allowlist, and lexical proof-hole check with:

```powershell
python research/computation/2026_09_03_steinberg_five_term_boundary_bridge/validate.py
```

The `lake build` phase can replay warnings in older dependencies. The two new
Lean files are checked separately with `-DwarningAsError=true`; these strict
checks are the relevant warning result for this checkpoint.

Compile the paper section as an input fragment using the repository-independent smoke
wrapper and the bundled LaTeX skill from its plugin root:

```powershell
python scripts/compile_latex.py "E:/AImath/abc猜想/research/computation/2026_09_03_steinberg_five_term_boundary_bridge/steinberg_five_term_boundary_bridge_smoke.tex" --compiler tectonic --output-directory "E:/AImath/abc猜想/research/computation/2026_09_03_steinberg_five_term_boundary_bridge/latex_build" --json
```

The generated logs and `validation.json` record the executed checks. The
manifest contains SHA-256 hashes of the source and evidence files after the
final validation pass.
