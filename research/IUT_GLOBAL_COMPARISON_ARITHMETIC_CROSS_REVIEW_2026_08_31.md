# Independent arithmetic review of the next IUT global comparison gate

Author: ChatGPT, arithmetic-geometry review. Date: 2026-08-31.

Reviewed file: research/IUT_GLOBAL_COMPARISON_NEXT_GATE_2026_08_31.md.
Reviewed bytes: 48426. SHA256:
837a5874091ebb9f56a3dd6179f2732682db76a4f02e65cd248ed68a4c556641.

Scope: the mathematics of Sections 3--5, conditional on the explicitly
identified local equality (2.5) already proved in the earlier reports.
No original report, Lean file, TeX input, PDF, or accepted verification
artifact was changed.

**Conclusion: no substantive correction is required in the reviewed
arithmetic statements.** The fractional ideals, metrics, determinant
powers, descent, degree, and reference changes are genuine constructions
with the stated hypotheses. They do not establish membership in the
published possible-output family. In particular, the choices of other
finite components and infinite metrics remain part of this construction,
as the reviewed report explicitly says in Section 6.

## 1. Actual ideals, norms, and the product formula

Locations checked: Section 4.1, equations (4.1)--(4.2), and Section 4.2,
Theorem 4.1(1)--(2), especially the paragraphs proving (4.7)--(4.8).

The ideal

\[
 \mathfrak a_j=\prod_{w\mid p}\mathfrak p_w^{\eta_j}
\]

is an actual invertible fractional ideal of the actual Dedekind domain
\(\mathcal O_K\), even when \(\eta_j<0\). Its direct sum of \(N_j\)
copies is projective of rank \(N_j\). Localization gives the required
depth at every conjugate place above \(p\) and the standard lattice
elsewhere. The first-factor decomposition identifies the local tensor
algebra with \(N_j\) copies of \(K_w\); no global generator for the
individual ideal is required.

For \(\mathfrak a_w=\pi_w^b\mathcal O_{K_w}\), the norm of the rational
section 1 is \(q_w^b\), not \(q_w^{-b}\). The finite absolute value
\(q_w^{-\operatorname{ord}_w(x)}\) is the local norm absolute value.
Together with multiplicities 1 and 2 at real and complex places, its
product formula is exactly the one used in (4.1). Thus the normalized
degree with standard ambient infinite metrics is
\(-[K:\mathbb Q]^{-1}\log N(\mathfrak a)\).

In this Galois extension, if \(g\) places lie above \(p\), then
\([K:\mathbb Q]=gef\). The determinant calculation gives

\[
 \widehat{\deg}_K(\overline{\mathcal E_j})
 =-\frac{gfN_j\eta_j}{gef}\log p
 =-\frac{N_j\eta_j}{e}\log p.
\]

The standard coordinate wedge has norm 1 at every infinite place.
Changing the rational section introduces finite and infinite norm terms
which cancel by the product formula; it does not change the degree.
Consequently the zero infinite contribution used in this computation
does not amount to dropping the infinite metrics.

## 2. Local dimensions and source weights

Locations checked: Sections 3.2 and 3.5; (3.1)--(3.3), (4.4), and (4.8).

The \(N_j\) field factors each have residue size \(p^f\), so

\[
 \mu_{B_j}(\beta^{\eta_j}B_j)=p^{-fN_j\eta_j},\qquad
 D_j=efN_j.
\]

It follows that division by \(D_j\), and division of the global vector
bundle degree by \(N_j\), both give \(-\eta_j\log p/e\). The weights
\([K_w:\mathbb Q_p]/[K:\mathbb Q]\) of the conjugate places sum to 1.
There is no additional factor of \(d\), \(g\), or \(m_j\).

For a general field of moduli the tensor-word denominator in (3.2)
is correct: summing products over all ordered words gives
\((\sum_{v\mid p}h_v)^{m_j}=[F_0:\mathbb Q]^{m_j}\).
In the rational branch there is one selected-place word and its weight
is 1. The remaining procession operation is the average over labels,
not an additional division by the tensor length.

This agrees with the original passages independently reread:
Mochizuki IV, Proposition 1.4(i), PDF p.13, and Remark 1.7.1, p.17;
Mochizuki III, Proposition 3.9(i)--(iii), pp.116--117.
For the rational branch of Joshi III (9.10.3.1) and (9.10.5.1),
pp.124--125, the factor weight is \(1/d\). Indeed

\[
 \mu_A\!\left(\bigotimes_i V_i\right)
 =\prod_i\mu_{\mathcal O_E}(V_i)^{D/d}
\]

for full factor lattices. Its \(1/D\)-th power gives exactly the stated
product of factor volumes with exponent \(1/d\), relative to \(A\).
The report correctly does not call this positive root of a Haar measure
another additive Haar measure.

