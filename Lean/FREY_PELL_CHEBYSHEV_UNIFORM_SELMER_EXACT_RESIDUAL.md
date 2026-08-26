# Prime-index Chebyshev 2-Selmer: exact residual splitting and the BSPT boundary

## 0. Result and status

Let \(p\ne3\) be an odd prime, \(g=(p-1)/2\),

\[
 K_p=\mathbf Q(a),\qquad a^p=2,
\]

and let \(J_p\) be the Jacobian of the prime-index Chebyshev curve from
`FREY_PELL_CHEBYSHEV_UNIFORM_TWO_DESCENT_AUDIT.md`.  Write

\[
 E_p=\langle [a-1],[3(a+1)]\rangle .
\]

The earlier audit proves \(E_p\subset \operatorname {Sel}_2(J_p)\) and
\(\dim_{\mathbf F_2}E_p=2\).  This note does **not** prove the desired
uniform upper bound.  It proves the following exact reduction.

There are two explicitly defined maps

\[
 \lambda_{U,p}:U_p^{\rm odd}/E_p\longrightarrow Q_{2,p},
 \qquad
 \partial_{C,p}:C_p^{\rm surv}\longrightarrow
       \operatorname {coker}(\lambda_{U,p})
\]

and a canonical short exact sequence

\[
 0\longrightarrow\ker\lambda_{U,p}
 \longrightarrow \operatorname {Sel}_2(J_p)/E_p
 \longrightarrow\ker\partial_{C,p}\longrightarrow0.       \tag{0.1}
\]

Consequently

\[
 \boxed{
 \dim\operatorname {Sel}_2(J_p)
   =2+\dim\ker\lambda_{U,p}+\dim\ker\partial_{C,p}}
                                                               \tag{0.2}
\]

and the missing bound is equivalent to the simultaneous vanishing of the
two displayed kernels.  The first is the exact \(S\)-unit/dyadic
transversality obstruction.  The second is the exact surviving
\(S\)-class obstruction **after allowing correction by an odd-admissible
\(S\)-unit**.  Thus (0.1) is a canonical two-step refinement, equivalent
to the reverse inclusion in equation (5.7) of the earlier audit.

There is also a rigorous no-go consequence of the 2023 theorem of Barrera
Salazar--Pacetti--Tornaría (BSPT).  Whenever their Hypotheses 5.2 hold for
the monic Chebyshev model,

\[
 \boxed{
 \dim\operatorname {Sel}_2(J_p)
 \ge 2+\dim\operatorname {Cl}(K_p)[2].}                       \tag{0.3}
\]

In particular, in that range a uniform Selmer dimension two theorem would
force the ordinary pure-field 2-class group to vanish.  The BSPT hypotheses
do hold when \(p\) is non-Wieferich to base \(2\) and
\(\operatorname {ord}_p(3)\) is even.  Outside that explicit subfamily,
the missing component-group alternative in BSPT must not be silently
assumed.

Equations (0.1)--(0.2) are unconditional for every odd prime \(p\ne3\).
Equation (0.3) is conditional on BSPT Hypotheses 5.2, and hence is
unconditional on the explicit subfamily above.  These are reduction/no-go
statements, not a uniform Selmer upper bound, a rank-two theorem, or a
uniform Chabauty closure.  No GRH, BSD, finiteness of (Sha), `abc`, or
Szpiro statement is used.

## 1. Descent spaces and the dyadic quotient

Use the monic odd-degree model

\[
 C_{p,m}:W^2=q_{p,m}(Z),\qquad
 q_{p,m}(Z)=2^{p-1}q_p(-Z/2),
\]

whose root

\[
 \vartheta=-2(a+a^{-1})
\]

generates \(K_p\).  The standard odd-degree descent identifies the relevant
cohomology group with the norm-square subgroup of
\(K_p^*/K_p^{*2}\), and the global Kummer map is injective.  See BSPT,
Theorem 2.1 and Definition 2.2, pp. 5--6, and Stoll, Proposition 4.2,
pp. 250--251, in the references below.

Let \(S\) be the primes of \(K_p\) above \(2,3,p\), and put

\[
 K_p(S,2)=
 \{u\in K_p^*:v_{\mathfrak q}(u)\equiv0\pmod2
       \text{ for }\mathfrak q\notin S\}/K_p^{*2}.
\]

