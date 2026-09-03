# Synchronized divisor packets for primitive \(abc\) triples

**Date:** 2026-09-03
**Status:** the named finite propositions and the real-log finite-minimum quality bridge are Lean-closed; the radical-control gate is open
**Claim discipline:** this note does **not** prove the \(abc\) conjecture, any uniform upper bound for \(abc\) quality, or an eventual packet-compression theorem.

## 1. Purpose and scope

This note develops a structure read directly from

\[
  a+b=c,\qquad \gcd(a,b)=1,
\]

rather than replacing the standard \(abc\) quality by another mean.  The new object is a finite spectrum of simultaneous square-residue collisions inside the three divisor lattices of \(a,b,c\).  It remembers:

1. which prime powers belong to which arm;
2. how much of each arm exponent is retained by a divisor coordinate;
3. three coupled square-congruence conditions; and
4. the local unsquared sign selected by each odd prime power.

The exact results below are elementary but nontrivial: nonemptiness, a local-to-global product divisibility, an optimal-for-this-proof sixth-power height envelope, an integral synchronization index, odd-prime orientation channels, and rigidity of the canonical orientation.  A deterministic finite audit searches simultaneously for positive examples and for counterexamples to stronger candidate statements.

For the cleanest nondegenerate theory, Sections 2--8 assume

\[
  a,b,c\in\mathbf Z_{>0},\qquad a+b=c,\qquad \gcd(a,b)=1,
  \qquad a>1,\ b>1.
  \tag{1.1}
\]

The computation additionally orders \(a\le b\).  Unit-arm triples \(1+b=b+1\) are legitimate \(abc\) triples, but are excluded from the packet search and the rigidity theorem stated here; this is a scope restriction, not an assertion that they are exceptional for \(abc\).

## 2. Definition: synchronized divisor packet spectrum

For positive integers \(r,s\), put

\[
  \Delta(r,s):=|r^2-s^2|.
\]

A **synchronized divisor packet** for (1.1) is a triple \(Q=(x,y,z)\) such that

\[
\begin{aligned}
 &x>1,\quad y>1,\quad z>1,\\
 &x\mid a,\quad y\mid b,\quad z\mid c,\\
 &a\mid\Delta(y,z),\quad
   b\mid\Delta(x,z),\quad
   c\mid\Delta(x,y).
\end{aligned}
\tag{2.1}
\]

The finite set of all such packets is denoted

\[
  \mathscr S(a,b,c).
\]

The packet is **proper** if \(Q\ne(a,b,c)\).  Define

\[
\begin{aligned}
 D(Q)&:=\Delta(y,z)\Delta(x,z)\Delta(x,y),\\
 B(Q)&:=\max(y,z)^2\max(x,z)^2\max(x,y)^2,\\
 T(Q)&:=\max(x,y,z).
\end{aligned}
\tag{2.2}
\]

This is a spectrum rather than a single score: cardinality, proper strata, coordinate heights, the index in Section 4, and the orientation data in Section 6 can all differ.

## 3. Nonemptiness and the exact height envelope

### Proposition 3.1 (pairwise coprimality of packet coordinates)

If \(Q=(x,y,z)\in\mathscr S(a,b,c)\), then \(x,y,z\) are pairwise coprime and hence pairwise distinct.

**Proof.**  From \(a+b=c\) and \(\gcd(a,b)=1\), one obtains

\[
  \gcd(a,c)=\gcd(a,a+b)=1,
  \qquad
  \gcd(b,c)=\gcd(b,a+b)=1.
\]

Every common divisor of \(x\) and \(y\) divides \(a\) and \(b\), and similarly for the other two pairs.  Thus all three coordinate gcds are one.  Since every coordinate is greater than one, no two coordinates can be equal.  \(\square\)

### Proposition 3.2 (the full packet)

The full corner \(Q_0=(a,b,c)\) belongs to \(\mathscr S(a,b,c)\).  Consequently the packet spectrum is finite and nonempty.

