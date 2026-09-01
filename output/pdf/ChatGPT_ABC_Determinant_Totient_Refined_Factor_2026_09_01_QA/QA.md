# PDF and manuscript QA

Artifact:
`../ChatGPT_ABC_Determinant_Totient_Refined_Factor_2026_09_01.pdf`.

The final Tectonic run exited zero after two explicit reruns.  Its final log
has no overfull box, undefined control sequence, unresolved reference,
unresolved citation, duplicate label, or LaTeX error.  It has one harmless
underfull vertical box on the title page.  The resulting PDF is 152 A4 pages,
1,079,219 bytes, is unencrypted, contains no form or JavaScript, and records
ChatGPT as author.  Its SHA-256 digest is
`8a793426c185bc343bb6b5204297ad66a45cb7b0fcfb197479db5321554dedf2`.

`verify_pdf.py` extracts text from every page and verifies the title, honest
open-problem status, all three new section headings, the positive-kappa scope
correction, the exact Lean declaration counts, the one-for-one proof audit,
the 9212-job build record, and the terminal non-closure statement.  It also
checks the metadata, page geometry, final compilation log, eight contact
sheets, and the 36 retained high-resolution page renders.  The recorded run in
`pdf-verification.json` is PASS.

`static_tex_audit.py` recursively expands the main source and all 35 input
files.  It finds 608 unique labels, 665 resolved references, 73 unique
bibliography keys, 234 citation commands containing 249 cited keys, no raw
`qquad`, and no environment mismatch.  All 25 theorem, proposition, or
corollary statements directly present in the main file and the three new
fragments are immediately followed by proofs.  The recorded run in
`static-tex-audit.json` is PASS.

All 152 pages were rendered at low resolution and inspected through the eight
contact sheets.  Pages 1 and 118--152 were also retained at higher resolution.
The contact sheets and detailed views of pages 1, 119, 120, 125, 126, 134,
135, 148, 149, and 152 were inspected at original detail.  No clipping,
overlap, broken formula, unreadable table, or malformed reference entry was
found.

These checks certify compilation, internal cross-reference integrity, text
presence, and visual layout.  They do not certify the open mathematical gates
and do not prove or disprove the standard abc conjecture.
