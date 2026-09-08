# Root17 final formal-scope TeX and CI source review

Status: PASS. Full sources were read; current source and evidence hashes are in
`root_scope_ci_review.json`. This is read-only review, not a new Lean build,
dependency download, or independent re-execution of the eight aggregate replays.

The formal-scope TeX correctly states 24+16 new theorems, 55 dependencies and
95 axiom queries. Its CD account uses the actual gcd/quotient map and derives
the cleared identities and scalar integrality. Its CP account retains explicit
prime-profile and mass premises. It distinguishes the finite certificates
from ordinary asymptotics and p-adic geometry. I requested the sole wording
clarification that the displayed sum over primes dividing T has T>0; the final
line was actually re-read after root added it. The Lean functions themselves
also have well-defined finite-factor conventions at T=0.

The workflow invalidates historical PASS records immediately after checkout,
before compiler/dependency setup. Each standalone verifier independently writes
NOT_RUN before parsing/preflight. Fresh compilation changes this to RUNNING
only after source inventory, and finally to PASS only after all six source
compiles, byte-stability checks and every axiom query. Thus setup failures,
compiler errors and later assertions cannot leave a historical PASS in the
uploaded compiler evidence. Finite replay failure likewise leaves NOT_RUN.

The negative-path test copies the real three scripts into an isolated temporary
tree. It tests initial reset, then explicitly reseeds the relevant PASS file
before each missing-Mathlib and missing-certificate failure. This is the repaired
strong test, not the earlier weak pattern that only failed after an initial
reset. I matched its three recorded source hashes to the current bytes.

The dependency project pins Lean 4.32.0 and the exact Mathlib commit. Its prepare
script rejects conflicting existing files. The verifier checks the Mathlib HEAD
and tracked source/toolchain diff, copies six current local sources into a new
directory, prepends that directory to LEAN_PATH and compiles them in dependency
order. The Windows `sys.executable` change is Linux compatible: the same current
Python path is passed through `lake env`, and LEAN_PATH uses `os.pathsep`.

All direct Mathlib imports are restored by the workflow's cache requests. The
one direct import not written verbatim in that list, Finset.Basic, is covered by
Fintype.BigOperators -> Finset.Piecewise -> Finset.Basic; I read these import
lines in the local pinned sources. Std comes from the pinned compiler. Prior
local project modules are freshly compiled rather than silently reused.

The path triggers include the root checkpoint, all three source round17 trees,
all four prior Lean source dependencies, the toolchain and the workflow itself.
The finite verifier pins the original five and added LP certificate hashes. It
invokes those six scripts with --check; the original five have an additional
post-run certificate hash comparison. LP itself recomputes and compares its
canonical bytes. The separate HT check is described below. Current source
hashes are recorded for all seven entries.
I matched all referenced script/certificate hashes and the seven reported
PASS results. The three always-uploaded primary files are current-invalidated
records, not checked-in success claims reused before execution.

The workflow does not claim a whole-repository or Mathlib rebuild. The added LP replay verifies its recursive Lucas certificate and one actual
endpoint. The added HT checker imports the exact leading-digit routine and
checks its outputs and all four pinned recorded p-adic ball rows, but does not
invoke PARI or regenerate high-precision heights. It states that narrower scope
explicitly. Neither these finite results nor the Lean artifact certify any
complete ABC or QC conclusion. No concrete blocking defect remains in this
reviewed scope.

The final seven-replay update and its new height checker were actually re-read,
and the updated three negative-path source bindings were checked after root
regenerated their record. The workflow includes the two new round18 input paths.
The earlier five-replay snapshot was not used as final evidence for these bytes.

The final formal_scope.tex seven-record paragraph was read in full after the
update. It accurately distinguishes local full PARI execution from the portable
CI check of exact leading digits and recorded balls. Its final source hash is
`2568a928844ff9f35df7ea39ea47888c988d432ad8e35c49a603d7e5c36f228e`.

## Final eight-record update

The final workflow, formal-scope TeX, entire finite verifier, failure-path verifier, LM replay source and all eight recorded outputs were actually read. The workflow now also triggers on the critical eighteenth-round input tree. The LM entry snapshots its program and certificate before --check and verifies both unchanged afterwards. The standalone finite entry still writes NOT_RUN before any certificate preflight. The regenerated negative-path record binds the new finite-verifier bytes and still checks all three reseeded historical-PASS failures. Every script/certificate hash in all eight aggregate records matches the current file. This supersedes the seven-record snapshot above. The formal scope accurately describes eight finite entries, including the narrow portable HT check. No new compile, download or aggregate execution was performed by this reviewer.

Final formal-scope TeX SHA256: `73885fec667a8f79c67aa28876e3dcb37e8a43b908e356f949f4f1f563e91593`.
Final finite-verifier SHA256: `4c4cb191f2d2c61f0b7657e39ab1eb745895f3ed45df3cebd758b463768f428a`.
Final aggregate SHA256: `2c73d83b80a4bd7c3e09b2e7c1a8da04d934047d0df1f13884d3db1e6153bdb1`.
Final negative-path record SHA256: `2b09e160951250c9e1928dd9912f4fd8b3c6707b5ec34f82eaacb03409781a29`.
