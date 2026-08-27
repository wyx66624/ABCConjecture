# Prime-index Chebyshev square: ambiguous-class descent and the exact uniform residual

## Scope and conclusion

Write \(\mathcal T_0(X)=1\), \(\mathcal T_1(X)=X\), and

\[
 \mathcal T_{n+2}(X)=2X\mathcal T_{n+1}(X)-\mathcal T_n(X).
\]

The question audited here is whether

\[
 y^2=4\mathcal T_p(T)+5,\qquad T>1,\quad p\ge 11\text{ prime},        \tag{0.1}
\]

can occur.  The lower prime index \(p=7\) is handled by a separate
Coleman--Chabauty certificate.  This note does **not** prove that (0.1) has no
solutions.  It gives an exact ambiguous-class principalization, keeps the complete ledger
at the unique prime above \(2\), and records why the accepted uniform
unit-equation and primitive-divisor theorems do not yet exclude the moving
family.  In particular, this note is neither an \(abc\) proof nor an input
that assumes \(abc\), Szpiro, GRH, BSD, or another open conjecture.

The smallest remaining statement is displayed in Section 9.

## 1. The four-consecutive block

Assume hypothetically that (0.1) holds and put

\[
 Z=\mathcal T_p(T)=b^2+3b+1,
 \qquad y=2b+3,                                             \tag{1.1}
\]

using the positive branch.  In the Pell family under audit the four
consecutive integers have the exact decomposition

\[
 b=Au^2,\qquad b+1=Bv^2,\qquad b+2=3r^2,\qquad b+3=s^2,      \tag{1.2}
\]

where \(A,B\) are positive squarefree and coprime and \(3\nmid AB\).  Set

\[
 D=3AB,\qquad
 \varepsilon=T+x_0y_0\sqrt D,\qquad
 \varepsilon^p=Z+uvrs\sqrt D.                              \tag{1.3}
\]

Here \(\varepsilon\) is the positive norm-one fundamental unit and the
odd-index half-angle identities give

\[
 T-1=Ax_0^2,\qquad T+1=3By_0^2.                             \tag{1.4}
\]

Conversely, (1.2)--(1.4), together with the last equality in (1.3), are the
full specialized residual and not merely necessary congruences.

The elementary four-consecutive identity gives

\[
 Z^2-3AB(uvrs)^2=1,\qquad 4Z+5=(2b+3)^2.                   \tag{1.5}
\]

The target branch assumes \(T\equiv23\pmod {24}\); this residue must be
supplied by the upstream four-consecutive reduction and is not implied by
oddness of \(T\) alone.  The theorem
`pellChebyshev_pellResidue_of_odd` now verifies in Lean that odd \(p\)
then gives \(Z=T_p(T)\equiv23\pmod {24}\).  Solving (1.1)--(1.2) modulo
\(24\) gives the single residue

\[
 b\equiv22\pmod {24}.                                     \tag{1.6}
\]

Indeed the square residues modulo \(24\), together with
\(b+2=3r^2\) and \(b+3=s^2\), eliminate the other roots of
\(b^2+3b+1\equiv23\).  It follows that

\[
 v_2(b)=1,\quad 4\mid r,\quad u,v,s\text{ are odd},\quad
 A\equiv22, B\equiv23\pmod {24}.                          \tag{1.7}
\]

In particular \(D\equiv6\pmod8\).

## 2. The square ideal and its moving ramified-prime class

Let \(K=\mathbf Q(\sqrt D)\), let conjugation in \(K\) be denoted by a bar,
and define

\[
 \alpha=1+2\varepsilon^p.                                  \tag{2.1}
\]

Then

\[
 N_{K/\mathbf Q}(\alpha)=4Z+5=(2b+3)^2                    \tag{2.2}
\]

and, exactly,

\[
 \alpha-2\varepsilon^p\bar\alpha=-3.                      \tag{2.3}
\]

Because \(Z\equiv-1\pmod3\), the integer \(2b+3\) is not divisible by
\(3\).  Thus \((\alpha)\) and \((\bar\alpha)\) are coprime: a common prime
ideal would divide (2.3), whereas (2.2) has norm prime to \(3\).  Unique
factorization of ideals in \(K\) therefore gives

\[
 (\alpha)=\mathfrak a^2,\qquad
 [\mathfrak a]\in\operatorname {Cl}(K)[2].                 \tag{2.4}
\]

This class is not an unspecified obstruction.  Pass to the biquadratic
square-root field