**Proof.**  The divisor conditions are immediate.  Since \(c\equiv b\pmod a\), \(c\equiv a\pmod b\), and \(a\equiv-b\pmod c\), squaring gives

\[
  b^2\equiv c^2\pmod a,
  \qquad a^2\equiv c^2\pmod b,
  \qquad a^2\equiv b^2\pmod c.
\]

There are only finitely many triples of divisors of \(a,b,c\).  \(\square\)

### Theorem 3.3 (synchronized product and sixth-power envelope)

Every \(Q\in\mathscr S(a,b,c)\) satisfies

\[
  abc\mid D(Q)
  \quad\text{and}\quad
  abc\le D(Q)\le B(Q)\le T(Q)^6.
  \tag{3.1}
\]

**Proof.**  From (2.1), write

\[
  \Delta(y,z)=a\alpha,\qquad
  \Delta(x,z)=b\beta,\qquad
  \Delta(x,y)=c\gamma

\]

with \(\alpha,\beta,\gamma\in\mathbf Z_{\ge0}\).  Multiplication proves \(abc\mid D(Q)\).  Proposition 3.1 makes all three gaps positive, so \(D(Q)>0\); a positive multiple of \(abc\) is at least \(abc\).

For any positive \(r,s\),

\[
  \Delta(r,s)=\max(r,s)^2-\min(r,s)^2\le\max(r,s)^2.

\]

Multiplying the three inequalities gives \(D(Q)\le B(Q)\).  Each of the three pair maxima is at most \(T(Q)\), hence \(B(Q)\le T(Q)^6\).  \(\square\)

The pair-max expression \(B(Q)\), rather than \(T(Q)^6\), is the exact output of the proof and can be materially smaller.

## 4. The synchronization index and exact-gap stratum

Theorem 3.3 defines a positive integer

\[
  \kappa(Q):=\frac{D(Q)}{abc}\in\mathbf Z_{>0}.
  \tag{4.1}
\]

### Proposition 4.1 (index-one rigidity of the three gaps)

For \(Q\in\mathscr S(a,b,c)\),

\[
  \kappa(Q)=1
  \quad\Longleftrightarrow\quad
  \Delta(y,z)=a,
  \quad \Delta(x,z)=b,
  \quad \Delta(x,y)=c.
  \tag{4.2}
\]

**Proof.**  With \(\alpha,\beta,\gamma\) as in the proof of Theorem 3.3,

\[
  \kappa(Q)=\alpha\beta\gamma.

\]

All three factors are positive.  Their product is one exactly when all three are one.  The converse is immediate.  \(\square\)

Because \(c=a+b\), an index-one packet also satisfies

\[
  \Delta(x,y)=\Delta(y,z)+\Delta(x,z).
  \tag{4.3}
\]

Thus \(z^2\), and hence \(z\), lies between \(x^2,y^2\), respectively \(x,y\).  This ordering assertion uses all three exact equalities; it is not asserted for a general packet.

### Proposition 4.2 (an infinite exact-gap family)

For every integer \(t\ge2\), set