Let \(B_p=V_p^{\rm odd}\) be the subspace of the norm-square part of
\(K_p(S,2)\) satisfying the Kummer conditions at infinity, \(3\), and \(p\).
The good odd-prime conditions outside \(S\) have already been imposed by the
even-valuation definition.  This is exactly the space denoted
\(V_p^{\rm odd}\) in equation (5.7) of the earlier audit.

At the unique prime over \(2\), define

\[
 \mathscr N_{2,p}=
 \ker\!\left(
 K_{p,2}^*/K_{p,2}^{*2}\xrightarrow{N}
 \mathbf Q_2^*/\mathbf Q_2^{*2}\right),
\]

let

\[
 L_{2,p}=\delta_2(J_p(\mathbf Q_2)/2J_p(\mathbf Q_2))
       \subset\mathscr N_{2,p},
 \qquad Q_{2,p}=\mathscr N_{2,p}/L_{2,p},
\]

and let

\[
 \lambda_p:B_p\longrightarrow Q_{2,p}                       \tag{1.1}
\]

be localization followed by the quotient.  Since all other local
conditions are already built into \(B_p\), the definition of the Selmer
group gives the exact equality

\[
 \operatorname {Sel}_2(J_p)=\ker\lambda_p.                  \tag{1.2}
\]

This is Stoll's local-intersection description, not a dimension heuristic.

## 2. Verification that \(E_p\hookrightarrow\operatorname {Sel}_2(J_p)\)

Let \(H_+,H_-\in J_p(\mathbf Q)\) be the two rational half-divisors of the
earlier audit.  On the monic model their Kummer classes are

\[
 \delta(H_+)=[a-1],\qquad \delta(H_-)=[3(a+1)].              \tag{2.1}
\]

There are three separate facts here.

1. The Kummer map
   \(J_p(\mathbf Q)/2J_p(\mathbf Q)\hookrightarrow
   K_p^*/K_p^{*2}\) is injective.
2. The two squareclasses in (2.1) are independent for \(p\ne3\):
   \(a-1\) is nonsquare at the dyadic completion, while \(3(a+1)\) and
   \(3(a-1)(a+1)\) have odd valuation at a cofactor prime over \(3\).
3. A global rational Kummer class satisfies every local Kummer condition
   by functoriality.  Therefore its image belongs to the Selmer group.

It follows that the map from the two-dimensional span is injective and

\[
 E_p\cong(\mathbf F_2)^2\hookrightarrow
 \operatorname {Sel}_2(J_p).                               \tag{2.2}
\]

The same classes are \(S\)-units modulo squares.  Indeed \(a-1\) is a
global unit because \(N(a-1)=1\), and \(3(a+1)\) has no support away from
primes above \(3\).  Hence \(E_p\) will lie in the unit term introduced
next.  Finally, (2.2) and (1.2) give

\[
 E_p\subset B_p,\qquad \lambda_p(E_p)=0.                    \tag{2.3}
\]

These statements verify both the injection and the quotient condition
needed below; neither is being inferred merely from the rank lower bound.

## 3. Restricting the exact \(S\)-class sequence

The standard ideal-parity sequence is

\[
 0\longrightarrow
 U_{S,p}:=\mathcal O_{K_p,S}^*/\mathcal O_{K_p,S}^{*2}
 \longrightarrow K_p(S,2)
 \xrightarrow{\rho_p}\operatorname {Cl}(\mathcal O_{K_p,S})[2]
 \longrightarrow0.                                        \tag{3.1}
\]

Explicitly, if \((u)=\mathfrak a^2\) as a fractional
\(S\)-ideal, then \(\rho_p([u])=[\mathfrak a]\).  Its kernel is precisely
the \(S\)-unit squareclasses.

Restrict (3.1) to \(B_p\), and define

\[
 U_p^{\rm odd}=B_p\cap U_{S,p},\qquad
 C_p^{\rm surv}=\rho_p(B_p).                               \tag{3.2}
\]

The notation is deliberately restrictive: \(C_p^{\rm surv}\) is only the
part of the \(S\)-class 2-torsion admitting a norm-square lift which passes
the infinity, \(3\)-adic, and \(p\)-adic Kummer conditions.  Restriction of
(3.1) gives the short exact sequence

