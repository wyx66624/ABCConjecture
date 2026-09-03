# Primary-source audit: Mersenne Farey denominator entropy

Access date: 2 September 2026.

## Newly archived primary sources

- Igor E. Shparlinski, *Fermat quotients: exponential sums, value set and
  primitive roots*, arXiv:1104.3909.  Source record:
  <https://arxiv.org/abs/1104.3909>; archived PDF endpoint:
  <https://arxiv.org/pdf/1104.3909>.  The large-sieve result is averaged over
  moduli and concerns short sums/value sets.  It does not upper-bound the
  fixed-base zeros `q_p(2) = 0 mod p^2`.
- François G. Dorais and Dominic Klyve, *A Wieferich prime search up to
  6.7 x 10^15*, Journal of Integer Sequences 14 (2011), Article 11.9.2.
  Primary journal PDF:
  <https://cs.uwaterloo.ca/journals/JIS/VOL14/Klyve/klyve3.pdf>.  The paper
  reports that 1093 and 3511 are the only base-two Wieferich primes below the
  stated limit.  This is finite computational evidence.
- Nicholas M. Katz, *Wieferich past and future*, Contemporary Mathematics
  632 (2015), 253--270.  Author-hosted copy:
  <https://web.math.princeton.edu/~nmk/wieferich38.pdf>.  Its random model is
  used only as motivation; none of its conjectural equidistribution is used
  as a premise.
- R. Laniewski, *Radical defects, Wieferich primes, and the abc conjecture*,
  arXiv:2609.00039v1 (submitted 29 August 2026).  Official record:
  <https://arxiv.org/abs/2609.00039>; archived PDF endpoint:
  <https://arxiv.org/pdf/2609.00039>.  It reduces Mersenne transgression to
  ordinary-Wieferich order--defect growth but explicitly leaves that growth
  open; it does not prove the fixed-base depth-three count needed here.

Each PDF has a UTF-8 `pypdf` extraction beside it for searchability.  The PDF
is authoritative where formulas or typography differ.

## Existing archived primary sources rechecked

- Erdős--Murty (1999), Murty--Séguin (2019), and Fellini--Murty (2026) in
  `research/sources/mersenne_prime_layer_radical_2026_09_01/`.
- Yamada (2010) and Li--Zhao (2026) in
  `research/sources/mersenne_balanced_multiplier_depth_2026_09_01/`.
- Falk--Harrington--Jones, *Generalized Wieferich primes and monogenic
  trinomials*, arXiv:2607.29329v1, official record
  <https://arxiv.org/abs/2607.29329>.  Its individual-prime monogenicity
  criteria do not give a Wieferich counting theorem.

The exact quantifier audit is recorded in
`research/ABC_MERSENNE_FAREY_DENOMINATOR_ENTROPY_2026_09_02.md`.  None of
these papers proves a fixed-base super-Wieferich counting bound with
logarithmic exponent at most one half.  Results conditional on abc or on
finiteness of super-Wieferich primes are not used in the unconditional
theorems.

## Integrity

`SHA256SUMS` covers the newly archived PDFs, text extractions, this audit, and
`source-metadata.json`, but not itself.
