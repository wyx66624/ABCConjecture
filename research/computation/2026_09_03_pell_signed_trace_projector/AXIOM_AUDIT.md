# Lean axiom audit

The main module and audit module both compile under
-DwarningAsError=true.  The named Lake target also builds successfully.

The machine summary formalization_audit.json checks all 36 declarations in
PellSignedTraceProjector20260903.lean against the companion audit:

- 36 declaration names extracted from the main module;
- 36 matching check commands;
- 36 matching print-axioms commands;
- 36 axiom records in the compiler output;
- no sorry, admit, custom axiom declaration, or native_decide token; and
- axiom union exactly Classical.choice, Quot.sound, and propext.

These are standard axioms used by the imported Lean/mathlib stack.  The
checkpoint introduces no project-specific axiom.
