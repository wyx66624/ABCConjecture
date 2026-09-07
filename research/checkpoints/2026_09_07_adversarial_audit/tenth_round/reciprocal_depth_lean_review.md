# Independent review of ReciprocalDepthArithmetic

Date: 2026-09-07. All seventeen theorem signatures and proofs were
read in full. Mathematical fidelity and formal scope: PASS.

Source:
`2026_09_07_critical_bottleneck/tenth_round/Lean/ReciprocalDepthArithmetic.lean`,
SHA256 `ec42e21085ad65c1a3ffdd939a742a0f5276c728ff4ca8a564b3d79c8d1e934c`.

The finite-list local cap inequality uses actual natural truncated
subtraction and nonnegative integer weights, including the zero-depth
case. The finite sum proof is genuine induction. The cleared cap bridge
uses b>=0 and b*h=3d to turn that inequality into the required budget;
it does not merely assume the list result as a new antecedent. The
unrestricted identity represents zero coefficient with all radical
credit retained. The cap-zero cases allowed by some arithmetic
signatures are true stronger statements and are not used to pretend
that the ordinary positive-cap requirement has been dropped.

The canonical positive coefficient is max(b-d,0), written by cases.
Its nonnegativity, domination and upper bounds are correct. The signed
coefficient estimate uses the actual interval bounds to get
0<=t-s<=delta+l; hence its proof does not need an independent sign
premise on delta or l. The small-mass theorem multiplies nonnegative
differences by the visible nonnegative low masses and sums them.

The general cleared three-arm inequality is an algebraic combination
of explicit cap, coefficient and low-mass premises. The canonical
version discharges the latter two kinds of premises from the interval
bounds and the low-mass bounds, leaving the cap inputs explicit. The
finite-cap bridge and unrestricted identity provide the intended ways
to instantiate those cap inputs. No rational division or hidden
positive-denominator assertion is present in these integer statements;
the ordinary interpretation chooses a positive common denominator.
The nonpositive margin theorem explicitly requires t>=0.

The last three iff statements correctly classify positive sorted integer
caps after clearing denominators. The one-cap case gives one. In the
two-cap case a>=3 contradicts b>=a and ab<=a+b. In the three-cap
case a>=4 is impossible; a=3 forces b=c=3; a=2 gives b=2, b=3
with c<=6, or b=c=4. The a=1 alternatives are unrestricted above
the sorting bounds. Their reverse implications also use the required
positive sorted domain. These encode the one-, two-, and three-finite-
cap cases; infinity is represented by the number of omitted finite
caps in the ordinary interpretation, not an undeclared Lean datatype.

The author-provided fresh manifest was actually read. Its SHA256 is
`227ac8c27e88c237cbcc7c34a438e6a94dcecb0007ea8d17b3aea06e02365376`.
It records seventeen new and seventy-one dependency declarations under
Lean 4.32.0, commit `8c9756b28d64dab099da31a4c09229a9e6a2ef35`,
with only `propext`, `Classical.choice` and `Quot.sound`. All four
source hashes were independently recomputed and matched. Their
declaration/query counts are 29, 10, 32 and 17. This is independent
source and manifest verification, not another claimed compiler run.

The module remains a finite integer-weight formalization. It does not
define prime factorization, real logarithms, the analytic two-place
estimate or actual membership. The root's separate actual-prime-log
module is a distinct formal development. No global ABC claim follows.
