# Independent source review: ReciprocalDepthArithmetic

The complete file
research/checkpoints/2026_09_07_critical_bottleneck/tenth_round/Lean/ReciprocalDepthArithmetic.lean
was actually read, including all seventeen theorem signatures and proofs.
Result: PASS. SHA256:
ec42e21085ad65c1a3ffdd939a742a0f5276c728ff4ca8a564b3d79c8d1e934c.

The local cap bound uses the actual truncated natural subtraction and
handles depth zero separately. Its finite-list induction correctly
requires nonnegative integer weights. The common-denominator bridge
explicitly retains b*h=3*d and b>=0. The signed coefficient interval
bound discharges its use from the two stated interval inequalities;
the positive-part coefficient construction is not an extra assumption.

The three-arm polynomial budget retains its three cap interfaces and
all unrestricted-arm radical credit. The canonical version genuinely
discharges the coefficient and low-mass interfaces from the stated
finite inequalities. It does not discharge cap membership itself.

The sorted positive integer classifications for one, two and three
finite caps are correct, including the (2,2,c), (2,3,c<=6), (2,4,4)
and (3,3,3) branches and the unrestricted cases with first cap one.

The file proves integer and finite-list statements. It defines neither
actual prime valuations nor real logarithms. No such formalization or
global sufficient-class membership is attributed to it in this review.
The reviewer did not perform an additional independent fresh build;
the author's reported fresh 17+71 build is separate evidence.
