# Exact conductor and a coefficient-below-six obstruction in an entire Frey isogeny class

Author: ChatGPT. Date: 2026-08-31.

Status: complete mathematical proof before any new Lean formalization. This
report is an unconditional continuation of the previously reviewed entire
rational-isogeny-class and Weil-height calculations. It proves an exact
conductor formula and a new infinite subfamily on which no rationally
isogenous representative admits a uniform conductor-height upper bound with
coefficient below six.
It neither proves nor disproves the abc conjecture. No conjecture, numerical
search, or finite verification is used in the proofs.

## 1. Previously proved input and its exact external boundary

For `n >= 1`, put

\[
 c=1792n+2,\qquad E_c:y^2=x(x-1)(x+c-1).
 \tag{1.1}
\]

The paper proof in
`research/ARITHMETIC_GEOMETRY_UNIFORM_GATE_2026_08_31.md` proves that the
entire rational isogeny class of `E_c` consists of the four displayed curves
`E_c,E_0,E_a,E_b`. Its inputs are:

1. the actual three rational 2-isogeny quotients and the proof that their
   only rational 2-isogeny edge is the dual edge;
2. the good-reduction point count at 7, which excludes a rational
   3-isogeny;
3. the cyclic-isogeny classification over `Q`, used after proving that a
   least-degree isogeny between fixed endpoints has cyclic kernel and hence
   factors into rational prime-degree steps.

The source boundary was rechecked in this round. Mazur's 1978 Theorem 1
gives the prime-degree list; it does not by itself give the complete
composite-degree theorem. Balakrishnan--Mazur 2025, Theorem 2.2, printed
page 239 (PDF page 5), states the complete cyclic-degree list

\[
 1\le N\le19,\quad N\in\{21,25,27,37,43,67,163\}.
 \tag{1.2}
\]

Thus a cyclic `4 ell`-isogeny for an odd prime `ell` forces `ell=3`.
The relevant archived files remain:

| file | bytes | SHA256 |
|---|---:|---|
| `research/sources/arithmetic_geometry_gate_2026_08_31/Mazur_1978_Rational_isogenies_prime_degree.pdf` | 1789871 | `f3da9ef0d3d184225c4799951897be7b90d8b25050c5d508b69aeff70fd2ead3` |
| `research/sources/arithmetic_geometry_gate_2026_08_31/Balakrishnan_Mazur_2025_Ogg.pdf` | 732299 | `2c6acd3452ced7f031c446e6f54a94f09681d0e9d8ee28d199e308ad46847d6d` |

The four original Kenku articles referenced in the 2025 survey were not
reread in full. The present report does not silently replace the reviewed
classification theorem by a database computation.

The separate report
`research/FREY_ENTIRE_ISOGENY_WEIL_HEIGHT_2026_08_31.md` proves, for

\[
 Q(c)=c^2-16c+16,
\]

that the unique minimum of the absolute logarithmic Weil height throughout
this entire rational isogeny class is

\[
 h_{\min}(c)=3\log Q(c),
 \tag{1.3}
\]

attained by `E_0`. The Lean module
`FreyIsogenyWeilHeight20260831.lean` proves the actual four-model height
calculation and unique minimum. It intentionally does not formalize the
external assertion that these four models exhaust the isogeny class.

## 2. The exact local conductor of the endpoint family

Write (1.1) in rational-2-torsion form

\[
 E_c:y^2=x^3+A x^2+B x,\qquad A=c-2,\quad B=1-c.
 \tag{2.1}
\]

Its invariants are

\[
 c_4=16(c^2-c+1),\qquad
 \Delta=16(c-1)^2c^2.
 \tag{2.2}
\]

**Theorem 2.1.** For every `c=1792n+2`, `n>=1`, the displayed equation is
minimal at every prime. At 2 it has Kodaira symbol III and conductor
exponent 5. At every odd prime `q` dividing `c(c-1)` it has multiplicative
type

\[
 I_{2v_q(c(c-1))}
\]

and conductor exponent 1. It has good reduction at every other prime.

**Proof at 2.** We have

\[
 v_2(A)=v_2(1792n)\ge8,qquad v_2(B)=0,qquad B\equiv-1\pmod4.
 \tag{2.3}
\]

Mulholland's Theorem 2.1 and Table 2.1 specialize the complete
Papadopoulos classification to an integral equation
`y^2=x^3+A x^2+B x`. The row

