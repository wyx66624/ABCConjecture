# The parity square class of the Pell companion: an unconditional boundary audit

## Abstract

Let

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,
 \qquad c_n=s_n^2-2=3r_n^2-1,
\]

and write, uniquely,

\[
 c_n=A_ny_n^2,
 \qquad A_n>0\ \hbox{squarefree}.
\]

Put

\[
 H_n=n\log(97+56\sqrt3).
\]

The coefficient-one estimate needed from this route is

\[
 \log A_n\ge (1-o(1))H_n.                         \tag{0.1}
\]

No accepted unconditional theorem audited below proves (0.1).  The main
terminological point is decisive: in Stewart's paper the “greatest square
free factor” is explicitly

\[
 Q(m)=\prod_{p\mid m}p=\operatorname {rad}(m),
\]

not the parity square-class representative in \(m=A y^2\).  Thus Stewart's
strong pointwise lower bound for \(Q(c_n)\) is a radical theorem and supplies
no lower bound for \(A_n\).

The square-class theorems of Shorey--Stewart and
Ribenboim--McDaniel also have the wrong quantifiers.  Their general result
first fixes the Lucas parameters and the multiplier \(k\), and only then
bounds solutions of \(U_j=kx^h\) by a constant depending on \(k\).  The
printed theorem contains no uniform estimate of \(j\) in terms of
\(\log k\).  The square-class results bound collisions inside one class; they
do not bound the numerical size of the class representative.  Moreover,
\(c_n\) is an order-three shifted sequence, not a Lucas or Lehmer sequence to
which those binary theorems directly apply.

There are two exact boundary models.

* \(Z_n=2s_n^2=2c_n+4\) has exactly the same characteristic polynomial and
  order-three recurrence as \(c_n\), but its parity square class is \(2\) for
  every \(n\).  It has eventual primitive support and it is never a perfect
  power.
* The fixed discriminant \(47\equiv23\pmod {24}\) has the infinite norm-two
  Pell orbit generated from \(7^2-47\cdot1^2=2\) by multiplication by
  \(48+7\sqrt {47}\).  Hence the norm-two equation and the congruence, without
  the actual simultaneous \(s_n^2-3r_n^2=1\) and fundamental-solution
  conditions, do not make the squarefree parameter grow.

The special factorization in \(\mathbf Q(\sqrt2)\) is exact and useful for
locating the remaining problem.  It turns \(s_n+\sqrt2\) into a square times
an algebraic integer of norm \(A_n\), and hence into an indefinite binary
quadratic form of discriminant \(4A_n\) representing \(1\).  This is another
presentation of the same regulator problem, not an independent height
bound.  The simultaneous-Pell and Richaud--Degert literature audited here
does not change that conclusion.

Consequently the strongest accepted pointwise estimate for \(A_n\) in the
present chain remains the fundamental-unit/class-number estimate

\[
 A_n\ge
 \left({64\over c_2^2}-o(1)\right)
 {H_n^2\over(\log H_n)^2},
 \qquad c_2=2-{2\over\sqrt e},                    \tag{0.2}
\]

with \(64/c_2^2=103.347\ldots\).  Equivalently,

\[
 \log A_n\ge
 2\log H_n-2\log\log H_n+
 \log(64/c_2^2)+o(1)=o(H_n).                     \tag{0.3}
\]

No abc, Szpiro, GRH, or other open conjecture is used in this note.

## 1. Radical versus parity square class

If

\[
 m=\prod_p p^{e_p},
\]

there are two different squarefree integers in common use:

\[
 \operatorname {rad}(m)=\prod_{e_p>0}p,
 \qquad
 \operatorname {core}_2(m)=\prod_{e_p\ {\rm odd}}p.       \tag{1.1}
\]

The second is characterized by

\[
 m=\operatorname {core}_2(m)y^2.                 \tag{1.2}
\]

Thus \(A_n=\operatorname {core}_2(c_n)\), while Stewart's \(Q(c_n)\)
is \(\operatorname {rad}(c_n)\).  One has

\[
 A_n\mid\operatorname {rad}(c_n),                \tag{1.3}
\]

but there is no reverse lower bound.  An arbitrarily large product of
primes occurring to even exponent contributes to the radical and contributes
nothing to \(A_n\).

The exact height ledger is

\[
 \log c_n=\log A_n+2\log y_n.                    \tag{1.4}
\]

Since \(\log c_n=H_n+O(1)\), estimate (0.1) is equivalent to

