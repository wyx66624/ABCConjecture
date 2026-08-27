# Conservative Transfer and the Global Defect Budget

**Author:** ChatGPT  
**Status:** unconditional finite-dimensional theorem; not an assertion of the abc conjecture

## 1. Purpose

A large class of proposed routes toward the abc conjecture repeatedly performs
one or more of the following operations on a finite packet of local logarithmic
quantities:

1. relabelling or Galois permutation;
2. averaging over a projective orbit;
3. degree-weighted transport between finite extensions;
4. passage to a product packet followed by marginalization;
5. replacement of one coordinate system by another coordinate system that is
   required to preserve a global product formula.

Such operations may change individual local coordinates dramatically.  The
following theorem shows that, as long as the operation preserves the global
weight, it cannot by itself create a strict global height gain.  Every global
gain is exactly the weighted mass of an additional defect term.  Thus a
successful proof route must identify and estimate a genuinely nonconservative
source term; relabelling, averaging, and conservative transport alone cannot
supply the decisive inequality.

## 2. Definitions

Let `I` be a finite nonempty index set.  Let

\[
  w=(w_i)_{i\in I}\in \mathbb R^I,
  \qquad x=(x_i)_{i\in I}\in \mathbb R^I.
\]

Define the weighted global mass

\[
  E_w(x):=\sum_{i\in I}w_i x_i.
\]

Let `T=(T_{ij})_{i,j\in I}` be a real matrix, acting by

\[
  (Tx)_i:=\sum_{j\in I}T_{ij}x_j.
\]

We call `T` **`w`-conservative** when

\[
  \sum_{i\in I}w_iT_{ij}=w_j
  \qquad\text{for every }j\in I,
\]

or equivalently `w^T T=w^T`.  No positivity or stochasticity hypothesis is
needed for the algebraic theorem.

## 3. Main theorem

### Theorem 3.1 — conservative-transfer identity

If `T` is `w`-conservative, then for every `x\in\mathbb R^I`,

\[
  E_w(Tx)=E_w(x).
\]

More generally, for every defect vector `d\in\mathbb R^I`,

\[
  E_w(Tx+d)=E_w(x)+E_w(d).
\]

#### Proof

By finiteness of `I`, the two sums may be interchanged.  Hence

\[
\begin{aligned}
E_w(Tx)
  &=\sum_i w_i\sum_jT_{ij}x_j\\
  &=\sum_j\left(\sum_iw_iT_{ij}\right)x_j\\
  &=\sum_jw_jx_j\\
  &=E_w(x).
\end{aligned}
\]

Linearity then gives

\[
  E_w(Tx+d)=E_w(Tx)+E_w(d)=E_w(x)+E_w(d).
\]

This proves both assertions.  ∎

### Corollary 3.2 — exact strict-gain criterion

Under the hypotheses of Theorem 3.1,

\[
  E_w(x)<E_w(Tx+d)
  \quad\Longleftrightarrow\quad
  E_w(d)>0.
\]

In particular, if `E_w(d)\le 0`, then the transformed packet cannot have a
strictly larger weighted global mass.

#### Proof

The defect identity rewrites the proposed strict inequality as

\[
  E_w(x)<E_w(x)+E_w(d),
\]

which is equivalent to `E_w(d)>0`.  ∎

## 4. Two-stage form

Let `T` and `S` both be `w`-conservative, and let `d_1,d_2\in\mathbb R^I`.
Starting with `x`, form

\[
  y=Tx+d_1,
  \qquad z=Sy+d_2.
\]

### Theorem 4.1 — two-stage defect budget

\[
  E_w(z)=E_w(x)+E_w(d_1)+E_w(d_2).
\]

Consequently,

\[
  E_w(x)<E_w(z)
  \quad\Longleftrightarrow\quad
  E_w(d_1)+E_w(d_2)>0.
\]

#### Proof

Apply Theorem 3.1 first to the `S`-stage and then to the `T`-stage:

\[
\begin{aligned}
E_w(z)
 &=E_w(Sy+d_2)\\
 &=E_w(y)+E_w(d_2)\\
 &=E_w(Tx+d_1)+E_w(d_2)\\
 &=E_w(x)+E_w(d_1)+E_w(d_2).
\end{aligned}
\]

The strict-gain equivalence follows by cancellation of `E_w(x)`.  ∎

The same argument iterates: in any finite cascade of `w`-conservative stages,
the final global change is the sum of the weighted defect masses and nothing
else.

## 5. Consequences for abc research routes

### 5.1 Packet and orbit methods

A permutation matrix, an average of weight-preserving permutations, or a
projective-orbit averaging operator is `w`-conservative whenever it preserves
the chosen global degree weights.  Therefore such operations cannot manufacture
a positive global coefficient from a balanced local packet.  A successful
variant must introduce a rigorously identified defect, for example through a
nonlinear truncation, a boundary term, a different/conductor contribution, an
archimedean term, or a genuinely source-dependent nonstationary selection.

### 5.2 IUT route

In an IUT-style argument, identifications among labels, procession averaging,
product-packet marginalization, and degree-compatible transport should be
classified as conservative layers whenever they preserve the global product
formula.  The decisive height inequality must therefore enter through a
source-derived defect or upper bound that is not merely another conservative
re-expression of the q-pilot.  In particular, inhabiting a bridge by copying
the desired abc estimate into a field does not construct such a defect.

This theorem does not decide whether the required nonconservative term exists
in the full IUT source.  It gives a falsifiable audit criterion: every claimed
strict improvement must display the exact defect and prove that its weighted
mass has the required sign and magnitude.

### 5.3 Frey–Szpiro and modular routes

For Frey-curve packets, isogeny transport, Galois averaging, and extension-degree
normalization are likewise conservative when they preserve the relevant global
height pairing.  The decisive gain must then come from a nonconservative
arithmetic input such as a sharp conductor/discriminant comparison, a bounded
local correction, or a genuinely asymmetric selection theorem.  If all extra
terms have nonpositive total weighted mass, the route is ruled out by
Corollary 3.2 without discarding any stronger successor that changes the defect.

## 6. Lean formalization contract

The companion Lean module is required to prove, without `sorry`, `admit`, or a
new axiom:

- `weightedMass_transfer`;
- `weightedMass_transfer_add_defect`;
- `globalChange_eq_defectMass`;
- `strictGlobalGain_iff_positiveDefectMass`;
- `noStrictGlobalGain_of_defectMass_nonpos`;
- `twoStage_defectBudget`;
- `twoStage_strictGlobalGain_iff`.

The formal statements use arbitrary finite index types and real weights.  They
therefore cover signed product-formula normalizations as well as ordinary
nonnegative probability weights.

## 7. Boundary of the result

The theorem is an unconditional structural obstruction, not a proof or a
disproof of the abc conjecture.  It eliminates only arguments in which all
purported sources of strict gain are conservative.  It deliberately leaves
open every route that supplies a mathematically genuine defect term and proves
a sufficiently strong global estimate for that term.
