# Original sources used in the August 30 continuation

Researcher: ChatGPT. Retrieval and verification: 2026-08-30, America/Tijuana.
The exact downloaded bytes are inventoried in `source_inventory.json` and
`SHA256SUMS`. All seven files have a PDF signature and were opened with a PDF
reader. Dates below distinguish the cited version from a later publication.

| Local file | Original source and version | Use and limits |
| --- | --- | --- |
| `Akhtari_Vaaler_2009.10857v2.pdf` | [Akhtari–Vaaler, arXiv:2009.10857v2](https://arxiv.org/pdf/2009.10857v2), 19 October 2023; subsequently *Algebra & Number Theory* 18 (2024), 1589–1617 | Theorem 1.2, exterior products and small independent generators. The application uses Pasten's explicit specialization and checks its index and rank conditions. |
| `Bennett_Walsh_1999.pdf` | [Bennett–Walsh, author's journal PDF](https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf), *Proc. Amer. Math. Soc.* 127 (1999), 3481–3491; [DOI](https://doi.org/10.1090/S0002-9939-99-05041-8) | Theorem 1.2 and Corollary 1.3; the fundamental norm-one Pell coordinate in the squarefree endpoint branch. This is an existing published input, not a new theorem attributed to this project. |
| `Gyory_1901.11289v1.pdf` | [Győry, arXiv:1901.11289v1](https://arxiv.org/pdf/1901.11289v1), 31 January 2019 | Background check on multiplicative-group approximation. A later corrigendum is listed in the [author's bibliography](https://math.unideb.hu/en/research-kalman-gyory), but its full text was not obtained. The project does not claim to have read it and does not base the final argument on the suspect printed sign in this version. |
| `Joshi_IIhalf_2305.10398v12.pdf` | [Joshi, arXiv:2305.10398v12](https://arxiv.org/pdf/2305.10398v12), arXiv version 24 February 2025; title-page date 25 February 2025 | Corollary 5.6.2 on perfected multiplicative monoids, Proposition 7.2.2 on Kummer cohomology, and Section 7.5 on collation. A monoid Frobenius is not silently identified with multiplication by the prime on an integral Kummer lattice. |
| `Matveev_2000_explicit_lower_bound.pdf` | [Matveev, original English PDF via Math-Net](https://www.mathnet.ru/php/getFT.phtml?jrnid=im&option_lang=eng&paperid=314&what=fullteng), *Izv. Math.* 64 (2000), 1217–1269; [DOI](https://doi.org/10.1070/IM2000v064n06ABEH000314) | Printed pp. 1218–1219, equation (1.3) and Corollary 2.3. The normalized exponent parameter, the 0.16 cutoff, the field-degree factor, and the explicit constant were checked independently. Theorem 2.1's additional logarithmic independence condition is not assumed. |
| `Mochizuki_IUT_I_May2020.pdf` | [Mochizuki, author's Kyoto PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20I.pdf), title-page date May 2020, 186 pages | Definition 3.1 on physical pp. 61–63 and Example 3.2(iv) on p. 71. These fix the initial extension and the `1/(2 ell)` Tate root used by the original IUT IV calculation; they do not verify every global initial-data condition for a proposed example. |
| `Mochizuki_IUT_IV_April2020.pdf` | [Mochizuki, author's Kyoto PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20IV.pdf), title-page date April 2020, 87 pages | Propositions 1.1–1.4, Remark 1.7.1, and Theorem 1.10 Steps (iv)–(v), especially physical pp. 13–14, 17, 26–29. This archived author version is distinguished from the 2021 journal pagination. The local source comparison is not a proof or disproof of the full IUT argument. |

The Matveev and Mochizuki files were fetched directly from the listed
primary hosts. The other files were copied from the research agents'
downloads from the listed URLs and checked against their hashes. One newly
created duplicate Matveev archive was removed only after its full SHA-256
matched this canonical copy. No pre-existing user PDF was removed or edited.

The previously archived Bérczes–Evertse–Győry, Pasten, BBLT, Younis,
Joshi III/IV, and LANA sources remain in their original source directories
and retain their earlier manifests. The current continuation uses those
same pinned versions rather than silently replacing them with a moving URL.

Original PDFs are retained for source checking. The English manuscript
paraphrases their statements, supplies the application proofs, and does
not reproduce long copyrighted passages. The new mathematical proofs were
written before their companion Lean implementations; cited external
theorems are not inserted as Lean axioms.
