# abc / IUT / radical-quality primary-literature gate audit

**Audit date:** 2026-09-03
**Retrieval cutoff:** searches and source checks are current **through 2026-09-03**.
**Scope:** standard \(abc\), IUT, radical/quality, \(S\)-units, powerful and
squarefull values, Pell/Lucas sequences, Mason--Stothers and function-field
analogues, and proposed alternative quality metrics. Only original papers,
author-hosted versions, official journal copies, and arXiv versions are used as
mathematical sources. Search snippets, blogs, news, and secondary summaries are
not used to establish any theorem below.

> **时间边界与总判定（检索截至 2026-09-03）：**标准 abc 仍无公认的无条件证明或证伪；IUT 已有正式发表来源，但本仓库尚未得到 source-faithful 的 all-place / Ind3 / pointed-transport 闭合。

## 1. Overall judgment

As of the cutoff, **standard \(abc\) still has no generally accepted
unconditional proof or disproof**. Published IUT sources exist, but this
repository has not obtained a source-faithful closure of the **all-place / Ind3 /
pointed-transport** chain. This audit therefore does not promote an IUT-derived
inequality to an independently closed theorem.

No checked source closes any of the following three selected active arithmetic
gates:

| active gate | exact missing conclusion | literature outcome |
|---|---|---|
| canonical defect | a uniform pointwise upper bound for \(X-Y\) | Laniewski identifies \(X-Y\) exactly in the parity class; BBLT and Lichtman give aggregate counts. Neither supplies the required pointwise bound. |
| compensated packet | an eventual estimate such as \(B(Q)^m\le (ab)^mR^{m+n}\) with the repository's actual packet quantities | none of the checked papers contains the packet quantity \(B(Q)\) or a theorem yielding its needed compensation by \(ab\) |
| Pell simultaneous-squarefull | exclude, or construct unboundedly often, squarefull \(A_\ell B_\ell\) for odd prime \(\ell\) | primitive-divisor and valuation theorems leave the first-rank exponent free; the new Pell family is mainly at composite indices; the only prime seed in it is not squarefull |

The classification used below is deliberately strict:

- **directly formalizable** means either an elementary identity/implication that
  can be proved from existing integer, polynomial, or valuation APIs, or a deep
  theorem whose exact hypotheses can be recorded as a source-labelled external
  interface. It does not mean that the external paper has already been
  re-proved in Lean.
- **conditional/source-dependent** means the result assumes \(abc\), another
  conjecture, or the contested IUT theorem chain, or starts from a hypothetical
  transgressive sequence.
- **cannot be used as stated** means that a required hypothesis is absent, the
  conclusion has the wrong quantifiers, or a specific printed proof step fails.
  Such a finding rejects only that inference, not the paper's other results and
  not the surrounding research route.

## 2. Repository gate dictionary

For a primitive positive triple \(a+b=c\), put

\[
 m=\log(abc),\qquad r=\log\operatorname{rad}(abc),\qquad h=\log c,
\]

and

\[
 X=\frac{m-r}{r},\qquad Y=\frac{m-h}{r}.
\]

Then the standard quality satisfies the exact identity

\[
 q=\frac{h}{r}=1+X-Y.
\]

Thus a proof of standard \(abc\) needs an independently justified, uniform
eventual bound on \(X-Y\), equivalently a bound of the form
\(X-Y\le\varepsilon+C_\varepsilon/r\). Bounds on the repeated-prime mass \(X\)
alone do not suffice because \(Y\) is the compensating mass.

For the packet route, the former uncompensated target
\(B(Q)\le R^{1+\varepsilon}\) is already false in the repository at
\(\varepsilon=1/3\). The surviving sufficient interface is a compensated
estimate of the form

\[
 B(Q)^m\le (ab)^mR^{m+n}\quad\Longrightarrow\quad c^m\le R^{m+n}.
\]

For the Pell route, write

\[
 (1+\sqrt{2})^\ell=A_\ell+B_\ell\sqrt{2}
\]

at odd prime indices \(\ell\). The repository's simultaneous zero-displacement
condition is equivalent to \(A_\ell B_\ell\) being squarefull. A local root,
one repeated prime, one squarefull coordinate, or a primitive divisor without
valuation control does not decide this gate.

## 3. Directly formalizable or exact unconditional interfaces

### 3.1 Laniewski: exact defect identities and parity-class thresholds

