# FM7. The non-finite-flat branch and a uniform modular budget

This is an ordinary-proof supplement to FM1--FM6 in
`frey_modular_entry.md`. It removes the restriction `p` does not divide `V`
from the modular candidate budget. It does not eliminate those candidates.
The complete ordinary proof has passed independent full reviews by
critical_bottleneck and adversarial_audit, including its primary-source
inputs. The final TeX transcription also passed adversarial_audit's
full review. No Lean formalization of modularity is claimed.

## Statement

Let `a,b` be coprime positive integers and put

\[
 F=a^4+3a^3b+5a^2b^2+3ab^3+b^4=VQ^p,
 \qquad V,Q\in\mathbb Z_{>0},\quad p>7\text{ prime},
\]

where `V` is `p`-power-free. Set

\[
 r=v_p(V),\quad R=V/p^r,\qquad
 k(V,p)=\begin{cases}2,&r=0,\\p+1,&r>0.\end{cases}       \tag{NW1}
\]

For the fixed Q-curve splitting character used in FM5, the descended
residual representation arises from a normalized characteristic-zero
newform of weight `k(V,p)`, nebentypus `epsilon=psi_3` of conductor 12,
and exact prime-to-`p` level

\[
 N=2^e3^2\operatorname{rad}(R),\qquad 2\le e\le6.          \tag{NW2}
\]

If `r>0`, necessarily `p` splits in `K=Q(sqrt(-3))`, equivalently
`p=1 mod 3`. With `lambda=max(1,log V)/p`, in both branches

\[
 \frac{\log N}{p}\le\lambda+\frac{\log576}{p}.             \tag{NW3}
\]

For fixed `p,V`, the sum of the dimensions of the five indicated
newspaces is at most

\[
 485(p+1)V^2.                                              \tag{NW4}
\]

For every `L>=0`, the sum over all `p`-power-free integers
`1<=V<=exp(Lp)` coprime to 6 is at most

\[
 485(p+1)\exp(3Lp).                                        \tag{NW5}
\]

Each `V` contributes only its specified weight in (NW1). The budget counts
all such residual integers, including ones for which no seed exists. It
counts Galois orbits with their coefficient-field degrees. In particular,
if `L->0` and `p->infinity`, its logarithm divided by `p` tends to zero.

## Proof of the local weight and exact level

Write `x=a^2+b^2`, `y=a+b`, `s=sqrt(-3)` and consider

\[
 E_{a,b}:\quad Y^2=X^3+12yX^2+6(3y^2+xs)X.
\]

FM3--FM5 apply to the actual curve independently of the power
factorization: it is a non-CM Q-curve of minimum degree 2, with a
multiplicative prime greater than 3. The fixed finite Hecke character
`chi` has order 4, conductor dividing the third power of the prime over
2, and is unramified at 3. Its twist descends to an odd two-dimensional
representation over `Q` with determinant `psi_3` times the cyclotomic
character. The general Q-curve large-image theorem already checked in
FM5 gives absolute residual irreducibility for every `p>7`. These facts
do not require `p` to be coprime to `V`.

At every rational prime `q>3` dividing `F`, FM3 proves that `q` splits
in `K`, that the curve is minimal and multiplicative at both primes over
`q`, and that the two minimal discriminant valuations are `m,2m`, with
`m=v_q(F)`. The two `c4` valuations are zero, so the corresponding
valuations of `j` are `-m,-2m`.

Suppose first that `r>0`. Then `p|F`, hence `p` splits and either
completion of `K` at `p` is `Q_p`. At the chosen completion,

\[
 m=r+p\,v_p(Q),\qquad 1\le r\le p-1.                     \tag{NW6}
\]

Neither `m` nor `2m` is divisible by `p`. The twist by `chi` is
unramified at this place and leaves the inertia representation and
its Serre weight unchanged. Serre's semistable elliptic-curve weight
formula therefore gives exactly `k=p+1`. This uses Proposition 5 of
Section 2.9 in the 1987 paper: for a multiplicative elliptic curve over
`Q_p`, weight 2 occurs precisely when `p` divides `v_p(j)`; otherwise
the weight is `p+1`. The result includes nonsplit multiplicative
reduction, by an unramified quadratic extension in its proof.

When `r=0`, the finite-flat argument of FM5--FM6 gives weight 2. If
`p|Q`, the Tate parameter valuation is a multiple of `p`; if `p` does
not divide `F`, the curve has good reduction. The unramified extension
and character twist preserve finite flatness. This also covers an inert
prime `p` in the good-reduction case.

For `q>3`, `q` different from `p`, residual Tate monodromy is nonzero
precisely when `p` does not divide `v_q(F)`. The `p`-power-free condition
on `V` makes this equivalent to `q|V`. Thus the rational prime-to-`p`
residual conductor has precisely the factor `rad(R)` away from 6. The
local proofs at 2 and 3 in FM5 do not involve `r`: their exponents remain
`2<=e<=6` and exactly 2 respectively. Reduction modulo `p>7` does not
alter these finite inertia conductors. This proves (NW2) for the
residual conductor.

