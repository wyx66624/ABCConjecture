# Native pilot points, multiplicative families, and Galois transport

Author: ChatGPT  
Date: 2026-08-30  
Status: mathematical continuation; not an unconditional ABC proof or an IUT counterexample

## 1. Results and scope

This report completes two positive local interfaces which were previously
left open.

First, if \(a\) is integral and
\(\lambda(a)=p^{-1}\log(1+pa)\), then **after each allowed integral
Galois transport**, \(\lambda(a)\) and \(a\) still generate the same
native principal ideal. This is stronger than comparing their valuations
before transport: the transport need not be linear over the local field.
It identifies the module hull of a specified crystalline point orbit
with that of the corresponding specified root point orbit.

Second, there is an exact crystalline realization of the **whole**
multiplication image \(aI\): the family of units \(1+paI\), mapped by
\(p^{-1}\log_{\rm BK}^{\rm std}\), is precisely \(aI\).
This is a larger family than the single class of \(1+pa\).
The difference cannot be suppressed. In the degree-210 tame example,
the three whole-family hulls are exactly one factor of \(p^{-1}\)
larger than the corresponding three point hulls.

A further trace-dual argument first places the intermediate, native
pre-hull source \(aB_m\) between these two explicitly computed families.
Using the trace dual of the maximal order, not just that of the tensor
order, strengthens this to an exact equality: in the attained examples,
the pre-hull orbit has the point hull, not the larger whole-product
hull. Thus it computes **one specified source set**. It does not
identify this restricted local computation with every possible image
in the global construction.

The source comparison retains four distinct objects:

1. a specified point \(a\), or its crystalline replacement
   \(\lambda(a)\);
2. the action of multiplication by \(a\) on \(I\), with image \(aI\);
3. the corresponding principal \(B_m\)-ideal **before** transport;
4. the \(B_m\)-module hull **after** transport.

We also keep standard Bloch--Kato logarithms separate from logarithms
divided by \(p\), and squared powers of a root separate from a change
of the absolute value attached to a marking.

## 2. Fixed local objects and arrows

Let \(p>2\), and let \(E/\mathbf Q_p\) be a finite Galois extension
with ramification index \(e\) satisfying
\[
                  2\leq e\leq p-2.
\]
Write \(v(p)=1\), \(\mathcal O=\mathcal O_E\), and
\(\mathfrak m=\pi\mathcal O\), where \(v(\pi)=1/e\). Put
\[
 \kappa=\frac{e-1}{e},\qquad
 I=p^{-1}\log(\mathcal O^\times)=p^{-1}\mathfrak m
   =\pi^{1-e}\mathcal O,\qquad
 u=\frac{\log(1+p)}p.
 \tag{2.1}
\]
The equality of fractional ideals in (2.1) does not require
\(\pi^e=p\): their ratio is a unit. The tame different is
\(\mathfrak D_{E/\mathbf Q_p}=\mathfrak m^{e-1}\), so \(I\) is also
the inverse different. The factor \(2\) in the convention
\((2p)^{-1}\log(\mathcal O^\times)\) used in some IUT sources is
a \(\mathbf Z_p^\times\)-factor and has no effect on the ideals below.

The logarithm and exponential are mutually inverse, valuation-preserving
maps on \(\mathfrak m\) and \(1+\mathfrak m\). Indeed
\(1/e>1/(p-1)\), which places the whole ideal \(\mathfrak m\)
inside their common strict convergence disk. Prime-to-\(p\) torsion
is killed by the logarithm; there is no nontrivial \(p\)-power torsion
in \(1+\mathfrak m\) in this range.

For \(m\geq1\), set
\[
 T_m=E^{\otimes_{\mathbf Q_p}m},\qquad
 A_m=\mathcal O^{\otimes_{\mathbf Z_p}m},\qquad
 B_m=\text{the integral closure of }A_m\text{ in }T_m.
 \tag{2.2}
\]
Thus \(T_m\) is a product of \(d^{m-1}\) copies of \(E\), where
\(d=[E:\mathbf Q_p]\), and \(B_m\) is the product of their rings of
integers. Every embedding into such a component preserves the native
valuation \(v(p)=1\). A pure tensor of nonzero elements has no zero
component, and its componentwise valuation is the sum of their valuations.

If every component has valuation \(t/e\), its principal \(B_m\)-ideal
is denoted by \(\pi^tB_m\). This notation records a product fractional
ideal; it does not assert that all component coefficients are equal.

Let \(\Gamma\) denote the actual integral Kummer actions supplied by
outer automorphisms of \(G_E\), allowing an integral Tate-module
identification. These actions preserve \(I\), hence are
\(\mathbf Z_p\)-linear automorphisms of \(I\), with unique
\(\mathbf Q_p\)-linear extensions to \(E\). They are not assumed to
exhaust \({\rm GL}_{\mathbf Z_p}(I)\).

Most statements in Sections 4--6 hold for any family
\[
   \mathcal G_m\subseteq
   {\rm Aut}_{\mathbf Z_p}(I)^m
\]
of tuples of such arrows. In particular, they hold with the coherence
requirement that all entries are the same \(F\in\Gamma\).
When an identity input is used, the identity tuple is required to
belong to \(\mathcal G_m\).

For \(S\subseteq E^m\), define the raw orbit module hull
\[
 \mathscr H_{\mathcal G_m}(S)=
 \overline{\operatorname{span}_{B_m}
 \{F_1x_1\otimes\cdots\otimes F_mx_m:
      (F_1,\ldots,F_m)\in\mathcal G_m,\ (x_1,\ldots,x_m)\in S\}} .
 \tag{2.3}
\]
The closure is in the native topology of \(T_m\). In the explicit
calculations below the span is already a closed product fractional ideal.
Taking a closed \(\mathbf Z_p\)-convex hull **in \(E^m\) before tensoring**
is a separate operation; we state explicitly when a result survives it.

The full-Galois, rather than merely pro-\(p\), realization of the
operators used in Section 7 was established in
[the full-Galois construction](IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md),
Sections 3--7, and in
[the degree-210 continuation](IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md),
Sections 4, 8--9.
Their proofs use the full relative Jannsen--Wingberg presentation,
not an assumed lift from a pro-\(p\) quotient.

## 3. Primary-source object ledger

The following locators refer to the archived versions, not to an
unpinned future revision.

