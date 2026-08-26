# Projective torsion-line oscillation

## 1. Motivation

At a split Tate place, one cyclic `ell`-line is canonical and the other `ell`
lines are noncanonical.  Their local Neron/theta slopes are

\[
  A_\ell=\frac{\ell-1}{12},
  \qquad
  B_\ell=-\frac{\ell-1}{12\ell}.
\]

Linear Galois averaging gives

\[
  A_\ell+\ell B_\ell=0,
\]

which rigorously excludes every fixed place-independent linear packet.  This
note studies nonlinear, projectively invariant statistics of the same orbit.
They survive the averaging no-go theorem and do not require selecting one
Galois-noncanonical line.

## 2. Exact oscillation and energy

Let `L>0` be the local Tate weight.  Define a vector indexed by
`P^1(F_ell)` whose canonical coordinate is `A_ell L` and whose other
coordinates are `B_ell L`.

### Theorem 2.1 (projective oscillation)

The coordinate oscillation is

\[
  \operatorname{osc}_\ell(L)
  :=\max_C s_C-\min_C s_C
  =\frac{\ell^2-1}{12\ell}L.
\]

### Proof

The maximum is `A_ell L`, the minimum is `B_ell L`, and

\[
 A_\ell-B_\ell
 =\frac{\ell-1}{12}
  +\frac{\ell-1}{12\ell}
 =\frac{\ell^2-1}{12\ell}.
\]

This quantity is unchanged by a permutation of the cyclic lines and by adding
the same scalar to every coordinate.  It is therefore a genuine projective,
Galois-invariant statistic.

### Theorem 2.2 (quadratic energy)

The centered quadratic energy is

\[
  \sum_Cs_C^2
  =\frac{(\ell-1)^2(\ell+1)}{144\ell}L^2.
\]

### Proof

Use one canonical and `ell` noncanonical coordinates:

\[
 A_\ell^2+\ell B_\ell^2
 =\frac{(\ell-1)^2}{144}
  +\frac{(\ell-1)^2}{144\ell}.
\]

## 3. Projective theta packet

Suppose the cyclic lines carry nonzero algebraic theta/evaluation quantities
`theta_C`.  At a split Tate place, normalize their local logarithmic norms so
that

\[
  -\log|\theta_C|_v=s_C+O_\ell(1).
\]

The projective point

\[
  \Theta_\ell(E)
  =[\theta_C]_{C\in\mathbb P^1(\mathbb F_\ell)}
\]

is invariant under common rescaling and its Galois conjugates merely permute
coordinates.  Its local projective diameter

\[
  \max_{C,D}\log\left|\frac{\theta_C}{\theta_D}\right|_v
\]

therefore has main term

\[
  \frac{\ell^2-1}{12\ell}L.
\]

Unlike a linear average, this term cannot cancel under the transitive
projective Galois action.

## 4. Exact global target

A proof of `abc` would follow from a construction of the packet above with the
following properties.

### Target theorem 4.1 (projective theta-height bound)

For every sufficiently large auxiliary prime `ell`, construct a projective
packet over a number field such that:

1. at every multiplicative place its projective diameter has the main term
   from Theorem 2.1;
2. at every good finite place it has integral projective diameter zero;
3. the level-prime and field-of-definition contribution is `O(log ell)` after
   normalized degree;
4. its global projective height satisfies

   \[
   h_{\rm proj}(\Theta_\ell(E))
   \le
   \frac{\ell^2-1}{2\ell}
   \bigl(\log\operatorname{Diff}
      +\log\operatorname{Cond}\bigr)
   +o(\ell)\,\log\operatorname{Cond}
   +O(\ell\log\ell).
   \]

Dividing the local oscillation coefficient by the leading global coefficient
would give the required factor `1/6`.

## 5. Why the target is genuinely different from the excluded packets

The fixed-packet no-go theorem applies to a linear functional of the orbit.
The projective diameter is nonlinear:

\[
  \operatorname{osc}(s+c\mathbf1)=\operatorname{osc}(s),
  \qquad
  \operatorname{osc}(\sigma s)=\operatorname{osc}(s).
\]

It therefore survives both common metric rescaling and Galois permutation.
It also avoids choosing one line before taking the global product formula.

## 6. Remaining difficulty and falsifiability

A generic height bound for arbitrary modular functions is too weak: it is
linear in the ordinary `j`-height and therefore restores the full
multiplicity.  Target theorem 4.1 needs special integral relations among the
cyclic-line theta values, or a sharp determinant/maximal-slope theorem.

The route can be rejected only after proving one of the following:

- every algebraic packet with the local oscillation of Theorem 2.1 has global
  projective height at least a fixed positive multiple of the full Frey
  height; or
- the required integral good-place packet cannot exist; or
- an explicit family violates the proposed conductor-level upper bound.

No such no-go theorem is presently known.  The route remains independent of
both the linear torsion packet and the IUT prime-strip comparison.
