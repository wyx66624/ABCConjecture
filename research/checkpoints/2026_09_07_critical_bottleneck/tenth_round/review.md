# Tenth-round review ledger

Root and adversarial_audit both read `full_mass_tail_location.md`, FM1--FM3,
in full and approved its ordinary proof. They checked the sum beginning at
depth one, the unchanged cap discrepancy, the two rank-progressions and
harmonic main term, all constants 6 and 36, the all-index divisor bounds,
the separate all-prime LR2 treatment of 2 and 3, the actual Markov
quantifiers, and the prime-index rank-one removal bounded by 3/n. The
conclusion is full valuation mass, not signed cost or radical size.

I read adversarial_audit's `tenth_round/three_arm_private_depth.md`,
TD1--TD5, and its `replay_three_arm_depth.py` in full. Ordinary proof and
replay scope PASS. The elementary cyclotomic construction really gives
three distinct primes with exact order 6n; its argument uses q not
dividing 6n and separability, not Dirichlet density. The three raw target
ratios have the right n-th powers and cube order n. Their orders exclude
the input arms zero and minus one, and the inverse formula lies on the
norm-unit locus. I checked the n=5 modulo 6 interchange of the first and
third normalized arms. The derivative, integer quotient simplicity,
exact Hensel choice at depth s but not s+1, and simultaneous CRT preserve
every explicit antecedent. The actual root has coordinate gcd one and
norm one modulo three. All selected depths are private and new, and the
cutoff comparison is uniform as n varies.

The selected positive contribution satisfies the stated strict bound
because a>=M0, Q>a^2 and t_height>n log a. This supplies a counterexample
only to automatic two-cubefree-arm membership. It does not fix the other
prime factors or their negative credits and does not refute any complete
signed budget. The replay deliberately checks selected depths without
claiming full factorization or simultaneous pure second norms.

I actually ran the supplied TD replay in read-only `--check` mode. It
passed five parameter rows, ten actual roots and thirty selected-depth
checks with byte SHA256
`71c8e1d1aa54ecef4048ca2ba05ded94e8efdce60a00b25e7fe707283e1ec0fe`.

Both root and adversarial_audit read `reciprocal_depth_compensation.md`,
RC1--RC4, completely and approved its ordinary proof. They checked the
negative-coefficient height costs, the exact retained radical terms, the
uniform bounds A<=6 and B<=2, the input-height coefficient (2A+3)/n,
all five maximal patterns and their complete classification, and the
explicit abstract finite-ledger sharpness family. That last family
does not assert the actual additive or norm relations and excludes no
actual arithmetic route.

I read independent-route `tenth_round/mixed_exponent_covers.md`, MX1--MX4,
in full and approved its ordinary proof. The actual first coefficient
has precisely the inverse u^2*zeta^e*v/bar(v), height log(V0)/2, with
no extra h-unit-class ambiguity. Counting all residual elements of norm
at most X costs CX once. Disjoint geometric branch sets give trivial
intersection of the two Galois function-field extensions, so degree
hg^3 and the stated genus do not require coprime exponents. The fixed
number of coefficients, actual quartic g^9 lift count, exponent 17 in
the second residual sum and coefficient-height/point-height separation
are all correct. No point-height upper bound is inferred.

I read the complete final TD TeX transcription and approved it, including
the new cap-union corollary. Every valid finite cap in that actual family
is at least four, so the reciprocal sum is at most three quarters even
when the caps can be selected for each root. This does not refute the
net-credit criteria. I also read the complete final MX TeX: the added
actual exclusion of norm primes 2,3,5 supplies Q>=7 for its QC reference,
and inversion of the three second coefficients preserves both heights
and count. Final MX transcription PASS.

`ReciprocalDepthArithmetic.lean` passed a fresh scoped Lake build with
seventeen new and seventy-one dependency declarations, complete axiom
inventory, warnings treated as errors and only the standard three
axioms. Adversarial_audit actually read every source signature and proof
and approved its complete scope, including the exact finite cap bridges,
canonical discharged height interfaces and the one/two/three-finite-cap
iff classifications. Source SHA256:
`ec42e21085ad65c1a3ffdd939a742a0f5276c728ff4ca8a564b3d79c8d1e934c`.
The finite cap arithmetic does not define actual prime logarithms or
assert membership. Final RC and FM TeX transcription review is pending.

I read independent-route `double_oriented_covers.md`, DC1--DC4, completely
and approved the ordinary proof. The exact second norm identity and
gcd(ab,M)=1 give an actual primitive unramified element ab+M*zeta. Its
oriented factorization transfers the numerical root and residual norms
without an enlarged field or exponent-dependent unit-class ambiguity.
The polynomial G/zeta has discriminant -1-3*zeta of norm thirteen; its
four simple zero/pole branches are disjoint from the first ratio's two
branches. This gives degree hg and genus 1+2hg-g-2h by the stated
geometric Galois intersection and Riemann--Hurwitz argument. The actual
residual lattice counts, exact half-log coefficient heights and the
point-height lower bound uniform in max(h,g) all check. No actual
point-height upper bound follows. I additionally noted that the g-free
restriction on V1 is unnecessary for this particular oriented
factorization: the equality E_q=v_q(V1)+g*v_q(Q) defines the same actual
v1,w1 even for a noncanonical residual. Removing that restriction
requires no change in its height or counting proof.

