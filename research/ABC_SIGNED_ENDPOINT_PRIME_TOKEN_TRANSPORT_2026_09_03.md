# Signed endpoint core defect and monotone prime-token transport

**Date:** 2026-09-03
**Status:** unconditional finite identities and transport implications; a
companion complete-premise prime-square obstruction retires the ordered
uniform small-unmatched-mass gate.

**Claim discipline:** this note does not prove or disprove the \(abc\)
conjecture. It retains the endpoint token construction while separating the
false ordered gate from later bidirectional successors.

## 1. Scope and relation to the earlier endpoint notes

Let

\[
 a,b,c\in\mathbf Z_{>0},\qquad a+b=c,
 \qquad \gcd(a,b)=1.
 \tag{1.1}
\]

The three integers are pairwise coprime. Write

\[
 \operatorname{rad}(n)=\prod_{p\mid n}p,
 \qquad
 \operatorname{core}(n)=\frac{n}{\operatorname{rad}(n)}.
 \tag{1.2}
\]

The earlier signed-square-radical defect uses the two large endpoints and is
equivalent, after a height corridor, to \(abc\). The canonical powerful
residual core instead writes each endpoint as its radical times its powerful
part. The present construction takes a different exact slice: it places every
excess prime layer of the sum endpoint \(c\) on one side and every distinct
prime of \(ab\) on the other, and asks whether logarithmic mass can move
monotonically between those two finite sets.

## 2. Exact endpoint-core identity

Put

\[
 K_c=\operatorname{core}(c),\qquad
 E_{ab}=\operatorname{rad}(a)\operatorname{rad}(b),\qquad
 R=\operatorname{rad}(abc).
\]

### Proposition 2.1 (multiplicative endpoint-core balance)

Every triple satisfying (1.1) obeys

\[
 E_{ab}=\operatorname{rad}(ab),\qquad
 R=E_{ab}\operatorname{rad}(c),
 \tag{2.1}
\]

and

\[
 \boxed{E_{ab}c=R K_c.}
 \tag{2.2}
\]

Consequently its **signed endpoint-core defect**

\[
 \delta_c(a,b,c):=\log K_c-\log E_{ab}
 \tag{2.3}
\]

satisfies the exact identity

\[
 \boxed{\delta_c(a,b,c)=\log c-\log R.}
 \tag{2.4}
\]

**Proof.** Pairwise coprimality makes the radical multiplicative across the
three arms, which proves (2.1). Since
\(c=\operatorname{rad}(c)K_c\),

\[
 E_{ab}c
 =E_{ab}\operatorname{rad}(c)K_c
 =R K_c.
\]

All four factors are positive. Taking logarithms in (2.2) and rearranging
gives (2.4). \(\square\)

Thus the standard \(abc\) excess is exactly the excess multiplicity on the
\(c\)-arm after charging the complete squarefree support of the other two
arms.

## 3. Actual prime-layer tokens

For \(p\mid c\), write \(e_p=v_p(c)\). Define the finite source token set

\[
 \mathcal S_c=
 \{(p,j):p\mid c,\ 1\le j<e_p\},
 \qquad w(p,j)=\log p.
 \tag{3.1}
\]

There are \(e_p-1\) source tokens above the first radical copy of \(p\).
Define the sink set

\[
 \mathcal T_{ab}=\{q:q\mid ab\},
 \qquad v(q)=\log q,
 \tag{3.2}
\]

where each distinct prime occurs once.

### Proposition 3.1 (token mass identities)

The two total masses are

\[
 \sum_{s\in\mathcal S_c}w(s)=\log K_c,
 \qquad
 \sum_{q\in\mathcal T_{ab}}v(q)=\log E_{ab}.
 \tag{3.3}
\]

In particular, their difference is \(\delta_c(a,b,c)\).

**Proof.** Prime factorization gives

\[
 K_c=\prod_{p\mid c}p^{e_p-1}.
\]

Taking logarithms gives the first equality. The second follows from
\(E_{ab}=\operatorname{rad}(ab)=\prod_{q\mid ab}q\). Proposition 2.1 then
identifies the difference. \(\square\)

## 4. Fractional monotone transport

A **fractional monotone endpoint transport** is a collection of real numbers

\[
 F(s,q)\ge0
 \qquad(s\in\mathcal S_c,\ q\in\mathcal T_{ab})
\]

such that

\[
 \sum_qF(s,q)\le w(s),
 \qquad
 \sum_sF(s,q)\le v(q),
 \tag{4.1}
\]

and

