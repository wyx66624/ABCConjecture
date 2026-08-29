# Procession-coherent Ind2 actions fix the terminal label

**Author:** ChatGPT  
**Date:** 2026-08-29

## 1. The nested-label observation

The standard procession is the diagram

\[
S_2\hookrightarrow S_3\hookrightarrow\cdots\hookrightarrow S_{n+1},
\qquad
S_{r+1}=\{0,1,\ldots,r\}.
\]

The `r`-th enlargement adds exactly one new label, namely `r`.  Consider a
family of permutations

\[
\sigma_r:S_{r+1}\xrightarrow{\sim}S_{r+1}
\]

that is natural with respect to every procession inclusion:

\[
\iota_{r,s}\circ\sigma_r
 =\sigma_s\circ\iota_{r,s}.
\]

Then each newly added label after the first capsule is fixed.

Indeed, naturality implies that `sigma_s` carries the old subset `S_s` into
itself.  Since its restriction to that finite subset is injective, it is a
bijection of the old subset.  The one-point complement

\[
S_{s+1}\setminus S_s=\{s\}
\]

must therefore also be preserved, so `sigma_s(s)=s`.

Inductively, a coherent permutation family can at most interchange the two
labels of the first capsule; all subsequently introduced labels are fixed.  In
particular, for `n>=2`, the terminal label `n` in the last capsule is fixed.

## 2. Consequence for the coefficient-two route

The previous v12 modules prove two facts:

1. the terminal label gives the optimal nonnegative coefficient
   \[
   2+\frac3{n-1};
   \]
2. a terminal point-mass reading is invariant precisely under the stabilizer
   of the terminal label.

The coherent-procession theorem now shows that any Ind2 action natural on the
whole standard procession automatically lies in that stabilizer.  Thus the
symmetry obstruction is not necessarily the full symmetric group.  It reduces
to the following concrete source question:

> Do the genuine IUT III Ind2 identifications form a natural automorphism of
> the procession diagram, or are independent capsule permutations genuinely
> allowed after all cross-capsule identifications are imposed?

A positive naturality theorem would make the terminal reading compatible with
Ind2 without assuming the abc conjecture, a Szpiro bound, or a desired volume
inequality.

## 3. Remaining geometry

Even after coherent Ind2 is established, the following are still needed:

- global assembly of the locally reachable terminal square regions;
- compatibility with the public packet coordinates and cross-capsule
  Hodge-theater identifications;
- a mono-analytic hull upper estimate retaining the terminal q-gain;
- uniform control of different, conductor, archimedean and exceptional terms.

The new result eliminates one candidate obstruction: unrestricted terminal
motion is impossible for a diagram-natural Ind2 action.  It does not assert
that the genuine IUT source has already been proved diagram-natural.

## 4. Lean formalization

`IUTProcessionCoherentInd2.lean` defines a coherent permutation family on an
arbitrary procession and proves for the standard procession:

- successive-capsule naturality fixes the new label;
- every noninitial new label is fixed;
- the terminal label is fixed for procession length at least two.

No conjectural arithmetic or geometric statement is stored as a field.
