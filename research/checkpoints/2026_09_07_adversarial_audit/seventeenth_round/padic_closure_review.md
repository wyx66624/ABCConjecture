# Independent audit of QL1--QL4

Status: full ordinary proof and primary-source review PASS, after the precise
QL3 correction below. Reviewed source:
`../../2026_09_07_independent_route/seventeenth_round/padic_closure_entry.md`,
SHA256 `e54c52e6a8554d01de7f33668e750fa59a87585ba688c149262610b7fdbd992d`.
No Lean proof or rational-point classification is asserted by this review.

## Mathematical checks

* QL1: the integral invariant differential gives a logarithm on 5 Z5. For
  each degree n >= 2, n-v5(n) >= 2 and n-1-v5(n) >= 1 give respectively
  the mod-25 statement and strict contraction. Thus the logarithm is a
  bijective topological group map, not merely a formal series identity.
  The exact ninth multiples have parameter valuation one and the specified
  unit residues. Their integer multiples are dense in the formal kernels.
  The order-nine reduction images supply all nine cosets, so the closure
  is the entire local elliptic group in each case.
* QL2: rational torsion injects into the order-nine reduction group because
  the formal kernel is torsion-free. The previously proved GD absence of
  rational 3-torsion and the rational isogeny bijection eliminate torsion.
  If P=5R locally, then 9R lies in the formal kernel and log(9P) would lie
  in 25 Z5, a contradiction. Rank one now gives finite global index prime
  to five, without proving index one at other primes.
* QL3: all six quotient images at A and the two infinities were independently
  checked by substituting the exact EQ rational maps and taking their leading
  terms. They give Phi(D1)=(0,2P') and Phi(D2)=(-2P,2P'). The initial sentence
  treating their integer matrix as an automorphism of two different elliptic
  groups was not well typed. The author corrected this: the image subgroup
  is exactly 2 ZP x 2 ZP', using D1 and D2-D1. This is dense factor by factor.
  The final corrected paragraph was actually reread before this PASS.
* The local isogeny argument includes both directions: the kernel of Phi is
  killed by two; [2] is bijective on the formal kernel and odd-order reduction
  group of J, and on both elliptic groups. Phi is therefore a bijective
  continuous map of compact Hausdorff groups. This checks its cokernel as
  well as its differential. The exact J(F5) order is 81.
* Global torsion of J vanishes by Phi and the absence of local 2-torsion.
  Applying Phi to 5D=mD1+nD2, the already proved elliptic five-saturation
  gives 5|n and 5|(m+n). Removing the corresponding rational integer
  combination proves actual five-saturation. Independence and rank two
  then give a finite global index prime to five. The normalized logarithm
  matrix has determinant 2 modulo five; its unnormalized determinant has
  valuation exactly two in the stated product coordinates.
* QL4: the rational group closure has index one, discharging the additional
  closure hypothesis in BD Theorem 1.2 for this H. The rank, Neron--Severi
  rank over Q, basepoint and good reduction were separately checked in the
  QH review. Height/log-squared ratios on a rank-one rational group do not
  require proving that the displayed infinite-order points are generators.

## Primary sources actually inspected

[Milne, Elliptic Curves](https://www.jmilne.org/math/Books/EC2.pdf), II.2.7,
printed p.54 (PDF p.58), constructs the integral formal group. II.4.1--4.2,
printed pp.62--64, supplies the reduction filtration and prime-to-p
multiplication; Aside II.4.4, printed p.65 (PDF p.69), identifies the formal
kernel. Milne uses x/y; replacing it by -x/y changes the formal parameter
without changing the assertions. The logarithm/contraction proof needed
here is supplied in QL, rather than attributed to a numerical routine.

[Balakrishnan--Dogra, Quadratic Chabauty and rational points I](https://arxiv.org/pdf/1601.00388),
the actually opened v2 PDF, Theorem 1.2 (printed p.4), Corollary 8.1 and
Algorithm 8.3 (printed pp.32--33), were inspected. Theorem 1.2 has the
closure hypothesis just discharged. The even-sextic algorithm has a model
normalization requirement: although H(s) is monic, its displayed even chart
with leading coefficient -9 cannot be substituted without checking that
normalization. The final QL wording preserves this restriction.

## Exact finite evidence and boundaries

The author script `replay_padic_entry.py` was fully read and actually run
with `--check`. It passed with certificate SHA256
`2bc0673769cc10abba959725e1683676d162918afa7fbf89a463f664c9b24696`.
Both ninth multiples were also recomputed independently by binary rational
doubling/addition and matched exactly. The author replay covers complete
finite elliptic tables, exact coordinates and valuation/unit tests, the
F25 hyperelliptic count and integer matrix arithmetic. Its divisor-image
matrix is supplied explicitly; the projective image check is the separate
ordinary substitution above, not a hidden claim about the program.

No local-height value sets, Coleman functions, complete analytic zero sets,
Mordell--Weil sieve, global generators or complete rational points have
been calculated here. The finite pullback container for the genus-six D
remains distinct from an intrinsic genus-six quadratic Chabauty locus.
The common second-root and positivity gates, and the varying-exponent,
residual-coefficient and ABC uniform-height questions, remain open.
