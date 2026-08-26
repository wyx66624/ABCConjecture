# The Steinberg sup-packet route to the abc inequality

## 1. Why a nonlinear packet is needed

Let `ell>=3` be prime and let

\[
  \mathcal L_\ell=\mathbf P^1(\mathbf F_\ell)
\]

be the `ell+1` cyclic order-`ell` lines in a two-dimensional torsion module.
At a split Tate place, exactly one line `C_v` is canonical.  Put

\[
 A_\ell=\frac{\ell-1}{12},
 \qquad
 B_\ell=-\frac{\ell-1}{12\ell}.
\]

If `L_v=-\log|q_v|`, the cyclic-line Neron energies are

\[
 s_v(C)=
 \begin{cases}
 A_\ell L_v,&C=C_v,\\
 B_\ell L_v,&C\ne C_v.
 \end{cases}
\tag{1}
\]

The linear average vanishes because

\[
 A_\ell+\ell B_\ell=0.
\tag{2}
\]

Thus every argument which first averages the line coordinates projects the
local signal to zero.  This is the exact obstruction already proved for fixed
packets and generic full-orbit selectors.

The key observation is that (2) only kills the **trivial representation**.  The
whole local vector is nonzero in the augmentation, or Steinberg,
representation.  A permutation-invariant nonlinear norm can retain it.

## 2. The augmentation-vector identity

Let `1` denote the all-one vector and let `e_C` be the standard basis vector
at `C`.  Define

\[
 \Delta_\ell=A_\ell-B_\ell
 =\frac{\ell^2-1}{12\ell}.
\]

### Theorem 2.1

The local energy vector in (1) is

\[
 s_v
 =\Delta_\ell L_v
   \left(e_{C_v}-\frac1{\ell+1}\mathbf1\right).
\tag{3}
\]

In particular,

\[
 \sum_{C\in\mathcal L_\ell}s_v(C)=0,
\]

so `s_v` lies in the augmentation hyperplane

\[
 \operatorname{St}_\ell
 =\left\{(x_C):\sum_Cx_C=0\right\}.
\]

### Proof

At the canonical coordinate, the right side of (3) equals

\[
 \Delta_\ell L_v\frac\ell{\ell+1}
 =\frac{\ell-1}{12}L_v=A_\ell L_v.
\]

At every other coordinate it equals

\[
 -\Delta_\ell L_v\frac1{\ell+1}
 =-\frac{\ell-1}{12\ell}L_v=B_\ell L_v.
\]

The augmentation representation is the characteristic-zero Steinberg
constituent of the permutation representation on `P^1(F_ell)`.

## 3. The norm convention and exact finite-place recovery

For a conventional metrized evaluation section `tau_C`, one normally has

\[
  -\log\|\tau_C\|_v=s_v(C).
\]

The ordinary sup norm of the vector `(tau_C)_C` would therefore select the
**smallest** energy, not the canonical energy.  The packet must use the dual
coordinates

\[
  \sigma_C=\tau_C^{-1}\in\mathcal M_C^\vee
\]

(or an equivalent dual evaluation functional), normalized so that

\[
  \log\|\sigma_C\|_v=s_v(C).
\tag{4}
\]

This sign choice is essential and is part of the source theorem, not a harmless
notation change.

Equip the direct sum of these dual coordinates with the nonarchimedean sup
norm.  Equation (4) makes its logarithm the maximum of the energies.

### Theorem 3.1 (canonical-line selection without choosing a line)

For every `L>=0`,

\[
 \max_{C\in\mathcal L_\ell}s_v(C)=A_\ell L.
\tag{5}
\]

### Proof

For `ell>=1`, `A_ell>=0` and `B_ell<=0`.  Hence

\[
 B_\ell L\le0\le A_\ell L.
\]

The canonical coordinate is therefore the unique maximum when `L>0`.

The operation in (5) is invariant under every permutation of the cyclic
lines.  Consequently it survives transitive projective Galois action even
though no individual canonical line is globally fixed.  This is precisely
what the linear packet failed to do.

## 4. Archimedean smoothing costs only `O(log ell)`

At an archimedean place use the Euclidean norm on the `ell+1` dual coordinates.
Its logarithmic value for the two-valued packet is

\[
 \mathcal E_\ell(L)
 =\frac12\log\left(
   e^{2A_\ell L}+\ell e^{2B_\ell L}
  \right).
\]

### Theorem 4.1 (soft maximum)

For `L>=0`,

\[
 A_\ell L
 \le \mathcal E_\ell(L)
 \le A_\ell L+\frac12\log(\ell+1).
\tag{6}
\]

### Proof