## 3. Integral determinant powers and actual descent

Locations checked: Theorem 4.1(3)--(4), equation (4.5), and
Section 4.5, Corollary 4.4, equations (4.12)--(4.13).

Here \(N_j=d^j\) for \(1\le j\le h\). A single explicit choice clearing
every denominator, including the descent denominator, is

\[
 C=ehd^h,\qquad
 \frac{C}{hN_j}=e\,d^{h-j}\in\mathbb Z_{>0}.
\]

Thus every determinant tensor power in (4.5) is an actual positive
integer power. Since \(\det\mathcal E_j=\mathfrak a_j^{N_j}\), the
weighted tensor has exponent \((C/h)\sum_j\eta_j\) at each \(w\mid p\).
Tensoring all the vector bundles by one metrized line \(Q\) contributes
the exponent
\(\sum_j N_jC/(hN_j)=C\), as asserted.

Galois stability alone would not prove integral descent of each
\(\mathfrak a_j\). The extra argument in Corollary 4.4 supplies exactly
what is needed:

\[
 p\mathcal O_K=\prod_{w\mid p}\mathfrak p_w^e,\qquad
 \mathfrak a_j^e=p^{\eta_j}\mathcal O_K.
\]

Multiplication of these rank-one lattices is isometric for the specified
ambient infinite norms. This proves the realified descent of
\(\overline{\mathfrak a_j}\), without asserting unpowered integral
descent. For the actual powered determinant, put

\[
 t=\frac{C}{eh}\sum_j\eta_j=d^h\sum_j\eta_j\in\mathbb Z.
\]

The full lattice is \(p^t\mathcal O_K\), with its standard ambient
metric. It is therefore the isometric pullback of the actual metrized
line \(p^t\mathbb Z\), including when \(t<0\). Its degree is
\(-t\log p\). This proves descent of the object rather than only
coincidence of degrees.

The properties just verified match the bookkeeping in Mochizuki III,
Remark 3.9.5(vii)(Ob3-1)--(Ob3-3), pp.132--133, independently reread
for this audit. They do not prove that this particular descended object
is the output of the source's indicated prime-strip comparison.

## 4. Exponents and the exact average

Locations checked: (2.3), Section 4.3, Corollary 4.2, equations
(4.9)--(4.10), and the finite check immediately following its proof.

Let \(t_j\) be the least positive residue of \(2j^2\) modulo \(\ell\).
Since \(\ell\) is odd prime and \(1\le j<\ell\), one has
\(1\le t_j\le\ell-1\). With \(e=15\ell\),

\[
 \left\lfloor\frac{2j^2}{\ell}+\frac{e-1}{e}\right\rfloor
 =\left\lfloor\frac{2j^2}{\ell}\right\rfloor+1=k_j.
\]

The strict inequalities \(t_j/\ell>1/e\) and \(t_j/\ell<1\)
justify the floor identity. Also \(2j^2/\ell<j\), so \(k_j\le j\).
Thus

\[
 \eta_j=e k_j-(e-1)(j+1)
 \le-e+j+1<0,\qquad
 \eta_j+e(j+1)=e k_j+j+1>0.
\]

The native volume is strictly positive and the standard-coordinate
volume is strictly negative; these signs refer to the specified
regions and references.

Writing \(R_\ell=\sum_j t_j\), elementary summation gives

\[
 \sum_j(j+1)=\frac{h(\ell+5)}4,\qquad
 \sum_j\left\lfloor\frac{2j^2}{\ell}\right\rfloor
 =\frac{\ell^2-1}{12}-\frac{R_\ell}{\ell}.
\]

Consequently

\[
 -\frac{\sum_j\eta_j}{eh}
 =\frac{\ell+1}{12}-\frac{\ell+5}{60\ell}
       +\frac{2R_\ell}{\ell(\ell-1)}.
\]

This proves the average in (4.10) directly; no asymptotic or
equidistribution of residues is needed.

For \(\ell=43\), the complete independent integer recalculation is:

| \(j\) | \(k_j\) | \(\eta_j\) | \(\eta_j+e(j+1)\) |
|---:|---:|---:|---:|
| 1 | 1 | -643 | 647 |
| 2 | 1 | -1287 | 648 |
| 3 | 1 | -1931 | 649 |
| 4 | 1 | -2575 | 650 |
| 5 | 2 | -2574 | 1296 |
| 6 | 2 | -3218 | 1297 |
| 7 | 3 | -3217 | 1943 |
| 8 | 3 | -3861 | 1944 |
| 9 | 4 | -3860 | 2590 |
| 10 | 5 | -3859 | 3236 |
| 11 | 6 | -3858 | 3882 |
| 12 | 7 | -3857 | 4528 |
| 13 | 8 | -3856 | 5174 |
| 14 | 10 | -3210 | 6465 |
| 15 | 11 | -3209 | 7111 |
| 16 | 12 | -3208 | 7757 |
| 17 | 14 | -2562 | 9048 |
| 18 | 16 | -1916 | 10339 |
| 19 | 17 | -1915 | 10985 |
| 20 | 19 | -1269 | 12276 |
| 21 | 21 | -623 | 13567 |

