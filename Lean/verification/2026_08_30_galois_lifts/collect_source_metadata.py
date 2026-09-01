"""Verify and index the ten primary PDFs newly archived for this increment."""
from pathlib import Path
import hashlib
import json
from pypdf import PdfReader

HERE = Path(__file__).resolve().parent
ROOT = HERE.parents[2]
SOURCES = [
    {
        "path": "research/sources/galois_lift_2026_08_30/Jannsen_Wingberg_1982_Inventiones.pdf",
        "title": "U. Jannsen and K. Wingberg, Die Struktur der absoluten Galoisgruppe p-adischer Zahlkörper",
        "version": "Inventiones Mathematicae 70 (1982), 71–98; author repository scan",
        "url": "https://epub.uni-regensburg.de/26689/1/jannsen17.pdf",
        "sha256": "54b303960baa182f4b7770b734e90da8d8ae48dde1708736af87bc100ea9f048",
        "used_passages": "Section 1.2, Theorem 2 and Section 1.4(a), printed pp. 74–76: full relative local-Galois presentation and relators.",
    },
    {
        "path": "research/sources/galois_lift_2026_08_30/Hoshi_Nishio_2022_revised.pdf",
        "title": "Y. Hoshi and Y. Nishio, On the outer automorphism groups of the absolute Galois groups of mixed-characteristic local fields",
        "version": "June 2022 revised author manuscript",
        "url": "https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1931revised.pdf",
        "sha256": "3789ba5014602506073c82889aa27bb9c9e7e22e763f0905c087cb2713cf497c",
        "used_passages": "Proposition 1.1, proof of Lemma 1.3, and Lemma 2.3: generators, integral coefficient and local linear action. The abelian-field hypothesis of Theorem A is not silently applied to a nonabelian field.",
    },
    {
        "path": "research/sources/galois_lift_2026_08_30/Kondo_2512.09231v2_Dec2025.pdf",
        "title": "K. Kondo, Anabelian aspects of the outer automorphism groups of the absolute Galois groups of mixed-characteristic local fields",
        "version": "arXiv:2512.09231v2, December 12, 2025; preprint",
        "url": "https://arxiv.org/pdf/2512.09231v2",
        "sha256": "376d2f3cf6df8ca944a6158349a3ccd50906b424537a84aaa512d1b42e0801bd",
        "used_passages": "Theorem 1.3 on the trace kernel; Theorem 2.17 and PDF pp. 19–20 on handle maps. The even-degree case is used with its actual hypotheses.",
    },
    {
        "path": "research/sources/galois_lift_2026_08_30/Kedlaya_2004_Tate_Curve.pdf",
        "title": "K. S. Kedlaya, Introduction: the Tate curve",
        "version": "MIT 18.727 lecture notes, Fall 2004",
        "url": "https://kskedlaya.org/18.727/tate-curve.pdf",
        "sha256": "92a836142364d520c947884b24dead6253901e842f10000ec883298662d752dd",
        "used_passages": "Theorem 1, PDF p. 3; Theorem 2, p. 4; Proposition 3, p. 5: Tate uniformization, field of definition, and ramified torsion.",
    },
    {
        "path": "research/sources/initial_data_2026_08_30/Mochizuki_Canonical_Curves_2003_author.pdf",
        "title": "S. Mochizuki, The absolute anabelian geometry of canonical curves",
        "version": "Author version of Documenta Mathematica, Extra Volume (2003), 609–640",
        "url": "https://www.kurims.kyoto-u.ac.jp/~motizuki/Canonical%20Liftings.pdf",
        "sha256": "dcf986ecbb06d4e9cb49f6ff92d7417d7e63ce946fd1403b1128e416d9ac807a",
        "used_passages": "Remark 2.1.1, PDF p. 9; Proposition 2.3, p. 10; Proposition 2.7, pp. 14–15: nonarithmetic hemi-elliptic core and base change/descent.",
    },
    {
        "path": "research/sources/initial_data_2026_08_30/Mochizuki_Etale_Theta_2009_author.pdf",
        "title": "S. Mochizuki, The étale theta function and its Frobenioid-theoretic manifestations",
        "version": "Author version of Publications of RIMS 45 (2009), 227–349",
        "url": "https://www.kurims.kyoto-u.ac.jp/~motizuki/The%20Etale%20Theta%20Function%20and%20its%20Frobenioid-theoretic%20Manifestations.pdf",
        "sha256": "42c5d9180c69bc9fa6596ce1a11662494315954ed74301060bf1819f955a7406",
        "used_passages": "PDF p. 11 graph cover; p. 16 square-root field; pp. 20–21 theta values; pp. 27–28 Theorem 1.10 and Remark 1.10.1(ii); pp. 32–36 Definitions 2.1/2.5 and Proposition 2.2, including its local/global quantifiers.",
    },
    {
        "path": "research/sources/initial_data_2026_08_30/Takeuchi_1983_Arithmetic_1e_JMSJ.pdf",
        "title": "K. Takeuchi, Arithmetic Fuchsian groups with signature (1;e)",
        "version": "Journal of the Mathematical Society of Japan 35 (1983), 381–407",
        "url": "https://www.jstage.jst.go.jp/article/jmath1948/35/3/35_3_381/_pdf/-char/en",
        "sha256": "6c4f44cf6abc2b75d5433f594d2d9b1d4407a3fea934c5149c13fb62d2f6223f",
        "used_passages": "Theorem 4.1(i), printed p. 392 / PDF p. 12: the four arithmetic once-punctured classes.",
    },
    {
        "path": "research/sources/initial_data_2026_08_30/Sijsling_1707.01158v2_2017.pdf",
        "title": "J. Sijsling, Canonical models of arithmetic (1;∞)-curves",
        "version": "arXiv:1707.01158v2, July 6, 2017; subsequently Contemporary Mathematics 722 (2019), DOI 10.1090/conm/722/14530",
        "url": "https://arxiv.org/pdf/1707.01158v2",
        "sha256": "b483753b248795227de800c9f004cbcf077c502092140d3ac4c1e84b6b7df60f",
        "used_passages": "Table 4, PDF p. 11: the four j-invariants. The table was read directly and independently cross-checked.",
    },
    {
        "path": "research/sources/frey_powerfree_family_2026_08_30/Xylouris_2009_0906_2749v1_author_preprint.pdf",
        "title": "T. Xylouris, On Linnik's constant",
        "version": "arXiv:0906.2749v1, June 15, 2009; German Diplomarbeit",
        "url": "https://arxiv.org/pdf/0906.2749v1",
        "sha256": "f9505f1dba1d4f3eca2b69f5f25e2395054fde875848a1c9026f10a53a99844c",
        "used_passages": "Definition of P(q), PDF p. 6; Theorem 1.1, PDF p. 9: the effective exponent 5.2. The construction does not use or claim an archived verification of the later 5.18 improvement.",
    },
    {
        "path": "research/sources/frey_powerfree_family_2026_08_30/Mochizuki_2010_Arithmetic_Elliptic_Curves_General_Position_author.pdf",
        "title": "S. Mochizuki, Arithmetic elliptic curves in general position",
        "version": "February 2009 author version; Mathematical Journal of Okayama University 52 (2010), 1–28",
        "url": "https://www.kurims.kyoto-u.ac.jp/~motizuki/Arithmetic%20Elliptic%20Curves%20in%20General%20Position.pdf",
        "sha256": "b9dc115af61dca7fe434332ebafddf6a376a9e2926dad4e1ea2dcc0d2441f768",
        "used_passages": "Example 1.3(ii), PDF pp. 5–6: compactness/interior is imposed on each finite-extension slice, not on ambient Qbar2.",
    },
]

