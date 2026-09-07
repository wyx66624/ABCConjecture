# Sixth round: the actual quartic Frey curve and modular budgets

This checkpoint adds a separate arithmetic-modular route for the actual
second norm `F(a,b)`. It neither proves nor disproves ABC.

## Ordinary results and manuscript inputs

1. `frey_modular_entry.md` / `paper/frey_modular_entry.tex`: FM1--FM6.
   Exact inverse charts for `x^2+3y^4=4F`; the actual degree-two Q-curve;
   complete Tate proofs of conductor exponents 6 over 2 and 2 over 3;
   reviewed character/descent/large-image inputs; the five necessary
   weight-two levels 36, 72, 144, 288, 576 for pure prime powers;
   and the residual-level budget when `p` does not divide `V`.
2. `nonflat_weight_budget.md` / `paper/nonflat_weight_budget.tex`: FM7.
   When `p|V`, Serre weight is exactly `p+1`. Both branches have
   level `2^e*9*rad(V/p^vpV)`, `2<=e<=6`. The total newspace dimension
   over all `V<=exp(Lp)` is at most `485(p+1)exp(3Lp)`. Complete
   source and ordinary proof, with composite-exponent canonicalization
   and the remaining congruence-elimination condition made explicit.
3. `paper/bibliography_additions.tex`: six bibliography entries for root
   integration. Input the two manuscript files in the order above.
4. `REVIEW.md`: independent proof/transcription reviews and exact replay
   scope. FM1--FM6 full reviews passed. FM7 received two independent
   full ordinary reviews and a full final TeX review, all passed.

The dependent earlier actual 13-adic lemma is labelled `qc-bad-depth` in
the frozen fifth-round manuscript. This checkpoint does not replace its
proof with a numerical sample. Existing theorem environments and notation
come from the shared manuscript.

## Exact evidence inventory

`exact_frey_replay.py` runs the three GP scripts, retains the full
transcripts, and independently checks the displayed arithmetic. It was
actually run in WSL using Python 3 and PARI/GP 2.15.4. Outputs are UTF-8
with LF; the canonical JSON is `exact_frey_results.json`, SHA256
`876816dd1f37f6cbee6887e59bab57fa993744bb0e5f37b4de8a6ce01993bd59`.

The exact Ubuntu 24.04 amd64 package used was
`pari-gp_2.15.4-2.1build1_amd64.deb`, 3,989,060 bytes, obtained from
`https://archive.ubuntu.com/ubuntu/pool/universe/p/pari/pari-gp_2.15.4-2.1build1_amd64.deb`.
Its SHA256 was freshly checked as
`55a95d51afe87688fe0fcfe1bca74bf8c5474533e2a42d3af45c87c1ae0d86fa`.
The package requires `libc6 (>=2.38)`, `libgmp10 (>=2:6.3.0+dfsg)`,
`libreadline8t64 (>=6.0)`, and `libx11-6`; these were already installed
in the existing Ubuntu 24.04 environment. No recommended PARI datasets
were needed or installed for these scripts. This package should not be
assumed compatible with an older Ubuntu runner.

| Script | Retained evidence | Exact scope |
| --- | --- | --- |
| `frey_local_probe.gp` | `frey_local_probe_results.txt` | 159 coprime positive pairs, both exceptional local reductions |
| `modular_spaces_probe.gp` | `modular_spaces_probe_results.txt` | All five weight-two newspaces, dimensions, orbit fields, CM returns and coefficients through 25 |
| `boundary_probe.gp` | `boundary_probe_results.txt` | Boundary-curve invariants, reduction and trace probes |
| `exact_frey_replay.py` | `exact_frey_results.json` | Also checks all 768 admissible mod-32 residue pairs for the explicit arithmetic/Tate divisibilities |

The five computed dimensions are 2, 0, 2, 4, 8. This is independently
repeated exact software evidence, not a Lean proof of the newform
algorithms, a candidate exclusion, or identification of the boundary
curve from finitely many traces. `computational_registry.md` records
these distinctions. FM7 uses an ordinary general dimension bound and
does not claim a computation of all the varying-weight spaces.

## Remaining work and formal scope

The newform spaces need not be empty. No remaining form is eliminated
here, and a subexponential dimension budget gives no uniform bound for
seed heights. Uniform congruence exclusion must retain the actual inverse
square and positive primitive integer conditions. Boundary-curve local
shadows are not global pure powers. Any Frey--Mazur type upgrade from a
residual congruence to an isogeny remains a separately stated conditional
input.

The parent agent owns integration and any new Lean arithmetic module.
The ordinary modularity, Q-curve descent, Tate-algorithm and geometric
results here are not asserted to have complete Lean formalizations.
Earlier first--fifth mathematical files remain frozen; the authorized
fifth-round visual QA record was added separately.
