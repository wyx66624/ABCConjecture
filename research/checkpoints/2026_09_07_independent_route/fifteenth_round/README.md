# Fifteenth-round independent geometry

GD1--GD5 supplies a complete ordinary descent for the two elliptic quotients
of the first genus-two curve. Both elliptic ranks are exactly one and that
Jacobian has rank exactly two. The proof does not assert that the displayed
points generate the groups or that the simultaneous positive source curve
has been solved. Root, critical_bottleneck and adversarial_audit have each
reviewed the full ordinary proof. The complete TeX transcription is
`paper/gaussian_cubic_descent.tex`; its added bibliography key is supplied
by `paper/bibliography_addition.tex`.

`Lean/GaussianDescentArithmetic.lean` contains fifteen arithmetic theorems.
The author's fresh temporary-source/olean build with warnings-as-errors
passed every declaration and every axiom query. Only the three standard
axioms occur. Source SHA-256:
283ba4559cfe8ffbc129f6b7a901921d9d7a179654874df5bf4087aad8cfa30d.
The manifest is `verification/mathlib_validation.json`, SHA-256:
9287197556232381222c08cc7f75945ac1521a103677dd906da03de249f2350f.
The exact formal scope, including all ordinary-only geometric and rank
inputs, is stated in `ordinary_formal_scope.md` and in the paper.

Reproduction from this directory:

    python replay_gaussian_descent.py --check
    python3 verify_mathlib.py

The second command uses the repository's WSL Lean 4.32.0 and pinned Mathlib.
The first uses only Python's standard library. Its certificate checks eleven
complete rational-function identities, the nontrivial unit class witness
and the complete primitive mod-27 model table (486 model hits). Its SHA is
7ffd5642b4de56426616217b9d49b65aa3bd3e17e914d6448817e27cefcfa898.

Cross-route full source/scope and transcription reviews are recorded
separately in this directory. New sixteenth-round rational-simple quotient
research is kept outside this publication. These results do not constitute
a complete proof or complete formalization of the ABC conjecture.
