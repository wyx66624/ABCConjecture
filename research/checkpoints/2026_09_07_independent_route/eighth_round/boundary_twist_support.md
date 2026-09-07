# BT1--BT4. Exact boundary twists and unconditional pure-power support

Status: complete ordinary proof independently reviewed in full by both
research peers and the root researcher, with two independently executed
full-Sturm coefficient comparisons. No file
from the frozen seventh round is changed. The modular coefficient
enumeration is exact software evidence, not a Lean theorem.

Retain the actual quartic `F(a,b)`, field `K=Q(sqrt(-3))`, Frey curves
`E_ab`, boundary `E0=E_{0,1}`, and fixed order-four character `chi`
of FM/BC. The quadratic character `psi_d` is attached to `Q(sqrt(d))`.
Let `epsilon=psi_3`, of conductor 12. Let `f` be the non-CM newform
orbit at level 576 identified in BM, and `g` the unique non-CM orbit
at level 288 in the complete sixth-round enumeration. We fix the exact
PARI field model `L=Q[z]/(z^4+1)` for both forms, using the chosen
normalized representatives returned by the recorded computation.

## BT1. The common level and coefficient-determination bound

For a cusp form of level `N`, weight 2 and character `epsilon`, its
coefficient twist by either primitive quadratic character of conductor
`m=8` is a cusp form of level dividing `Nm^2` and the same character.
Here is a direct level verification, to avoid relying on a software
level label. Write `T_u=[[1,u/m],[0,1]]`. The nonzero quadratic Gauss
sum expresses the twist as

\[
 \frac1{\tau(\psi)}\sum_{u\bmod m}\psi(u) f|_2 T_u.
\]

Its Fourier coefficients are `psi(n)a_n(f)`. For
`gamma=[[a,b],[c,d]]` in `Gamma_0(Nm^2)`, choose
`v=u d^2 mod m`. Then

\[
 T_u\gamma T_{-v}=
 \begin{pmatrix}
 a+uc/m&b+(ud-av)/m-ucv/m^2\\
 c&d-cv/m
 \end{pmatrix}
\]

is an integral matrix of determinant one in `Gamma_0(N)`. Its
lower-right entry is congruent to `d mod N`, and `v=u d^2` permutes
the residues without changing their quadratic character. Applying
the slash operator to the finite sum therefore gives character
`epsilon(d)`. Rational translates preserve holomorphy and vanishing
at the cusps, proving the claim.

Consequently both `g^sigma` and `f twist psi_{-2}` belong to

\[
 S_2(\Gamma_0(M),\epsilon),\qquad
 M=576\cdot8^2=36864.
\]

Indeed 288 divides M. Its index and the safe coefficient cutoff are

\[
 I=[\operatorname{SL}_2(\mathbb Z):\Gamma_0(M)]
   =M(1+1/2)(1+1/3)=73728,
 \qquad B=\left\lfloor\frac{2I}{12}\right\rfloor=12288. \tag{BT1}
\]

For completeness, this coefficient-determination bound follows from
the level-one valence formula. If a nonzero difference H of two such
forms vanished in degrees 0 through B, take the product of its
weight-two translates over the I right cosets of `Gamma_0(M)` in
`SL_2(Z)`. The square of this product is a nonzero holomorphic
level-one form of weight `4I`: the possible transformation signs are
killed because `epsilon` is quadratic. At infinity its order is at
least `2(B+1)`, since each other cusp contribution is nonnegative.
This exceeds `4I/12`, contradicting the level-one valence bound.
Thus equality through B proves equality as modular forms. Milne's
author text, Proposition 4.12 and Example 4.13, was actually opened
for this valence input; his weight convention is `2k`, giving `k/6`.

## BT2. The exact twist identities

Let `sigma_j` be the field automorphism `z -> z^j` for odd
`j` modulo 8. It is an automorphism because z is a primitive eighth
root of unity. Complete exact coefficient calculation gives

\[
 g^{\sigma_7}=f\otimes\psi_{-2},\qquad
 g^{\sigma_5}=f\otimes\psi_2.                            \tag{BT2}
\]

Both are equalities of normalized cusp forms, not only congruences.
The residual characters in (BT2) have fundamental discriminants
respectively -8 and 8. In the rational basis `(1,z,z^2,z^3)`, the
automorphisms act by

\[
 \sigma_7(c_0,c_1,c_2,c_3)=(c_0,-c_3,-c_2,-c_1),
\]
\[
 \sigma_5(c_0,c_1,c_2,c_3)=(c_0,-c_1,c_2,-c_3).
\]

The script `boundary_twist_certificate.gp` selects the unique non-CM
form in each complete newspace by `mfisCM`, rather than assuming a
fixed list position. It checks the field polynomial and character and
returns every coefficient from 0 through 12288 in its four rational
coordinates. All the recorded coordinates are integers. The independent
Python code in `replay_boundary_twist.py` then performs both displayed
coordinate transformations and both Kronecker multiplications, and
checks equality in all degrees, including those divisible by 2 or 3.

The observed newspace dimensions are 4 and 8. The automatically
selected orbit indices are 1 and 3, respectively. These identify the
same orbits as the previously independently repeated complete space
enumeration. The software version is exactly PARI/GP 2.15.4.

The canonical UTF-8 LF output retains both full coefficient arrays:
`boundary_twist_results.json`, SHA256
`c8181912aa36023ff86ac94c72bc59cf0279a67a42849035450de866ea115549`.
There are 12289 coefficient rows per form. The ordinary argument in
BT1 turns these finite exact identities into (BT2).

