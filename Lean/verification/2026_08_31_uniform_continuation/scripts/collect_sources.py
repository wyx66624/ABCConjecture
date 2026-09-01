"""Verify the exact original PDFs used in this continuation; never edit the PDFs."""
from pathlib import Path
import hashlib
import json
from pypdf import PdfReader

ROOT = Path(__file__).resolve().parents[4]
RECORD = ROOT / "Lean/verification/2026_08_31_uniform_continuation"
M = "https://www.kurims.kyoto-u.ac.jp/~motizuki/"
sources = [
    dict(path="research/sources/iut_membership_2026_08_31/Mochizuki_AbsTopIII_November2015_author.pdf",
         title="S. Mochizuki, Topics in Absolute Anabelian Geometry III: Global Reconstruction Algorithms",
         version="November 2015 author version, as shown on the title page", newly_archived=True,
         url=M+"Topics%20in%20Absolute%20Anabelian%20Geometry%20III.pdf",
         sha256="e8115df30a86dea26e2ebf60cb333558ff28fe3e4d57017a80421787b53421a9",
         used_passages="Proposition 5.8(i)–(iii), pp.139–140: contravariant transfer reconstruction of the actual mono-analytic carrier and shell, and its log-volume normalization. Corollary 5.10(iv)(c),(d), pp.148–149: the natural Kummer/abelianization comparison through local reciprocity, and its shell compatibility. Used for the fixed-base-branch local membership proof, not as an abc theorem."),
    dict(path="research/sources/uniform_gate_2026_08_30/Mochizuki_Local_Fields_IJM1997.pdf",
         title="S. Mochizuki, A version of the Grothendieck conjecture for p-adic local fields",
         version="International Journal of Mathematics 8 (1997), 499–506; author PDF",
         url=M+"A%20Version%20of%20the%20Grothendieck%20Conjecture%20for%20p-adic%20Local%20Fields.pdf",
         sha256="757670e59a4e9d4c69675fec91b5d6998b411d3554e721b40d445e61a867121e",
         used_passages="Propositions 1.1–1.2 and Corollary 1.3, PDF pp.2–3: recovered inertia, cyclotomic character and absolute degree."),
    dict(path="research/sources/uniform_gate_2026_08_30/Milne_CFT_v4.03_August2020.pdf",
         title="J. S. Milne, Class Field Theory", version="Version 4.03, August 6, 2020",
         url="https://www.jmilne.org/math/CourseNotes/CFT.pdf",
         sha256="50d79af78250a9f1117ad9d337e0b231704a533fc707966ed1bfa52e13d498f5",
         used_passages="Chapter III, Proposition 3.6 and Section 4; PDF pp.118–122: local pairing/reciprocity input to the separately proved trace covariance."),
    dict(path="research/sources/global_uniform_gate_2026_08_30/Silverman_2009_Arithmetic_of_Elliptic_Curves_2nd.pdf",
         title="J. H. Silverman, The Arithmetic of Elliptic Curves",
         version="Second edition, Springer, 2009; previously archived private reading copy, not a deliverable",
         url="https://www.pdmi.ras.ru/~lowdimma/BSD/Silverman-Arithmetic_of_EC.pdf",
         sha256="72ee67bfa1e3fdf582ac7e4b032d7ca0b35a168ed6443ac39c121fbb788cab25",
         used_passages="Chapters III, V and VII: isogeny quotients and duals, good-reduction Frobenius and integral-model minimality. These inputs remain outside the new Lean module."),
    dict(path="research/sources/arithmetic_geometry_gate_2026_08_31/Mazur_1978_Rational_isogenies_prime_degree.pdf",
         title="B. Mazur, with an appendix by D. Goldfeld, Rational isogenies of prime degree",
         version="Inventiones Mathematicae 44 (1978), 129–162", newly_archived=True,
         url="https://www.math.columbia.edu/~goldfeld/Mazur-Goldfeld1978.pdf",
         sha256="f3da9ef0d3d184225c4799951897be7b90d8b25050c5d508b69aeff70fd2ead3",
         used_passages="Theorem 1, printed pp.129–130. The 1978 paper is not cited as already proving the completed composite cyclic-degree list."),
    dict(path="research/sources/arithmetic_geometry_gate_2026_08_31/Balakrishnan_Mazur_2025_Ogg.pdf",
         title="J. S. Balakrishnan and B. Mazur, with an appendix by N. Dogra, Ogg's torsion conjecture: Fifty years later",
         version="Bull. Amer. Math. Soc. 62 (2025), 235–268; DOI 10.1090/bull/1851", newly_archived=True,
         url="https://celebratio.org/media/essaypdf/636_Orig.pdf",
         sha256="2c6acd3452ced7f031c446e6f54a94f09681d0e9d8ee28d199e308ad46847d6d",
         used_passages="Theorem 2.2, printed p.239 / PDF p.5: complete unconditional rational cyclic-isogeny degree list, including CM. Read by the root and independent reviewer."),
    dict(path="research/sources/initial_data_2026_08_30/Mochizuki_Etale_Theta_2009_author.pdf",
         title="S. Mochizuki, The étale theta function and its Frobenioid-theoretic manifestations",
         version="Title page: December 2008; published in PRIMS 45 (2009). Filename year is not the PDF version date.",
         url=M+"The%20Etale%20Theta%20Function%20and%20its%20Frobenioid-theoretic%20Manifestations.pdf",
         sha256="42c5d9180c69bc9fa6596ce1a11662494315954ed74301060bf1819f955a7406",
         used_passages="Proposition 1.4(ii)–(iii), PDF pp.20–21: original theta series, functional equation and Kummer evaluation."),
    dict(path="research/sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf",
         title="S. Mochizuki, Inter-universal Teichmüller Theory I", version="May 2020 author version",
         url=M+"Inter-universal%20Teichmuller%20Theory%20I.pdf",
         sha256="7360e3ed27c235b5497a0743d3ed1646fbb97688547d16b7c784fc7f127f1f03",
         used_passages="Example 3.2(ii),(iv), pp.70–71: reciprocal normalized theta root and its finite constant ambiguity. Corollary 5.3(ii), pp.143–145: the bijective lifting of D-prime-strip isomorphisms used with one synchronized copy identity; prior initial-data and theater constructions retained."),
    dict(path="research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_II_December2020.pdf",
         title="S. Mochizuki, Inter-universal Teichmüller Theory II", version="December 2020 author version",
         url=M+"Inter-universal%20Teichmuller%20Theory%20II.pdf",
         sha256="180bfa6aaddc4ae37af37acaad51f61e0a47b33b8255ad3169e28a970ae39b7c",
         used_passages="Remark 1.12.2(i)–(ii), pp.58–59; Corollary 2.5 and Remark 2.5.1, pp.71–73: standard-type mu_(2ell) ambiguity, square labels and independence across labels."),
    dict(path="research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf",
         title="S. Mochizuki, Inter-universal Teichmüller Theory III", version="May 2020 author version",
         url=M+"Inter-universal%20Teichmuller%20Theory%20III.pdf",
         sha256="9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9",
         used_passages="Definition 1.1, pp.23–25; Proposition 1.3, pp.41–43; Propositions 3.1,3.3–3.5, pp.93–106; 3.7–3.9, pp.109–117; Remark 3.9.5(vii), pp.131–134; Theorem 3.11 and Corollary 3.12, pp.153–184. Source links, words, local/global hulls, weighted determinants and the still distinct global comparison."),
    dict(path="research/sources/continuation_2026_08_30/Mochizuki_IUT_IV_April2020.pdf",
         title="S. Mochizuki, Inter-universal Teichmüller Theory IV", version="April 2020 author version",
         url=M+"Inter-universal%20Teichmuller%20Theory%20IV.pdf",
         sha256="5bf4b1e0a8c2686562a6859e5009d301335044cfb5efec5d3a9edf764e4af87f",
         used_passages="Proposition 1.4, p.13; Remark 1.7.1, p.17; Theorem 1.10 and proof, pp.22–30: exact local/word weights and the announced full-hull upper containers."),
    dict(path="research/sources/iut_2026_08_30/Joshi_III_2401.13508v4.pdf",
         title="K. Joshi, Construction of Arithmetic Teichmüller Spaces III",
         version="arXiv:2401.13508v4, stamp February 24, 2025; title-page date February 25, 2025; preprint",
         url="https://arxiv.org/pdf/2401.13508v4",
         sha256="86a92ca893e774e1ea591ed9825a30627f3f19d8df0b26b7f5855dc0923f0429",
         used_passages="Sections 9.7–9.11, pp.111–128: actual cohomology classes and collation, tensor-order normalization, convex/maximal-order distinction and the literal sign mismatch. No claimed global inequality is used as an axiom."),
    dict(path="research/sources/iut_2026_08_30/Joshi_IV_2403.10430v2.pdf",
         title="K. Joshi, Construction of Arithmetic Teichmüller Spaces IV",
         version="arXiv:2403.10430v2, stamp February 24, 2025; title-page date February 25, 2025; preprint",
         url="https://arxiv.org/pdf/2403.10430v2",
         sha256="ef8851fe656c705f7e9881778b4dd0c592c9f35a2980be6a335412a15542547a",
         used_passages="Theorem 6.10.1, Remark 6.10.2 and subsequent estimates, pp.66–71: the two collated families and the middle global equality, distinguished from our fixed-source covariance."),
]