\[
 F((p,j),q)>0\quad\Longrightarrow\quad p\le q.
 \tag{4.2}
\]

Condition (4.2) is the local structure: logarithmic mass at a larger source
prime cannot be paid by a smaller external-support prime. The zero flow is
always allowed, so existence is trivial; the arithmetic content is whether
one can make the unmatched mass small.

Define total carried mass, unmatched source mass, and unused sink capacity by

\[
 C(F)=\sum_{s,q}F(s,q),
\]

\[
 U(F)=\sum_s\left(w(s)-\sum_qF(s,q)\right),
 \qquad
 V(F)=\sum_q\left(v(q)-\sum_sF(s,q)\right).
 \tag{4.3}
\]

Both \(U(F)\) and \(V(F)\) are nonnegative by (4.1).

### Theorem 4.1 (exact transport accounting)

Every fractional monotone endpoint transport satisfies

\[
 \boxed{U(F)=\delta_c(a,b,c)+V(F).}
 \tag{4.4}
\]

In particular,

\[
 \delta_c(a,b,c)\le U(F),
 \qquad
 \log c\le\log R+U(F).
 \tag{4.5}
\]

**Proof.** Finite interchange of summation gives the same carried mass from
the row and column sums. Therefore

\[
 U(F)=\sum_sw(s)-C(F),
 \qquad
 V(F)=\sum_qv(q)-C(F).
\]

Subtracting these equalities and using Proposition 3.1 gives
\(U(F)-V(F)=\delta_c(a,b,c)\), which is (4.4). Since \(V(F)\ge0\), the first
inequality in (4.5) follows. The second follows from (2.4). \(\square\)

### Theorem 4.2 (weighted Hall threshold obstruction)

For a natural-number threshold \(t\), put

\[
 S_{>t}=\sum_{(p,j)\in\mathcal S_c,\ p>t}\log p,
 \qquad
 T_{>t}=\sum_{q\in\mathcal T_{ab},\ q>t}\log q.
 \tag{4.6}
\]

Every fractional monotone endpoint transport satisfies

\[
 \boxed{U(F)\ge S_{>t}-T_{>t}.}
 \tag{4.7}
\]

**Proof.** By (4.2), mass emitted by a source prime \(p>t\) can enter only a
sink prime \(q\ge p>t\). Hence the total mass carried from the source tail is
at most \(T_{>t}\). The unmatched mass inside that source tail is therefore
at least \(S_{>t}-T_{>t}\). It is at most the full unmatched mass because
every row deficit in (4.3) is nonnegative. This proves (4.7). \(\square\)

Theorem 4.2 is a family of local obstructions absent from the scalar core
identity. This note does not claim or formalize the converse max-flow formula
for the nested threshold graph.

## 5. The precise sufficient global gate

Consider the following statement.

> **Uniform fractional transport gate.** For every \(\varepsilon>0\), there
> is a constant \(C_\varepsilon\) such that every positive primitive triple
> admits a fractional monotone endpoint transport \(F\) satisfying
> \[
> U(F)\le\varepsilon\log R+C_\varepsilon.
> \tag{5.1}
> \]

### Theorem 5.1 (the transport gate implies standard \(abc\))

If the uniform fractional transport gate holds, then for every
\(\varepsilon>0\),

\[
 \log c\le(1+\varepsilon)\log\operatorname{rad}(abc)+C_\varepsilon
 \tag{5.2}
\]

for every positive primitive triple.

**Proof.** Choose the flow supplied by (5.1). Theorem 4.1 gives

\[
 \log c\le\log R+U(F)
 \le(1+\varepsilon)\log R+C_\varepsilon.
\]

This is the standard logarithmic \(abc\) statement. \(\square\)

No construction satisfying (5.1) is proved here. The weighted Hall lower
bounds in Theorem 4.2 are concrete tests that any proposed construction must
pass.

## 6. Complete-premise counterexamples to integral strengthenings

Call a transport **full integral** if every source layer is assigned to one
distinct sink prime and a token over \(p\) may be assigned only to
\(q\ge p\).

### Counterexample 6.1 (cardinality obstruction)

The primitive nonunit triple

\[
 3+13=16
\]

has source multiset \(\{2,2,2\}\) and sink set \(\{3,13\}\). There is no
injection from three source layers to two sinks. Thus universal full integral
matching is false, even though every possible edge satisfies the prime-size
condition.

### Counterexample 6.2 (threshold obstruction despite favorable total mass)

The primitive nonunit triple

\[
 9+16=25
\]

has one source token over \(5\) and sink primes \(\{2,3\}\). Hence no
monotone edge exists. Nevertheless