\[
 \log y_n=o(H_n),                                \tag{1.5}
\]

or, equivalently, to the statement that the largest square divisor
\(y_n^2\) of \(c_n\) is \(c_n^{o(1)}\).  A radical theorem does not address
the subtractive term \(2\log y_n\) in (1.4).

## 2. What Stewart's theorem says

Stewart defines, word for word, (Q(m)) by

\[
 m=p_1^{h_1}\cdots p_r^{h_r}
 \quad\Longrightarrow\quad
 Q(m)=p_1\cdots p_r.                              \tag{2.1}
\]

His Theorem 1 applies to an integer exponentially approximated by a dominant
algebraic power.  For a nondegenerate recurrence with a dominant root it
gives effective constants \(C_2,C_3>0\) such that, for \(j>C_3\),

\[
 Q(u_j)>j^{C_2\log_2j/\log_3j}.                  \tag{2.2}
\]

The hypotheses apply to \(c_n\), whose characteristic roots are

\[
 \lambda=97+56\sqrt3,
 \qquad 1,
 \qquad \lambda^{-1}.                            \tag{2.3}
\]

Consequently (2.2) is a genuine unconditional pointwise radical estimate for
\(c_n\).  It is not an estimate for \(A_n\).  Reading \(Q\) as the parity
squarefree part would change the theorem's definition and is therefore not
permissible.

The older binary estimates of Stewart, Yu--Hung, and Shorey quoted in the
same paper use the same \(Q=\operatorname {rad}\).  They do not repair this
parity mismatch.

## 3. An exact same-spectrum obstruction

Define

\[
 Z_n=2s_n^2=2c_n+4.                              \tag{3.1}
\]

The coordinate \(s_n\) is odd.  Therefore

\[
 Z_n=2\cdot(\hbox{odd})^2,
 \qquad \operatorname {core}_2(Z_n)=2            \tag{3.2}
\]

for every \(n\ge1\).  On the other hand, the affine identity in (3.1)
shows that \(Z_n\) obeys exactly the recurrence of \(c_n\):

\[
 Z_{n+3}=195Z_{n+2}-195Z_{n+1}+Z_n.              \tag{3.3}
\]

Its characteristic polynomial is

\[
 (X-1)(X^2-194X+1)
 =X^3-195X^2+195X-1.                             \tag{3.4}
\]

Thus dominance, simplicity, nondegeneracy, the characteristic roots, and the
entire recurrence spectrum do not control the parity square class.

This model also survives two common proposed repairs.

First, \(v_2(Z_n)=1\), so \(Z_n\) is not a perfect \(q\)-th power for any
\(q\ge2\).

Second, put

\[
 \alpha=7+4\sqrt3,
 \quad \beta=\alpha^{-1},
 \quad V_n=\alpha^n+\beta^n=2s_n,
\]

and let \(U_j=(\alpha^j-\beta^j)/(\alpha-\beta)\).  The Lucas identity

\[
 U_{2n}=U_nV_n                                      \tag{3.5}
\]

and the Bilu--Hanrot--Voutier theorem show that, for \(2n>30\), a primitive
divisor of \(U_{2n}\) divides \(V_n\) and no earlier \(V_m\).  Hence the
support of \(Z_n=V_n^2/2\) has an eventual primitive prime.  Every such odd
prime occurs in \(Z_n\) to even exponent.  Primitive support records first
appearance, not valuation parity.

Accordingly none of the following data, separately or together, implies
growth of \(A_n\):

1. a dominant nondegenerate recurrence;
2. a strong radical lower bound;
3. eventual primitive divisors; or
4. absence of perfect powers.

## 4. The exact quantifiers in square-class and power theorems

### 4.1 Shorey--Stewart

The general theorem recorded as (5.1) in Ribenboim's
*My Numbers, My Friends* has the following order of quantifiers.  Fix a
nondegenerate Lucas sequence (U(P,Q)) and fix an integer \(k\ge1\).  Then
there is an effectively computable

\[
 C=C(P,Q,k)>0                                    \tag{4.1}
\]

such that

\[
 U_j=kx^h,\quad |x|\ge2,\quad h\ge2
 \quad\Longrightarrow\quad j,|x|,h<C.           \tag{4.2}
\]

The analogous assertion holds for \(V_j\).  Ribenboim's later paper on
terms \(Cx^h\), formula (1.4), again says: for a given Lucas sequence and a
given integer \(A\ge1\), a constant depending on \(P,Q,A\) bounds the
solutions.

