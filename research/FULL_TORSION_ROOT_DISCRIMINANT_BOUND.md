# Root discriminant of the full `ell`-torsion field

## 1. Statement

Let `E/Q` be a semistable elliptic curve, let `ell>=5` be prime, and assume

\[
 \ell\nmid N_E.
\]

Put

\[
 K=\mathbb Q(E[\ell]).
\]

Assume, as in the two-inertia selector used elsewhere in the repository, that
`ell` avoids every multiplicative Tate order which is required to give a
nonzero transvection.  Then

\[
 \boxed{
 \log\operatorname{rd}(K)
 \le
 \left(1-\frac1\ell\right)
 \log\operatorname{rad}(N_E)
 +2\log\ell.}
\tag{1.1}
\]

Here

\[
 \operatorname{rd}(K)=|D_K|^{1/[K:\mathbb Q]}.
\]

For a Frey curve with a fixed non-semistable contribution at `2`, the same
proof gives an additional absolute constant depending only on the fixed local
model at `2`.

Every subfield of `K`, including the field of definition of one cyclic line or
of a descended packet constituent, satisfies the same upper bound for its root
discriminant.

## 2. Good primes away from the level

### Lemma 2.1

If

\[
 p\nmid \ell N_E,
\]

then `p` is unramified in `K`.

#### Proof

The curve has good reduction at `p`, and `p` is different from `ell`.
Neron--Ogg--Shafarevich says that the prime-to-`p` Tate module, hence its
mod-`ell` quotient, is unramified.  The splitting field of `E[ell]` is
therefore unramified at `p`.

## 3. Multiplicative primes

Let `p|N_E`, with `p!=ell`.  Semistability makes the reduction
multiplicative.  In a Tate basis the inertia representation is

\[
 \sigma\longmapsto
 \begin{pmatrix}
 1&N_p t_\ell(\sigma)\\
 0&1
 \end{pmatrix},
\tag{3.1}
\]

where `N_p` is the local Tate order and the tame character
`t_ell:I_p -> F_ell` is surjective.  If `ell` does not divide `N_p`, the
inertia image has order exactly `ell`; otherwise its contribution is smaller.
Since `p!=ell`, this ramification is tame.

### Lemma 3.1

For every multiplicative prime,

\[
 \frac{v_p(D_K)}{[K:\mathbb Q]}
 \le 1-\frac1\ell.
\tag{3.2}
\]

#### Proof

The extension `K/Q` is Galois.  At a prime above `p`, let `e,f,g` be the common
ramification index, residue degree and number of primes, and let `d` be the
local different exponent.  Then

\[
 [K:\mathbb Q]=gef,
 \qquad
 v_p(D_K)=gfd,
\]

so the normalized exponent is `d/e`.  In the nontrivial case `e=ell` and tame
ramification gives `d=e-1`; hence `d/e=1-1/ell`.  In the trivial case it is
zero.

## 4. The level prime

We use the standard local different inequality.  If `M/Q_p` is finite, with
ramification index `e` and different exponent `d`, then

\[
 d\le e-1+v_M(e)
   =e-1+e\,v_p(e).
\tag{4.1}
\]

Consequently

\[
 \frac de\le 1-\frac1e+v_p(e).
\tag{4.2}
\]

### Lemma 4.1

At `p=ell`,

\[
 \frac{v_\ell(D_K)}{[K:\mathbb Q]}\le2.
\tag{4.3}
\]

#### Proof

The local Galois group is a subgroup of
`GL_2(F_ell)`, so its ramification index divides

\[
 |\operatorname{GL}_2(\mathbb F_\ell)|
 =\ell(\ell-1)^2(\ell+1).
\]

The `ell`-adic valuation of this integer is exactly one.  Thus

\[
 v_\ell(e)\le1.
\]

Apply (4.2).  Since the global extension is Galois, the normalized global
discriminant exponent is again `d/e`, which is at most two.

This argument does not require a separate finite-flat discriminant theorem;
the elementary local different bound and the exact group order suffice.

## 5. Global proof

Only the multiplicative primes and the level prime can ramify.  Summing Lemma
3.1 gives

\[
 \sum_{p\mid N_E}
 \frac{v_p(D_K)}{[K:\mathbb Q]}\log p
 \le
 \left(1-\frac1\ell\right)
 \log\operatorname{rad}(N_E).
\]

Lemma 4.1 contributes at most `2 log ell`.  This proves (1.1).

## 6. Subfields

If `L` is a subfield of `K`, the discriminant tower formula gives

\[
 |D_K|
 =|D_L|^{[K:L]}
  \operatorname{Norm}_{L/\mathbb Q}(D_{K/L}).
\]

The relative different has norm at least one, hence

\[
 \operatorname{rd}(L)\le\operatorname{rd}(K).
\tag{6.1}
\]

Thus (1.1) applies to every cyclic-line field and every field needed to descend
a permutation or Steinberg packet.

## 7. Consequences for the active routes

### 7.1 Steinberg packet

The descent-field contribution is now bounded by

\[
 \log\operatorname{rad}(N_E)+O(\log\ell),
\]

with coefficient tending to one.  It cannot be the source of an uncontrolled
`ell^4` loss despite the degree of the full torsion field.

### 7.2 Universal transverse isogeny

The root-discriminant estimate anticipated in the one-step tropical
radicalization branch is an actual consequence of local different theory.  The
remaining obstruction there is the archimedean/boundary compensation, not the
field discriminant.

### 7.3 IUT/ATS source audit

Any source construction which passes to the full level field may charge its
normalized different by the right side of (1.1).  A larger polynomial-in-ell
normalized discriminant charge is unnecessary.

## 8. Remaining arithmetic difficulty

The estimate controls the algebraic descent lattice.  It does not control the
archimedean norm of the theta or determinant packet.  Units in a fixed number
field can have arbitrarily uneven archimedean sizes, so root discriminant alone
cannot replace the required metrized maximal-slope theorem.  This distinction
prevents a circular claim of ABC.

## 9. Formalization plan

A Lean development can be separated into:

1. the numerical identity
   `|GL_2(F_ell)|=ell*(ell-1)^2*(ell+1)` and its exact `ell`-valuation;
2. the normalized Galois discriminant identity `v_p(D_K)/[K:Q]=d/e`;
3. the local different inequality (4.1), once exposed in the number-field
   library;
4. the finite sum over the conductor support.

No unresolved height inequality is inserted as an axiom.