\[
 0\longrightarrow U_p^{\rm odd}
 \longrightarrow B_p\xrightarrow{\rho_p}C_p^{\rm surv}
 \longrightarrow0.                                        \tag{3.3}
\]

By Section 2, \(E_p\subset U_p^{\rm odd}\).  Quotienting (3.3) by \(E_p\)
therefore gives another short exact sequence

\[
 0\longrightarrow U_p^{\rm odd}/E_p
 \longrightarrow B_p/E_p
 \xrightarrow{\bar\rho_p}C_p^{\rm surv}
 \longrightarrow0.                                        \tag{3.4}
\]

No class-number hypothesis is present in (3.1)--(3.4).

## 4. The connecting map and the exact residual sequence

Because \(\lambda_p(E_p)=0\), equation (1.1) induces a well-defined map

\[
 \bar\lambda_p:B_p/E_p\longrightarrow Q_{2,p},\qquad
 \bar\lambda_p(b+E_p)=\lambda_p(b).                        \tag{4.1}
\]

Moreover, (1.2) gives

\[
 \ker\bar\lambda_p=\operatorname {Sel}_2(J_p)/E_p.         \tag{4.2}
\]

Restrict (4.1) to the left term of (3.4):

\[
 \lambda_{U,p}:U_p^{\rm odd}/E_p\longrightarrow Q_{2,p}.   \tag{4.3}
\]

Now define

\[
 \partial_{C,p}:C_p^{\rm surv}\longrightarrow
       Q_{2,p}/\operatorname {im}(\lambda_{U,p})            \tag{4.4}
\]

as follows.  For \(c\in C_p^{\rm surv}\), choose any
\(b\in B_p/E_p\) with \(\bar\rho_p(b)=c\), and set

\[
 \partial_{C,p}(c)=
 \bar\lambda_p(b)+\operatorname {im}(\lambda_{U,p}).       \tag{4.5}
\]

This is well defined.  Two lifts differ by an element of
\(U_p^{\rm odd}/E_p\), so their dyadic localizations differ by an element
of \(\operatorname {im}(\lambda_{U,p})\).  It is visibly linear.

Restrict \(\bar\rho_p\) to \(\ker\bar\lambda_p\).  Its kernel is

\[
 (U_p^{\rm odd}/E_p)\cap\ker\bar\lambda_p
   =\ker\lambda_{U,p}.                                    \tag{4.6}
\]

Its image is exactly \(\ker\partial_{C,p}\).  One inclusion follows from
(4.5).  Conversely, if \(\partial_{C,p}(c)=0\), choose a lift \(b\).  Then
\(\bar\lambda_p(b)=\lambda_{U,p}(u)\) for some
\(u\in U_p^{\rm odd}/E_p\), and \(b-u\) is a lift of \(c\) lying in
\(\ker\bar\lambda_p\).  Thus (4.2) and (4.6) prove

\[
 0\longrightarrow\ker\lambda_{U,p}
 \longrightarrow\operatorname {Sel}_2(J_p)/E_p
 \xrightarrow{\bar\rho_p}\ker\partial_{C,p}
 \longrightarrow0,                                       \tag{4.7}
\]

which is (0.1).  Taking dimensions proves (0.2).

The desired upper bound is therefore equivalent to the two exact claims

\[
 \ker\lambda_{U,p}=0,
 \qquad \ker\partial_{C,p}=0.                              \tag{4.8}
\]

The second condition is subtler than saying that one selected lift of a
class does not lie in \(L_{2,p}\).  A class survives precisely when its
dyadic localization can be moved into \(L_{2,p}\) by an odd-admissible
\(S\)-unit.  The cokernel in (4.4) records exactly this correction freedom.

Stoll's implementation makes the same ideal-theoretic distinction: the
everywhere-even space has a unit/class exact sequence, while allowed bad
valuations first have to satisfy an ideal-class lifting condition.  See
Stoll, Corollary 4.7 and Lemma 4.9, pp. 253--255.  Thus replacing
\(C_p^{\rm surv}\) by all of \(\operatorname {Cl}(\mathcal O_{K_p,S})[2]\),
or replacing it by the ordinary class group, would lose information.

## 5. Why the unique dyadic prime is not an upper bound

The polynomial \(Z^p-2\), not \(q_{p,m}\), is Eisenstein at \(2\).  It gives
the unique totally ramified degree-\(p\) completion

