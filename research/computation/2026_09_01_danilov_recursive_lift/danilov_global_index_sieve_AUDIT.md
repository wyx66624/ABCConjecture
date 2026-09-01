# Adversarial audit of the Danilov global index sieve

Author: ChatGPT.  Date: 2026-08-31.

## 0. Verdict

**PASS, with one quantifier clarification recommended and no mathematical
repair required.**  I independently reconstructed the forward Pell orbit,
the exact-valuation transfer, the `11` and `89` lifts, all ten later lifts,
the primality proofs, and the final CRT calculation.  I found no
counterexample satisfying the stated hypotheses.

The proved conclusion is exactly

\[
 K_t\text{ squarefull}\quad\Longrightarrow\quad
 t\equiv
 122136955032565025967809449110840347537827
 \pmod {183205432548847538951714173666260521306741}          \tag{0.1}
\]

for the **forward orbit**, meaning integer `t>=0`.  Hence every index
`0<=t<T_0` is excluded, where the displayed representative is `T_0`.
The surviving residue class is not proved to contain a squarefull value and
is not proved to contain none.  The Danilov route therefore remains active.

The report consistently speaks of indices, uses `r>=0`, and concludes only
about the first nonnegative indices, so this is its evident scope.  For
standalone reuse, Section 2 and display (1.1) should explicitly declare
`t >= 0` (or simply “let `t` be a nonnegative integer”).  The
proof as written does not need or claim a theorem about negative powers.

## 1. Audited artifacts and replay

The audit covered:

- `research/ABC_DANILOV_GLOBAL_INDEX_SIEVE_2026_08_31.md`;
- `danilov_global_index_sieve.py`;
- `danilov_global_index_sieve_certificate.json`; and
- every Pocklington witness and modular residue stored in that certificate.

Hashes before this audit's own additions were:

\[
\begin{array}{c|l}
\text{report}&	exttt{8df1201a383a1eb73e7e4fcabceceb9c89e4de60833445068786c4118aa429b0}\\
\text{generator}&	exttt{8f35f8ace6c28d5e8cf5f69edc229ec66de2303e3711af96db436cb55fe1ede3}\\
\text{certificate}&	exttt{be46476e42272f80948a2c6d23d53ae665cd2105a0c1769f01c6f6717fa07ece}.
\end{array}
\]

The original generator was replayed with the bundled Python runtime.  It
exited `0` in 29.451 seconds, regenerated the same certificate hash, checked
all residue classes for each of the ten primes, and returned the same
`R`, `T_0`, and moduli.

I also wrote and ran `independent_global_index_audit.py`.  It deliberately
does not import the generator.  It represents multiplication by `eta` with
the matrix

\[
 \begin{pmatrix}A&5B\\B&A\end{pmatrix},                    \tag{1.1}
\]

uses generic matrix exponentiation, proves every displayed prime by
exhaustive trial division, separately checks the saved Pocklington data,
iterates every `r mod p`, and recomputes CRT.  It exited `0` in 0.868
seconds.  Its output is
`independent_global_index_audit_output.json`.

## 2. Orbit, integrality, and Hall normalization

The exact norm calculations are

\[
 682^2-5\cdot305^2=-1,
\qquad
 1730726404001^2-5\cdot774004377960^2=1.                  \tag{2.1}
\]

Thus the integer recurrence

\[
 \begin{aligned}
 z_{t+1}&=Az_t+5Bw_t,\\
 w_{t+1}&=Bz_t+Aw_t
 \end{aligned}                                             \tag{2.2}
\]

preserves `z_t^2-5w_t^2=-1`.  All four starting and multiplier
coefficients are positive, so `z_t,w_t>0` for every `t>=0`.

Modulo 125,

\[
 A\equiv1,\qquad B\equiv85,\qquad z_0\equiv57,\qquad5\mid w_0. \tag{2.3}
\]

Equation (2.2) preserves `5|w_t`, and then
`z_(t+1)-z_t=5Bw_t` is divisible by 125.  Hence
`z_t=57 mod 125` for every forward index.  It follows that
`125|(2z_t+11)` and

\[
                         K_t={27(2z_t+11)\over125}           \tag{2.4}
\]

