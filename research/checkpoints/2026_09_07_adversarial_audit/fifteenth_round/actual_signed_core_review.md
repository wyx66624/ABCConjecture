# Actual signed products and the single-owner bridge

Reviewer: adversarial_audit. **Full source review PASS** for the four
Gram theorems, twelve signed-product theorems and two final bridge
theorems. The twenty-two signed finite-budget theorems were reviewed
separately in this round. The exact seven source hashes and all 96
recorded queries were independently checked in
`verification/actual_signed_bridge_review.json`; the three zero-axiom
outputs are included. No independent compiler run is claimed here.

The integer Gram calculation uses the actual Eisenstein norm and gives
the claimed factor three. Its modulus criterion accepts signed integer
moduli; the strict square bound makes a separate positive-modulus
assumption unnecessary. Modulus divisibility and the actual height bound
are explicit premises.

The signed product is a literal finite product with integer exponents.
The private homomorphisms recover each coordinate by multiplication by
a nonzero integer, with no sign restriction on that integer. Actual
unit normalization uses the explicit vanishing of those homomorphisms
on each unit. It is not a formal assertion that arbitrary arithmetic
unit choices or private ideals have already been constructed.

The concrete diamond is the disjoint union of two actual finite squares.
Its coordinate map is injective, its cardinality is computed, and the
four-corner inequalities place every coordinate in the required l1
radius. Surjectivity onto an abstract complete l1 ball is not assumed
or needed. The private-product and pair-vector injections compose with
this concrete map, producing the exact lower bound in a finite target
subject to the stated rigidity implication and target size.

The final two theorems really restrict the supplied data to the two
distinct indices using Fin 2 arrays. Their off-diagonal implications
have the correct orientation. They derive high-filter cardinality at
most one, then feed that derived fact into the previously proved
complete single-owner budget on the original set. The lower-layer
count, full individual depth caps, finite target size and modular
rigidity remain explicit. Every summand and sum is a natural truncated
difference before its real cast.

The complete TeX `paper/actual_signed_core.tex` was also read in full.
Its mathematical transcription and formal/ordinary distinction pass.
Only explicit natural domains for n,r and e_i, and real domains for
L,w, were suggested to align isolated statements with the source.
The final source hash will be added after the author's domain-only
wording update. This review does not certify layout or build a new PDF.

Final TeX update: both requested natural/real domains and the explicit distinction between ordinary full-ball counting and formal special-sum identities were actually reread. Final complete transcription PASS, SHA256 c1d1e42ce87fc3d554145edcd3b0883bb1168250a81e4b3e1da4f9f243ae0a27.
