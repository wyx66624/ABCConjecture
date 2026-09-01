# Independent review of the exact trace-dual pre-ideal hull

Author: ChatGPT. Review completed: 2026-08-31.

**Verdict: passed.** The sharpened upper bound and the equality with the
attained point hull are valid for the stated local source and arrow
families. No substantive correction is required in the three checked
files. The proof does not identify the full global IUT possible-image
family or include its remaining indeterminacies.

Checked snapshots:

| File | Bytes | SHA256 |
|---|---:|---|
| research/TRACE_DUAL_PREIDEAL_EXACT_HULL_2026_08_31.md | 7027 | 89f7330a19c714b983042d6bd97f1bf30f7207a164889ab377d6a08c4d8441e1 |
| paper/general_tame_square_labels_2026.tex | 15722 | 96dc3927b70817d3a14be819d06923d7e6a9fe68f435067cae0425197689ffc8 |
| paper/native_pilot_dictionary_2026.tex | 24744 | 3aad83a3c3dc34a71958b47dc9db67015bb2a62f64a8c1f48119f2e2036ba1db |

No reviewed file, main input, PDF, or frozen Lean module was edited.

## 1. The absolute trace introduces no extra multiplicity

Let \(d=[E:\mathbb Q_p]\), \(T=E^{\otimes m}\), and use the full
absolute algebra trace. Under

\[
 T\simeq\prod_{\alpha=1}^{d^{m-1}} E,
\]

multiplication by \((x_\alpha)\) is block diagonal. Hence

\[
 \operatorname{Tr}_{T/\mathbb Q_p}(x_\alpha)
   =\sum_\alpha\operatorname{Tr}_{E/\mathbb Q_p}(x_\alpha).
\]

For \(B=\prod_\alpha\mathcal O_E\), testing against
\(y_\alpha e_\alpha\), with \(y_\alpha\in\mathcal O_E\) and
\(e_\alpha\) the product idempotent, isolates the trace condition in
one factor. It follows that

\[
 B^\vee=\prod_\alpha\mathfrak D_{E/\mathbb Q_p}^{-1}
       =\prod_\alpha I.
\]

Testing only diagonal elements of \(B\) would not justify this formula;
the proof correctly uses the individual components. There is no divisor
or multiplier equal to the number of components.

On pure tensors the multiplication operator is a tensor product of
multiplication operators. Its trace is the product of the field traces.
If \(u_i\) is an integral basis of \(\mathcal O_E\) and \(v_i\) its
trace-dual basis of \(I\), the tensor bases have Kronecker-delta pairing.
They have full rank \(d^m\), proving

\[
 A^\vee=I^{\otimes_{\mathbb Z_p}m},
 \qquad A=\mathcal O_E^{\otimes_{\mathbb Z_p}m}.
\]

Since \(A\subseteq B\), trace duality reverses the inclusion:
\(B^\vee\subseteq A^\vee\). The direction used in both English proofs
is correct.

## 2. The input ideal is bounded before applying the arrow

Write \(v(p)=1\), \(\kappa=(e-1)/e\), \(r=v(a)\), and
\(k=\lfloor r+\kappa\rfloor\), with \(0\ne a\in\mathcal O_E\).
For \(z=a\otimes1\otimes\cdots\otimes1\), every component of \(z\)
has valuation \(r\). The elementary inequality

\[
 r-k\ge-\kappa
\]

therefore gives

\[
 p^{-k}zB\subseteq B^\vee\subseteq A^\vee,
 \qquad zB\subseteq p^kA^\vee.
\]

If \(\Phi\) is \(\mathbb Q_p\)-linear and
\(\Phi(A^\vee)\subseteq A^\vee\), its image of this **entire**
input ideal is contained in \(p^kA^\vee\). Taking the \(B\)-span
only after this step gives

\[
 \operatorname{Span}_B\Phi(zB)
 \subseteq p^k\operatorname{Span}_B A^\vee
 =\beta^{ek-m(e-1)}B.
\]

For the last equality, the tensor of \(m\) copies of
\(\beta^{1-e}\) has valuation \(-m\kappa\) in every product component
and generates the whole corresponding principal \(B\)-ideal.
The containing product lattice is closed, so the same bound holds
for the union over arrows and its closed \(B\)-span.

No \(B\)-linearity, multiplicativity, or trace preservation of
\(\Phi\) is used. In particular, no equality of the form
\(\Phi(\operatorname{Span}_B S)=\operatorname{Span}_B\Phi(S)\)
has been assumed.

## 3. One attained point is sufficient for equality

The element \(z\) belongs to the input \(zB\). If one allowed
\(\Phi_0(z)\) has valuation \(k-m\kappa\) in every component,
its principal \(B\)-ideal is exactly the upper bounding ideal.
This gives the reverse containment and proves the equality.
The equality remains valid after any enlargement of the arrow
family that preserves \(A^\vee\) and retains this witness.

For the diagonal integral arrows \(F^{\otimes m}\), preservation of
\(I\) implies preservation of \(I^{\otimes m}=A^\vee\).
The lower witness is also correctly transferred from the logarithmic
point to the root point, for the very same \(F\). Indeed