| Source and location | Object or operation relevant here |
|---|---|
| Joshi III v4, PDF p.33, (4.2.2.2) | At bad places, the absolute values attached to the labels have a \(j^2\) scaling relationship. |
| Joshi III v4, PDF pp.108--109, Sections 9.5.2 and 9.6.2 | The Tate class is replaced by the crystalline Kummer class of \(1+p\,q^{1/(2\ell)}\). The displayed defining class has no \(j^2\) in its exponent. |
| Joshi III v4, PDF p.109, Remark 9.6.2.1 | An optional family is printed with \(q^{j/(2\ell)}\). That displayed exponent is \(j\), not \(j^2\). |
| Joshi III v4, PDF p.110, (9.7.1.1), (9.7.2.1)--(9.7.2.2) | The exponential, its purported inverse, and the coefficient divided by \(p\) must be distinguished; see Section 4. |
| Joshi III v4, PDF pp.112, 114--115, Proposition 9.7.5.1 and Theorem-Definition 9.8.1.1 | The chosen classes and the background class \(1+p\) are collated by the stated topological isomorphisms, followed by the stated convex-hull operation. |
| Joshi III v4, PDF pp.116, 121, Remarks 9.8.1.2 and 9.9.7 | The author distinguishes his crystalline classes from Mochizuki's multiplicative action and proposes a comparison using the norm calculation. |
| Joshi III v4, PDF pp.125--126, Section 9.10.7 | The holomorphic module hull uses the product integral ring of the field components. |
| Mochizuki I, PDF p.71, Example 3.2(iv) | The local root is \(\underline q=q^{1/(2\ell)}\), up to the specified torsion ambiguity. |
| Mochizuki III, PDF pp.107--108, 112, Example 3.6(ii), Proposition 3.7(v), Definition 3.8(i) | Pilot objects have a local fractional-ideal realization generated by the splitting-monoid elements. |
| Mochizuki III, PDF pp.153--154, Theorem 3.11(i)(a),(b) | The represented monoid is both a subset of a tensor carrier and equipped with a multiplicative action on that carrier. These are additional data, not interchangeable types. |
| Mochizuki IV, PDF pp.10--11, Proposition 1.2; pp.26--28, Theorem 1.10, Steps (iv)--(v) | The local containing calculation has input \(\phi(p^\lambda B_m)\), where \(\phi\) preserves the tensor product of the logarithmic lattices. At a bad place \(\lambda=v(\underline q^{\,j^2})\). |
| Joshi IV v2, PDF pp.65--69, Theorem 6.10.1, Remark 6.10.2, Proposition 6.10.9 | The lower and upper claims involve the stated global loci, marking comparison, and normalizations. Remark 6.10.2 expressly restricts direct comparison of quantities attached to different arithmeticoids. |

The printed procession indexing in Joshi III p.114 contains
\(j+1\)/\(j+2\) inconsistencies. The explicit local blocks in this report
use \(m=j+1\), with labels \(0,\ldots,j\), as in Mochizuki IV p.27.
This convention is declared rather than silently inferred from a
misindexed display.

Exact source URLs and local copies:

- [Joshi III, arXiv 2401.13508v4](https://arxiv.org/pdf/2401.13508v4),
  archived at
  [Joshi_III_2401.13508v4.pdf](sources/iut_2026_08_30/Joshi_III_2401.13508v4.pdf).
- [Joshi IV, arXiv 2403.10430v2](https://arxiv.org/pdf/2403.10430v2),
  archived at
  [Joshi_IV_2403.10430v2.pdf](sources/iut_2026_08_30/Joshi_IV_2403.10430v2.pdf).
- [Mochizuki I](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20I.pdf),
  archived as
  [the May 2020 copy](sources/continuation_2026_08_30/Mochizuki_IUT_I_May2020.pdf).
- [Mochizuki III](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf),
  archived as
  [the May 2020 copy](sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf).
- [Mochizuki IV](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20IV.pdf),
  archived as
  [the April 2020 copy](sources/continuation_2026_08_30/Mochizuki_IUT_IV_April2020.pdf).

Sections 4--8 are mathematical statements about explicitly defined
local objects. The ledger does not declare all of these objects to be
equal in the original global constructions.

## 4. The two logarithmic scales

Write \({\rm Kum}\) for the integral Kummer map on principal units,
and let \(\log_{\rm BK}^{\rm std}\) be inverse to the usual rational
Bloch--Kato exponential. Thus, on its convergence disk,
\[
 \exp_{\rm BK}(x)={\rm Kum}(\exp x),\qquad
 \log_{\rm BK}^{\rm std}({\rm Kum}(1+pa))=\log(1+pa).
 \tag{4.1}
\]
For arbitrary \(x\in E\), the first formula is extended as
\(p^{-n}{\rm Kum}(\exp(p^nx))\) for sufficiently large \(n\).
The divisions here are scalar operations in rational cohomology.

Define the separate coordinate map
\[
            \rho=p^{-1}\log_{\rm BK}^{\rm std}.
 \tag{4.2}
\]
Then the class \(\xi_a={\rm Kum}(1+pa)\) has coordinate
\[
                    \rho(\xi_a)=\lambda(a)
                      :=\frac{\log(1+pa)}p.
 \tag{4.3}
\]

**Proposition 4.1.**
For nonzero \(a\in\mathcal O\), the following three statements cannot
hold together: the exponential is the standard one in (4.1), the
logarithm is its inverse, and the logarithm of the unscaled class
\({\rm Kum}(1+pa)\) is \(\lambda(a)\).

**Proof.**
The convergent logarithm has the nonzero leading term \(pa\), so
\(\xi_a\ne0\) in rational cohomology. By linearity and (4.1),
\[
             \exp_{\rm BK}(\lambda(a))=p^{-1}\xi_a\ne\xi_a.
\]
The inequality follows because rational cohomology is a
\(\mathbf Q_p\)-vector space and \(p^{-1}-1\ne0\).
Thus (4.3) is a valid normalized coordinate formula, but not the
inverse formula for the original exponential and unscaled class.
\(\square\)

This is the precise normalization conflict in the three cited displays
of Joshi III p.110, when its exponential display is interpreted with
the standard cohomological scalar meaning. It can be repaired locally
by explicitly using \(\rho\), or by rescaling the cohomology class and
stating that change. These are different conventions; their volumes
must be transported accordingly.

Every \(\mathbf Q_p\)-linear Kummer transport commutes with multiplication
by \(p\). Consequently, with exactly \(m\) entries and the same arrows,
\[
                 H^{\rm std}=p^m H^\rho .
 \tag{4.4}
\]
Here every entry, including each background entry, has been rescaled.
For Haar measure \(\mu_B(B_m)=1\), let
\[
            D=d^m,\qquad V_B(H)=D^{-1}\log\mu_B(H).
 \tag{4.5}
\]
Multiplication by \(p^m\) has determinant \(p^{mD}\) over
\(\mathbf Q_p\); hence
\[
                 V_B(H^{\rm std})=V_B(H^\rho)-m\log p.
 \tag{4.6}
\]
If instead \(\mu_A(A_m)=1\), then
\[
 V_A(H)=V_B(H)+D^{-1}\log[B_m:A_m].
 \tag{4.7}
\]
The constant in (4.7) cancels between two sets measured with the same
reference order. It must not be silently omitted when changing the
reference order on only one side.

## 5. The root-point/crystalline-point bridge after every arrow

**Proposition 5.1.**
Let \(0\ne a\in\mathcal O\), \(r=v(a)\), and
\[
                         k=\lfloor r+\kappa\rfloor .
\]
For every \(F\in{\rm Aut}_{\mathbf Z_p}(I)\),
\[
              v(F\lambda(a))=v(Fa),\qquad v(Fu)=v(F1).
 \tag{5.1}
\]
This includes every actual integral Kummer arrow.

**Proof.**
By the definition of \(k\),
\[
          a\in p^k I\setminus p^{k+1}I.
 \tag{5.2}
\]
The logarithm expansion gives
\[
 \lambda(a)-a
   =\sum_{n\ge2}(-1)^{n+1}\frac{p^{n-1}a^n}{n}.
\]
For \(p>2\) and \(n\ge2\), \(v_p(n)\le n-2\). It follows that
each summand has valuation at least \(1+2r\), and therefore
\[
 v(\lambda(a)-a)\ge1+2r
                    \ge k+1-\kappa.
 \tag{5.3}
\]
The last inequality uses \(k\le r+\kappa\) and \(r\ge0\).
Thus \(\lambda(a)-a\in p^{k+1}I\).

The map \(F\) preserves each \(p^nI\), in both directions. Equations
(5.2)--(5.3) consequently imply
\[
 v(Fa)<k+1-\kappa,\qquad
 v(F(\lambda(a)-a))\ge k+1-\kappa.
\]
The strict ultrametric inequality now yields the first equality in
(5.1). Apply the same argument with \(a=1\) and \(k=0\) to obtain
the second. No \(E\)-linearity or multiplicativity of \(F\) was used.
\(\square\)

**Corollary 5.2.**
For each single tuple of allowed arrows \((F_1,\ldots,F_m)\),
the two tensors
\[
 F_1\lambda(a)\otimes F_2u\otimes\cdots\otimes F_mu,\qquad
 F_1a\otimes F_2 1\otimes\cdots\otimes F_m1
 \tag{5.4}
\]
generate exactly the same principal \(B_m\)-ideal. Consequently,
\[
 \mathscr H_{\mathcal G_m}
       (\{(\lambda(a),u,\ldots,u)\})
 =
 \mathscr H_{\mathcal G_m}
       (\{(a,1,\ldots,1)\}).
 \tag{5.5}
\]

**Proof.**
In every field component of \(T_m\), the two nonzero products in
(5.4) have equal valuation by Proposition 5.1. Their componentwise
ratio is a unit of that component's integer ring. Their ratio in
\(T_m\) is therefore a unit of \(B_m\), proving equality of the
principal ideals. Taking their unions, \(B_m\)-spans, and closures
proves (5.5). \(\square\)

Root-of-unity ambiguities do not require an arrow to commute with
arbitrary \(\mathcal O^\times\). Apply the proposition separately
to each allowed integral input \(\zeta a\), then take the stated
union. The proof does not replace \(F(\zeta a)\) by \(\zeta F(a)\).

**Convex-hull boundary.**
Equation (5.5) concerns the raw orbit module hull in (2.3).
The tensor map \(E^m\to T_m\) is not additive in the tuple as a whole.
Therefore equality of the individual principal tensor ideals does
not, without a further argument, establish equality after taking
unrelated product convex hulls first. In the degree-210 calculation
below, common attaining points and common closed product containers
provide that further argument explicitly.

This bridge identifies point hulls. It does not assert equality of
the transported points themselves, or equality with the image of an
entire multiplication operator.

## 6. The exact whole-family bridge and a strict distinction

**Proposition 6.1.**
For \(0\ne a\in\mathcal O\), put
\[
                         U_a=1+paI=1+a\mathfrak m .
 \tag{6.1}
\]
This is a multiplicative subgroup of the principal units, and
\[
             \rho({\rm Kum}(U_a))=aI,\qquad
 \log_{\rm BK}^{\rm std}({\rm Kum}(U_a))=paI
 \tag{6.2}
\]
as actual sets.

**Proof.**
The ideal \(a\mathfrak m\) has valuation at least
\(r+1/e>1/(p-1)\). The logarithm and exponential are inverse on
this ideal and its associated unit group and preserve valuations.
Hence
\[
                    \log(1+paI)=paI.
\]
In particular, \(1+paI\) is closed under multiplication and inversion.
Alternatively this follows directly from the positive valuation of
the ideal \(paI\).
Formula (4.1) gives the second equality of (6.2), and division by
\(p\) gives the first. More explicitly, for each \(z\in aI\),
\(\exp(pz)\in U_a\) and
\(\rho({\rm Kum}(\exp(pz)))=z\). This proves surjectivity as well
as containment. \(\square\)

For \(a=1\), \(U_1=1+\mathfrak m\) is the whole principal-unit
group. It is not the singleton \(1+p\).

Taking products in (6.2) gives an exact realization of
\[
                          aI\times I^{m-1}.
 \tag{6.3}
\]
Since this equality is before transport and before hulls, applying
the same permitted arrows, taking the same product convex hull,
then tensoring and taking the same \(B_m\)-module hull all preserve
the equality. This is a valid cohomological realization of the
specified multiplication image. It is an explicit enlargement of
the single-class recipe, not a claim that the source has already
performed this enlargement.

**Proposition 6.2.**
Suppose the identity tuple is allowed. Set
\[
 \begin{split}
 H_{\rm pt}(a)&=
   \mathscr H_{\mathcal G_m}(\{(\lambda(a),u,\ldots,u)\}),\\
 H_{\rm sat}(a)&=
   \mathscr H_{\mathcal G_m}(aI\times I^{m-1}).
 \end{split}
 \tag{6.4}
\]
If \(r=v(a)<k=\lfloor r+\kappa\rfloor\), then
\[
                         H_{\rm pt}(a)\subsetneq H_{\rm sat}(a).
 \tag{6.5}
\]
The same strict inclusion holds if both constructions first take
the closed \(\mathbf Z_p\)-convex hull of their product inputs.

**Proof.**
The expansion in Proposition 5.1 shows
\(\lambda(a)/a\in\mathcal O^\times\). Also \(u\in\mathcal O\subset I\).
Thus the point input is contained in (6.3), and the corresponding
hull is contained in \(H_{\rm sat}(a)\).

Every point input after an allowed arrow lies in
\[
                          p^kI\times I^{m-1}.
 \tag{6.6}
\]
Consequently its tensor, and its \(B_m\)-span and closure, have
valuation at least \(k-m\kappa\) in every component.
The larger family at the identity contains
\[
             (a\pi^{1-e},\pi^{1-e},\ldots,\pi^{1-e}).
 \tag{6.7}
\]
Its tensor has valuation \(r-m\kappa<k-m\kappa\) in every
component. It cannot lie in the point hull, proving strictness.
For the additional convex-hull assertion, (6.6) is already a closed
\(\mathbf Z_p\)-convex product lattice, while (6.7) remains in the
enlarged larger input. The same separation still applies.
\(\square\)

Thus there is a strict counterexample to the precise local shortcut
that replaces the image of a whole multiplication operator on \(I\)
by the single crystalline class merely because their displayed
coefficient norms agree. It is not a counterexample to a global IUT
theorem: that would require showing that the theorem asserts this
particular identification with these particular scales and arrows.

## 7. Exact point and whole-family hulls at \(p=139\)

Let
\[
 p=139,\quad \ell=7,\quad
 b_0\in\mathbf Q_p,\quad v(b_0)=1,\quad
 q=b_0^2,\quad
 K_0=\mathbf Q_p(\mu_{210}),\quad
 \pi^{105}=b_0,\quad E=K_0(\pi).
 \tag{7.1}
\]
The extension \(K_0/\mathbf Q_p\) is unramified of degree \(2\):
\(139\) has order \(2\) modulo \(210\).
The Eisenstein extension \(E/K_0\) has degree \(105\), and
\(K_0\) contains \(\mu_{105}\). Thus \(E/\mathbf Q_p\) is Galois,
with
\[
                  (d,e,f)=(210,105,2),\quad
                  I=\pi^{-104}\mathcal O,\quad
                  \kappa=104/105 .
 \tag{7.2}
\]
This field is the full local 210-torsion field of a split Tate
curve with parameter \(q\). The assertion also applies to actual
split Frey curves with full rational 2-torsion and \(v(q)=2\);
their rational square root \(b_0\) was proved in Section 11 of
[the degree-210 report](IUT_TATE_210_MINIMUM_LAYER_ARITHMETIC_2026_08_30.md).
It is not necessary to prescribe the exact value \(q=p^2\).

Write
\[
 r_0=\pi^{15}=q^{1/14},\qquad
 a_s=r_0^s,\qquad
 \tau_s=\lambda(a_s),\qquad s\in\{1,4,9\}.
 \tag{7.3}
\]
For \(s=j^2\), set \(m=j+1\) and
\[
 n_s=\lfloor s/7\rfloor,\qquad
 k_s=\lfloor s/7+104/105\rfloor,\qquad
 T_s=\tau_s/p^{k_s},\qquad
 X_s=a_s\pi^{-104}/p^{n_s}.
 \tag{7.4}
\]
The following numerical data are exact:

| \(s\) | \(m\) | \(n_s\) | \(k_s\) | \(v(T_s)\) | \(v(X_s)\) |
|---|---:|---:|---:|---:|---:|
| \(1\) | 2 | 0 | 1 | \(-90/105\) | \(-89/105\) |
| \(4\) | 3 | 0 | 1 | \(-45/105\) | \(-44/105\) |
| \(9\) | 4 | 1 | 2 | \(-75/105\) | \(-74/105\) |

All six vectors belong to \(\pi I\setminus pI\).
The \(X_s\) have exact trace zero, since
\(105\nmid15s-104\) and the Kummer conjugates over \(K_0\)
sum to zero, including for negative exponents.
For the other three vectors, direct norm and trace computation gives
\[
 {\rm Tr}_{E/\mathbf Q_p}(T_s)
       =\frac{30\log(1+p^7b_0^s)}{p^{k_s+1}},
 \qquad
 v({\rm Tr}(T_s))=s+6-k_s\in\{6,9,13\}.
 \tag{7.5}
\]
Indeed the degree-seven product of the relevant conjugates of
\(1+pa_s\) is \(1+p^7b_0^s\); there are fifteen repetitions
over \(K_0\), and the latter field has degree two over \(\mathbf Q_p\).
The logarithm on the right has its leading-term valuation.
Also
\[
              {\rm Tr}(u)=210u\in\mathbf Z_p^\times.
 \tag{7.6}
\]

Here the tame trace formulas imply
\({\rm Tr}(I)={\rm Tr}(\pi I)=\mathbf Z_p\).
For example \(\mathcal O\subset\pi I\), and \(1/210\in\mathcal O\)
has trace one. The upper containment follows by writing \(I\)
in its \(K_0\)-basis with powers \(\pi^{-104},\ldots,1\):
only the constant power can have nonzero trace over \(K_0\).

### 7.1 One actual arrow for both families

The integral-basis and full-presentation arguments in the earlier
reports give a basis
\[
 I=\mathbf Z_p a\oplus\mathbf Z_p b\oplus W_{\mathbf Z_p},
 \qquad
 \ker({\rm Tr}|_I)=\mathbf Z_p a\oplus W_{\mathbf Z_p},
 \tag{7.7}
\]
where \(W\) has rank \(208\), carries the indicated unimodular
alternating handle form \(\omega\), and \({\rm Tr}(b)\) is a unit.
The letter \(a\) in (7.7) is a basis vector, not the root \(a_s\).
The following canonical linear actions have individual full-Galois
lifts:
\[
 \begin{array}{lll}
 C_c:&b\longmapsto b+ca,&a,W\text{ fixed},\\
 N_w:&b\longmapsto b+w,\quad
      x\longmapsto x+\omega(w,x)a\ (x\in W),&a\text{ fixed},\\
 S_z:&x\longmapsto x+\omega(z,x)z\ (x\in W),&a,b\text{ fixed}.
 \end{array}
 \tag{7.8}
\]
Integer representatives suffice for \(c,w,z\) used below.
The cross-handle word supplies a basis direction of \(N_w\);
handle conjugation and the central correction
\(N_wN_v=C_{\omega(w,v)}N_{w+v}\) on the linear images supply
the indicated integer directions. The individual \(S_z\) lifts
come from boundary-preserving handle automorphisms. These facts
concern the full presentation, retaining its distinguished
\(x_1^{p^s}\) term. No homomorphic section from a symplectic group
to an outer Galois group, and no realization of all linear
automorphisms of \(I\), is assumed.

**Proposition 7.1.**
There is one and the same actual integral Kummer arrow \(F\) such that
\[
                 v(Fu)=v(FT_s)=v(FX_s)=-104/105
                   \quad(s=1,4,9).
 \tag{7.9}
\]

**Proof.**
Work in \(V=I/pI\), and put \(L=\pi I/pI\). Then
\(\dim_{\mathbf F_p}V=210\) and \(L\) has codimension two.
The reduction of the \(b\)-coefficient of \(u\) is nonzero by
(7.6)--(7.7), whereas that of all six \(T_s,X_s\) is zero by
(7.5). Each of these six vectors is a nonzero vector of \(L\).

Let \(\sigma\) be the actual field automorphism
\(\pi\mapsto\zeta_7\pi\), fixing \(K_0\).
Modulo \(pI\), \(T_s\) has leading term \(a_s/p^{k_s}\):
the logarithmic tail belongs to \(pI\) after this division.
The corresponding character of \(\sigma\) is \(\zeta_7^s\).
The character of \(X_s\) is \(\zeta_7^{15s-104}
 =\zeta_7^{s+1}\).
These exponents are respectively \(1,4,2\) and \(2,5,3\)
modulo seven, so none is zero.

Since \(\mu_7\cap\mathbf F_{139}^\times=\{1\}\), each of the
six projective orbits under \(1,\sigma,\ldots,\sigma^6\)
has length seven. To check this directly, if two nonzero
residue vectors differ by a scalar in \(\mathbf F_p^\times\),
the corresponding difference between a power of \(\zeta_7\)
and that scalar would annihilate a nonzero vector. Unless their
residues agree, that difference is a unit and cannot do so.
The residues agree only for the trivial power of \(\zeta_7\).

Each vector therefore has at most one choice of \(h\in\{0,\ldots,6\}\)
for which \(\sigma^h\) places it on the line \(\mathbf F_p a\).
There are at most six forbidden choices in total. Choose a common
remaining \(h\). It preserves \(L\) and the trace, and it fixes \(u\).
After this common inertia action, all six vectors have nonzero
\(W\)-components \(w_1,\ldots,w_6\).

If \(a\notin L\), choose \(w\in W\) with
\(\omega(w,w_i)\ne0\) for every \(i\). The six forbidden
hyperplanes contain at most \(6p^{207}<p^{208}\) vectors.
The lift \(N_w\) sends every one of the six vectors outside \(L\).
Their \(b\)-coefficients remain zero. If its image of \(u\)
is still in \(L\), compose with \(C_1\); otherwise do not.
The \(C_1\) step then moves \(u\) outside \(L\) and leaves
the other six projections unchanged.

If \(a\in L\), the projection \(\eta:W\to V/L\) is surjective.
Indeed the trace is surjective on \(L\); subtracting an element
of \(L\) of the same trace reduces any vector to
\(\mathbf F_p a\oplus W\), without changing its image in \(V/L\).
Choose \(z\in W\) outside \(\ker\eta\) and all six hyperplanes
\(\omega(z,w_i)=0\). The forbidden union has size at most
\[
                       p^{206}+6p^{207}<p^{208}.
\]
The lift \(S_z\) moves all six vectors outside \(L\), since
their former projections were zero. If \(S_z(u)\) is still
in \(L\), choose a basis direction \(w\) with \(\eta(w)\ne0\)
and apply \(N_w\). Its change of the projection of \(u\) is
its nonzero \(b\)-coefficient times \(\eta(w)\). Its changes
to the other six projections are zero, because their
\(b\)-coefficients are zero and \(a\in L\).

We have obtained one full-Galois canonical action \(M\) sending
all seven vectors outside \(L\), which means to valuation
\(-104/105\).
As proved via the local Tate evaluation pairing in Section 7 of
the full-Galois report, the Kummer action associated to an arrow
has the form \(cM^{-1}\), with \(c\in\mathbf Z_p^\times\).
Choose the inverse full-Galois arrow. Its Kummer action is a
unit times \(M\), and therefore has all the same valuations
simultaneously. This proves (7.9). \(\square\)

### 7.2 The exact hulls

Use the diagonal family \(F\in\Gamma\) in (2.3), and set
\[
 \begin{split}
 P_j^\rho&=
  \mathscr H_\Gamma(\{(\tau_{j^2},u,\ldots,u)\}),\\
 S_j^\rho&=
  \mathscr H_\Gamma(a_{j^2}I\times I^{m-1}),\qquad m=j+1 .
 \end{split}
 \tag{7.10}
\]

**Proposition 7.2.**
For \(j=1,2,3\),
\[
 P_j^\rho=\pi^{105k_{j^2}-104m}B_m,\qquad
 S_j^\rho=\pi^{105n_{j^2}-104m}B_m=p^{-1}P_j^\rho.
 \tag{7.11}
\]
One arrow can be used to witness attainment of both formulas
in all three blocks.

**Proof.**
The inclusion \(\tau_s\in p^{k_s}I\) bounds each component
of every point tensor below by \(k_s-m\kappa\). Equation
(7.9) attains this bound, because
\(F\tau_s=p^{k_s}FT_s\) and all the background \(Fu\)
have valuation \(-\kappa\).
The attaining tensor has a nonzero component of the stated
valuation in every factor field of \(T_m\). Its principal
\(B_m\)-ideal is therefore the entire product ideal in
the first formula of (7.11).

For the whole family, \(a_sI\subseteq p^{n_s}I\).
Hence every tensor has component valuation at least
\(n_s-m\kappa\). The allowed tuple
\((a_s\pi^{-104},u,\ldots,u)\) attains this bound using
the same \(F\), since its first entry is \(p^{n_s}X_s\).
This proves the second formula. Here \(k_s=n_s+1\);
the equality with \(p^{-1}P_j^\rho\) is an equality of
fractional \(B_m\)-ideals, since \(p\) and \(\pi^{105}\)
differ by a unit.
Both resulting ideals are closed. \(\square\)

The proof also covers an intermediate closed product convex hull:
the upper product containers \(p^{k_s}I\times I^{m-1}\)
and \(p^{n_s}I\times I^{m-1}\) are closed and convex, while
the attaining tuples remain present. It also covers a larger
allowed family of independent factor arrows between the same
copies of \(I\): the upper bounds remain valid and the
diagonal attaining arrow is still included.

By Proposition 5.1, replacing \(\tau_s,u\) by \(a_s,1\)
has the same raw point hull. The same attaining arrow and
closed product container also give equality with product
convex hulls in this specific example.

The two logarithmic scales give the following four exact tables:

| \(j\) | \(m\) | exponent of \(P_j^\rho\) | exponent of \(S_j^\rho\) | exponent of \(P_j^{\rm std}\) | exponent of \(S_j^{\rm std}\) |
|---|---:|---:|---:|---:|---:|
| 1 | 2 | \(-103\) | \(-208\) | \(107\) | \(2\) |
| 2 | 3 | \(-207\) | \(-312\) | \(108\) | \(3\) |
| 3 | 4 | \(-206\) | \(-311\) | \(214\) | \(109\) |

Each entry is the exponent \(t\) in \(\pi^tB_m\), not an
exponent of \(p\). The standard-log columns add \(105m\)
to the corresponding \(\rho\) columns, exactly as in (4.4).
In particular, nonintegrality in a \(\rho\) column is not a
counterexample to an upper bound formulated in the standard
cohomological coordinate.

## 8. The principal \(B_m\)-ideal before transport

The original local estimate also involves \(B_m\)-ideals
before applying a merely \(\mathbf Q_p\)-linear arrow. This
operation cannot generally be exchanged with the final
\(B_m\)-module hull.

For \(z=a\otimes1\otimes\cdots\otimes1\), put
\[
 \mathscr M_{\mathcal G_m}(a)=
 \overline{\operatorname{span}_{B_m}
 \{\Phi(b): b\in zB_m,\ 
        \Phi=F_1\otimes\cdots\otimes F_m,\
        (F_1,\ldots,F_m)\in\mathcal G_m\}}.
 \tag{8.1}
\]
Thus \(zB_m\) is the input ideal, not an ideal taken after
applying \(\Phi\). The arrows \(\Phi\) preserve
\(I^{\otimes_{\mathbf Z_p}m}\), and therefore also preserve
the standard logarithmic tensor lattice
\((\log\mathcal O^\times)^{\otimes m}=p^m I^{\otimes m}\).
They are examples of the lattice-preserving linear arrows
to which Mochizuki IV Proposition 1.2 applies.

**Proposition 8.1 (native pre-hull sandwich).**
With the notation of Section 2,
\[
 \mathscr H_{\mathcal G_m}(\{(a,1,\ldots,1)\})
       \ \subseteq\ \mathscr M_{\mathcal G_m}(a)
       \ \subseteq\
 \mathscr H_{\mathcal G_m}(aI\times I^{m-1}).
 \tag{8.2}
\]

**Proof.**
The first containment follows from \(z\in zB_m\).
For the second, use the nondegenerate trace pairing on
the finite etale \(\mathbf Q_p\)-algebra \(T_m\), and
write \(A_m^\vee\) for the integral trace dual of \(A_m\).
Trace factorizes on pure tensors. Choosing an integral
basis and its trace-dual basis in each factor consequently
gives
\[
 A_m^\vee
   =(\mathfrak D_{E/\mathbf Q_p}^{-1})^{\otimes_{\mathbf Z_p}m}
   = I^{\otimes_{\mathbf Z_p}m}.
 \tag{8.3}
\]
For \(b\in B_m\) and \(c\in A_m\subseteq B_m\), the element
\(bc\) is integral in every field component; its trace
to \(\mathbf Q_p\) lies in \(\mathbf Z_p\).
Thus
\[
                          B_m\subseteq A_m^\vee.
 \tag{8.4}
\]
Multiplying (8.4) by \(z\) shows that every element of
\(zB_m\) is a finite \(\mathbf Z_p\)-linear combination
of pure tensors with entries in \(aI\times I^{m-1}\).
Apply the linear map \(\Phi\), and then take the common
\(B_m\)-span and closure. This proves the second
containment in (8.2). \(\square\)

In the degree-210 example, combine Propositions 5.1, 7.2
and 8.1. For \(m=j+1\) and \(a=a_{j^2}\),
\[
                  P_j^\rho\subseteq
                  \mathscr M_\Gamma(a_{j^2})
                  \subseteq S_j^\rho=p^{-1}P_j^\rho .
 \tag{8.5}
\]
The same is true for any intermediate allowed factor family
that contains the diagonal witnesses and consists of integral
arrows between these fixed copies.
Equation (8.5) is a proved lower and upper bound for a single,
well-defined native pre-hull family. The strengthened trace-dual
calculation below determines its middle ideal exactly; we retain
this sandwich because it describes the relation between the three
differently typed source constructions without additional attainment
hypotheses.

For \(\mu_B(B_m)=1\), it gives the interval bound
\[
 (m\kappa-k_{j^2})\log p
       \ \leq\ V_B(\mathscr M_\Gamma(a_{j^2}))
       \ \leq\ (m\kappa-n_{j^2})\log p.
 \tag{8.6}
\]
This bound has width \(\log p\). Corollary 8.3 below proves that
the value for this pre-hull family is its lower endpoint.

For comparison with the original containing calculation, at
\(e=105,p=139\) the local parameters of Mochizuki IV
Propositions 1.1--1.2 are
\[
 d_i=104/105,\qquad a_i=1/105,\qquad b_i=-1/105.
\]
For \(m\) repeated factors, and \(\lambda=v(a_{j^2})=j^2/7\),
its displayed containing ideal has depth
\[
 \lfloor\lambda-d_I-a_I\rfloor-b_I
                  =\lfloor\lambda\rfloor-m\kappa.
 \tag{8.7}
\]
This is exactly the upper endpoint ideal \(S_j^\rho\)
computed here. Numerical agreement of (8.7) with the
whole-family hull is not used as a proof that the two
input families are equal. The proof of (8.5) used the
trace-dual containment and the specified arrows instead.

### 8.1 A sharper trace-dual bound and the exact pre-hull

**Proposition 8.2 (maximal-order trace-dual bound).**
Retain the Galois field and tame hypotheses of Section 2. Let
\(0\ne a\in\mathcal O_E\), \(r=v(a)\),
\(k=\lfloor r+\kappa\rfloor\), and
\(z=a\otimes1\otimes\cdots\otimes1\). If \(\Phi\) is any
\(\mathbf Q_p\)-linear map of \(T_m\) satisfying
\(\Phi(A_m^\vee)\subseteq A_m^\vee\), then
\[
   B_m\operatorname{-span}\Phi(zB_m)
       \ \subseteq\ \pi^{ek-m(e-1)}B_m .          \tag{8.8}
\]
Consequently the same upper bound holds for
\(\mathscr M_{\mathcal G_m}(a)\) for every allowed integral
factor family of Section 2. No independent linear-group reachability
or factorization of \(\Phi\) is needed for the upper bound.

**Proof.**
Use the absolute algebra trace
\(\operatorname{Tr}_{T_m/\mathbf Q_p}\). Since \(E/\mathbf Q_p\)
is Galois, the component fields of \(T_m\) are all copies of \(E\).
The integral trace dual of their product maximal order is therefore
\[
 B_m^\vee=\prod_{\alpha} I_\alpha
       \ \subseteq\ A_m^\vee
       =I^{\otimes_{\mathbf Z_p}m},               \tag{8.9}
\]
where each \(I_\alpha=\mathfrak D_{E/\mathbf Q_p}^{-1}\)
is the inverse different in that component. The equality follows
component by component: multiplication by an idempotent of \(B_m\)
isolates any one component of the trace sum. Thus there is no
extra number-of-components or field-degree factor in (8.9).
The containment is the contravariance of the trace dual under
\(A_m\subseteq B_m\); the last equality is (8.3).

Every component of \(z\) has valuation \(r\). The floor defining
\(k\) gives \(r-k\ge-\kappa\), so
\[
 p^{-k}zB_m\subseteq B_m^\vee\subseteq A_m^\vee,
 \qquad zB_m\subseteq p^kA_m^\vee.               \tag{8.10}
\]
Apply \(\Phi\), which commutes with the rational scalar \(p^k\)
and preserves \(A_m^\vee\). It remains to compute the final
module span. Every pure tensor in \(I^{\otimes m}\) has component
valuation at least \(-m\kappa\), whereas
\((\pi^{1-e})^{\otimes m}\) attains that valuation in every
component. Hence
\[
 \operatorname{span}_{B_m}A_m^\vee
       =\pi^{-m(e-1)}B_m.                         \tag{8.11}
\]
Multiplication by \(p^k\) proves (8.8), since \(p\) has
valuation \(e\) in the uniformizer convention. The right-hand
ideal is closed, so taking unions, spans, and closures preserves
the upper bound. Integral factor arrows preserve
\(I^{\otimes m}=A_m^\vee\), proving the stated consequence.
\(\square\)

**Corollary 8.3 (exact native pre-hull).**
Whenever the allowed point orbit attains the depth
\(k-m\kappa\) in every field component, its point hull and
\(\mathscr M_{\mathcal G_m}(a)\) both equal
\(\pi^{ek-m(e-1)}B_m\). In particular, for the actual
degree-210 three-label family of Section 7,
\[
 \mathscr M_\Gamma(a_{j^2})=P_j^\rho
        =\pi^{105k_{j^2}-104m}B_m,
 \qquad S_j^\rho=p^{-1}\mathscr M_\Gamma(a_{j^2}),
 \quad m=j+1,\ j=1,2,3.                         \tag{8.12}
\]
The same single actual full-Galois arrow from Proposition 7.2
can be used for all of these point attainments.

**Proof.**
The first containment of (8.2), together with the assumed point
attainment, gives the reverse inclusion to (8.8). For the
specified example, Proposition 5.1 identifies the root-point
principal ideal with the normalized crystalline-point principal
ideal after each arrow, including the background factors.
Proposition 7.2 supplies the common attaining arrow. This gives
the first equality in (8.12). The second is the already proved
whole-product formula (7.11), not an identification of its source
with the pre-hull source. \(\square\)

Thus the exact normalized logarithmic measure of the pre-hull is
\[
 V_B(\mathscr M_\Gamma(a_{j^2}))
       =(m\kappa-k_{j^2})\log p .                \tag{8.13}
\]
The containing calculation (8.7) is a valid but larger ideal
in these native fixed-carrier examples: it is \(p^{-1}\) times
the exact pre-hull. A loose upper bound is not a contradiction.

If every tensor coordinate is changed from \(\rho\) to the
standard logarithm, the input pre-ideal itself changes from
\(zB_m\) to \(p^m zB_m\). Its hull is then
\(p^m\mathscr M_\Gamma(a_{j^2})=P_j^{\rm std}\), and its
normalized log measure decreases by \(m\log p\), as in Section 4.
This does not insert \(p^m\) into an originally printed
\(\phi(p^\lambda B_m)\) input without a coordinate conversion.
The exact native equality (8.12) and the standard-scale conversion
must therefore be used with the stated source objects on both sides.

The full source permits additional data and the Ind3
upper semi-compatibility operation. Nothing in (8.12)
computes that additional union, the cross-Frobenius map,
or its relation to a differently marked initial pilot.

## 9. Squared powers, markings, and global entry conditions

### 9.1 The same native ring does not turn a marking change into a power map

In the fixed native field (7.1), the literal coefficient
from the displayed singleton definition
\(\lambda(r_0)\) has \(p\)-content \(1\). In contrast
\(\lambda(r_0^9)\) has \(p\)-content \(2\).
No integral isomorphism of the indicated log lattices can
identify these two classes in their \(\rho\) coordinates,
because it preserves \(p^n I\) in both directions.
This is a rigorous obstruction to that particular
fixed-native dictionary. It does not contradict a
statement made with distinct marked absolute values.

For the unpowered coefficient \(\lambda(r_0)\) in every
block, the same native point calculation instead gives
\[
       \pi^{-103}B_2,\qquad
       \pi^{-207}B_3,\qquad
       \pi^{-311}B_4.
 \tag{9.1}
\]
At \(j=3\), (9.1) differs from the powered point column in
Section 7 by a factor of \(p^{-1}\).
The two norm prescriptions cannot be joined by silently
replacing the source vector.

| Operation | Algebraic source and integral \(p\)-content | Native hull / measure consequence |
|---|---|---|
| A field marking preserving \(\mathbf Q_p\) | Carries the specified unit, root, \(I\), and powers \(p^nI\) together. | Native valuations are preserved. |
| Replacing an attached valuation by \(c\,v\) | Does not, by itself, change the element, ring, or \(p\)-content. In particular \(v(p)\) changes too. | A native Haar measure with the same integral reference lattice does not acquire a \(c\)-fold determinant merely from this notation change. |
| Replacing \(r_0\) by \(r_0^{j^2}\) | Changes the source principal ideal and, in this example, sometimes its integral \(p\)-content. | This is a different native family; its hull must be computed anew. |
| Replacing \(\rho\) by \(\log_{\rm BK}^{\rm std}\) | Keeps the cohomology class, but multiplies every coordinate by \(p\). | The length-\(m\) hull is multiplied by \(p^m\), with volume shift \(-m\log p\). |
| Replacing a chosen unit by all of \(1+paI\) | Enlarges the source class family. | It realizes all of \(aI\); in Section 7 the resulting hull is \(p^{-1}\) times the point hull. |

This table makes explicit which data are preserved by a
target reset and which data must change to obtain a
native squared-power amplification. The fixed-source
all-isomorphism covariance proved in the earlier work
does not identify these different rows.

### 9.2 An actual Frey realization still has global hypotheses

The local field calculation is now available for any
split rational Frey curve at \(139\) with discriminant
valuation \(2\), not just for a prescribed abstract
Tate parameter. The coordinating and arithmetic agents
have independently checked the concrete direct Legendre curve
\[
                 D:\ y^2=x(x-1)(x+2362),
 \qquad (a,b,c)=(1,2362,2363).
 \tag{9.2}
\]
Its direct Legendre form removes a twist ambiguity in an
earlier proposed example. The checks establish the full
rational 2-torsion, the stated level fields, the exact
split local 210-torsion field, good reduction at \(7\),
the large mod-\(7\) image over the specified level field,
and the normalized numerical Tate window. These independent
realization checks are recorded separately in
[the Frey realization report](FREY_139_TATE_210_REALIZATION_2026_08_30.md)
and
[its arithmetic review](FREY_139_REALIZATION_ARITHMETIC_CROSS_REVIEW_2026_08_30.md).
They are not assumptions smuggled into Propositions 5.1
or 6.1, whose local hypotheses were stated in full.

There is a specific additional exclusion in the existence
proof of Joshi IV, even for a curve satisfying the small
numerical \(\ell=7\) window. Its Lemma 5.8.1, PDF p.54,
chooses \(\xi_{\rm prm}\) so that
\(\theta(x)\ge2x/3\) for all \(x\ge\xi_{\rm prm}\).
But
\[
                   \theta(10)=\log210<20/3.
\]
Thus any such \(\xi_{\rm prm}\) must be greater than \(10\).
The same page explicitly adds all points with
\(\sqrt Q\le\xi_{\rm prm}\) to the constructed exceptional
set. Therefore every \(\ell=7\) candidate satisfying
\(\sqrt Q\le7\), if it belongs to the chosen bounding
domain, is in that proof-constructed small-\(Q\)
exceptional set. In particular the normalized value
\(Q=2\log2790703<49\) in the accompanying realization
report does not provide an outside-exception input
to that proof when \(Q\) retains its definition and
the theorem's normalization.

There is a relevant displayed normalization discrepancy
in this part of the source as well. Definition 5.4.1,
PDF p.51, divides the Tate sum by the field degree;
Theorem 5.7.1 uses that Tate quantity. The opening
display of Section 5.8, p.54, instead omits the factor
\([L:\mathbf Q]^{-1}\). The conclusion in the preceding
paragraph concerns the normalized \(Q\) in the definition
and theorem. If the later display is read literally as
a different unnormalized quantity, then neither the
number \(2\log2790703\) nor its \(\ell=7\) numerical
window may be reused for that different quantity.
No silent correction of this source discrepancy is made.

This observation does not rule out directly checking
initial theta data for a small curve, nor assert that
every smaller admissible exceptional set must contain
it. It does rule out presenting these local examples
as automatically furnished outside the particular
exceptional set constructed in Section 5.8.

The remaining original initial-data requirements include
the full specified number fields and Galois degree
conditions, stable reduction, torsion and large-image
conditions, all the selected places, local orbicurve
types, and compatible cusp and auxiliary-cover choices.
Mochizuki I Definition 3.1, PDF pp.61--63, lists those
requirements. Establishing a split Tate chart and a
large residual image verifies only a portion of that
list. The actual global arithmeticoid family,
cross-Frobenius comparison, and common measured locus
must still be supplied before invoking the full
comparison in Joshi IV Sections 6.9--6.10.

## 10. What the new interfaces do and do not settle

The following are proved here:

- the per-arrow native principal-ideal equality between
  an integral root point and its normalized crystalline
  replacement;
- the exact, set-valued cohomological realization of
  \(aI\) by the saturated principal-unit family;
- a strict distinction between that whole family and
  the single-class family in the stated content range;
- a common full-Galois minimum-layer witness and exact
  hulls for both degree-210 three-label families;
- a general trace-dual bound for the same fixed-native
  pre-hull \(aB_m\) input, and its exact equality with
  the point hull in the attained three-label family;
- the precise \(p^m\) change between the two logarithmic
  coordinate scales.

The first result positively repairs the former point-level
bridge, even for nongeometric integral Galois arrows.
The second supplies a concrete larger family with the
correct multiplication-image type. The trace-dual
bound then computes the pre-hull type used in the original
containing estimate when the point bound is attained. It
does not commute a module span across a field-nonlinear
arrow: it bounds the entire pre-ideal before applying that
arrow. None requires independent arbitrary
\({\rm GL}_{\mathbf Z_p}(I)\) reachability.

It remains to identify and transport the full source
family selected by the global theorem, with its
actual marking, Ind3 operations, product weights,
and reference measures. No equality between the
point, whole-action, and pre-hull families is inferred
solely from a norm identity. No normalization change
is made on only one side of an inequality.

All proofs here precede any proposed formalization.
The new \(p\)-adic analytic, trace-dual, and whole-family
statements in this report have not yet been formalized
in Lean. The previously frozen theorem count, paper,
source manifests, and validation records are unchanged.
An algebraic word identity checked or formalized in
another module does not by itself formalize the
full local class-field or Galois-presentation inputs.

No unconditional \({\rm ABCConjecture}\) closed term or
rigorous disproof of ABC is obtained by these local
results. The global route remains open.