The established strong form of Serre modularity now gives the residual
eigensystem at its Serre weight and conductor. This is the completed
Khare--Wintenberger theorem with its Kisin input, not a theorem asserted
to have been proved in Serre's 1987 paper. The determinant identifies
the residual nebentypus as `psi_3`: both possible weights satisfy
`k-1=1 mod (p-1)`. Its Teichmuller lift is again the same quadratic
character. Section 3.1.6 of Serre's paper supplies the characteristic-zero
eigenform lift with this same weight, level and Teichmuller character.
The lift can be chosen new at exact level `N`. Indeed, a lift arising
from an oldform at a proper divisor of `N` would have residual conductor
dividing that smaller level, contradicting the exact conductor (NW2).

## Proof of the quantitative budget

Since `F` is coprime to 6, so is `V`. Put `D=rad(R)`. Then
`N<=576V` and

\[
 I=[\mathrm{SL}_2(\mathbb Z):\Gamma_0(N)]
   =2N\prod_{q\mid D}(1+q^{-1})
   \le2ND\le1152V^2.                                      \tag{NW7}
\]

The index formula includes the factors `3/2` and `4/3` for 2 and 3.
The inequality uses `1+1/q<=q` for each prime divisor of `D`.
The usual Sturm coefficient bound injects a cusp-form space of weight
`k` into at most `floor(kI/12)+1` coefficients. A newspace is a subspace,
so, in either branch,

\[
 \dim S_{k(V,p)}^{\mathrm{new}}(\Gamma_0(N),\psi_3)
 \le1+96(p+1)V^2.
\]

There are five values of `e`; summing proves (NW4). If
`H=floor(exp(Lp))`, the sum of `V^2` over `1<=V<=H` is at most `H^3`.
This proves (NW5). Finally

\[
 \frac{\log(485(p+1)e^{3Lp})}{p}
 =3L+\frac{\log485+\log(p+1)}p\longrightarrow0,
\]

under the stated joint limit. This is a candidate dimension bound, not
an estimate for heights or counts of rational points on the associated
modular or Kummer curves.

## The remaining elimination condition

Let `C(p,L)` be the finite collection of newforms just bounded, including
all coefficient embeddings and allowing all residual integers
`V<=exp(Lp)` in their prescribed weight branches. Every actual profile
`F(a,b)=VQ^p` in this range gives a congruence between the descended
Frey representation and one member of `C(p,L)`, at a place above `p`.
It also satisfies the exact inverse-square and positivity conditions
of FM1. The missing input is an exclusion of these congruences for the
actual integer seeds, uniform in the moving residual integers and the
moving primes. A bound on the number of candidates alone does not
provide such an exclusion.

The nontrivial compression target has `Q>1`. The necessary theorem and
budget also allow `Q=1`; for a fixed seed these trivial representations
can persist as `p` grows and are not to be ruled out by an indiscriminate
claim that every candidate profile is impossible.

For example, a proved uniform assertion that every such congruence
forces a finite list of explicitly classified seeds, together with
verification that the list contains no required power profiles, would
close the corresponding branch. This assertion is not proved here.
Likewise a proposed Frey--Mazur type assertion converting a congruence
with the boundary curve into an isogeny is a conditional additional
input, not a consequence of finitely many traces. Local residue states
can shadow the boundary curve without being global power profiles.

For the pure branch `V=1`, a uniform exclusion for all sufficiently large
prime exponents, combined with PL5 and the fixed-exponent finiteness,
would settle the pure second-norm family with exponent at least 3.
It would still not settle ABC or arbitrary two-step residual profiles.
For a composite exponent `g` and `p|g`, first write `V=V_p C^p`
with `V_p` `p`-power-free. The new profile is
`F=V_p(CQ^{g/p})^p`; a merely `g`-power-free original `V` need not
be `p`-power-free. Its parameter satisfies
`lambda_p=max(1,log V_p)/p <= max(1,log V)/p`.
Smallness of `max(1,log V)/g` does not by itself guarantee smallness
of `lambda_p`. If `p>=theta*g` with fixed `theta>0`, then
`lambda_p <= max(1,log V)/(theta*g)`; otherwise this bridge requires
additional control. All these branches remain available for research.

## Primary-source ledger

* J.-P. Serre, *Sur les representations modulaires de degre 2 de
  Gal(Qbar/Q)*, Duke Math. J. 54 (1987), 179--230. Section 2.9,
  Proposition 5, printed page 191, and Section 3.1.6, printed pages
  194--195, were actually opened and checked. Author-institution PDF:
  https://www.college-de-france.fr/media/jean-pierre-serre/UPL5835292064138487263_Serre_Repr.modulaires_Galois.pdf .
* C. Khare and J.-P. Wintenberger, *Serre's modularity conjecture (I)*,
  Invent. Math. 178 (2009), 485--504. The author PDF introduction,
  Section 9 (Theorem 9.1), and its explicit completed Kisin input were
  actually opened; Part II proves the technical lifting inputs:
  https://www.math.ucla.edu/~shekhar/papers/results.pdf and
  https://www.math.ucla.edu/~shekhar/papers/proofs.pdf .
* The fixed splitting character, large-image hypotheses, local conductor
  arguments and Sturm convention are those individually sourced and
  independently reviewed in FM1--FM6. This supplement changes the local
  weight at `p`; it does not replace those dependencies with a claim that
  an arbitrary generalized Fermat theorem applies.
