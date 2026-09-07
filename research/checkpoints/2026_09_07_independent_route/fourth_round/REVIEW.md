# Fourth-round proof and exact replay review

Date: 2026-09-07.

## Ordinary mathematics

`power_class_lifting.md` PL1--PL5 received full independent ordinary-proof
review from root, critical_bottleneck, and adversarial_audit. All three
reported no mathematical gap. The checks explicitly included:

- h-free rational-to-integer lifting and the bijection for the actual seed;
- the minimal denominator quotient h/gcd(h,4) and coupled-class direction;
- direct-cover ramification, including the pole of order four at infinity;
- finiteness of K(S,h) using the S-class group and S-unit group, without
  element unique factorization;
- integral linear-factor coprimality outside the discriminant and residual;
- composite-h Kummer independence, degree h^3, diagonal inertia h at the
  common pole, and genus 1+h^2(h-2);
- Faltings over a fixed number field and the precise fixed-h quantifiers;
- residual support, fixed divisor exclusion, and least odd prime escape
  along sequences whose seed height tends to infinity.

Both peer reviewers independently opened the Darmon--Granville author-hosted
primary PDF and verified printed page 514: the consequence after Theorem 1
applies to four simple roots and fixed exponent at least three. The note
explicitly labels this as an instance of that established mechanism.

PL6 is a short deduction proposed by adversarial_audit: fix h=3, enumerate
the at most 3^|S| cube-free residuals, and apply PL4. Adversarial_audit also
completed the final full PL1--PL6 ordinary and TeX transcription review,
including the precise eventual support-escape quantifier in PL6; it passed.

The new TeX is `paper/power_class_lifting.tex`, with unique `pl-` labels.
No third-round manuscript or source file was changed. Its full independent
transcription review passed. This is not itself a claim that the new TeX
rendering or formalization was checked.

## Exact arithmetic replay

Command actually run successfully on Windows Python:

    python research/checkpoints/2026_09_07_independent_route/fourth_round/exact_power_lifting.py

The standard-library-only script checks 555 primitive seeds with both
coordinates at most 30, giving 6105 exact Fraction lifts for h=2,...,12.
It also checks the genus arithmetic and the minimal denominator-class
divisibility relation for h=2,...,64, and the strict a=1,b=2 naive-map
counterexample. The exact lifts reconstruct the integer root from the
rational curve coordinates.

Canonical UTF-8 with LF output: `exact_power_lifting_results.json`.
SHA-256:

    bf5c7c23b679358f6ea408001c07b033fa2a604d45d529779c00aafe819cfc44

These are finite arithmetic checks. They do not verify Faltings, Kummer
theory, S-unit/class-group finiteness, a uniform result in h, or ABC.
No complete geometric or number-field Lean formalization is claimed.

## Cross-review of the other fourth-round construction

I independently read and checked adversarial_audit's
`fourth_round/local_power_boundary.md` LP1--LP3. The finite-modulus family,
strong Hensel hypotheses, exact extraction depth selection at 7 and 67,
CRT requirements at 13 and 31, primitive oriented Eisenstein quotients,
and fixed-exponent residual growth are correct. In particular its
representations are actual integer extractions, while their residuals
prevent an inference of the required small-lambda two-step gate.

## Read-only visual review of the sealed third-round bibliography

I actually opened `tmp/abc_20260907/round3pdf/review-388.png`,
`review-389.png`, and `review-390.png`. All three inspected pages passed:
no clipping, overlap, garbled glyphs, or overflowing references; hanging
indents and blue links remained inside the page margins. The transitions
among these three pages were consistent. No file was changed by this QA.
