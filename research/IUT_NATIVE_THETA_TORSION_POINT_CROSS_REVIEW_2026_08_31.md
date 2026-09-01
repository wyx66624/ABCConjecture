# Independent review of the native theta torsion point hull

Reviewer: ChatGPT, analytic-route agent. Date: 2026-08-31.

**Verdict:** the mathematical assertions in Sections 4--7 pass for the
declared native additive carrier. Section 8 preserves the distinction
between that calculation and membership in the published global
pilot-output family. No mandatory correction was found.

This review does not assert a proof or disproof of IUT or abc. No reviewed
report, Lean module, manuscript input, or PDF was modified.

## 1. Exact object reviewed and source checks

The reviewed report is
[IUT_NATIVE_THETA_TORSION_POINT_HULL_2026_08_31.md](E:/AImath/abc猜想/research/IUT_NATIVE_THETA_TORSION_POINT_HULL_2026_08_31.md),
32722 bytes, SHA256
a3521db8cd5dbc03b6a843f49078b465eae9315f82c5917e491bb4fa1023e294.
All nine sections were read; the independent mathematical checks below
concentrate on Sections 4--8.

The following original PDFs were read at the indicated physical pages;
their printed page numbers agree there. Both author URLs were also
opened independently.

| Source | Archived file, bytes and SHA256 | Pages checked |
| --- | --- | --- |
| [IUT II, December 2020](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20II.pdf) | research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_II_December2020.pdf; 1203855 bytes; 180bfa6aaddc4ae37af37acaad51f61e0a47b33b8255ad3169e28a970ae39b7c | 71--73 |
| [IUT III, May 2020](https://www.kurims.kyoto-u.ac.jp/~motizuki/Inter-universal%20Teichmuller%20Theory%20III.pdf) | research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf; 1307865 bytes; 9a7ee3c77b1c7717210c0613eb39b6844649d0040dc3d9e1be7d544f8f91a0b9 | 23--25, 31, 39, 41--43, 93, 100, 102--106, 173--175 |

The cached page images of II pp.72--73 and III p.105 were also inspected.
II Remark 2.5.1 identifies the prescribed integer square exponents and
the finite root-of-unity orbit, and explicitly makes the ambiguities
independent across labels. III gives literal tensor-slot ones, specified
log-link pullbacks, and the finite torsion subgroup of the unperfected
splitting monoid. Its theater log-links arise from one synchronized
isomorphism, and its final hull concerns possible images of a global
pilot subject to the stated indeterminacies. These passages support the
report's restricted source description, not an arbitrary-unit source or
an automatic global-membership conclusion.

The previously reviewed full-group lift and integral-basis arguments
were reread in Section 4 of
[IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md](E:/AImath/abc猜想/research/IUT_GENERAL_TAME_SQUARE_LABELS_2026_08_30.md)
and Sections 5 and 7 of
[IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md](E:/AImath/abc猜想/research/IUT_FULL_GALOIS_MINIMUM_LAYER_2026_08_30.md).
They are explicit prior inputs here. This review does not replace their
full relative-group presentation proof by a claim about a maximal
pro-\(p\) quotient, or about all integral linear automorphisms.

## 2. Field, content and exact trace

Let \(e=15\ell\), \(d=2e\), and retain the report's assumptions
\(\ell\ge7\), \(p\equiv-1\pmod{30\ell}\), and \(v_p(b_0)=2\).
They imply \(p\ge30\ell-1\), \(e\le p-2\), and \(p\nmid d\).
The cyclotomic field \(K_0=\mathbf Q_p(\mu_{30\ell})\) is unramified
quadratic. In particular it contains \(\mu_{2\ell}\).

Writing \(\gamma=p^2/b_0\), I independently checked

\[
 \beta^e=p\gamma^{-(e+1)/2},\qquad
 \varpi=\gamma\beta^2,\qquad r_0=\gamma^{15}\beta^{30}.
\]

The first polynomial is Eisenstein over \(K_0\); all its root
multipliers lie in \(K_0\). The coefficients are rational over
\(\mathbf Q_p\). Thus \(E/\mathbf Q_p\) is Galois with the claimed
ramification index \(e\), residue degree two, and uniformizer \(\beta\).
The assertion does not mistake \(\varpi\), of valuation \(2/e\), for
a uniformizer.

In this tame range logarithm gives
\(I=p^{-1}\log(\mathcal O_E^\times)=\beta^{1-e}\mathcal O_E\).
The tame different identifies this with the inverse different. Its
trace is contained in \(\mathbf Z_p\), and \(1/d\in\mathcal O_E\)
has trace one, so the stated trace surjectivity follows.

For a label \(j\), put \(2j^2=\ell n_j+\delta_j\), where
\(1\le\delta_j\le\ell-1\). With
\(x_j=\zeta_j r_0^{j^2}\) and \(T_j=x_j/p^{n_j+1}\), one has

\[
 k_j=n_j+1=\lfloor v_p(x_j)+\kappa\rfloor,\qquad
 e\,v_p(T_j)=15\delta_j-e,\qquad \kappa=(e-1)/e .
\]

The relevant integral exponents are

\[
 2-e<15-e\le 15\delta_j-e\le-15<1 .
\]

The left and right thresholds \(2-e\) and \(1\) are exactly those of
\(\beta I\) and \(pI\). Hence \(T_j\in\beta I\setminus pI\),
not merely \(T_j\in I\). The point \(1\) satisfies the same membership,
while its trace is the unit \(d\).

Every \(\zeta_j\) lies in \(K_0\), so tame inertia fixes it.
The inertia character on \(T_j\) is \(\epsilon^{30j^2}\), of order
\(\ell\). Summing its conjugates gives zero over \(K_0\), hence
exactly zero absolute trace. This is an exact identity for every
independent twist, not an estimate modulo \(p\).

The series reindexing in Section 2 was checked as well: substituting
\(n+a\) gives the stated factor
\((-1)^a q^{-a^2/2}U^{-2a}\). At \(U=i\), the two terms of
valuation zero sum to \(2i\), a unit because \(p\) is odd.
The reciprocal root formula therefore has the stated square exponent
and finite ambiguity.

## 3. Projective avoidance and the common actual arrow

The projective orbit has exactly \(\ell\) elements over \(\mathbf F_p\).
Indeed the character values are prime-to-\(p\) roots reducing
injectively, and
\(\mu_\ell\cap\mathbf F_p^\times=\{1\}\).
If two character multiples became proportional modulo \(pI\), a
nonzero difference of their residues would multiply \(T_j\) by a
unit of \(K_0\). Such a product cannot lie in \(pI\), since
\(T_j\notin pI\). Thus proportionality forces equal characters.
This checks the argument at its actual fractional-lattice layer.

The integral JW basis makes \(a_{\rm JW}\) nonzero modulo \(pI\).
For each label at most one of the first \(\ell\) inertia powers
hits its projective line. There are \(h=(\ell-1)/2<\ell\)
labels, so one inertia power avoids all these lines. It fixes \(1\).
The resulting decomposition
\(\overline{T_j}=A_j\overline a_{\rm JW}+w_j\)
has \(w_j\ne0\) for every \(j\).

I checked both parabolic cases without assuming independence among
the \(w_j\):

- If \(\overline a_{\rm JW}\notin V_0\), the nondegeneracy of the
  form on \(W/pW\) makes each \(\omega(-,w_j)=0\) a proper
  hyperplane. Since \(h<p\), choose \(z\) outside their union.
  Each \(N_zT_j\) then has nonzero projection to \(V/V_0\).
  If the background remains in \(V_0\), \(C_1\) moves it out
  because its \(b_{\rm JW}\)-coordinate is a unit. The other
  vectors have zero \(b_{\rm JW}\)-coordinate and are unchanged
  by this correction.
- If \(\overline a_{\rm JW}\in V_0\), subtracting
  \(\operatorname{Tr}(x)/d\in\mathcal O_E\subset\beta I\)
  proves that the trace kernel surjects onto \(V/V_0\).
  Consequently the map from \(W/pW\) is surjective, and all
  \(w_j\) lie in its kernel. Avoid that kernel and the \(h\)
  hyperplanes at once; \(h+1<p\) suffices. The resulting
  \(S_z\) moves every \(T_j\) out of \(V_0\). If needed,
  \(N_{z'}\) then moves the background out while preserving
  every other quotient projection.

The formulas use parameters lifted to integers. The previously
proved central/cross composition and individual symplectic handle
lifts provide actual full-group automorphisms for these parameters.
No section from a symplectic group to the Galois automorphism group
is required. The central composition law is used only in its proved
linear image.

Finally, if the composed canonical action is \(M\), the inverse
group arrow has integral Kummer action \(cM\), with
\(c\in\mathbf Z_p^\times\). This is the correct use of the
covariance formula \(F_\alpha=c_\alpha M_\alpha^{-1}\).
Multiplication by \(c\) does not affect any native valuation.
Thus one actual \(F\) attains the minimum for \(1\) and every
\(T_j\).

The proved quantifier is exactly

\[
  \forall(\zeta_1,\ldots,\zeta_h)\quad
  \exists F\in\Gamma_E\quad
  \forall j,\quad v_p(F(1))=v_p(F(T_j))=-\kappa .
\]

It does not require one \(F\) to work for every possible tuple
of twists. Nor is multiplication by a twist commuted through \(F\).

## 4. The point-source hull and its volume

For \(m=j+1\), the Galois tensor algebra has \(d^{m-1}\)
components, all copies of \(E\). Its maximal order is the product
of their integer rings. This is the report's \(B_m\); replacing it
by the smaller tensor order would be an unjustified change.

Every actual \(F\) preserves \(I\) and its \(p\)-power multiples.
Therefore every component of
\(F(1)^{\otimes(m-1)}\otimes F(x_j)\)
has valuation at least \(k_j-m\kappa\). The common \(F\) proved
above attains equality in every component, since each component
map applies valuation-preserving field embeddings to its factors.
This single tensor is a componentwise unit times a generator of

\[
 P_j=\beta^{\,e k_j-(e-1)m}B_m .
\]

It already generates \(P_j\) over \(B_m\). The ideal is closed,
so taking closure neither enlarges nor shrinks this equality.
No assumption that the original point source contains
\(a_jB_m\) or a product of fractional ideals is used.

With \(\mu(B_m)=1\), the log-volume of \(\beta^\nu B_m\) is
\(-2d^{m-1}\nu\log p\). Dividing by the actual
\(\mathbf Q_p\)-dimension \(d^m\) gives
\(-(\nu/e)\log p\). This checks (6.8), including the absence
of an extra factor \(1/m\).

The same \(F\) supplies these generators at all labels. This
simultaneity is stronger than obtaining each hull equality
from unrelated operators.

## 5. The logarithmic tail and all-slot scaling

For any nonzero integral \(x\), write \(r=v_p(x)\ge0\).
For \(n\ge2\), the \(n\)-th term of
\(\lambda(x)-x\) has valuation

\[
 (n-1)+nr-v_p(n)\ge1+2r,
\]

because \(p\) is odd and \(v_p(n)\le n-2\). The series
converges, so the same lower bound holds for its sum.
For \(k=\lfloor r+\kappa\rfloor\),
\(1+2r\ge k+1-\kappa\), proving that the difference lies
in \(p^{k+1}I\).

The strict step is valid for every actual \(F\):
\(x\in p^kI\setminus p^{k+1}I\) and \(F\) is an
automorphism of this filtered lattice. Hence

\[
 v_p(F(x))<k+1-\kappa
       \le v_p(F(\lambda(x)-x)).
\]

Strict ultrametricity gives the asserted equality of valuations.
The proof never assumes that an arbitrary \(F\) preserves the
valuation of \(x\) itself or commutes with the logarithm.

For the rational background,
\(u=p^{-1}\log(1+p)\in\mathbf Z_p^\times\), so
\(F(u)=uF(1)\). Combining this with the preceding result gives
the same principal \(B_m\)-ideal for each pair of tensors in
(7.6), for each individual \(F\). It also preserves the same
common attainer for all labels. No exact zero-trace assertion
is made for the logarithmic coefficient \(t_j\).

Changing all \(m\) coordinates of this separately defined
unit-cohomology packet from \(p^{-1}\log_{\rm BK}^{\rm std}\)
to \(\log_{\rm BK}^{\rm std}\) multiplies its tensor by \(p^m\).
Consequently its hull is

\[
 p^mP_j=\beta^{\,e k_j+m}B_m,\qquad
 \frac{\log\mu(p^mP_j)}{d^m}
       =-(k_j+m/e)\log p .
\]

The log-volume change is \(-m\log p\). This checks the
scale at every \(m_j=j+1\), not only the first label.
It is not an extra multiplier on the original theta source.

## 6. The remaining source boundary

Section 8 keeps the three objects distinct:

\[
 \operatorname{Kum}(x_j),\qquad
 x_j\in E,\qquad
 \operatorname{Kum}_p(1+px_j).
\]

The first and third have different valuation components.
In the normalized unit-cohomology coordinate the scalar \(x_j\)
instead comes from \(\exp(px_j)\). Equality of additive
valuations and principal ideals does not identify these
multiplicative inputs.

The tautological local marking is used only to specify a
coordinate for a logarithmic field. It is not described as
a ring homomorphism from the predecessor's original field.
The pullback symbol in the source table does not grant
independent choices of log-links at all labels.

Accordingly the report still requires a compatible, globally
indexed log-Kummer and reference-data choice giving actual
membership in the final possible-image family. That requirement,
and the treatment of Ind3, do not follow from the native
point-hull calculation. Initial theta data alone do not
remove them. No scope correction is required in the reviewed
version.