\[
 v_2(A)\ge2,quad v_2(B)=0,quad B\equiv-1\pmod4
\]

has Kodaira symbol III, Tate case 4, and conductor exponent 5. The same
theorem states that every row with conductor exponent other than 0 or 1 is
already minimal. This proves the assertion at 2. Notice that this is not an
inference from the valuations of `c_4` and `Delta` alone; the displayed
congruence on `B` is the required residue-characteristic-two condition.

The source was downloaded and the relevant table was visually read in this
round:

`research/sources/arithmetic_geometry_uniform_continuation_2026_08_31/`
`Mulholland_2006_Conductor_2Torsion_Thesis.pdf`,
1712336 bytes, SHA256
`183d6da157a26527ccc3325149ee66ae929a3cde3bd42c406e5e6d2c6a9b94a4`.

The theorem is on printed page 13 (PDF page 21), Table 2.1 on printed page
15 (PDF page 23), and the proof of the applicable row is on printed page 22
(PDF page 30). The thesis explicitly specializes I. Papadopoulos,
*Neron classification of elliptic curves where the residual characteristics
equal 2 or 3*, J. Number Theory 44 (1993), 119--152,
DOI `10.1006/jnth.1993.1040`.

**Proof at odd primes.** Let `q` be odd. If `q` divides `c`, then
`c^2-c+1` is 1 modulo `q`; the same is true if `q` divides `c-1`.
Because consecutive integers are coprime, these are the only two cases in
which `q` divides the displayed discriminant. Thus at every such `q`,

\[
 v_q(c_4)=0,qquad
 v_q(\Delta)=2v_q(c(c-1))>0.
\]

An integral model with unit `c_4` and nonunit discriminant is minimal and
multiplicative, of type `I_{v_q(Delta)}`, with conductor exponent 1.
If `q` does not divide `c(c-1)`, the discriminant is a unit and the reduction
is good. This proof includes `q=3`; no residue-characteristic-three shortcut
is being assumed. This completes the proof. `square`

**Corollary 2.2.** The exact global minimal discriminant of this particular
representative is

\[
 |\Delta_{\min}(E_c)|=16(c-1)^2c^2,
 \tag{2.4}
\]

and its exact Neron conductor is

\[
 \boxed{N(E_c)=2^5\!\prod_{\substack{q\mid c(c-1)\\q\text{ odd}}}q
              =16\operatorname{rad}(c(c-1)).}
 \tag{2.5}
\]

**Proof.** Minimality at every prime gives (2.4). Since `c` is even,
`rad(c(c-1))` contains one factor 2. The local exponents of Theorem 2.1
then give (2.5). `square`

## 3. The formula holds on the entire rational isogeny class

**Proposition 3.1.** Every elliptic curve `F/Q` rationally isogenous to
`E_c` has

\[
 N(F)=16\operatorname{rad}(c(c-1)).
 \tag{3.1}
\]

**Proof.** A rational isogeny induces an isomorphism of rational Tate
modules `V_ell(E_c) -> V_ell(F)`: the dual composite is multiplication by
the nonzero degree, which is invertible over `Q_ell`. At each finite place,
choose `ell` different from the residue characteristic. The two local
Galois representations are isomorphic, so their Artin conductor exponents
are equal. Hence rationally isogenous elliptic curves have the same Neron
conductor. Apply (2.5). `square`

This proposition does not say that minimal discriminants are isogeny
invariant; they are not. It identifies the one quantity which genuinely is
constant on all four vertices and on the entire class.

## 4. The conductor is the radical of the minimizing j-denominator

Put `u=c/2=896n+1`. The already proved reduced fraction for the unique
height-minimizing curve is

\[
 j(E_0)=-\frac{Q(c)^3}{D(c)},qquad
 D(c)=(c-1)u^4,qquad \gcd(Q(c),D(c))=1.
 \tag{4.1}
\]

Both `u` and `c-1=2u-1` are odd, and

\[
 \gcd(u,2u-1)=1.
\]

Consequently

\[
 \operatorname{rad}D(c)
 =\operatorname{rad}(u(c-1)),qquad
 \operatorname{rad}(c(c-1))
 =2\operatorname{rad}D(c).
 \tag{4.2}
\]

Combining (3.1) and (4.2) gives the exact entire-class identity

\[
 \boxed{N(F)=32\operatorname{rad}(\operatorname{den}j(E_0))}
 \tag{4.3}
\]