\[
\begin{aligned}
 a_t&=2t+1,\\
 b_t&=t(3t+2),\\
 c_t&=(t+1)(3t+1),\\
 Q_t&=(2t+1,t,t+1).
\end{aligned}
\tag{4.4}

Then \((a_t,b_t,c_t)\) satisfies (1.1), \(Q_t\in\mathscr S(a_t,b_t,c_t)\) is proper, and \(\kappa(Q_t)=1\).

**Proof.**  Direct expansion gives

\[
  a_t+b_t=3t^2+4t+1=(t+1)(3t+1)=c_t.

\]

Furthermore,

\[
  \gcd(2t+1,t)=1,

\]

and

\[
  2(3t+2)-3(2t+1)=1,

\]

so \(2t+1\) is coprime to both factors of \(b_t=t(3t+2)\).  The coordinate divisibilities follow directly from (4.4), and

\[
\begin{aligned}
 (t+1)^2-t^2 &= 2t+1=a_t,\\
 (2t+1)^2-(t+1)^2 &= t(3t+2)=b_t,\\
 (2t+1)^2-t^2 &= (t+1)(3t+1)=c_t.
\end{aligned}

\]

Proposition 4.1 now gives \(\kappa(Q_t)=1\).  Since \(b_t>t\) and \(c_t>t+1\), the packet is proper.  \(\square\)

This family also shows that no universal estimate \(abc\le T(Q)^r\) can hold for every synchronized packet with a fixed real exponent \(r<5\): here \(a_tb_tc_t\asymp18t^5\) and \(T(Q_t)=2t+1\asymp2t\).  It does **not** disprove a fifth-power estimate with a multiplicative constant.  The constant-one fifth-power estimate is separately disproved in Section 9.

The three identities in (4.4) are familiar square-difference algebra.  They are used here as one exact stratum of the packet spectrum; renaming those identities is not the claimed contribution.

## 5. A radical-height bridge with an explicit open gate

Let

\[
  R=\operatorname{rad}(abc),
  \qquad
  q(a,b,c)=\frac{\log c}{\log R}.
\]

Since \(R>1\) in the present scope, define the **synchronization energy**

\[
  \mathcal E_{\rm sync}(a,b,c)
  :=\min_{Q\in\mathscr S(a,b,c)}
  \frac{\log B(Q)}{\log R}.
  \tag{5.1}
\]

The minimum exists by Proposition 3.2.

### Theorem 5.1 (quality is bounded by packet energy)

Every nonunit primitive triple satisfies

\[
  q(a,b,c)\le\mathcal E_{\rm sync}(a,b,c).
  \tag{5.2}
\]

**Proof.**  For every packet \(Q\), Theorem 3.3 gives \(abc\le B(Q)\).  Also \(c\le abc\).  Hence

\[
  \log c\le\log B(Q).

\]

Divide by \(\log R>0\), then minimize over the finite nonempty spectrum.  \(\square\)

This produces a precise sufficient route to \(abc\):

> **Open synchronization-energy gate.** For every \(\varepsilon>0\), prove that all but finitely many nonunit primitive triples admit a synchronized packet \(Q\) with
> \[
>   B(Q)\le R^{1+\varepsilon}.
>   \tag{5.3}
> \]

Theorem 5.1 would then give \(q\le1+\varepsilon\).  No estimate resembling (5.3) is proved here.  It is stronger than the desired \(abc\) inequality at the packet level, and the finite data in Section 10 is adverse rather than supportive: the largest-quality triples in the search often have only the full packet and therefore have large synchronization energy.  The algebraic layer identifies a testable gate; it does not cross it.

## 6. Odd-prime orientation channels

The square congruence on the \(a\)-arm factors as

\[
  y^2-z^2=(y-z)(y+z).
\]

Let \(p^e\Vert a\) with \(p\) odd.  Pairwise coprimality of the arms implies \(p\nmid yz\).  If \(p\) divided both \(y-z\) and \(y+z\), it would divide \(2y\) and \(2z\), hence \(y,z\), a contradiction.  Euclid's lemma for the prime power therefore gives exactly one channel:

\[
  p^e\mid y-z
  \quad\text{or}\quad
  p^e\mid y+z,
  \tag{6.1}

\]

but not both.  The same argument applies cyclically to prime powers on the \(b\)- and \(c\)-arms.

Different odd prime powers of one composite arm may choose different signs.  Thus a square congruence modulo the whole arm need not lift to one global congruence \(y\equiv z\pmod a\) or \(y\equiv-z\pmod a\).  This **orientation fragmentation** is part of the packet data.  At the unique possible even arm, the two linear factors need not be coprime, so the \(2\)-primary channel must be kept separate.

A useful sign-free allocation identity is the following standard gcd lemma.  If \(\gcd(u,v)=1\) and \(n\mid uv\), then

\[
  \gcd(n,u)\gcd(n,v)=n.
  \tag{6.2}

\]

Applied to coprime odd parts of the two square-difference factors, it recovers the exact amount of the modulus sent into each channel.

## 7. Canonical orientation is globally rigid

Call a packet \(Q=(x,y,z)\) **canonically oriented** if it uses, at the level of the whole three arm moduli, the signs visible in \(a+b=c\):

\[
  y\equiv z\pmod a,
  \qquad x\equiv z\pmod b,
  \qquad x\equiv-y\pmod c.
  \tag{7.1}

The last congruence is equivalently \(c\mid x+y\).

### Theorem 7.1 (canonical-orientation rigidity)

The only canonically oriented synchronized divisor packet is the full packet:

\[
  Q=(a,b,c).
  \tag{7.2}

\]

**Proof.**  Divisibility and positivity give \(x\le a\), \(y\le b\), and \(z\le c\).  Since \(c\mid x+y\) and \(x+y>0\),

\[
  c\le x+y\le a+b=c.

\]

Therefore \(x+y=a+b\).  Together with \(x\le a\) and \(y\le b\), this forces \(x=a\) and \(y=b\).

We next show \(c<ab\).  Because \(a,b>1\), one has \((a-1)(b-1)\ge1\).  Equality would force \(a=b=2\), contradicting \(\gcd(a,b)=1\).  Hence \((a-1)(b-1)\ge2\), equivalently \(a+b<ab\).

After substituting \(x=a,y=b\), (7.1) says that \(z\) and \(c=a+b\) have the same residue modulo both \(a\) and \(b\).  The coprime Chinese remainder theorem gives

\[
  z\equiv c\pmod{ab}.

\]

But \(0<z\le c<ab\), so \(z=c\).  \(\square\)

Consequently every proper packet has a genuine orientation defect: at least one whole-arm canonical congruence in (7.1) fails.  On odd prime powers this failure can be resolved into an opposite sign or a fragmented collection of signs; the even arm retains its separate \(2\)-adic ambiguity.

## 8. Comparison with Sankaran's packing efficiency

Sankaran, *Variants on the \(abc\)-Conjecture using Alternative Quality Metrics*, arXiv:2606.08416v1 (2026), writes the distinct primes dividing \(abc\) as \(p_1,\dots,p_\omega\) and defines

\[
  A=\frac1\omega\sum_i\log p_i,
  \qquad
  G=\left(\prod_i\log p_i\right)^{1/\omega},
  \qquad
  \eta=G/A.

\]

At \(\omega\ge2\), the strict AM--GM inequality gives \(0<\eta<1\).  The paper's exact factorization is

\[
  q_s=\eta q_{\rm DGM},
  \qquad
  q_{\rm DGM}=\frac{\log c}{\omega G}.
  \tag{8.1}

\]

The synchronized packet spectrum is not a renaming of \(A,G,\eta\), or \(q_{\rm DGM}\):

* \(\eta\) depends only on the unordered set of distinct prime logarithms;
* the packet spectrum depends on arm assignment, exponent caps in the divisor lattices, and three simultaneous modular incidence conditions;
* packet orientations retain local sign data that no symmetric mean of the prime logarithms records.

There is a complete-premise finite witness to this distinction.  The primitive triples

\[
  (2,3,5)\quad\text{and}\quad(3,5,8)

\]

have the same radical \(30\), hence the same distinct-prime set and the same packing efficiency \(\eta\).  In the exact divisor enumeration, the first has only its full packet, whereas the second also has the proper packet \((3,5,2)\).  Thus \(\eta\) does not determine the packet spectrum.  Equation (8.1) remains valid and is checked numerically in the reproducible output; it serves as a comparison identity, not as an input to Theorems 3.3 or 7.1.

## 9. Full-premise counterexamples to stronger candidates

Only examples satisfying every condition in (1.1) and (2.1) are used to retire a candidate.

1. **The full corner need not be unique.**  For \((a,b,c)=(3,5,8)\), \(Q=(3,5,2)\) is proper and
   \[
     (\Delta(5,2),\Delta(3,2),\Delta(3,5))=(21,5,16),
   \]
   divisible componentwise by \((3,5,8)\).

2. **The cubic height bound fails.**  For \((5,7,12)\), \(Q=(5,7,2)\) is synchronized, but
   \[
     abc=420>7^3=T(Q)^3.
   \]

3. **The quartic bound and \((xyz)^2\) bound fail.**  For \((5,16,21)\), \(Q=(5,2,3)\) has exact gaps \((5,16,21)\), while
   \[
     abc=1680>5^4=625,
     \qquad
     abc=1680>(5\cdot2\cdot3)^2=900.
   \]

4. **The constant-one fifth-power bound fails.**  For
   \[
     (a,b,c)=(385,527,912),
     \qquad Q=(7,31,24),
   \]
   the gaps are exactly \((385,527,912)\), so all packet premises hold and \(\kappa=1\).  Nevertheless
   \[
     abc=185040240>31^5=28629151.
   \]

These examples do not disprove the proved pair-max/sixth-power bound.  They also do not settle whether some universal constant times \(T^5\) might hold.

## 10. Deterministic finite audit

Artifacts:

* `research/computation/2026_09_03_synchronized_divisor_packets/search_synchronized_packets.py`
* `research/computation/2026_09_03_synchronized_divisor_packets/OUTPUT.json`
* `research/computation/2026_09_03_synchronized_divisor_packets/RUN.log`

Exact command:

```powershell
python research/computation/2026_09_03_synchronized_divisor_packets/search_synchronized_packets.py `
  --limit 5000 --exhaustive 1000 --top-quality 200 `
  --quality-threshold 1.0 --family-limit 100000 `
  --output research/computation/2026_09_03_synchronized_divisor_packets/OUTPUT.json
```

The output records script SHA-256

```text
55a322658e930587fda58d07dd3c84ee3c42b5795da3c2a94be6d58e980cb28e
```

and reports:

| item | result |
|---|---:|
| primitive triples scanned with \(c\le5000\), \(2\le a\le b\) | 3,795,230 |
| triples with packets fully enumerated | 151,244 |
| packets found | 151,711 |
| proper packets found | 467 |
| exact-gap packets found | 105 |
| canonical-orientation counterexample | none in the enumerated domain |
| explicit family audit | no failure for \(2\le t\le100000\) |

The packet enumeration is exhaustive for every normalized primitive triple with \(c\le1000\).  For \(1000<c\le5000\), it covers the top 200 standard-quality triples and every triple with standard quality at least one.  The initial primitive-triple scan is exhaustive through \(c=5000\).

The 20 highest-quality triples in that range all have only the full packet.  For example, \((3,125,128)\) has

\[
  q_s=1.4265653296,
  \quad \eta=0.9439249502,
  \quad q_{\rm DGM}=1.5113122387,

\]

and the output verifies \(\eta q_{\rm DGM}=q_s\), but its minimum synchronization energy is approximately \(8.54545\).  This finite observation weighs against treating (5.3) as already plausible.  It neither proves eventual rigidity nor refutes an all-but-finitely-many statement.

Every enumerated packet was checked by exact integer assertions for positivity, \(abc\mid D(Q)\), \(abc\le B(Q)\), and \(abc\le T(Q)^6\).  Floating-point logarithms are used only for ranking and reported ratios, never for packet membership or divisibility.

## 11. Formalization boundary and declaration inventory

The independent module `Lean/IUTThreeClosures/ABCSynchronizedDivisorPackets20260903.lean` formalizes the named finite statements as follows.

| paper statement | Lean declarations | status |
|---|---|---|
| Proposition 3.1 | `SynchronizedPacket.coprime_xy`, `coprime_xz`, `coprime_yz`, `x_ne_y`, `x_ne_z`, `y_ne_z` | Lean-closed |
| Proposition 3.2 | `fullPacket`, `synchronizedPacketFintype`, `finite_synchronizedPacket` | Lean-closed |
| Theorem 3.3 | `modulusProduct_dvd_gapProduct`, `modulusProduct_le_gapProduct`, `gapProduct_le_pairMaxBound`, `pairMaxBound_le_height_pow_six`, and the two composed bounds | Lean-closed |
| Proposition 4.1 | `synchronizationIndex_eq_one_iff_exactGaps` | Lean-closed |
| Proposition 4.2 | `family_sum`, `family_coprime`, `family_exact_gaps`, `familyDatum`, `familyPacket`, `familyPacket_y_ne_full` | Lean-closed |
| odd-prime channel algebra | `primePower_orientation_channel`, `coprime_channel_allocation` | generic exact core Lean-closed; the short derivation of its odd/coprime antecedent is paper-level |
| Theorem 7.1 | `SynchronizedPacket.canonicalOrientation_rigid` | Lean-closed |
| Theorem 5.1 | `abcRadical`, `standardQuality`, `packetEnergy`, `standardQuality_le_packetEnergy`, `minimumPacketEnergy`, `standardQuality_le_minimumPacketEnergy` | Lean-closed with the actual squarefree radical, `Real.log`, and the actual finite packet spectrum |
| Section 9 counterexamples | `cornerCounterexamplePacket_ne_full`, `cubicCounterexamplePacket_fails_height_pow_three`, the two `quarticCounterexamplePacket_fails_*` declarations, and `quinticCounterexamplePacket_fails_height_pow_five` | each datum and packet is an explicit Lean structure satisfying every premise |

The companion `Lean/IUTThreeClosures/ABCSynchronizedDivisorPackets20260903AxiomAudit.lean` inventories these declarations.  Its output contains only `propext`, `Classical.choice`, and `Quot.sound`.  There is no `sorry`, `admit`, declaration of a new axiom, finite-search oracle, or asymptotic radical-compression assumption.

The finite search and the open all-but-finitely-many gate (5.3) are deliberately absent from the Lean module.  The quality majorant is now formalized, but no upper bound on `minimumPacketEnergy` is assumed or proved.  Thus Lean-closed applies to the exact bridge \(q_s\le\mathcal E_{\rm sync}\), never to the global radical-compression gate.

## 12. Exact \(abc\) gap and no-breakthrough statement

The route currently stops at (5.3).  The identity \(a+b=c\) produces the packet spectrum and forces (3.1) and (7.2), but none of those statements controls the smallest pair-max bound by \(\operatorname{rad}(abc)^{1+\varepsilon}\).  The full packet alone yields a bound on the order of \(c^6\), which contains no new radical saving.  The finite audit shows that proper packets can be absent even among conspicuous high-quality triples.

Accordingly:

* no open gate is assumed;
* no (abc) estimate is derived;
* no novelty priority beyond this project is claimed;
* no conflict with Sankaran's exact factorization is asserted;
* this is a finite structural invariant plus an explicit, still-open global gate.

## Appendix A. Required correction to the older Steinberg report

The older umbrella-style report `research/ABC_STEINBERG_VALUATION_CONTACT_SURFACE_2026_09_02.md`, lines 763--765 in the 2026-09-03 checkout, still describes the integer exponent-gcd bridge as paper-only.  It should be replaced during integration, but is deliberately not edited by this task, with:

> Lean now formalizes the positive-integer exponent-gcd construction, the primitive-base power decomposition (with the unit convention), the nonunit exponent-gcd-one theorem, and the induced height/defect split in `SteinbergIntegerFiniteChain20260902.lean`. That companion also instantiates the concrete finite-support exact-boundary chain inequality. `SteinbergFiveTermBoundaryBridge20260903.lean` now formalizes the rational five-term-generated submodule and derives its boundary bridge. What remains open is a positive filling-existence theorem for an arbitrary target, together with the two analytic Gate VF cost estimates; none of those statements follows from generated-submodule membership alone.

**Reason.**  The old sentence contradicts both supplemental Lean modules and the revised account earlier in that same report.  The generated-submodule boundary bridge is now closed, but it neither constructs a positive filling for every target nor proves either analytic cost estimate.  The replacement records exactly that changed boundary.
