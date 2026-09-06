# Correlated valuation completions and norm-power ramification

Author: ChatGPT. Date: September 6, 2026.

## Mathematical status

This is partial research, **not a proof or disproof of standard ABC**.
The ordinary paper proves:

1. A uniform elementary squarefree-completion theorem for `1+b=c`, with
   specified valuation patterns on both large arms and auxiliary norm content
   one. It constructs exact compensation at a polynomial modulus/height scale.
2. A prime-norm completion theorem in a stated growing-modulus and rectangle
   range. Kai's prime-element estimate and the real-character zero-free input
   are cited, not reproved. A possible exceptional conductor is explicitly
   retained. Fixed-pattern existence and a growing-prime/depth construction
   are deduced without assuming that Siegel zeros do not exist.
3. A sharp ramification bound for rational maps that force an exact or partial
   norm power. The degree-only transfer obstruction is scoped to the stated
   polynomial radical estimate; it does not refute all rational-map methods.

Positive counts of completions do not imply a bound for arbitrary input
triples. The same-height large-modulus obstruction is quantified in the paper.
The uniform all-point correlation remains unresolved and at ABC strength.

## Source reconciliation

Main `937cb77058a80e9e9ae8ce3a4c8e13b752119796` contains a 353-page
exponent-profile manuscript. The separately attached 354-page manuscript
contains a different exponent-compression/prime-norm supplement. `integrate.py`
adds that historical mathematical body and the new body without replacing
main's exponent-profile work. Removing its two marked insertions recovers
the exact main master SHA-256. The archived compression text is unchanged;
its runtime statements refer to its prior execution. Its exact historical
Lean companion is retained under `historical/` and remains **uncompiled**.

## Verification scope

`Lean/CorrelatedCompletions.lean` imports only `Std` and has 16 named queries.
It proves integer congruences, exact prescribed-power arithmetic, finite
weighted-union accounting, polynomial identities, and numerical consequences
of an explicitly supplied ramification budget. It does not formalize Kai's
analytic theorem, the infinite sieve, all prime-factorization mappings, or the
general Jacobian ramification theorem. It has no ABC theorem or extra axiom.
Actual compiler and axiom reports, rather than a source-only scan, are used.

The finite Python replay uses only the standard library. It checks 50 recursive
prime certificates and 195 modular conditions, four fully factored completion
examples, 260070 local residue pairs, twelve polynomial maps, and a sieve of
705600 progression points with an independent factorization check of 100
surviving pairs. It does not test unknown analytic constants or asymptotics.

## Reproduce from the repository root

```sh
python3 research/checkpoints/2026_09_06_correlated_completions/verify.py
bash research/checkpoints/2026_09_06_correlated_completions/wsl/verify_lean.sh
python3 research/checkpoints/2026_09_06_correlated_completions/integrate.py
cd paper
latexmk -pdf -interaction=nonstopmode -halt-on-error ChatGPT_ABC_Uniformity_2026.tex
```

The installer is compatible with x86_64 WSL Ubuntu and ordinary Linux. A
hosted Ubuntu execution does not establish access to the user's personal WSL.
No independent autonomous subagent execution or external peer review is claimed.