for every `F` in the class. Here `den` is the positive denominator of the
reduced rational number. This is a genuine finite-place height/conductor
bridge: the denominator radical of the unique height minimizer has exactly
the moving conductor support, with only the fixed factor 32 omitted.

It is not yet the desired height-conductor inequality. The multiplicities
in `D(c)=(c-1)u^4` contribute to `h(j(E_0))`, whereas (4.3) keeps only their
support.

## 5. An infinite power subfamily inside the reviewed class

The congruence modulus 1792 was not an obstacle to forcing a large perfect
power into one endpoint. For `k>=1`, define

\[
 m_k=897^k,\qquad
 n_k=\frac{897^k-1}{896}=1+897+\cdots+897^{k-1},qquad
 c_k=2\cdot897^k.
 \tag{5.1}
\]

Then `n_k` is a positive integer and

\[
 c_k=1792n_k+2.
 \tag{5.2}
\]

Thus every `c_k` belongs to the exact family for which the entire rational
isogeny class and its unique height minimum have already been determined.

Since

\[
 897=3\cdot13\cdot23
\]

is squarefree and `gcd(897,2*897^k-1)=1`, the radical and conductor are
particularly transparent:

\[
 \begin{aligned}
 R_k&=\operatorname{rad}(c_k(c_k-1))
     =1794\operatorname{rad}(2\cdot897^k-1),\\
 N_k&=N(E_{c_k})
     =28704\operatorname{rad}(2\cdot897^k-1)
     \le28704(c_k-1)<28704c_k.
 \end{aligned}
 \tag{5.3}
\]

The equality is elementary radical multiplicativity for coprime factors;
the inequality uses `rad(r)<=r` for a positive integer `r`.

## 6. Every coefficient below six fails after optimizing the entire class

**Theorem 6.1.** Fix real numbers `theta,C` with `0<=theta<6`. For all
sufficiently large `k`, every elliptic curve `F/Q` rationally isogenous to
`E_{c_k}` satisfies

\[
 h(j(F))>\theta\log N(F)+C.
 \tag{6.1}
\]

Equivalently, no choice of a representative depending arbitrarily on `k`
can give a uniform conductor-height upper bound with coefficient strictly
less than six on this explicit infinite Frey family.

**Proof.** The entire-class minimum (1.3) and `c_k>=1794>32` give

\[
 h(j(F))\ge3\log(c_k^2-16c_k+16)
          >6\log c_k-3\log2.
 \tag{6.2}
\]

By (5.3) and `theta>=0`,

\[
 \theta\log N(F)<\theta\log c_k+\theta\log28704.
 \tag{6.3}
\]

Subtracting yields

\[
 h(j(F))-\theta\log N(F)
 >(6-\theta)\log c_k-3\log2-\theta\log28704.
 \tag{6.4}
\]

The right side tends to infinity because `theta<6` and
`c_k=2*897^k`. Choose `k` sufficiently large that the displayed right side
exceeds `C`. The choice is independent of `F`, so the assertion holds
simultaneously for the entire class.
`square`

In particular,

\[
 \liminf_{k\to\infty}
 \frac{\min_{F\sim_{\mathbb Q}E_{c_k}}h(j(F))}{\log N(E_{c_k})}\ge6.
 \tag{6.5}
\]

This is stronger than the preceding obstruction measured only against
`log c`: it proves that rational isogeny optimization cannot lower the
possible uniform coefficient below six on this family. It does not supply
an upper bound with coefficient six and therefore does not identify the
optimal coefficient.

## 7. What remains at and above coefficient six

Theorem 6.1 rules out every fixed coefficient below six. It deliberately
does not rule out

\[
 h(j(E))\le(6+\varepsilon)\log N(E)+C_\varepsilon
 \tag{7.1}
\]

for every positive `epsilon`; that estimate is of modified-Szpiro/abc
strength. On this family, (1.3) and (2.5) make the remaining gap exact:

\[
 3\log(c^2-16c+16)
 \stackrel{?}{\le}
 6(1+\varepsilon)
 \bigl(\log\operatorname{rad}(c(c-1))+\log16\bigr)+C_\varepsilon.
 \tag{7.2}
\]

