# Pell-index transfer for the congruent-number twists

## Scope and conclusion

For the integrated Pell family

\[
 s_n+r_n\sqrt3=(7+4\sqrt3)^n,\qquad
 c_n=s_n^2-2=3r_n^2-1=A_ny_n^2,
\]

the congruent-number construction gives an integral point on
\(E_{3A_n}:Y^2=X^3-(3A_n)^2X\).  Chan's theorem therefore gives a sparse
*unordered support* of possible discriminants.  It does **not** by itself give
a pointwise lower bound for \(A_n\), because a counting theorem contains no
information about which support element receives which Pell index.

After the already accepted Pell regulator/class-number estimate is inserted,
however, the family has the pointwise bound

\[
 A_n\gg \frac{H_n^2}{(\log H_n)^2}
      \asymp \frac{n^2}{(\log n)^2}.
\]

Consequently

\[
 \#\{n:3A_n\le X\}\ll \sqrt X\log X.
\]

This is asymptotically stronger than the transfer of Chan's bound
\(\ll_\varepsilon X(\log X)^{-1/4+\varepsilon}\).  Thus Chan sparsity is
quantitatively redundant for the present Pell-index lower bound.  It remains
valuable as an independent geometric consistency check, but it cannot upgrade
the polynomial pointwise estimate to
\(\log A_n\ge(1-o(1))H_n\).

The division-free scalar implication formalized in Lean is

\[
 n^2\le C A L^2,\quad A\le X,\quad L^2\le B^2
 \quad\Longrightarrow\quad n^2\le C X B^2.
\]

Taking \(L\asymp\log A\) and \(B\asymp\log X\) gives the displayed indexed
count without dividing by a possibly vanishing endpoint quantity.

## Genuine adjacent structure

Write \(c=s^2-2\), \(c'= (7s+12r)^2-2\), and \(L=7sr-6\).  Direct elimination
from \(s^2-3r^2=1\) gives the exact identity

\[
 c(1176c+3528+291L)-3Lc'=240.
\]

More precisely, before imposing the Pell equation the difference from 240 is

\[
 24(49s^2+42rs-36)(s^2-3r^2-1).
\]

Hence every common divisor of adjacent carriers divides 240.  On the actual
orbit, \(s_n\) is odd, \(c_n\equiv2\pmod3\), and a square is never 2 modulo 5;
therefore \(\gcd(c_n,240)=1\), and the identity yields
\(\gcd(c_n,c_{n+1})=1\).  This resultant/gcd statement is genuine information
not present in an unordered counting theorem.

It still does not control the parity core.  Pairwise coprimality says that prime
carriers do not repeat in adjacent terms; it does not say whether a new prime
occurs to odd or even valuation.  The decomposition
\(c_n=A_ny_n^2\) can therefore have a small \(A_n\) and a very large square
part without contradicting the resultant.

## Strict separation profile

Here is a numerical profile satisfying every marginal input used above while
failing any coefficient-one source-height conclusion.  Let \(p_m\) be the
\(m\)-th prime congruent to 23 modulo 24 and set

\[
 A_n=p_{n^2}.
\]

The prime number theorem in arithmetic progressions gives
\(A_n\sim16n^2\log n\).  Thus the \(A_n\) are positive squarefree, pairwise
coprime, all congruent to 23 modulo 24, and their counting function satisfies
both the indexed \(O(\sqrt X\log X)\) envelope and Chan's weaker envelope.
They also satisfy the regulator-compatible inequality
\(n\ll\sqrt{A_n}\log A_n\), but

\[
 \frac{\log A_n}{n}\longrightarrow0.
\]

For an explicit full carrier profile, choose distinct primes
\(z_n\equiv1\pmod{24}\) with
\(\log z_n=(\kappa n-\log A_n)/2+o(1)\), possible by the same prime number
theorem, and put \(c_n=A_nz_n^2\).  Then

\[
 \operatorname{core}(c_n)=A_n,\qquad
 \log c_n=\kappa n+o(n),\qquad
 \gcd(c_n,c_{n+1})=1,
\]

yet \(\log A_n/\log c_n\to0\).  This is a separation profile, not a claimed
solution of the coupled Pell equations.  Its role is logical: unordered
sparsity, pointwise quadratic growth, residue classes, squarefreeness, height
growth, and even adjacent coprimality do not entail a large parity core.

The remaining missing input is therefore an exponent-sensitive theorem for the
*coupled Pell carriers*—for example a lower bound on the odd-valuation part of
\(s_n^2-2\).  Neither Chan's support count nor the exact adjacent resultant
supplies such a theorem.

## Formal boundary

`IUTThreeClosures/FreyPellCongruentTwistIndexTransferAudit.lean` checks the
resultant, its common-divisor consequence, the explicit divisor-form gcd
criterion, and the division-free pointwise envelope.  It proves no `abc`
statement, no exponential lower bound for \(A_n\), and no completeness theorem
for integral points.
