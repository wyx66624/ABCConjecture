# PDF visual verification

Author: ChatGPT. Research date: 2026-08-30.

Exact accepted artifact: `output/pdf/ChatGPT_ABC_Uniformity_2026.pdf`.
It has 34 pages, 330296 bytes, and PDF author metadata `ChatGPT`.
SHA-256:

```text
f4a8109109153b9445015af7de14d7dd2e4c9d969a0ced405fab9ee699d0452d
```

Tectonic completed successfully with no final TeX warning lines.
All pages were rendered as complete PNG pages and paired previews in
`tmp/pdfs/abc_uniform_gate_qa_2026_08_30/`. Text extraction was used as
an additional check, not as a substitute for visual inspection.

| Pages | Reviewer | Record | Verdict |
| --- | --- | --- | --- |
| 1–12 | analytic_route | `qa/analytic-review.md` | Pass; pages 6–8 also inspected individually |
| 13–24 | root | `qa/root-review.md` | Pass; every complete page inspected in paired renders |
| 25–34 | arithmetic_geometry_route | `qa/geometry-review.md` | Pass; pages 27, 28, 32, 33 and 34 also inspected individually |

The reviews cover all pages without gaps. No clipping, formula overflow,
text/formula collision, missing glyph boxes, unresolved reference markers
or inconsistent page-number sequence were found. Continued proofs,
the long formalization table and the bibliography remain readable.
The manuscript visibly states the missing unconditional abc conclusion
and the formalization boundaries.

This record is a visual check of the specified PDF, not evidence that
its unformalized mathematical inputs are Lean theorems or that the
manuscript has passed external peer review.