This is effective fixed-\(k\) finiteness.  Neither printed statement gives a
uniform estimate

\[
 j\ll\log k,
 \quad j\ll(\log k)^B,
 \quad\hbox{or any displayed function of }\log k. \tag{4.3}
\]

An unspecified algorithmic dependence (C(P,Q,k)) cannot be replaced by
the coefficient-one inequality required here.  In particular it cannot be
inverted into \(\log k\ge(1-o(1))H_j\).

There is also a hypothesis mismatch.  The minimal characteristic polynomial
of \(c_n\) is the reducible cubic (3.4), so \(c_n\) is not a binary Lucas or
Lehmer sequence.  Applying (4.2) directly to \(c_n=A_ny_n^2\) would therefore
be invalid even before considering the moving multiplier \(A_n\).

### 4.2 McDaniel--Ribenboim

For fixed odd coprime parameters \(P,Q\) of positive discriminant,
McDaniel and Ribenboim prove that there are only finitely many
**nontrivial** square classes in (U(P,Q)) and (V(P,Q)), and that each
square class contains at most three terms.  “Nontrivial” here means a class
containing more than one term.  Infinitely many singleton classes are not
excluded.

This is a collision theorem:

\[
 U_iU_j=\square
\]

has severely restricted distinct indices.  It is not a lower bound for the
squarefree representative of \(U_j\).  In the actual Pell companion,
Bennett--Walsh already gives the stronger fact that the \(A_n\) are pairwise
distinct.  An injective sequence of squarefree integers need not enumerate
them in increasing numerical order, so injectivity still gives no pointwise
bound of the form (0.1).

The paper *On Lucas sequence terms of the form \(kx^2\)* and the related
algorithms likewise take \(k\) as given.  They solve or bound a fixed
square-class problem; they do not state a uniform index-versus-\(\log k\)
theorem.

## 5. Perfect powers, Subspace Theorem, and fixed support

Bugeaud and Kaneko prove finiteness of perfect powers for an integer linear
recurrence whose characteristic polynomial is irreducible and has a dominant
root.  Their Theorem 1.1 explicitly assumes irreducibility.  Immediately
after the theorem they give the squares of Fibonacci numbers, an order-three
recurrence with reducible characteristic polynomial, to show that the
assumption cannot be removed.

The characteristic polynomial (3.4) is reducible.  More fundamentally,

\[
 c_n=A_ny_n^2
\]

with a moving squarefree \(A_n\) is not a perfect-power equation unless
\(A_n=1\).  Finiteness of exact perfect powers supplies no upper bound for
the square divisor \(y_n^2\).

For a fixed exponent \(q\), the Corvaja--Zannier theorem quoted by
Bugeaud--Kaneko says that infinitely many \(q\)-th powers force an algebraic
\(q\)-th-power recurrence on an arithmetic progression.  Its quantifier is
again about exact powers.  It does not treat a different coefficient
\(A_n\) at each index.

The \(S\)-unit theorems of Bugeaud--Evertse and related Subspace-Theorem
results first fix a finite set of primes \(S\).  Here the support of \(A_n\)
moves with \(n\).  A threshold whose constants depend on \(S\) gives no
pointwise estimate after replacing \(S\) by the prime divisors of the term
being estimated.

Finally, standard \(p\)-adic valuation formulae are prime-by-prime.  Their
constants and ranks of apparition depend on the fixed prime \(p\).  They do
not give the uniform sum

\[
 \sum_p\left\lfloor{v_p(c_n)\over2}\right\rfloor\log p=o(H_n) \tag{5.1}
\]

which is exactly (1.5).  The model \(Z_n\) shows why good control at every
fixed prime can coexist with a full moving set of even-exponent primes.

## 6. The special norm-two equation

The actual square-class decomposition gives

\[
 \nu_n=s_n+y_n\sqrt {A_n},
 \qquad N(\nu_n)=2.                               \tag{6.1}
\]

Squaring and using \(s_n^2-A_ny_n^2=2\) gives the exact identity

\[
 {\nu_n^2\over2}
  =(s_n^2-1)+s_ny_n\sqrt {A_n}
  =(c_n+1)+s_ny_n\sqrt {A_n}.                    \tag{6.2}
\]

The Bennett--Walsh argument in the fundamental-unit audit proves that the
right side of (6.2) is the fundamental norm-one unit
\(\varepsilon_{A_n}\).  Thus the norm-two solution is not merely some point
on a Pell orbit; it lies halfway to the fundamental norm-one unit.