Their sums give \(R_{43}=473\), \(\sum k_j=164\),
\(\sum m_j=252\), and \(\sum\eta_j=-56508\). Hence the average is
\(18836\log p/4515\), exactly as printed. The explicit descent choice
above has \(C=645\cdot21\cdot1290^{21}\) and
\(t=-56508\cdot1290^{21}\).

## 5. Tensor-order correction

Location checked: Section 4.4, Proposition 4.3 and (4.11).

Let \(\delta=f(e-1)\) be the local discriminant exponent of
\(\mathcal O_E\). The trace Gram matrix for the tensor order \(A_j\)
is the Kronecker product of the factor Gram matrices. Therefore

\[
 v_p\operatorname{disc}(A_j)=m_jd^{m_j-1}\delta,\qquad
 v_p\operatorname{disc}(B_j)=d^{m_j-1}\delta.
\]

The index-discriminant relation gives
\(v_p[B_j:A_j]=(m_j-1)d^{m_j-1}\delta/2\).
Since \(\mu_A=[B:A]\mu_B\), its normalized contribution is
\((m_j-1)\kappa\log p/2\), with the positive sign in (4.11).
This is not the coordinate factor \(p^{m_j}\). For \(\ell=43\), its
label average is \(3542\log p/645\).

The separate relative-determinant paragraph after (4.8) is also correct:
restriction-of-scalars discriminant and archimedean covolume factors of
the fixed reference cancel between equal-rank numerator and reference.
It does not erase the \(A_j/B_j\) index when those are different local
references.

## 6. Native and standard coordinates; finite support

Locations checked: Section 5.1, Proposition 5.1, equations
(5.1)--(5.2), and Section 5.2, Proposition 5.2.

Each of the \(m_j\) entries changes by the same rational scalar \(p\).
Linearity of the allowed arrows and multilinearity of the tensor
operation therefore scale every tensor image by \(p^{m_j}\).
The determinant on the \(D_j\)-dimensional space has absolute value
\(p^{-m_jD_j}\). With \(B_j\) fixed, the normalized change is
\(-m_j\log p\).

For the constructed global bundles, multiplication by \(p^{m_j}\)
is a unit away from \(p\). With ambient infinite metrics fixed it changes
degree per rank by exactly \(-m_j\log p\). With the infinite norms
transported instead, the determinant norm changes by
\(p^{-m_jN_j}\), whose normalized infinite contribution cancels the
finite degree change. Both claims in Proposition 5.1 are correct.
For \(\ell=43\), the fixed-reference average shift is \(-12\log p\);
the resulting average is \(-35344\log p/4515\).

For Proposition 5.2, outside the stated finite exceptional set the
completion is unramified, \(I=\mathcal O_E\), and
\(p^{-1}\log(1+p)\) is a rational \(p\)-adic unit. An integral
automorphism preserves its nonzero class modulo \(pI\); in an
unramified field this is precisely the unit condition. Every tensor
component is a unit, and the native \(B\)-span is \(B\).
The standard-coordinate hull is \(p^{m_j}B\). Its normalized logarithm
is \(-m_j\log p\), regardless of the varying local degree.
Summing over infinitely many such primes gives \(-\infty\). This
cannot be a finite-support fractional-ideal modification of a fixed
bundle. The restriction to the declared native branch, and the warning
that a new almost-everywhere reference is a different restricted
product, are essential and are present in the report.

## 7. Source-membership and sign boundaries

Sections 3.1, 3.3--3.6 distinguish local upper containers, actual source
families, hulls, and the 1-column/global comparison. None of the degree
computations reviewed here supplies that family membership. In
particular, a global bundle of the chosen rank with standard lattices
away from \(p\) is not yet an identification with all the published
tensor packets at those other places; its chosen infinite metrics are
likewise not a proof about their archimedean containers.

The literal sign test of Section 3.7 is valid as written. Joshi III,
PDF p.128, explicitly relates the bars to the usual absolute value
of a nonpositive real logarithm, and its final displayed right side
has the leading minus sign recorded in (3.8). For a nonempty bad set
the right side is positive and the left side nonpositive. This checks
that literal formulation only; it is neither an abc counterexample
nor a refutation of the differently signed comparison in Joshi IV.

The reviewed file's distinctions are therefore retained: the actual
arithmetic-bundle construction and its exact degree pass this review;
published-family membership and the indicated Ind3/global comparison
remain separate mathematical requirements.