\[
 L=\mathbf Q(\sqrt B,\sqrt{3A})                             \tag{2.5}
\]

and put

\[
 \beta=vs\sqrt B+ur\sqrt{3A}.                              \tag{2.6}
\]

Direct expansion using (1.2) gives

\[
 \beta^2=1+2\varepsilon^p=\alpha.                          \tag{2.7}
\]

There is also a square already in the third quadratic subfield:

\[
 \gamma=\sqrt B\,\beta=Bvs+ur\sqrt D,\qquad
 \gamma^2=B\alpha.                                        \tag{2.8}
\]

For every rational prime \(q\mid B\), let \(\mathfrak q\) be the unique
ramified prime of \(K\) over \(q\), and set

\[
 \mathfrak P_B=\prod_{q\mid B}\mathfrak q,\qquad
 (B)=\mathfrak P_B^2.                                      \tag{2.9}
\]

Equations (2.4), (2.8), and (2.9) imply

\[
 (\gamma)^2=(\mathfrak P_B\mathfrak a)^2.
\]

The fractional-ideal group is torsion-free, so
\((\gamma)=\mathfrak P_B\mathfrak a\).  Consequently

\[
 \boxed{[\mathfrak a]=[\mathfrak P_B]}.                    \tag{2.10}
\]

The inverse can be omitted because \([\mathfrak P_B]^2=1\).  Thus the
apparently moving \(2\)-torsion class is exactly the ambiguous class generated
by the ramified primes indexed by \(B\); no class-group conjecture is needed
to identify it.  The field \(L\) is a principalizing square-root field for
this calculation, not the strict genus field of \(K\): Section 4 shows that
\(L/K\) remains ramified above \(2\).

The odd ramified-prime residues explain why a purely local attempt does not
remove this class.  At a ramified \(q\mid A\),
\(\alpha\equiv3\pmod{\mathfrak q}\); at a ramified \(q\mid B\),
\(\alpha\equiv-1\pmod{\mathfrak q}\).  These follow from
\(T\equiv1\pmod q\), respectively \(T\equiv-1\pmod q\), and are independent
of the odd prime \(p\).  They show that the odd ramified valuations vanish,
but they do not principalize (2.10).

## 3. Three quadratic-subfield norms

For compactness write

\[
 X=vs\sqrt B,\qquad R=ur\sqrt{3A},\qquad t=X-R,
\]

and introduce the norm-one units

\[
 \eta_B=(b+2)+X\in\mathbf Q(\sqrt B),\qquad
 \eta_A=(b+1)+R\in\mathbf Q(\sqrt{3A}).                    \tag{3.1}
\]

Their norms are one because

\[
 X^2=(b+1)(b+3),\qquad R^2=b(b+2).                          \tag{3.2}
\]

Taking the two relative norms of \(\beta\pm1\) gives four exact identities:

\[
\begin{aligned}
 N_{L/\mathbf Q(\sqrt B)}(\beta+1)&=2\eta_B,&
 N_{L/\mathbf Q(\sqrt B)}(\beta-1)&=2\eta_B^{-1},\\
 N_{L/\mathbf Q(\sqrt{3A})}(\beta+1)&=-2\eta_A^{-1},&
 N_{L/\mathbf Q(\sqrt{3A})}(\beta-1)&=-2\eta_A.
\end{aligned}                                               \tag{3.3}
\]

Equivalently,

\[
 \eta_B={ (\beta+1)(t+1)\over2},\qquad
 \eta_A={ (\beta-1)(t+1)\over2}.                           \tag{3.4}
\]

It follows that

\[
 (t+1)^2={2\eta_A\eta_B\over\varepsilon^p},\qquad
 {\beta+1\over\beta-1}={\eta_B\over\eta_A}.               \tag{3.5}
\]

If \(\delta=\eta_B/\eta_A\), elimination of \(\beta\) from (2.7) and
(3.5) gives the especially small unit equation

\[
 \boxed{(\delta-1)^2\varepsilon^p=2\delta}.                 \tag{3.6}
\]

This is an exact reformulation.  In the square-class group of \(L\), however,
the odd power \(\varepsilon^p\) has the same class as \(\varepsilon\).
Therefore ambiguous-class and square-class information alone sees only the
parity of \(p\), not its size.

## 4. The complete ledger above 2

The congruences (1.7) imply

