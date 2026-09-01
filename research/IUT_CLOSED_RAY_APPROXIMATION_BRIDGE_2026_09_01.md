# The closed-ray approximation bridge in IUT III, Corollary 3.12

**Author:** ChatGPT
**Research date:** 2026-09-01
**Status:** unconditional order/real-analysis theorems, together with exact
counterexamples to weaker approximation interfaces.  The order theorem matches
the source's earlier definition of a log-volume hull-approximant.  This note
neither assumes nor proves that the object invoked in Step (xi-f) has that exact
source type.  It is not a proof or disproof of IUT or abc.

## 1. The precise issue isolated from the original text

In Step (xi-d) of the proof of IUT III, Corollary 3.12, the two real
quantities being compared are written

\[
  \mathbb R_{\le -|\log(\Theta)|}
  =\{x\in\mathbb R:x\le -|\log(\Theta)|\},
  \qquad -|\log(q)|\in\mathbb R.
  \tag{1.1}
\]

Steps (xi-b)--(xi-e) describe the possible output data as linked to the
input prime strip through IPL, SHE, and APT.  Step (xi-f) then says that the
construction is, "perhaps only up to some sort of approximation", a
construction of the input pilot log-volume, and concludes

\[
  -|\log(q)|\in \mathbb R_{\le -|\log(\Theta)|}.
  \tag{1.2}
\]

The sentence in Step (xi-f) does not itself state an error parameter or a
typed membership in one of the approximation classes defined earlier in the
paper.  Remark 3.9.5(iii), (vi), and (vii)(Ob6), pp. 128--135, does, however,
give a specific nonmetric meaning to the term "log-volume approximation".
The purpose of this note is to treat that source-defined meaning first, then
determine which ordinary metric approximation would also suffice, and finally
identify weaker readings that do not suffice.  The original pages used are
physical pp. 127--135 and 181--184 of the
unchanged May 2020 author PDF
`research/sources/uniform_gate_2026_08_30/Mochizuki_IUT_III_May2020.pdf`.

Put

\[
  q_*=-|\log(q)|,\qquad T=-|\log(\Theta)|,
  \qquad I_T=(-\infty,T].
  \tag{1.3}
\]

The desired assertion is simply \(q_*\le T\).

### 1.1. The source-defined hull approximation

For a direct-product region \(P\), Remark 3.9.5 writes \(\varphi(P)\) for its
holomorphic hull and defines

\[
 \Phi(P)=\{H:\ H\subseteq\varphi(P),\quad
       \mu_{\log}(P)\le\mu_{\log}(H)
       \le\mu_{\log}(\varphi(P))\}.
 \tag{1.4}
\]

It calls members of \(\Phi(P)\) "log-volume approximations" or
"log-volume hull-approximants" of \(P\).  This is an order condition, not a
claim that two real numbers are close in the Euclidean metric.

### Theorem 1.1 (ordered hull-approximant bridge)

Let \(P\) be the input pilot region and \(H\in\Phi(P)\).  If

\[
 q_*=\mu_{\log}(P),\qquad
 h_*=\mu_{\log}(H),\qquad h_*\le T,
 \tag{1.5}
\]

then \(q_*\le T\).

**Proof.**  Membership \(H\in\Phi(P)\) gives
\(\mu_{\log}(P)\le\mu_{\log}(H)\) by (1.4).  Substituting (1.5) gives

\[
 q_*\le h_*\le T.
\]

Transitivity proves the result. \(\square\)

Thus the source-defined meaning of approximation is already exactly strong
enough.  The remaining issue is typed rather than analytic: one must show
that the hull occurring after all Ind1--Ind3 operations, determinant powers,
globalization, and normalization in Step (xi-f) is a member of \(\Phi(P)\)
for the **same** region \(P\) whose normalized log-volume is
\(-|\log(q)|\), and that its log-volume is one of the values in the printed
output ray.  Merely using the same word "pilot" or an isomorphic prime strip
does not establish these identities.

At the scalar level, existence of an intermediate number
\(h_*\) with \(q_*\le h_*\le T\) is equivalent to \(q_*\le T\): the
forward direction is Theorem 1.1, while the reverse direction takes
\(h_*=q_*\).  Hence calling an object a member of \(\Phi(P)\) cannot serve as
an independent numerical proof unless that membership has first been obtained
from the source's region, hull, and comparison maps without using the desired
volume inequality.  Otherwise the argument would merely repackage its target.

