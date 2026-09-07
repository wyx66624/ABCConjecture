# Seventh round: one complete square-class classification and boundary support

This checkpoint contains ordinary theorems about the actual quartic
second norm. It does not prove or disprove ABC.

Status: both ordinary notes, both manuscript sections and the bibliography
fragment have completed independent reviews. The three paper sources are
frozen for the parent's seventh-round integration. Assigned final PDF
pages 425--426 were actually viewed and passed; see `pdf_visual_review.md`.

## Mathematical deliverables

1. `quartic_13_square_class.md` and `paper/quartic_13_square_class.tex`:
   the complete classification
   `F(a,b)=13s^2` iff `a=b` and `s=+/-a^2`, for all integers.
   For positive primitive seeds this leaves exactly `(a,b)=(1,1)`.
   The proof gives all three local two-isogeny descent exclusions,
   the exact index and torsion argument proving
   `E(Q)={O,(0,0)}`, and both the original rational map and the
   simplified integral map. No software rank value is a premise.
2. `boundary_congruence_support.md` and
   `paper/boundary_congruence_support.tex`: BC1--BC4. An actual
   boundary residual module isomorphism, including quadratic twists
   unramified outside 6, forces `F=Q^p` and
   `q>=(sqrt(p)-1)^2` for every prime divisor `q`.
   Away from `q=p`, the exact Frobenius condition is
   `p | (q+1)^2-t_q^2`. The permitted prime-ideal density for each
   fixed sufficiently large `p` is
   `(2p^2-p-5)/((p-1)^2(p+1))`, and rational-prime density is half
   this. BC4 separately uses the independently identified level-576
   boundary orbit to exclude that orbit from `V>1` branches.
3. `paper/bibliography_additions.tex`: the single new Serre 1972
   primary reference. Existing Serre 1987 and Milne ANT entries are
   reused. Root owns integration and cross-reference order.

The Q13 paper uses the earlier QG descent labels. The BC paper uses
FM local results and the independent BM orbit theorem. Input the BM
paper before BC when arranging the integrated narrative; Q13 is
independent of the modular enumeration.

## Exact replay inventory

Both scripts use only the Python standard library. Both were actually
run and then checked against their committed canonical output bytes.
The JSON encoding is UTF-8 with LF.

| Script | Output | Exact scope |
| --- | --- | --- |
| `replay_quartic_13.py` | `quartic_13_results.json` | Three rational-map polynomial identities; 192 primitive-parity pairs modulo 16; 168 nonzero pairs for each of two modulo-13 covers; complete elliptic point counts at 5 and 7 |
| `replay_boundary_support.py` | `boundary_support_results.json` | Every GL2 matrix at 3, 5, 7, 11, 13, 17, 19; both eigenvalue counts, intersection and union; eight complete boundary point counts at 7, 13, 19, 31 |

SHA256 values:

* `quartic_13_results.json`:
  `4eef13317b23f01fd6240236071857efbb0add693d48b2215423c327f5e98e31`.
* `boundary_support_results.json`:
  `d00b5cdcde7f73384dce4a6da72970938fcfb0d94e1f1419be9bbec6122c34a4`.

`quartic_13_probe.gp` is discovery guidance only. Its PARI/GP 2.15.4
rank-zero result was replaced by the complete ordinary descent proof;
it is not a required replay or a hidden rank assumption.

## Independent review and formal scope

`REVIEW.md` records full ordinary and manuscript transcription reviews.
The parent module
`research/checkpoints/2026_09_07_boundary_descent/Lean/ThirteenMapArithmetic.lean`
has seven checked integer statements. This agent independently reviewed
every signature, proof and the imported actual norm definition. The parent
reported a fresh successful build of its 65-module dependency closure.
The final diagonal theorem is conditional on an explicitly named integral
elliptic-point obstruction. Neither this module nor the finite replays
formalize the rational elliptic group classification, Tate local theory,
Serre modularity, Chebotarev, or the boundary newform identification.

The small-radical/two-step compatibility existence problem remains open.
Q13 does not control other residual classes, and BC does not establish
the residual isomorphism it assumes. Its fixed-prime density statement
gives no uniform point-height estimate or global exclusion in the pure
branch. Earlier first--sixth mathematical files remain frozen.
