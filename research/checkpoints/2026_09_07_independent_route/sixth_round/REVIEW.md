# Sixth-round proof and verification ledger

Date: 2026-09-07. Owner: independent_route.
Earlier rounds remain frozen, apart from the explicitly requested fifth-round
visual-QA record added as a separate file.

## Ordinary proofs and TeX

`frey_modular_entry.md` and `paper/frey_modular_entry.tex` contain FM1--FM6.

* FM1--FM4: full ordinary proof independently reviewed by adversarial_audit,
  including both inverse parity charts, the exact minimum isogeny degree,
  both exceptional Tate branches, and the residue field F4. Review passed.
* FM5: full published-source and representation review by critical_bottleneck
  passed. This includes the splitting character, separately sourced oddness,
  finite-flat Tate class, exact 3-adic descent exponent, 2-adic break bound,
  and the general Q-curve large-image theorem's hypotheses.
* FM6: independent ordinary review by critical_bottleneck passed. The
  condition p does not divide V is explicit and is not inferred from lambda.
* TeX FM1--FM4: full independent transcription review by adversarial_audit
  passed after correcting a missing backslash before `quad`. The `n>=1`
  domain of the integral-basis test was also made explicit.
* TeX FM5--FM6: full independent transcription review by critical_bottleneck
  passed. The positive-integer domains of Q and V were made explicit as
  requested. These were precision fixes, with no new mathematical claim.

The six required bibliography entries are in the separate integration
fragment `paper/bibliography_additions.tex`. The root agent owns integration.
No complete Lean proof of the geometry, Tate algorithm, or modularity is
claimed. These results do not prove or disprove ABC.

## Canonical exact replay

`exact_frey_replay.py` was actually run in WSL with Python 3 and PARI/GP
2.15.4. It passed:

* 768 admissible residue pairs modulo 32 for the explicit Tate coefficient
  divisibilities and the two polynomial identities;
* all 159 coprime seed pairs with coordinates from 1 through 16 for PARI
  local reduction, returning I2* / conductor 6 at 2 and III* / conductor 2 at 3;
* all five newspace dimensions, with weight 2 and the quadratic character 12;
* the displayed boundary-curve trace samples.

Outputs use UTF-8 and LF. The JSON
`exact_frey_results.json` has SHA256
`876816dd1f37f6cbee6887e59bab57fa993744bb0e5f37b4de8a6ce01993bd59`.
It contains the hashes of the three complete PARI transcripts. The residue
and software checks supplement the universal ordinary Tate proof; they are
not used as a substitute for it.

The newspace computation is independent of the geometric existence theorem.
It returns dimensions 2, 0, 2, 4, 8 at levels 36, 72, 144, 288, 576.
Independent replay by adversarial_audit agrees. Nonempty spaces have not
all been eliminated. The software-only probe does not by itself identify
an eigenform with a curve from finitely many matching coefficients.

## Independent review of the boundary-shadow route

The complete ordinary BS1--BS3 argument in
`research/checkpoints/2026_09_07_adversarial_audit/sixth_round/boundary_shadow.md`
was read independently and passed. The two 17-adic Frobenius centralizers
are respectively a product algebra and a field, proving non-CM without
a CM database. The explicit consecutive seeds are positive and primitive
and shadow every prescribed finite local precision, but are not asserted
to have a global pure-power norm. The Mazur zero-factor statement has a
precisely specified elimination procedure and was conditional on exact
boundary-form identification at the time of this review.

Both peer replay scripts were actually rerun with `--check`:

* `replay_boundary_shadow.py`: complete point counts 34 over F25, 12 and 4
  over the two F7 embeddings, plus 16 shadow examples; SHA256
  `fecf29fe68b332d60cfdd3143f6a1639b335b5db94d3557b8ba41fa09862f5fa`.
* `replay_boundary_character.py`: all 48 residue units, all 2304
  multiplicativity pairs, and both norm-13 primes; SHA256
  `7eff33ce6623cca2544f5f4cd5c52a16d53a9cef8f0aa128903d800e7543c22a`.

The exact twisted trace at 13 is **-4**, correcting an earlier uncomputed
sign guess made in research messages. The guess never entered a theorem.
No exact boundary eigenform identification is claimed by this ledger.
The final full TeX transcription `paper/boundary_shadow.tex` was also
independently read here and passed, including BS4's explicit 48-unit
character construction and the corrected trace -4 at thirteen. The
last conditional membership paragraph and exact-software scope are
preserved.

## FM7 independent review and preview build

`nonflat_weight_budget.md` received full independent ordinary review by
critical_bottleneck and passed. This includes exact Serre weight p+1 in
the p-divides-V branch, the same-character characteristic-zero lift,
exact prime-to-p new level, and the dimension budget
`485(p+1)exp(3Lp)`. The reviewer actually opened Serre 1987 Section 2.9,
Proposition 5, and Section 3.1.6. We also directly checked the author
Khare--Wintenberger Part I introduction and Section 9 to separate the
completed modularity theorem from Serre's original conjectural status.

The suggested final precision improvements were incorporated: for a
composite exponent, first canonicalize `V=V_p C^p` before comparing the
new parameter; and distinguish the nontrivial compression target Q>1
from the Q=1 profiles still included in the necessary budget.

The complete ordinary manuscript and `paper/nonflat_weight_budget.tex`
then received a second independent full review by adversarial_audit:
PASS. That review independently reopened both Serre sections and the
Khare--Wintenberger source, and checked split local completions,
the two Tate depths, exact conductor/newness, both dimension bounds,
and the final composite-exponent normalization. Thus FM7 ordinary
proof has two independent reviews and its final TeX has a full
independent transcription review.

The two manuscript inputs and all six bibliography entries were actually
compiled twice in an isolated six-page amsart preview, with the earlier
external theorem replaced only by a cross-reference stub in the preview.
The final log has zero overfull boxes, undefined references/citations or
LaTeX warnings. The bibliography has two harmless underfull lines. This
checks the new transcription, not the shared full-manuscript pagination.
The preview and its log live under `tmp/abc_20260907/fm6_preview.*` and
are not checkpoint deliverables.

## Continuing independent work

FM7 includes the p-divides-V branch via Serre's explicit semistable weight
formula. FM1--FM6 retain their reviewed scope with a forward reference.
The uniform elimination of moving modular candidates and the independent
Kummer point-height route are still open.