\[
 K_c=5\le6=E_{ab}.
\]

Thus the aggregate inequality \(K_c\le E_{ab}\) does not imply a full
integral dominance matching. The fractional transport has unmatched mass
\(\log5\), while the signed core defect is \(\log(5/6)<0\); the difference is
genuine matching inefficiency.

Both examples satisfy positivity, the additive equation, coprimality, and
nonunit-arm hypotheses. They retire only the stated integral claims. On their
own they do not refute the fractional small-unmatched-mass gate (5.1); the
separate infinite prime-square family does.

## 7. An infinite full-premise obstruction at zero epsilon

The next family shows that even scalar endpoint-core domination cannot hold
with one fixed multiplicative constant when no \(R^\varepsilon\) allowance is
present.

For \(k\ge0\), set

\[
 X_k=4^{3^k},\qquad P_k=(1,X_k-1,X_k).
 \tag{7.1}
\]

Every \(P_k\) is a positive primitive \(abc\) triple.

### Proposition 7.1 (unbounded zero-epsilon endpoint-core ratio)

For every \(k\ge0\),

\[
 3^{k+1}\mid X_k-1,
 \qquad
 3^k\operatorname{rad}(X_k-1)\le X_k-1,
 \tag{7.2}
\]

and

\[
 \frac{\operatorname{core}(X_k)}
 {\operatorname{rad}(1)\operatorname{rad}(X_k-1)}
 >\frac{3^k}{2}.
 \tag{7.3}
\]

Consequently, for every integer \(K\ge0\), some positive primitive triple
satisfies

\[
 \operatorname{core}(c)>K\operatorname{rad}(a)\operatorname{rad}(b).
 \tag{7.4}
\]

**Proof.** We first prove the divisibility in (7.2) by induction. At
\(k=0\), \(X_0-1=3\). If \(3^{k+1}\mid X_k-1\), then
\(X_k\equiv1\pmod3\), so

\[
 X_k^2+X_k+1\equiv3\equiv0\pmod3.
\]

Using

\[
 X_{k+1}-1=X_k^3-1=(X_k-1)(X_k^2+X_k+1)
\]

gives \(3^{k+2}\mid X_{k+1}-1\).

Write \(X_k-1=3^{k+1}u\). Radical submultiplicativity and
\(\operatorname{rad}(3^{k+1})=3\) give

\[
 \operatorname{rad}(X_k-1)
 \le3\operatorname{rad}(u)\le3u,
\]

which is the second inequality in (7.2). Since \(X_k\) is a positive power
of \(2\), its radical is \(2\) and its core is \(X_k/2\). Hence

\[
 \frac{\operatorname{core}(X_k)}{\operatorname{rad}(X_k-1)}
 \ge \frac{(X_k/2)3^k}{X_k-1}>\frac{3^k}{2}.
\]

Finally choose \(k\) with \(3^k>2K\); for example, the elementary bound
\(2K<3^{2K+1}\) permits \(k=2K+1\). Then (7.3) gives (7.4). \(\square\)

This is an actual infinite-quantifier counterexample to fixed-constant,
zero-epsilon domination. This family alone does not refute \(abc\) or (5.1):
the lower bound
on the logarithmic defect certified by the repeated factor \(3\) is only
\(k\log3-\log2=\log(3^k/2)\), whereas
\(\log c=3^k\log4\). No upper bound on contributions from other repeated
primes is asserted.

## 8. Deterministic finite audit

The script

```text
research/computation/2026_09_03_signed_endpoint_prime_token_transport/
  search_endpoint_token_transport.py
```

was run as

```powershell
python research/computation/2026_09_03_signed_endpoint_prime_token_transport/search_endpoint_token_transport.py `
  --limit 5000 --lte-k-limit 12 `
  --output research/computation/2026_09_03_signed_endpoint_prime_token_transport/OUTPUT.json
```

It exhaustively scanned all \(3{,}795{,}230\) normalized primitive nonunit
triples with \(2\le a\le b\) and \(c\le5000\). The exact endpoint-core
identity had zero failures. Full integral dominance matching failed for
\(113{,}086\) triples, including \(113{,}027\) for which
\(K_c\le E_{ab}\). The first failure was \((3,13,16)\). An exact
nested-Hall test compares, at each source-prime cutoff, the integer products
whose logarithms are the source and sink upper-tail masses. It certified
zero-unmatched fractional feasibility for \(3{,}792{,}836\) triples and
failure for \(2{,}394\). The deterministic greedy fractional flow was
cross-checked against this exact classification; no asymptotic conclusion is
inferred from the finite computation.

