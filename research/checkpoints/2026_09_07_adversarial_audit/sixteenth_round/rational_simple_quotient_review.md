# QS1--QS4 independent ordinary and exact finite review

Status: FULL ORDINARY PASS, with independently implemented complete finite counts.
Reviewed source SHA256: `ca3672e3c0533b2e3ef7c04e8308d1d8e4e744df3bb6a4abccffd42fda0aaea3`.

## Ordinary mathematics actually reviewed

QS1: the cubic substitution has the stated common minus multiplier; the ordinate multiplier makes sigma have order three rather than six. The invariant function fields have degree exactly three, so the three displayed smooth conics are the actual quotients. Norm/pullback through their zero Jacobians gives 1+sigma+sigma^2=0 on each Jacobian. The irreducible quadratic therefore defines a unital field action over Q; on rational Mordell--Weil groups tensored with Q this forces even rank, including zero. No geometric simplicity is inferred from this action.

QS2--QS3: the sextics are squarefree modulo both five and seven; monicity gives two smooth rational infinity points in each characteristic. Good reduction of a Q-isogenous elliptic factor follows from the unramified rational Tate module, or the isogeny invariance of good reduction. Comparing the actual degree-four Frobenius polynomial with two degree-two elliptic factors forces a^2=5 or 17, both impossible over the integers. Thus each remaining Jacobian is simple over Q; distinct good-five polynomials prohibit a Q-isogeny between them. A nonconstant map to any genus-one curve would induce a forbidden dimension-one quotient. This does not prove absolute simplicity.

QS4: the four complete counts below give special-fibre Jacobian orders 31,19 at five and 84 at seven. Prime-to-p torsion specialization excludes every prime separately; in particular five-primary torsion is excluded using seven, and seven-primary torsion using five. For completeness, the specialization injection follows on the good abelian scheme because multiplication by a prime-to-p integer is finite etale, so two such sections with the same reduction coincide. The class [(0,1)-infinity_plus] is nonzero: a principal divisor of this form would give a degree-one function on a genus-two curve. Torsion vanishing makes that point infinite order, and the Q(sqrt(-3)) action then gives rank at least two for each Jacobian. The already audited HG isogeny and GD rank-one result give rank Jac(D) at least six. These are lower bounds, with no basis, upper rank, rational-point completeness, or positive-seed existence claim. Only the direct classical strict-rank-less-than-genus criterion is excluded.

## Independent exact finite implementation

I wrote and actually ran `replay_quotient_counts.py`, then independently executed its byte-comparison `--check` mode successfully. It enumerates all square fibres directly, using F25=F5[sqrt(3)] and F49=F7[sqrt(5)], different defining polynomials from the author. It does not use the norm-character formula or a CAS. A modular polynomial Euclidean algorithm independently gives gcd(sextic, derivative)=1 for all four pairs.

| Curve | Prime | N1 | N2 | Frobenius polynomial | Jacobian order |
|---|---:|---:|---:|---|---:|
| H2 | 5 | 6 | 36 | X^4+5X^2+25 | 31 |
| H3 | 5 | 6 | 12 | X^4-7X^2+25 | 19 |
| H2 | 7 | 11 | 61 | X^4+3X^3+10X^2+21X+49 | 84 |
| H3 | 7 | 11 | 61 | X^4+3X^3+10X^2+21X+49 | 84 |

Certificate SHA256: `ab19e8d24b6eecbcda662aaed88dc4706702732abe149f2e5f1e3d8247643a65`.
Script SHA256: `4e7ae2e188e6453884ab60b0413e6e573423f649dc52f0b8cc20ccbb4d8bed60`.
The code certifies these finite calculations only; Frobenius interpretation and the ordinary deductions above are separate.

## Primary inputs actually reopened

- [Milne, Abelian Varieties](https://www.jmilne.org/math/CourseNotes/AVc.pdf): I Proposition 10.1, printed page 42 (PDF page 48), gives ground-field reducibility; IV Theorem 3.5 and Corollary 3.6, printed pages 141--142 (PDF pages 147--148), give the good-reduction/Tate-module criterion and isogeny invariance. I actually opened the relevant text passages.
- [Milne, Jacobian Varieties](https://www.jmilne.org/math/xnotes/JVs.pdf): Theorem 11.1 and Corollary 11.4, printed pages 35--37, give curve/Jacobian Frobenius and zeta correspondence; the adjacent discussion also explicitly states Mordell--Weil finite generation. I actually opened those passages.

This review supplies no Lean Jacobian/Frobenius formalization and does not change any frozen round-fifteen file.
