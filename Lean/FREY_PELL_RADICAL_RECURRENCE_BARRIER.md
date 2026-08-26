# The Pell radical recurrence behind the adelic compensation barrier

## Abstract

The adelic packet audit isolates an infinite Frey family for which the entire
missing term is archimedean.  This note identifies the exact integer recurrence
hidden in that family.

Let

\[
 q_n+p_n\sqrt 3=(2+\sqrt 3)^n,
 \qquad
 r_n=2p_nq_n,
 \qquad
 s_n=q_n^2+3p_n^2.
\]

Then

\[
 s_n^2-3r_n^2=1,
 \qquad
 b_n=3r_n^2-2=s_n^2-3,
 \qquad
 c_n=b_n+1=s_n^2-2.                              \tag{1.1}
\]

Both \(b_n\) and \(c_n\) satisfy the same simple nondegenerate order-three
recurrence

\[
 u_{n+3}=195u_{n+2}-195u_{n+1}+u_n,               \tag{1.2}
\]

whose characteristic polynomial is

\[
 (X-1)(X^2-194X+1).                                \tag{1.3}
\]

Consequently the critical archimedean estimate on this family is exactly a
joint radical theorem for two consecutive values of two explicit linear
recurrences.  Existing general theorems on primitive divisors, greatest prime
factors, perfect powers, and square-free parts do not have the required
coefficient: the best general square-free-part input guarantees only

\[
 \log\operatorname{rad}(u_n)
   \gg {\log n\,\log_2 n\over\log_3 n}=o(n),       \tag{1.4}
\]

whereas the required joint estimate has a positive linear coefficient in
\(n\).  Here \(\log_2 n=\log\log n\) and
\(\log_3 n=\log\log\log n\).  Thus the recurrence reformulation is exact
and useful, but it is not an abc proof.

## 1. The integral Pell orbit

Put

\[
 \alpha=2+\sqrt3.
\]

Writing \(\alpha^n=q_n+p_n\sqrt3\) gives

\[
 q_0=1,\quad p_0=0,
\]

and

\[
 q_{n+1}=2q_n+3p_n,
 \qquad
 p_{n+1}=q_n+2p_n.                                 \tag{1.5}
\]

Taking norms in \(\mathbf Q(\sqrt3)\), or simply expanding (1.5), gives

\[
 q_n^2-3p_n^2=1.                                   \tag{1.6}
\]

The double-angle coordinates are

\[
 r_n=2p_nq_n,
 \qquad
 s_n=q_n^2+3p_n^2.
\]

The identity

\[
 s_n^2-3r_n^2=(q_n^2-3p_n^2)^2=1                  \tag{1.7}
\]

is precisely the parametrization used in the fixed-field adelic example.
Moreover,

\[
 \binom{s_{n+1}}{r_{n+1}}
 =
 \begin{pmatrix}7&12\\4&7\end{pmatrix}
 \binom{s_n}{r_n}.                                 \tag{1.8}
\]

The matrix in (1.8) has trace \(14\) and determinant \(1\).  Hence

\[
 s_{n+2}=14s_{n+1}-s_n.                            \tag{1.9}
\]

## 2. The two consecutive recurrence values

Define

\[
 b_n=s_n^2-3,
 \qquad
 c_n=s_n^2-2.
\]

Equation (1.7) gives the alternative forms

\[
 b_n=3r_n^2-2,
 \qquad
 c_n=3r_n^2-1,                                     \tag{2.1}
\]

and of course

\[
 c_n=b_n+1.                                        \tag{2.2}
\]

The first terms are

\[
 (b_1,c_1)=(46,47),
 \quad
 (b_2,c_2)=(9406,9407),
 \quad
 (b_3,c_3)=(1825198,1825199).                      \tag{2.3}
\]

The symmetric square of the matrix in (1.8) has eigenvalues

\[
 (7+4\sqrt3)^2,\quad 1,\quad(7-4\sqrt3)^2.
\]

Since

\[
 (7+4\sqrt3)^2+(7-4\sqrt3)^2=194,
\]

its characteristic polynomial is (1.3).  Both the square sequence \(s_n^2\)
and every constant sequence satisfy the corresponding recurrence.  Their
difference therefore gives (1.2) for both \(b_n\) and \(c_n\).

