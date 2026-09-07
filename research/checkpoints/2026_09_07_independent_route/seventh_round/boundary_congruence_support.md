# BC1--BC4. A moving prime-support condition for boundary congruences

This new seventh-round note does not change the frozen sixth-round
manuscript. Its premise is an actual isomorphism of residual Galois
modules. BC1--BC3 do not require boundary eigenform identification;
BC4 explicitly uses the independent BM identification. No such residual
congruence or Frey--Mazur assertion is asserted to exist.
The BC1--BC3 ordinary proof has passed independent full reviews by
critical_bottleneck and adversarial_audit; the latter has additionally
reviewed the complete quadratic-twist extension and BC4. The latter also independently
checked both new primary sources and exhaustively replayed the finite
matrix counts. No complete Lean formalization is claimed.

Let `K=Q(sqrt(-3))`, `r=sqrt(-3)`, and

\[
 F(a,b)=a^4+3a^3b+5a^2b^2+3ab^3+b^4,
 \quad x=a^2+b^2,\quad y=a+b,
\]
\[
 E_{a,b}:Y^2=X^3+12yX^2+6(3y^2+xr)X,
 \qquad E_0=E_{0,1}.
\]

The sixth-round ordinary proofs establish the following inputs. For
coprime positive `a,b`, `F` is coprime to 6. Every `q|F` splits in `K`,
and the two places above `q` are multiplicative with minimal discriminant
valuations `m,2m`, where `m=v_q(F)`; their `c4` valuations are zero.
The fixed boundary curve `E_0` has good reduction at every prime above
`q>3` and has no geometric CM. These facts have separate ordinary
proofs and finite point-count certificates; they do not use boundary
newform identification.

## BC1. A residual boundary isomorphism forces a pure norm

**Theorem.** Let `p>7` be prime, and let `a,b` be coprime positive
integers. Let `nu` be a quadratic character of `G_K` unramified outside
the primes over 6; the trivial character is allowed. Suppose

\[
 E_{a,b}[p]\otimes\overline{\mathbb F}_p
   \simeq (E_0[p]\otimes\overline{\mathbb F}_p)\otimes\nu
 \quad\text{as representations of }G_K.                    \tag{BC1}
\]

Then `F(a,b)=Q^p` for an integer `Q>1`. In particular a `p`-power-free
residual factor in any decomposition `F=VQ_1^p` must equal 1.
For every prime `q|Q` one has

\[
 q\ge(\sqrt p-1)^2.                                      \tag{BC2}
\]

For `q` different from `p`, and either prime `mathfrak q` of `K` over
`q`, let `t_q=q+1-#E_0(F_q)`. Then the stronger exact condition is

\[
 p\mid (q+1)^2-t_q^2.                                    \tag{BC3}
\]

**Proof.** At a divisor `q` of `F` different from `p`, the good-reduction
module of `E_0` and its twist by `nu` are unramified. Hence (BC1) forces the Tate module modulo
`p` of `E_{a,b}` to be unramified. For a multiplicative elliptic curve
over `Q_q`, the residual inertia is trivial exactly when the valuation
of the Tate parameter is divisible by `p`. These valuations are `m`
and `2m` at the two places. Since `p` is odd, `p|m`.

If `p|F`, then `p` splits in `K`, and the completion at either prime
above it is `Q_p`. The boundary curve has good reduction, so its
residual representation has Serre weight 2. The character `nu` is
unramified at `p`, so it leaves the inertia weight unchanged.
The isomorphism (BC1)
preserves the local weight. Serre's semistable weight formula gives
weight 2 for the actual multiplicative curve precisely when its
`j` valuation, namely `-m` or `-2m`, is divisible by `p`. Thus again
`p|m`. This can equivalently be expressed as preservation of the
finite-flat local representation under isomorphism. The assertion is
about the full representations, not just their local semisimplified
traces. The weight criterion is unchanged on extending the coefficient
field to `Fbar_p`.

Every prime valuation of `F` is now divisible by `p`; since `F>=13`,
unique factorization gives the integer `Q>1`. For a divisor `q` of `F`
different from `p`, the unramified residual representation of its
Tate curve has Frobenius trace `eta(q)(q+1)`, where `eta(q)` is 1 or -1
according to the unramified multiplicative splitting character.
The extra Frobenius sign from `nu` is absorbed into this sign. Consequently

\[
 t_q\equiv\pm(q+1)\pmod p.
\]

