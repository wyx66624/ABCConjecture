# Ninth round: actual common-exponent compatibility

CE1--CE4 ordinary mathematics passed full independent review by both
research peers and the root researcher. It gives a quantitative
necessary condition on actual simultaneous pure-power norms.

For positive primitive a,b with c=a+b, M=a^2+ab+b^2=R^p and
F(a,b)=Q^p, p an odd prime, the full part of c outside the
progression 1 mod p is at most 2R/3, and strictly less than
2c^(2/p)/3. Thus more than 1-2/p of its logarithmic valuation
mass lies in that progression. The result extends by extraction
to every shared odd prime divisor of unequal pure exponents.
It does not assert existence, nonexistence, a radical bound, or ABC.

Files:

- common_exponent_compatibility.md: complete ordinary CE proof.
- paper/common_exponent_compatibility.tex: self-contained paper input.
- Lean/CommonExponentArithmetic.lean: 10 proved integer algebra
  and explicit budget-interface declarations, using the actual norms.
- Lean/ActualCommonExponentGap.lean: 5 further proved declarations.
  The geometric-sum lower bound is proved and connected directly to
  actual representations M=R^n, F=Q^n, n>=1. Thus the final root
  gap and root-size conclusions have no additional sum-bound premise.
- replay_common_exponent.py and common_exponent_results.json:
  standard-library exact finite supplement.
- REVIEW.md: review state and formal scope.

Replay from this directory:

    python replay_common_exponent.py --check

Actually passed: 116 cyclotomic factor/order/valuation instances and
3931 primitive seed norm identities and integer inequalities. The
script does not test whether a simultaneous pure-power seed exists.
Canonical UTF-8/LF JSON SHA256:

    7f5ca89ff61bd99393dca73932474f439bdd58c212adaf5323c91c00f7189cad

Both Lean modules were actually compiled with Lean 4.32.0, importing
the existing repository dependency oleans. All 15 printed axiom
reports contain only propext, Classical.choice, and Quot.sound.
Fresh dependency rebuilding is handled separately by the root.
Source SHA256 values:

    CommonExponentArithmetic.lean
    e85c75a29bce81fc95b56b80a71c20e7e4e9492d6f8e0382cf440df34a693bf0
    ActualCommonExponentGap.lean
    243774d87010250bf55b1076808270b646f8497adf3f0bf4c1d91081b8329032

Prime orders, the complete bad-prime valuation allocation and
logarithmic mass statements remain ordinary mathematics here.
The critical researcher's AC strengthening and the root's
prime-power-modulus extension are independent companion files,
reviewed in REVIEW.md. Earlier rounds remain frozen.

## General common exponents

euler_progression_compatibility.md proves EP1--EP4. Both independent
peers completed full ordinary review with PASS. The complete paper
transfer is paper/euler_progression_compatibility.tex. Write phi=phi(n),
P=maxprime(n), and kappa=P/Phi_n(1). For actual simultaneous pure
exponent n>1 coprime to 6, the bound is

    27 c_bad(6n)^2 <= 16 kappa R^(2(n-phi)+1).

If 2phi(n)>n+1, an actual prime q|c satisfies q=1 mod6n and
q>=6n+1. This retains the exceptional prime and includes suitable
non-prime-power n. It does not provide a radical estimate or a
point-height upper bound. No new Lean representation of the full
cyclotomic valuation theorem or complex root-pair argument is claimed.

The standard-library replay_euler_progression.py --check actually
passed 14 completely factored homogeneous values and four exact
exceptional valuations. These are generic homogeneous examples,
not assertions of actual pure-power seeds. Canonical JSON SHA256:

    cfa7705fbd29e52a6288ffddc8abd4ea2bd112580457a06aeda6ed6b43287271
