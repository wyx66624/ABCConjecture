# Anchored prefix fibres and weighted proper-face CRT flags

**Author:** ChatGPT  
**Date:** 2026-09-04  
**Status:** the finite propositions and counterexample below are proved; the
uniform **FCRT-1** estimate and the standard \(abc\) conjecture remain open.

## 1. Purpose and endpoint notation

This note isolates the exact part of Bae's anchored-fibre argument that can be
transferred to the endpoint residue cube. The transfer is positive but
conditional on an explicit finite entropy inequality. It controls both the
logarithmic weight of the packet removed by a prefix collision and the
cross-source proper face required by FCRT-1.

Let \(a,b,c>0\), \(a+b=c\), and \(\gcd(a,b)=1\). For a source prime
\(p^{e_p}\Vert c\), \(e_p\geq2\), put

\[
x_p=(e_p-1)\log p.
\]

Let \(J\) be the primes dividing \(ab\), put \(y_q=\log q\), and write
\(y(A)=\sum_{q\in A}y_q\). For a source face \(S\), write
\(x(S)=\sum_{p\in S}x_p\). As in the endpoint residue-cube note, let

\[
G_p=(\mathbb Z/p^{e_p}\mathbb Z)^\times,\qquad
\Phi_p(A)=\prod_{q\in A}g_{p,q},
\]

where \(g_{p,q}=q^{v_q(a)}\) on the \(a\)-arm and
\(g_{p,q}=q^{-v_q(b)}\) on the \(b\)-arm. Then

\[
\Phi_p(J)=-1,\qquad
p^{e_p}\mid a_A+b_A\quad\Longleftrightarrow\quad\Phi_p(A)=-1. \tag{1.1}
\]

For a source face \(S\), \(\Phi_S\) denotes the product of these coordinate
maps. A block \((S,T)\) is compatible when \(\Phi_S(T)=-1\), and saturated
when \(x(S)\leq y(T)\).