is a positive integer.

As a separate algebra check, the independent verifier expanded and matched
every coefficient in

\[
 (z^2+6z+4)^3-(z^2+1)(z^2+9z+19)^2=-27(2z+11).            \tag{2.5}
\]

Moreover `z_t=57 mod 125` gives

\[
 z_t^2+6z_t+4=20\pmod {25},
 \qquad z_t^2+1=0\pmod {125},                               \tag{2.6}
\]

and the Pell equation gives `z_t^2+1=5w_t^2`, hence `5|w_t`.
Thus division of (2.5) by 125 gives, with

\[
 X_t={z_t^2+6z_t+4\over5},
 \qquad Y_t={w_t(z_t^2+9z_t+19)\over5},                    \tag{2.7}
\]

the normalized Hall identity `X_t^3+K_t=Y_t^2` from the preceding audited
report.  The global
sieve itself needs only (2.4) and positivity; it does not silently assume
squarefullness or abc.

## 3. Exact-valuation transfer

For every prime `p` used in the sieve,

\[
                              p\nmid3375=27\cdot125.         \tag{3.1}
\]

The integer identity `125K_t=27L_t` therefore gives

\[
                         v_p(K_t)=v_p(L_t).                 \tag{3.2}
\]

Consequently, if `L_t=0 mod p` but `L_t` is nonzero modulo `p^2`, then
`v_p(K_t)=1`; this contradicts squarefullness.  This implication is used
only for `p=11,89` and the ten displayed primes, none of which is 3 or 5.
It would be invalid without (3.1), but no excluded prime is used.

The nilpotent identity

\[
                 (1+pd\sqrt5)^r=1+rpd\sqrt5\pmod {p^2}     \tag{3.3}
\]

is exact for every nonnegative integer `r`: every binomial term of degree
at least two contains `p^2`.  There is no truncation or probabilistic step.

## 4. The 11 and 89 stages

The first residues independently recompute to

\[
 \eta\equiv1+44\sqrt5,\qquad
 \alpha_0\equiv77+63\sqrt5\pmod {121}.                     \tag{4.1}
\]

Matrix iteration over every `t mod 121` verifies

\[
                         L_t\equiv11(t+4)\pmod {121}.       \tag{4.2}
\]

If `t+4` is nonzero modulo 11, equation (4.2) makes the 11-adic valuation
of `L_t` exactly one.  Hence squarefullness forces

\[
                              t=7+11s.                       \tag{4.3}
\]

For a nonnegative `t`, this representation has `s>=0`.

Modulo `89^2`, the independently powered matrix gives

\[
 \eta^{11}=1+89\cdot41\sqrt5,\qquad
 \alpha_7=39+3785\sqrt5.                                   \tag{4.4}
\]

All 89 residue classes of `s` satisfy

\[
                    L_{7+11s}=89(1+46s)\pmod {89^2}.        \tag{4.5}
\]

Since `46^(-1)=60 mod 89`, squarefullness forces
`s=29 mod 89`.  Nonnegativity then gives

\[
                              t=326+979r,\qquad r\ge0.       \tag{4.6}
\]

Every implication direction and endpoint is correct.

## 5. Ten simultaneous lifts

For each of the ten rows, the independent matrix computation recovered
exactly the certificate values

\[
 \alpha_{326}=x+y\sqrt5,\qquad
 \eta^{979}=1+pd\sqrt5,\qquad
 2x+11=pc\pmod {p^2}.                                      \tag{5.1}
\]

It also recovered `a=10yd mod p`, found `a` nonzero, and recovered the
listed root `rho=-c/a mod p`.  Multiplication gives

\[
 L_{326+979r}=p(c+ar)\pmod {p^2}.                           \tag{5.2}
\]

The audit iterated the independent matrix recurrence for **every**
`r=0,...,p-1` in every row.  All 2,395,824 residue checks passed.  Because
the right side and `(1+pd sqrt(5))^r mod p^2` depend only on `r mod p`,
this finite table proves (5.2) for all nonnegative `r`; it is not a finite
search for squarefull `K_t`.

