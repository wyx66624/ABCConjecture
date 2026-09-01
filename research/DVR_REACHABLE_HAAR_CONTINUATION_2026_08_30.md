# Reachable determinants and normalized local volume

Author: ChatGPT. Continuation dated 2026-08-30.

This note gives the mathematical argument before its Lean implementation. It
concerns actual submodules and measures, not a new assumption implying abc.
The notation `R` below denotes a discrete valuation ring with uniformizer
`pi`, valuation `v(pi)=1`, fraction field `K`, and finite residue field of
cardinality `q`. The valuation of zero is infinity.

## 1. A Cramer divisibility criterion

Let `A` be an `n` by `n` matrix over any integral domain, with `det(A) != 0`.
For a column vector `s`, suppose `det(A)` divides
`det(A[j <- s])` for every column position `j`. Then `s` is in the image
of the `R`-linear map defined by `A`.

Indeed, choose `x_j` with `det(A[j <- s]) = det(A) x_j`. The adjugate/Cramer
identity gives

    A (det(A) x) = det(A) s.

Linearity and cancellation of the nonzero scalar `det(A)` give `A x = s`.
No inversion in `R`, and no saturation hypothesis on a submodule, is used.

Consequently, if every column of `A` belongs to a set `S` and `det(A)` divides
the determinant of every matrix whose columns belong to `S`, then

    span_R(S) = image_R(A).

For the nontrivial inclusion, replace one column of `A` by an arbitrary
member of `S` and apply the criterion. The reverse inclusion follows because
the columns of `A` are in `S`.

## 2. Minimum valuation is attained among reachable columns

Assume that at least one matrix with columns in `S subset R^n` has nonzero
determinant. The nonempty collection of finite determinant valuations is
a subset of the natural numbers, so has a least element `d`. Choose an
actual matrix `A` with columns in `S` attaining it. For every other such
matrix `B`, either `det(B)=0`, in which case divisibility is automatic, or

    v(det(A)) <= v(det(B)).

In a DVR this is equivalent to `det(A) | det(B)`. Section 1 therefore gives
`span_R(S)=image_R(A)`. In particular, the least valuation is attained on
reachable columns themselves; it is not an infimum over an enlarged orbit.
The statement also covers `n=0`: the empty determinant is one.

## 3. The exact index

For any nonsingular integral matrix `A`, Smith normal form gives invertible
integral changes of coordinates and nonzero scalars `a_1,...,a_n` such that

    R^n / image_R(A) is isomorphic to product_i R/(a_i),
    det(A) is associated to product_i a_i.

Writing `a_i = unit_i pi^(e_i)`, the filtration of `R/(pi^e_i)` by powers
of `pi` has `e_i` successive quotients isomorphic to the residue field.
Thus its cardinality is `q^e_i`. Multiplication of cardinalities, followed
by additivity of the valuation, yields the exact formula

    [R^n : image_R(A)] = q^(v(det(A))).

This is an index of actual additive groups. It does not assume that a
tensor order equals its integral closure. If two orders have a nontrivial
index, that index must still be included when changing normalization.

## 4. Topology and normalized Haar measure

Suppose in addition that `R` is a compact Hausdorff topological ring, and
let `mu` be an additive translation invariant probability measure on `R^n`
with its Borel measurable structure. The matrix map is continuous. Its
image is compact, hence closed and measurable. Sections 2 and 3 show that,
in the full rank case, the closed span of `S` already equals `image_R(A)`.
Its finitely many cosets all have the same measure and partition `R^n`, so

    mu(closure(span_R(S))) = q^(-d),
    log(mu(closure(span_R(S)))) = -d log(q).

For completeness, in the deficient rank case `span_R(S)` is a finitely
generated free submodule because `R` is a PID. It is the compact image of
some `R^r`, so is closed. A Smith basis shows that its quotient has a free
`R` summand when `r<n`. Since a DVR is infinite, this quotient is infinite.
For every positive integer `m` there are `m` disjoint translates of the
submodule. Invariance and total mass one imply `m mu(span_R(S)) <= 1` for
all `m`, and hence `mu(span_R(S))=0`.

## 5. Formalization boundary

`Lean/IUTThreeClosures/DVRReachableHaar20260830.lean` has passed direct
Lean 4.32.0 checking, with no warnings. Its theorem
`exists_reachable_closed_span_volume` proves the entire full-rank chain:
the minimum is attained on actual reachable columns, their integral span
equals the chosen matrix range, the range is closed, its quotient has
exactly `q^d` elements, and its normalized Haar measure and real logarithm
are `q^(-d)` and `-d log(q)`. The intermediate declarations include
`exists_reachable_min_det_span`, `cardQuot_matrix_range`,
`measure_matrix_range`, and `log_measure_matrix_range`.

The measure-zero assertion for deficient rank in Section 4 is still a
mathematical proof only. The Lean theorem uses normalized additive Haar
measure on the compact integral lattice; its identification with the
restriction of a chosen ambient local-field Haar measure is not a new
source-specific construction. No result asserts that an IUT output meets
these hypotheses. The source-specific reachable set and matching upper
bound remain separate obligations. None of these local statements is an
abc proof. The continuation verification record contains the aggregate
build and kernel dependency audit.