Adversarial_audit independently implemented and actually ran a second
comparison using PARI's `mftwist` and direct coordinate rearrangement,
without this script's coefficient cache or substitution expression.
Its 98312 rational-coordinate comparisons passed, with independent
output SHA256
`9864149fe7dc844d34f71306192e49b05c90d40bb22728fe71940b173a9807e0`.
This independent program also selects each unique non-CM form dynamically.

The exact software modular-form algorithms are explicit dependencies
of (BT2). No Lean verification of those algorithms or all the modular
form coefficients is asserted.

## BT3. All actual pure p-th powers satisfy the boundary support sieve

**Theorem.** Let `a,b` be positive coprime integers, let `p>7` be
prime, and suppose `F(a,b)=Q^p` with integer `Q>1`. Then for some
quadratic character

\[
 \nu\in\{1,\psi_3|_{G_K},\psi_{-2}|_{G_K},\psi_{-6}|_{G_K}\}
\]

one has the actual residual module isomorphism

\[
 E_{a,b}[p]\otimes\overline{\mathbb F}_p
 \simeq (E_0[p]\otimes\overline{\mathbb F}_p)\otimes\nu. \tag{BT3}
\]

Consequently every rational prime q dividing Q satisfies

\[
 q\ge(\sqrt p-1)^2,                                    \tag{BT4}
\]

neither 7 nor 13 divides Q, and for q different from p the trace of
E0 at either split place over q satisfies

\[
 p\mid (q+1)^2-t_q(E_0)^2.                              \tag{BT5}
\]

**Proof.** The reviewed FM modular reduction gives a weight-two
newform with character epsilon at one of the levels
36, 72, 144, 288, 576. The independently reviewed CB global projective
image theorem excludes every CM candidate for the actual positive
seed and p>7. The complete exact enumeration leaves only the orbits
of f and g. By (BT2), every coefficient embedding of g is the
quadratic twist by `psi_{-2}` of some coefficient embedding of f;
the twist has rational character values and hence commutes with
coefficient embeddings.

For the f orbit, the BM algebraic Frobenius identities and compatible
representations give, upon restriction to G_K, the boundary system
`E0 times chi^sigma`. The actual system restricts to `E_ab times chi`.
The ratio `chi^sigma/chi` is either 1 or `chi^{-2}=psi_3|G_K`.
For the g orbit the extra factor is `psi_{-2}|G_K`, giving the four
characters displayed in (BT3). Equality of modular forms in (BT2)
gives the usual twist relation of their compatible representations:
at every prime away from the finite ramification set the Frobenius
polynomials agree with the quadratic twist, and Chebotarev plus
semisimplicity gives the isomorphism. The residual actual representation
is absolutely irreducible by the checked projective-image input, so
the semisimplified congruence is the full module isomorphism used
in BC. All four quadratic characters are unramified outside 6.

Thus every actual seed under this theorem satisfies the premise of
BC1. Its full local proof gives (BT4), (BT5), and the exclusions of
7 and 13. In particular, (BT3) was derived here from the pure-power
assumption; it is no longer an additional hypothesis in this theorem.
The conclusion does not assert that either orbit or any such seed
actually occurs.

The fixed-p Frobenius density theorem BC3 now also applies as a
necessary support condition to all these pure powers. For every
sufficiently large fixed p, their prime factors other than possibly p
belong to a split rational-prime set of natural density

\[
 \frac{2p^2-p-5}{2(p-1)^2(p+1)}\sim\frac1p.
\]

The allowed sign twists leave the trace square unchanged. This remains
a fixed-p density statement, with no uniform error term in p and the
height of the seed.

## BT4. A resulting actual height lower bound

Put `c=a+b`. The exact identity
`4F=(a^2+b^2)^2+3c^4`, together with `a^2+b^2<=c^2`, gives
`F<=c^4`. As Q has a prime divisor, (BT4) implies

\[
 \log c\ge \frac p4\log Q
          \ge \frac p2\log(\sqrt p-1).                 \tag{BT6}
\]

In the usual rational height `h(a/b)=log max(a,b)` one may instead
use `F<=13 max(a,b)^4`, obtaining

\[
 h(a/b)\ge\frac p2\log(\sqrt p-1)-\frac{\log13}{4}.
\]

Thus a sequence of such actual seeds with p tending to infinity has
height at least `(p/4)log p+O(sqrt p)`. This strengthens a lower
bound using only a fixed least allowed root prime. It is a lower
bound, not an upper bound or a contradiction to the Kummer model's
O(p) coefficient height. Point height and defining coefficient height
remain different quantities.

## Sources and remaining gap

* Official PARI modular-forms documentation, actually opened:
  `mfinit`, `mfeigenbasis`, `mfcoefs`, `mfisCM`, `mftwist`, and
  `mfconductor` / `mfparams` conventions. In particular a metadata
  level is not assumed to be the minimal level. The common-level
  proof above is valid independently of that metadata.
  https://pari.math.u-bordeaux.fr/dochtml/html-stable/Modular_forms.html
* Milne, Modular Functions and Modular Forms, Proposition 4.12 and
  Example 4.13, actually opened for the full-level valence formula:
  https://www.jmilne.org/math/CourseNotes/MF.pdf .
* FM, BM, BC and CB ordinary proofs retain their primary modularity,
  local, projective-image and compatible-system dependencies. Their
  separate review records identify these inputs.

The theorem gives a common boundary representation and a moving
arithmetic support condition for both surviving pure-power orbits.
It does not prove that a polynomial value cannot have all its prime
factors in that support. Large moving prime factors, the actual
point-height upper bound, and compatibility with a first compressed
norm remain open. Varying nonunit residual levels are not reduced to
the same two orbits by this argument. No ABC conclusion follows.