After division by six and absorption of bounded terms, this is the abc
inequality for the endpoint triple `(1,c-1,c)`. The special power choice in
Section 5 reduces its unproved arithmetic content to control of
`rad(2*897^k-1)`. Equation (5.3) gives an upper bound for that radical, not
the lower bound required for abc. No claim that this sequence violates abc
is made.

Thus the new result is a one-sided lower-threshold obstruction and an exact
radical ledger. It closes a proposed coefficient-below-six isogeny shortcut
while leaving the coefficient-six and all-epsilon route open.

## 8. Formalization boundary and bounded-companion specification

The current mathlib checkout has actual Weierstrass curves and rational
height APIs, but no elliptic-isogeny object, Tate algorithm, Kodaira symbol,
or Neron-conductor API. Therefore the following paper inputs cannot honestly
be converted into Lean merely by enumerating four labels:

1. the Mazur--Kenku cyclic-isogeny classification;
2. the assertion that the four labels exhaust the actual rational isogeny
   class;
3. the residue-characteristic-two local conductor computation;
4. isogeny invariance of the Neron conductor.

Introducing a new `conductor` function with (2.5) as a field or axiom would
only restate the theorem and is forbidden.

A useful companion with no project-specific or nonstandard axioms can
nevertheless formalize the new elementary content after this proof:

- the power indices (5.1)--(5.2);
- the exact radical relation (4.2) for the actual reduced denominator already
  identified by `familyCurve_j_den`;
- the radical upper bound in (5.3);
- the scalar divergence in (6.4), explicitly parametrized by the already
  formalized four-model height minimum.

Such a module would prove facts about the actual four existing models and
Mathlib's actual `Height` and `radical` functions. It must continue to state
that the passage from those models to the entire rational isogeny class and
the interpretation of the integer in (2.5) as a Neron conductor are paper
mathematics.

## 9. Bounded computational cross-check, not a proof

PARI/GP 2.15.4 was used only as an independent error detector. For
`1<=n<=30`, `elllocalred` returned local conductor exponent 5 and Kodaira
code 3 at 2 for `[0,c-2,0,1-c,0]`. At `n=1` it returned

\[
 [f_2,\text{Kodaira code},\text{change},c_2]
 =[5,3,[1,0,0,0],2]
\]

and global conductor `51466272`, exactly
`16*rad(1794*1793)`. These finite checks are not used in Theorems 2.1,
3.1, or 6.1; the proofs above are uniform in `n` and `k`.

As a separate invariance sanity check at `n=1`, all four displayed models
returned the same global conductor `51466272`; their local conductor
exponents at 2 were all 5 even though their individual Kodaira codes differed.
This is consistent with Proposition 3.1 and also confirms that the proof does
not accidentally assert isogeny invariance of Kodaira symbols.

## 10. Bounded Lean companion completed after the proof

After Sections 1--9 were completed, the companion specified in Section 8
was implemented in

`Lean/IUTThreeClosures/FreyIsogenyConductorSharpness20260831.lean`.

It contains five definitions and twenty-eight public theorems. In
particular, it proves:

1. `endpoint_radical_eq_two_actual_j_den_radical`, using the actual
   `Rat.den` of the actual zero-kernel Weierstrass curve;
2. `endpointC_powerIndex` and `powerEndpoint_radical`, giving the exact
   geometric-series and radical identities of Section 5;
3. `power_conductorProxy_lt`, where `conductorProxy` is explicitly only the
   elementary integer `16 * radical (c(c-1))` inside Lean;
4. `powerFamily_subcritical_gap` and `exists_powerFamily_gap_gt`, using the
   actual four Weierstrass models and Mathlib's actual
   `Height.logHeight₁` function.

The module does **not** declare that `conductorProxy` is a Neron conductor,
does not define an isogeny class, and does not add the Tate-algorithm or
Mazur--Kenku results as assumptions. Those remain precisely the paper inputs
listed in Section 8.

Both bounded checks succeeded:

```text
lake env lean IUTThreeClosures/FreyIsogenyConductorSharpness20260831.lean
exit 0

lake build IUTThreeClosures.FreyIsogenyConductorSharpness20260831
exit 0; Build completed successfully (8763 jobs)
```

The single-module build emitted no warning in the new module; its displayed
warnings were replayed warnings from older dependencies. Six representative
`#print axioms` checks reported only
`propext`, `Classical.choice`, and `Quot.sound`, with no `sorryAx`.

Final module SHA256:

`2e3e938f0eef0541faabcf21277de042538382a56085218882799aba302c2913`.
