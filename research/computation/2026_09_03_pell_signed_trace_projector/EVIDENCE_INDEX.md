# Evidence index: Pell signed trace projector

**Author:** ChatGPT  
**Date:** 2026-09-03  
**Frozen finite scope:** odd prime index ell at most 800,000 and support
prime q at most 2,000,000, restricted to the necessary classes
q congruent to plus or minus one modulo 2 ell.

## Claim boundary

The two certified rows are local repeated-support collisions.  At index seven,
the opposite coordinate is the exponent-one prime 239, so that row is not
squarefull.  The large row certifies only one repeated A-channel support prime;
the squarefull status of the complete coordinate product is unresolved.
Neither row is a counterexample to the standard abc conjecture.  A bounded
unresolved index is never classified as squarefull.  The global
simultaneous-zero and depth-three gates remain open.

## Search and independent replay

The producer is search_signed_trace_projector.py and its result is
signed_trace_projector_search.json.  It found:

- 63,950 odd prime indices;
- 764,366 candidate-prime tests;
- 12,356 actual support hits;
- 11,098 indices with a bounded simple support witness;
- 52,852 bounded unresolved indices;
- two repeated hits, one in each channel;
- zero depth-three hits in scope; and
- zero indices with in-scope repetition in both channels.

The independent matrix verifier is verify_signed_trace_projector.py.
signed_trace_projector_verification.json records PASS and exact agreement
on all counts and both collision rows.

## Complete-premise collision certificates

certify_exact_collisions.py checks both collision rows independently of the
bounded scan.  exact_collision_certificates.json records PASS.  It uses:

- complete trial division through floor(sqrt(n)) for both index and support
  primality;
- quadratic-ring binary powering;
- independent 2 by 2 matrix binary powering;
- the defining linear recurrence through every index;
- the odd norm identity modulo q^5;
- exact q^2 but not q^3 coordinate divisibility;
- nondivisibility of the opposite coordinate by q;
- nonzero fixed-parameter derivative; and
- exact q^4 but not q^5 signed-trace divisibility.

For the large row, ell=773231 and q=1546463=2 ell+1.  Trial division runs
through 879 and 1243 respectively.  All three orbit algorithms agree
modulo

\[
q^5=8844996565598309452666138088543.
\]

The nonzero certificate residues are

\[
\frac{A_{\ell}}{q^2}\equiv1090979,\qquad
L_{\ell}'(2)\equiv326969,\qquad
\frac{A_{2\ell}-1}{q^4}\equiv1407445\pmod q.
\]

They establish every primality, support, transversality, and exact-depth
premise used to refute the corresponding universal strengthenings.

## Formal verification

The strict main compile, Lake build, and strict axiom audit all have exit
code zero.  formalization_audit.json records PASS for 36 declarations:
every declaration is checked once, every axiom set is printed once, no
proof placeholder or custom axiom declaration occurs, and the axiom union
is exactly Classical.choice, Quot.sound, and propext.

## Text and paper verification

text_artifact_validation.json records PASS for the mathematical report and
directly inputtable English paper section.  It verifies UTF-8 decoding, absence of
unexpected C0 bytes, balanced display-math and TeX environment delimiters,
absence of bare high-risk TeX control words, and the escaped qquad in the
final adjacent-factor display.  It also verifies the absence of document
wrapper commands, the unique pell-signed label prefix, resolution of every
local reference, and the existing BHV2001 bibliography item in the main
paper.

latex_compile_stdout.json records a successful bundled-Tectonic build of
the fragment through an isolated four-page wrapper.  The final pass has no overfull box or unresolved
reference warning.  The PDF was also rendered at pages 1 and 4 for visual
inspection; title, body text, equations, and the collision table fit the
page.

SHA256SUMS.txt authenticates the frozen source, certificates, logs,
formalization, report, paper source, and compiled PDF.