The first summand inside the logarithm is `e^(2A_ell L)`, giving the lower
bound.  Since `B_ell L<=A_ell L`, every one of the `ell` remaining summands is
at most this first summand.  Hence the total is at most

\[
 (\ell+1)e^{2A_\ell L}.
\]

Taking one half of the logarithm proves (6).

After normalized summation over all archimedean embeddings, the discrepancy
between Euclidean and sup norms remains at most

\[
 \frac12\log(\ell+1),
\]

not this quantity multiplied by the field degree.

## 5. Descent as a Galois-invariant dual packet

Let `L/Q` be a field over which all cyclic lines and their evaluation
coordinates are defined.  Form the direct sum

\[
 \mathcal V_\ell
 =\bigoplus_{C\in\mathcal L_\ell}\mathcal M_C^\vee.
\]

Galois permutes the summands.  The tuple of all conjugate dual evaluation
sections is therefore a rational section of the descended permutation bundle.
The finite sup norm and the archimedean Euclidean norm are invariant under this
permutation action.

Taking duals may exchange zeros and poles.  Target theorem 7.1 must therefore
prove, rather than assume, that the chosen rational dual sections are integral
units at good finite places and that all boundary poles are exactly the Tate
energies in (4).  A failure of this good-place assertion would refute the
simplest form of the route.

The trivial summand records the cancelled average.  The local multiplicative
signal (3) lies in the Steinberg/augmentation summand.  Thus the correct global
object is not one chosen cyclic line and not the linear sum of all lines, but a
Galois-invariant dual vector whose local norm is nonlinear.

## 6. Arakelov maximal slope rather than total degree

Let `sigma_ell` be the descended packet section.  With the arithmetic-degree
sign convention matching (4), the line generated by this vector is bounded by
the maximal slope of the appropriate dual metrized bundle:

\[
 \widehat{\deg}(\mathcal O\sigma_\ell)
 \le \widehat\mu_{\max}(\overline{\mathcal V}_\ell).
\tag{7}
\]

A direct sum has rank `ell+1`, but (7) involves the **maximal slope**, not the
total degree.  Therefore the rank does not automatically multiply the desired
coefficient.

At every multiplicative finite place, Theorem 3.1 contributes

\[
 \frac{\ell-1}{12}(-\log|q_v|).
\]

If good finite places are integral units, the level-prime and descent defects
are `O(log ell)`, and

\[
 \widehat\mu_{\max}(\overline{\mathcal V}_\ell)
 \le
 \left(\frac{\ell-1}{2}+o(\ell)\right)
   (D+N)+O(\ell\log\ell),
\tag{8}
\]

then (5), (7), and (8) give

\[
 \frac{\ell-1}{12}Q
 \le
 \left(\frac{\ell-1}{2}+o(\ell)\right)(D+N)
 +O(\ell\log\ell).
\]

Dividing by `(ell-1)/2` yields

\[
 \frac16Q
 \le (1+o(1))(D+N)+O(\log\ell).
\tag{9}
\]

Together with the quantifier-correct auxiliary prime satisfying
`log ell=o(log c)`, (9) implies the logarithmic abc inequality.

## 7. The exact remaining theorem

The route is reduced to the following classical, falsifiable statement.

### Target theorem 7.1 (dual Steinberg packet slope theorem)

Construct the descended dual metrized packet
`V_ell` and its rational section `sigma_ell` so that:

1. at a multiplicative place its logarithmic coordinate norms are exactly the
   cyclic-line Neron energies in (1), with the dual convention (4);
2. the dual coordinates are integral units at good finite places;
3. the total normalized defect at primes above `ell` and in the descent field
   is `O(log ell)`;
4. the archimedean metric differs from the sup metric by at most
   `log(ell+1)/2`;
5. the maximal slope bound (8) holds with every metric, inversion divisor, and
   Jacobian explicitly normalized.

This theorem is independent of the disputed IUT prime-strip identification.
It may be attacked by determinant of cohomology, arithmetic invariant theory,
Bost slope inequalities, modular units, or the modular interpretation of the
Steinberg representation.

## 8. Relation to the previous no-go theorems

The full-average cancellation and the `1/(ell+1)` Minkowski barrier do not
refute this route.  They concern linear projections or selection of one global
line.  The dual sup packet uses the complete orbit, is Galois invariant, and
applies a nonlinear norm before global summation.

A future counterexample would have to show that no descended dual packet can
satisfy Target theorem 7.1, that inversion necessarily creates uncontrolled
good-place poles, or that its maximal slope carries a coefficient strictly
larger than `(ell-1)/2` by a nonvanishing proportion.  No such theorem is
presently known, so the route remains active.