**Source.** R. Laniewski, *Radical defects, Wieferich primes, and the \(abc\)
conjecture*, arXiv:2609.00039v1 (submitted 2026-08-29),
[abstract](https://arxiv.org/abs/2609.00039),
[PDF](https://arxiv.org/pdf/2609.00039v1). Page numbers below are PDF/printed
page numbers, which coincide. The repository already caches this version in
`research/sources/mersenne_farey_denominator_entropy_2026_09_02/`.

**Full common premises.** A *parity-class triple* consists of pairwise coprime
positive integers \(a,b,c\), with \(a+b=c\), \(a,b\) odd and \(c\) even. Put

\[
 K=\frac{a+b}{2},\qquad M=\frac{b-a}{2},\qquad
 \rho=\frac{|M|}{K},\qquad s=\min(a,b),
\]

let \(R_K\) be the product of the **odd** primes dividing \(K\),
\(t_K=\log R_K\), let

\[
 \delta_{\rm lin}=\log\frac{ab}{\operatorname{rad}(a)\operatorname{rad}(b)},
 \qquad
 \delta_{\rm tot}=\log\frac{abc}{\operatorname{rad}(abc)},
 \qquad \theta_\varepsilon=\frac{\varepsilon}{1+\varepsilon},
\]

and \(E_\varepsilon=\log c-(1+\varepsilon)\log\operatorname{rad}(abc)\).

1. **Proposition 2.6, p. 7.**

   \[
   \operatorname{rad}(abc)=2R_K\operatorname{rad}(a)\operatorname{rad}(b).
   \]

   This is an elementary support-separation identity and is suitable for a
   kernel proof.

2. **Proposition 3.4, p. 8.** The exact radical-excess identity is

   \[
   \begin{aligned}
   E_\varepsilon={}&-(1+2\varepsilon)\log K
   -(1+\varepsilon)t_K+(1+\varepsilon)\delta_{\rm lin}\\
   &-(1+\varepsilon)\log(1-\rho^2)-\varepsilon\log 2.
   \end{aligned}
   \]

   **Reusable unconditional proposition:** this is exact algebra once
   Proposition 2.6 and \(ab=K^2(1-\rho^2)\) are available.
   **Missing bridge:** it has no upper bound for the positive defect terms.

3. **Proposition 3.7 and Corollary 3.9, pp. 8--9.**

   \[
   E_\varepsilon=(1+\varepsilon)
   (\delta_{\rm tot}-\log(ab))-\varepsilon\log(2K),
   \]

   and

   \[
   q=1+\frac{\delta_{\rm tot}-\log(ab)}
   {\log\operatorname{rad}(abc)}.
   \]

   Since \(\delta_{\rm tot}=m-r\) and
   \(\log(ab)=m-h\), Corollary 3.9 is **exactly** the repository identity
   \(q=1+X-Y\). This is the clearest increment not yet used in the current main
   paper: it identifies the canonical gate source-faithfully, but supplies no
   estimate for \(X-Y\).

4. **Theorem 4.3, pp. 9--10.** If \(K>1\), then

   \[
   E_\varepsilon\ge0
   \quad\Longleftrightarrow\quad
   \delta_{\rm lin}\ge t_K+\theta_\varepsilon\log(2K)
      +\log\!\left(s\left(2-\frac{s}{K}\right)\right).
   \]

   The boundary term is increasing for \(1\le s\le K\) and lies between
   \(\log(2-1/K)\) and \(\log(2s)\).
   **Reusable unconditional proposition:** an exact iff certificate in the
   parity class.
   **Missing bridge:** it restates transgression as a lower bound on the
   repeated-prime defect; it does not prove that the lower bound eventually
   fails.

5. **Proposition 4.8, pp. 11--12.** If \(0\le\alpha\le1\), \(s\ge K^\alpha\),
   and \(E_\varepsilon\ge0\), then

   \[
   \delta_{\rm lin}\ge t_K+(\theta_\varepsilon+\alpha)\log(2K)-\log 2.
   \]

   When \(\theta_\varepsilon+\alpha<1\), this is only the **necessary condition**
   from Theorem 4.4 at the amplified parameter
   \(\theta_{\varepsilon'}=\theta_\varepsilon+\alpha\), up to \(\log 2\).
   It does **not** conclude \(E_{\varepsilon'}\ge0\).

6. **Corollary 4.9 and Theorem 4.12, p. 12.** Squarefree \(a,b\) imply
   \(E_\varepsilon<0\). If \(u_a=\operatorname{sq}(a)\) and
   \(u_b=\operatorname{sq}(b)\) are the square roots of the largest square
   divisors and \(E_\varepsilon\ge0\), then

   \[
   \max(u_a^2,u_b^2)\ge u_au_b\ge
   (sR_K)^{1/2}(2K)^{\theta_\varepsilon/2}.
   \]

   **Reusable unconditional proposition:** a transgressive parity triple forces
   a quantitatively large square part in a summand.
   **Missing bridge:** no cited result counts or excludes integral solutions to
   the resulting moving-kernel quadratic equation at this size.

7. **Proposition 4.15 and Remark 4.16, pp. 13--14.** For odd positive
   \(d_a,d_b\) and even \(2K\),
   \(d_aX^2+d_bY^2=2K\) has a solution with \(X,Y\in\mathbb Z_2^\times\) iff
   \(d_a+d_b\equiv2K\pmod8\). The paper explicitly warns that this local test
   neither produces coprime integral \(X,Y\) nor the size lower bound of
   Theorem 4.12. This is useful as a local filter only.

8. **Theorems 4.20 and 4.26, pp. 15--18.** A transgressive parity triple has a
   repeated prime in a summand satisfying the weighted lower bound of Theorem
   4.20, and at least two distinct primes of \(abc\) have valuation at least two.
   These statements are directly recordable but give no uniform control when
   the support size grows.

9. **Theorem 4.31, pp. 19--20.** Let
   \((x_1,y_1)=(1,1)\),
   \(x_{n+1}=3x_n+4y_n\), \(y_{n+1}=2x_n+3y_n\), and
   \(P_n=(1,x_n^2,2y_n^2)\), \(n\ge2\). Then

   \[
   q(P_n)>1\quad\Longleftrightarrow\quad x_ny_n
   \text{ is not squarefree}.
   \]

   For \(n=7j+4\), \(q(P_n)>1\),

   \[
   q(P_{7j+4})-1>
   \frac{\log(13/\sqrt{2})}{\log(2y_{7j+4}^2)},
   \]

   and the lower index density is at least \(1/7\). Because
   \(x_n+y_n\sqrt{2}=(1+\sqrt{2})^{2n-1}\), this progression has exponent
   \(\ell=14j+7=7(2j+1)\), composite for every \(j\ge1\). For \(j=0\), the
   prime exponent is \(\ell=7\), but

   \[
   A_7B_7=239\cdot169=239\cdot13^2
   \]

   has \(v_{239}=1\) and is not squarefull. Thus this is also a full-premise
   counterexample to the inference
   “prime-index Pell quality \(>1\), or non-squarefree, implies simultaneous
   squarefullness.” The excess tends to zero, so the theorem gives no fixed
   \(\varepsilon>0\) transgressive family.

10. **Theorem 10.5, pp. 68--69.** This result is audited under conditional
    interfaces in Section 4 because its premise is a hypothetical infinite
    transgressive sequence.

**Net Laniewski increment.** Propositions 3.4 and 3.7, Corollary 3.9, and
Theorems 4.3 and 4.12 are worthwhile exact interfaces. Theorem 4.31 and
Theorem 10.5 delimit the two active directions but do not close either the
canonical defect or Pell gate. No result in the paper mentions or bounds the
repository's compensated packet \(B(Q)\).

### 3.2 Exceptional-set counts: unconditional but aggregate

**Bernert--Browning--Lichtman--Teräväinen.** C. Bernert, T. Browning,
J. D. Lichtman, J. Teräväinen, *Bounds on the exceptional set in the \(abc\)
conjecture*, arXiv:2410.12234v2 (2026-05-09),
[abstract](https://arxiv.org/abs/2410.12234v2),
[PDF](https://arxiv.org/pdf/2410.12234v2).

Let \(N_\lambda(X)\) count primitive positive \(a+b=c\) in \([1,X]^3\) with
\(\operatorname{rad}(abc)<c^\lambda\).

- **Proposition 1.1, p. 2:** for every \(\lambda>0\) and \(\varepsilon>0\),
  \(N_\lambda(X)=O_\varepsilon(X^{2\lambda/3+\varepsilon})\).
- **Theorem 1.2, p. 2:** for \(0<\lambda\le2\) and every \(\varepsilon>0\),

  \[
  N_\lambda(X)\ll_\varepsilon
  X^{(23\lambda+3)/40+\varepsilon}.
  \]
- **Theorem 1.3, p. 2:** for fixed \(0<\lambda<1\) and every
  \(\varepsilon>0\),
  \(N_\lambda(X)\ll_{\varepsilon,\lambda}X^{0.6+\varepsilon}\).

These are exact, unconditional counting interfaces. Their quantifier is a
power-saving upper bound for the number of exceptions up to \(X\), rather than
\(O(1)\), and they yield no pointwise estimate for \(X-Y\).

**Lichtman.** J. D. Lichtman, *The \(abc\) conjecture is true almost always*,
arXiv:2505.13991v1,
[abstract](https://arxiv.org/abs/2505.13991),
[PDF](https://arxiv.org/pdf/2505.13991v1). For a fixed \(\varepsilon>0\), let
\(E(N)\) be primitive positive triples in \([1,N]^3\) with
\(\operatorname{rad}(abc)<c^{1-\varepsilon}\). **Theorem 1.1, p. 2** gives
\(|E(N)|=O(N^{2/3})\). This is a clean elementary counting interface, superseded
quantitatively in the relevant ranges by BBLT, and again does not imply finite
exceptions.

### 3.3 Powerful numbers and generalized Fermat surfaces

**Browning--Verzobio.** T. Browning and M. Verzobio, *Sums of three powerful
numbers*, arXiv:2608.24512v1 (2026-08-25),
[abstract](https://arxiv.org/abs/2608.24512),
[PDF](https://arxiv.org/pdf/2608.24512v1).

Let \(S_m\) be the positive \(m\)-full integers. Their \(N(B)\) counts primitive
\(a+b=c\) with \((a,b,c)\in S_p\times S_q\times S_r\) and coordinates at most
\(B\).

- **Theorem 1.1, pp. 2--3:** fix \(u\ge v\ge0\), put \(p=r+u\), \(q=r+v\).
  For all sufficiently large \(r\), an explicit
  \(\eta_{u,v}(r)>0\) gives

  \[
  N(B)\ll_{\varepsilon,u,v,r}
  B^{1/p+1/q-\eta_{u,v}(r)+\varepsilon},
  \qquad
  \eta_{u,v}(r)=r^{-2}+O_{u,v}(r^{-5/2}).
  \]
- **Theorem 1.2, p. 3:** for fixed \(p,q,r\ge2\), nonzero integer
  coefficients \(a_1,a_2,a_3\), \(X,Y,Z\ge2\), and
  \(W=\exp\sqrt{\log X\log Y/r}\), the number of primitive points on
  \(a_1x^p+a_2y^q+a_3z^r=0\) in the indicated box is

  \[
  \ll_{\varepsilon,p,q,r}(XYZ)^\varepsilon
  \left(W^2+W\max(X,Y)^{2/\sqrt{\max(p,q,36)}}
  +W\max(X,Y)^{1/r}\right),
  \]

  uniformly in the coefficients.
- **Lemma 2.6, p. 5:** Brownawell--Masser for nonconstant \(S\)-units
  \(1+u+v=0\) on a smooth projective curve \(C/\mathbb Q\), with no proper
  vanishing subsum:
  \(H_C(1:u:v)\le2g-2+|S|\).
- **Lemma 2.7, p. 5:** the characteristic-zero polynomial
  Mason--Stothers inequality.

**Missing bridge.** The paper explicitly places itself in the log-general-type
range \(1/p+1/q+1/r<1\). The simultaneous-squarefull case \(p=q=r=2\) is
log-Fano; p. 2 records the conjectural asymptotic \(N(B)\sim cB^{1/2}\) and the
best cited upper bound \(N(B)\ll_\delta B^{3/5-\delta}\) for
\(\delta<3/1555\). Hence Theorem 1.1 cannot be specialized to the repository's
Pell squarefull gate. The conclusions are counts for fixed exponents, not a
pointwise packet or valuation-one theorem.

### 3.4 Mordell, Thue--Mahler, and small-\(j\)-denominator bounds

**Pasten, 2026 preprint.** H. Pasten, *Power-saving bounds for Thue--Mahler and
Mordell equations*, arXiv:2608.23559v1 (2026-08-24),
[abstract](https://arxiv.org/abs/2608.23559),
[PDF](https://arxiv.org/pdf/2608.23559v1).

- **Theorem 1.1, p. 2:** for \(k\ne0\), every integral
  \(y^2=x^3+k\) satisfies

  \[
  \log\max(|x|,|y|)\ll |k|^{1/2}(\log(2|k|))^4,
  \]

  with effective absolute constant.
- **Theorem 1.2, p. 2:** if \(x^3\ne y^2\), with
  \(X=\max(3,|x|,|y|)\),

  \[
  |x^3-y^2|\gg\frac{(\log X)^2}{(\log\log X)^8},
  \]

  effectively and absolutely.
- If
  \(\bar n=\prod_p p^{\min(2,v_p(n))}\), **Theorems 1.3 and 1.4, p. 2** give
  the truncated and radical forms; the latter is

  \[
  \log\max(|x|,|y|)\ll
  \operatorname{rad}(k)(\log(2\operatorname{rad}k))^2
  \log(2|k|)\log(\operatorname{rad}(k)\log(3|k|)).
  \]
- **Theorem 1.6, p. 3:** if an elliptic curve over \(\mathbb Q\) has integral
  \(j\)-invariant, then
  \(h(E)\ll N_E^{1/2}(\log N_E)^4\), effectively.
- **Theorems 1.7--1.8, pp. 3--4:** effective cubic Thue--Mahler bounds have
  explicit dependence on the fixed support, its \(S\)-regulator, the largest
  support prime, and the cubic discriminant.

These are strong unconditional, source-faithful interfaces. Their scale is
logarithmic and their constants grow with the support/regulator; arbitrary
\(abc\) triples have moving support. No coefficient-one \(X-Y\) estimate follows.

**Pasten, CUBO 2026.** H. Pasten, *Szpiro's conjecture when the denominator of
the \(j\)-invariant is small*, CUBO 28(2) (2026), 383--389,
[DOI](https://doi.org/10.56754/0719-0646.2802.383),
[official PDF](https://www.scielo.cl/pdf/cubo/v28n2/0719-0646-cubo-28-02-383.pdf).
**Theorem 1.2, printed p. 384 / PDF p. 2:** if \(A,B>0\) and

\[
 \operatorname{den}(j_E)\le
 A(\log\operatorname{num}(j_E))^B,
\]

then

\[
 |\Delta_E|\le A16^{B+1}N_E^{B+5}(\log N_E)^B.
\]

**Corollary 1.3, printed p. 385 / PDF p. 3** gives
\(|\Delta_E|\le256AN_E^6\log N_E\) for \(B=1\); **Corollary 3.4,
printed p. 387 / PDF p. 5** gives
\(|\Delta_E|\mid16\operatorname{den}(j_E)N_E^5\).
The missing bridge is the small-denominator premise for the Frey curves attached
to arbitrary \(abc\) triples.

### 3.5 \(S\)-unit interfaces

**Hirata-Kohno--Kawashima--Poëls--Washio.** *\(S\)-unit equation in two
variables and Padé approximations*, arXiv:2211.14399v1,
[abstract](https://arxiv.org/abs/2211.14399),
[PDF](https://arxiv.org/pdf/2211.14399v1).
Let \(K\) be a number field of degree \(d\), let \(S\) contain all archimedean
places, \(s=|S|\), and fix nonzero \(\lambda,\mu\in K\).
**Theorem 1.1, PDF p. 1** says that
\(\lambda x+\mu y=1\), \(x,y\in U_S\), has at most

\[
 (3.1+5(3.4)^d)45^s
\]

solutions. The sharper displayed minimum is equation (3), PDF p. 2:

\[
 \min\left\{
 2.81864(46.8312)^s+5(3.22803)^d47^s,
 3.06759(44.9866)^s+5(3.36406)^d45^s
 \right\}.
\]

For \(x=a/c,y=b/c\) over \(\mathbb Q\), \(S\) contains infinity and all primes
of \(abc\), so \(s=\omega(abc)+1\) varies. The theorem counts solutions for
fixed \(S\) and explicitly does not provide their height bound. It therefore
does not control \(X-Y\).

**Wang--Xiao.** J. T.-Y. Wang and Z. Xiao, *Families of unit equations and
exponential Diophantine problems via integral points*, arXiv:2604.26497v1,
[abstract](https://arxiv.org/abs/2604.26497),
[PDF](https://arxiv.org/pdf/2604.26497v1).
For fixed number field \(k\), fixed finite \(S\), and nonconstant
\(f_i\in k[t]\) without a common zero, **Theorem 1.14, PDF p. 7** assumes

\[
 \max_i(d_i+1)<
 \frac{(n+1)^n}{(n+1)^n-n^n}\min_i d_i
\]

and concludes that all but finitely many integral/\(S\)-unit points of the
one-parameter unit equation lie in a proper Zariski closed subset.
**Theorem 1.15, p. 7** gives the analogous degeneracy when all degrees are the
same. Fixed \(S\) and “proper closed subset” are materially weaker than a
moving-support height bound, so these results do not cross a repository gate.

### 3.6 Mason--Stothers and function-field analogies

**Baek--Lee.** J. Baek and S. Lee, *Formalizing Mason--Stothers Theorem and its
Corollaries in Lean 4*, arXiv:2408.15180v2 (revised 2025-09-25),
[abstract](https://arxiv.org/abs/2408.15180v2),
[PDF](https://arxiv.org/pdf/2408.15180v2).

- **Theorem 1, PDF p. 2:** over any field \(k\), if nonzero pairwise coprime
  \(a,b,c\in k[t]\) satisfy \(a+b+c=0\), then either
  \(a'=b'=c'=0\), or

  \[
  \max(\deg a,\deg b,\deg c)<\deg\operatorname{rad}(abc).
  \]
- **Lean statement `Polynomial.abc`, pp. 8--9:** only `IsCoprime a b` is
  assumed, because the zero-sum relation supplies the other coprimalities;
  the conclusion is the derivative disjunction or
  `max3 natDegree + 1 ≤ natDegree (radical (a*b*c))`.
- **Theorem 2, p. 3:** if \(p,q,r\ge1\) are not divisible by
  \(\operatorname{char}k\), \(1/p+1/q+1/r\le1\), and nonzero pairwise coprime
  polynomials solve \(ua^p+vb^q+wc^r=0\) for nonzero constants \(u,v,w\), then
  all three polynomials are constant.
- **Theorem 5 and `Polynomial.abc'_char0`, pp. 11--12:** the
  characteristic-zero noncoprime variant is also formalized.
- **Theorem 6, p. 16:** for algebraically closed \(k\), a smooth projective
  curve \(C/k\) of genus \(g\), \(a+b=1\) in \(k(C)\), and finite \(S\)
  containing all zeros and poles, either \(a,b\in k^\times\), or
  \(\max(\deg a,\deg b)\le2g-2+|S|\). This last theorem is discussed rather
  than formalized in the paper.

The repository already imports Mathlib's Mason--Stothers development. The
unclosed step remains a specialization theorem comparing polynomial degree and
polynomial radical with integer height and \(\operatorname{rad}(abc)\); none is
present in the source.

**Full-premise characteristic-\(p\) counterexample, p. 3.** If the derivative
alternative is deleted, the naive characteristic-free inequality is false:

\[
 (-1,-t^p,(1+t)^p)
\]

is nonzero, pairwise coprime, has zero sum, and satisfies
\(\max\deg+1=p+1>2=\deg\operatorname{rad}(abc)\). This is suitable as a regression
test for any proposed generalization.

**Lu--Lu--Wen.** J.-T. Lu, X.-X. Lu, Z.-T. Wen, *\(Q\)-difference analogue of
the Stothers--Mason theorem*, arXiv:2605.27876v1,
[abstract](https://arxiv.org/abs/2605.27876),
[PDF](https://arxiv.org/pdf/2605.27876v1).
**Theorem 3.2, PDF pp. 7--8** assumes \(q\in\mathbb C^*\), \(|q|\ne1\), and
relatively \(q\)-prime polynomials \(a+b=c\), not all constant, and proves

\[
 \max(\deg a,\deg b,\deg c)\le
 \deg\operatorname{rad}_q(abc)-1.
\]

**Theorem 4.1, pp. 8--10** gives the multi-summand truncated
\(q\)-radical form under pairwise relative \(q\)-primality, a minimum-degree
condition, and linear independence of \(f_1,\ldots,f_m\). These use a
\(q\)-shift radical, with no theorem relating it to the integer radical, so no
arithmetic specialization is presently available.

### 3.7 Pell/Lucas local and primitive-divisor results

**Sanna.** C. Sanna, *The \(p\)-adic valuation of Lucas sequences*, Fibonacci
Quarterly 54(2) (2016), 118--124,
[official PDF](https://www.fq.math.ca/Papers1/54-2/Sanna02242016.pdf).
For the nondegenerate recurrence
\(u_0=0,u_1=1,u_n=au_{n-1}+bu_{n-2}\), with \(\gcd(a,b)=1\) and
\(\Delta=a^2+4b\), **Theorem 1.5 and Corollaries 1.6--1.7,
PDF pp. 1--2** imply, in particular, that for odd
\(p\nmid b\Delta\),

\[
 v_p(u_n)=
 \begin{cases}
 v_p(n)+v_p(u_{\tau(p)}),&\tau(p)\mid n,\\
 0,&\tau(p)\nmid n,
 \end{cases}
\]

where \(\tau(p)\) is the rank of apparition. For Pell \(B_n\), take
\(a=2,b=1,\Delta=8\). At a prime index \(\ell\), every
\(p\mid B_\ell\) has \(\tau(p)=\ell\) and \(p\ne\ell\), so the formula reduces to
the still-unknown first-rank valuation \(v_p(B_\ell)\). It does not produce a
prime with valuation one.

**Yabuta/Carmichael.** M. Yabuta, *A simple proof of Carmichael's theorem on
primitive divisors*, Fibonacci Quarterly 39(5) (2001), 439--443,
[official PDF](https://www.fq.math.ca/Scanned/39-5/yabuta.pdf).
**Theorem 1, PDF p. 1 / printed p. 439:** for a real Lucas sequence with
coprime nonzero recurrence parameters \(L,M\), \(L>0\), the \(n\)-th term has a
primitive divisor for \(n\notin\{1,2,6\}\), except the Fibonacci case
\((L,M,n)=(1,-1,12)\). Applied to Pell, it supplies a new-support prime at prime
\(\ell\ge3\), but “primitive” controls first occurrence, not exponent one.

**Zhang.** G.-R. Zhang, *13 unknowns over quadratic integer rings and Lucas
congruences*, arXiv:2608.30389v1 (2026-08-31),
[abstract](https://arxiv.org/abs/2608.30389),
[HTML](https://arxiv.org/html/2608.30389v1),
[PDF](https://arxiv.org/pdf/2608.30389v1).
For \(u_{n+2}=au_{n+1}-u_n\), \(v_{n+2}=av_{n+1}-v_n\),
\(\delta=a^2-4\):

- **Proposition 5.1, PDF p. 20** gives the all-orders norm-one Lucas
  multiplication polynomial.
- **Corollaries 5.2--5.3, p. 21** give the fourth-order expansion and exact
  \(\ell\)-adic valuation of the deviation
  \(u_{nk}/u_n-k\), under \(u_n\ne0\), odd \(k\), odd prime
  \(\ell\nmid\delta\), and \(\ell\mid u_n\).
- **Theorem 5.6, pp. 23--24:** fix \(n\) with \(u_n\ne0\), a nonzero divisor
  \(s\mid u_n\), and odd \(t\). For every residue \(c\pmod s\), infinitely many
  positive odd \(k\) satisfy

  \[
  k\equiv t\pmod{u_n^2},\qquad
  \frac{u_{nk}/u_n-t}{u_n^2}\equiv c\pmod s.
  \]
- **Corollary 5.7, p. 24** gives the corresponding \(\ell\)-adic density along
  \(N_j=n_0\ell^j\), with its stated conditions
  \(\ell\ge3\), \(\ell\nmid\delta\), and \(\ell\mid u_{n_0}\).

These are useful local one-coordinate congruence interfaces. They do not impose
simultaneous conditions on the \(u\)- and \(v\)-companions, do not keep the
resulting index prime, and do not prove squarefullness or nonsquarefullness.

**Falk--Harrington--Jones.** A. Falk, J. Harrington, L. Jones,
*Generalized Wieferich primes and monogenic trinomials*,
arXiv:2607.29329v1,
[abstract](https://arxiv.org/abs/2607.29329),
[HTML](https://arxiv.org/html/2607.29329v1),
[PDF](https://arxiv.org/pdf/2607.29329v1).
Their standing premise (1.3), PDF p. 2, is that \(b\ge2\) and both \(b\) and
\(b-4\) are squarefree, with \(D=b^2-4b\).
**Theorem 1.5, pp. 2--3** gives an exact three-case monogenicity criterion for
\(\mathcal G_{p,b}=x^{2p}+bx^p+b\), according to
\(\delta=(D/p)\in\{0,1,-1\}\). **Corollary 1.7, p. 3** says that for
\(b\in\{2,3\}\), \(p\ge3\), \(p\nmid D\), nonmonogenicity is equivalent to
\(b^{p-1}\equiv1\pmod{p^2}\). **Theorem 1.8, p. 3** reduces composite \(n\)
monogenicity to all prime divisors of \(n\). This is an exact local Wieferich
criterion for a different object; it supplies neither a count of such primes nor
a Pell valuation-one/squarefull theorem.

### 3.8 Alternative metrics: exact identities that remain usable

**Sankaran.** A. Sankaran, *Variants on the \(abc\)-Conjecture using Alternative
Quality Metrics*, arXiv:2606.08416v1,
[abstract](https://arxiv.org/abs/2606.08416),
[PDF](https://arxiv.org/pdf/2606.08416v1).
For the distinct primes of \(N=\operatorname{rad}(abc)\), let

\[
 A=\frac1\omega\sum_{p\mid N}\log p,\qquad
 G=\left(\prod_{p\mid N}\log p\right)^{1/\omega},\qquad
 \eta=G/A.
\]

- **Theorem 3.12, PDF pp. 8--9:** using Chen's theorem, there are infinitely
  many primes \(p\) for which \(p+2\) is prime or a product of two primes, and
  the triples \((2,p,p+2)\) have the displayed lower bound
  \(q_{\rm DGM}\gg(\log c)^{1/4}\). This is an unconditional theorem about the
  alternative metric, not standard quality.
- The first assertion of **Theorem 4.13, p. 17** is the exact identity

  \[
  q_{\rm std}=q_C(\alpha,1)\,\omega^{\alpha-1}\eta.
  \]

  At \(\alpha=1\), \(q_{\rm std}=\eta q_{\rm DGM}\). This algebraic identity is
  directly formalizable.
- **Theorem 4.15, pp. 17--18:** standard \(abc\) is equivalent to
  \(q_{\rm DGM}\le(1+\varepsilon)/\eta\) for all but finitely many triples.
  This is an exact reformulation, not an independent estimate for \(\eta\).

The valid metric identities may be retained. The specific asymptotic claims
listed in Section 5.2 below may not.

**Bright.** C. Bright, *A new lower bound in the \(abc\) conjecture*, Canadian
Mathematical Bulletin 67(2) (2024), 369--378,
[author/arXiv version](https://arxiv.org/abs/2301.11056v2),
[PDF](https://arxiv.org/pdf/2301.11056v2).
**Theorem 3.1, PDF p. 8** gives infinitely many \(abc\) triples satisfying

\[
 \exp\!\left(4\sqrt{2(\delta/e)\frac{\log c}{\log\log c}}\right)
 \operatorname{rad}(abc)\le c.
\]

Rankin's permissible lattice constant yields about \(6.56338\) in the
exponent. This proves infinitely many \(q>1\) triples, but the excess over one
tends to zero; it is consistent with standard \(abc\) and does not provide a
fixed-\(\varepsilon\) family.

## 4. Conditional or source-dependent interfaces

### 4.1 Laniewski's hypothetical transgressive-sequence dichotomy

**Theorem 10.5, PDF pp. 68--69** of arXiv:2609.00039v1 fixes
\(\varepsilon>0\) and assumes a sequence of distinct parity-class triples with
\(E_\varepsilon\ge0\) for every term. It extracts a subsequence in exactly one
of two regimes:

1. \(s_j=s_0\) for a fixed odd \(s_0\), \(K_j\to\infty\), and

   \[
   \log\frac{2K_j-s_0}{\operatorname{rad}(2K_j-s_0)}
   \ge t_K(T_j)+\theta_\varepsilon\log(2K_j)+\log\operatorname{rad}(s_0);
   \]
2. \(s_j\to\infty\), and

   \[
   \delta_{\rm lin}(T_j)-t_K(T_j)-
   \theta_\varepsilon\log(2K_j)\ge\log s_j\to\infty.
   \]

If additionally \(s_j\ge K_j^\alpha\) for fixed
\(0<\alpha\le1\) and \(\theta_\varepsilon+\alpha<1\), Proposition 4.8 gives only
the amplified **necessary** threshold up to \(\log 2\).

This is a rigorous conditional normal form for a putative counterexample
sequence. The missing bridge is precisely the exclusion of both regimes; the
theorem itself does not do so.

### 4.2 \(abc\)-conditional Pell/Lucas finiteness

**Ribenboim.** P. Ribenboim, *On square factors of terms of binary recurring
sequences*, Publicationes Mathematicae Debrecen 59 (2001), 459--469,
[official journal PDF](https://publi.math.unideb.hu/load_doi.php?pdoi=10_5486_PMD_2001_2559).
The standing Lucas hypotheses, printed p. 460 / PDF p. 2, are
\(P>0\), \(Q\ne0\), \(\gcd(P,Q)=1\), and
\(D=P^2-4Q\ne0\). For the companion term, \(V'_n\) removes prime factors
dividing \(2P\). **Statement 2.22, printed p. 465 / PDF p. 7:** assuming the
standard \(ABC\) conjecture, each of

\[
 \{n\ge1:U_n\text{ is powerful}\},\qquad
 \{n\ge1:V'_n\text{ is powerful}\}
\]

is finite. For \(P=2,Q=-1\) and odd \(n\), \(U_n=B_n\) and \(V'_n=A_n\).
Thus standard \(abc\) would imply the desired finiteness of each Pell channel,
but using it to prove or disprove \(abc\) is circular.

### 4.3 Letendre's strengthened radical conjecture

**Source.** E. Letendre, arXiv:2607.07641v2,
[abstract](https://arxiv.org/abs/2607.07641v2),
[PDF](https://arxiv.org/pdf/2607.07641v2). Define, on PDF p. 2,

\[
 H(n)=\frac{\operatorname{rad}(n)}
 {(\log\operatorname{rad}(n))^{\omega(n)}}.
\]

- **Conjecture 1, pp. 2--3:** for every \(\varepsilon>0\), all primitive
  \(a+b=c\) satisfy \(c<C(\varepsilon)H(abc)^{1+\varepsilon}\).
- **Proposition 1, p. 3:** this conjecture implies standard \(abc\).
- **Proposition 2, p. 3:** the minimum of \(H(n)\) over
  \(\omega(n)=k\) is \(e^{-k(1+o(1))}\).
- **Proposition 3, p. 3:** unconditionally, infinitely many primitive triples
  satisfy

  \[
  c>H\exp\!\left(\frac{2\log H}{\log\log H}\right),
  \qquad H=\max(H(abc),e^e).
  \]
- **Theorems 1--2, p. 3** are conditional on Conjecture 1 and concern prime
  factor counts in short blocks and CRT systems.

The unconditional propositions test the proposed metric. The gate-relevant
upper bound remains Conjecture 1, which is stronger than and not derived from
standard \(abc\).

### 4.4 IUT and downstream explicit inequalities

**Mochizuki, IUT III.** S. Mochizuki, *Inter-universal Teichmüller Theory III:
Canonical Splittings of the Log-theta-lattice*, published in PRIMS 57 (2021),
author version
[PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf).

**Corollary 3.12, PDF pp. 173--174** begins “Suppose that we are in the
situation of Theorem 3.11.” It defines the procession-normalized mono-analytic
log-volume of the holomorphic hull of the union of possible images of a
\(\Theta\)-pilot object, with the images subject to \(\mathrm{Ind1}\), \(\mathrm{Ind2}\), and \(\mathrm{Ind3}\).
The \(q\)-pilot volume is expressly not treated as subject to those
indeterminacies. The stated conclusion is

\[
 -|\log\Theta|\ge-|\log q|,
\]

equivalently \(C_\Theta\ge-1\) for a real \(C_\Theta\) satisfying
\(-|\log\Theta|\le C_\Theta|\log q|\).

This is a precise source interface, but it is conditional on the entire
“situation of Theorem 3.11” and its preceding IUT constructions. The repository
may cite this as the source's claim; it may not replace the all-place, Ind3, and
pointed transport data by an abstract same-pilot inequality without proving the
translation.

**Mochizuki, 2026 formalization report.** S. Mochizuki, *On the Formalization
of Inter-universal Teichmüller Theory: A Preliminary Progress Report* (April
2026), author
[PDF](https://www.kurims.kyoto-u.ac.jp/~motizuki/Formalization%20of%20IUT%20%282026-04%29.pdf).

- **PDF p. 3:** the Lean code is described as skeletal/bare-bones and not yet
  sufficiently fleshed out for public release.
- **PDF p. 4:** Stage 1 is IUT III Theorem 3.11 \(\Rightarrow\) Corollary 3.12;
  Stage 2 is Theorem 3.11 modulo IUT I--II; Stage 5 contains the numerical
  aspects. The report says the project is in the early skeletal part of Stage 1.
- **PDF pp. 9 and 11:** the displayed skeleton addresses
  “3.11.5 \(\Rightarrow\) 3.12”; the second/third triangles and their algorithmic
  parallel transport component are described as work in substantial progress.

This primary source itself rules out treating a public end-to-end Lean
formalization as presently available.

**Zhou.** Z.-P. Zhou, *The inter-universal Teichmüller theory and new
Diophantine results over the rational numbers. I*, arXiv:2503.14510v1,
[abstract](https://arxiv.org/abs/2503.14510),
[PDF](https://arxiv.org/pdf/2503.14510v1).

- **Theorem A1, PDF pp. 2--3:** for nonzero coprime integers \(a+b=c\), if
  \(\log|abc|\ge700\), the paper states

  \[
  \log|abc|\le3\log\operatorname{rad}(abc)
  +8\sqrt{\log|abc|}\log\log|abc|.
  \]

  Part (ii) gives the sharper displayed remainder once
  \(\log|abc|\ge3\cdot10^{13}\).
- **Corollary A2, p. 3:** for \(0<\varepsilon\le0.1\),

  \[
  |abc|\le\max\left\{
  \exp(400\varepsilon^{-2}\log\varepsilon^{-1}),
  \operatorname{rad}(abc)^{3+3\varepsilon}
  \right\}.
  \]
- **Proposition 1.9, PDF p. 12** says explicitly that its lower log-volume
  bound follows from the \(\mu_6\)-version of IUT III, Corollary 3.12.

These formulas are not independent substitutes for the missing IUT bridge; they
inherit the source dependence. This classification does not assert that IUT is
false. It records that the repository has not reconstructed the cited transport
chain with all of its premises.

## 5. Cannot be used as stated

### 5.1 A claimed unconditional infinite exceptional set

**Carella.** N. A. Carella, *Note on the Exceptional Set in the ABC
Conjecture*, arXiv:2608.16764v2,
[abstract](https://arxiv.org/abs/2608.16764v2),
[PDF](https://arxiv.org/pdf/2608.16764v2).
Theorem 1.1 (PDF p. 2) and Theorem 5.1 (pp. 12--14) are presented as yielding
infinitely many fixed-\(\varepsilon\) exceptional triples. The printed proof does
not establish that conclusion:

1. **Lemma 4.2, p. 8:** the claimed first-moment asymptotic (4.5)/(4.8)
   requires an error \(O(h\rho(u))\), but the calculation in (4.9) produces
   only \(O(h)\). Here \(\rho(u)\to0\), so \(O(h)\) cannot be absorbed into
   \(O(h\rho(u))\).
2. **Lemma 4.4, pp. 9--10:** the same issue occurs for the second moment:
   (4.19) is \(O(h)\), while (4.13)/(4.18) use
   \(O(h\rho(u)\log\log y)\).
3. **Theorem 4.1, pp. 10--12:** its variance calculation (4.21)--(4.24), and
   hence the selection step in Theorem 5.1, depend on those unsupported error
   absorptions.
4. **Theorem 5.1(iii), p. 12:** the stated
   \(w=A(\log\log y)^{1/2+\delta}\) omits the
   \(\log\log y\) center used in Theorem 4.1, and its counting premise is not
   stated for the smooth interval subset needed in the proof.
5. **Definition (1.2), p. 2:** \(E(x)\) is defined with \(c>x\), so it is
   decreasing in \(x\). The proof on p. 15 calls the sets monotonically
   increasing and uses that claim to infer an infinite union.

**Disposition:** the claimed disproof and the dependent smooth-number moment
argument cannot be imported. This finding is limited to those steps; it does not
show that every smooth-number approach is impossible.

### 5.2 Invalid asymptotic transfers in an alternative-quality preprint

In Sankaran, arXiv:2606.08416v1:

1. **Theorem 4.10, pp. 15--16** derives an upper bound for \(q_C\) from the
   one-sided lower bound for \(G\) in Lemma 4.11, but then asserts an exact
   boundary limsup. A matching lower estimate is absent. The exact limit cannot
   be used.
2. The later asymptotic part of **Theorem 4.13, pp. 17--18** invokes that exact
   boundary value and therefore inherits the gap.
3. **Lemma 4.12, pp. 16--17** proves decay of \(\eta\) under
   \(N=P N_0\) with \(N_0\) invariant; this fixes \(\omega\). Theorem 4.13 applies
   the estimate while assuming
   \(\omega_n\sim\delta(\log c_n)^\gamma\to\infty\), outside the lemma's
   premise. It also identifies \(\log P=O(\log c)\) with
   \(P\sim c^\kappa\), which is not an equivalence.
4. The resulting conclusion \(\limsup q_{\rm std}=0\) is impossible for
   nontrivial positive \(abc\) triples: since
   \(\operatorname{rad}(abc)\le abc<c^3\), one always has
   \(q_{\rm std}>1/3\).

**Disposition:** retain Theorem 3.12's Chen family and the exact identity
\(q_{\rm std}=\eta q_{\rm DGM}\); reject only the stated phase-boundary and
packing-decay transfers.

### 5.3 Approximation gain does not provide an \(abc\) theorem

**Müller--Taktikos.** K. Müller and M. Taktikos, *From ABC to Effective Roth
and Ridout Constants for Cubic Roots*, arXiv:2601.11376v2,
[abstract](https://arxiv.org/abs/2601.11376v2),
[PDF](https://arxiv.org/pdf/2601.11376v2).

- **Definition 2.6, PDF p. 13** defines the positive-\(d_n\) approximation-gain
  numerator using \(\log(kq_n^s)\), while **Theorem 2.7, pp. 13--14** evaluates
  the purported same quantity with numerator \(\log(p_n^3)\). The object changes
  inside the proof. The \(d_n<0\) case is only called analogous.
- **Theorem 2.8, pp. 14--15** obtains a one-sided asymptotic upper bound for
  \(k=2\) and then asserts equality of the limit and approach from below. It
  leaves the cutoff \(N\) unspecified and checks only the first convergent while
  saying the finite remainder is checked.
- **Theorem 2.9, p. 16** states
  \(c<L_\varepsilon\operatorname{rad}(abc)^{3+\varepsilon}\) and expressly
  treats it as conditional on using Mochizuki's results. Even if accepted, the
  exponent is far too weak for standard \(abc\).

**Disposition:** none of these claims supplies a reproducible bound for the
canonical defect or packet gate. This does not rule out studying a consistently
defined approximation-gain invariant.

## 6. Exact Pell gate synthesis

The checked Pell/Lucas sources combine as follows:

| source | what is proved | missing implication |
|---|---|---|
| Laniewski Thm. 4.31 | positive-density **composite-index** family with \(q>1\iff x_ny_n\) non-squarefree | non-squarefree is weaker than squarefull; prime seed \(\ell=7\) has \(239\parallel A_7B_7\) |
| Sanna Cor. 1.6--1.7 | exact valuation after the rank of apparition is known | first-rank valuation \(v_p(B_\ell)\) remains arbitrary |
| Yabuta/Carmichael Thm. 1 | a primitive divisor exists | primitive does not mean exponent one |
| Zhang Thm. 5.6 / Cor. 5.7 | local surjectivity of one normalized Lucas correction | no simultaneous companion control and no prime-index preservation |
| Ribenboim 2.22 | powerful \(A_n\) and \(B_n\) occur only finitely often | assumes standard \(abc\), hence circular here |
| Browning--Verzobio | power-saving counts in a broad log-general-type range | \(p=q=r=2\) is explicitly log-Fano and outside the theorem |

Therefore the missing statement has not moved: one needs either an eventual
prime \(p\mid A_\ell B_\ell\) with \(v_p=1\), uniformly for all sufficiently
large prime \(\ell\), or an unbounded prime-index family where every support
valuation is at least two. No audited theorem supplies either quantifier.

## 7. Formalization and citation priority

The highest-value additions, if the main development chooses to absorb them,
are:

1. a small parity-class module for Laniewski Proposition 2.6, Proposition 3.7,
   Corollary 3.9, and Theorem 4.3, with an explicit theorem equating
   \(\delta_{\rm tot}-\log(ab)\) to the repository numerator of \(X-Y\);
2. Theorem 4.12 as a source-labelled square-extraction interface, preserving
   \(K>1\), \(E_\varepsilon\ge0\), and the odd radical \(R_K\);
3. a regression theorem at \(\ell=7\):
   \(A_7=239\), \(B_7=169\), quality \(>1\), non-squarefree product, but
   \(239\parallel A_7B_7\), preventing the non-squarefree/squarefull conflation;
4. Baek--Lee's positive-characteristic counterexample as a test that every
   characteristic-free Mason interface keeps the derivative-zero branch;
5. source-labelled statements for BBLT Theorems 1.2--1.3 and
   Browning--Verzobio Theorem 1.2 only if an aggregate counting layer is needed;
   they should not be wired into a pointwise closure theorem;
6. IUT III Corollary 3.12 only behind a structure carrying the full Theorem
   3.11 situation, all places, the Ind1--Ind3 action, hull, and pointed transport.

The following should not be added as axioms or proved lemmas:

- “Laniewski Proposition 4.8 implies transgression at the amplified exponent”;
- “Pell \(q>1\) or non-squarefree implies simultaneous squarefullness”;
- “a primitive divisor has valuation one”;
- “fixed-\(S\) unit-equation finiteness gives a moving-\(S\) height bound”;
- the Carella fixed-\(\varepsilon\) infinite-exception conclusion;
- Sankaran's exact phase-boundary limsup or the derived
  \(\limsup q_{\rm std}=0\);
- Müller--Taktikos' approximation-gain bounds without first repairing the
  invariant and quantifiers;
- Zhou's explicit inequalities as independent of the IUT source chain.

## 8. Source list and version lock

The audit used the following exact versions or official copies:

1. Laniewski, arXiv:2609.00039v1:
   <https://arxiv.org/abs/2609.00039>.
2. Bernert--Browning--Lichtman--Teräväinen, arXiv:2410.12234v2:
   <https://arxiv.org/abs/2410.12234v2>.
3. Lichtman, arXiv:2505.13991v1:
   <https://arxiv.org/abs/2505.13991>.
4. Browning--Verzobio, arXiv:2608.24512v1:
   <https://arxiv.org/abs/2608.24512>.
5. Pasten, arXiv:2608.23559v1:
   <https://arxiv.org/abs/2608.23559>.
6. Pasten, CUBO 28(2) (2026):
   <https://doi.org/10.56754/0719-0646.2802.383>.
7. Hirata-Kohno--Kawashima--Poëls--Washio, arXiv:2211.14399v1:
   <https://arxiv.org/abs/2211.14399>.
8. Wang--Xiao, arXiv:2604.26497v1:
   <https://arxiv.org/abs/2604.26497>.
9. Baek--Lee, arXiv:2408.15180v2:
   <https://arxiv.org/abs/2408.15180v2>.
10. Lu--Lu--Wen, arXiv:2605.27876v1:
    <https://arxiv.org/abs/2605.27876>.
11. Sanna, official Fibonacci Quarterly PDF:
    <https://www.fq.math.ca/Papers1/54-2/Sanna02242016.pdf>.
12. Yabuta, official Fibonacci Quarterly PDF:
    <https://www.fq.math.ca/Scanned/39-5/yabuta.pdf>.
13. Ribenboim, official journal PDF:
    <https://publi.math.unideb.hu/load_doi.php?pdoi=10_5486_PMD_2001_2559>.
14. Zhang, arXiv:2608.30389v1:
    <https://arxiv.org/abs/2608.30389>.
15. Falk--Harrington--Jones, arXiv:2607.29329v1:
    <https://arxiv.org/abs/2607.29329>.
16. Sankaran, arXiv:2606.08416v1:
    <https://arxiv.org/abs/2606.08416>.
17. Bright, arXiv:2301.11056v2 / Canadian Mathematical Bulletin 67(2):
    <https://arxiv.org/abs/2301.11056v2>.
18. Letendre, arXiv:2607.07641v2:
    <https://arxiv.org/abs/2607.07641v2>.
19. Müller--Taktikos, arXiv:2601.11376v2:
    <https://arxiv.org/abs/2601.11376v2>.
20. Carella, arXiv:2608.16764v2:
    <https://arxiv.org/abs/2608.16764v2>.
21. Mochizuki, IUT III author version:
    <https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf>.
22. Mochizuki, April 2026 formalization progress report:
    <https://www.kurims.kyoto-u.ac.jp/~motizuki/Formalization%20of%20IUT%20%282026-04%29.pdf>.
23. Zhou, arXiv:2503.14510v1:
    <https://arxiv.org/abs/2503.14510>.

Any later arXiv revision should be re-audited theorem by theorem; page and
statement references here are locked to the versions above.