for source in SOURCES:
    path = ROOT / source["path"]
    actual = hashlib.sha256(path.read_bytes()).hexdigest()
    assert actual == source["sha256"], source["path"]
    source["bytes"] = path.stat().st_size
    source["pdf_pages"] = len(PdfReader(path).pages)

(HERE/"source_metadata.json").write_text(
    json.dumps({"verification_date": "2026-08-31", "new_primary_pdf_count": 10,
                "sources": SOURCES}, ensure_ascii=False, indent=2)+"\n", encoding="utf-8")
parts = ["""# Primary sources newly archived for the Galois/initial-data increment

Author: ChatGPT. Checked through 2026-08-31.

These ten original-source PDFs were read at the passages actually used
in the mathematical arguments. This index records the precise archived
version, not an assertion that all results in a source are formalized or
that a disputed global comparison is accepted as an axiom. Original PDFs
were not edited. Sizes, page counts and SHA-256 values below are recomputed
by `collect_source_metadata.py`; machine-readable data are in
`source_metadata.json`.
"""]
for n, source in enumerate(SOURCES, 1):
    parts.append(f"""## {n}. {source['title']}

- Primary source: [{source['title']}]({source['url']}).
- Archived version: {source['version']}.
- Repository path: `{source['path']}`.
- Size: {source['bytes']} bytes; PDF pages: {source['pdf_pages']}.
- SHA-256: `{source['sha256']}`.
- Checked use: {source['used_passages']}
""")
parts.append("""## Earlier primary sources retained unchanged

IUT I Definition 3.1 (PDF pp. 61–63), its oriented-cover discussion
(pp. 37–39), and the native root in Example 3.2(iv) (p. 71) were reread
in the existing archived IUT I source. IUT III/IV pilot, procession,
Ind1/Ind2 and containing-ideal passages were checked in the previously
archived originals. Joshi IV v2 (February 24, 2025), especially pp. 50,
53–54 and the normalized-Q definitions, is distinguished from the
original finite-slice compactness condition and from an unnormalized
printed sum. Silverman's second edition supplies the precise good-
reduction, torsion, Tate and j-valuation facts.

Those originals and their earlier indexes remain covered by the prior
506-entry manifest and its preserved snapshot. The existing family
`research/sources/frey_powerfree_family_2026_08_30/SOURCE_INDEX.md`
also records shared older inputs and has not been rewritten. Version
labels matter: Kondo is a preprint; Xylouris 2009 rather than an
unretrieved later journal PDF supplies the Linnik exponent used here.
""")
(HERE/"SOURCE_INDEX.md").write_text("\n".join(parts), encoding="utf-8")
print(json.dumps({"checked_primary_pdfs": len(SOURCES),
                  "total_bytes": sum(s["bytes"] for s in SOURCES),
                  "pages": {Path(s["path"]).name: s["pdf_pages"] for s in SOURCES}},
                 ensure_ascii=False))