The Hasse bound `|t_q|<=2sqrt(q)<q+1` makes the corresponding integer
difference nonzero. Its absolute value is at most
`q+1+2sqrt(q)=(sqrt(q)+1)^2`; a nonzero integer divisible by `p` has
absolute value at least `p`. This proves (BC2) and (BC3). For `q=p`,
(BC2) holds directly as a real inequality; no unramified-at-`p` trace
assertion is made. This completes the proof.

The actual depth-one theorem at 13 additionally excludes `13|Q`.
The sixth-round complete point counts give `t_7=+/-4`, hence
`(7+1)^2-t_7^2=48`. Therefore `7|Q` is also impossible for `p>7`.
Further fixed-prime exclusions may be certified by full point counts;
they should not be inferred from numerical approximations.

## BC2. Exact size of the permitted Frobenius set

Fix an odd prime `p`. In `G=GL_2(F_p)` define

\[
 C_p=\{A\in G:(\operatorname{tr}A)^2
                       =(\det A+1)^2\}.                 \tag{BC4}
\]

Then

\[
 |C_p|=p(2p^2-p-5),\qquad
 \frac{|C_p|}{|G|}
 =\frac{2p^2-p-5}{(p-1)^2(p+1)}.                          \tag{BC5}
\]

**Proof.** The first sign condition `tr A=det A+1` is equivalent to
1 being an eigenvalue. For each other eigenvalue
`u` in `F_p^*` different from 1, there is one conjugacy class of
`diag(1,u)`, of size `p(p+1)`. There are `p-2` choices of `u`.
For the repeated eigenvalue 1, the identity and the nontrivial
unipotent class together have size `1+(p^2-1)=p^2`. The number of
matrices having eigenvalue 1 is therefore
`(p-2)p(p+1)+p^2=p(p^2-2)`.

Negation gives the same count for eigenvalue -1. Their intersection is
exactly the conjugacy class of `diag(1,-1)`, of size `p(p+1)` since
`p` is odd. Inclusion-exclusion proves the numerator in (BC5), and
`|GL_2(F_p)|=p(p-1)^2(p+1)` gives its denominator. This proof holds
for every odd prime and is independent of any elliptic image hypothesis.

## BC3. Density of the allowed prime support

For a fixed odd prime `p`, suppose the residual image of `E_0` over
`K` is `GL_2(F_p)`. Let `S_p` be the set of its good prime ideals,
away from `p`, with residue-field order `n` and trace `t` satisfying

\[
 t^2\equiv(n+1)^2\pmod p.
\]

Then `S_p` has natural density

\[
 \delta_p=\frac{2p^2-p-5}{(p-1)^2(p+1)}\sim\frac2p       \tag{BC6}
\]

among the finite prime ideals of `K`, ordered by norm.
Indeed, in the Galois extension `K(E_0[p])/K`, Frobenius has trace
`t` and determinant `n` modulo `p`. The set (BC4) is conjugacy
invariant. Chebotarev applied to its finitely many conjugacy classes
gives (BC6) from (BC5).

The no-CM theorem for the fixed curve `E_0` and Serre's open-image
theorem imply that the full-image hypothesis holds for every
sufficiently large `p`. This is an eventual statement with no explicit
threshold claimed here. The original primary source states that the
adelic image is open and explicitly deduces equality of the mod-`p`
image with the full automorphism group for all but finitely many `p`.

All prime divisors of a norm occurring in (BC1), except possibly `p`,
are split rational primes whose two places lie in `S_p`. Thus actual
boundary-congruent pure norms have support in a moving Frobenius
condition whose density tends to zero, as well as the lower cutoff
(BC2). This is a necessary restriction, not a global obstruction:
for every fixed large `p` the allowed set has positive density and is
infinite. No estimate uniform in both `p` and the norm cutoff follows
from the fixed-extension Chebotarev statement used here. Nor does
sparse permitted prime support alone exclude a polynomial value whose
prime factors all lie in that support.

There is also a rational-prime formulation. At a split rational prime
`q>3`, the traces at the two places have the same square. Indeed, the
explicit two-isogeny identifies `E_0` with the `(-2)`-twist of its
conjugate up to isogeny; at good places this makes the two traces differ
by the quadratic sign `(-2/q)`. Therefore either both places are in
`S_p` or neither is. The permitted split rational primes consequently
have natural density `delta_p/2` among all rational primes, hence
asymptotic density `1/p` as `p` grows through the sufficiently large
primes for which the image is full. To verify the factor 1/2, count
prime ideals by norm: inert rational primes with norm at most `X` have
size at most `sqrt(X)` and contribute negligibly, whereas a permitted
split rational prime contributes two prime ideals. The split rational
primes themselves have density 1/2. This does not supply a
Chebotarev error estimate uniform in `p`.

