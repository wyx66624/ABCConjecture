# Torsion-line energy and the three Legendre directions

## 1. Purpose

This route seeks a classical, non-IUT source of the discriminant--conductor
inequality.  It uses local Neron functions on Tate curves and the special fact
that the Frey--Legendre family has only three Picard--Lefschetz directions.

The first results are unconditional local identities and symmetry
obstructions.  The remaining global theorem is stated explicitly at the end.

## 2. Local Tate-line energies

Let `K` be a complete nonarchimedean field, let `E_q/K` be a split Tate curve
with

\[
  L=-\log|q|>0,
\]

and let `ell>=3` be prime to the residue characteristic.  Assume `mu_ell` and
an `ell`-th root of `q` are present.  Write

\[
  B_2(t)=t^2-t+\frac16.
\]

For the standard Tate local Neron function, a point represented by `u` has

\[
 \lambda(u)
 =-\log|1-u|+\frac12 B_2(r(u))L,
\]

where `r(u)` is the radial coordinate modulo one.

The Bernoulli distribution relation gives

\[
  \sum_{j=0}^{\ell-1}B_2(j/\ell)=\frac1{6\ell},
\]

and hence

\[
  \sum_{j=1}^{\ell-1}B_2(j/\ell)
  =-\frac{\ell-1}{6\ell}.
\]

### Theorem 2.1 (canonical line)

For the canonical Tate line `C_can=mu_ell`,

\[
  \sum_{P\in C_{\rm can}\setminus\{0\}}\lambda(P)
  =\frac{\ell-1}{12}L.
\]

#### Proof

Every nonzero point is represented by a nontrivial root of unity.  Since the
residue characteristic does not divide `ell`, `|1-zeta|=1`, while the radial
coordinate is zero.  Thus each term is `B_2(0)L/2=L/12`.

### Theorem 2.2 (noncanonical line)

For every other cyclic order-`ell` subgroup `C`,

\[
  \sum_{P\in C\setminus\{0\}}\lambda(P)
  =-\frac{\ell-1}{12\ell}L.
\]

#### Proof

After choosing a Tate basis, the nonzero points of `C` may be represented as

\[
  u_j=\zeta^{tj}q^{j/\ell},
  \qquad 1\leq j\leq\ell-1.
\]

Here `|u_j|<1`, hence `|1-u_j|=1`.  Summing the Bernoulli terms gives the
stated value.

## 3. Full-torsion cancellation

There are `ell+1` cyclic order-`ell` lines in `E[ell]`: one canonical line and
`ell` noncanonical lines.

### Corollary 3.1

\[
  \sum_{P\in E[\ell]\setminus\{0\}}\lambda(P)=0.
\]

Indeed,

\[
  \frac{\ell-1}{12}L
  +\ell\left(-\frac{\ell-1}{12\ell}L\right)=0.
\]

This is a strict no-go result for the naive fully symmetric torsion average.
Averaging all nonzero `ell`-torsion points erases the multiplicative
`q`-parameter exactly.

## 4. Galois-symmetry obstruction

If the mod-`ell` representation is surjective, `GL_2(F_ell)` acts transitively
on `E[ell]\setminus{0}` and transitively on the projective line of cyclic
subgroups.  Consequently every Galois-stable subset of nonzero torsion points,
or of cyclic lines, is either empty or the full orbit.

Combined with Corollary 3.1, this proves:

### Theorem 4.1

A completely Galois-symmetric, unweighted torsion-energy construction cannot
recover a positive multiple of the Tate order.  Any successful torsion proof
must select or weight directions asymmetrically and must account for the field
of definition and the resulting different/Jacobian terms.

## 5. The three Legendre directions

For the Legendre family there are three distinguished vanishing-cycle lines,
corresponding to the boundary points `0,1,infinity`.  At a multiplicative
specialization, the local canonical Tate line is one of these three lines.

Let their total Tate weights be

\[
  W_0,W_1,W_\infty\geq0,
  \qquad W=W_0+W_1+W_\infty.
\]

Set

\[
  A_\ell=\frac{\ell-1}{12},
  \qquad
  B_\ell=-\frac{\ell-1}{12\ell}.
\]

If a fixed global line `d` is canonical exactly at the places belonging to
direction `d`, its finite multiplicative score is

\[
  S_d=A_\ell W_d+B_\ell(W-W_d).
\]

### Theorem 5.1 (three-direction concentration)

For some `d in {0,1,infinity}`,

\[
  S_d\geq
  \frac{(\ell-1)(\ell-2)}{36\ell}W.
\]

#### Proof

Choose `d` with `W_d>=W/3`.  Then

\[
 S_d
 =\frac{\ell-1}{12\ell}((\ell+1)W_d-W)
 \geq
 \frac{(\ell-1)(\ell-2)}{36\ell}W.
\]

### Corollary 5.2 (sum of the three packets)

\[
  S_0+S_1+S_\infty
  =\frac{(\ell-1)(\ell-2)}{12\ell}W.
\]

Thus the special three-direction geometry of the Frey--Legendre family avoids
the full-projective-line cancellation.

## 6. The remaining global theorem

Choose one of the three cyclic subgroups by Theorem 5.1 and pass to its field
of definition.  The global canonical height of every torsion point is zero, so
the positive finite multiplicative score must be cancelled by:

1. archimedean local Neron terms;
2. places above `ell`;
3. changes of integral model and the different of the line field.

A proof of abc along this route is reduced to the following concrete theorem.

### Target theorem 6.1 (three-line compensation bound)

For every `eta>0`, the selected line can be chosen so that

\[
 -\sum_{v\mid\infty,\,v\mid\ell,\,v\text{ non-multiplicative}}
   n_v\sum_{P\in C\setminus\{0\}}\lambda_v(P)
 \leq
 \left(\frac{(\ell-1)(\ell-2)}{36\ell}+\eta\right)
  (6+o_\ell(1))\log\operatorname{rad}(abc)
 +O_{\eta,\ell}(1).
\]

Together with Theorem 5.1 and the Frey identity
`log Delta_min = 2 log(abc)+O(1)`, an asymptotically sharp form of this bound
would imply the logarithmic abc inequality.

The theorem is not currently proved.  It is materially different from the
IUT Rosetta statement: every object here is a classical torsion subgroup,
local Neron function, and number-field place.  The branch remains active until
this compensation bound is proved or a concrete family disproves it.

## 7. Important negative result for the isogeny shortcut

The stable Faltings height changes by at most a logarithmic amount under an
`ell`-isogeny, while local minimal discriminant exponents of Tate parameters
`q` and `q^ell` differ by an arbitrarily large amount.  Hence an isogeny-height
inequality alone cannot control the local Tate order.  Any isogeny version of
Target theorem 6.1 must retain the local Neron/division-polynomial data rather
than replacing it only by stable Faltings heights.