This strengthens the structural description but does not improve the known
uniform regulator bound.  Generalized Pell theorems describe all solutions
after \(A\) is fixed by multiplying a starting solution by powers of
\(\varepsilon_A\).  They do not upper-bound \(\varepsilon_A\) by a polynomial
in \(A\).  Classical continued fractions give only

\[
 \log\varepsilon_A\ll\sqrt A\log A,              \tag{6.3}
\]

the same square-root scale already sharpened by the class-number formula in
this family.

The congruence alone does not help.  The fixed value (A=47\equiv23\pmod
{24}) has

\[
 7^2-47\cdot1^2=2,
 \qquad 48^2-47\cdot7^2=1.                       \tag{6.4}
\]

If \(s^2-47y^2=2\), put

\[
 s'=48s+329y,
 \qquad y'=7s+48y.                               \tag{6.5}
\]

Then

\[
 (s')^2-47(y')^2
 =(48^2-47\cdot7^2)(s^2-47y^2)=2.                \tag{6.6}
\]

This produces an infinite norm-two orbit with constant parity square class.
It is not a counterexample to the full actual system: its later points are
not the least norm-two solution, and they do not also satisfy
\(s^2-3r^2=1\).  It precisely shows which extra hypotheses remain essential.

## 7. Factorization in \(\mathbf Q(\sqrt2)\)

Let \(K=\mathbf Q(\sqrt2)\), whose ring of integers is
\(\mathbf Z[\sqrt2]\).  It is a PID.  Since \(c_n\) is odd, the two ideals

\[
 (s_n+\sqrt2),\qquad(s_n-\sqrt2)                 \tag{7.1}
\]

are coprime.  If an odd prime \(p\mid c_n\), then

\[
 s_n^2\equiv2\pmod p,
\]

so \(p\) splits in \(K\).  Exactly one prime ideal above \(p\) occurs in
\((s_n+\sqrt2)\), with exponent \(v_p(c_n)\).

Taking the parity of these ideal exponents gives an ideal of norm \(A_n\).
Because \(K\) is principal, it has a generator

\[
 \kappa_n=a_n+b_n\sqrt2,
 \qquad N(\kappa_n)=A_n.                         \tag{7.2}
\]

The remaining ideal is a square.  Units of \(K\) are generated, up to sign,
by \(1+\sqrt2\); the unit can be reduced modulo unit squares and absorbed in
the choice of \(\kappa_n\).  Hence there are integers \(u_n,v_n\) such that

\[
 s_n+\sqrt2
  =(a_n+b_n\sqrt2)(u_n+v_n\sqrt2)^2.             \tag{7.3}
\]

Norms and the coefficient of \(\sqrt2\) give

\[
 |u_n^2-2v_n^2|=y_n,                             \tag{7.4}
\]

and

\[
 b_n(u_n^2+2v_n^2)+2a_nu_nv_n=1.                \tag{7.5}
\]

The binary quadratic form in (7.5) has discriminant

\[
 (2a_n)^2-4b_n(2b_n)=4A_n.                      \tag{7.6}
\]

Modulo multiplication of \(\kappa_n\) by unit squares, it may be reduced so
that \(|a_n|+|b_n|\ll\sqrt {A_n}\), with an absolute implied constant.
Nevertheless, (7.5) is an indefinite quadratic equation.  It has an
infinite automorphism orbit controlled by the fundamental unit of
\(\mathbf Q(\sqrt {A_n})\).  Thus (7.3)--(7.6) repackage the regulator
problem; they are not a degree-at-least-three Thue equation and do not bound
\(y_n\) by \(c_n^{o(1)}\).

All prime divisors of \(A_n\) splitting in \(\mathbf Q(\sqrt2)\) is already
contained in the congruence \(p\equiv\pm1\pmod8\).  The factorization exposes
the orientations of the split primes, but no accepted theorem found in this
audit turns those orientations into a pointwise lower bound for \(A_n\).

## 8. Simultaneous Pell and Richaud--Degert results

The genuinely extra equation is

\[
 s_n^2-3r_n^2=1.                                 \tag{8.1}
\]

Together with (6.1), it gives the simultaneous system

\[
 s_n^2-3r_n^2=1,
 \qquad s_n^2-A_ny_n^2=2,                        \tag{8.2}
\]

