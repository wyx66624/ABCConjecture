# Independent review of RL1--RL4 and UG1--UG3

Reviewer: adversarial_audit. Date: 2026-09-07.
Status: full ordinary mathematical and specified primary-source review
PASS. These are ordinary geometric results, not Lean claims or numerical
enumerations of rational points.

Reviewed complete source files in the independent_route checkpoint:

- `twelfth_round/rational_biquadratic_locus.md`, SHA256
  `47c079a1b9d841ba380735f06fe8ea207ce61f09bea88cbdb44b8e9d5fde043e`.
- `twelfth_round/unramified_gaussian_cover.md`, SHA256
  `a12ddf72265a606842bb1f53dd36a0c582c90a0763ffbcb10f7c8b3961fad12e`.

## RL scope and inverse

Both norm-one parametrizations and their inverses have correct signs;
the value one is exactly the infinite projective input. A quotient of
two g-th roots in the quadratic field is a root of unity, so the Gaussian
injectivity needs odd g and the Eisenstein injectivity needs gcd(g,6)=1.
The two hypotheses are not conflated.

The target polynomial pairs have no common projective zero, including
infinity. Over K their fractional linear coordinates give exactly the
previously proved BK odd cover. Its geometric connectedness applies to
odd composite g as well. The positive t>1 chart avoids all branch zeros,
so rational points there are not duplicated or lost by normalization.

The four Galois equations express precisely membership in the two
quadratic fields and their norm-one subgroups. With t rational they
recover rational projective s,v. The actual seed inverse uses the fully
reviewed pure-coefficient CI theorem at first exponent two and second
exponent g, including unit, ramified and infinite input cases. The
positive rational square root of the integral first norm is integral.
It does not preserve an arbitrarily specified larger even exponent;
the final extra U=R^(h/2) condition correctly remains explicit.

GE supplies a Gaussian power for every positive rational Eisenstein
point. Oddness absorbs its unit and makes the Gaussian rational lift
unique. Hence the new cover does not itself eliminate any point on this
positive rational locus. For gcd(g,6)=1, both units and roots are uniquely
handled in the single curve, giving the stated ordered-seed bijection.
No inverse is asserted for arbitrary K-points lacking the Galois tests.

## UG geometry and torsion

The degree-g relative cover is finite on the smooth projective models.
At each of the eight simple branch points, D and C have the same
ramification index g over the base. Thus the relative map is unramified
everywhere, including infinity; characteristic zero and smoothness give
etaleness. The genus values 3g-3 and 1+3g^2-4g satisfy the unramified
Riemann--Hurwitz identity.

For m=(g+1)/2, W=(Z/Y)^m/f satisfies both W^g=f and W^2=Z/Y. These
identities hold over K without adjoining roots of unity. The divisor
of f is g(R4-R2), with Rj defined over K. A hypothetical smaller order
d|g makes f an actual (g/d)-th power over the geometric function field,
contradicting the already proved geometric relative degree g. This proves
exact geometric and arithmetic order g, rather than merely divisibility.

The actual K-defined divisor yields a K-rational Jacobian point via the
natural Picard map. No rational base point or equality of all arithmetic
Picard classes and Jacobian points is required. Locally W/s is a root
of a unit, giving a mu_g group-scheme torsor. This is correctly distinct
from claiming g constant arithmetic deck transformations over K.

The final bijection over the positive rational locus follows from RL4;
it is compatible with a geometrically connected nontrivial cover. The
Jacobian dimension grows with g, so no fixed-dimension torsion or height
bound is asserted.

## Primary sources independently opened and read

I opened the complete relevant text of [Stacks 53.2](https://stacks.math.columbia.edu/tag/0BXX),
including the extension, finiteness and function-field/smooth-projective
model results, and [Stacks 53.12](https://stacks.math.columbia.edu/tag/0C1B),
including the characteristic-zero ramification formula and the flat
smooth-curve implication used for etaleness. These support the geometric
extension and genus steps above.

I independently opened [Milne, Jacobian Varieties](https://www.jmilne.org/math/xnotes/JVs.pdf),
Theorem 1.1 and Remark 1.5 (printed pages 2 and 4). They give the natural
Picard-to-Jacobian map and its injectivity without a rational base point.
This supports the exact torsion image assertion; the note does not use
the stronger equality which can fail without a rational point.

The BK, GE, CI and RD antecedents remain their independently reviewed
ordinary repository proofs. No new finite computation or Lean execution
is claimed in this review.

## Final RL and UG TeX transcription

I read both complete self-contained TeX files. RL final transcription
PASS, SHA256
`300f4c9403cc188a0ee29d758e1d42fd63f737bafd31397d2b97c6f0eb5cc5d5`.
UG final transcription PASS after one literal base-location correction,
SHA256
`9c54990e807e9086de902cf8b1f51efb49bb535a449e40d15fa4249fdf6b06f6`.
The simple zeros and poles occur on the base P1_t, while their pullbacks
to D have order g. The author corrected that sentence in both ordinary
and TeX sources, and I actually reread the corrected lines. The ordinary
UG source now has SHA256
`61a4e3c9454ba3c2083de779da5f1c01f0995b0fbc72815dfb9a716e47c661e2`.
The ramification computations and conclusions were unchanged. This is
a source transcription review, not PDF visual inspection.

## HG1--HG3 ordinary review

I also read the complete `twelfth_round/hyperelliptic_quotients.md`,
SHA256 `6c1e1c7a82dbf83262fb5448ec8348683d8521c3aae766744a91ff7340cc33bf`.
Status: full ordinary proof PASS.

The rational inverse between t and (v,w) is valid on a dense open,
and the unique smooth projective model retains the excluded projective
points. The three rational target values avoid the two branch values
of the Eisenstein power map. Their inverse images are three disjoint
simple sets of size g, including possible points at infinity. The V4
extension has degree four, and each double quotient has 2g branch points
and genus g-1. The common-pole inertia in the V4 cover is order two,
not four.

The displayed pullback and norm maps are defined over Q. On divisors
their three double-quotient identities sum to [2] plus the full V4
trace; the latter is zero on the Jacobian because the quotient is P1.
This proves Psi Phi=[2] and, with equal dimensions, the stated isogeny.
It is a direct arithmetic construction, not a transfer of a result
stated only over the complex numbers. Oddness preserves the exact order
g of the torsion tuple; the note correctly asserts a single coordinate
of exact order g only when g is prime.

The positive domain 0<r<1/3 and v>0 gives v-w>0 and t>1; equality
r=1/3 would require a nonrational t=1+sqrt(3). Both signs of w retain
the ordered seed data. The g=3 coefficient expansions and infinity
branch of the homogeneous B form are correct. Separate quotient
points still require their common source coordinate and real-domain
conditions. No rank, rational-point computation or emptiness is
established merely by exhibiting the genus-two models.
