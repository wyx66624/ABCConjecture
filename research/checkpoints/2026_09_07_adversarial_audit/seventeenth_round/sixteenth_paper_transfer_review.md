# Independent final transcription audit of QS, QH and JP

Status: all four listed files actually read in full; mathematical transcription
PASS. This new round-seventeen review leaves the earlier sources unchanged.
The scope is source transcription against the separately reviewed ordinary
proofs, not a PDF visual review or a new Lean result.

## QS and QH

Files under `../../2026_09_07_independent_route/sixteenth_round/paper/`:
`rational_simple_quotients.tex`, `quadratic_chabauty_entry.tex`, and
`bibliography_additions.tex`.

QS faithfully includes the rational order-three action and conic fixed fields,
ground-field endomorphism action and even ranks, both complete F25 tables,
both complete F49 tables, good-reduction charts, and the two different
Frobenius polynomials at five. The rational elliptic-factor exclusion uses
integer traces and good reduction of the factors; it does not infer absolute
simplicity. The torsion proof separately treats five- and seven-primary
torsion. The nonzero rational point-difference class supplies positive rank,
and the order-three action raises the bound to two. No upper rank or complete
point computation is introduced. The displayed table entries and sums agree
with the previously independently checked ordinary finite certificates.

QH faithfully supplies rational Neron--Severi classes, isogeny invariance,
good reduction at five including the common pole divisor of the two square
roots, rational basepoints, and the exact BD rank criterion. Pullback through
the full degree-two projective morphism produces a finite local container
including all rational points and all chart exceptions. It is explicitly
distinct from the intrinsic genus-six quadratic Chabauty set. The latter
finiteness statement retains the unproved rank upper bound as a hypothesis.
The theorem uses BD Lemma 3.2, and does not silently import the new QL
closure results from round seventeen. The source paragraph correctly
separates the extra assumptions of BD Theorem 1.2.

The two bibliography entries point to the actually audited primary Milne
and Balakrishnan--Dogra sources and use the requested distinct citation keys.
The MilneJV2021 key is deliberately reused from the established bibliography.

## JP

File `../../2026_09_07_critical_bottleneck/sixteenth_round/paper/projective_packets.tex`.
Its actual quotient by mu3, restriction to q-unit marked roots, higher
precision q-group kernel, and n-torsion bound are correctly transcribed.
The rigidity theorem keeps the entire common-hit rectangle. Three possibly
different phase choices are combined through an integer product determinant;
all signs, unequal lengths and the empty product are included. Positive
integer nu and e, distinct primes q>8B and the strict determinant estimate
are present. The exact signed-ball count has target size n^s, not n.
The final paragraphs preserve the singleton-label and weighted-depth gaps,
and make no new formal claim about the residue-group construction.

File hashes at this full read are recorded in the adjacent
`sixteenth_paper_transfer_review.json`.

Final layout binding: QS subsequently received only allowbreak commands and
their associated line wrap inside the long replay script name. The changed
lines were actually read, and removing exactly that patch recovers the
initial fully reviewed SHA256 byte-for-byte. The adjacent JSON now binds
the final QS SHA256 `43cfad945b701a166e75799f2c163f32c420fb7a766e56fb193e085be0b29bae`.