\[
 K_{p,2}=\mathbf Q_2(a).
\]

The element \(\vartheta=-2(a+a^{-1})\) is not rational over
\(\mathbf Q_2\); since \(p\) is prime, it generates the same completion.
Thus \(q_{p,m}\) is irreducible over \(\mathbf Q_2\), although it need not
itself be Eisenstein.

The local norm kernel \(\mathscr N_{2,p}\) has dimension \(2g\), while
\(L_{2,p}\) has dimension \(g\) and is a maximal isotropic subspace.  The
factor count determines these dimensions, but it does not determine the
position of \(L_{2,p}\), nor the localization of the moving global unit
space.

There is an elementary method counterexample.  Let
\(H=X\oplus Y\) be a \(2g\)-dimensional symplectic space, let \(L=X\), and,
for \(g\ge3\), let \(E=\langle x_1,x_2\rangle\subset X\).  Both

\[
 B_{\min}=E\oplus Y,
 \qquad B_{\max}=X\oplus\langle y_1,y_2\rangle
\]

have dimension \(g+2\), contain \(E\), and meet the same \(g\)-dimensional
Lagrangian \(L\).  Nevertheless

\[
 B_{\min}\cap L=E,
 \qquad B_{\max}\cap L=L.
\]

Thus the common dimension ledger is compatible with intersection dimension
\(2\) or \(g\).  This is a counterexample to the proposed *method*, not an
arithmetic counterexample in the Chebyshev family.

BSPT also give actual genus-five, monogenic, narrow-class-number-one
examples attaining Selmer ranks \(0\) and \(5\); the first has \(2\) inert,
and the second defining polynomial
\(x^{11}+x^4+x^2+x+1\) is irreducible modulo \(2\).  See BSPT, pp. 26--27.
The latter finite-field assertion was independently checked by the exact
PARI/GP expression `factormod(x^11+x^4+x^2+x+1,2)`, which returns one
degree-11 factor.
These examples likewise show that class number and the number of dyadic
factors do not locate the Kummer Lagrangian.

## 6. What BSPT proves, and only under which hypotheses

BSPT work with a monic integral odd-degree equation
\(y^2=P(x)\), with nonzero discriminant and with the coefficient of
\(x^{d-1}\) divisible at the primes above \(2\).  Their Hypotheses 5.2 are:

1. \(d\) is odd;
2. the narrow class group of the **base field** is odd;
3. at every finite base-field place the curve satisfies condition
   \((\dagger)\).

At a finite place, \((\dagger)\) means either:

* \((\dagger.i)\): the integral algebra of \(P\) is the product of the
  integral algebras of its local irreducible factors (the integral CRT
  condition); or
* \((\dagger.ii)\): the residue characteristic is odd and the Néron
  component group has odd order.

See BSPT, Definition 3.2 and Remark 3.3, pp. 6--7, and Hypotheses 5.2,
p. 13.  The component-group alternative is a genuine hypothesis.  Stoll's
Lemma 4.5, pp. 251--252, identifies the valuation of the odd local Kummer
image with the image of the component group modulo \(2\), so it cannot be
dropped from the descent bookkeeping.

For the Chebyshev monic model, the first two BSPT hypotheses hold: the
degree is \(p\), the \(Z^{p-1}\)-coefficient is zero, and the base field is
\(\mathbf Q\), whose narrow class number is one.  The finite-place audit is
as follows.

* At \(2\), \(q_{p,m}\) is locally irreducible, so \((\dagger.i)\) is
  automatic.
* Away from \(2,3,p\), its discriminant is a unit, so distinct local factors
  have coprime reductions and \((\dagger.i)\) holds.
* At \(p\), if \(p\) is non-Wieferich to base \(2\), there is one prime of
  \(K_p\) above \(p\); equivalently \(q_{p,m}\) is locally irreducible, so
  \((\dagger.i)\) holds.  More explicitly, the constant coefficient of
  \((X+2)^p-2\) has \(p\)-adic valuation one in the non-Wieferich case,
  while every other nonleading coefficient is divisible by \(p\); this
  translated polynomial is Eisenstein.  In the Wieferich branch,
  \(2\in\mathbf Q_p^{*p}\), so \(X^p-2\) is a linear factor times an
  irreducible degree-\(p-1\) cyclotomic factor.  The roots belonging to the
  two factors have the same reduction because the \(p\)-th roots of unity
  reduce to \(1\).  Hence \((\dagger.i)\) fails; no uniform proof of
  \((\dagger.ii)\) is supplied here.