or \(A_ny_n^2-3r_n^2=-1\).  Accepted simultaneous-Pell theorems of
Masser--Rickert, Bennett, and Bennett--Cipu--Mignotte--Okazaki give
solution-count or gap statements after the nonsquare coefficients are fixed.
They do not state

\[
 \log s\ll\log A                                \tag{8.3}
\]

uniformly for the unique solution while \(A\) moves.  A bound of at most one
or two solutions for each fixed coefficient is compatible with arbitrarily
large height of that one solution.  Bennett--Walsh supplies actual
injectivity and fundamentality, but not (8.3).

Richaud--Degert fields form a different, explicitly parameterized family.
In the standard definition the squarefree radicand has the special shape

\[
 d=m^2+r,
 \qquad r\mid4m,
 \qquad -m<r\le m.                               \tag{8.4}
\]

Their fundamental units have explicit polynomial-size formulae.  The
identity \(s_n^2-A_ny_n^2=2\) does not put \(A_n\) in the form (8.4): it says
that \(A_n\) has an exceptionally accurate rational approximation
\(s_n/y_n\), not that \(A_n\) differs from an integer square by a small
divisor of that integer.  Consequently Richaud--Degert class-number and unit
formulae cannot be applied to \(A_n\) without a new proof of the missing
shape condition.

## 9. Circular results which are excluded

Ribenboim's 2001 paper is titled *On square factors of terms of binary
recurring sequences and the ABC Conjecture*.  Its abstract begins by
assuming abc, and its principal powerful-part results explicitly repeat that
hypothesis.  It cannot be input to a proof of abc.

Likewise, the Ribenboim--Walsh results on the powerful part of Lucas
sequences assume abc.  They are useful descriptions of what abc would imply,
not unconditional control of \(A_n\).

No statement from either paper is used in (0.2).

## 10. Strongest unconditional conclusion and exact missing theorem

The separate fundamental-unit audit proves

\[
 \varepsilon_{A_n}
  =(c_n+1)+y_ns_n\sqrt {A_n},
 \qquad R_n=\log\varepsilon_{A_n}=H_n+O(1).       \tag{10.1}
\]

The real quadratic class-number formula, the local conditions
\(\chi_n(2)=0\), \(\chi_n(3)=-1\), and the best retained small-prime constant
in the audited unconditional quadratic-character bound give

\[
 A_n\ge
 \left({64\over c_2^2}-o(1)\right)
 {R_n^2\over(\log R_n)^2},
 \qquad c_2=2-{2\over\sqrt e}.                   \tag{10.2}
\]

Substitution of (10.1) is (0.2)--(0.3).  Genus theory supplies the further
implicit factor \(2^{\omega(A_n)}\), but this is \(A_n^{o(1)}\) even at its
largest possible order and does not change the square-root regulator scale.

The exact remaining proposition is any one of the equivalent statements

\[
 \boxed{\ \log A_n\ge(1-o(1))H_n\ },             \tag{10.3}
\]

\[
 \log y_n=o(H_n),                                \tag{10.4}
\]

or

\[
 y_n^2\le c_n^{o(1)}.                            \tag{10.5}
\]

This is a pointwise upper bound for the full largest square divisor of the
specific shifted Pell value.  It is strictly stronger than fixed-\(k\)
finiteness, square-class collision bounds, primitive-divisor existence,
radical lower bounds, absence of perfect powers, fixed-\(S\) theorems, and
generic regulator estimates.  None of the accepted results audited here
proves it.

## 11. Formal companion

`IUTThreeClosures/FreyPellSquareclassRecurrenceAudit.lean` verifies only the
elementary scalar and recurrence boundary:

1. \(Z_n=2s_n^2=2c_n+4\);
2. \(Z_n\) satisfies the exact order-three recurrence and characteristic
   polynomial of \(c_n\);
3. the first values are \(98=2\cdot7^2\) and
   \(18818=2\cdot97^2\);
4. multiplication by \(48+7\sqrt {47}\) preserves
   \(s^2-47y^2=2\), and \(47\equiv23\pmod {24}\); and
5. at the scalar level, coefficient-one square-class growth is equivalent to
   sublinear square-base weight.

It does not formalize unique factorization in \(\mathbf Z[\sqrt2]\), Lucas
primitive divisors, any theorem from the cited literature, asymptotic
notation, class numbers, or abc.

## References

