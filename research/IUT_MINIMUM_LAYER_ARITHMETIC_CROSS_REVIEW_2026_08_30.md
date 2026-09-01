# Independent arithmetic review of the 19-adic minimum-layer argument

Author: ChatGPT (arithmetic_geometry_route). Research date: 2026-08-30.

This review concerns the local field, integral JW coordinates, trace parameters,
and reduction to the lowest layer. It does not modify the frozen manuscript or
Lean files. The complete source report was subsequently read after it appeared;
the final scope and result of that review are recorded in section 7 below.

## 1. Original inputs and the integral-basis issue

The inspected originals are:

* Jannsen–Wingberg (1982), `research/sources/galois_lift_2026_08_30/Jannsen_Wingberg_1982_Inventiones.pdf`,
  especially the cyclotomic parameters on printed p. 71 and the full presentation
  on printed pp. 74–76. SHA-256:
  `54b303960baa182f4b7770b734e90da8d8ae48dde1708736af87bc100ea9f048`.
* [Hoshi–Nishio, June 2022 revised original](https://www.kurims.kyoto-u.ac.jp/~yuichiro/rims1931revised.pdf),
  pp. 4–5, Proposition 1.1 and Lemma 1.3. Local file
  `research/sources/galois_lift_2026_08_30/Hoshi_Nishio_2022_revised.pdf`;
  SHA-256 `3789ba5014602506073c82889aa27bb9c9e7e22e763f0905c087cb2713cf497c`.
* [Kondo, arXiv:2512.09231v2, 12 December 2025](https://arxiv.org/html/2512.09231v2),
  pp. 8–11, Theorem 1.3 and its generator conventions; pp. 19–20 for
  boundary-fixing handle automorphisms. Local file
  `research/sources/galois_lift_2026_08_30/Kondo_2512.09231v2_Dec2025.pdf`;
  SHA-256 `376d2f3cf6df8ca944a6158349a3ccd50906b424537a84aaa512d1b42e0801bd`.

**Important distinction.** Hoshi–Nishio Lemma 1.3 states a basis over `Q_p`.
It does not by itself state an integral basis. The following additional
argument is required for the present application.

Fix the actual full JW presentation, with `h` lifting the action of its tame
inertia generator on `mu_p`. Let `y_i` be the logarithm of the image of `x_i`
under local reciprocity. Normal generation of wild inertia implies that
`y_0,...,y_d` generate `L=log(U^1)` over `Z_p`. Abelianizing the full relation
gives

```text
C y_0 = p^s y_1,
C = 1 - (g/(p-1)) * sum_{j=1}^{p-1} h^j.             (1)
```

The tame generator itself has torsion image in the abelianization, by the
relation `sigma tau sigma^-1=tau^(p^f)`, so its logarithm contributes zero.
Commutators likewise contribute zero. The division by `p-1` in (1) is in
`Z_p`.

If `h mod p != 1`, the geometric sum in (1) vanishes modulo `p`, whence
`C=1 mod p`. Thus `C` is a unit and `y_0` lies in `p^s Z_p y_1`.
Consequently `y_1,...,y_d` generate `L` integrally. Their independence over
`Q_p` then proves that they form a `Z_p` basis of `L`.

For the field in section 2, the tame cyclotomic action is nontrivial:
`Q_19(mu_19)/Q_19` has ramification index 18, whereas the base field has
ramification index 5. The former extension therefore cannot become unramified
over the base field. Its tame inertia action has order 18 in this example;
nontriviality alone suffices. Hence `h mod 19 != 1` and (1) applies.

This uses the cyclotomic parameter of the **same full JW presentation**.
Choosing unrelated generators satisfying only the weakened displayed
conditions of Hoshi–Nishio Proposition 1.1 would not justify the congruence
for `h`. No choice of a convenient arbitrary linear basis is made here.

## 2. The field, logarithmic lattice, and exact traces

Put

```text
p=19,  K0=Q_19(mu_5),  pi^5=19,  E=K0(pi),
v(19)=1,  O=O_E,  I=(1/19) log(O^*) .
```

The order of 19 modulo 5 is 2, so `K0/Q_19` is unramified of degree 2.
The polynomial `X^5-19` is Eisenstein over `K0`; it gives a totally ramified
extension of degree 5, which is Galois because `K0` contains `mu_5`.
Thus `E/Q_19` is the splitting field, with `(d,e,f)=(10,5,2)`.

Since `v(pi)=1/5 > 1/18`, logarithm and exponential identify `1+pi O`
and `pi O`. Prime-to-19 roots of unity have zero logarithm. It follows that

```text
L=log(O^*)=pi O,   I=pi^(-4) O,   pi I=pi^(-3) O,
O subset pi I,     19 I subset pi I.                 (2)
```

The convention `(1/(2p))log(O^*)` gives the same lattice: the factor 2 is
a `Z_19` unit. The coordinates used below are explicitly `v_i=y_i/19`.

There is also a direct trace calculation, without needing a separate
inverse-different theorem. The integral power basis over `O_K0` gives

```text
I = direct_sum_{j=-4}^0 O_K0 * pi^j.
```

For `-4 <= j <= -1`, summing the five conjugates of `pi^j` gives zero;
the relative trace of 1 is 5. Hence

```text
Tr_{E/Q_19}(I)=Tr_{K0/Q_19}(5 O_K0)=Z_19.            (3)
```

The equality on the right follows already from `Tr_E(1/10)=1` and
integrality of the trace. In particular `Tr(O)=Z_19`. For any `z in I`,

```text
z0 = z - Tr(z)/10
```

lies in `ker(Tr) cap I` and has the same class as `z` in `I/pi I`, since
`Tr(z)/10 in O subset pi I`. Thus

```text
ker(Tr) cap I  -->  I/pi I  is surjective.            (4)
```

Define the actual local coefficients

```text
u    = log(20)/19,
tau1 = log(1+19*pi)/19,
t    = tau1/19 = log(1+19*pi)/19^2.
```

Convergence and the leading terms of the logarithm series yield

```text
v(u)=0,   v(tau1)=1/5,   v(t)=-4/5.                 (5)
```

The product of the five conjugates of `1+19*pi` over `K0` is `1+19^6`.
Trace commutes with the convergent logarithm, so exactly

```text
Tr(u)    = 10 log(20)/19,
Tr(tau1) = 2 log(1+19^6)/19,
Tr(t)    = 2 log(1+19^6)/19^2.                       (6)
```

Since `v(log(20))=1` and `v(log(1+19^6))=6`, (6) proves
`v(Tr(u))=0` and `v(Tr(t))=4`. These are valuation equalities, not merely
lower bounds. In particular `u in pi I`, while `t` has nonzero image in
`I/pi I`.

## 3. The trace coordinate in the actual integral JW basis

By section 1, `v_1,...,v_10` is a `Z_19` basis of `I`. Set

```text
a=v_1,   b=v_2,   W=Z_19 v_3 + ... + Z_19 v_10.
```

Kondo Theorem 1.3, with odd residue characteristic and even degree 10,
gives `ker(Tr)=Q_19 a + Q_19 W`. This is an assertion about the JW basis
being used, not about arbitrary adapted coordinates. It implies

```text
Tr(a)=0,  Tr(W)=0,
ker(Tr) cap I = Z_19 a direct_sum W.
```

Combining the integral basis with (3), `beta=Tr(b)` generates the ideal
`Z_19` and is therefore a unit. If

```text
z=A_z a+B_z b+w_z  (A_z,B_z in Z_19; w_z in W),
```

then `B_z=Tr(z)/beta`. In particular

```text
B_u in Z_19^*,   B_t in 19^4 Z_19^* subset 19 Z_19. (7)
```

No unbounded denominator is concealed in either trace coefficient.

## 4. The two minimum-layer cases

Write a bar for the image in `I/pi I`. This quotient is a two-dimensional
`F_19` vector space, although it is also naturally one-dimensional over
the residue field `F_(19^2)`. Only its `F_19` structure is used here.

First suppose `a` has valuation `-4/5`, i.e. `bar(a)!=0`. The actual
generator substitution `x_2 -> x_2 x_1` fixes the JW relator and induces

```text
T_a(z)=z+B_z a.
```

By (5) and (7), `bar(T_a(u))=bar(B_u)*bar(a)!=0`. Also
`B_t a in 19I subset pi I`, so `bar(T_a(t))=bar(t)!=0`.
One and the same map sends both coefficients to valuation `-4/5`.

Now suppose `a in pi I`. By (4), `Z_19 a+W` surjects onto `I/pi I`.
As `bar(a)=0`, the images of the eight displayed basis vectors of `W`
span the quotient. Thus at least one actual basis vector `w=v_j`, `j>=3`,
satisfies `bar(w)!=0`.

The only source-lift input needed in this case is an automorphism whose
linear action has the form

```text
E_w(a)=a,
E_w(b)=b+w,
E_w(x)=x+omega(w,x)a  for x in W,                  (8)
```

where `omega:W x W -> Z_19` is the integral alternating pairing in the
displayed handle basis. More generally an integral linear coefficient of
`a` suffices; its sign is immaterial for this argument. For (8),

```text
E_w(z)-z=B_z w+omega(w,w_z)a.
```

Applied to `u`, the second term and `u` lie in `pi I`, while the first
term has nonzero reduction by (7). Applied to `t`, both difference terms
lie in `pi I`: use `B_t in 19 Z_19` for the first and `a in pi I` for
the second. Therefore again

```text
v(E_w(u))=v(E_w(t))=-4/5.                           (9)
```

There is no cancellation gap: in each case the reduction of the image
of `u` is a single nonzero unit multiple of the chosen lowest vector;
the reduction of the image of `t` is unchanged. Neither case assumes
that every lattice automorphism is induced by a Galois automorphism.

## 5. Source and Kummer boundaries that must remain explicit

Kondo's pp. 19–20 show how boundary-fixing automorphisms of the remaining
four handles induce automorphisms of the full local absolute Galois group.
In particular the integral symplectic action on those eight coordinates
can move one displayed basis direction to another while fixing `a,b`.
One only needs these integral basis-direction operations, not an
unproved surjectivity onto an arbitrary `p`-adic linear group.

The new ingredient relative to those cited statements is the cross-handle
map (8). For it one must verify the **full noncommutative JW relator**, the
fixed tame generators and `x_0,x_1`, and an inverse substitution. Checking
only the alternating form on abelianization is insufficient. These checks
are supplied in sections 3–4 of the now-complete source report; the separate
analytic review also confirmed them. See section 7 of this review for the
additional direct checks made here.

The reconstructed additive action and a contravariant Kummer action must
not be identified without their variance. Write `M` for the action on
abelianized principal units, in logarithmic coordinates. Local Tate
duality, under the evaluation pairing between characters and Kummer
classes, gives the Kummer pullback action as

```text
F_Kum = c * M^(-1),   c in Z_19^*.
```

Indeed characters pull back by composition with `M`, and the induced
isomorphism on the integral rank-one `H^2` orientation is multiplication
by a unit `c`. Perfectness forces the displayed inverse formula. One may
use the inverse Galois automorphism to realize a unit multiple of the
desired `M`. Its two valuations in (9) are unchanged. The coefficient
identification and this choice must be coherent when a source label is
repeated.

This establishes the local arithmetic mechanism for the full source
automorphism family with the stated and now verified cross lift. It does not
show that a smaller family satisfying extra marking restrictions contains
these arrows. It does not instantiate every global initial-data or prime-
window condition, and it proves neither ABC nor a contradiction to ABC.

## 6. Review conclusion

The integral-basis strengthening, all field and trace calculations, the
unit/divisibility assertions for `B_u,B_t`, and the two-case reduction
argument pass this independent review. The needed qualifications are
substantive: retain the proof of integrality in section 1, the source-level
verification of (8), and the inverse/unit Kummer convention. Do not replace
any of them by an assertion that all symplectic or lattice maps lift.

## 7. Final read of the complete source report

The complete file `research/IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md`
was read through sections 1–11 after it was written. **Final result: pass;
no necessary mathematical correction identified.** In particular:

* Sections 3–4 use the full relative JW object, including the characteristic
  maximal-pro-p kernel of the normal wild subgroup, before imposing the
  remaining relation. The substitutions fix the tame generators, `x_0`
  and `x_1`, not merely their abelianized images.
* For the displayed cross map, writing `r=bab^-1` and `z=d r d^-1`
  gives `F(r)=z`, `F([a,b])=a z^-1`, and
  `F([c,d])=z r^-1 c d c^-1 r d^-1 z^-1`.
  Their product reduces exactly to `[a,b][c,d]`. With
  `D=r^-1 d r` and `s=D^-1 r D`, the displayed inverse has
  `G(r)=s`, `G(z)=r`, `F(D)=d`, `F(s)=r`; these verify both
  compositions on all four generators. These identities were checked
  algebraically here, independently of the computational word checker.
* The generator images on abelianization are exactly
  `a -> a`, `b -> b+d`, `c -> c-a`, `d -> d`.
  The remaining-handle rotations and swaps fix their boundary word,
  so their conjugates retain integral coefficients and the same full
  relator. The optional factorization (4.5) is not needed for the direct
  proof; its separate word review was reported complete by analytic_route.
* Sections 5, 6 and 8 match the integral and trace proof above, including
  the strong valuation `v_19(B_t)=4`. No arbitrary adapted basis or
  unproved residue surjectivity is substituted for the actual JW basis.
* Section 7 has the correct inverse and unit in the Kummer convention.
  It explicitly separates one local representative from a globally
  compatible marked family.
* Section 9 defines its fixed repeated-label source set `S_m` explicitly.
  The lattice bound and one simultaneously attained pure tensor give
  `H_m=pi^(5-4m) B_m` for its actual coefficient-ring span. All component
  valuations are the same, so division by that power of `pi` gives a
  unit of the product maximal order. Its statement about closure follows
  because the resulting fractional lattice is compact. It does not
  replace the coefficient-ring span by an ordinary convex hull.
* Sections 10–11 keep the odd-degree case, the actual squared-index
  source family, global compatibility, ABC, and unformalized source
  inputs outside the proved conclusion. Those limitations are needed.

The trace-kernel and Galois-presentation inputs remain cited mathematical
theorems, not newly introduced Lean axioms. No frozen PDF, TeX or Lean file
was edited in this review.
