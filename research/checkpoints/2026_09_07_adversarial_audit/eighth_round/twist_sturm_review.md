# Independent exact Sturm implementation and ordinary prerequisites

Date: 2026-09-07. Final status: complete independent coefficient replay,
ordinary proof, primary-source check and full BT1--BT4 manuscript review
PASS. The exact modular-form computation remains an explicit software
dependency; this is not a Lean formalization.

The implementation in `replay_twist_independent.gp` was written separately
from independent_route's `twist_288_probe.gp`. It uses the complete
newspace eigenbases and chooses the unique non-CM orbit with `mfisCM`,
rather than hard-coding the third level-576 orbit. Both coefficient
fields are independently required to equal Q[y]/(y^4+1).

Instead of the other implementation's symbolic substitution and
Kronecker multiplication of a stored coefficient vector, this uses
PARI `mftwist(f576,-8)` and `mftwist(f576,8)`. Each resulting exact
coefficient is compared in its four rational coordinates with the
corresponding coefficient of g288, transformed by

    sigma7: (c0,c1,c2,c3) -> (c0,-c3,-c2,-c1),
    sigma5: (c0,c1,c2,c3) -> (c0,-c1,c2,-c3).

These are exactly y -> y^7=-y^3 and y -> y^5=-y in that same
field. No coefficient cache or conversion code from the author is
imported. The index and bound are computed with exact rational
arithmetic from the conservative common level:

    L=576*8²=36864,
    [SL2(Z):Gamma0(L)]=L(1+1/2)(1+1/3)=73728,
    weight*index/12=2*73728/12=12288.

The check includes every n from zero through 12288, not just prime
indices or good indices. Both identities passed all 98,312 rational
coordinate comparisons. Thus the bad 2- and 3-divisible coefficients
are not omitted. The original and twisted parameter outputs all
retain weight two, quadratic character 12, and the same quartic field.
The library records a smaller twist level 576, but the mathematical
argument uses only the conservative common level above.

## Ordinary mathematical inputs

The official PARI modular-forms documentation was reopened and read:
https://pari.math.u-bordeaux.fr/dochtml/html-stable/Modular_forms.html .
Its `mftwist` entry defines coefficientwise Kronecker twisting; its
`mfcoefs` entry specifies the full vector beginning with a_0.

The standard modular twisting theorem puts the twist by a primitive
character of conductor eight into level dividing N*8², with unchanged
weight and character epsilon*psi². Here psi is quadratic, and both
original forms have rational character epsilon=psi_3, so the twisted
and Galois-conjugated forms have exactly the same character at the
common level. No primitive twist-level minimization is needed. This
level bound also follows from the usual finite Gauss-sum translation
formula for twisting; it does not rely on checking a handful of
coefficients or on the library's smaller-level metadata.

Stein's author text was independently opened, specifically Corollary
9.20 and its proof:
https://wstein.org/books/modform/modform/newforms.html .
It gives the character-space Sturm bound k[SL2:Gamma0(L)]/12.
All the normalized newform coefficients, their Galois conjugates and
their quadratic twists are algebraic integers in the common field.
Exact equality through the bound gives congruence at every maximal
ideal by this theorem; a nonzero algebraic integer cannot belong to
every maximal ideal. Consequently the two equalities extend to every
coefficient, as characteristic-zero modular-form identities. One may
equivalently use the characteristic-zero valence form of the bound.

This establishes, with the stated exact software input,

    g288^sigma7 = f576 twisted by psi_{-2},
    g288^sigma5 = f576 twisted by psi_2.

The two characters have fundamental discriminants -8 and 8. They do
not change the nebentype or weight. Deriving Galois-module identities
from these forms requires the usual compatible-representation input;
the full ordinary manuscript is responsible for that separate step
and for preserving chi under coefficient embeddings.

## Reproducibility and exact limits

The Python wrapper ran PARI/GP 2.15.4, first writing the certificate,
then recomputing it with `--check`; both returned PASS. It rejects a
nonzero exit code, a missing certificate marker, or any unexpected
stderr, since GP can otherwise continue after a top-level error.
Only its known stack-size warnings are tolerated. Canonical UTF-8 LF
JSON: `independent_twist_results.json`, SHA256
`9864149fe7dc844d34f71306192e49b05c90d40bb22728fe71940b173a9807e0`.

This is an independently repeated exact software-assisted identity,
not a Lean proof of modular-form construction or Sturm's theorem.
It supplies neither an actual perfect-power seed nor a height-uniform
exclusion of all such seeds.

## Final full-manuscript review: BT1--BT4

The complete file reviewed was
`2026_09_07_independent_route/eighth_round/boundary_twist_support.md`,
SHA256 at review
`aa6ee1b37c4aa562e79d0d005934d0f14992e53dc8d4b134984e80da3401085c`.
This hash identifies the ordinary text, not a replay JSON. Later changes
to its review-status paragraph do not alter the mathematical review.