* At \(3\), put \(d=\operatorname {ord}_p(3)\).  Modulo \(3\), parametrize
  the roots by \(z=-\zeta^k\), \(\zeta^p=1\).  Frobenius sends
  \(k\) to \(3k\), while
  \(z+z^{-1}\) identifies exactly \(k\) and \(-k\).  If \(d\) is odd, the
  two Frobenius orbits of \(k\) and \(-k\) are distinct but give the same
  reduced roots of \(q_{p,m}\); hence \((\dagger.i)\) fails.  If \(d\) is
  even, \(-1\in\langle3\rangle\subset\mathbf F_p^*\), every orbit is
  inversion-stable, and distinct local factors have disjoint reduced root
  sets.  Each nontrivial local factor reduces to \(h_O^2\) for the
  irreducible polynomial attached to the inversion-stable orbit \(O\);
  the polynomials \(h_O\) for distinct orbits are distinct and are coprime
  to the linear factor.  Thus every pairwise resultant is a \(3\)-adic unit
  and \((\dagger.i)\) holds.  The large index \(3^g\) of the polynomial
  order is compatible with this: for even \(d\), repeated roots occur
  inside a local factor, whereas \((\dagger.i)\) only separates distinct
  local factors.

It follows that all BSPT Hypotheses 5.2 are proved, without a component
group calculation, for

\[
 p\ne3,\qquad p^2\nmid 2^{p-1}-1,
 \qquad \operatorname {ord}_p(3)\ \text{even}.              \tag{6.1}
\]

When either exceptional branch occurs, BSPT may still apply if
\((\dagger.ii)\) is proved at every failed CRT place.  It does not apply
there merely from the factor count, and this note makes no component-group
parity assertion.

## 7. The conditional class injection and its disjointness from \(E_p\)

Assume now that BSPT Hypotheses 5.2 hold.  Their Proposition 5.7 identifies
\(C_*(C_{p,m})\) with \(\operatorname {Cl}_*(K_p,C_{p,m})[2]\).  Since
\(q_{p,m}\) has exactly one real root, the extra paired-real-place
conditions are empty, and

\[
 \operatorname {Cl}_*(K_p,C_{p,m})=\operatorname {Cl}(K_p). \tag{7.1}
\]

At \(2\) there is one local factor.  BSPT Lemma 3.13 and Theorem 3.14 give

\[
 U_{4,2}/(A_{\mathcal O_2}^{\times})^2=0,
 \qquad W_2=(A_{\mathcal O_2}^{\times})^2.                  \tag{7.2}
\]

Their Theorem 5.12 then gives
\([C_*:C_W]\le2^{1-1-0}=1\), so \(C_*=C_W\).  Finally Proposition 5.9
gives \(C_W\subset\operatorname {Sel}_2(J_p)\).  Combining these statements
produces an injection

\[
 \operatorname {Cl}(K_p)[2]\hookrightarrow
 \operatorname {Sel}_2(J_p).                              \tag{7.3}
\]

The cited results occur on BSPT pp. 10 and 13--16.  Notice the direction:
the unique dyadic factor makes the BSPT unramified class subgroup locally
square and hence places it **inside** the Selmer group.  It does not remove
that subgroup.

The image in (7.3) meets \(E_p\) trivially.  Indeed its classes are locally
square at \(2\) by (7.2), whereas \([a-1]\) is not.  The other two nonzero
elements of \(E_p\), namely \([3(a+1)]\) and
\([3(a-1)(a+1)]\), have odd valuation at a cofactor prime above \(3\), so
their quadratic extensions are ramified there; classes in \(C_*\) are
unramified at every finite place.  Hence

\[
 E_p\oplus\operatorname {Cl}(K_p)[2]
 \hookrightarrow\operatorname {Sel}_2(J_p),               \tag{7.4}
\]

which proves (0.3).  In particular, (0.3) is unconditional for every prime
in (6.1).  For those primes, a proof of
\(\dim\operatorname {Sel}_2(J_p)\le2\) necessarily proves
\(\operatorname {Cl}(\mathbf Q(2^{1/p}))[2]=0\) as a consequence.

