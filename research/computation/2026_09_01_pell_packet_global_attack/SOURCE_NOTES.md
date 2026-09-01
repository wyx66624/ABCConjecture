# Source notes and exact quantifiers

Checked on 2026-09-01.  Search snippets were used only to locate papers.  Every
literature statement used in `REPORT.md` was checked in the paper itself or in
the already audited source bundle named below.

## Fellini--Murty (new input in this stage)

Nic Fellini and M. Ram Murty, *Wieferich primes in number fields and the
conjectures of Ankeny--Artin--Chowla and Mordell*, Journal of Number Theory
**285** (2026), 209--229, DOI
<https://doi.org/10.1016/j.jnt.2026.01.002>.

* Open author PDF used for inspection:
  <https://www.mast.queensu.ca/~murty/aacm.pdf>.
* Stable repository file:
  `research/sources/pell_packet_global_attack_2026_09_01/Fellini_Murty_2026_aacm.pdf`.
* Byte-identical working copy: `Fellini_Murty_2026_aacm.pdf` in this
  artifact directory.
* SHA-256:
  `104e9e6f3992e751a08f8af564857d9820e944ade1e178c3ba5ce07827faab4c`.
* Exact definition (paper pp. 211 and 225): for an algebraic number field
  `K`, an admissible base is a nonzero `alpha in O_K` which is not a root of
  unity.  A prime ideal `p` is base-alpha Wieferich (respectively
  super-Wieferich) when
  `alpha^(N(p)-1) = 1 mod p^2` (respectively modulo `p^3`).
* Exact imported theorem: Theorem 2.3, proved again as Theorem 8.1, says that
  **if there are finitely many base-alpha super-Wieferich prime ideals, then
  there are infinitely many base-alpha non-Wieferich prime ideals**.  It is
  unconditional; it uses Siegel's theorem, not abc.
* Extra proof information used: Section 8 chooses an infinite set `T` of
  rational prime cyclotomic indices `ell`.  For every prime ideal dividing
  `C_ell=(Phi_ell(alpha))`, Lemma 6.4 and the exclusions defining `T` force
  `f_alpha(p)=ell`.  This supports the prime-order refinement proved in
  `REPORT.md`; that refinement is our deduction from the published proof and
  is not quoted as the literal statement of Theorem 2.3.

The extracted text `Fellini_Murty_2026_aacm.txt` is retained solely to make
the checked locations searchable.  The PDF is the authoritative local copy.

## Previously audited inputs

Carlo Sanna, *The p-adic valuation of Lucas sequences*, Fibonacci Quarterly
**54**(2) (2016), 118--124.

* Official PDF: <https://www.fq.math.ca/Papers1/54-2/Sanna02242016.pdf>.
* Repository file:
  `research/sources/pell_squarefull_deep_2026_08_31/Sanna_2016_p_adic_valuation_Lucas.pdf`.
* SHA-256:
  `094cda071af2d905fae8667fa498bcd16e6768a6f9004c005e5abcb6b30c30f0`.
* Exact use: Theorem 1.5 and Corollary 1.6 specialize to
  `v_q(u_n)=e(q)+v_q(n/z(q))` when `z(q)|n`, for odd `q` in
  `U_n(6,1)`.  They propagate the first exponent and do not bound it.

U. K. Dutta, B. K. Patel, and P. K. Ray, *A brief remark on
balancing-Wieferich primes*, Mathematica **60**(83), no. 1 (2018), 48--53,
DOI <https://doi.org/10.24193/mathcluj.2018.1.05>.

* Journal PDF:
  <https://math.ubbcluj.ro/~mathjour/fulltext/2018-1/dutta-patel-ray.pdf>.
* Repository SHA-256:
  `ffe96a4331429931e9875f2964ef2e3e7f127bc850fdad8e06057c71b219838c`.
* Exact use: their normalization calls an odd rational prime `q`
  balancing-Wieferich when
  `q^2 | u_(q-(8/q)) = u_(q-(2/q))`.  Their finite list is not imported as a
  completeness result.

J. H. E. Cohn, *Perfect Pell Powers*, Glasgow Mathematical Journal **38**
(1996), 19--20, DOI <https://doi.org/10.1017/S0017089500031207>.

* Repository SHA-256:
  `f911aabfa404f64792891f8a5d96159454a41288b5415813e355aa9fc7b1eeb3`.
* Exact inherited use: the standard Pell sequence has no non-square perfect
  powers at nontrivial indices; together with the cited theorem of Ljunggren,
  its only perfect-power values are `0,1,169`, with `P_7=169`.

J. H. E. Cohn, *The Diophantine equation x^n=Dy^2+1*, Acta Arithmetica
**106** (2003), 73--83, DOI <https://doi.org/10.4064/aa106-1-5>.

* Official article page:
  <https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/106/1/81995/the-diophantine-equation-x-n-dy-2-1>.
* Exact inherited use: Section 6, Theorem 6.1 says that the associated Pell
  recurrence `Q_0=Q_1=1`, `Q_(n+2)=2Q_(n+1)+Q_n` has only the
  perfect-power value `1`.  This is the `A_n` sequence in the report.

Y. Bilu, G. Hanrot, and P. M. Voutier, *Existence of primitive divisors of
Lucas and Lehmer numbers*, J. reine angew. Math. **539** (2001), 75--122,
DOI <https://doi.org/10.1515/crll.2001.080>.

* Repository source SHA-256:
  `7394f551d71c49de5f204819f0cb38184d463c3488c6fc9f3ac832603d20c4a1`.
* Exact contextual statement: Theorem 1.4 supplies a primitive divisor for
  every Lucas or Lehmer term of index greater than 30.  It does not state
  that the primitive divisor has valuation one.  The report gives explicit
  primitive repeated divisors showing why that extra inference is false.

## Repository inputs inspected

* `research/ABC_PELL_PRIME_INDEX_DICHOTOMY_2026_08_31.md`, SHA-256
  `e00df6b1935319b1dc1bcab909ce83ef6b3d605de108c7b819a05c508549d76b`.
* `Lean/IUTThreeClosures/PellPrimeIndexDichotomy20260831.lean`, SHA-256
  `66aaa47b66285990d64eb9bdab7f17fe8d3fbed16b8928816c04da237647739e`.
* `Lean/IUTThreeClosures/PellSquareRootDescent20260831.lean`, SHA-256
  `ce9868c50f375b00716eecc1344bfa63c0b5e41afc73e4c72c83000e0c7c077b`.
* `Lean/IUTThreeClosures/PellAdjacentFactorCounterexample20260831.lean`,
  SHA-256
  `07569e80aa0d361bfbc2ce672f4f60b457853449f9ebd3127be0a490126122cf`.

No shared research report or Lean source was edited in this stage.
