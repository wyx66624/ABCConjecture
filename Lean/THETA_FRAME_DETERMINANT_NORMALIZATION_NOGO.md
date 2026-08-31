# Theta-frame determinant normalization no-go

**Author:** ChatGPT  
**Date:** 2026-08-31

## Status

This note audits the pure-theta/transverse-frame route at the precise point
where a raw local theta-coefficient order was being interpreted as a new
multiplicative-place gain.  The determinant algebra proves that this
interpretation is invalid for either

- a full square frame determinant, or
- a fixed square row/column minor normalized by the matching source Pluecker
  coordinate.

In both cases the centered theta order is already the determinant order of the
chosen source coefficient columns and cancels under canonical source
normalization.

This is not a proof or disproof of the abc conjecture.  It removes one false
closure mechanism and isolates the stronger slope theorem that would actually
be needed.

## 1. Local coefficient lattice

Let `ell=2m+1` be odd and let `r(j)` be the centered representative of
`j mod ell` in `{-m,...,m}`.  For a Tate parameter root `s` with
`s^ell=q`, the rank-two residue-class theta coefficient has the form

\[
 A_z(s)=s^{|r(z)|^2}U_z(s),
 \qquad U_z(s)\in\mathcal O^\times.
\]

Thus

\[
 \operatorname{ord}(A_z)
 =\frac{|r(z)|^2}{\ell}\operatorname{ord}(q).
\]

For the even two-dimensional coordinates modulo sign, the complete diagonal
coefficient lattice is

\[
 D(q)=\operatorname{diag}(A_z(q))_{z\in Z}.
\]

Its determinant order is

\[
 \operatorname{ord}\det D(q)
 =\sum_{z\in Z}\operatorname{ord}(A_z(q)).
\]

The centered sum is

\[
 \sum_{j\in\mathbf F_\ell}r(j)^2
 =\frac{\ell(\ell^2-1)}{12}.
\]

Consequently, after the two-dimensional/sign-orbit bookkeeping and the
substitution `s^ell=q`, the complete raw order is

\[
 S_\ell(q)
 =\frac{\ell(\ell^2-1)}{12}\operatorname{ord}(q).
\tag{1.1}
\]

This is the previously observed one-sixth packet coefficient.  The point of
the present audit is that (1.1) is a **source determinant baseline**, not yet
an improvement over that source.

## 2. Exact determinant and minor factorization

Let `Phi` be a phase/frame matrix on the same coordinate set.  The transformed
coefficient matrix is

\[
 F(q)=\Phi D(q).
\]

Ordinary determinant multiplicativity gives

\[
 \boxed{
 \det F(q)=\det\Phi\cdot\det D(q).
 }
\tag{2.1}
\]

Equivalently,

\[
 \operatorname{ord}\det F(q)
 =S_\ell(q)+\operatorname{ord}\det\Phi.
\tag{2.2}
\]

There is an equally exact Pluecker version.  Choose square row and column
index sets `I,J`.  Since the diagonal matrix scales the column indexed by
`z` by `A_z`,

\[
 \boxed{
 \det F_{I,J}(q)
 =\det\Phi_{I,J}\prod_{z\in J}A_z(q).
 }
\tag{2.3}
\]

Thus even a proper fixed-column minor contains exactly the determinant of its
matching source columns; it does not acquire a second copy of their tropical
weight.

The accompanying Lean module proves (2.1) and (2.3) over an arbitrary
commutative ring.  It uses only `det(AB)=det(A)det(B)`, the determinant formula
for a diagonal matrix, and the entrywise identity for a selected submatrix.

## 3. Canonical normalization cancels the q-order

A determinant comparison between the transformed and source theta lattices
must divide by the determinant line of the source lattice.  Subtracting the
source order from (2.2) gives

\[
 \boxed{
 \operatorname{ord}\det F(q)
 -\operatorname{ord}\det D(q)
 =\operatorname{ord}\det\Phi.
 }
\tag{3.1}
\]

For a fixed minor, subtracting the order of its matching source Pluecker
coordinate gives

