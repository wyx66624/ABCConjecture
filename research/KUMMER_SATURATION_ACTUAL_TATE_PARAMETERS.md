# Kummer saturation of actual local Tate parameters

## 1. Purpose

This route replaces the toy extensions `Q(p^(1/N_p))` by number fields whose
completions contain roots of the **actual** local Tate parameters

\[
  q_p=p^{N_p}u_p\in\mathbb Q_p^\times,
  \qquad u_p\in\mathbb Z_p^\times.
\]

The construction has normalized root-discriminant cost equal to the radical
plus an arbitrarily small multiple of the full multiplicity mass.  A second
theorem proves that ordinary isometric tensor-root extraction does not by
itself remove multiplicity; a successful continuation must therefore use a
stacky, nonlinear, determinant, or maximal-slope operation.

No IUT theorem and no `abc` conclusion is assumed.

## 2. Multiplicity notation

Let `P` be a finite set of rational primes.  For every `p in P`, let
`N_p>=1`, and put

\[
 H(P,N)=\sum_{p\in P}N_p\log p,
 \qquad
 R(P)=\prod_{p\in P}p.
\]

We use the uniform entropy facts

\[
 \sum_{p\in P}\log(N_p+1)
 \le \eta H(P,N)+C_\eta,
\]

and

\[
 |P|\le \eta H(P,N)+C'_\eta
\]

for every `eta>0`.  They follow by splitting the primes at one fixed cutoff:
large primes absorb each local cost into `N_p log p`, while only finitely many
small primes remain and their logarithmic growth is absorbed by
`log(1+H/log 2)=o(H)`.

## 3. A quantitative local power lemma

For a prime `p` and a positive integer `N`, write `s=v_p(N)` and define

\[
 k_p(N)=
 \begin{cases}
 s+1,&p\ne2,\\
 s+2,&p=2.
 \end{cases}
\]

### Lemma 3.1

If

\[
 x\in1+p^{k_p(N)}\mathbb Z_p,
\]

then `x` is an `N`-th power in `Q_p^x`.

### Proof

Write `N=p^sN_0`, with `N_0` a `p`-adic unit.  For odd `p`, the maps

\[
 \log:1+p\mathbb Z_p\longrightarrow p\mathbb Z_p,
 \qquad
 \exp:p\mathbb Z_p\longrightarrow1+p\mathbb Z_p
\]

are inverse isomorphisms.  If `x in 1+p^(s+1)Z_p`, then
`log(x)/N in pZ_p`, and

\[
 x=\exp(\log(x)/N)^N.
\]

For `p=2`, use the inverse isomorphisms between `1+4Z_2` and `4Z_2`.
The assumption `x in 1+2^(s+2)Z_2` again implies `log(x)/N in4Z_2`.

## 4. Simultaneous actual-root globalization

### Theorem 4.1

For every `p in P`, let

\[
 q_p\in\mathbb Q_p^\times,
 \qquad v_p(q_p)=N_p\ge1.
\]

For every `eta>0`, there exist a number field `K`, a place `w_p|p` of `K`,
and an element `r_p in K_{w_p}` for every `p in P`, such that

\[
 r_p^{N_p}=q_p,
 \qquad
 |r_p|_{w_p}=p^{-1},
\]

and

\[
 \boxed{
 \log\operatorname{rd}(K)
 \le
 \log R(P)+\eta H(P,N)+C_\eta.}
\]

Here `rd(K)=|D_K|^(1/[K:Q])`, and `C_eta` is independent of `P`, of all
multiplicities, and of all local unit parts of the `q_p`.

### Proof

Write

\[
 q_p=p^{N_p}u_p,
 \qquad u_p\in\mathbb Z_p^\times.
\]

Choose an auxiliary prime

\[
 \rho_p=
 \begin{cases}
 2,&p\ne2,\\
 3,&p=2.
 \end{cases}
\]

By the Chinese remainder theorem, choose an integer `U_p` satisfying

\[
 U_p\equiv u_p\pmod {p^{k_p(N_p)}},
 \qquad
 U_p\equiv\rho_p\pmod {\rho_p^2},
\]

and

\[
 1\le U_p\le p^{k_p(N_p)}\rho_p^2.
\]

Lemma 3.1 gives a unit `h_p in Q_p^x` such that

\[
 u_p=U_ph_p^{N_p}.
\]