\[
 B\equiv7\pmod8,\qquad 3A\equiv2\pmod8,\qquad D\equiv6\pmod8. \tag{4.1}
\]

All three quadratic subfields of \(L\) are consequently ramified at \(2\).
The local extension \(L/\mathbf Q\) has degree four and is totally ramified
at \(2\).  Hence there is a unique prime \(\mathfrak P\) of \(L\) above
\(2\), and

\[
 (2)=\mathfrak P^4,\qquad N\mathfrak P=2.                  \tag{4.2}
\]

From (2.7),

\[
 (\beta-1)(\beta+1)=2\varepsilon^p.                        \tag{4.3}
\]

Thus both factors are supported only at \(\mathfrak P\).  The scalar norm
calculation from the four conjugates gives

\[
 |N_{L/\mathbf Q}(\beta-1)|=|N_{L/\mathbf Q}(\beta+1)|=4.  \tag{4.4}
\]

Combining (4.2)--(4.4), with no omitted unit factor at the ideal level,
gives the two exact ledgers

\[
 \boxed{(\beta-1)=\mathfrak P^2,\qquad
        (\beta+1)=\mathfrak P^2}.                           \tag{4.5}
\]

Their quotient is the ordinary unit \(\eta_B/\eta_A\) in (3.5).  Therefore
principalizing \(\mathfrak P^2\), or merely renaming (4.3) as an
\(S\)-unit equation, supplies no additional exponent bound: it returns
exactly (3.6).

## 5. What Kubota's theorem does, with its exact quantifier

Kubota's Satz 1 applies to **one fixed real biquadratic field** \(L\) with
quadratic subfields \(L_1,L_2,L_3\).  In the branch where at least one
quadratic-subfield fundamental unit has norm \(+1\), every unit of \(L\) has
the form

\[
 \pm\sqrt{\epsilon_1^{m_1}\epsilon_2^{m_2}\epsilon_3^{m_3}},             \tag{5.1}
\]

subject to the requirement that \(m_i\) is even unless
\(N_{L_i/\mathbf Q}(\epsilon_i)=1\), and subject to the product in (5.1)
actually being a square in \(L\).  If all three fundamental units have norm
\(-1\), Kubota has a separate branch which can also contain
\(\sqrt{\epsilon_1\epsilon_2\epsilon_3}\).  The present field is in the
first branch: \(B\equiv7\pmod8\) makes the negative Pell equation over
\(\mathbf Q(\sqrt B)\) impossible modulo \(8\), so its fundamental unit has
norm \(+1\).  This is the classification restated in Kala--Man,
Theorem 3.1 and Lemma 3.2.

Applied here, Kubota gives a finite \(2\)-primary list of possible square
roots and unit indices after \(A,B\), hence \(L\), have been fixed.  It does
not bound the integer exponents of the three quadratic-subfield fundamental
units.  The finite list of combination **types** is uniform, but the units
\(\epsilon_i\), the square-feasibility of each type, and their heights move
with the discriminants \(A,B\); the theorem gives no uniform exponent bound.
In particular it cannot distinguish \(\varepsilon^p\) from \(\varepsilon\)
in a square-class calculation when \(p\) is odd.

References:

* T. Kubota, *Über den bizyklischen biquadratischen Zahlkörper*, Nagoya
  Math. J. **10** (1956), 65--85.
