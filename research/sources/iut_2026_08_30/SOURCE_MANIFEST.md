# IUT and Arithmetic Teichmuller source archive

Prepared by ChatGPT for the research session of 2026-08-30.

This directory preserves primary-source bytes used in the IUT route audit. Here
“III v4” and “IV v2” refer to Kirti Joshi's *Construction of Arithmetic
Teichmuller Spaces* series, not to Mochizuki's IUT III and IV. Recording a claimed
theorem does not certify its proof or assume the abc conjecture.

Four existing cached originals were copied without conversion. The two missing
version-specific arXiv PDFs were then downloaded from their original URLs; their
combined size is 3,275,212 bytes. All six archived source files are listed below.
`SHA256SUMS` contains the same hashes in a machine-readable format. The manifest
and checksum list are newly written documentation, not original source files.

PDF page numbers below are one-based physical PDF pages; they coincide with the
printed folios at the cited body passages. The locations identify passages used
or rechecked in this session, not an assertion that every result in each source
has been validated. Section-number searches against the archived PDFs confirmed
the main locations originally read in the official arXiv HTML.

## 1. Joshi's response to the LANA report

- File: `Joshi_Response_LANA_2026-07-30.pdf`
- Original URL: <https://sites.arizona.edu/kirti-joshi/files/2026/07/Comments-on-the-LANA-Project-Report-of-Kato-et-al.pdf>
- Author and title: Kirti Joshi, *Comments on the LANA Project Report of Kato et al.*
- Date printed on page 1: July 30, 2026.
- Extent: 6 pages; 210,901 bytes.
- SHA-256: `04001467c3541f4b5eb1121a8d97e459fc5ad41c48a5f743ca9eefd9077a8854`
- Provenance: copied from `tmp/pdfs/iut_route_2026_08_30/Joshi_LANA_comments_July2026.pdf`; source and destination hashes match.
- Verified locations: p. 1 (title and date); p. 2, section 3(1) (the author's statement about the February 2025 Part IV revision); pp. 3–4, section 3(6) (the two arithmeticoids and the reference to Part IV, Theorem 6.10.1). The response was text-inspected in full; pp. 3–4 were also visually inspected during the audit.
- Audit boundary: the response supplies the author's explanation of the intended arithmetic structures. It is not treated as a newly supplied proof of the required source-object and log-volume compatibility.

## 2. Joshi, Part III, version 4

- PDF file: `Joshi_III_2401.13508v4.pdf`
- Original PDF URL: <https://arxiv.org/pdf/2401.13508v4>
- Version record: <https://arxiv.org/abs/2401.13508v4>
- Author and title: Kirti Joshi, *Construction of Arithmetic Teichmuller Spaces III: A ‘Rosetta Stone’ and a proof of Mochizuki's Corollary 3.12*.
- Version: arXiv:2401.13508v4. The arXiv stamp on p. 1 reads **24 February 2025**, while the author's title-page date reads **25 February 2025**. These are distinct date fields.
- Extent: 165 pages; 2,169,796 bytes.
- PDF SHA-256: `86a92ca893e774e1ea591ed9825a30627f3f19d8df0b26b7f5855dc0923f0429`
- Provenance: no original PDF was present in the inspected local cache; this file was downloaded directly from the version-specific PDF URL during archival. Its PDF header, page count, title, version stamp, and the principal cited passages were rechecked.
- Companion HTML file: `Joshi_III_2401.13508v4.html`
- Original HTML URL: <https://arxiv.org/html/2401.13508v4>
- HTML size: 3,952,164 bytes.
- HTML SHA-256: `8c863b8303e94493b261a55b772cf0aeff9a46995d51b80b59a5ce35c41a025a`
- HTML provenance: copied from `tmp/iut_route_session_2026_08_30/joshi_III_v4.html`; source and destination hashes match. This is the original downloaded HTML, not a PDF extraction. The presentation of a web page can change even when its manuscript version is fixed; the checksum pins this archived representation.

Locations used in the audit:

| Location | PDF page | Role in the source audit |
| --- | ---: | --- |
| Theorem 4.2.2.1 | 32 | Simultaneous actions and the stated norm relation. |
| Proposition 9.7.5.1 | 112 | The collation construction and its specified isomorphisms. |
| Theorem-Definition 9.8.1.1 | 113 onward | Simultaneous tuple actions, convex closures, and passage to a tensor image. |
| Passage from a product to a tensor product | 120 | The displayed tuple-to-pure-tensor map and the claim about its linearity. |
| Lemma 9.10.7.1 | 125 | A volume estimate with a full tensor lattice included in its hypotheses. |
| Proposition 9.10.8.1 | 126 | The comparison involving holomorphic hulls. |
| Theorem 9.11.1 | 127 | The stated lower bound. |
| Corollary 9.11.1.1 | 128 | The subsequent signed numerical formulation. |

Useful anchors in the archived official HTML include
`S9.SS7.SSS5`, `S9.SS8.SSS1.E1`, `S9.SS10.SSS7.E1`, and
`S9.SS10.SSS8.E1`. The audit also used sections 5.3 and 8.11 when checking the
allowed enlargement and indeterminacies. A convex hull is not silently assumed
to be a module span, and simultaneous actions are not silently replaced by
independent actions on tensor factors.

## 3. Joshi, Part IV, version 2

- File: `Joshi_IV_2403.10430v2.pdf`
- Original PDF URL: <https://arxiv.org/pdf/2403.10430v2>
- Version record: <https://arxiv.org/abs/2403.10430v2>
- Official HTML used during the audit: <https://arxiv.org/html/2403.10430v2> (no local HTML file is included).
- Author and title: Kirti Joshi, *Construction of Arithmetic Teichmuller Spaces IV: Proof of the abc-conjecture*.
- Version: arXiv:2403.10430v2. The arXiv stamp on p. 1 reads **24 February 2025**, while the author's title-page date reads **25 February 2025**.
- Extent: 80 pages; 1,105,416 bytes.
- SHA-256: `ef8851fe656c705f7e9881778b4dd0c592c9f35a2980be6a335412a15542547a`
- Provenance: no original PDF was present in the inspected local cache; this file was downloaded directly from the version-specific PDF URL during archival. Its PDF header, page count, title, version stamp, and cited passages were rechecked.
- Verified locations: p. 66, Theorem 6.10.1 and Remarks 6.10.2–6.10.3; p. 67, the proof and the middle equality involving the two hull volumes; p. 69, Proposition 6.10.9 and its reference to IUT IV, Theorem 1.10, Step (v); p. 71, equation (6.11.7) and the surrounding sign conventions.
- Audit boundary: choosing a common normalization does not by itself supply a correspondence between the actual hulls that has the necessary measure properties. The manuscript's asserted equality is recorded as a proof obligation, not added as an axiom.

## 4. Pinned LANA report source

- File: `LANA_report_202607_293bdd8.tex`
- Title and author as written in the source: *Project LANA Interim Report on IUT Theory*, LANA project.
- Immutable source URL: <https://raw.githubusercontent.com/katobungen/LANA_report_202607/293bdd89463473ae13d40834d70fb4b7ba81da1f/LANA_report_202607.tex>
- Immutable source browser view: <https://github.com/katobungen/LANA_report_202607/blob/293bdd89463473ae13d40834d70fb4b7ba81da1f/LANA_report_202607.tex>
- Commit URL: <https://github.com/katobungen/LANA_report_202607/commit/293bdd89463473ae13d40834d70fb4b7ba81da1f>
- Commit: `293bdd89463473ae13d40834d70fb4b7ba81da1f`; message `revision 1.0.1`; author and committer timestamp `2026-07-20T05:27:20Z`, checked through the original GitHub API.
- Size: 189,256 bytes.
- SHA-256: `13c60b0669644b0e5dea72adfdb55b1dad367ff91f5b11fadf75e48ac0e66f51`
- Provenance: copied from `tmp/iut_route_session_2026_08_30/LANA_report_202607.tex`. That cache was initially obtained from the repository's mutable main branch. During this archival pass, the copied bytes were compared with a fresh response from the **immutable** raw URL above and found exactly equal, not merely textually similar.
- Format boundary: this archive contains the original TeX source, not a report PDF or a complete reproducible TeX build bundle. The file's date macro uses `\today`; a date produced by recompiling it would not establish its historical revision date. Use the commit metadata instead.

Verified locations in these exact source bytes:

| Source lines / stable label | Role in the audit |
| --- | --- |
| Lines 1695–1704; `sec:multiradialThetaCor312` | The multiradial algorithm and the three indeterminacies. |
| Lines 2502–2523; `sub:theMainGoal`, `eqn:SSEtaGoal` | The two constructions of the real-line identification and the existence of a suitable integral-structure choice equating them. |
| Lines 2645–2677 | The distinction between source compatibility and a numerical comparison, and the report's stated lack of a proof of the required compatibility. |

The following PDF link is recorded for navigation only and was **not archived**:
<https://github.com/katobungen/LANA_report_202607/blob/pdf/LANA_report_202607.pdf>.
The `pdf` branch is mutable; this link is not a checksum-pinned substitute for
the TeX source above.

## 5. Joshi FAQ: upload date versus manuscript date

- File: `Joshi_FAQ_upload_2026-05.pdf`
- Original URL: <https://sites.arizona.edu/kirti-joshi/files/2026/05/joshi-mochizuki-FAQ.pdf>
- Author and title: Kirti Joshi, *FAQ about the proof of the abc-conjecture*.
- Dates: p. 1 is dated **November 1, 2025**; its update log ends with **April 13, 2026**. The author's URL is under May 2026, and the PDF creation metadata is dated May 10, 2026. The upload path is not evidence of a newly revised May 2026 proof.
- Extent: 23 pages; 351,560 bytes.
- SHA-256: `1c457be3c2b7dfc0b5b829d6b8bf484e899f3f89ede938f0925a4fabe03ba422`
- Provenance: copied from `tmp/pdfs/iut_route_2026_08_30/Joshi_FAQ_May2026.pdf`; source and destination hashes match.
- Verified location: p. 1, including the title date and footnote update log, checked in text and visually. This file was used for version/date control, not as a new proof input.

## 6. Original web records without archived page snapshots

- ZEN University, July 17, 2026 announcement: <https://zen.ac.jp/news/zmcpostevent0717e>. The report overview and current-status discussion were checked for the stated difficulty in passing from IUT III, Theorem 3.11, to Corollary 3.12 and the project's suspension of judgment. No webpage bytes or screenshots are included, and no webpage hash is claimed.
- LANA commit record: <https://github.com/katobungen/LANA_report_202607/commit/293bdd89463473ae13d40834d70fb4b7ba81da1f>. The underlying TeX file is archived and verified against this commit as described above.
- Joshi's author website: <https://sites.arizona.edu/kirti-joshi/>. It was used to locate the July response and distinguish uploads from revisions. No website snapshot is included.

## Verification

All copied files were compared with their cache sources using SHA-256. Both new
PDF downloads were checked for a PDF signature and successfully opened with
`pypdf`; their version stamps and relevant pages were inspected. The LANA source
was additionally compared byte for byte with its immutable upstream URL.

To verify the six source files using Python from this directory:

```python
from pathlib import Path
from hashlib import sha256

for line in Path("SHA256SUMS").read_text(encoding="ascii").splitlines():
    expected, name = line.split("  ", 1)
    actual = sha256(Path(name).read_bytes()).hexdigest()
    assert actual == expected, name
    print("OK", name)
```

This source archive does not contain, or certify the existence of, an
unconditional Lean proof of `ABCConjecture` or a disproof of the conjecture.
