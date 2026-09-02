# Source notes: prime-layer Mersenne radical attack

Access date for all network sources: 2026-09-01.

## Erdős--Shorey (1976)

- Archived file: `Erdos_Shorey_1976_greatest_prime_factor.pdf`
- Title: *On the greatest prime factor of \(2^p-1\) for a prime \(p\) and
  other expressions*
- Authors: P. Erdős and T. N. Shorey
- Journal: *Acta Arithmetica* 30 (1976), 257--265
- DOI: <https://doi.org/10.4064/aa-30-3-257-265>
- Official landing page:
  <https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/30/3/101030/on-the-greatest-prime-factor-of-2-p-1-for-a-prime-p-and-other-expressions>
- License shown by the official page: CC-BY.
- Relevant evidence: the first page states that
  \(P(2^p-1)/p\) exceeds a constant times \(\log p\) for primes \(p\).
- `Erdos_Shorey_1976_page_257_render.png` is a 150-dpi render of that first
  scanned page.  It is included because the PDF has no usable text layer.

## Ford--Luca--Shparlinski (2009)

- Archived files: `Ford_Luca_Shparlinski_2009_largest_prime_factor.pdf` and
  its pypdf text extraction.
- Title: *On the largest prime factor of the Mersenne numbers*
- Authors: Kevin Ford, Florian Luca, and Igor E. Shparlinski
- Journal: *Bulletin of the Australian Mathematical Society* 79 (2009),
  455--463
- DOI: <https://doi.org/10.1017/S0004972709000033>
- Author-hosted PDF used for the archive:
  <https://www.ford126.web.illinois.edu/wwwpapers/P2n-1.pdf>
- Official Cambridge record:
  <https://www.cambridge.org/core/journals/bulletin-of-the-australian-mathematical-society/article/on-the-largest-prime-factor-of-the-mersenne-numbers/BDD36EA7E350D8A73C9741DE93AADDE1>
- Relevant evidence: extracted text lines 36--41 restate the
  Stewart/Erdős--Shorey theorem as
  \(P(2^p-1)>c p\log p\) for all sufficiently large primes \(p\).

## Cambraia--Knapp--Lemos--Moriya--Rodrigues (2021 revision)

- Archived files: `Cambraia_et_al_2021_prime_factors_Mersenne.pdf` and its
  pypdf text extraction.
- Title: *On prime factors of Mersenne numbers*
- arXiv:1606.08690v5, 27 April 2021
- Primary record: <https://arxiv.org/abs/1606.08690>
- Relevant context: extracted text lines 89--92 record the consequence of
  Mihăilescu's theorem that \(2^m-1\) is not a nontrivial perfect power for
  \(m>1\).  The report and Lean module instead use a self-contained elementary
  proof of this special case, so this source is contextual rather than a
  logical dependency.

## Murty--Wong (2002)

- Archived files: `Murty_Wong_2002_ABC_Lucas_Lehmer.pdf` and its pypdf text
  extraction.
- Title: *The ABC conjecture and prime divisors of the Lucas and Lehmer
  sequences*
- Authors: M. Ram Murty and Siman Wong
- Publication: *Number Theory for the Millennium, III* (Urbana, IL, 2000),
  A K Peters, 2002, 43--54; MR 1956267.
- Author-hosted primary manuscript:
  <https://mast.queensu.ca/~murty/murty-wong.pdf>
- Relevant evidence: page 5 states that a prime divisor of
  \(\Phi_d(a,b)\) is congruent to one modulo \(d\), except for the largest
  prime factor of \(d\), and that this exceptional divisor occurs to at most
  the first power.  Pages 6--7 define the powerful part and show how the
  Brun--Titchmarsh and totient bounds enter their conditional argument.

## Erdős--Murty (1999)

- Archived file: `Erdos_Murty_1999_order_mod_p.pdf` (the author copy is a
  scan and has no usable text layer).
- Title: *On the order of \(a\pmod p\)*
- Authors: P. Erdős and M. Ram Murty
- Publication: *Number Theory* (Ottawa, ON, 1996), CRM Proceedings and
  Lecture Notes 19, American Mathematical Society, 1999, 87--97.
- Author-hosted primary scan:
  <https://mast.queensu.ca/~murty/erdos-ram.pdf>
