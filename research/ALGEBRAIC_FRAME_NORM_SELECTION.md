# Algebraic frame determinants and simultaneous archimedean selection

## 1. The selection problem

A finite theta-frame inequality at one complex embedding says that some
transverse kernel gives a large theta evaluation.  The maximizing kernel may
vary with the embedding of the level field.  Choosing one kernel independently
at every embedding would not define an algebraic object and cannot be inserted
into the number-field product formula.

The correct replacement is a **single nonzero algebraic frame minor**.  Its
Galois conjugates are automatically evaluated at all embeddings, and the
number-field product formula controls their product.  This note proves the
abstract arithmetic lemma needed for that passage.

## 2. Product-formula lower bound

Let `K` be a number field of degree `d`, let `alpha in K^x`, and normalize the
absolute values so that

\[
 \sum_{v} n_v\log|\alpha|_v=0.
\tag{2.1}
\]

For a finite set `S` of nonarchimedean places define the denominator charge

\[
 \operatorname{den}_S(\alpha)
 =\sum_{v\in S} n_v
   \max\{0,\log|\alpha|_v\}.
\tag{2.2}
\]

### Theorem 2.1 (algebraic norm selection)

Assume

\[
 |\alpha|_v\le1
 \qquad(v<\infty,\ v\notin S).
\tag{2.3}
\]

Then

\[
 \boxed{
 -\sum_{v\mid\infty}n_v\log|\alpha|_v
 \le\operatorname{den}_S(\alpha).}
\tag{2.4}
\]

Equivalently, the normalized geometric mean satisfies

\[
 \boxed{
 \prod_{v\mid\infty}|\alpha|_v^{n_v/d}
 \ge
 \exp\left(-\frac1d
  \operatorname{den}_S(\alpha)\right).}
\tag{2.5}
\]

#### Proof

By (2.1),

\[
 -\sum_{v\mid\infty}n_v\log|\alpha|_v
 =\sum_{v<\infty}n_v\log|\alpha|_v.
\]

Every summand outside `S` is nonpositive by (2.3).  Discarding those terms and
then replacing each remaining term by its positive part gives (2.4).
Exponentiation proves (2.5).

### Corollary 2.2

If `alpha` is an algebraic integer, then

\[
 \prod_{v\mid\infty}|\alpha|_v^{n_v/d}\ge1.
\tag{2.6}
\]

This is the familiar fact that the nonzero integral norm is a nonzero integer,
but Theorem 2.1 retains the precise denominator budget required for level and
different places.

## 3. Application to a theta-frame minor

Let `Phi` be the finite phase matrix of the irreducible-symmetric transverse
packet, with columns indexed by the even theta coordinates.  The positive
frame theorem proves that `Phi` has full column rank.  Hence some square minor
`Phi_J` has nonzero determinant.

Suppose the universal theta construction produces, over a finite level field
`K`, integral theta lattices and a corresponding algebraic matrix

\[
 \widetilde\Phi_J
\]

whose complex realizations are the finite phase minors multiplied by explicit
metric and theta-trivialization factors.  Put

\[
 \alpha_J=\det\widetilde\Phi_J\in K^\times.
\]

If:

1. `alpha_J` is integral at every good place away from `ell`;
2. its denominators at the remaining places are bounded by
   \[
   O(\ell\log\ell)+o(\ell)(D+N),
   \]

then Theorem 2.1 gives a simultaneous lower bound for the product of all
archimedean determinant norms.  No kernel has to maximize separately at each
embedding.

## 4. Combining Cauchy--Binet with the product formula

At a fixed complex embedding, Cauchy--Binet gives

\[
 \sum_{|J|=d}|\det\Phi_J|^2
 =\det(\Phi^*\Phi).
\tag{4.1}
\]

The exact Gram eigenvalues make the right-hand side explicit and positive.  A
pointwise argument selects a large minor at one embedding, but the algebraic
argument should instead form the product of the conjugate minors, or one
Galois-stable norm of the Plucker vector

\[
 \bigwedge^d\Phi.
\]

The invariant squared norm

\[
 \|\bigwedge^d\Phi\|^2
 =\det(\Phi^*\Phi)
\tag{4.2}
\]

is independent of the chosen coordinate minor.  Therefore a clean global
formulation is to construct the **Plucker determinant line** of the pure-theta
frame and apply Theorem 2.1 to a nonzero integral Plucker section.

This avoids two artificial losses:

- multiplying by the number of candidate kernels;
- making incompatible embeddingwise choices.

## 5. Exact revised source theorem

The integral pure-theta frame target may now be stated as follows.

### Target theorem 5.1 (integral Plucker theta section)

Construct a nonzero algebraic Plucker section

\[
 \mathfrak p_\ell
 \in
 \det(\mathscr T_\ell)^{\vee}
 \otimes
 \bigwedge^d\mathscr P_\ell
\]

for the transverse pure-theta evaluation map, and prove:

1. **good-place integrality:**
   `|p_ell|_v<=1` away from the conductor and `ell`;
2. **multiplicative tropical order:** its local norm contains
   \[
   \frac{\ell-1}{12}Q-O(\ell)N;
   \]
3. **level/descent denominator:** the total positive finite logarithmic norm is
   \[
   O(\ell\log\ell)+o(\ell)(D+N);
   \]
4. **complex frame metric:** its archimedean norm agrees with the Plucker norm
   whose square is the exact Gram determinant.

Then Theorem 2.1 supplies the required simultaneous archimedean lower bound,
and the pure-theta key formula yields

\[
 \frac{\ell-1}{12}Q
 \le
 \left(\frac{\ell-1}{2}+o(\ell)\right)(D+N)
 +O(\ell\log\ell).
\]

## 6. Research consequence

The global-selection issue is therefore not an independent obstruction.  It is
absorbed into the construction and integrality of one exterior-power theta
section.  The truly unresolved local calculation is the elementary-divisor
profile of that Plucker section at multiplicative and level places.

This refinement applies equally to the classical transverse-isogeny route and
to any IUT/ATS source which proposes to select different local theta pilots:
the local choices must arise from one global algebraic exterior-power section,
or their simultaneous product must be justified by an equivalent norm
argument.

## 7. Formalization plan

Theorem 2.1 can be formalized independently once the normalized product formula
for number fields is exposed in the imported height libraries.  Before that,
its finite real-sum core can be kernel-checked as a lemma saying that a zero
sum, nonpositive terms outside `S`, and positive-part bounds on `S` imply the
archimedean inequality.  The Plucker construction is postponed until the
integral theta morphism is fixed; no placeholder source field is introduced.
