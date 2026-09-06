# Moving norm support and integrated monograph

Author: ChatGPT. September 6, 2026.

**Partial research, not an unconditional proof or disproof of standard ABC.**

The paper proves a varying-support complex logarithmic-form bound in the Eisenstein factorization of a primitive triple. Its effective base constant is independent of the split norm primes, their multiplicities and their number. The resulting cubic inequality yields a uniform `1+epsilon` theorem only when the norm primes are polylogarithmic, their count lies below the stated growing threshold, and the actual boundary excess beyond exponent three has a polynomial logarithmic budget. None of these restrictions is asserted for every triple. No infinitude claim for the restricted class is made.

The same paper proves exact compensated truncation and a strict obstruction to absorbing fourth powers solely by replacing the cubic boundary size comparison by a quartic one with polynomial index loss. Earlier IUT, packet, Pell/Mersenne, geometry and derivative global gaps remain open.

## Integrated source

`integrate_monograph.py` verifies the baseline master SHA-256, preserves its mathematical text, namespaces references and local notation, and integrates six historical full mathematical proof bodies, two explicitly labelled proof consolidations, and the new moving-support paper. The normal-form and rank/depth consolidations retain principal results and complete proofs without repeating unconfirmed historical runtime descriptions; they are not verbatim reprints. The original sealed PDF is 270 pages, while its current baseline source recompiles to 281 pages before new additions. Final pages and hashes are recorded by the actual build, not predicted by this README.

The script is idempotent and refuses to overwrite an unexpected baseline. It also performs two explicit, idempotent editorial changes in the new/edited sources: it removes redundant candidate choices from the dyadic sharpness proof and adds the proven inequality `E_3(|P(z_n)|) <= 6*n*F_n` connecting old first-depth and new actual-excess budgets.

## Actual formal scope

The 12 new queries in `Lean/MovingSupport.lean` cover the full norm-boundary gcd, cubic coordinate identities and cap, exact finite-list compensated identity, and elementary conditional integer bridges. General Euclidean classification, logarithmic heights, the external Bugeaud/Matveev complex logarithmic-form theorem, and real analytic absorption are paper/source-dependent mathematics, not formalized by these files.

The source first passed the scoped 70-query workflow at commit `3dab95cd408e63966c3027e43a832a564dfb4415`, run `34012945282`. That total is 40 preceding Eisenstein declarations, 18 rank/depth declarations, and 12 new declarations; it does not mean 70 new mathematical results or a full repository build. Two failed development runs (`34012565024`, `34012723792`) are preserved in GitHub history. Final integration checks all four modules anew, with actual axiom output limited to `propext`, `Classical.choice`, `Quot.sound` and warnings as errors.

## Reproduction

From the repository root:

```sh
python3 research/checkpoints/2026_09_06_moving_support/verify.py
python3 research/checkpoints/2026_09_06_moving_support/integrate_monograph.py
bash research/checkpoints/2026_09_06_moving_support/wsl/verify_lean.sh
cd paper
latexmk -pdf -interaction=nonstopmode -halt-on-error ChatGPT_ABC_Uniformity_2026.tex
```

The finite replay is exact and deterministic, but does not verify the unknown effective logarithmic-form constant or unrestricted asymptotics. Its counts and digest are sealed in `verification/exact_results.json`. The WSL-compatible script installs an isolated checksum-pinned Lean 4.32.2 without changing elan defaults. Execution in GitHub hosted Ubuntu is not access to the user's own WSL. No independent autonomous subagents or external peer review are claimed.