* V. Kala and S. H. Man, *Sails for universal quadratic forms*, Selecta
  Math. **31** (2025), Section 3.1,
  [DOI 10.1007/s00029-025-01022-z](https://doi.org/10.1007/s00029-025-01022-z).

## 6. The degree-eight extension degenerates exactly

Let \(p=2m+1\) and set

\[
 \Delta=x_0\sqrt A+y_0\sqrt{3B}.
\]

Equations (1.3)--(1.4) give \(\Delta^2=2\varepsilon\).  The positive
half-index square root is

\[
 q=\Delta\varepsilon^m=us\sqrt A+vr\sqrt{3B},\qquad
 q^2=2\varepsilon^p.                                      \tag{6.1}
\]

In

\[
 E=\mathbf Q(\sqrt3,\sqrt A,\sqrt B)
\]

put \(\lambda=\beta+q\).  Since \(\beta^2-q^2=1\),
\(\lambda^{-1}=\beta-q\).  More importantly, the apparent new degree-eight
unit factors exactly:

\[
 \boxed{\lambda=(s+r\sqrt3)(u\sqrt A+v\sqrt B)}.            \tag{6.2}
\]

After squaring,

\[
 \lambda^2=(s+r\sqrt3)^2
   \bigl((2b+1)+2uv\sqrt{AB}\bigr)
   \in\mathbf Q(\sqrt3,\sqrt{AB}).                         \tag{6.3}
\]

Both factors are already visible Pell units:

\[
 s^2-3r^2=1,\qquad
 (2b+1)^2-AB(2uv)^2=1.                                    \tag{6.4}
\]

Thus the degree-eight extension and its Hasse unit index do not introduce a
new carrier for the prime exponent.  They split back into the two adjacent
quadratic kernels in (1.2).

## 7. Exact boundaries of accepted uniform theorems

The following statements are unconditional and accepted, but their
quantifiers stop short of the moving residual.

1. **Beukers--Schlickewei.**  Theorem 1.1 says: if \(G\) is the
   \(\mathbf Q\)-closure of a finitely generated subgroup of
   \((\mathbf C^*)^2\) of rank \(r\), then \(x+y=1\) has at most
   \(2^{8r+8}\) solutions in \(G\).  For one fixed \(L\), the ordinary
   \(S\)-unit rank is \(r_1+r_2-1+|S_f|=4\), because \(L\) is totally real
   of degree four and \(S_f=\{\mathfrak P\}\).  A pair group may therefore
   be taken with rank at most eight.  Thus its numerical bound \(2^{72}\) is
   uniform even as \(L\) moves.  What remains missing is not a uniform count:
   the theorem gives neither the height of any possible solution nor its
   exponent \(p\), and the underlying unit group itself changes with \(L\).

2. **Bérczes--Evertse--Győry.**  Their hyper- and superelliptic theorems fix
   a number field \(K\), a finite set \(S\), a nonzero \(S\)-integer \(b\),
   and a polynomial \(f\) with nonzero discriminant.  The explicit height
   and exponent bounds depend on the discriminant of \(K\), the norms of
   primes in \(S\), and the heights of \(b,f\).  In the present family these
   inputs move with \(A,B\), so the theorem is effective pointwise but not a
   uniform-in-\(p\), moving-field exclusion.

3. **Mocanu.**  Theorem 3 fixes a totally real field \(K\) and a distinguished
   prime \(\widetilde{\mathfrak P}\mid2\).  Besides
   \(\operatorname {Cl}_{S_K}(K)[2]=1\), it assumes that every
   \(\alpha,\beta\in\mathcal O_{S_K}^{*}\),
   \(\gamma\in\mathcal O_{S_K}\) with
   \(\alpha+\beta=\gamma^2\) satisfies
   \(\lvert v_{\widetilde{\mathfrak P}}(\alpha/\beta)\rvert
     \leq6v_{\widetilde{\mathfrak P}}(2)\).
   It then bounds the exponent in primitive nontrivial
   \(a^p+b^p=c^2\) solutions having
   \(\widetilde{\mathfrak P}\mid b\), by a constant \(B_K\) depending on
   that fixed field.  Our descent produces the moving class
   \([\mathfrak P_B]\) in (2.10), but proves neither
   \(\operatorname {Cl}_{S_K}(K)[2]=1\) uniformly nor Mocanu's local
   valuation hypothesis.

4. **Bugeaud--Shorey.**  The solution-count theorem for
   \(D_1x^2+D_2=k^n\) fixes positive coprime \(D_1,D_2\), a positive odd
   integer \(k\), and assumes \(\gcd(k,D_1D_2)=1\).  It does not cover a
   moving algebraic-unit base and moving biquadratic field.

5. **Bremner--Tzanakis.**  In their notation \(n_0,k\) are fixed.  Their
   passage from \(n_0\) to \(n=mn_0\) further requires every prime of \(m\)
   to lie in one fixed finite set \(S\).  The quantifier pattern relevant here
   is their Table 1 type (iv), where \(P,Q,n\) move while the power exponent
   \(r=2\) is fixed; the paper labels that general case very difficult and
   treats restricted versions.  Problem 1 fixes \(k,n_0,S\).  Theorem 2.1
   fixes \(k,n_0\) and proves finiteness as the coprime recurrence parameters
   move; it does not assert the stronger all-moving uniform conclusion needed
   here.

6. Results on shifted powers in Lucas sequences, including the papers of
   Bennett et al. and Bennett--Patel--Siksek, fix the recurrence and its
   coefficients.  Here the fundamental unit and the field both move.

The first item is already weaker than the fixed-\((A,B)\) Bennett--Walsh
input: their Theorem 1.2 is applied with coefficient pair
\((b_{\mathrm{BW}},d_{\mathrm{BW}})=(B,3A)\) and permits at most one relevant
Pell coordinate after that entire pair is fixed.  Neither statement bounds
the one possible prime exponent as the coefficients move.
Moreover the \(p=1\) four-consecutive identities produce elements
\(\beta\pm1\) of unbounded height in moving real biquadratic fields while
retaining a single prime above \(2\) and absolute norm four.  Hence no height
bound can depend only on degree, Galois type, \(|S_f|=1\), and the norm in
(4.4).  A successful theorem must use the extra assertions that
\(\varepsilon\) is fundamental and \(p\ge11\) is prime.

References for this section:

* F. Beukers and H. P. Schlickewei, *The equation \(x+y=1\) in finitely
  generated groups*, Acta Arith. **78** (1996), 189--199,
  [DOI 10.4064/aa-78-2-189-199](https://doi.org/10.4064/aa-78-2-189-199).
* A. Bérczes, J.-H. Evertse, and K. Győry, *Effective results for hyper- and
  superelliptic equations over number fields*, Publ. Math. Debrecen **82**
  (2013), 727--756,
  [arXiv:1301.7168](https://arxiv.org/abs/1301.7168),
  [DOI 10.5486/PMD.2013.5748](https://doi.org/10.5486/PMD.2013.5748).
* V. Mocanu, *Asymptotic Fermat for signatures \((p,p,2)\) and \((p,p,3)\)
  over totally real fields*,
  [arXiv:2203.07873](https://arxiv.org/abs/2203.07873).
* Y. Bugeaud and T. N. Shorey, *On the number of solutions of the generalized
  Ramanujan--Nagell equation*, J. Reine Angew. Math. **539** (2001), 55--74,
  [DOI 10.1515/crll.2001.079](https://doi.org/10.1515/crll.2001.079).
* A. Bremner and N. Tzanakis, *Lucas sequences whose \(n\)-th term is a square
  or an almost square*, Acta Arith. **126** (2007), 261--280,
  [official article](https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/126/3/83425/lucas-sequences-whose-n-th-term-is-a-square-or-an-almost-square).
* M. A. Bennett and G. Walsh, *The Diophantine equation
  \(b^2X^4-dY^2=1\)*, Proc. Amer. Math. Soc. **127** (1999), 3481--3491,
  [author PDF](https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf).
* M. A. Bennett, S. R. Dahmen, M. Mignotte, and S. Siksek, *Shifted powers
  in binary recurrence sequences*,
  [arXiv:1408.1710](https://arxiv.org/abs/1408.1710).
* M. A. Bennett, V. Patel, and S. Siksek, *Shifted powers in Lucas--Lehmer
  sequences*, [arXiv:1811.10889](https://arxiv.org/abs/1811.10889).

## 8. A fundamental-unit/BHV splitting diagnostic

The following exact example disproves a tempting **method claim**: one cannot
argue that a primitive divisor supplied by Bilu--Hanrot--Voutier must fail the
quadratic splitting condition merely because the Pell generator is
fundamental.  It is not a solution of (0.1).

Take

\[
 K=\mathbf Q(\sqrt{3585}),\qquad
 \varepsilon=479+8\sqrt{3585}.                            \tag{8.1}
\]

PARI/GP returns

```text
? quadunit(3585)
% = 471 + 16*w
```

where \(w=(1+\sqrt{3585})/2\); hence (8.1) is the fundamental unit.  The
integer identity

\[
 479^2-3585\cdot8^2=1                                    \tag{8.2}
\]

is elementary.  At \(p=17\), exact integer arithmetic gives

\[
\begin{aligned}
 \mathcal T_{17}(479)
  &=479\cdot1235420969309\\
  &\quad\cdot407403853151449298643522544267728629\\
  &=241088011053920208729099094596353527770088881085919.
\end{aligned}                                             \tag{8.3}
\]

Let

\[
 q_1=1235420969309,\qquad
 q_2=407403853151449298643522544267728629.
\]

External PARI `isprime` computations return \(1\) for both.  They also satisfy

\[
 q_1\equiv q_2\equiv4\pmod5,\qquad
 q_1\equiv q_2\equiv1\pmod {68}.                          \tag{8.4}
\]

Define the Lucas sequence

\[
 U_0=0,\quad U_1=1,\quad U_{n+2}=958U_{n+1}-U_n.           \tag{8.5}
\]

The following exact modular recurrence is a reproducible rank certificate:

```gp
Umod(n,q)={
  my(a=0,b=1,c);
  for(k=1,n, c=lift(Mod(958*b-a,q)); a=b; b=c);
  return(a)
};
select(n->Umod(n,q1)==0,[1..34])
% = [34]
select(n->Umod(n,q2)==0,[1..34])
% = [34]
```

Thus the first zero modulo each \(q_i\) occurs at \(34\).  Since

\[
 U_{34}=2U_{17}\mathcal T_{17}(479)                        \tag{8.6}
\]

and neither prime divides the Lucas discriminant \(958^2-4\), both \(q_i\)
are genuine primitive divisors of \(U_{34}\).  Congruence (8.4) also says
that both primes split in \(\mathbf Q(\sqrt5)\).  Hence BHV existence,
fundamentality, and the desired quadratic splitting can hold simultaneously.

This diagnostic is not a counterexample to the shifted-square assertion:

\[
 4\mathcal T_{17}(479)+5\equiv3\pmod7,                     \tag{8.7}
\]

which is nonsquare modulo \(7\).  Its role is solely to block the proposed
uniform BHV-plus-splitting contradiction.

The primitive-divisor theorem used for context is Y. Bilu, G. Hanrot, and
P. M. Voutier, *Existence of primitive divisors of Lucas and Lehmer numbers*,
J. Reine Angew. Math. **539** (2001), 75--122,
[DOI 10.1515/crll.2001.080](https://doi.org/10.1515/crll.2001.080).

## 9. Minimal residual for \(p\ge11\)

The exact unresolved statement left by this route is the following.

> **Moving fundamental-unit ambiguous-class/S-unit residual.**  Let \(A,B\) be
> positive squarefree coprime integers with \(3\nmid AB\).  There do not
> exist positive integers \(x_0,y_0,u,v,r,s,b,T\) and a rational prime
> \(p\ge11\) such that
> \[
> \begin{gathered}
> T\equiv23\pmod {24},\\
> T-1=Ax_0^2,\qquad T+1=3By_0^2,\\
> b=Au^2,\qquad b+1=Bv^2,\qquad
> b+2=3r^2,\qquad b+3=s^2,\\
> D=3AB,\qquad
> \varepsilon=T+x_0y_0\sqrt D
>   \text{ is the positive fundamental norm-one unit},\\
> \varepsilon^p=b^2+3b+1+uvrs\sqrt D.
> \end{gathered}                                           \tag{9.1}
> \]

Equivalently, retaining all the constraints in (9.1), the principalizing-field form is

\[
 B(1+2\varepsilon^p)=(Bvs+ur\sqrt D)^2,                   \tag{9.2}
\]

and the biquadratic \(S\)-unit form is

\[
 \beta^2-1=2\varepsilon^p,\quad
 (\beta-1)=(\beta+1)=\mathfrak P^2,\quad
 |N_{L/\mathbf Q}(\beta\pm1)|=4,                          \tag{9.3}
\]

with the explicit relative norms (3.3) and the unique prime
\(\mathfrak P\mid2\).

No accepted theorem cited above uniformly excludes (9.1)--(9.3) as
\(K,L,A,B\) move.  Proving that statement, or producing an exact finite
reduction plus certificates, would close the prime-index residual.  The
ramified-prime class identity, Kubota classification, degree-eight factorization, and BHV
alone do not.

## 10. Lean companion and trust boundary

`IUTThreeClosures/FreyPellChebyshevPrimeIndexUniformGenusAudit.lean` checks:

* the scalar coordinates of (2.7) and (2.8);
* all four relative-norm identities (3.3), the two norm-one identities, and
  the denominator-cleared quotient and exponent equation (3.6);
* the scalar absolute norm in (4.4);
* the degree-eight factorization (6.2) and adjacent Pell norm (6.4);
* (8.2), the exact factorization (8.3), residues (8.4), and (8.7).

It deliberately does not formalize quadratic number fields, ideals,
ambiguous class theory, local ramification, Kubota's theorem, the cited Diophantine theorems,
BHV, PARI primality, the ranks of apparition, or the residual (9.1).
`#print axioms` is included for transparent dependency disclosure.  The Lean
file contains no axiom asserting the desired \(p\ge11\) exclusion.