The Lean companion proves (1.5)--(1.9), (2.1)--(2.2), the first two pairs in
(2.3), the order-three recurrence, and the characteristic-polynomial
factorization directly over \(\mathbf Z\).

## 3. Exact exponential scale

All logarithmic and asymptotic statements from this point onward concern
\(n\ge1\).  The integral recurrence itself also has a harmless index-zero
term, but \(b_0=-2\) is outside the positive abc family.

Since

\[
 s_n={\alpha^{2n}+\alpha^{-2n}\over2},
\]

we have

\[
 \begin{aligned}
 b_n&={\alpha^{4n}+\alpha^{-4n}-10\over4},\\
 c_n&={\alpha^{4n}+\alpha^{-4n}-6\over4}.
 \end{aligned}                                     \tag{3.1}
\]

Put

\[
 \lambda=\alpha^4=97+56\sqrt3.
\]

Then

\[
 \log b_n=n\log\lambda+O(1),
 \qquad
 \log c_n=n\log\lambda+O(1).                      \tag{3.2}
\]

Thus the height in the Pell abc triple \((1,b_n,c_n)\) has coefficient
\(\log\lambda=4\log(2+\sqrt3)\).

Because \(b_n\) and \(c_n\) are consecutive,

\[
 \gcd(b_n,c_n)=1.                                  \tag{3.3}
\]

The fixed factor \(6\) changes logarithmic radicals only by \(O(1)\), so

\[
 \log\operatorname{rad}(6b_nc_n)
 =\log\operatorname{rad}(b_n)
  +\log\operatorname{rad}(c_n)+O(1).               \tag{3.4}
\]

## 4. The exact missing recurrence theorem

Write

\[
 H_n=\log b_n,
 \qquad
 R_n=\log\operatorname{rad}(6b_nc_n).
\]

The abc estimate on this subfamily is

\[
 H_n\le(1+\varepsilon)R_n+C_\varepsilon.           \tag{4.1}
\]

Equivalently, for every \(0<\eta<1\),

\[
 \boxed{
 \log\operatorname{rad}(b_n)
 +\log\operatorname{rad}(c_n)
 \ge(1-\eta)n\log\lambda-O_\eta(1).}              \tag{4.2}
\]

Indeed, take \(\eta=\varepsilon/(1+\varepsilon)\) in one direction and
\(\varepsilon=\eta/(1-\eta)\) in the other, and use (3.2)--(3.4).  Bounds
with \(\eta\ge1\) are weaker and carry no additional content.

It is important that (4.2) asks for one source-height unit of radical, not
for the entire two-height product \(b_nc_n\) to be square-free.  For example,
the two stronger separate estimates

\[
 \log\operatorname{rad}(b_n)\ge
       \left({1\over2}-o(1)\right)\log b_n,
 \qquad
 \log\operatorname{rad}(c_n)\ge
       \left({1\over2}-o(1)\right)\log c_n          \tag{4.3}
\]

would suffice, but (4.2) allows the mass to be distributed asymmetrically.

Combining (4.1) with the adelic identity

\[
 \Lambda_\infty(Q)=-{1\over12}H_n+O(1)
\]

recovers exactly the critical archimedean lower bound.  No new coefficient is
created by passing to the recurrence language.

## 5. A toric factorization

Formula (3.1) also exposes the relevant local approximation problem.  With
\(x=\lambda^n\),

\[
 \begin{aligned}
 4xb_n
   &=x^2-10x+1\\
   &=(x-(5+2\sqrt6))(x-(5-2\sqrt6)),               \tag{5.1}\\
 4xc_n
   &=x^2-6x+1\\
   &=(x-(3+2\sqrt2))(x-(3-2\sqrt2)).               \tag{5.2}
 \end{aligned}
\]

The moving unit \(\lambda\in\mathbf Q(\sqrt3)\) is multiplicatively
independent from the two target units in \(\mathbf Q(\sqrt6)\) and
\(\mathbf Q(\sqrt2)\).  Thus repeated prime powers in \(b_n c_n\) measure
high \(p\)-adic proximity of a fixed multiplicative orbit to four fixed
algebraic targets.

