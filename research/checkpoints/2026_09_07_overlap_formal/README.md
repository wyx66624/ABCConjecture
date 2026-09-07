# Shared exponent columns: algebraic proof before formalization

This checkpoint supplies the finite algebra behind the positive overlapping
exponent route. It does not prove an analytic estimate or ABC.

Let `z_i` be integer pairs with Eisenstein multiplication, and let `f_i,r_i,k`
be nonnegative integers. Write `P(e)=product_i z_i^(e_i)`. Then

`P(k*f+r) = P(f)^k * P(r)`.

Ordinary proof: for every index, the addition and multiplication laws of
nonnegative integer powers give `z_i^(k*f_i+r_i)=(z_i^f_i)^k*z_i^r_i`.
Commutativity and associativity move all first factors to the left. The
product of their k-th powers is the k-th power of their product. The empty
list gives the identity on both sides. No relative primality or disjoint
support is needed. Taking the multiplicative norm gives

`N(P(k*f+r)) = N(P(f))^k * N(P(r))`.

The Lean file formalizes these exact statements in the existing integer-pair
algebra. The ordinary analytic proof, its external inputs, and its open
large-prime premise belong to the critical-bottleneck checkpoint.

## Actual validation

Run `python3 research/checkpoints/2026_09_07_overlap_formal/verify_round.py`
inside the existing WSL environment from the repository root. It stages
byte-identical copies of six specified source files into a fresh scoped Lake
package and invokes `lake build` with warnings as errors. It does not alter the
repository toolchain, dependencies, or existing build caches.

The actual run accepted 22 new and 74 dependency theorem declarations under
Lean 4.32.0. Every theorem has a matching axiom query; only `propext`,
`Classical.choice`, and `Quot.sound` occur. The three new shared-column
declarations are all included. See `verification/lean_validation.json` for
exact source hashes and `verification/fresh-lake-build.log` for compiler output.

This scoped checkpoint build does not certify the full repository, analytic
theorems, general radical compression, the geometric classification, or ABC.

## Integrated manuscript

The current complete source is `paper/ChatGPT_ABC_Uniformity_2026.tex` at the
repository root. Run pdfLaTeX from the `paper` directory, with scalable CM Super
fonts available; repeated passes resolve references. The final verification pass
uses `-recorder -interaction=nonstopmode -halt-on-error -file-line-error` and
outputs to `../tmp/abc_20260907/pdfbuild`.

The updated user-designated PDF has 360 pages and SHA256
`36ea6367ee76db063f3ed9e44a6c4537b815a1173aa60a7eb7785d79fbacecf1`.
The actual final pass contains zero overfull boxes and no unresolved references
or citations. The title and all new-section pages (349 through 356) were rendered
and visually reviewed. `verification/manuscript_validation.json` records every
actual local TeX input hash and final raster hashes. This is not a claim that all
360 pages were individually reviewed or that all historical mathematics was
independently audited during this round.
