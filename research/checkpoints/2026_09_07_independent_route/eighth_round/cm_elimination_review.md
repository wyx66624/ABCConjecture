# Independent review of CB1--CB5

Status: complete ordinary-proof review PASS. The reviewed file is
`research/checkpoints/2026_09_07_adversarial_audit/eighth_round/cm_boundary_shadow.md`.
This record does not change the frozen seventh-round mathematical sources.

The reviewer actually read CB1--CB5 in full. The explicit boundary
`E_*:Y^2=X^3+12rX`, its order-four geometric automorphism, and the
trace-zero character-sum pairing at split primes congruent to 7 modulo
12 are correct. The positive primitive seeds `(Lk-1,1)` realize every
finite coefficient and direct power-residue condition described. They
are not asserted to have globally perfect-power norms.

The global CM exclusion is a different argument. For every positive
primitive actual seed, `F>=13` and `gcd(F,6)=1` ensure a multiplicative
prime greater than 3. Its proved degree-two cyclic isogeny puts it in
the general square-free-degree Q-curve theorem. The reviewer actually
reopened all of the following primary sources:

* Pacetti--Villagra Torcomian, author PDF, Theorem 5.2 (PDF page 28),
  with its general multiplicative-prime hypothesis and N_3=7; and
  Section 6 (PDF page 30), explaining the CM-induced-image exclusion.
  https://sweet.ua.pt/apacetti/papers/Q-curves.pdf
* Ellenberg, author PDF, Theorem 3.14 (PDF page 15), whose displayed
  projective representation has domain G_Q and target PGL2(F_p).
  The earlier Q-curve definition and projective representation were
  also actually read. https://people.math.wisc.edu/~ellenberg/A4B2Cp.pdf
* Koutsianas, Proposition 5.4, the auxiliary newform nonvanishing for
  every prime at least 11, and Proposition 5.5's separate discussion
  of p=13. https://arxiv.org/pdf/1805.07127

The numerical small-prime improvement remains an explicitly cited
published input; this review does not claim to have re-executed the
source's Magma nonvanishing certificate. No theorem for a substituted
nonprimitive generalized Fermat triple is used.

Restricting the surjective projective G_Q representation to G_K gives
a normal subgroup of index at most two. It contains PSL2(F_p), and
the displayed elementary-unipotent commutators establish perfectness
for p>3. This supplies a nontrivial perfect, hence nonsolvable,
subgroup. The statement does not incorrectly demand full PGL2 image
over K itself.

On the CM side, the inducing p-adic character has unit values by
compactness. The two-coset induced lattice is stable, and its reduction
is monomial. If the residual inducing characters coincide, the quotient
of order two splits after coefficient extension because p is odd;
otherwise the induced representation is irreducible. Its projective
image is cyclic-by-at-most-two, or abelian. Passing to a subgroup,
coefficient embedding, or scalar twist cannot create the nonsolvable
projective image forced on the actual side. This proves the stated
global residual-congruence exclusion, independently of the newform weight.

The final two-orbit statement correctly requires the pure branch and
the complete five-space enumeration. For varying residual factors and
weight p+1 the result only removes CM forms from the corresponding
spaces; it does not reduce them to the same two orbits. The remaining
non-CM orbits and uniform height problem are expressly retained.

The author also read the complete final TeX transfer at
`2026_09_07_adversarial_audit/eighth_round/paper/cm_boundary_shadow.tex`.
The CB1--CB5 statements, image comparison, source hypotheses, and
pure-branch-only two-orbit conclusion faithfully match the ordinary
proof. Final TeX mathematical transfer: PASS.
