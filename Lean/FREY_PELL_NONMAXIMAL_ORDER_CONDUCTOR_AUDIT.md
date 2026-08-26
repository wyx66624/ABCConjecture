# The quadratic conductor order attached to the Pell square part

## Abstract

Let

\[
 s_n^2-3r_n^2=1,
 \qquad c_n=s_n^2-2,
 \qquad c_n=A_ny_n^2,
\]

where \(A_n>0\) is squarefree.  The preceding fundamental-unit audit proves
that

\[
 \varepsilon_n=(c_n+1)+y_ns_n\sqrt {A_n}
\]

is the norm-one fundamental unit of
\(K_n=\mathbf Q(\sqrt {A_n})\).  This note audits the apparently stronger
idea of placing the same unit in the conductor order

\[
 \mathcal O_{n,f}=\mathbf Z+f\mathcal O_{K_n},
 \qquad f=y_n.
\]

This order is nonmaximal when \(y_n>1\); if \(y_n=1\), it is the maximal
order and all formulas below specialize with conductor one.

The outcome is exact and negative for this method.

1.  Since \(A_n\equiv23\pmod {24}\), one has
    \(\mathcal O_{K_n}=\mathbf Z[\sqrt {A_n}]\), and \(y_n\) is odd.
    Therefore

    \[
      \mathcal O_{n,y_n}=\mathbf Z[y_n\sqrt {A_n}]
    \]

    has conductor exactly \(y_n\).  There is no hidden 2-adic correction.

2.  The fundamental unit itself belongs to this order, as does its inverse.
    Consequently

    \[
      \mathcal O_{n,y_n}^{\times}=\mathcal O_{K_n}^{\times},
      \qquad
      [\mathcal O_{K_n}^{\times}:\mathcal O_{n,y_n}^{\times}]=1.
                                                        \tag{0.1}
    \]

    The same index is one for the totally positive unit groups.

3.  Put \(D_n=4A_n\), let \(h_n\) be the ordinary class number of
    \(K_n\), and write

    \[
      P_{D_n}(f)=\prod_{p\mid f}
        \left(1-\frac{\chi_{D_n}(p)}p\right).
    \]

    The exact real-quadratic ring class number formula becomes

    \[
      h(D_nf^2)=h_n fP_{D_n}(f).                  \tag{0.2}
    \]

    Thus the conductor and every local Euler factor are absorbed by the
    enlarged class number.  Substitution into the order class-number
    identity cancels them identically and recovers only

    \[
      h_n\log\varepsilon_n
       =\sqrt {A_n}\,L(1,\chi_{D_n}),             \tag{0.3}
    \]

    the already-audited maximal-order formula.

4.  The radical bookkeeping needs a correction which matters in this
    family.  In general \(A_n\) and \(y_n\) need not be coprime.  Exactly,

    \[
      \operatorname {rad}(c_n)
       =\frac{A_n\operatorname {rad}(y_n)}
              {\gcd(A_n,y_n)}.                   \tag{0.4}
    \]

    The overlap really occurs on the fixed Pell orbit:

    \[
       v_{23}(c_{1575})=3.                        \tag{0.5}
    \]

    Hence \(23\mid A_{1575}\) and \(23\mid y_{1575}\).

5.  If \(H=\log c_n\), then the exact radical deficit satisfies

    \[
      \log y_n
       \le H-\log\operatorname {rad}(c_n)
       \le2\log y_n.                              \tag{0.6}
    \]

    Therefore the coefficient-one one-factor target is equivalent to

    \[
       \log y_n=o(H),                              \tag{0.7}
    \]

    or equivalently \(\log A_n=(1-o(1))H\).  A lower bound merely saying
    that \(\operatorname {rad}(y_n)\) is almost \(y_n\) is not enough.

The ring class formula, ray class theory, genus theory, and their local
Euler factors do not imply (0.7).  They turn conductor size into class-group
size.  A genuinely new input must instead control the square-divisor height
\(\log y_n\), or the equivalent valuation sum
\(\sum_p\lfloor v_p(c_n)/2\rfloor\log p\).
No abc, Szpiro, GRH, or open class-number conjecture is used below.

## 1. The order and its exact conductor

The congruence audit gives

\[
 A_n\equiv23\pmod {24},
 \qquad (y_n,6)=1.                                \tag{1.1}
\]

In particular \(A_n\equiv3\pmod4\), so

\[
 \mathcal O_{K_n}=\mathbf Z[\sqrt {A_n}].         \tag{1.2}
\]

For every positive integer \(f\), the unique order of conductor \(f\) in
this field is

\[
 \mathcal O_f=\mathbf Z+f\mathcal O_{K_n}
             =\mathbf Z[f\sqrt {A_n}].            \tag{1.3}
\]