This is not an ordinary divisibility sequence.  In particular, a primitive
divisor theorem for the underlying Pell sequence does not automatically give
a primitive divisor for either shifted sequence in (5.1)--(5.2), much less the
linear total mass required by (4.2).

## 6. Quantitative audit of existing recurrence theorems

For a simple nondegenerate integer linear recurrence with a dominant root,
Stewart's square-free-factor theorem gives effective constants \(C_1,C_2>0\)
such that

\[
 \operatorname{rad}(u_n)>
 n^{C_1\log_2 n/\log_3 n}
 \qquad(n\ge C_2).                                  \tag{6.1}
\]

The hypotheses apply to both recurrences here: their roots are
\(\lambda,1,\lambda^{-1}\), they are distinct, no quotient is a root of
unity, and \(\lambda\) is dominant.  Applying (6.1) separately gives only

\[
 \log\operatorname{rad}(b_n)
 +\log\operatorname{rad}(c_n)
 \gg {\log n\,\log_2 n\over\log_3 n}=o(n).         \tag{6.2}
\]

This is a valid unconditional lower bound but does not imply (4.2), whose
right side is \(\Theta(n)\).

Likewise:

1. the existence of one primitive prime gives support, not weighted mass;
2. a lower bound for the greatest prime factor is still subexponential in
   the source index in the available general theorems;
3. finiteness of exact perfect-power terms does not control near-powerful
   terms; and
4. an average or density-one square-free estimate would not by itself give
   the all-\(n\) quantifier in (4.2).

The logical gap in item 1 is strict.  A sequence of integers can have a new
prime in every term while that prime contributes only \(o(1)\) of the term's
logarithmic height.  The radical coefficient cannot be recovered from the
word "primitive."

## 7. What would genuinely advance the route

Any one of the following would be a genuine new input:

1. the joint estimate (4.2) itself;
2. the two separate half-height estimates (4.3);
3. a weighted uniform-integrability theorem for the Hensel depths in
   (5.1)--(5.2), strong enough to leave at most one source-height unit of
   powerful mass; or
4. an adelic cancellation theorem that avoids needing (4.2) by cancelling
   the archimedean deficit with another globally compatible branch or motive.

Primitive-divisor existence, perfect-power finiteness, and the current
general square-free-part lower bound are not substitutes for these inputs.

The present note therefore sharpens the boundary but does not close abc.

## 8. Formalization boundary

The Lean module
`IUTThreeClosures/FreyPellRadicalRecurrenceBarrier.lean` proves:

* the integral Pell orbit and its norm-one identity;
* the double-angle coordinates and their trace-14 matrix recurrence;
* the identities \(b_n=3r_n^2-2\), \(c_n=3r_n^2-1\), and \(c_n=b_n+1\);
* the common order-three recurrence and characteristic polynomial; and
* the first two nontrivial pairs.

Lean does not formalize Stewart's theorem, the asymptotic formulas, the toric
factorization over the biquadratic field, or the missing radical estimate.
Those remain paper mathematics and are not inserted as assumptions.

## References

* C. L. Stewart, *On the greatest square-free factor of terms of a linear
  recurrence sequence*, in **Diophantine Equations**, Tata Institute Studies
  in Mathematics 20 (2008), 257--264.  The exact bound used above is restated
  as Lemma 2.1 in
  [Berczes--Hajdu--Ostafe--Shparlinski](https://doi.org/10.4153/S0008439525000475).
* Y. Bilu, G. Hanrot and P. M. Voutier, *Existence of primitive divisors of
  Lucas and Lehmer numbers*, J. Reine Angew. Math. 539 (2001), 75--122;
  see also [Voutier's source exposition](https://arxiv.org/abs/1201.6659).
* C. L. Stewart, *On divisors of Lucas and Lehmer numbers*, available at
  [arXiv:1008.1274](https://arxiv.org/abs/1008.1274).
* M. Yabuta, *The ABC-conjecture and the powerful numbers in Lucas
  sequences*, Fibonacci Quarterly 45 (2007), 362--365,
  [journal PDF](https://www.fq.math.ca/Papers1/45-4/quartYabuta04_2007.pdf).