All gcds, factorizations, valuations, identities, and candidate inequalities
are checked by exact integer arithmetic. Floating-point logarithms are used
only for displayed flow weights and rankings. The output separately checks
\(v_3(2^{2\cdot3^k}-1)=k+1\) for \(1\le k\le12\); this finite check is not
used as proof of Proposition 7.1.

## 9. Lean coverage and formalization boundary

The independent Lean companion formalizes, after the ordinary proofs above:

1. Propositions 2.1 and 3.1 with the repository's actual radical and natural
   factorization;
2. the finite weighted-flow accounting theorem and nonnegativity;
3. the weighted Hall threshold lower bound;
4. Theorem 5.1 with the exact \(\varepsilon,C\) quantifiers of
   `ABCConjecture`;
5. the two complete-premise finite counterexample certificates, including
   \(K_c=5\le6=E_{ab}\) for \((9,16,25)\); and
6. Proposition 7.1 through the integer factorization induction, its natural
   divisibility form, the radical budget, the primitive family, and the exact
   theorem
   \[
   \neg\exists K\in\mathbf N\ \forall P,
   \quad \operatorname{core}(c_P)\le
   K\operatorname{rad}(a_P b_P)
   =K\operatorname{rad}(a_P)\operatorname{rad}(b_P).
   \]

The companion is
`Lean/IUTThreeClosures/ABCSignedEndpointPrimeTokenTransport20260903.lean`;
its separate axiom inventory is
`Lean/IUTThreeClosures/ABCSignedEndpointPrimeTokenTransport20260903AxiomAudit.lean`.
The last theorem is precisely about natural multipliers. No extension here to
arbitrary real constants is claimed.

The paper-to-Lean declaration inventory is:

- Proposition 2.1: `externalRadical_eq_radical_a_mul_radical_b`,
  `externalRadical_mul_c_eq_totalRadical_mul_endpointCore`, and
  `log_c_sub_log_totalRadical_eq_signedEndpointCoreDefect`;
- Proposition 3.1: `sum_primeExcessTokenWeight_eq_log_powerfulPart`,
  `sum_primeSupportTokenWeight_eq_log_radical`, and the two
  `endpointPrimeFlow_*Mass_eq_*` specializations;
- Theorem 4.1: generic
  `MonotoneWeightedFlow.unmatchedMass_eq_defect_add_unusedCapacity` and the
  actual-prime consequences `signedEndpointCoreDefect_le_unmatchedMass` and
  `height_le_conductor_add_unmatchedMass`;
- Theorem 4.2:
  `MonotoneWeightedFlow.sourceTailMass_sub_sinkTailMass_le_unmatchedMass` and
  `endpointPrimeFlow_threshold_obstruction`, both with \(t\in\mathbf N\);
- Theorem 5.1: `UniformEndpointPrimeFlowBound` and
  `abc_of_uniformEndpointPrimeFlowBound`;
- Counterexamples 6.1 and 6.2:
  `threeThirteenSixteen_not_fullIntegralDominanceMatching`,
  `nineSixteenTwentyFive_not_fullIntegralDominanceMatching`, and the latter's
  separate core/radical comparison declarations; and
- Proposition 7.1:
  `three_pow_succ_dvd_four_pow_three_pow_sub_one`,
  `dyadicMersenneCoreDatum_radical_budget`, the cross-multiplied ratio theorem
  `dyadicMersenneCoreDatum_three_pow_mul_radical_lt_two_mul_core`, and
  `no_uniform_natural_endpointCore_domination`.

The original module does not assert the uniform flow construction (5.1), the
nested-graph max-flow converse, or any unconditional \(abc\) estimate. The
companion obstruction module proves the quantified negation of (5.1).

## 10. No-breakthrough statement

The exact identity (2.4) explains which multiplicity must be paid. Fractional
monotone transport adds a finite family of threshold constraints and hence is
not merely a new name for the scalar defect. The infinite family
\((1,p^2-1,p^2)\), with \(p\) running through odd primes, now proves that
those particular upper-tail constraints are uniformly too rigid: its source
prime \(p\) lies above every external sink prime. The exact proof and Lean
negation are recorded in
`ABC_ORDERED_PRIME_TRANSPORT_OBSTRUCTION_2026_09_03.md`.

The endpoint token route remains active under a changed geometry. Completely
unordered flow collapses to the positive part of the scalar defect, so the
next positive construction must permit downward edges while retaining an
independent displacement, multi-face, or homological cost. Such a successor
is not abandoned for being hard and is not asserted without proof.