Its index in the maximal order and its conductor are both \(f\), and its
discriminant is \(D_nf^2\).  Taking \(f=y_n\) gives

\[
 \operatorname {disc}(\mathcal O_{y_n})
   =4A_ny_n^2=4c_n.                               \tag{1.4}
\]

Because \(y_n\) is odd, (1.3) is already the exact answer; none of the
usual basis changes for a radicand congruent to \(1\pmod4\) occurs.

## 2. The unit index is exactly one

Write \(A=A_n\), \(f=y_n\), \(s=s_n\), and \(c=c_n=Af^2\).  Then

\[
 \varepsilon_n=(Af^2+1)+fs\sqrt A,
 \qquad
 \varepsilon_n^{-1}=(Af^2+1)-fs\sqrt A.          \tag{2.1}
\]

Both elements lie in \(\mathbf Z[f\sqrt A]\).  The preceding
Bennett--Walsh argument proves that \(\varepsilon_n\) is not a proper power:
it generates the maximal-order unit group modulo sign.  Therefore every
maximal-order unit is already a unit of \(\mathcal O_f\), proving (0.1).

There is no negative-norm unit in \(K_n\).  Thus \(\varepsilon_n\) is also
the generator of the totally positive units, and both the wide and narrow
unit exponents in the real ring class formula equal one.

There is an even stronger congruence:

\[
 \varepsilon_n-1
  =Af^2+fs\sqrt A
  =f(Af+s\sqrt A)\in f\mathcal O_{K_n}.           \tag{2.2}
\]

Hence every totally positive unit is congruent to one modulo
\(f\mathcal O_{K_n}\).  Section 5 explains why this enlarges the ray class
group rather than bounding \(f\).

## 3. The exact ring class formula

Let \(D=4A\) be the fundamental discriminant, let \(h(D)\) be the wide
class number of \(K=\mathbf Q(\sqrt A)\), and let \(h(Df^2)\) denote the
wide proper ideal class number of \(\mathcal O_f\).  For a real quadratic
order the exact formula is

\[
 h(Df^2)
  =\frac{h(D)f}{[\mathcal O_K^\times:\mathcal O_f^\times]}
    \prod_{p\mid f}\left(1-\frac{\chi_D(p)}p\right).       \tag{3.1}
\]

The narrow formula has the same shape, with the corresponding totally
positive unit exponent.  In the present family both exponents are one, so

\[
 \begin{aligned}
 h(Df^2)&=h(D)fP_D(f),\\
 h^+(Df^2)&=h^+(D)fP_D(f)=2h(Df^2).
 \end{aligned}                                    \tag{3.2}
\]

The second equality uses the already-proved absence of norm \(-1\) units.

Prime by prime, if \(p^a\Vert f\), the relative multiplier is

\[
 p^{a-1}(p-\chi_D(p))=
 \begin{cases}
  p^{a-1}(p-1),&\chi_D(p)=1,\\
  p^a,&\chi_D(p)=0,\\
  p^{a-1}(p+1),&\chi_D(p)=-1.
 \end{cases}                                      \tag{3.3}
\]

Thus

\[
 \frac{h(Df^2)}{h(D)}
  =\prod_{p^a\Vert f}p^{a-1}(p-\chi_D(p)).        \tag{3.4}
\]

Formula (3.4) does contain the primes of \(\operatorname {rad}(f)\), but it
also contains every extra power \(p^{a-1}\).  It is a formula for a new
class number, not an upper bound for that class number.  In logarithmic
form,

\[
 \log\frac{h(Df^2)}{h(D)}
  =\log f+\sum_{p\mid f}
       \log\left(1-\frac{\chi_D(p)}p\right).       \tag{3.5}
\]

The second term is only a small Euler correction to \(\log f\); it does not
replace \(\log f\) by \(\log\operatorname {rad}(f)\).  The elementary
bounds

\[
 \varphi(f)\le fP_D(f)
 \le f\prod_{p\mid f}\left(1+\frac1p\right)       \tag{3.6}
\]

make this explicit.

## 4. Exact cancellation in the analytic formula

Put

\[
 R=\log\varepsilon_n,
 \qquad L_D=L(1,\chi_D).
\]

The maximal-order class-number formula is

\[
 h(D)R=\frac{\sqrt D}{2}L_D=\sqrt A\,L_D.         \tag{4.1}
\]

The imprimitive Kronecker character of discriminant \(Df^2\) satisfies

\[
 L(1,\chi_{Df^2})=L_D P_D(f).                     \tag{4.2}
\]

Since the order regulator is still \(R\), its formula reads