When `r` is not `rho mod p`, (5.2) says `p|L_t` and `p^2` does not divide
`L_t`, so Section 3 rules out squarefullness.  Thus squarefullness forces
all ten congruences simultaneously.  No row has `a=0`, no modulus divides
3375, and the ten moduli are distinct primes.

## 6. Primality and Pocklington certificates

The largest alleged prime is only 1,801,361.  Exhaustive trial division up
to its integer square root independently proved all ten numbers prime and
re-factored every `p-1`; the results exactly match the table and JSON.

For each distinct prime divisor `q` of each completely factored `p-1`, the
saved witness `b` was checked to satisfy

\[
 b^{p-1}=1\pmod p,
 \qquad
 \gcd(b^{(p-1)/q}-1,p)=1.                                  \tag{6.1}
\]

Different `q` may use different witnesses, as allowed by Pocklington's
criterion.  Here the known factored part is all of `p-1`, and
`p-1>sqrt(p)`.  Thus the saved data is a valid Pocklington proof for every
row.  The generator's deterministic 64-bit Miller--Rabin check is
corroborative; the audit does not rely on its base-set theorem.

## 7. CRT and the exact lower endpoint

Independent CRT reconstruction from the ten `(p,rho)` pairs gives

\[
 \begin{aligned}
 R_0&=124756848858595532142808426058059599119,\\
 M&=187135273287893298214212639087089398679,
 \end{aligned}                                              \tag{7.1}
\]

with `0<R_0<M` and `R_0=rho mod p` for every row.  Their difference is

\[
 M-R_0=62378424429297766071404213029029799560>0.            \tag{7.2}
\]

Substitution into `t=326+979r` gives

\[
 \begin{aligned}
 T_0&=326+979R_0\\
 &=122136955032565025967809449110840347537827,\\
 Q&=979M\\
 &=183205432548847538951714173666260521306741.
 \end{aligned}                                              \tag{7.3}
\]

The independent difference

\[
 Q-T_0=61068477516282512983904724555420173768914>0          \tag{7.4}
\]

proves that `T_0` is already the least nonnegative representative of the
final class.  Therefore (0.1) really excludes every `0<=t<T_0`; it does not
merely give a congruence with a nonminimal representative.

## 8. Adversarial boundary audit

The following limitations are necessary and are respected:

1. The valuation transfer must avoid 3 and 5.  Every sieve prime does.
2. The linear coefficient `a` must be nonzero modulo its prime.  Every row
   is checked, both symbolically and numerically.
3. The step must have real coordinate one modulo `p^2` and imaginary
   coordinate divisible by `p`.  Every full residue is stored and was
   independently recomputed; checking only modulo `p` would not suffice.
4. The preliminary parameterizations preserve nonnegativity:
   `t=7+11s` gives `s>=0`, and `s=29+89r` gives `r>=0`.
5. The ten-prime computation is an exhaustive verification of periodic
   identities.  It is not an extrapolation from a bounded index interval.
6. The final class is nonempty as an integer congruence class.  No evidence
   here decides squarefullness at `T_0+nQ`, so only the explicitly refuted
   residue complements are closed.
7. The theorem concerns this normalized forward orbit.  It does not rule
   out another Danilov orbit, another normalization, or a different Hall
   squarefull construction.

I found no hidden assumption of abc, no finite-search extrapolation, no
primality gap, no CRT sign error, and no overclaim that the Danilov route is
closed.

## 9. Recommended edits

Only one clarification is recommended before treating the report as a
standalone theorem source:

- explicitly state near (2.1), and preferably again in the main theorem,
  that `t` ranges over nonnegative integers.

There is also a systematic TeX transcription issue with no mathematical
effect: source lines 47, 54, 66, 99, 127, 156, 157, and 219 contain
`qquad` without the leading backslash.  They should read `\qquad`.  Lines
37 and 39 already have the correct command.  Without this repair a renderer
interprets the letters as mathematical variables rather than spacing.

Optionally, Section 6 of the research report could mention that the verifier
also checks the mod-125 integrality invariant and polynomial identity if the
new independent verifier is retained.  These facts were already proved in
the preceding report, so their absence from the original generator is not a
gap in the global sieve.

No mathematical statement needs weakening, and no exact route proposition
is refuted beyond the residue classes excluded by (0.1).