\[
 \lambda_p(a)-a\in p^{k+1}I,\qquad
 a\in p^kI\setminus p^{k+1}I,
\]

and an integral automorphism preserves both displayed lattices.
The strict ultrametric inequality gives
\(v(F\lambda_p(a))=v(Fa)\). Applying the same proof to \(a=1\)
gives \(v(Fu)=v(F1)\), including every repeated background factor.
This is equality of transported valuations and principal ideals,
not equality of the transported vectors.

## 4. The simultaneous-label witnesses satisfy their quantifiers

For the degree-210 example, the six normalized inputs have the
nontrivial characters \(\zeta_7^s\) and \(\zeta_7^{s+1}\),
\(s=1,4,9\). Since
\(\mu_7\cap\mathbb F_{139}^{\times}=\{1\}\), each projective orbit
has seven elements. At most one inertia exponent is forbidden per
input, so six inputs leave a common choice among seven exponents.
The parabolic lemma then uses six hyperplanes (and, in its second
case, one further proper subspace), with \(6+1<139\).
This gives one arrow for all labels and the repeated background,
not a different arrow for each tensor block.

For the general family, \(\ell\ge7\) is prime,
\(p\equiv-1\pmod{30\ell}\), \(e=15\ell\), and
\(h=(\ell-1)/2\). Here \(\gcd(e,p-1)=1\). The \(h\) point
characters have order \(\ell\), forbidding at most \(15h\)
inertia exponents. For the whole-product inputs the exponent is
\(30j^2+1\) modulo \(e\). Its gcd with \(e\) is 1 or \(\ell\),
and at most one \(j\in\{1,\ldots,h\}\) has the latter value:
the two possible roots modulo \(\ell\) are \(j,-j\).
Thus their total exclusions are at most \(h-1+\ell\), and

\[
 15h+(h-1+\ell)=9\ell-9<15\ell.
\]

The count uses equality of leading projective coefficients only as
a necessary condition for equality of full vector lines; it does
not turn that necessary condition into a sufficient one.
There is one common inertia exponent. The subsequent finite-family
lemma has \(2h+1=\ell<p\), so one parabolic composition suffices
for all \(2h\) inputs and the background. Integral coordinate lifts
and the previously verified full-Galois construction supply the
same actual arrow. The inverse/unit Kummer convention does not
change any of these valuations.

## 5. Haar normalization and the original printed source

For an ideal \(\beta^tB\) in \(d^{m-1}\) copies of \(E\), with
residue degree \(f\), the Haar measure normalized by \(\mu_B(B)=1\)
has logarithm \(-t f d^{m-1}\log p\). Dividing by \(d^m\)
gives \(-t/e\log p\). Hence the manuscript's formulas

\[
 V_B(P_j^\rho)=(m\kappa-k_j)\log p,\qquad
 V_B(S_j^\rho)=V_B(P_j^\rho)+\log p
\]

have no missing component-count factor.
Scalar multiplication of the whole tensor source by \(p^m\)
adds \(em\) to its uniformizer exponent and subtracts
\(m\log p\) from this normalized logarithmic measure.

I reopened the original April 2020 Mochizuki IV PDF and checked
Propositions 1.1--1.4, pages 9--14, and Theorem 1.10, Step (v),
pages 27--28; Mochizuki I, Example 3.2(iv), page 71, was also
checked. The IV source uses \(\phi(p^\lambda B)\), with
\(\lambda=v(\underline q^{\,j^2})\), where
\(\underline q=q^{1/(2\ell)}\). Preservation of
\((\log\mathcal O_E^\times)^{\otimes m}=p^mA^\vee\)
is equivalent, for a \(\mathbb Q_p\)-linear arrow, to preservation
of \(A^\vee\). Thus the new bound applies to the specified repeated
field input without changing that printed source.

At \(e=105,p=139\), the source parameters are
\(d_i=104/105\), \(a_i=1/105\), \(b_i=-1/105\).
Its containing depth is therefore
\[
 \lfloor\lambda-d_I-a_I\rfloor-b_I
      =\lfloor\lambda\rfloor-m\kappa.
\]
The newly attained depth is
\(\lceil\lambda\rceil-m\kappa\), and the three
\(\lambda=j^2/7\) are nonintegers. The original containing ideal
is consequently \(p^{-1}\) times the new exact hull. This is a
strictly looser upper bound, not a contradiction in that local
containing calculation.

The standard-coordinate formulas in the English files explicitly
transform the corresponding source along with all \(m\) coordinates.
They do not insert \(p^m\) into the original unscaled
\(\phi(p^\lambda B)\) while leaving its input fixed. In particular,
the numerical nonintegrality of a \(\rho\)-coordinate hull alone
does not contradict an estimate in another coordinate system.

The IV PDF used has 632447 bytes and SHA256
5bf4b1e0a8c2686562a6859e5009d301335044cfb5efec5d3a9edf764e4af87f.
The paper source boundaries remain explicit: complete global
pilot identification, the further Ind3 operation, and the
cross-Frobenius comparison are not established by this equality.
