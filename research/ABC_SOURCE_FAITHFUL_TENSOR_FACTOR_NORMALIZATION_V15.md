# Exact normalization of the source tensor-factor packet

**Author:** ChatGPT  
**Status:** mathematical proof and Lean formalization completed.  No IUT IV
component upper estimate or abc statement is assumed.

## 1. Source multiplicity

For a fixed theta label `j`, IUT III, Theorem 3.11(i), describes Ind2 on the
direct summands of `j+1` tensor factors.  The source-faithful direct-summand
packet theorem shows that fiberwise Ind1/Ind2/Ind3 choices leave the union equal
to the native squared-label packet.

This note specializes the fiber over a final-capsule label `u` to

\[
 F_u=\operatorname{Fin}(D.labelInteger(u)+1).       \tag{1.1}
\]

Thus the packet retains exactly `j+1` copies at theta label `j`.

## 2. Complete packet equality

Let `n_u=D.labelInteger(u)`.  Every native tensor factor over `u` has local
region

\[
 q_u^{n_u^2}\mathcal O_u.                           \tag{2.1}
\]

The general complete direct-summand theorem gives immediately

\[
 \boxed{
 \bigcup_C\prod_u\prod_{f\in\operatorname{Fin}(n_u+1)}
       U_{C,u,f}
 =
 \prod_u\prod_{f\in\operatorname{Fin}(n_u+1)}
       q_u^{n_u^2}\mathcal O_u.
 }                                                   \tag{2.2}
\]

The inclusion from left to right uses the nonnegativity of Ind3.  The reverse
inclusion is realized by one ordinary choice at every label and every tensor
factor.

## 3. Multiplicity before normalization

Let

\[
 L_u
 =\operatorname{HaarLog}_u
    \left(q_u^{n_u^2}\mathcal O_u\right).
\]

The actual local Haar calculation already proved in the repository gives

\[
 L_u=n_u^2\,\ell_u,                                  \tag{3.1}
\]

where `\ell_u=D.signedHaarLogSum(u)`.

There are `n_u+1` identical tensor factors.  Their unnormalized additive
log-volume is therefore

\[
 \sum_{f\in\operatorname{Fin}(n_u+1)}L_u
 =(n_u+1)L_u.                                        \tag{3.2}
\]

## 4. Canonical normalization

The tensor-factor average uses weight `1/(n_u+1)`.  Combining with (3.2),

\[
 \begin{aligned}
 \frac1{n_u+1}
 \sum_{f\in\operatorname{Fin}(n_u+1)}L_u
 &=\frac1{n_u+1}(n_u+1)L_u\\
 &=L_u\\
 &=n_u^2\ell_u.
 \end{aligned}                                      \tag{4.1}
\]

Thus the tensor multiplicity cancels exactly; it does not create an extra
coefficient in the theta log-volume.

Summing (4.1) over every actual final-capsule label yields

\[
 \boxed{
 \operatorname{Vol}^{\mathrm{normalized}}_{\mathrm{tensor}}(D)
 =\sum_u n_u^2\ell_u
 =\operatorname{processionLogSum}(D).
 }                                                   \tag{4.2}
\]

The same procession sum is the actual Haar log-volume of the one-coordinate
native radial packet.  Hence

\[
 \boxed{
 \operatorname{Vol}^{\mathrm{normalized}}_{\mathrm{tensor}}(D)
 =\operatorname{Vol}_{\mathrm{native}}(D).
 }                                                   \tag{4.3}
\]

## 5. Lean ledger

`IUTThreeClosures/SourceFaithfulTensorFactorNormalization.lean` proves:

- `sourceFaithfulTensorFactorPacketUnion_eq_native`;
- `normalizedTensorFactorLocalHaarLogVolume_eq`;
- `actualTensorFactorNormalizedHaarLogVolume_eq_processionLogSum`;
- `actualTensorFactorNormalizedHaarLogVolume_eq_nativePacketHaarLogVolume`.

The file uses the actual adic-completion Haar volume from the repository, not a
freely supplied component-volume function.  It contains no `axiom`, `sorry`,
or `admit` and was built locally with the pinned Lean 4.32.0 toolchain before
submission to CI.

## 6. Remaining input

The direct-summand multiplicity and its normalization are now exact.  The
remaining geometric problem is confined to the genuinely non-radial
operations in the tensor/log-shell possible image and to proving that their
mono-analytic holomorphic hull contributes no larger component log-volume than
the arithmetic main and error terms of IUT IV, Theorem 1.10.
