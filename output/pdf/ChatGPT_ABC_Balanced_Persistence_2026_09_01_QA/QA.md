# PDF release QA

**Artifact:** `ChatGPT_ABC_Balanced_Persistence_2026_09_01.pdf`  
**Author metadata:** ChatGPT  
**Verdict:** PASS

## Mechanical checks

- Tectonic compilation exited `0` after the final source revisions.
- The final log contains no overfull box, undefined control sequence, LaTeX
  error, undefined citation, or undefined reference.
- It contains two nonblocking underfull-vbox locations per internal TeX pass:
  the title material at main-source line 112 (badness 4291) and the long
  formalization table near `balanced_persistence_2026.tex` line 694
  (badness 1281).
- The bundled runtime emits a nonblocking Fontconfig warning before TeX starts.
- The PDF is A4, version 1.5, 111 pages, and 844,056 bytes.
- SHA-256:
  `609962b0bf64daf51e5822410c1dbcdff4f55ae452c70d2da6db9fc3e9f87bbc`.

`verify_pdf.py` uses `pypdf` to verify the page count, nonempty extracted text
on every page, ChatGPT author metadata, the two Danilov constants, the corrected
87-declaration statement, and the explicit absence-of-terminal-result sentence.
Its machine-readable output is `pdf-verification.json`.

## Visual checks

Poppler rendered page 1 and every page from 96 through 111 at 110 dpi.  The
rendered pages and `contact-sheet.png` were inspected.  Higher-resolution
inspection focused on pages 98--100 and 103--108, which contain the revised
affine theorem and proof, Pell boundary, elliptic notation, Walsh rank
hypothesis, Danilov progression, route ledger, and Lean declaration inventory.

No clipped equations, text collisions, broken table rules, missing glyphs, or
margin overflow were found.  In particular, the 42-digit Danilov representative
and modulus fit on two centered lines, and the formalization tables remain
inside the text block.

## Claim audit

An independent adversarial reviewer rechecked the final source after revision
and returned PASS.  The PDF distinguishes conditional implications, finite
search exclusions, and unconditional theorems; keeps Walsh's positive-rank
hypothesis explicit; and states that neither an unconditional Lean proof nor a
rigorous unconditional disproof of standard abc has been obtained.
