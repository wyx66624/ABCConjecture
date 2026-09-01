# Original-source evidence for the arithmetic-geometry audit

Retrieved and checked on 30 August 2026. These are unchanged original PDFs,
not generated research articles. Filenames are relative to this directory.

| File | Original source and version | Relevant location |
|---|---|---|
| `Berczes_Evertse_Gyory_2013.pdf` | [Publisher PDF](https://publi.math.unideb.hu/paper/1797/download/10_5486_PMD_2013_5748.pdf), [DOI 10.5486/PMD.2013.5748](https://doi.org/10.5486/PMD.2013.5748) | Theorem 2.2 and the definitions before it, printed p. 730; constants, coefficient height, and the specialization to integral variables over Q |
| `Pasten_Cubo_2026_small_j_denominator.pdf` | [Published PDF](https://www.scielo.cl/pdf/cubo/v28n2/0719-0646-cubo-28-02-383.pdf), [DOI 10.56754/0719-0646.2802.383](https://doi.org/10.56754/0719-0646.2802.383), Cubo 28(2), 383–389, May 2026 | Theorem 1.2 and Corollary 1.3; the fixed small-denominator hypothesis is essential |
| `Pasten_2026_08_24_2608_23559v1.pdf` | [Pinned arXiv PDF](https://arxiv.org/pdf/2608.23559v1), submitted 24 August 2026 | Theorem 1.3: Mordell point height; Theorem 1.6: integral-j curve height; Theorem 1.8: irreducible binary cubic hypothesis |

## SHA-256 verification values

```text
CA72086C6DC27557E37682123D89BF255A5D951273E1A279B081CDEC9970E560  Berczes_Evertse_Gyory_2013.pdf
5FA700F13662C9963FB3088B0FEA30EA5B4DBBB06973EBE74D7AD79B48F8A032  Pasten_Cubo_2026_small_j_denominator.pdf
8D37EE54D852D00122D1EE311D01A5A47BD7E4C31125D99A863F38C19B11AAC2  Pasten_2026_08_24_2608_23559v1.pdf
```

The published effective integral-point theorem is used in the mathematical
proof. Its numerical consequences in Lean keep the relevant height bounds
as explicit hypotheses. Neither it nor the August preprint has been silently
introduced as a new Lean axiom. The integral map, integer square-factor
descent, and Frey denominator inequalities have separate kernel-checked
proofs. See `research/ARITHMETIC_GEOMETRY_SESSION_2026_08_30.md` for the exact
substitutions and remaining obligations.