\[
 \boxed{
 \operatorname{ord}\det F_{I,J}(q)
 -\sum_{z\in J}\operatorname{ord}A_z(q)
 =\operatorname{ord}\det\Phi_{I,J}.
 }
\tag{3.2}
\]

Hence the selected diagonal weight cancels exactly.  If the phase matrix
consists of roots of unity or an integral finite Fourier/convolution
transform, its remaining order is a level term; it is independent of the
unbounded Tate order `ord(q)` away from the level prime.

The Lean module also proves the scalar consequence that a scale-independent
phase order cannot satisfy any uniform positive linear lower bound

\[
 \alpha Q+C
 \le
 \bigl(\text{frame/minor order}\bigr)
 -\bigl(\text{matching source order}\bigr),
 \qquad \alpha>0,
\]

for all nonnegative `Q`.

## 4. Why the pure theta extension does not restore the raw gain

The pure theta extension is valuable because it puts the complex Riemann theta
norm, the nonarchimedean tropical theta correction, the Hodge line, and the
boundary divisor into one canonical adelic line.  Precisely for that reason,
the source determinant or source Pluecker line cannot be silently discarded.
A local basis change contributes the determinant of the change-of-basis
minor, not the full volume of the chosen source columns a second time.

Thus the raw centered sum (1.1) cannot be divided by the packet cardinality and
inserted as an independent `Q/6` term while the Hodge/source determinant is
normalized separately.  That would count the same theta-lattice determinant
order twice.

## 5. Consequence for the former determinant target

A proposed target of the form

\[
 \operatorname{ord}\Delta_J^\theta
 \ge
 \frac{\ell-1}{12}Q-O(\ell)N
\]

cannot be obtained from `Phi*diag(A_z)` after normalization by the matching
source determinant line.  Its `Q`-dependent diagonal order is exactly the
source baseline and disappears in the relative determinant.  Choosing a
fixed proper minor does not alter this conclusion when it is normalized by
the same source columns.

Any valid theorem with a surviving positive `Q` coefficient must therefore
compare objects whose canonical source and target boundary weights are not
identical.

## 6. The genuine surviving target: a nonmatching slope theorem

The determinant no-go does not exclude the following stronger mechanisms.

1. **A nonmatching Harder--Narasimhan comparison.**  A globally defined target
   subspace could be compared with a different canonical source filtration,
   rather than with the same selected columns.  The needed gain is then an
   actual slope imbalance, not the determinant weight of those columns.
2. **A nonlinear adelic section.**  Products, resultants, or wedge sections
   with a genuinely different line-bundle weight may have a divisor not equal
   to a matching diagonal baseline plus a constant phase term.
3. **A cross-label comparison.**  Different theta labels could carry distinct
   canonical source lines; an honest comparison theorem would have to compute
   the complete divisor of the morphism between those lines.
4. **A quotient with a proved degree imbalance.**  One must exhibit an
   integral map whose target determinant line has a smaller canonical
   multiplicative boundary degree while its Hodge, level, descent, and complex
   costs remain controlled.

The exact next theorem is therefore not “find a nonzero full frame minor,” nor
“choose a fixed proper minor with large raw diagonal weight.”  It is:

> Construct a globally algebraic theta subspace or nonlinear packet section
> whose target line has a provably different canonical boundary degree from
> the source line used for normalization, and prove a positive
> conductor-uniform slope excess while the total Hodge, level, descent, and
> archimedean loss is `o(ell)(D+N)+O(ell log ell)`.

No such slope theorem is inserted as an axiom in the repository.

## 7. Research decision

The full square determinant and matching-column Pluecker routes are retired as
sources of a positive normalized `Q` coefficient.  The following ingredients
remain useful:

- the exact centered theta weights;
- the irreducible-symmetric finite frame;
- the integral phase/convolution determinant;
- the pure theta metric and adelic key formula;
- algebraic norm selection.

They must now be assembled through a genuinely nonmatching slope or nonlinear
divisor calculation rather than by reusing the determinant weight of the same
coefficient columns.
