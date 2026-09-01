# Primary sources for the unbounded power-free Frey family

Research and source verification: 2026-08-30. Index prepared: 2026-08-31.
Author: ChatGPT.

This is a local source index for the report
FREY_POWERFREE_CRT_EXISTENCE_FAMILY_2026_08_30.md and the English input
paper/powerfree_global_family_2026.tex. It does not modify or replace the
shared source manifest. Page numbers below are one-based PDF page numbers
unless explicitly described as printed book or journal pages.

## 1. Xylouris: the effective least-prime bound actually used

- Local file: Xylouris_2009_0906_2749v1_author_preprint.pdf
- Original: [arXiv:0906.2749v1 author PDF](https://arxiv.org/pdf/0906.2749v1).
- Author: Triantafyllos Xylouris.
- Title: Über die Linniksche Konstante.
- Version: diploma thesis submitted 22 April 2009; cover version 12 June
  2009; arXiv v1 posted 15 June 2009.
- Bytes: 822404. Pages: 86.
- SHA256:

      f9505f1dba1d4f3eca2b69f5f25e2395054fde875848a1c9026f10a53a99844c

- Checked locations: p. 6, definition of P(q) as the maximum of the least
  primes in the reduced residue classes; p. 9, Theorem 1.1.
- Mathematical input: P(q) is at most an effective absolute constant times
  q to the power 5.2. The constant is independent of the modulus and
  the reduced class. The report and TeX use 26/5 throughout.
- Both pages were extracted, rendered, and visually checked.
- Proposed bibliography key: XylourisLinnik2009.

The later article is T. Xylouris, On the least prime in an arithmetic
progression and estimates for the zeros of Dirichlet L-functions, Acta
Arithmetica 150 (2011), 65--91,
[DOI 10.4064/aa150-1-4](https://doi.org/10.4064/aa150-1-4).
Its publisher PDF was opened with the web reader: Theorem 1.1, printed
p. 66, gives the stronger exponent 5.18. Direct archival downloads
returned HTTP 502. No local file is represented as that journal version,
and no step here depends on the stronger exponent.

## 2. Mochizuki: the original compactly bounded definition

- Local file:
  Mochizuki_2010_Arithmetic_Elliptic_Curves_General_Position_author.pdf
- Original: [author PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Arithmetic%20Elliptic%20Curves%20in%20General%20Position.pdf).
- Author: Shinichi Mochizuki.
- Title: Arithmetic Elliptic Curves in General Position.
- Version: February 2009 author version; publication in Mathematical
  Journal of Okayama University 52 (2010), 1--28.
- Bytes: 262332. Pages: 25 in this author PDF.
- SHA256:

      b9dc115af61dca7fe434332ebafddf6a376a9e2926dad4e1ea2dcc0d2441f768

- Checked locations: Example 1.3(ii), pp. 5--6.
- Mathematical role: the nonarchimedean compactness requirement is on
  intersections with each finite local extension. The full set in a local
  algebraic closure is not asserted to be compact.
- Both pages were extracted, rendered, and visually checked.
- Proposed bibliography key: MochGeneralPosition.

## 3. Existing archive: Joshi IV v2

- Local file, relative to the repository root:
  research/sources/iut_2026_08_30/Joshi_IV_2403.10430v2.pdf
- Original: [arXiv:2403.10430v2](https://arxiv.org/pdf/2403.10430v2).
- Author: Kirti Joshi.
- Version: arXiv v2 dated 24 February 2025; cover date 25 February 2025.
- Bytes: 1105416. Pages: 80.
- SHA256:

      ef8851fe656c705f7e9881778b4dd0c592c9f35a2980be6a335412a15542547a

- Checked locations: section 5.1, p. 50, literal compact-domain wording;
  section 5.6 and Theorem 5.7.1, p. 53, the bound on the 2-adic
  j-invariant, the numerical level window, and the finite-exception and
  existential-prime quantifiers.
- Pages 49--53 were read by extraction; pp. 50 and 53 were also rendered
  and visually checked.
- Scope: the report does not silently equate this literal topological
  wording with the original finite-extension-section definition. It also
  does not identify its constructed level prime with the existentially
  selected prime of Theorem 5.7.1.
- Existing bibliography key: JoshiIV.

## 4. Existing archive: Kedlaya's Tate-curve notes

- Local file, relative to the repository root:
  research/sources/galois_lift_2026_08_30/Kedlaya_2004_Tate_Curve.pdf
- Original: [author lecture notes](https://kskedlaya.org/18.727/tate-curve.pdf).
- Author: Kiran S. Kedlaya.
- Title: Introduction: the Tate curve, MIT course 18.727, Fall 2004.
- Bytes: 108729. Pages: 6.
- SHA256:

      92a836142364d520c947884b24dead6253901e842f10000ec883298662d752dd

- Checked locations: Theorems 1--2, pp. 3--4, Tate uniformization and the
  split multiplicative criterion; Proposition 3, p. 5, a nontrivial
  inertia transvection when the prime level does not divide the Tate
  valuation.
- Application: the family has residue prime p different from its level
  ell, native valuation four, and ell at least 43. Thus the nontrivial
  transvection has order ell. No subgroup-classification or unspecified
  large-image theorem is used.
- Agreed bibliography key: KedlayaTate.

## 5. Existing archive: Silverman's elliptic-curve text

- Local file, relative to the repository root:
  research/sources/global_uniform_gate_2026_08_30/Silverman_2009_Arithmetic_of_Elliptic_Curves_2nd.pdf
- Original PDF location:
  [The Arithmetic of Elliptic Curves, second edition](https://www.pdmi.ras.ru/~lowdimma/BSD/Silverman-Arithmetic_of_EC.pdf).
- Author: Joseph H. Silverman.
- Publication: Graduate Texts in Mathematics 106, Springer, second
  edition, 2009.
- Bytes: 3658085. Pages: 522.
- SHA256:

      72ee67bfa1e3fdf582ac7e4b032d7ca0b35a168ed6443ac39c121fbb788cab25

- Specific inputs:
  - Chapter VII, Proposition 5.1, printed p. 196 = PDF p. 212:
    reduction and minimal invariants.
  - Chapter VII, Proposition 5.5, printed p. 197 = PDF p. 213:
    integral j-invariant and potential good reduction.
  - Chapter VII, Theorem 7.1, printed p. 201 = PDF p. 217:
    the Neron--Ogg--Shafarevich criterion.
  - Chapter V, section 2, and Chapter VII, section 4:
    the good-reduction Frobenius polynomial determined by the finite
    point count.
  - Appendix C, Theorem 14.1(a)--(b), printed p. 445 = PDF p. 456:
    Galois-equivariant Tate uniformization.
- The report supplies its own proof that the finite inertia image after
  adjoining 3-torsion is trivial, using torsion-freeness of
  1 + 3 Mat(2,Z_3). The cited good-reduction criteria then apply to the
  particular field L_A, without an unspecified further extension.
- Existing bibliography key: Silverman.

## 6. Reproducibility and mathematical scope

Source-reading images are in
tmp/pdfs/frey_powerfree_sources_2026_08_30/. They are disposable aids;
the hashed originals above are the source of record.

The effective sieve uses only the archived exponent 5.2 and elementary
root lifting and interval counting. The uniform constants are fixed
before ell varies. The family avoids every fixed finite parameter or
moduli set because its rational heights tend to infinity; this does not
assert avoidance of a separately moving set or satisfy a theorem's
existential level quantifier by substitution.

The separate initial-theta-data review for the concrete level-43 curve
uses another source directory and is not silently included as a theorem
about every member of this family. No abc counterexample, full pilot
identification, or new Lean formalization of the external source theorems
is claimed by this index.
