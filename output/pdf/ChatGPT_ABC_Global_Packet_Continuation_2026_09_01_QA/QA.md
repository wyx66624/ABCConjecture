# PDF release QA

**Artifact:** `ChatGPT_ABC_Global_Packet_Continuation_2026_09_01.pdf`  
**Author metadata:** ChatGPT  
**Verdict:** PASS

## Mechanical checks

- Bundled Tectonic compiled the final source twice and exited `0`.
- The final log contains no overfull box, undefined control sequence, LaTeX
  error, undefined citation, or undefined reference.
- The log contains three nonblocking underfull-vbox locations: two in the
  title/front matter at main-source lines 121 and 128 (badness 10000), and one
  near `balanced_persistence_2026.tex` line 694 (badness 1281).
- The bundled runtime emits a nonblocking Fontconfig configuration warning
  before TeX starts.
- The PDF is unencrypted A4, version 1.5, has no forms or JavaScript, and has
  nonempty extractable text on all 119 pages.
- It is 887,737 bytes.  SHA-256:
  `6d3e1faed22053e973f8d87fd669423d7c02a8bed6cc557435a9458b3d8b237e`.

`verify_pdf.py` checks those properties and the ChatGPT author metadata.  It
also checks extracted-text markers for the affine square warning, the Pell
alternative, the 638-factor Danilov state, the `41n+1` tail, the exact IUT
scope, the `122 + 42 = 164` Lean declaration inventory, and the explicit
absence of an unconditional `ABCConjecture` term.  Its machine-readable result
is `pdf-verification.json`; the captured run is `verify-pdf-stdout.txt`.

## Visual checks

Poppler rendered all 119 pages at 60 dpi.  Six contact sheets cover pages
1--20, 21--40, 41--60, 61--80, 81--100, and 101--119.  Page 1 and pages
101--119 were also rendered at 110 dpi.  Three reviewers split the page range:
pages 1--60, pages 61--110, and pages 111--119, with higher-resolution checks
of the title page and the new global-packet section.

No clipped equations, text collisions, margin overflow, missing glyphs,
malformed table rules, unexpected blank pages, or header/footer defects were
found.  In particular, the long formulas and integers on pages 104 and
108--110, the formalization tables on pages 105 and 111--115, and the final
bibliography pages render inside the text block.

## Claim audit

An independent adversarial mathematical audit returned PASS with no high- or
medium-severity issue after the final wording repairs.  The paper separates
proved implications, exact counterexamples to auxiliary statements, finite
no-hit searches, and open premises.  It states that neither an unconditional
Lean proof nor a rigorous unconditional disproof of standard abc has been
obtained.