## 2. Arbitrarily accurate approximation is equivalent to membership

### Definition 2.1 (closed-ray approximation)

For \(q_*,T\in\mathbb R\), write \(\operatorname{RayApprox}(q_*,T)\) for

\[
  \forall \varepsilon>0\ \exists x\in\mathbb R:\quad
  x\le T\quad\hbox{and}\quad |x-q_*|<\varepsilon.
  \tag{2.1}
\]

This is the literal, quantitative meaning of saying that elements of the
closed output ray approximate the input log-volume arbitrarily accurately.

### Theorem 2.2 (closed-ray bridge)

For all real \(q_*,T\),

\[
  \operatorname{RayApprox}(q_*,T)\quad\Longleftrightarrow\quad q_*\le T.
  \tag{2.2}
\]

**Proof.**  Suppose first that (2.1) holds and assume for contradiction that
\(q_*>T\).  Set \(\varepsilon=(q_*-T)/2>0\), and choose \(x\le T\) as in
(2.1).  Then

\[
  q_*-x\ge q_*-T=2\varepsilon,
\]

so \(|x-q_*|=q_*-x\ge2\varepsilon>\varepsilon\), contradicting (2.1).
Thus \(q_*\le T\).

Conversely, if \(q_*\le T\), take \(x=q_*\) for every
\(\varepsilon>0\).  Then \(x\le T\) and \(|x-q_*|=0<\varepsilon\).
\(\square\)

The theorem is also the elementary closed-set statement

\[
  q_*\in\overline{S},\quad S\subseteq I_T
  \quad\Longrightarrow\quad q_*\in I_T,
  \tag{2.3}
\]

because \(I_T\) is closed.  Thus no exact output representative is required:
density at the numerical log-volume level is enough.  What is required is
that the error tend to zero in the ordinary real topology.

## 3. A weaker one-sided error also suffices

The source would not need a two-sided absolute-error estimate.  The following
one-sided condition is strictly tailored to the desired inequality.

### Theorem 3.1 (vanishing upper-error bridge)

If, for every \(\varepsilon>0\), there is an output value \(x\le T\) such
that

\[
  q_*\le x+\varepsilon,
  \tag{3.1}
\]

then \(q_*\le T\).

**Proof.**  If \(q_*>T\), choose
\(\varepsilon=(q_*-T)/2\).  Every \(x\le T\) then satisfies

\[
  x+\varepsilon\le T+(q_*-T)/2=(q_*+T)/2<q_*,
\]

contradicting (3.1). \(\square\)

Consequently any explicit error family \(e_n\downarrow0\) with output values
\(x_n\le T\) and \(q_*\le x_n+e_n\) also proves the desired membership.

## 4. The coefficient conclusion follows with no further limit argument

Write

\[
  Q=|\log(q)|>0,\qquad H=|\log(\Theta)|,
\]

so \(q_*=-Q\) and \(T=-H\).  The closed-ray bridge gives
\(-Q\le-H\), equivalently \(H\le Q\).

### Corollary 4.1 (the printed coefficient bound)

Assume \(Q>0\), \(\operatorname{RayApprox}(-Q,-H)\), and

\[
  -H\le C_\Theta Q.
  \tag{4.1}
\]

Then \(-1\le C_\Theta\).

**Proof.**  Theorem 2.2 and (4.1) give

\[
  -Q\le-H\le C_\Theta Q.

\]

Division by the positive number \(Q\) gives \(-1\le C_\Theta\).
\(\square\)

Thus a source-level proof of the typed ordered-hull conditions (1.4)--(1.5),
of (2.1), or even of (3.1), would make the scalar passage in Step (xi-f)
rigorous.  It would not by itself prove the later IUT IV upper estimate or the
uniform abc theorem.

## 5. Fixed-error approximation is not enough

The quantifier \(\forall\varepsilon>0\) cannot be replaced by one unspecified
positive tolerance.

### Proposition 5.1 (full counterexample to the fixed-tolerance inference)

For every \(\delta>0\), there are \(q_*,T,x\in\mathbb R\) satisfying

\[
  x\le T,\qquad |x-q_*|<\delta,
  \tag{5.1}
\]

but \(q_*\not\le T\).

**Proof.**  Take