for item in sources:
    file = ROOT / item["path"]
    data = file.read_bytes()
    assert hashlib.sha256(data).hexdigest() == item["sha256"], item["path"]
    reader = PdfReader(file)
    item["bytes"] = len(data)
    item["pdf_pages"] = len(reader.pages)
    item["newly_archived"] = item.get("newly_archived", False)

record = {"verification_date": "2026-08-31", "verified_pdf_count": len(sources),
          "new_primary_pdf_count": sum(s["newly_archived"] for s in sources),
          "reused_pdf_count": sum(not s["newly_archived"] for s in sources),
          "sources": sources}
(RECORD / "source_metadata.json").write_text(
    json.dumps(record, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
lines = ["# Primary source index for the August 31 uniform continuation", "",
         "Author: ChatGPT. Verified August 31, 2026.", "",
         f"{record['new_primary_pdf_count']} new original PDFs and {record['reused_pdf_count']} previously archived PDFs are checked here.",
         "The earlier source catalogues and their exact bytes remain preserved.",
         "These are reading sources; copyrighted source copies are not new deliverables.", ""]
for item in sources:
    lines.extend([f"## {item['title']}", "", item["version"], "",
                  f"[Original source]({item['url']})", "",
                  f"Archive: `{item['path']}`. {item['bytes']} bytes; {item['pdf_pages']} pages.",
                  f"SHA-256: `{item['sha256']}`.", "", item["used_passages"], ""])
lines.extend([
    "## Source boundary", "",
    "The Kenku composite-degree results are used through the explicit completed theorem",
    "in Balakrishnan–Mazur, not described as rederived from Mazur's prime-degree paper.",
    "The source-specific Galois, Kummer, isogeny and Arakelov arguments have the proof",
    "and formalization boundaries stated in the manuscript and research reports.",
    "A typographical sign defect is not an abc or IUT counterexample.", "",
])
(RECORD / "SOURCE_INDEX.md").write_text("\n".join(lines), encoding="utf-8")
print(json.dumps({k: v for k, v in record.items() if k != "sources"}, ensure_ascii=False))
