# Actual integer arm arithmetic and the finite signed ledger

This describes the elementary portion of the already independently reviewed SA proof that is implemented in `Lean/SignedArmArithmetic.lean`. It does not replace SA's ordinary analytic input.

For any integer pair w=(a,b), the normalized nth power is w^n if n=1 mod 6 and its conjugate otherwise. When n=1 or 5 mod 6, the three boundary lines a=0, b=0, a+b=0 map to themselves. Reduction modulo a, b, and a+b therefore proves actual divisibility of the output coordinates A, B, A+B by their corresponding input arms. This proof is valid even when an input arm is zero: its output is then zero, and integer quotient reconstruction remains valid. In the nonzero ordinary SA domain these are precisely its usual arm quotients.

The normalized unit-power calculations use period six and scaling by b^n or a^n. Congruence is preserved by actual pair multiplication, conjugation and exponentiation. These facts prove the three actual divisibilities without a finite bound on n or the input coordinates. Integer division then gives aD1=A, bD2=B, (a+b)D3=A+B. Substitution proves the additive relation, boundary product, and exact quadratic norm of the first two weighted arms.

If the output pair is primitive, its three boundary arms are pairwise coprime. Any divisors of two coprime integers are coprime, so the three integer quotients are pairwise coprime. The formal theorem explicitly includes output primitivity. Its number-theoretic derivation from an unramified primitive root is an ordinary input in SA and is not asserted by this module.

For the finite ledger, let a list consist of natural depths e and nonnegative integer weights w. Define S=sum e*w, R=sum_{e>0} w and E=sum max(e-2,0)*w. At every entry, e-max(e-2,0) is at most two if e>0 and is zero otherwise. Multiplying by w>=0 and summing proves S-E<=2R. No primality premise is needed for this numerical lemma.

For three such lists, suppose S3<=t, S1>=t-delta-L1 and S2>=t-delta-L2. The two inequalities S1-E1<=2R1 and S2-E2<=2R2 give

    2(S1+S2+S3-3(R1+R2+R3))
      <=2delta+L1+L2+3(E1+E2)-6R3.

This is the exact linear kernel in SA2, and the module proves both its abstract integer-weight form and its specialization to finite lists. E1=E2=0 leaves the third list's individual depths unrestricted. The formal variables are integer weights and height budgets; the module does not identify them with real logarithms or discharge the real height antecedents for arithmetic orbits.

Finally define the signed exponent credit c(0)=0 and c(e)=e-3 for e>0. For natural u,v, c(u+v)<=c(v)+u: if v>0 equality holds, while a newly introduced prime loses the additional credit three. Multiplication by a nonnegative weight proves the local weighted overlap bound. Thus no coprimality between the old input boundary and the quotient product is silently required in the ordinary argument.

The module has 32 theorem declarations, including all helper lemmas; the complete list and per-source SHA256 values are in `verification/lean_validation.json`. It imports the existing 29-theorem Eisenstein arithmetic and ten-theorem general Lucas bridge, all based on Std. The fresh build treats warnings as errors and checks every theorem's axiom query. General cyclotomic valuations, prime support allocation, LR2, the real weighted inequality and membership in the signed-tail subclass remain outside this formal scope.