\[
 \begin{aligned}
 h(Df^2)R
  &=\frac{\sqrt{Df^2}}2L(1,\chi_{Df^2})\\
  &=f\sqrt A\,L_D P_D(f).                        \tag{4.3}
 \end{aligned}
\]

Substituting (3.2) into the left side of (4.3) cancels the common nonzero
factor \(fP_D(f)\) and gives exactly (4.1).  Conversely, multiplying (4.1)
by that factor gives (4.3).  Hence the order formula and the field formula
are algebraically equivalent once the exact ring class number is used.

This also identifies a tempting but invalid move.  Dropping
\(h(Df^2)\ge1\) in (4.3) gives only

\[
 R\le f\sqrt A\,L_D P_D(f)=\sqrt c\,L_D P_D(f),  \tag{4.4}
\]

which is exponentially weaker here than the maximal-order estimate.  Using
the exact value of \(h(Df^2)\) returns to (4.1).  No choice of retaining or
discarding the same local Euler factors produces an independent radical
term.

## 5. Exact sequences, ray classes, and genus theory

For an order \(\mathcal O_f=\mathbf Z+f\mathcal O_K\), the standard exact
sequence is

\[
 1\longrightarrow
 \mathcal O_K^\times/\mathcal O_f^\times
 \longrightarrow
 \frac{(\mathcal O_K/f\mathcal O_K)^\times}
      {(\mathbf Z/f\mathbf Z)^\times}
 \longrightarrow
 \operatorname {Pic}(\mathcal O_f)
 \longrightarrow
 \operatorname {Pic}(\mathcal O_K)
 \longrightarrow1.                               \tag{5.1}
\]

In this family the first group is trivial.  Therefore the whole relative
residue quotient injects into the order class group, and its cardinality is