BT1 was checked independently as an ordinary proof. For a matrix in
Gamma_0(Nm^2), its determinant gives ad=1 modulo m. Taking v=ud^2
modulo m makes ud-av divisible by m. Thus the displayed matrix
T_u gamma T_{-v} is integral, has determinant one, and belongs to
Gamma_0(N). Its bottom-right entry differs from d by a multiple of N.
The permutation u -> ud^2 preserves either quadratic character, so
the finite primitive Gauss-sum formula transforms with precisely the
original nebentype. Rational translates preserve the cusp condition.
This proves membership at the conservative level without assuming the
library reports a minimal twist level.

For coefficient determination, choose coset representatives including
the identity. The product of all translates of a nonzero difference H
has weight 2I and transforms by signs, since epsilon is quadratic.
Its square is a nonzero holomorphic level-one form of weight 4I.
If H vanishes through degree B, that square has order at least
2(B+1), with nonnegative contributions from all other cusp expansions.
For I=73728 and B=12288, this exceeds 4I/12. The level-one valence
formula rules it out. Thus the full finite comparison is sufficient
for exact characteristic-zero identities, not merely a congruence or
agreement at selected good primes.

The following primary texts were actually reopened during this final
review, in addition to the earlier implementation audit:

* Milne, [Modular Functions and Modular Forms](https://www.jmilne.org/math/CourseNotes/MF.pdf),
  Proposition 4.12 and Example 4.13, PDF pages 53--54 (printed 53--54).
  The weight convention is 2k and the full-level order bound is k/6,
  hence weight/12 as used above.
* Stein, [Computing with Newforms](https://wstein.org/books/modform/modform/newforms.html),
  Corollary 9.20 and its proof. This independently supplies the same
  Gamma_0 index bound for forms with a fixed Dirichlet character.
* The [official PARI modular-forms catalogue](https://pari.math.u-bordeaux.fr/dochtml/html-stable/Modular_forms.html),
  the mftwist and mfcoefs entries. These specify Kronecker twisting and
  the complete vector starting at degree zero.

BT2 retains both field identifications and both explicit automorphisms.
In Q[z]/(z^4+1), z^7=-z^3 and z^5=-z, giving exactly the two
coordinate permutations tested. The character epsilon=psi_3 is
rational, so every field embedding fixes it. Both conductor-eight
quadratic twists also leave it unchanged. All 0..12288 coefficients,
including multiples of 2 and 3, enter the exact comparison.

BT3 was read in full, including its ordinary FM, BM, BC and CB
dependencies. Applying an arbitrary coefficient embedding to the first
twist identity permutes the embeddings of the level-576 orbit; its
rational quadratic twist is unchanged. Restriction to G_K must retain
chi^sigma/chi, which is 1 or psi_3, rather than silently cancel chi.
The level-288 case adds psi_{-2}, leaving exactly
{1, psi_3, psi_{-2}, psi_{-6}} restricted to G_K. All are quadratic
and unramified outside six. The established absolute irreducibility
of the actual residual representation makes the semisimplified
comparison an isomorphism of the full two-dimensional modules. The
BC support theorem consequently applies to every actual positive
primitive pure p-th power with p>7 under the explicit ordinary and
software dependencies. The fixed-p density retains its fixed-p
quantifier; no uniform Chebotarev error is inferred.

BT4 follows directly from Q^p=F<=c^4, Q having a prime divisor, and
the reviewed cutoff. The alternative F<=13 max(a,b)^4 gives the
stated rational-height bound. Expanding log(sqrt(p)-1) yields the
lower bound (p/4)log p+O(sqrt(p)); this is not an upper bound on
point height and does not conflict with an O(p) defining-model height.
The proof does not use the later, separately reviewed q=p refinement.

No mathematical correction to BT1--BT4 was required. Final scope is
an ordinary, exact-software-assisted theorem for the pure branch.
Moving nonunit residual levels and the full ABC gates remain open.

## Additional independent root execution

Root reported personally reading the GP implementation and running
it with PARI/GP 2.15.4: all 98,312 coordinate comparisons passed,
including the same twist parameter outputs and conservative level.
Root also independently ran both authors' Python wrappers with
`--check` and obtained the sealed hashes. Our wrapper rejects
unexpected GP stderr and requires the exact final PASS marker, so
this record does not equate an isolated zero exit code with success.

Root additionally reran `replay_cm_shadow.py --check`: 16 rows,
81,376 affine states and 32 shadows passed with canonical JSON SHA256
`a244f2e71b150a6e8076f86e22abea176f82e1348527e760fb4d79c23e2f09bd`.
These are separately identified finite supplements, not substitutes
for the ordinary projective-image or modularity arguments.
