# The arithmetic unit-spread barrier

## 1. Purpose

Several active routes now control all finite-place defects of a torsion or
theta packet by the conductor, the level prime, and the root discriminant of a
descent field.  This is substantial, but it does not by itself control the
archimedean projective height.  The following fixed-field example proves that
no generic theorem of that form can be true.

The result eliminates only arguments using **field discriminant plus finite
integrality alone**.  It does not eliminate the explicit Hecke-discriminant,
theta-distribution, or determinant-of-cohomology packets, whose special
archimedean functions may satisfy additional estimates.

## 2. A fixed real-quadratic example

Let

\[
 K=\mathbb Q(\sqrt2),
 \qquad
 u=3+2\sqrt2=(1+\sqrt2)^2.
\]

Then

\[
 u' =3-2\sqrt2=u^{-1},
 \qquad
 N_{K/\mathbb Q}(u)=1.
\]

Thus `u` and `u^{-1}` are algebraic-integer units.  For every integer
`n>=1`, consider

\[
 P_n=[u^n:u^{-n}]\in\mathbb P^1(K).
\]

### Theorem 2.1 (unbounded projective height in one fixed field)

Every finite-place contribution to the absolute logarithmic projective height
of `P_n` is zero, while

\[
 \boxed{h(P_n)=n\log u.}
\tag{2.1}
\]

In particular, the heights tend to infinity although:

1. the number field `K` is fixed;
2. its root discriminant is fixed;
3. both coordinates are units at every finite place;
4. the coordinate product is one.

#### Proof

At every nonarchimedean place, both `u^n` and `u^{-n}` have absolute value one,
so

\[
 \log\max\{|u^n|_v,|u^{-n}|_v\}=0.
\]

There are two real embeddings.  At the first,

\[
 \max\{u^n,u^{-n}\}=u^n.
\]

At the conjugate embedding the two coordinates are exchanged, so the maximum
is again `u^n`.  The normalized absolute height is therefore

\[
 \frac1{[K:\mathbb Q]}
 \left(n\log u+n\log u\right)
 =n\log u.
\]

### Corollary 2.2

There do not exist constants `A,B`, depending only on the rank, such that every
projective point with unit coordinates in a number field satisfies

\[
 h(P)\le A\log\operatorname{rd}(K)+B.
\tag{2.2}
\]

The assertion already fails in the single fixed field `Q(sqrt2)`.

## 3. Metric-rescaling form of the same obstruction

Let `L` be an arithmetic line with fixed integral lattice.  Multiplying every
archimedean norm by `e^{-T}` changes no finite-place lattice, no geometric
degree, and no field discriminant, but increases its arithmetic degree by
`T` (with normalized conventions).  Thus a geometric or parabolic slope does
not determine an arithmetic slope until the archimedean metric is specified
and compared to the integral lattice.

The real-quadratic unit example is stronger: it uses the standard absolute
values and varies only an integral unit section, rather than artificially
rescaling the metric.

## 4. Consequences for current abc routes

### 4.1 Full torsion-field root discriminant

The bound

\[
 \log\operatorname{rd}(\mathbb Q(E[\ell]))
 \le
 \left(1-\frac1\ell\right)\log\operatorname{rad}(N_E)
 +O(\log\ell)
\]

controls the descent lattice but cannot alone bound the archimedean spread of
a packet section.

### 4.2 Good-place determinant unitness

The theorem that cyclic determinant sections and their duals are units at good
finite places removes finite denominators.  The example above proves that this
still leaves a genuine archimedean problem.

### 4.3 Geometric Steinberg slope

The identity

\[
 \mu_{\max}^{\rm par}
 (\omega^{\ell-1}\otimes\mathcal{St}_\ell)
 =\frac{\ell-1}{2}
\]

is a geometric statement.  It becomes an arithmetic height estimate only
after one proves a canonical metric comparison for the **specific** packet
morphism or section.  A generic appeal to the ambient geometric slope is not
valid.

## 5. Corrected surviving theorem

The remaining target must exploit the explicit modular origin of the packet.
For the norm-one Hecke-discriminant or cyclic-theta packet `Sigma_ell(E)`, one
must prove a theorem of the form

\[
 h_\infty(\Sigma_\ell(E))
 \le
 \left(\frac{\ell-1}{2}+o(\ell)\right)
   (\operatorname{Different}(E)+\operatorname{Conductor}(E))
 +O(\ell\log\ell),
\tag{5.1}
\]

where `h_infinity` is computed from the actual Petersson/theta metric and the
finite normalizations are those already fixed by the product identities.

A proof may use:

- explicit modular-unit q-expansions;
- determinant of cohomology with Quillen/Petersson metrics;
- an arithmetic Riemann--Roch formula;
- a direct bound for the Hecke orbit of the modular discriminant;
- modular-symbol or spectral estimates tailored to the Steinberg constituent.

The generic discriminant-plus-integrality shortcut is excluded by Theorem 2.1;
the explicit modular packet route remains active because it contains
additional functional relations absent from arbitrary units.

## 6. Formalization plan

The scalar core can be formalized first: for `L>0`, the normalized two-place
height of the logarithmic vector `(nL,-nL)` is `nL`.  A later number-field layer
can instantiate `L=log(3+2sqrt2)` and verify that the two coordinates are
units.  No unproved height-conductor statement is introduced as an axiom.
