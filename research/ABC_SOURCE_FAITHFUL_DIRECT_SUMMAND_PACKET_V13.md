# The complete source-faithful direct-summand Ind2 packet

**Author:** ChatGPT  
**Status:** mathematical proof and Lean formalization completed.  No IUT IV
component inequality or abc statement is assumed.

## 1. The source-level issue

The radial-shadow theorem keeps one Tate-radius coordinate for each actual
final-capsule label.  The source description of Indeterminacy (Ind2) in IUT
III, Theorem 3.11(i), is finer: for a fixed rational place and a fixed theta
label `j`, independent copies of the local isomorphism action operate on the
direct summands of the corresponding `j+1` tensor factors.

Thus a faithful packet should retain a finite or profinite summand fiber
`F_label` above each fixed final-capsule label.  Ind2 acts inside
`F_label`; it does not send the summand to a different theta label.

This note proves that retaining the entire summand fiber introduces no radial
enlargement.

## 2. Direct-summand data

Let `D` be the actual final capsule.  For each label `u`, let `F_u` be its
summand fiber.  A source-faithful choice consists of

\[
 \zeta_{u,f}\in D.field(u),\qquad |\zeta_{u,f}|=1,
\]

\[
 \sigma_u:F_u\simeq F_u,
 \qquad
 n_{u,f}\in\mathbb N.
\]

The output attached to a target summand `f` is allowed to use the
source-summand data at `\sigma_u(f)`.  Its radial exponent is

\[
 e_{u,f}
 =D.labelInteger(u)^2+n_{u,\sigma_u(f)}.          \tag{2.1}
\]

The corresponding principal region is

\[
 U_{C,u,f}
 =\zeta_{u,\sigma_u(f)}q_u^{e_{u,f}}\mathcal O_u.
                                                               \tag{2.2}
\]

Because the multiplier has norm one, (2.2) is exactly

\[
 q_u^{e_{u,f}}\mathcal O_u.                       \tag{2.3}
\]

The complete packet is the dependent product of (2.2) over every pair
`(u,f)`.

## 3. Exact complete-packet theorem

Define the native direct-summand packet

\[
 \mathcal N_D(F)
 =\prod_u\prod_{f\in F_u}
   q_u^{D.labelInteger(u)^2}\mathcal O_u.          \tag{3.1}
\]

Let `\mathcal P_C` denote the complete packet for one choice and let

\[
 \mathcal U_D(F)=\bigcup_C\mathcal P_C.           \tag{3.2}
\]

### Theorem 3.1

\[
 \boxed{\mathcal U_D(F)=\mathcal N_D(F).}         \tag{3.3}
\]

### Proof

For every `u,f`, equation (2.1) gives

\[
 D.labelInteger(u)^2\le e_{u,f}.
\]

Since `|q_u|<1`, the Tate-power regions are antitone in their exponent.
Consequently

\[
 U_{C,u,f}
 \subseteq
 q_u^{D.labelInteger(u)^2}\mathcal O_u.
\]

Taking the dependent product proves
`\mathcal P_C\subseteq\mathcal N_D(F)` for every choice and hence

\[
 \mathcal U_D(F)\subseteq\mathcal N_D(F).         \tag{3.4}
\]

For the reverse inclusion, take the identity permutation on every fiber,
the unit multiplier `1` on every summand, and `n_{u,f}=0` everywhere.  This is
one legitimate complete choice, and its packet is exactly (3.1).  Therefore

\[
 \mathcal N_D(F)\subseteq\mathcal U_D(F).         \tag{3.5}
\]

Equations (3.4) and (3.5) prove (3.3).  The reverse inclusion is realized by
one choice simultaneously at all summands, so the proof does not exchange a
union with a product.  ∎

## 4. Consequence

The exact radial packet survives not only after collapsing each theta label to
one coordinate, but at the full direct-summand level on which source-faithful
Ind2 acts.  Fiber permutations merely reindex equal native radii.  Norm-one
Ind1 multipliers preserve the principal regions, and nonnegative Ind3 data can
only shrink them.

Therefore none of these three operations, considered on the complete
source-faithful direct-summand radial packet, creates an additional
holomorphic-hull radius or an unbounded radial volume loss.

This removes a second possible source of hidden enlargement beyond the
arbitrary-label-permutation no-go.  The remaining geometric problem is the
non-radial part of the tensor/log-shell possible image and its comparison with
the actual mono-analytic holomorphic hull used in IUT IV.

## 5. Lean ledger

`IUTThreeClosures/SourceFaithfulDirectSummandPacket.lean` proves:

- `norm_directSummandOutputValue`;
- `directSummandOutputRegion_eq_qPowerRegion`;
- `directSummandOutputRegion_subset_native`;
- `directSummandPacket_subset_nativeDirectSummandPacket`;
- `ordinaryDirectSummandPacket`;
- `directSummandPacketUnion_eq_nativeDirectSummandPacket`.

The module contains no `axiom`, `sorry`, or `admit` and was checked locally
with the repository's pinned Lean 4.32.0 toolchain before submission to CI.