I read the final `double_oriented_covers.tex` completely. Final DC
transcription PASS, including the now unrestricted noncanonical residual,
the exact oriented allocation, all six branch points, geometric degree hg,
the genus, actual K0 points, the cumulative count CX0X1, and the coefficient
height bound without an exponent term. The last separation statement
keeps both its actual-profile antecedent and its missing uniform point
upper bound explicit.

Independent_route additionally read all seventeen signatures and proofs
of ReciprocalDepthArithmetic.lean and approved their source and scope,
with the same final SHA. This is a second independent source review;
it is not recorded as an additional fresh compilation.

I read the added final-actual-state assertions in the TD replay: the final
CRT representative and its actual ratio/cube order are rechecked. These
assertions strengthen implementation coverage without changing the
canonical output. The author reran --check with the unchanged byte SHA;
my earlier independent complete run remains the independent runtime
record, and I do not claim another run for this read-only tiny addition.

I read independent-route `rational_map_descent.md`, RD1--RD3, completely.
Ordinary proof PASS. The rho conjugacy fixes both branch values even
with arbitrary nonzero tau. The composite rational map has exactly the
three branch values infinity, one third and minus one, disjoint from
those of the second power map. The local projective smoothness argument
therefore works above every base value. The finite-fiber argument
excludes hidden components, while the DC generic field supplies
geometric connectedness. The actual rational points, bidegree, genus
and the larger expanded coefficient-height budget all check. I actually
opened the cited primary Stacks pages and checked Lemma 53.2.2, Theorem
53.2.6 and the characteristic-zero formula in Section 53.12:
https://stacks.math.columbia.edu/tag/0BXX
https://stacks.math.columbia.edu/tag/0C1B
The sparse quadratic-field height bound is not asserted for the expanded
rational equation.

Adversarial_audit read `elementary_block_inputs.md`, EA1--EA3, completely
and approved its ordinary proof. Reviewed source SHA256:
`b6e7897bffa69995e8fbca2014de17b3f3146e88e1d2d6e6a1e78c219c19ef7b`.
The angular interval and cubic constant, the bound Delta/t<=4/n, the
normalized binomial lifting proof at both 2 and ramified 3, the exact
T2 factorization, and small-prime mass bound 20/n all passed. This
replaces the logarithmic-form inputs in the actual B>=n mass-location
argument, retaining Brun--Titchmarsh and the explicit exceptional set.

The author actually ran `replay_elementary_block.py`: PASS on 571 actual
rows and 1142 exact valuation equalities at indices one through 96,
with B=n,n^2,n^4 and both interval endpoints. It also checks exact norm
and integer height prerequisites. It does not use floating-point angular
inequalities as proof and does not completely factor the boundaries.
Canonical JSON byte SHA256:
`05ff5fa1ddb45dfb1c662e5ad0bae06a60adea8956038dd51d49ed778c8ef213`.
Compact payload seal:
`1d657505ffaa849345008e6901daab21c2b3bb07b22ba6c435900c2a10f29566`.

Final paper transcription review is complete. Adversarial_audit read all
three TeX sources in full and approved the following final bytes:

- RC: 8bc6aaaf1184db9cdf71c98ed7723c2a77ee60dc88e655f18f602a7014e074c7.
- FM: dee925fe103f8bcd4ad34e03fe456c6f1089d102501ffcd282d69c2f9be05dc7.
- EA: b0aea8b8e76ff4e50907f22133b688e43c3eeef67a931b2dcb3ac3937c1fb38b.

EA's only final domain clarification says its auxiliary index d is a
positive integer. The reviewer actually checked that change. Both the
ordinary EA proof and its full replay source were independently read,
and adversarial_audit actually ran --check: 571 actual roots and 1142
exact valuation equalities passed with the author's canonical byte SHA.
The earlier pending-transcription sentence above is superseded by this
completed record.

I also read the final RD rational-map TeX and its bibliography in full:
final transcription and primary-source linkage PASS. The author was
asked only to make the auxiliary positive integer n domain explicit.
All arithmetic/geometric statements otherwise match the reviewed RD
ordinary proof. Root's 24 actual-prime-log declarations have a separate
complete read-only review in actual_prime_log_review.md, including
independently recomputed source hashes and declaration/query counts.

Root completed the full ordinary and final TeX review of EA, including
its exact replay, and approved the section for tenth-round integration.
I subsequently read root's actual_prime_log_compensation.tex and
tenth_research_status.tex completely: final transcription and research
scope PASS. The positive natural arm theorem and squarefree interface
match all 24 formal statements. The 41 new declarations, 71 scoped
integer dependencies, pinned Mathlib-cache reuse, two distinct finite
replays and all ordinary/formal exclusions are faithfully stated.
No substantive correction was requested.