- Relevant evidence: for each prescribed positive function
  \(\epsilon(p)\to0\), Theorem 1 gives
  \(\operatorname{ord}_p(a)\ge p^{1/(2+\epsilon(p))}\) outside
  \(o(x/\log x)\) primes \(p\le x\).  It places the extreme large-prime arm of a failed
  exact-order estimate inside a zero-density exceptional prime set; it does
  not bound weighted mass on that set.

## Fellini--Murty (2026)

- Archived files: `Fellini_Murty_2026_Wieferich_number_fields.pdf` and its
  pypdf text extraction.
- Title: *Wieferich primes in number fields and the conjectures of
  Ankeny--Artin--Chowla and Mordell*
- Authors: Nic Fellini and M. Ram Murty
- Journal: *Journal of Number Theory* 285 (2026), 209--229.
- DOI: <https://doi.org/10.1016/j.jnt.2026.01.002>
- Primary preprint record: <https://arxiv.org/abs/2508.08472v2>
- Relevant evidence: the introduction explicitly says that no unconditional
  almost-all non-Wieferich theorem is known for a fixed integral base.  Their
  Theorems 1.3--1.4 obtain infinitely many non-Wieferich primes, with a
  logarithmic lower count, under finiteness of super-Wieferich primes; those
  results do not control weighted mass inside one exact-order block.

## Pomerance (2025)

- Archived files: `Pomerance_2025_Cyclotomic_Primes.pdf` and its pypdf text
  extraction.
- Title: *Cyclotomic primes*
- Author: Carl Pomerance
- Journal: *Journal of Number Theory* 276 (2025), 198--208.
- DOI: <https://doi.org/10.1016/j.jnt.2025.02.013>
- Author final manuscript:
  <https://math.dartmouth.edu/~carlp/cyclotomicprimesfinal.pdf>
- Relevant evidence: Section 2 identifies primitive divisors of
  \(\Phi_m(2)\) with exact order \(m\), and shows that every intrinsic
  divisor occurs to exactly the first power.  It also records
  \(2^{\varphi(m)-1}\le\Phi_m(2)<2^{\varphi(m)+1}\).  Theorem 1 proves
  compositeness results for many primitive parts, while the stronger
  distinct-factor statement in Theorem 2 is abc-conditional.  A bounded
  number of simple factors does not provide the near-full radical required
  by the present block-mass target.

## Murty--Séguin (2019)

- Archived files: `Murty_Seguin_2019_Cyclotomic_Wieferich.pdf` and its pypdf
  text extraction.
- Title: *Prime divisors of sparse values of cyclotomic polynomials and
  Wieferich primes*
- Authors: M. Ram Murty and François Séguin
- Journal: *Journal of Number Theory* 201 (2019), 1--22.
- DOI: <https://doi.org/10.1016/j.jnt.2019.02.016>
- Author-hosted primary article:
  <https://mast.queensu.ca/~murty/murty-seguin-jnt.pdf>
- Relevant evidence: Propositions 2.5--2.6 identify the valuation of an
  exact-order cyclotomic factor with the canonical valuation
  \(v_p(a^{\operatorname{ord}_p(a)}-1)\).  Lemmas 4.2--4.3 identify
  Wieferich and super-Wieferich primes with square and higher-power divisors
  of the unique exact-order cyclotomic value.  Theorem 2.4 states the weighted
  Brun--Titchmarsh input used by the adaptive small-support estimate.
  Theorem 1.1 gives only a polynomial largest-prime bound under uniformly
  bounded canonical valuations; that does not control the repeated-prime
  tail or imply near-full radical saturation.

## Integrity

`SHA256SUMS` records every archived source and generated metadata file except
itself.  Text extraction is provided for searchability and must be checked
against the PDF when typography matters.

To re-download the eight primary PDFs into a separate directory, run from
the repository root:

```powershell
& research/sources/mersenne_prime_layer_radical_2026_09_01/RETRIEVE_SOURCES.ps1 `
  -Destination tmp/mersenne_prime_layer_sources
```

The script prints the hashes of the retrieved PDFs.  Compare them with this
directory's `SHA256SUMS`; publisher-side byte changes do not by themselves
mean that the mathematical content changed.
