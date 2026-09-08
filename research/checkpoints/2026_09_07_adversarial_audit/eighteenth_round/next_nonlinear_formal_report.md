# Actual nonlinear selectors: fresh formal result

Status: **PASS**, 24 new theorems and all 24 explicit axiom queries.
This is a next-only implementation; published sources, the frozen six-module
inventory, and Git were not modified.

The source is `next_Lean/NonlinearPowerSelectors.lean`, SHA256
`38849679f2e456475bf9f9ef8dfaa0c55df2e0cba8d705d7ec579c2e111776e9`.
The namespace is `ABCNonlinearPowerSelectors`. The prior scope is
`next_nonlinear_formal_scope.md`, SHA256
`b60d0b3ef122faf7d19dbb127b97b2bc4c4a8bc24d11a2d2bf78070cca488533`.

The definitions literally multiply `(3*k,1)` using the Eisenstein integer
coordinate law. There is no assumed output power equation or assumed
primitivity witness. The concrete coprimality proofs construct Bezout
identities and imply actual `Int.gcd = 1` for all three pairs of arms.

The statements cover the root norm and its residue at three; both coordinate,
sum, norm-power, and complete boundary formulas; positivity for `k >= 1`;
and for each family **every** prime divisor of the complete boundary has
`IsUnit (norm (root k) : ZMod q)`. The final two corollaries state the same
root-norm conclusion as actual integer nondivisibility. Neither final theorem
assumes the prime is marked, large, or pre-factored. The reusable primitive
pair helper's `IsCoprime` premise is discharged by each concrete family.

One field helper proves that simultaneous boundary and norm vanishing forces
both coordinates to vanish; applying the actual Bezout identity modulo q
excludes this case. No separate arithmetic fact about the unmarked primes is
imported into the argument.

The successful manifest is
`next_verification/nonlinear-20260908T044715848295Z/validation.json`, SHA256
`b01e02f2482bef62985243547185acf3c35b60fadd7cf088596a341fbeb22cc6`.
Its complete compiler log is `fresh-build.log` in the same directory, SHA256
`9d87dfd1d55d6e71eb26807eccce156bd6f0178e10e939f742aad9fe2a321957`.
The log and manifest were both actually read after completion.

The compiler was Lean 4.32.0, commit
`8c9756b28d64dab099da31a4c09229a9e6a2ef35`. Mathlib was the clean pinned
`81a5d257c8e410db227a6665ed08f64fea08e997` cache. The fresh standalone
project was `/tmp/abc-nonlinear-selectors-fresh-5p4b6p6a`; its minimal Lake
configuration requires only Mathlib and reuses links to that package's cached
dependencies. The compiler ran single-threaded, directly on a fresh source
copy, with `-DwarningAsError=true` and `-o`, without native C generation.
No old project theorem module was imported or rebuilt. All source bytes were
checked again after compilation. The union of every printed axiom set is
exactly `propext`, `Classical.choice`, `Quot.sound`.

Reproduction from Windows/WSL:

```powershell
wsl -e bash -lc 'python3 /mnt/e/agent/ABCConjecture/research/checkpoints/2026_09_07_adversarial_audit/eighteenth_round/next_verify_nonlinear.py --cache-project /root/abc-lean-build'
```

The verifier SHA256 is
`eae2b1af2d92b15f572b64817eae21a41892ffc5be01ee014c2075fde6913e64`.
Every invocation creates a different fresh directory and a new result record.
Two unsuccessful development attempts are retained separately: invoking WSL
without its login shell did not find `lake`; the first Lean compile then found
the nonexistent lemma name `pow_eq_zero`. Replacing it by the actual
`eq_zero_of_pow_eq_zero` corrected only the proof implementation. Neither
failure is counted as a passing run, and neither changed any theorem signature.

This does not formalize CRT packet selection, irreducibility/separability of
the cubic factors, the squarefree sieve, density, moving-data uniformity,
infinite tails, or ABC. There are no added axioms for those missing interfaces.

Independent source review: critical_bottleneck has reported a full read of
all 24 theorem proofs, the ordinary scope, verifier, manifest and complete
axiom log, with independent byte-hash checks, and returned PASS. Its record is
`research/checkpoints/2026_09_07_critical_bottleneck/eighteenth_round/next_nonlinear_lean_review.md`.
This peer review is not counted as a second compiler run. Root review remains
a separate requested step.
