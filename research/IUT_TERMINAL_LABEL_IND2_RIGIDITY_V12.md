# Ind2 symmetry rigidity at the coefficient-two frontier

**Author:** ChatGPT  
**Date:** 2026-08-29

The terminal-label computation gives the sharp nonnegative label coefficient

\[
C_{\rm term}(n)=2+\frac{3}{n-1},
\]

but a point mass at the terminal label is not invariant under the full label
permutation ambiguity.

Let `L` be a finite nonempty label type and let

\[
w:L\to\mathbf R
\]

satisfy

\[
w(\sigma i)=w(i)
\]

for every permutation `sigma` of `L` and every label `i`.  Swapping any two
labels immediately gives

\[
w(i)=w(j),
\]

so `w` is constant.  If additionally

\[
\sum_{i\in L}w(i)=1,
\]

then

\[
w(i)=\frac1{|L|}
\]

for every label.  Thus every normalized full-Ind2-invariant linear reading is
exactly the arithmetic average.

On a label set with at least two elements, the terminal point mass

\[
\delta_t(i)=\begin{cases}1&i=t,\\0&i\ne t\end{cases}
\]

fails invariance under the transposition of `t` with another label.

Consequently the terminal-label coefficient cannot be extracted by merely
changing convex weights while retaining unrestricted Ind2 permutation
invariance.  One of the following genuinely geometric statements is required:

1. a source-derived terminal label that survives the relevant Ind2
   identifications;
2. a quotient or invariant carrying a canonical terminal orbit rather than a
   completely symmetric label set;
3. an Ind2 reduction theorem proved before applying the terminal projection;
4. a non-linear or signed construction whose validity is established directly
   from the Hodge-theater source and does not rely on monotonicity of a convex
   packet average.

The accompanying Lean module
`IUTTerminalLabelInd2Rigidity.lean` proves the finite symmetry statements
without assuming IUT III, modified Szpiro, or the abc conjecture.