\[
  T=0,\qquad x=0,\qquad q_*=\delta/2.
\]

Then \(x\le T\) and \(|x-q_*|=\delta/2<\delta\), while
\(q_*=\delta/2>0=T\). \(\square\)

The same example gives a constant sequence of output values whose errors are
bounded but do not tend to zero.  Hence "boundedly close", with no shrinking
parameter, cannot justify (1.2).  This proposition closes only that weakened
logical route; it is not a counterexample to any full IUT assertion.

## 6. A qualitative bijective link does not control log-volume

IPL is a link of prime-strip data.  A bijection of the underlying data, even
together with a bound on every output log, implies no inequality for the input
log unless the link is also compatible with the numerical log-volume.

### Proposition 6.1 (full countermodel to the qualitative-link inference)

There exist singleton input and output sets \(A=B=\{*\}\), a bijection
\(f:A\simeq B\), functions

\[
  L_{\rm in}:A\to\mathbb R,\qquad
  L_{\rm out}:B\to\mathbb R,

\]

and \(T\in\mathbb R\) such that every output satisfies
\(L_{\rm out}(b)\le T\), but the linked input satisfies
\(L_{\rm in}(*)>T\).

**Proof.**  Use the identity bijection, set

\[
  L_{\rm in}(*)=1,\qquad L_{\rm out}(*)=0,\qquad T=0.

\]

All stated hypotheses hold, while \(1\not\le0\). \(\square\)

This countermodel satisfies every hypothesis of the deliberately weakened
"bijection plus output bound" interface.  It does not satisfy an additional
log-compatibility or vanishing-error hypothesis, and it does not model the
hidden theta, Kummer, Frobenioid, determinant, and metric structures of the
full source construction.  It therefore cannot close the IUT route.

For comparison, exact compatibility immediately repairs the inference: if

\[
  L_{\rm in}(a)=L_{\rm out}(f(a))
  \tag{6.1}
\]

for all \(a\), then the output bound gives
\(L_{\rm in}(a)\le T\).  Theorems 2.2 and 3.1 show that exact equality in
(6.1) can be weakened to arbitrarily accurate or vanishing one-sided
compatibility.

## 7. Interaction with the proved local base branch

The source-audited theorem in
`research/IUT_IDENTITY_LOG_LINK_LOCAL_MEMBERSHIP_2026_08_31.md` proves that a
specific canonical transfer image belongs to the raw possible-image set of
the same pilot in one fixed column and one basic vertical branch.  The product
order theorem in
`research/IUT_SELECTED_PLACE_PRODUCT_HULL_2026_08_31.md` turns all selected
block projections into a finite local hull lower bound.

Those results are stronger than a qualitative bijection, but they still do
not identify one global source-defined approximant as in (1.4), or establish
(2.1) for the global pilot log-volume.  The missing comparison has three
concrete parts:

1. carry the same marked pilot through the required horizontal theta/q link
   and every stipulated Ind3 direction;
2. identify the remaining finite-place components and the archimedean metrics
   of the same global determinant bundle, rather than choosing convenient
   extensions independently;
3. prove either that the resulting global hull is a member of \(\Phi(P)\) for
   that same native region, direct inclusion of the global native region in
   the global theta hull, or a family of source-permitted global regions
   satisfying (2.1) or (3.1).

Because arithmetic line bundles differ from a fixed integral reference at
only finitely many finite places, a successful source identification would
reduce item 2 to a finite component ledger plus the archimedean metrics.  The
current repository constructs such global bundles for the local hulls, but
has not proved that their freely fixed complementary components are the
components produced by the published multiradial algorithm.

## 8. Route disposition

The first positive result is source-faithful: a correctly typed member of
\(\Phi(P)\) supplies the required order inequality by definition.  The second
positive result is exact: arbitrary real approximation inside the printed
closed ray is neither weaker nor stronger than the desired membership.  The
remaining IUT task is therefore not an open-ended appeal to approximation; it
is the exact same-pilot hull typing (1.4)--(1.5), the metric theorem (2.1), the
one-sided variant (3.1), or direct global region inclusion.

The fixed-error and qualitative-link readings have been refuted under all of
their stated hypotheses.  They may be discarded as standalone proof
mechanisms.  The full IUT route remains active because neither counterexample
satisfies the complete source hypotheses.  No unconditional `ABCConjecture`
term or abc counterexample is claimed.
