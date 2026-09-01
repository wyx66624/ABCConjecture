# Fixed-norm generators and uniform bounds for the Pell residual

Author: ChatGPT. Date: 30 August 2026.

This continuation proves stronger necessary conditions for the repository's
specified Pell residual. It also gives an exact integral normalization and
factorization for the genuine Frey family. None of these statements proves
or disproves abc, and the Pell packet is not asserted to contain every
possible abc counterexample. Mathematical proofs were written and sent for
independent review before the new Lean module was started.

## 1. Exact scope and the external input

The main packet consists of positive integers satisfying

\[
 b=Au^2,\quad b+1=Bv^2,\quad b+2=3r^2,\quad b+3=s^2,
 \qquad A\equiv22,\quad B\equiv23\pmod {24},                 \tag{1}
\]

where \(A,B\) are squarefree. Write

\[
 D=3AB,\qquad H=\log(b+2),\qquad L=\log(2D).
\]

In particular, \(b\ge A\ge22\), \(H>2\), \(A,B>1\),
\(3\nmid AB\), and \(\gcd(A,B)=1\). Thus \(D\) is squarefree.
The extra Chebyshev data used only in Section 4 supply

\[
 p\log(D+1)<4H.                                           \tag{2}
\]

Let \(h\) denote the absolute logarithmic Weil height. For a positive
squarefree \(a>1\), write \(R_a\) for the regulator of
\(\mathbb Q(\sqrt a)\), using a generator of its full unit group modulo
torsion, not a unit of a nonmaximal order.

The following are the external inputs used below, with all variable
parameters specified.

* Pasten, Theorem 2.4, supplies an effective constant \(C_{\rm LF}>0\)
  such that for any totally real degree-four field \(F\), any subgroup
  \(\Gamma\subset F^\times\) generated modulo torsion by three elements
  \(g_1,g_2,g_3\), any real embedding, and any \(g\in\Gamma\setminus\{1\}\),

  \[
  -\log|1-g|\le C_{\rm LF}\log\max(2,h(g))
       \prod_{i=1}^3\max(1,h(g_i)).                         \tag{3}
  \]

  One may take \(C_{\rm LF}=2c(4)^3/\log2\) in that theorem's notation.
  Its constant is independent of the field discriminant, generators, and
  element. Its only relevant place factor is \(\mathrm{Nm}(v)=2\).
