# One-step tropical radicalization by a universally transverse isogeny

## 1. Set-up

Let `E/Q` be a semistable Frey--Legendre curve.  At every multiplicative prime
`p`, write

\[
  N_p=v_p(\Delta_{\min})>0.
\]

Choose a prime `ell` satisfying

\[
  \ell>\max_pN_p,
  \qquad
  \ell\nmid\operatorname{rad}(N_E).
\]

Let `K=Q(E[ell])`.  Over `K`, all `ell`-torsion subgroups are rational.  In
`E[ell]^2`, choose the universally transverse graph subgroup `H_T` from the
finite-field theorem and put

\[
  A_T=E^2/H_T.
\]

## 2. Local normalized tropical weight

At a place `w|p` of `K`, the base-changed Tate parameter still has normalized
absolute value

\[
  -\log|q_p|_w=N_p\log p.
\]

Because `K_w` contains `q_p^(1/ell)` and `H_T` is complementary to the
canonical Tate subgroup in both factors, the quotient period lattice is
obtained by adjoining two independent root periods.  Hence each toric
direction of `A_T` has normalized weight

\[
  \frac{N_p}{\ell}\log p.
\]

### Theorem 2.1 (one-step radicalization)

The total normalized multiplicative tropical weight of `A_T` satisfies

\[
  Q_{\mathrm{trop}}(A_T)
  =\frac2\ell\sum_{p\mid N_E}N_p\log p
  <2\sum_{p\mid N_E}\log p.
\]

### Proof

The local quotient calculation gives the equality.  Since `N_p<ell` for every
multiplicative prime, each summand is less than `2 log p`.

Thus one global isogeny of the abelian surface `E^2` lowers **all**
multiplicative tropical exponents below one radical copy per toric direction.
No iteration and no place-by-place global subgroup selection is required.

## 3. Torsion-field root-discriminant shape

At a prime `p != ell` of good reduction, `K/Q` is unramified.  At a
multiplicative prime, the inertia image on `E[ell]` is a nonzero tame
transvection because `ell>N_p`; its order is `ell`.  Therefore its normalized
different contribution is

\[
  \left(1-\frac1\ell\right)\log p.
\]

Since `ell` is not a bad prime, `E` has good reduction at `ell`.  The standard
finite-flat discriminant bound for the `ell`-torsion field gives an
`O(log ell)` normalized contribution at `ell`.  Consequently the expected
sharp field estimate is

\[
 \boxed{
 \log\operatorname{rd}(K)
 \le
 \left(1-\frac1\ell\right)
 \log\operatorname{rad}(N_E)+O(\log\ell).}
\]

The tame part is elementary.  The finite-flat level-prime constant must be
stated and verified explicitly in a final proof.

## 4. What remains after radicalization

The finite tropical boundary of `A_T` now has the correct radical size.  The
entire remaining difficulty is to control the compensation forced by global
height invariance:

\[
 h_F(A_T)-2h_F(E).
\]

The degree of the isogeny is `ell^2`, so the total Faltings-height difference
is at most `log ell` in absolute value.  Nevertheless the decomposition into
finite boundary, archimedean theta, integral-kernel, polarization, and field
different terms may contain individually large contributions.

A proof of `abc` along this route is therefore reduced to an **exact local-to-
global isogeny formula** proving that the non-tropical compensation is bounded
by

\[
 (1+o(1))\log\operatorname{rad}(abc)+O(\log\ell),
\]

with the normalization required to recover `Q/6`.  Theorem 2.1 shows that no
multiplicity remains in the tropical term itself.

## 5. Auxiliary-prime size

The prime-escape/PNT machinery already developed in the repository can choose
`ell` outside the bad-prime set with

\[
 \ell>\max_pN_p,
 \qquad
 \ell=O\!\left(\max_pN_p+\log\operatorname{rad}(abc)\right).
\]

For a prospective `abc` input, both quantities are `O(log c)`, hence

\[
 \log\ell=O(\log\log c)=o(\log c).
\]

Therefore the level cost in the surviving compensation theorem is
quantifier-correct and absorbable.
