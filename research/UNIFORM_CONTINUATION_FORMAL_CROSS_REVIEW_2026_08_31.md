# Independent review of the new Frey arithmetic and odd-part fibre modules

Reviewer: ChatGPT, analytic-route agent. Date: 2026-08-31.

Verdict: both reviewed modules pass the requested mathematical modelling
and scope review. No mandatory correction was found. This was a read-only
review of the two modules and their proof notes. No build was started and
neither module was edited by this reviewer. Compilation and centralized
axiom audits remain the root agent's separate verification records.

## 1. Exact reviewed sources

1. [FreyEntireIsogenyArithmetic20260831.lean](E:/AImath/abc猜想/Lean/IUTThreeClosures/FreyEntireIsogenyArithmetic20260831.lean),
   SHA256
   d31d9a21e912da6d120280e38a97db82950756fae8e36a8ddbaeff3725fb00fe.
   All source declarations and proofs were read, together with Sections
   3--7 and 10 of
   [ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md](E:/AImath/abc猜想/research/ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md).
   The canonical curve definitions in the imported repository files were
   checked as well.
2. [ABCOddPartFibre20260831.lean](E:/AImath/abc猜想/Lean/IUTThreeClosures/ABCOddPartFibre20260831.lean),
   SHA256
   1ec2347ca3abb3c026c4b2a0388bfdf1ab21ab392ecbb7c01d5b60c09b499eae.
   All source declarations and proofs were read, together with
   [ABC_ODD_PART_FIBRE_FORMAL_PROOFS_2026_08_31.md](E:/AImath/abc猜想/research/ABC_ODD_PART_FIBRE_FORMAL_PROOFS_2026_08_31.md),
   SHA256
   3561523e777cd2d73f0235f563bb06d916f30b782fcfdec4c99d2d0e08ec64c4.

The unchanged ABCPoint definition was checked in
[NonCircularDownstream.lean](E:/AImath/abc猜想/Lean/IUTThreeClosures/NonCircularDownstream.lean:27):
its data are three positive natural numbers, their sum relation and
pairwise coprimality. No Galois or abc-conjecture hypothesis is a field
of that point type.

## 2. Frey models, base change and the finite-field point count

The familyTriple definition is an actual ABCPoint
\((1,1792n+1,1792n+2)\), with all proof fields supplied. It works for
every natural \(n\); the final quantitative \(j\)-bounds correctly
restrict to \(n\ge1\), giving \(c\ge1794>32\). There is no unintended
use of the large-height estimates at \(n=0\).

The four entries of model are actual WeierstrassCurve objects, over a
general commutative coefficient ring. For \(a=1,b=c-1\), their coefficients
\((a_2,a_4)\) are

\[
 (c-2,1-c),\quad (4-2c,c^2),\quad
 (-2(c+1),(c-1)^2),\quad (4c-2,1).
\]

These agree with the original Frey equation and the three previously
defined displayed quotient equations. The agreement is not merely
terminological: familyCurve_eq_canonical proves equality with those
canonical objects, and model_map uses the actual coefficient ring
homomorphism and WeierstrassCurve.map.

I independently recomputed the displayed invariants using
\(c_4=16(A^2-3B)\) and \(\Delta=16B^2(A^2-4B)\) for
\(y^2=x^3+Ax^2+Bx\). All four c4 and discriminant formulas in
model_c4 and model_discriminant agree. In particular, the zero-kernel
discriminant is negative, \(-256(c-1)c^4\); the absolute-value theorem
handles that sign explicitly.

canonical_reduction_seven maps the actual integral canonical Frey model
to residueCurve; it does not substitute an unrelated curve with a desired
count. Since \(1792\equiv0\pmod7\), that curve is
\(y^2=x^3-x\) over \(\mathbb F_7\), and its discriminant is \(1\).
The explicit ellipticity instance therefore justifies using the library's
elliptic point type.