* C. L. Stewart, *On the greatest square free factor of terms of a linear
  recurrence sequence*, in N. Saradha (ed.), *Diophantine Equations*, Tata
  Institute of Fundamental Research Studies in Mathematics 20 (2008),
  257--264.  The definition on page 1 explicitly identifies \(Q(m)\) with
  the product of the distinct prime divisors, and Theorem 1 is the pointwise
  recurrence estimate used in Section 2:
  <https://uwaterloo.ca/pure-mathematics/sites/default/files/uploads/documents/greatest_square_free_factor_0.pdf>.

* T. N. Shorey and C. L. Stewart, *On the Diophantine equation
  \(ax^{2t}+bx^ty+cy^2=d\) and pure powers in recurrence sequences*,
  Math. Scand. 52 (1983), 24--36, DOI 10.7146/math.scand.a-11990:
  <https://journals.msp.org/mscand/article/view/1631>.

* P. Ribenboim, *My Numbers, My Friends*, Springer, 2000, Section 5,
  especially statement (5.1), for the fixed-\(k\) quantifiers:
  <https://inis.jinr.ru/sl/M_Mathematics/MT_Number%20theory/Ribenboim%20My.pdf>.

* P. Ribenboim, *The terms \(Cx^h\ (h\ge3)\) in Lucas sequences: an
  algorithm and applications to Diophantine equations*, Acta Arith. 106
  (2003), 105--114.  Formula (1.4) states the fixed-\(A\) dependence:
  <https://www.impan.pl/shop/publication/transaction/download/product/82597>.

* W. L. McDaniel and P. Ribenboim, *Square-Classes in Lucas Sequences
  Having Odd Parameters*, J. Number Theory 73 (1998), 14--27,
  DOI 10.1006/jnth.1998.2280:
  <https://www.sciencedirect.com/science/article/pii/S0022314X98922806>.

* P. Ribenboim and W. L. McDaniel, *On Lucas sequence terms of the form
  \(kx^2\)*, in *Number Theory (Turku, 1999)*, de Gruyter, 2001,
  293--304, DOI 10.1515/9783110870923.293:
  <https://www.degruyter.com/document/doi/10.1515/9783110870923.293/html>.

* Yu. Bilu, G. Hanrot, and P. M. Voutier, *Existence of primitive divisors
  of Lucas and Lehmer numbers*, J. reine angew. Math. 539 (2001), 75--122.
  The abstract states the \(n>30\) theorem:
  <https://www.researchgate.net/profile/Paul_Voutier/publication/2397582_Existence_of_Primitive_Divisors_of_Lucas_and_Lehmer_Numbers/links/559999c308ae99aa62cc6983/Existence-of-Primitive-Divisors-of-Lucas-and-Lehmer-Numbers.pdf>.

* Y. Bugeaud and H. Kaneko, *On perfect powers in linear recurrence
  sequences of integers*, Kyushu J. Math. 73 (2019), 221--227.  Theorem
  1.1 and the reducible Fibonacci-square example are on pages 1--2:
  <https://www.jstage.jst.go.jp/article/kyushujm/73/2/73_221/_pdf/-char/en>.

* M. A. Bennett, M. Cipu, M. Mignotte, and R. Okazaki, *On the number of
  solutions of simultaneous Pell equations, II*, Acta Arith. 122 (2006),
  407--417, DOI 10.4064/aa122-4-4:
  <https://www.impan.pl/en/publishing-house/journals-and-series/acta-arithmetica/all/122/44/82060/on-the-number-of-solutions-of-simultaneous-pell-equations-ii>.

* M. A. Bennett and G. Walsh, *The Diophantine equation
  \(b^2X^4-dY^2=1\)*, Proc. Amer. Math. Soc. 127 (1999), 3481--3491:
  <https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf>.

* D. Byeon and S. Lee, *Class number 2 criteria for real quadratic fields*.
  Definition 2.1 and Proposition 2.2 record the Richaud--Degert shape and
  explicit fundamental units:
  <https://www.math.snu.ac.kr/~dhbyeon/04_class2.pdf>.

* P. Ribenboim, *On square factors of terms of binary recurring sequences
  and the ABC Conjecture*, Publ. Math. Debrecen 59 (2001), 459--469.  The
  abstract and the powerful-part statements explicitly assume abc:
  <https://publi.math.unideb.hu/paper/752/download/10_5486_PMD_2001_2559.pdf>.

* The sharp unconditional regulator/class-number calculation and its
  Louboutin and Granville--Soundararajan references are recorded in
  `FREY_PELL_FUNDAMENTAL_UNIT_SQUAREFREE_AUDIT.md`.