\[
 \frac{\#(\mathcal O_K/f\mathcal O_K)^\times}{\varphi(f)}
 =fP_D(f).                                        \tag{5.2}
\]

This is the group-theoretic reason for (3.2): the conductor creates new
classes of precisely the size one hoped to use as a restriction.

The ray class route is even less restrictive.  By (2.2), the totally
positive unit group maps trivially modulo \(f\).  The finite residue group
has order

\[
 \Phi_K(f):=\#(\mathcal O_K/f\mathcal O_K)^\times
  =f^2\prod_{p\mid f}
       \left(1-\frac1p\right)
       \left(1-\frac{\chi_D(p)}p\right).          \tag{5.3}
\]

Take the ray modulus whose finite part is \(f\mathcal O_K\) and whose
infinite part contains both real places; equivalently, use the narrow ray
convention.  Relative to the narrow class group, the positive-unit image is
trivial by (2.2).  The narrow ray exact sequence therefore gives the ray
class number \(h^+(D)\Phi_K(f)\), with no further unit quotient.  Again the
residue mass is stored in the ray class group; it does not force new prime
support in \(f\).

Classical genus theory extracts quadratic characters from the distinct
prime divisors of the discriminant

\[
 Df^2=4c.                                         \tag{5.4}
\]

Accordingly, its information is an elementary 2-quotient with rank bounded
by \(\omega(Df)+O(1)\).  It can record that a prime occurs, but not the
weight \(\log p\), and it does not remove the local factors
\(p^{a-1}\) in (3.3).  Higher ray or ring class characters see those local
groups, but their orders are then part of the enlarged class number.  Thus
passing from genus theory to full ray class theory changes how completely
the conductor is recorded, not the direction of the resulting inequality.

## 6. Correct radical bookkeeping and an actual overlap

For a general squarefree-kernel decomposition \(c=Af^2\), it is false that
\(A\) and \(f\) must be coprime.  If \(v_p(c)=2a+1\ge3\), then
\(p\mid A\) and \(p^a\mid f\).  Since \(A\) is squarefree,

\[
 \begin{aligned}
 \operatorname {rad}(c)
  &=\operatorname {rad}(Af)
    =\operatorname {lcm}(A,\operatorname {rad}(f))\\
  &=\frac{A\operatorname {rad}(f)}{\gcd(A,f)}.
 \end{aligned}                                    \tag{6.1}
\]

The overlap is not merely a formal possibility.  Starting from
\((s_0,r_0)=(1,0)\) and iterating

\[
 \binom{s_{n+1}}{r_{n+1}}
  =\begin{pmatrix}7&12\\4&7\end{pmatrix}
    \binom{s_n}{r_n},                              \tag{6.2}
\]

exact modular computation gives

\[
 c_{1575}\equiv85169=7\cdot23^3\pmod {23^4}.     \tag{6.3}
\]

Thus \(v_{23}(c_{1575})=3\).  In its canonical decomposition
\(c_{1575}=A_{1575}y_{1575}^2\), both \(A_{1575}\) and \(y_{1575}\)
are divisible by \(23\).  The Lean companion verifies (6.3) directly from
the repository recurrence.

## 7. The exact remaining input

Let

\[
 a=\log A,
 \quad u=\log f,
 \quad \rho=\log\operatorname {rad}(f),
 \quad g=\log\gcd(A,f).
\]

Then

\[
 H:=\log c=a+2u,
 \qquad
 R_c:=\log\operatorname {rad}(c)=a+\rho-g.        \tag{7.1}
\]

Because \(0\le g\le\rho\le u\),

\[
 H-R_c=2u-\rho+g,
 \qquad
 u\le H-R_c\le2u.                                \tag{7.2}
\]

Consequently

\[
 R_c=(1-o(1))H
 \quad\Longleftrightarrow\quad
 u=o(H).                                          \tag{7.3}
\]

Equivalently, one needs

\[
 \sum_p\left\lfloor\frac{v_p(c_n)}2\right\rfloor
       \log p=o(H_n),                              \tag{7.4}
\]

or \(A_n=c_n^{1-o(1)}\).  Even the strong-looking estimate
\(\operatorname {rad}(f)=f^{1-o(1)}\) would leave a half-height loss when
the square part dominates, because \(f\) occurs twice in \(c=Af^2\) and
only once in its radical.

The minimum genuinely new input for this route is therefore a pointwise
square-divisor-height theorem such as (7.4), preferably exploiting the
simultaneous equations

\[
 c_n=3r_n^2-1=s_n^2-2,                            \tag{7.5}
\]

not another generic formula for quadratic orders.  Existing ring class,
ray class, genus, and analytic class-number theorems do not provide it.

## 8. A strict scalar no-go model

The cancellation can be isolated without any asymptotics.  Let \(q\ne0\)
be the relative class multiplier, assume

\[
 h_f=hq.                                          \tag{8.1}
\]

Then

\[
 h_fR=qB\quad\Longleftrightarrow\quad hR=B.       \tag{8.2}
\]

For a ramified conductor prime \(p\), (3.3) permits
\(q=p^a\) while \(\operatorname {rad}(p^a)=p\) is fixed.  Taking
\(p=23\) respects the local congruence class of this Pell family.  This is a
scalar countermodel to every attempted deduction from (3.1) and (4.3)
alone: their conductor growth can be arbitrarily large at fixed radical
support because the class-number variable grows by the same factor.  It is
not asserted that the local profile is realized for arbitrarily large
\(a\) on the Pell orbit; (6.3) supplies an actual depth-three occurrence.

## 9. Formal companion

`IUTThreeClosures/FreyPellNonmaximalOrderConductorAudit.lean` verifies:

1. the order-discriminant scalar identity \(4Af^2=4c\);
2. the exact congruence \(\varepsilon-1\in f\mathcal O_K\) at the level of
   its two integral coordinates;
3. the algebraic equivalence (8.2), which is the ring-class cancellation;
4. the deficit bounds (7.2) and their coefficient consequences;
5. a fixed-radical prime-power scalar counterprofile; and
6. the exact certificate \(v_{23}(c_{1575})=3\).

It does not formalize quadratic orders, the Bennett--Walsh theorem, the
ring or ray class exact sequences, genus theory, or analytic class-number
formulas.

## References

* M. A. Bennett and G. Walsh, *The Diophantine equation
  \(b^2X^4-dY^2=1\)*, Proceedings of the American Mathematical Society 127
  (1999), 3481--3491, Theorem 1.2 and Corollary 1.3:
  <https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf>.

* R. Qureshi and T. Nakahara, *Behavior of the ring class numbers of a real
  quadratic field*, Ars Combinatoria 113 (2014), 257--271.  Theorem 4.1
  states both the wide and narrow real-quadratic formulas with the exact
  unit exponents:
  <https://www.researchgate.net/publication/290041441_Behavior_of_the_ring_class_numbers_of_a_real_quadratic_field>.

* K. Conrad, *The conductor ideal of an order*, Theorem 5.3 and exact
  sequence (5.7), for the unit quotient, residue quotient, and Picard groups:
  <https://kconrad.math.uconn.edu/blurbs/gradnumthy/conductor.pdf>.

* J. S. Milne, *Class Field Theory*, version 4.03, Chapter V, Section 1,
  especially Theorem 1.7 and Example 1.8, for ray class exact sequences,
  ray class numbers, and narrow classes:
  <https://www.jmilne.org/math/CourseNotes/CFT.pdf>.

* D. A. Cox, *Primes of the Form \(x^2+ny^2\)*, second edition, Wiley,
  Chapters 3 and 7, for quadratic orders, proper form classes, genus
  characters, and the ring class exact sequence.