This ordinary-class statement and the \(S\)-class term in (3.1) are not
interchangeable.  Localizing the class group at \(S\) can move an ordinary
unramified class into the \(S\)-unit part of (3.3).  Formula (4.7), not a
bare class-number assertion, remains the correct minimal ledger.

No accepted theorem located in this audit proves the required uniform
vanishing of either \(\operatorname {Cl}(K_p)[2]\) or
\(\operatorname {Cl}(\mathcal O_{K_p,S})[2]\).  Fixed-\(p\) class-group
computations must not be extrapolated.

## 8. Chabauty and partial descent do not presently replace (4.8)

The supplied modulo-\(5\) Coleman data at \(p=17\) and \(p=19\) are useful
pointwise certificates **if** rank two is first proved.  They do not provide
that rank upper bound, and no assertion about other primes follows from
them.

A partial-descent alternative could in principle avoid killing all of
\(\operatorname {Sel}_2/E_p\) by proving that the Abel--Jacobi image of the
curve misses the extra covering classes.  In the present family this still
requires a uniform theorem controlling the two sources in (4.7), or a new
uniform covering collection with local solubility proved at \(2,3,p\).
Poonen--Schaefer and Stoll provide fixed-algebra descent algorithms, not a
uniform theorem making either kernel in (4.8) vanish.  Thus no unconditional
uniform Chabauty/partial-descent closure is claimed here.

## 9. Exact remaining theorem

For every odd prime \(p\ne3\), prove both maps in

\[
 U_p^{\rm odd}/E_p\xrightarrow{\lambda_{U,p}}Q_{2,p},
 \qquad
 C_p^{\rm surv}\xrightarrow{\partial_{C,p}}
      \operatorname {coker}(\lambda_{U,p})                 \tag{9.1}
\]

are injective.  This formulation already includes:

* all allowed \(S\)-unit corrections;
* the image, rather than the whole, of the \(S\)-class 2-torsion after odd
  local conditions;
* the unique dyadic local Kummer Lagrangian;
* the odd-order and Wieferich branches.

It is equivalent to equation (5.7), but it separates the two possible
sources of every extra class through the canonical \(S\)-unit/\(S\)-class
filtration and dyadic localization.  No claim of absolute minimality among
all possible descent or Chabauty reformulations is made.

## 10. References and trust boundary

* D. Barrera Salazar, A. Pacetti, G. Tornaría,
  [*On the 2-Selmer group of Jacobians of hyperelliptic curves*](https://arxiv.org/pdf/2308.08663v1),
  arXiv:2308.08663v1 (2023): Theorem 2.1 and Definition 2.2, pp. 5--6;
  Definition 3.2, pp. 6--7; Lemma 3.13 and Theorem 3.14, p. 10;
  Hypotheses 5.2, Proposition 5.7, Definition 5.8, Proposition 5.9,
  Theorem 5.12, and Theorem 5.15, pp. 13--17; examples, pp. 26--27.
* M. Stoll,
  [*Implementing 2-descent for Jacobians of hyperelliptic curves*](https://www.impan.pl/shop/en/publication/transaction/download/product/83397),
  Acta Arith. 98 (2001), 245--277: Proposition 4.2, pp. 250--251;
  Lemma 4.5 and Proposition 4.6, pp. 251--252; Corollary 4.7 and
  Lemma 4.9, pp. 253--255.
* B. Poonen and E. Schaefer,
  [*Explicit descent for Jacobians of cyclic covers of the projective line*](https://math.mit.edu/~poonen/papers/descent.pdf),
  J. reine angew. Math. 488 (1997), 141--188.
* E. Schaefer,
  [*2-descent on the Jacobians of hyperelliptic curves*](https://doi.org/10.1006/jnth.1995.1044),
  J. Number Theory 51 (1995), 219--232.

The companion Lean file
`IUTThreeClosures/FreyPellChebyshevUniformSelmerExactResidual.lean`
checks only the scalar consequences of (0.2), (0.3), and the dimension-only
counterexample.  It does not formalize number fields, class groups, local
Kummer images, the short exact sequence (4.7), BSPT, Stoll, or any Selmer
calculation.  Those inputs remain transparently external accepted
mathematics.