The support set `S_p` is unchanged by the characters `nu` allowed in
BC1: away from 6 and `p` they only change a trace by sign. Thus the
density calculation does not need an image threshold uniform over
varying twists.

## BC4. All embeddings of the identified boundary orbit

Use the independent seventh-round BM1--BM4 identification of the
fixed-character boundary descent with the non-CM orbit at level 576.
Suppose the descended residual representation of an actual seed is
congruent to any coefficient embedding of that orbit at a place over
`p>7`. Restriction to `G_K` compares `E_{a,b}[p]` times the specified
character `chi` with `E_0[p]` times `chi^sigma`. This follows from the
algebraic Frobenius identities for the boundary newform, compatibility,
and semisimplicity; it is not inferred from finitely many coefficients.
The actual representation is absolutely irreducible by the checked
large-image input. Hence the resulting global semisimplified
isomorphism is the full module isomorphism used in BC1.

Since `chi` has order 4, a coefficient embedding fixes or inverts its
values. Therefore

\[
 \chi^\sigma/\chi\in\{1,\chi^{-2}\}
      =\{1,\psi_3|_{G_K}\}.
\]

Both characters are quadratic and unramified outside 6. Cancelling the
specified `chi` gives precisely the premise of BC1 with one of these
two characters `nu`; it need not give the untwisted isomorphism.
Consequently any actual seed residually congruent to any embedding
of the level-576 boundary orbit has a pure `p`-th power norm. For a
`p`-power-free decomposition `F=VQ^p`, this orbit cannot occur when
`V>1`. In the pure branch the support conditions remain necessary;
no impossibility assertion is made.

The BM modular identification is an explicit additional dependency
of BC4. BC1--BC3 themselves only use their stated Galois-module premise.

## What this adds to the remaining problem

The reduction from a boundary congruence to a pure norm is unconditional
given (BC1). It separates that particular fixed boundary representation
from moving nonunit residual branches. The moving-prime support sieve
is sharper than merely saying each fixed prime eventually disappears:
every divisor is at least `(sqrt(p)-1)^2`, and each satisfies a concrete
Frobenius equation. It provides an arithmetic condition to combine
with the independent affine-slice escape theorem and the two-step norm
constraints. None of these claims supplies (BC1), an isogeny, a uniform
seed-height bound, or an ABC proof.

## Primary sources actually checked

* The previous FM local Tate proofs, with their explicit actual-seed
  hypotheses, and Serre 1987 Section 2.9, Proposition 5, supply the local
  representation inputs. The Hasse bound is the standard elliptic-curve
  point bound used in the same sources.
* J.-P. Serre, *Proprietes galoisiennes des points d'ordre fini des
  courbes elliptiques*, Invent. Math. 15 (1972), 259--331. The original
  author-institution PDF was opened, downloaded as a source document,
  and printed pages 259--260 were actually rendered and visually read.
  In particular the introduction's assertions (3), (6), (7) give the
  open adelic image and eventual full mod-prime image:
  https://www.college-de-france.fr/media/jean-pierre-serre/UPL5874918517843398173_Serre_proprie_te_s_galoisiennes_des_courbes_elliptiques.pdf .
* J. S. Milne, *Algebraic Number Theory*, v3.08, Theorem 8.31 and its
  natural-density definition 8.30, were actually opened:
  https://www.jmilne.org/math/CourseNotes/ANT.pdf .

## Exact finite replay

`replay_boundary_support.py` was actually run with Python using only its
standard library. It exhaustively checks all four matrix entries for
`p=3,5,7,11,13,17,19`, verifies the two eigenvalue counts, their
intersection and union, and enumerates every affine pair in the eight
boundary reductions over `q=7,13,19,31`. The canonical UTF-8 LF JSON
`boundary_support_results.json` has SHA256
`d00b5cdcde7f73384dce4a6da72970938fcfb0d94e1f1419be9bbec6122c34a4`.
The general group proof is BC2; the finite checks supplement it.
The recorded divisibility test always retains `q` different from `p`.
No point-count row alone removes the case `q=p`.
