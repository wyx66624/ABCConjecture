# Independent geometry review of the balanced level-43 initial-data construction

Author: ChatGPT. Reviewer: arithmetic geometry route. Date: 2026-08-31.

Reviewed read-only:
`IUT_INITIAL_DATA_BALANCED43_AUDIT_2026_08_30.md`, sections 3--6.
The arithmetic realization was independently checked in the earlier
balanced-curve report; this review concentrates on the added geometry
and source hypotheses. No shared report, TeX, PDF, or frozen Lean file
was edited.

## Finding

No necessary mathematical correction was found in sections 3--6.
The asserted construction is a paper proof using the specified
classical and anabelian source results. It is not a Lean verification
of those sources and does not settle a subsequent theta-volume
comparison or ABC.

## Specific checks

1. **Core.** CanLift Proposition 2.7 applies to the punctured
   hemi-elliptic orbicurve over an algebraic closure, not directly
   to an arbitrary punctured elliptic curve. The reviewed proof
   uses it in exactly that way. The four values in Sijsling's
   Table 4 are integral at 1289; the candidate's j-valuation -4
   excludes all four. CanLift Proposition 2.3 supplies the
   base-field comparison and descent. Arithmeticity is unchanged
   under the finite etale double cover, as the relevant
   commensurability category is unchanged.

2. **One global cover.** For a fixed line H in D[43](K), the
   quotient isogeny phi:D->D/H has dual psi and
   ker(psi)=phi(D[43])=D[43]/H. Every fiber point above the
   origin is K-rational. Removing that fiber gives the asserted
   cyclic etale cover, trivial on the cusp decomposition group:
   both inertia and the residue-field action on the fiber vanish.
   The inversion quotients form the stated cartesian square as
   stacks, including at points fixed by inversion. No unjustified
   Galois assertion about the bottom orbicurve cover is made.

3. **Decorated transitivity.** For each pair (H,vbar), choose
   v lifting vbar and the unique h in H satisfying omega(h,v)=1.
   Mapping one such symplectic basis to another gives determinant
   one and sends both decorations correctly. This verifies
   transitivity on a line plus a nonzero quotient element, which
   is stronger than transitivity on lines alone.

4. **Place direction and quantifiers.** With
   (g w)(x)=w(g^(-1)x), the map g:K_w->K_(g w) is the
   compatible isomorphism of completed fields. It transports the
   Tate multiplicative subgroup and quotient generator in the
   same direction used in the proof. Choosing a separate g_r
   for each rational bad prime keeps global H and vbar fixed.
   Mochizuki I Definition 3.1(e) requires an arbitrary section
   of V(K)->V(F_mod), not an equivariant or preassigned section.
   The independent choices are therefore permitted.

5. **Dual graph-cover direction.** On D=E(q), quotienting by
   mu_43 gives phi:[z]->[z^43] from E(q) to E(q^43). Its
   dual psi is [z]->[z] from E(q^43) to E(q), of degree 43.
   Its deck generator is [q], and phi([q^(1/43)])=[q]. Thus
   the chosen cusp is the canonical graph generator up to sign.
   This agrees with EtTh's universal graph quotient and
   Definition 2.5(i); the power map is not mistakenly selected
   as the graph cover.

6. **No extra global splitting condition.** Definition 3.1(d)
   invokes the canonical geometric theta subgroups. The natural
   arithmetic theta models in 3.1(e) are local at selected bad
   places. Neither clause asks for a single global arithmetic
   splitting agreeing with every such place. Locally the field
   contains i and all rational 2- and 3-torsion, so sqrt(q)
   and mu_12 are available. The square-root claim uses Galois
   equivariance of Tate uniformization, not merely parity of
   the valuation. At the theta-series argument i, the leading
   value 2i is a unit in the odd residue characteristic and
   every remaining term has positive valuation. Unit scaling
   gives standard type. EtTh Theorem 1.10(iii) then supplies
   the compatible plus/minus structure, whose ambiguity dies
   modulo odd 43. Proposition 2.2 constructs the local cover
   without enlarging the global F.

## Original pages read

The following archived original PDFs were read directly through text
extraction, with the displayed definitions and proof dependencies
checked against the report:

- Mochizuki I, May 2020 author PDF, pages 61--63, Definition 3.1.
- Etale Theta, author PDF, pages 11, 16, 20--21, 27--28, 32--36;
  graph quotient, ddot-K, Proposition 1.4, Definition 1.9,
  Theorem 1.10 and root-of-unity correction, Definition 2.1,
  Proposition 2.2, and Definition 2.5.
- Canonical Curves author PDF, pages 9--10 and 14--15;
  Remark 2.1.1, Propositions 2.3 and 2.7.
- Sijsling arXiv:1707.01158v2, page 11, Table 4.

The source paths, URLs, versions and hashes are recorded in section 8
of the reviewed report. This review does not claim new independent
proofs of the cited anabelian theorems.

## One scope update after the review

Section 7's general source-comparison warning should now distinguish
the still unresolved complete published pilot from the specified
native pre-transport ideal: the new trace-dual argument in
`TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md` proves M=P for that
exact native input. This is an update to the boundary description,
not a defect in the initial-data construction.
