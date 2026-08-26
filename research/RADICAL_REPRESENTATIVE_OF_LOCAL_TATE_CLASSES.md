# One global radical representative for all local Tate Kummer classes

## 1. Statement

Retain the notation of the actual-root globalization theorem.  Let

\[
  P\text{ be finite},\qquad
  q_p\in\mathbb Q_p^\times,\qquad
  v_p(q_p)=N_p\ge1,
\]

and put

\[
  R=\prod_{p\in P}p\in\mathbb Q^\times.
\]

### Theorem 1.1

For every `eta>0`, there is a number field `K` satisfying

\[
 \log\operatorname{rd}(K)
 \le\log R+\eta\sum_{p\in P}N_p\log p+C_\eta,
\]

and, for every `p in P`, a place `w_p|p` and a unit

\[
  h_p\in\mathcal O_{K_{w_p}}^\times
\]

such that

\[
 \boxed{q_p=(R h_p)^{N_p}.}
\]

Equivalently, in the local Kummer quotient,

\[
 [q_p]=[R^{N_p}]
 \quad\text{in}\quad
 K_{w_p}^\times/(K_{w_p}^\times)^{N_p}.
\]

### Proof

The actual-root globalization theorem supplies `r_p in K_{w_p}` with

\[
 r_p^{N_p}=q_p,
 \qquad |r_p|_{w_p}=p^{-1}.
\]

Since `R` has the same normalized absolute value at `w_p`, the ratio

\[
 h_p=r_p/R
\]

is a unit.  Then `q_p=(Rh_p)^{N_p}`.  The field bound is unchanged.

## 2. Meaning

All valuation-one parts are represented by the **single rational radical
section** `R`.  The dependence on the actual unit parts of the Tate parameters
is moved entirely into local unit Kummer trivializations `h_p`.

This is stronger than merely constructing unrelated local roots.  It is the
correct input for a multi-root stack or adelic gerbe whose coarse global
section is the radical and whose stabilizer order at `p` is `N_p`.

## 3. Remaining obstruction

The exponents `N_p` vary with the place.  Therefore the identities

\[
 q_p=(Rh_p)^{N_p}
\]

do not arise from one ordinary global tensor-power identity of line bundles.
A global construction must use a multi-root stack, a place-dependent adelic
filtration, or another nonlinear object.

Moreover, any operation that locally reconstructs the ordinary `N_p`-th
tensor power restores the multiplicity by degree additivity.  Thus the theorem
closes the Kummer-class alignment problem but not the saturation-compensation
problem.

## 4. Precise next target

Construct an arithmetic multi-root stack `X(P,N)` and a canonical metrized
line `L_rad` with coarse section `R` such that:

1. the local `N_p`-power of `L_rad`, after the unit trivialization `h_p`, is the
   actual Tate/Hodge local object;
2. the stack degree of the distinguished section is `log R`;
3. the comparison with the original Frey height is mediated by the explicit
   saturation quotients, not by the excluded ordinary tensor reconstruction;
4. the total stack/descent/Jacobian defect is bounded by the root discriminant
   above and by sublinear level terms.

This is now a completely explicit stacky globalization problem rather than an
unspecified request to choose compatible local roots.