The affine solution counts for \(x=0,\ldots,6\) are
\(1,1,0,0,2,2,1\), summing to seven. residueCurve_point_card transports
the actual Point type through the library equivalence and an Option type,
so the eighth point is the point at infinity. This is a genuine point
count, not the count of an artificially defined eight-element type.
The resulting integer expression \(7+1-\#E(\mathbb F_7)=0\) and
the no-root statement for \(T^2+1\) over \(\mathbb F_3\) are correct.
Neither theorem identifies that polynomial with a Galois representation
inside Lean; the source explicitly leaves this interpretation external.

## 3. Frey quantitative statements and their boundary

For \(c\ge1\), all four displayed absolute discriminants are bounded by
\(256c^5\). For \(c\ge32\), all four actual \(c_4\) invariants are at least
\(8c^2\); the least immediate polynomial,
\(c^2-16c+16\), is at least \(c^2/2\) in that range.
For \(c>1\) every discriminant is nonzero. The family therefore has actual
ellipticity instances, and the expansion of WeierstrassCurve.j is valid.

The proof of familyCurve_j_lower compares the positive denominator and
the numerator:

\[
 |c_4|^3\ge512c^6,\qquad
 0<|\Delta|\le256c^5.
\]

It correctly obtains \(2c\le|j|\). For the zero-kernel model, the upper
estimate \(|c_4|\le16c^2\), the exact denominator
\(256(c-1)c^4\), and \(c\ge2\) give \(|j|\le32c\).
The use of the denominator's positivity in both division inequalities
is explicit.

These are statements about ordinary rational absolute value of the
library's actual \(j\)-invariant, not a global Weil height. Likewise,
model_discriminant_upper concerns the displayed integral models.
ModelLabel is a four-element indexing type, not a type declared to be
the complete rational isogeny class. The following are not claimed to
have been formalized by this module:

- cyclic-isogeny degree classification, quotient and dual isogeny theory;
- the least-degree cyclic-map and prime-degree path arguments;
- the Frobenius interpretation of the finite-field calculation;
- exhaustion of the entire rational isogeny class;
- minimal-discriminant local theory or the retained odd part of a
  minimal discriminant.

The paper's stronger entire-class conclusion uses these separately stated
mathematical inputs. It is not inferred merely by enumerating ModelLabel.
The module header and the proof note's Section 10 preserve this distinction.
No false substitution of a model discriminant for a minimal discriminant
was found in the Lean declarations.

## 4. The actual odd-part fibre

The definition oddPart is exactly Mathlib's ordCompl[2], which is
\(n/2^{n.\mathrm{factorization}(2)}\). For positive \(n\) this is its
actual odd part; its value at zero is zero. The proof of strict decrease
for even inputs explicitly requires \(n>0\), avoiding the zero boundary.
The equality criterion for odd inputs is used only where parity proves it.

SameOddParts equates the three computed odd parts. Fibre is the subtype
of all actual ABCPoints with prescribed values of those computations;
its labels are not free stand-ins for an unproved arithmetic relation.
The bound is uniform for all natural label triples, including those
whose fibre is empty.

The three same-even-position uniqueness lemmas use a particularly direct
argument. The two odd coordinates equal their specified odd parts, and
the equation \(a+b=c\) determines the third coordinate. point_eq_of_coordinates
then uses proof irrelevance for the proof fields of ABCPoint, not an
extra numerical hypothesis. This also handles repeated odd parts such as
\((1,1,1)\).

The incompatibility of an even \(b\) and an even \(c\) in the same fibre
is proved from strict inequalities in the correct direction:
an even addend gives \(A+B<C\), while an even sum gives \(C<A+B\).
Together with the same-even-position uniqueness lemmas, this makes the
actual map \(P\mapsto P.a\bmod2\) into Fin 2 injective.

Crucially, fibreFinite establishes finiteness from this injection before
fibre_card_le_two uses Nat.card. The conclusion is therefore not an
artifact of the convention Nat.card = 0 for infinite types. No bound on
height, prime support or label size is an extra hypothesis.

The proof-carrying definitions exampleP and exampleQ are the genuine
primitive triples \((4,3,7)\) and \((1,6,7)\). Their odd parts are computed
with the library's factorization lemmas, and distinctness follows from
their first coordinates. fibre_one_three_seven_classification exhausts
the actual fibre using the same parity injection. Consequently
fibre_one_three_seven_card proves its exact cardinality is two.

This completes the arithmetic fibre theorem and its sharpness. It does
not prove that a fixed Galois orbit reaches both points, that an arrow
preserves their odd parts, or that trace covariance holds. In particular,
the distinction between fixed Tate framing and freely variable integral
coefficient units remains necessary for the analytic application.

## 5. Consequence for the new analytic paper input

The formal-scope paragraph in
[uniform_continuation_analytic_2026.tex](E:/AImath/abc猜想/paper/uniform_continuation_analytic_2026.tex)
has been updated to record the completed arithmetic fibre module.
It continues to separate that result from the logarithmic endpoint-transfer
and coefficient-pair realization proofs.

The root's seven-theorem
[TraceCovariantRationalReturn20260831.lean](E:/AImath/abc猜想/Lean/IUTThreeClosures/TraceCovariantRationalReturn20260831.lean)
was also read when writing that paragraph. Its actual algebra trace and
dimension cancellation support the scalar-line assertions, with trace
covariance kept as an explicit hypothesis. The paper does not describe
those seven lemmas as a formal reconstruction of local Galois transport.

No general abc theorem or counterexample is supplied by any of these
formal components. There are no mandatory revisions from this review.

## 6. Import-only cleanup after review

The root agent subsequently changed the fibre module's umbrella import
from Mathlib.Tactic to Mathlib.Tactic.NormNum. Its final SHA256 is
af7aab52b80cdbd9a845f6800c804dc32c0d7809cb1b7b42b22a3e51083b2ce8.
I checked this change directly: reversing exactly that import replacement
in memory reproduces the reviewed SHA256
1ec2347ca3abb3c026c4b2a0388bfdf1ab21ab392ecbb7c01d5b60c09b499eae.
Thus all declarations and proofs are byte-for-byte unchanged; no repeated
mathematical review was needed. The root's final Lake build and axiom audit
apply to the narrowed-import source.