The revised proof in Ji Ho Bae,
[arXiv:2604.23784v3](https://arxiv.org/html/2604.23784v3), Lemma 5.1, says that
if a map from \(\{0,\ldots,m\}\) uses at most \(C\) codes and

\[
m+1>C(|\mathcal F|+1), \tag{1.2}
\]

then two equal-code indices have positive difference outside a prescribed
forbidden set \(\mathcal F\subseteq\{1,\ldots,m\}\). The proof anchors a
large fibre at its least index. No independence hypothesis is involved.

## 2. The exact zero-sum/proper-face dictionary

Fix a target source \(p\), a disjoint block source face \(S\), and a packet
\(T\subseteq J\) such that

\[
\Phi_S(T)=-1,\qquad \Phi_p(T)=-1,\qquad x(S)\leq y(T). \tag{2.1}
\]

The second condition is stronger than the definition of an FCRT-1 block, but
it is automatic for \(T=J\). Call a nonempty \(D\subseteq T\) a
\(p\)-zero-sum deletion when \(\Phi_p(D)=1\).

### Proposition 2.1 (complement dictionary)

For every \(p\)-zero-sum deletion \(D\subseteq T\), the packet

\[
U=T\setminus D \tag{2.2}
\]

is a nonempty proper subface of \(T\) and is compatible with the target
\(p\). Conversely, every proper \(p\)-compatible subface
\(U\subsetneq T\) arises from the zero-sum deletion \(D=T\setminus U\).

### Proof

Because \(D\) and \(U\) partition \(T\),

\[
\Phi_p(T)=\Phi_p(U)\Phi_p(D).
\]

Thus \(\Phi_p(D)=1\) and \(\Phi_p(T)=-1\) give
\(\Phi_p(U)=-1\). The set \(D\) is nonempty, so \(U\subsetneq T\). If
\(U\) were empty, then \(D=T\) and \(\Phi_p(T)=1\), contrary to
\(\Phi_p(T)=-1\). Here \(1\ne-1\) because \(p^{e_p}\geq4\).

Conversely, if both \(T\) and \(U\) have target label \(-1\), cancellation
in \(G_p\) gives \(\Phi_p(T\setminus U)=1\). Properness makes the deletion
nonempty. QED.

The block surplus is \(\sigma=y(T)-x(S)\), and the FCRT-1 credit carried by
the face \(U=T\setminus D\) is

\[
\rho=\min\{\sigma,y(U)\}
=\min\{y(T)-x(S),y(T)-y(D)\}. \tag{2.3}
\]

Consequently the entire block surplus is reusable exactly when

\[
y(D)\leq x(S). \tag{2.4}
\]

This is the weighted zero-sum problem that the prefix argument must solve.

## 3. Anchored weighted zero-sum flag theorem

Choose a nonempty reservoir \(K\subseteq T\) and order it as
\(K=(q_1,\ldots,q_m)\). Let

\[
H=\langle g_{p,q}:q\in K\rangle\leq G_p,\qquad W=y(K), \tag{3.1}
\]

and fix \(L>0\). Put \(N=\lceil W/L\rceil\). Partition \([0,W]\) into
\(N\) consecutive cells of diameter at most \(L\). Let
\(\mathcal F\subseteq\{1,\ldots,m\}\) be any forbidden set of prefix gaps.
Nonemptiness of \(K\), together with \(y_q=\log q>0\), gives \(m\geq1\),
\(W>0\), and hence \(N\geq1\).

### Theorem 3.1 (anchored prefix to cross-fibre FCRT flag)

Assume (2.1) and

\[
m+1>|H|N(|\mathcal F|+1). \tag{3.2}
\]

Then there are \(0\leq i<j\leq m\), with
\(j-i\notin\mathcal F\), such that

\[
D=\{q_{i+1},\ldots,q_j\}
\]

is nonempty and satisfies

\[
\Phi_p(D)=1,\qquad y(D)\leq L. \tag{3.3}
\]

Therefore \(U=T\setminus D\) is a legal nonempty proper target face for the
block \((S,T)\), and its reusable credit obeys

\[
\rho\geq\min\{y(T)-x(S),y(T)-L\}. \tag{3.4}
\]

If \(L\leq x(S)\), then \(\rho=y(T)-x(S)\): the complete block surplus is
reused.

### Proof

For \(0\leq k\leq m\), let

\[
P_k=\{q_1,\ldots,q_k\},\qquad
R_k=\Phi_p(P_k),\qquad Z_k=y(P_k).
\]

Code \(k\) by the pair consisting of \(R_k\in H\) and the weight cell
containing \(Z_k\in[0,W]\). There are at most \(|H|N\) codes. Condition
(3.2) and Bae's anchored-fibre lemma give \(i<j\) with the same code and
\(j-i\notin\mathcal F\).

Equality of the residue coordinates gives

\[
1=R_jR_i^{-1}=\prod_{r=i+1}^{j}g_{p,q_r}=\Phi_p(D).
\]

Equality of the weight-cell coordinates gives

\[
y(D)=Z_j-Z_i\leq L.
\]

Proposition 2.1 turns \(D\) into the legal cross-fibre flag
\(U=T\setminus D\). Since \(y(U)=y(T)-y(D)\geq y(T)-L\), formula (2.3)
gives (3.4). If \(L\leq x(S)\), then
\(y(T)-L\geq y(T)-x(S)=\sigma\), so the minimum in (2.3) is \(\sigma\).
QED.

The gap condition survives intact. Thus a future arithmetic estimate may put
every gap producing a bad tail, an unwanted cardinality, or another
difference-dependent obstruction into \(\mathcal F\), exactly as Bae does.
The theorem does not claim that such a small forbidden set is presently
available for endpoint packets.

### Corollary 3.2 (light-reservoir criterion)

If

\[
|K|\geq|H|,\qquad y(K)\leq x(S), \tag{3.5}
\]

then the complete surplus of \((S,T)\) can be sent to \(p\).

### Proof

Take \(L=x(S)\) and \(\mathcal F=\varnothing\). Since \(W\leq L\), one
weight cell suffices, so (3.2) is \(|K|+1>|H|\). Apply Theorem 3.1. QED.

This is also the ordinary partial-sum pigeonhole proof: the \(|K|+1\)
prefix products lie in \(H\), so \(|K|\geq|H|\) forces two equal prefixes.
The anchored formulation retains forbidden-gap avoidance and weight cells.

### Corollary 3.3 (full packet and exact scalar boundary)

Suppose \(I\setminus\{p\}=S\ne\varnothing\), \(x(S)\leq Y=y(J)\), and the
hypotheses of Theorem 3.1 hold with \(T=J\) and \(L\leq x(S)\). Then the
constructed one-block FCRT-1 configuration has

\[
B_{\rm FCRT}=(x_p-(Y-x(S)))_+=(X-Y)_+. \tag{3.6}
\]

Hence it attains the universal once-charged lower bound.

### Proof

The full packet is compatible with every source coordinate by (1.1), so it
meets (2.1). The block covers \(S\), consumes all sinks, and reuses its
entire surplus \(Y-x(S)\) at the only residual source \(p\). Its clipped
residual is the left side of (3.6), and

\[
x_p-(Y-x(S))=x_p+x(S)-Y=X-Y.
\]

The general FCRT mass bridge gives the reverse inequality for the optimized
boundary. QED.

Equation (3.6) removes the finite fragmentation loss at such a point. It is
not an \(abc\) bound: controlling \((X-Y)_+\) uniformly is the original
global problem.

## 4. Exact recovery of the two motivating flags

For \((a,b,c)=(1,675,676)\), take \(S=\{13\}\), \(p=2\),
\(T=J=\{3,5\}\), and \(K=\{5\}\). Modulo \(4\),

\[
g_{2,5}=5^{-2}=1.
\]

Thus \(H\) is trivial, \(|K|=|H|=1\), and
\(y(K)=\log5<\log13=x(S)\). Corollary 3.2 produces
\(D=\{5\}\) and \(U=\{3\}\), precisely the full-surplus flag in the endpoint
residue-cube note.

For \((1,65024,65025)\), take \(S=\{5,17\}\), \(p=3\),
\(T=J=\{2,127\}\), and \(K=\{127\}\). Modulo \(9\),
\(g_{3,127}=127^{-1}=1\). Taking \(L=\log127\), Theorem 3.1 gives
\(D=\{127\}\), \(U=\{2\}\), and

\[
\rho\geq
\min\left\{\log\frac{254}{85},\log\frac{254}{127}\right\}
=\log2.
\]

Here \(U\) itself has weight \(\log2\), so equality holds. The theorem thus
also recovers the example where the proper-face cap is active.

## 5. Complete-premise counterexample to the naive Boolean shortcut

The following tempting statement is false:

> **Naive shortcut NBF.** If \(2^{|J|}>|G_p|\), then the Boolean packet cube
> contains a nonempty proper \(p\)-compatible packet; consequently a saturated
> full block disjoint from \(p\) has a target-\(p\) FCRT flag.

Take the actual primitive endpoint

\[
(a,b,c)=(1,4715,4716),
\]

with exact factorizations

\[
4715=5\cdot23\cdot41,\qquad
4716=2^2\cdot3^2\cdot131. \tag{5.1}
\]

All premises of NBF are met for \(p=3\):

1. \(a+b=c\) and \(\gcd(a,b)=1\).
2. \(p^2=9\mid c\), so \(p\) is a source and
   \(|G_p|=|(\mathbb Z/9\mathbb Z)^\times|=6\).
3. \(J=\{5,23,41\}\), hence \(2^{|J|}=8>6\).
4. The disjoint full block \(S=\{2\}\), \(T=J\) is compatible and saturated:
   \(4\mid c\) and \(x(S)=\log2<\log4715=y(J)\).

Nevertheless, every sink prime is \(5\pmod9\), and, because all three occur
to the first power on the \(b\)-arm,

\[
g_{3,q}=q^{-1}=2\pmod9.
\]

For a packet \(U\subseteq J\), therefore,

\[
\Phi_3(U)=2^{|U|}\pmod9.
\]

A nonempty proper packet has size one or two and hence label \(2\) or \(4\),
never \(-1=8\pmod9\). Equivalently,

\[
1+b_U\equiv6\pmod9\quad(|U|=1),\qquad
1+b_U\equiv8\pmod9\quad(|U|=2).
\]

Only the full packet, of size three, is \(3\)-compatible. An FCRT target face
must be a proper subface of some \(T\subseteq J\), so no FCRT flag can target
\(p=3\) at this endpoint. In particular, the saturated full block in item 4
has no such flag.

The Boolean pigeonhole collision still exists. It occurs between distinct
packets of the same cardinality: all singletons have label \(2\), and all
doubletons have label \(4\). Such packets are incomparable. Cancelling them
gives a signed relation, not a positive zero-sum deletion. This is exactly why
a raw Boolean collision cannot by itself create a proper face.

This counterexample retires **only NBF**, the implication from the raw count
\(2^{|J|}>|G_p|\) to a proper target face. It does not refute Theorem 3.1:
here \(H=\langle2\rangle=(\mathbb Z/9\mathbb Z)^\times\), so
\(|K|\leq3<6=|H|\), and the anchored entropy premise fails. It does not
refute FCRT-1, SCRT-0, the endpoint residue-cube route, or \(abc\).

## 6. Exact remaining bottleneck

For a jointly compatible packet \(T\), define its target-\(p\) weighted
zero-sum radius by

\[
\zeta_p(T)=
\min\{y(D):\varnothing\ne D\subseteq T,\ \Phi_p(D)=1\},
\]

with value \(+\infty\) if no such deletion exists. Proposition 2.1 says that
proper \(p\)-faces of \(T\) are exactly complements of the deletions counted
by \(\zeta_p(T)\), and full surplus reuse is equivalent to
\(\zeta_p(T)\leq x(S)\).

Theorem 3.1 bounds this radius when an ordered reservoir has enough prefix
samples relative to its residue subgroup and weight-cell entropy. What is not
known is a uniform endpoint theorem forcing

\[
|K|+1>
|\langle g_{p,q}:q\in K\rangle|
\left\lceil\frac{y(K)}{L}\right\rceil
(|\mathcal F|+1) \tag{6.1}
\]

with \(L\) small enough to give useful credit. In typical unrestricted data,
the subgroup can be as large as \(G_p\), whose order is on the prime-power
scale, while \(|K|\) counts only distinct sink primes. Bae's application has a
separate exponential tail estimate and an exponentially longer sample
interval; no endpoint analogue of those two inputs has yet been proved.

Using all \(2^{|K|}\) Boolean packets does not solve this mismatch, as the
complete-premise counterexample shows. The next positive problem is a
weighted zero-sum or Davenport-type estimate exploiting the special endpoint
relation \(\Phi_p(J)=-1\), or an arithmetic theorem forcing many light sink
generators into a small subgroup. Failure to prove that estimate is a
bottleneck, not grounds for abandoning the parent route.

## 7. Formalization boundary

The companion Lean module formalizes the finite anchored-fibre selection
kernel, additive complement-zero compatibility, the credit inequalities, and
the exact integer arithmetic at \(4715\). Its weighted theorem takes a finite
cell code together with the proved diameter implication as input; it does not
formalize the elementary real-ceiling construction of the cells. It also does
not construct the concrete unit group \(G_p\) from an arbitrary endpoint,
postulate (6.1), or claim the uniform FCRT-1 gate. Those remain explicit
ordinary and formal obligations.