The polynomial `X^(N_p)-U_p` is Eisenstein at `rho_p`, hence irreducible over
`Q`.  Put

\[
 K_p=\mathbb Q(\alpha_p),
 \qquad \alpha_p^{N_p}=U_p.
\]

Choose a `p`-adic embedding of `K_p` corresponding to a root of this
polynomial and define

\[
 r_p=p\alpha_ph_p.
\]

Both `alpha_p` and `h_p` are `p`-adic units, so

\[
 r_p^{N_p}=p^{N_p}U_ph_p^{N_p}=q_p,
 \qquad |r_p|=p^{-1}.
\]

The polynomial discriminant formula

\[
 \operatorname{disc}(X^N-U)
 =(-1)^{N(N-1)/2}N^NU^{N-1}
\]

and divisibility of the field discriminant by the power-basis discriminant
give

\[
 \log\operatorname{rd}(K_p)
 \le \log N_p+
   \left(1-\frac1{N_p}\right)\log U_p.
\]

Since

\[
 \log U_p\le k_p(N_p)\log p+O(1),
 \qquad
 v_p(N_p)\log p\le\log N_p,
\]

there is an absolute constant `C_0` such that

\[
 \log\operatorname{rd}(K_p)
 \le\log p+2\log N_p+C_0.
\]

Let `K` be the compositum of the `K_p` in one algebraic closure.  The standard
compositum inequality

\[
 \operatorname{rd}(EF)
 \le\operatorname{rd}(E)\operatorname{rd}(F)
\]

implies

\[
 \log\operatorname{rd}(K)
 \le\sum_{p\in P}\log p
   +2\sum_{p\in P}\log N_p+C_0|P|.
\]

Apply the two uniform entropy estimates from Section 2, distributing the
prescribed `eta` between the last two terms.

## 5. Frey--Legendre specialization

At an odd multiplicative prime of a Frey--Legendre curve,

\[
 N_p=v_p(\Delta_{\min})=2v_p(abc).
\]

Thus Theorem 4.1 constructs completions containing actual local roots of the
Tate parameters with order one and gives

\[
 \log\operatorname{rd}(K)
 \le
 \log\operatorname{rad}(abc)
 +\eta\log(abc)+O_\eta(1),
\]

up to the fixed finite set of residue characteristics treated separately.
This is the error shape required by a quantifier-correct `abc` absorption.

## 6. Tensor-root multiplicity no-go

### Theorem 6.1

Let `R` and `Q` be metrized one-dimensional objects in any Arakelov category
whose degree is additive under tensor products.  If an isometric
identification

\[
 R^{\otimes N}\simeq Q
\]

is given, then

\[
 \widehat{\deg}(Q)=N\widehat{\deg}(R).
\]

In particular, if a local root satisfies `r^N=q` and the ordinary
multiplicative norm is used, then

\[
 -\log|q|=N(-\log|r|).
\]

### Consequence

Adjoining actual roots with small root-discriminant cost does **not** by itself
replace the multiplicity mass `sum N_p log p` by the radical mass
`sum log p`.  The multiplicity is restored as soon as one reconstructs the
original tensor power.

This strictly excludes only the naive, ordinary, isometric tensor-root route.
It does not exclude root-stack pushforward, stabilizer-weighted degree,
nonlinear holomorphic hulls, exterior-power compression, or a genuine adelic
maximal-slope theorem.

## 7. Exact surviving target

A Kummer-saturated proof of `abc` is reduced to constructing a canonical
stacky or adelic object `S` satisfying all of the following:

1. its distinguished local sections are the actual `r_p` from Theorem 4.1;
2. its finite positive degree is `sum log p`, not `sum N_p log p`;
3. the operation comparing `S` with the original Frey/Hodge object is not the
   excluded ordinary isometric tensor reconstruction;
4. every stabilizer, Jacobian, and metric-normalization term is explicit;
5. the globalization defect is bounded by `log rd(K)+O(log ell)`;
6. the archimedean and level-prime contributions have arbitrarily small height
   slope;
7. the resulting inequality is

   \[
   \frac16Q
   \le(1+o(1))\log\operatorname{rad}(abc)
     +\eta\log(abc)+O_\eta(1).
   \]

Theorem 4.1 closes the actual-root and discriminant portions of this route;
Theorem 6.1 records the precise mechanism that a successful geometric
construction must avoid.