* Pasten, Lemma 2.5, applied to a real quadratic field \(K\), its two real
  places \(S\), and \(\omega\in\mathcal O_K\) of absolute norm
  \(q>1\), gives independent \(\xi_1,\xi_2\) and an index
  \(1\le N\le2\) with

  \[
  \omega^N=\zeta\xi_1^{e_1}\xi_2^{e_2},\quad \zeta\in\{\pm1\},
  \qquad h(\xi_1)h(\xi_2)\le\frac38R_K\log q.              \tag{4}
  \]

  Here \(S\) contains every place above the rational infinite place and
  no place above any finite prime, so the lemma's all-or-none condition
  holds. Its \(q'\) is exactly \(q\).

[Pasten's original preprint, Theorem 2.4 and Lemma 2.5, pp. 5–6](https://arxiv.org/pdf/2608.23559v1).
These general lemmas do not assume that an associated cubic is irreducible.
We do not apply his cubic Thue–Mahler Theorem 1.8 to a split cubic.

The mechanism behind (4) is to choose short generators jointly in
\(\mathcal O_K^\times\langle\omega\rangle\). Treating its unit and
nonunit parts separately would generally pay for the regulator twice.
The exterior-product theorem used for this step has been checked in the
[original Akhtari–Vaaler paper, Theorem 1.2](https://arxiv.org/pdf/2009.10857).
The approximation input (3) comes from the published Evertse–Győry
theorem; a reproduced statement appears as Proposition 5 in
[Győry's 2019 paper](https://arxiv.org/pdf/1901.11289).
That reproduced proposition has a missing minus sign, explicitly corrected
in the author's 2020 corrigendum; its proof uses the correct sign.
[Author's publication list recording the corrigendum, p. 525](https://math.unideb.hu/en/research-kalman-gyory).

We also use Landau's effective fixed-degree estimate. In degree two it
gives an absolute effective \(C_Q\ge1\) with

\[
 R_a\le C_Q\sqrt a\log(2a)\qquad(a>1\text{ squarefree}).    \tag{5}
\]

Indeed the field discriminant is at most \(4a\), the class number is at
least one, and \(h_KR_K\ll\sqrt{|\Delta_K|}\log|\Delta_K|\).
All constants introduced later depend only on \(C_{\rm LF},C_Q\) and
fixed real numbers. In particular none depends on \(A,B,b,p\).

## 2. A fixed-norm construction at the A endpoint

We first record a height fact so that replacing heights by their maxima
with one in (3) has no hidden parameter cost.

**Lemma 1.** Put \(\varphi=(1+\sqrt5)/2\) and
\(\rho=(\log\varphi)/2>0\). Every nonzero algebraic number of degree at
most two which is not a root of unity has height at least \(\rho\).

**Proof.** A rational number other than \(\pm1\) has height at least
\(\log2\). For a quadratic number use its primitive irreducible integer
polynomial and the formula \(2h=\log M\), where \(M\) is its Mahler
measure. If the absolute leading or constant coefficient is at least two,
then \(M\ge2\). Otherwise the number is a quadratic algebraic unit with
norm \(\pm1\). For norm minus one its nonzero integer trace implies that
the larger absolute root is at least \(\varphi\). For norm plus one,
integer traces of absolute value at most two give roots of unity or a
reducible polynomial; every other trace gives a larger root at least
\((3+\sqrt5)/2\). This proves the claimed lower bound in all cases. ∎

**Proposition 2.** Every packet (1) satisfies

\[
 H\le \log3+C_A R_A\log(3H),\qquad
 C_A=\frac{3C_{\rm LF}\log3}{8\rho^2}.                    \tag{6}
\]

**Proof.** Work in \(K=\mathbb Q(\sqrt A)\) and set

\[
 \omega=s+u\sqrt A=s+\sqrt b,
 \qquad \eta=s+r\sqrt3=s+\sqrt{b+2}.                       \tag{7}
\]

These are algebraic integers. Their norms in their respective quadratic
fields are \(3\) and \(1\), since \(s^2=b+3\). The positive unit
\(\eta\) is a power of \(\varepsilon_3=2+\sqrt3\). Apply (4) with
\(q=3\), giving \(\xi_1,\xi_2,N\) as there.

The compositum \(F=\mathbb Q(\sqrt A,\sqrt3)\) has degree four:
\(A\) is squarefree, \(A>1\), and \(A\ne3\). Define

\[
 \gamma=\frac{\omega}{\eta}
 =\frac{\sqrt{b+3}+\sqrt b}
        {\sqrt{b+3}+\sqrt{b+2}}.                          \tag{8}
\]

In the chosen positive real embedding, \(0<\gamma<1\). In particular
neither \(\gamma\) nor \(\gamma^N\) is one. Rationalizing gives

\[
 1-\gamma=
 \frac{2}{(\sqrt{b+2}+\sqrt b)
               (\sqrt{b+3}+\sqrt{b+2})}
 <\frac1{2b}.                                             \tag{9}
\]

Both factors in the denominator exceed \(2\sqrt b\). Since
\(1\le N\le2\), the geometric-sum identity gives

\[
 0<1-\gamma^N\le N(1-\gamma)<\frac1b.                     \tag{10}
\]

Let \(\Gamma=\langle-1,\xi_1,\xi_2,\varepsilon_3\rangle\)
inside \(F^\times\). Its torsion subgroup is \(\{\pm1\}\), and the
three displayed nontorsion generators are independent modulo torsion.
For if a power of \(\varepsilon_3\) belongs to \(K\), it lies in
\(K\cap\mathbb Q(\sqrt3)=\mathbb Q\). Conjugation in
\(\mathbb Q(\sqrt3)\) would then give
\(\varepsilon_3^k=\varepsilon_3^{-k}\), forcing \(k=0\).
The independence of \(\xi_1,\xi_2\) then finishes the assertion.
By (4) and (7), \(\gamma^N\in\Gamma\).

By Lemma 1, \(\max(1,h(\xi_i))\le h(\xi_i)/\rho\).
Also \(h(\varepsilon_3)=\tfrac12\log(2+\sqrt3)<1\).
Thus (4) proves the uniform generator bound

\[
 \prod_{g_i=\xi_1,\xi_2,\varepsilon_3}\max(1,h(g_i))
 \le\frac{3\log3}{8\rho^2}R_A.                            \tag{11}
\]

The height of the approximating element must be evaluated globally, not
only at the selected embedding. Both conjugates of each integer in (7)
are positive. Because \(b\ge22\), \(\omega>3\) and \(\eta>1\),
their smaller conjugates are \(3/\omega<1\) and \(1/\eta<1\).
Consequently

\[
 h(\omega)=\tfrac12\log\omega,
 \qquad h(\eta)=\tfrac12\log\eta.
\]

Both \(\omega\) and \(\eta\) are less than \(2\sqrt{b+3}\).
Height invariance under field extension and the standard product and
power inequalities therefore give

\[
 h(\gamma^N)\le2(h(\omega)+h(\eta))
 <\log(4(b+3))<H+2\le3H.                                 \tag{12}
\]

As \(H>2\), this also bounds \(\max(2,h(\gamma^N))\) by \(3H\).
Apply (3) to \(g=\gamma^N\), then use (10)–(12):

\[
 \log b<C_A R_A\log(3H).
\]

Finally \(b+2\le3b\) implies \(H\le\log b+\log3\), proving (6). ∎

This is a direct use of the joint small-generator mechanism in the new
paper. It does not require a nonconstant map from the \(j=1728\) curve
to a Mordell curve, and does not replace point height by curve height.

The construction also gives an independent bound with \(R_{3A}\) in
place of \(R_A\). The norm-one unit
\(U_A=b+1+ur\sqrt{3A}\) and \(U_3=(s+r\sqrt3)^2\) satisfy
\(1<U_3/(2U_A)<1+2/b\). Apply (3) to the group generated by the two
quadratic fundamental units and \(2\); the latter has height
\(\log2<1\) and its cost is retained in the maximum. This auxiliary
variant is not needed for (6) or the combined bound below.

## 3. Absorbing the logarithm, and distinguishing the existing B theorem

**Lemma 3 (explicit logarithmic absorption).** If \(X,M>0\) and
\(X\le M\log(3X)\), then

\[
 X\le2M\log(3M).                                         \tag{13}
\]

**Proof.** Put \(t=X/M>0\). For every \(t>0\),
\(\log t\le t/2\): the function \(\log t-t/2\) has its maximum at
\(t=2\), and that maximum is \(\log2-1<0\). Hence

\[
 t\le\log(3M)+\log t\le\log(3M)+t/2.
\]

Rearranging and multiplying by \(M>0\) proves (13). ∎

Choose an absolute effective \(C_1\ge1\) so that (6) implies
\(H\le C_1\max(1,R_A)\log(3H)\). This is possible because
\(H>2\) and \(\log(3H)>1\). Put
\(M=C_1\max(1,R_A)\ge1\). Equations (5) and (13) show that an
absolute effective \(C_2\ge1\) satisfies

\[
 \boxed{H\le C_2\sqrt A\,[\log(2A)]^2.}                  \tag{14}
\]

To check the logarithmic power explicitly, (5) gives
\(M\le C_3\sqrt A\log(2A)\), with absolute \(C_3\ge1\).
Furthermore

\[
 \log(3M)\le\log(3C_3)+\tfrac12\log A+\log\log(2A)
 \le C_4\log(2A)
\]

for an absolute effective \(C_4\), since \(A\ge2\).
Thus (13) has exactly two powers of \(\log(2A)\), not three.

Replacing \(\omega\) by \(s+v\sqrt B\), whose norm is two, repeats
the argument with \(q=2\). Its positive ratio to \(\eta\) is strictly
less than one, and rationalization yields
\(1-\gamma_B<1/(4b)\). It follows that

\[
 H\le C_5\sqrt B\,[\log(2B)]^2.                          \tag{15}
\]

This is **not** a new improvement at the B endpoint. The repository
already proves, mathematically using Bennett–Walsh, that

\[
 \varepsilon_B=(b+2)+vs\sqrt B
 \quad\hbox{is the fundamental unit},\qquad
 H<R_B\le C_Q\sqrt B\log(2B).                            \tag{16}
\]

For completeness, its relevant hypotheses are \(B>1\) squarefree and
\(B\equiv3\pmod4\), so the maximal order is \(\mathbb Z[\sqrt B]\)
and a unit of norm minus one is impossible modulo four. The integral
identity

\[
 (b+2)^2-B(vs)^2=1,\qquad b+2=3r^2
\]

puts it under Bennett–Walsh with their squarefree parameters \(3,B>1\).
Their divisibility-index assertion forces the unit index to be
\(\alpha(3)\). The Chebyshev recurrence modulo three shows that an
iterate divisible by three can exist only if the fundamental trace is
already divisible by three, so \(\alpha(3)=1\).
[Original Bennett–Walsh paper, Theorem 1.2](https://personal.math.ubc.ca/~bennett/BW-PAMS.pdf).
This is the result recorded in
`Lean/FREY_PELL_FUNDAMENTAL_UNIT_SQUAREFREE_AUDIT.md`; it is not being
introduced anew or promoted to a fully formalized theorem here.

## 4. Joint restriction and its precise effect on the prime index

**Theorem 4.** There is an absolute effective \(K\ge1\) such that
every packet (1) satisfies

\[
 \boxed{H^4\le K D[\log(2D)]^6.}                          \tag{17}
\]

**Proof.** Square (14) and (16), then multiply the resulting inequalities:

\[
 \begin{aligned}
 H^4
 &\le C_2^2C_Q^2 AB[\log(2A)]^4[\log(2B)]^2\\
 &\le \frac{C_2^2C_Q^2}{3}D[\log(2D)]^6.
 \end{aligned}
\]

The last step uses exactly \(D=3AB\), \(A,B\ge1\), hence
\(A,B\le D\), and positivity of the logarithms. Increase the absolute
constant to at least one. ∎

Equivalently, \(H\le K^{1/4}D^{1/4}[\log(2D)]^{3/2}\).
Using (15) instead of the stronger existing B theorem would give
\(H\ll D^{1/4}[\log(2D)]^2\); the reduction from eight logarithmic
powers to six in (17) comes specifically from (16).

**Corollary 5.** For \(H\ge2\), (17) implies

\[
 D\ge\frac{H^4}{K5^6(\log H)^6},\qquad
 \log D\ge4\log H-6\log\log H-\log(K5^6).                \tag{18}
\]

**Proof.** If \(D\ge H^4\), the first bound is immediate because
\(K5^6(\log H)^6>1\). Otherwise
\(\log(2D)\le\log2+4\log H\le5\log H\), so (17) gives the result.
All quantities are positive, permitting division and logarithms. ∎

When the denominator below is positive, (2) and (18) yield

\[
 p<\frac{4H}{4\log H-6\log\log H-\log(K5^6)}.
                                                               \tag{19}
\]

Thus along any sequence of these packets with strictly increasing \(b\),

\[
 p\le(1+o(1))\frac{H}{\log H}.                            \tag{20}
\]

This sharpens the previously recorded BEG-based index upper bound and
forces **both** squarefree endpoint parameters to grow. It is still
compatible with the earlier lower bound
\(p\ge(\log H/4300)^{1/5}\) and with
\(\log(D+1)/H\to0\). A logarithmic lower bound on \(D\) does not
contradict the latter concentration. No unproved endpoint condition or
neighboring-radical lower bound was used to obtain (17).

## 5. A general split-cubic point bound

The same approximation input can be used without the fourth square in
(1). This section has a different scope: \(d>0\) is squarefree,
\(x\ge2\) is an integer, and

\[
 y^2=d(x^3-x),\qquad y\in\mathbb Z.                       \tag{21}
\]

**Proposition 6.** There is an absolute effective \(C_6\) such that

\[
 \log x\le C_6d^{2/3}[\log(2d)]^3.                        \tag{22}
\]

**Proof.** Write the unique positive squarefree decompositions

\[
 x-1=a u^2,\quad x=b v^2,\quad x+1=c w^2.
\]

Neighboring coefficients are coprime, and
\(g=\gcd(a,c)\in\{1,2\}\). The squareclass of the product is \(d\),
so \(abc=g^2d\le4d\). No two of \(a,b,c\) are equal. For adjacent
ones equality would force two positive squares to differ by one. For the
end coefficients equality forces \(a=c\mid2\); either two squares differ
by two or two positive squares differ by one, again impossible.
Consequently all three products \(ab,bc,ac\) are nonsquares, and the
three real quadratic fields they define are pairwise distinct.

Set

\[
 U=2x-1+2uv\sqrt{ab},\quad
 V=2x+1+2vw\sqrt{bc},\quad
 W=x+uw\sqrt{ac}.
\]

Each is an algebraic integer of norm one in its respective quadratic
field. Writing \(f(t)=t+\sqrt{t^2-1}\), they are
\(U=f(2x-1),V=f(2x+1),W=f(x)\) at the positive embedding.
The elementary inequality \(2t-1<f(t)<2t\), for \(t>1\), gives

\[
 1<\frac VU<1+\frac2x,
 \qquad 1<\frac{V}{2W}<1+\frac2x,
 \qquad 1<\frac{2W}{U}<1+\frac2x.                         \tag{23}
\]

For example \(U>4x-3\), \(V<4x+2\), and
\(x\cdot5\le2(4x-3)\) for \(x\ge2\), proving the first upper bound;
the other two follow from \(2W>4x-2\), \(2W<4x\).
Strict lower bounds follow from the corresponding ordered lower and
upper endpoints. Thus all three approximating ratios differ from one.

Each ratio is generated by two quadratic fundamental units and, where
needed, the rational number two. Distinct quadratic fields give
independence modulo torsion; adjoining two adds an independent nonunit.
One may add two also for the first ratio, so (3) applies with rank three
in all cases. The generator height product is at most an absolute
constant times the product of the two regulators, by Lemma 1. The global
height of each ratio is at most \(\log x+C_7\), since the unit heights
are half the logarithms of their positive values; the factor two adds
only \(\log2\). Here \(C_7\) is absolute.

Select the ratio whose two quadratic radicands share the smallest member
\(m=\min(a,b,c)\). For instance, if \(m=b\), select \(V/U\).
The product of the two regulators is, by (5), at most

\[
 C_8\sqrt{abc\,m}\,[\log(2abc)]^2
 \le C_8(abc)^{2/3}[\log(2abc)]^2.
\]

This uses only \(m\le(abc)^{1/3}\); passing to squarefree radicands
can only improve the discriminant upper bounds used in (5).
Equations (3) and (23) give
\(\log x\le C_9(abc)^{2/3}[\log(2abc)]^2
\log(3\log x)+C_{10}\), after adjusting absolute constants to cover
bounded \(x\). Applying Lemma 3 absorbs the last logarithm, adding one
power of \(\log(2abc)\). Finally \(abc\le4d\) proves (22). ∎

For the first three equations of (1), take \(x=b+1\). Their squarefree
coefficients are \(A,B,3\), so selecting the pair of fields with common
coefficient three gives the stronger special-case bound
\(H\ll\sqrt D[\log(2D)]^3\). The fourth square and its fixed
\(\mathbb Q(\sqrt3)\) unit are what improve this further to (17).

## 6. Actual Frey normalization and the remaining coefficient cost

Let \(a,b,c\) now denote an arbitrary positive primitive abc triple,
and define

\[
 Q=a^2+ab+b^2,\quad T=(a-b)(2a+b)(a+2b),\quad
 m=abc/2,\quad Y=T/2.
\]

The symbol \(b\) in this section is a Frey summand, not the Pell packet
coordinate. Both \(abc\) and \(T\) are even: checking the parities of
\(a,b\) proves each assertion. Thus \(m,Y\) are integers and \(m>0\).

**Proposition 7.** The normalized point satisfies

\[
 Y^2=Q^3-27m^2.                                           \tag{24}
\]

It admits no further integer rescaling of weights \((2,3)\): if
\(z\ge1\), \(z^2\mid Q\), and \(z^3\mid Y\), then \(z=1\).

**Proof.** Expansion gives
\(4Q^3-T^2=27a^2b^2(a+b)^2\), and division by four proves (24).
Primitivity gives \(\gcd(Q,abc)=1\), hence \(\gcd(Q,m)=1\).
The two divisibilities imply \(z^6\mid27m^2\) and
\(\gcd(z,m)=1\), so \(z^6\mid27\). If \(z\ge2\), then
\(z^6\ge64>27\), a contradiction. ∎

For the usual integral Frey invariants, this divides \(c_4,c_6\) by
\(4^2,4^3\), respectively. It improves the fixed coefficient from
\(-27648(abc)^2\) to \(-27(abc/2)^2\) but leaves the growing prime
support cost. Indeed every prime exponent of \(k=-27m^2\) is at least
two, and therefore

\[
 \sqrt{\underline k}=\operatorname{rad}(3m),\qquad
 \tfrac12\operatorname{rad}(abc)
 \le\operatorname{rad}(3m)\le3\operatorname{rad}(abc).       \tag{25}
\]

There is an additional exact structural fact in Pasten's Thue reduction.
With binary variables \(U,V\), its cubic is

\[
 \begin{aligned}
 G(U,V)&=U^3-3QUV^2+2YV^3\\
 &=(U-(a-b)V)(U-(a+2b)V)(U+(2a+b)V).                     \tag{26}
 \end{aligned}
\]

The three root differences are \(3a,3b,3c\), up to sign, so they are
nonzero and the cubic is completely split. An invertible linear change
of the binary variables preserves this factorization type. Consequently
this normalized Frey point, even after the integral binary-form reduction
in Pasten's Section 4, lies in that section's reducible case. It does not
enter the irreducible-cubic regulator argument. This proves a limitation
of this exact rescaling and binary-linear-change strategy; it does not
exclude other auxiliary curves or nonlinear arithmetic constructions.

## 7. Proof status and the remaining mathematical problem

Equations (6), (14), (17), and (22) are mathematical consequences of
the stated approximation and regulator inputs and the small-generator
lemma specified in Section 1. They are not Lean closed proofs of those
external inputs.

The new module is
`Lean/IUTThreeClosures/GeometryUniformityContinuation20260830.lean`.
It checks the integer norm identities; the strict real approximation
bounds and their preservation under index one or two; the explicit
logarithmic absorption; the six-logarithm scalar combination with supplied
height inequalities; and the actual ABCPoint normalization, coprimality,
weighted primitivity, and binary-cubic factorization. In particular, the
Frey point is linked to the actual \(c_4,c_6\) invariants by the scale
\((4^2,4^3)\). It introduces no approximation theorem as an axiom.

The direct module check completed successfully:

```text
lake env lean IUTThreeClosures/GeometryUniformityContinuation20260830.lean
exit code: 0
```

All nine printed dependency reports contain only `propext`,
`Classical.choice`, and `Quot.sound`; none contains `sorryAx` or a new
mathematical axiom. This checks the new module, not a new full-repository
build. Number fields, their regulators, the external approximation and
small-generator theorems, the complete mathematical bounds (14) and (22),
and the asymptotic deduction (20) retain their stated paper-proof boundary.

The joint lower bound (18) is substantially stronger than the preceding
BEG specialization for this packet, but remains logarithmic in the
original point size. The missing step is still an estimate strong enough
to exclude the compatible moving-parameter region, or an independent
uniform bound for the actual coupled radical defect. No route is declared
false merely because that step is missing.
