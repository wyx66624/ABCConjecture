# IF1--IF3 independent complete review

Status: **full ordinary proof PASS**. The complete finite-input verifier was
also actually read and independently executed with `--check`, terminal exit 0.
No reviewed source or certificate was modified.

Actual source:
`research/checkpoints/2026_09_07_collective_content_closure/next_infinity_disk_certificate.md`,
SHA256 `3aa6ee04f3751bd2107852f058b6cf904bf5109e18bd4dd96b1a0ddea6a4269a`.
Verifier `next_replay_infinity_inputs.py` SHA256
`2c05c2a77bbd7600340d5221807cd9a970afff46d7e847b80f7b48178ffacc96`.
Canonical `next_verification/infinity_inputs.json` SHA256
`9671a4f70cd70faf3ffa41e9dcca440d246ad7f824ac38fbe92f587ab6c63c95`.

## Pole cancellation and coefficient integrality

The exact root-parameter identity is `t1=-2q(1-9q^2)/v`. The short-model
expansion `w=t^3 U`, `x=t^-2/U`, `y=-t^-3/U` has integral even unit U. The
integer division polynomials have leading terms `9x^40`, `x^81`, and
`D=9x^120`; differentiating gives the coefficient `9(81-80)=9`. The standard
leading-degree statement agrees with the previously actually opened
[Sutherland Lecture 5, Lemma 5.22, printed pages 12--13](https://math.mit.edu/classes/18.783/2023/LectureNotes5.pdf).

Multiplying by the respective powers of t leaves integral even units with
constant 9, 1, 9. Substitution in RD1 therefore gives `delta=t^81 V(t^2)`
with constant-one V, and `[9]t=t(9+...)`. The sign from y is essential and
is correct. Thus `q^-81 delta1(R1)` is `(-2)^81` times an integral even
unit, with no evaluation of a Laurent pole at zero.

At R2 the actual integral jet in q^2 is `(2+4e,2+3e)` modulo five.
The finite division table gives the specified unit phi and omega and
divisible psi. These assertions imply unit denominators on the entire
integral formal disk, including nine-torsion points. The substitution
q=5s produces restricted series, `T1,T2 in 5A` and `Xi/Xi(0) in 1+25A`.
The infinite logarithm tail has Gauss valuations `2j-v5(j)`, so all of its
change is in 25A. This is a full-tail argument, not finite-jet inference.

## Exact center and all other places

The doubling law gives `2P'=(33/4,9/8)` and the actual center is its
negative. The first singular-height/base-coordinate combination tends
to `-2log_5(2)` since `t1/q -> -2`. The first elliptic logarithm tends
to zero; evenness of the second local height gives exactly IF4.

The minimal E' discriminant has only 2 and 3 as prime factors, with both
valuations below 12. At 2 the x valuation is -2 and the derivative test
is negative. At 3 the actual tests are A=5, B=2, C=6 and v3(c4)=4. These
select respectively the nonsingular/denominator case and additive case
with C>=3B, giving `2log_5(2)` and `-(4/3)log_5(3)`. All remaining finite
places other than 5 have good reduction and integral coordinates.
The normalizations and both branches were checked by actually reopening
[Cremona, chapter 3, Proposition 3.4.1 and the normalization paragraph,
printed page 72](https://johncremona.github.io/book/fulltext/chapter3.pdf).

The global/local identity for this **actual rational elliptic point**,
with the zero splitting changing only the place five, now proves the
center value exactly. It does not assume any sequence of global genus-two
rational points tending to infinity. No uncomputed other-prime term remains.

## Full disk factorization

The actual pullbacks give `ell1'=-2/v` and `ell2'=2q/v`, with constants
0 and `-2log(P')`. Integration denominators at every degree give the
claimed changes `ell1(5s)/5=-2s mod5A` and `ell2(5s)-ell2(0) in25A`.
The full ZS bounds put the R0 changes in 25A; the second log-square
change is in 125A before multiplying by its valuation-minus-one alpha.
Thus only the first log-square survives in `g=f(5s)/5 mod5A`, giving
`g=s^2 mod5A` with the correct minus sign and alpha digit.

The source then uses **exact** DS evenness and **exact** center vanishing,
not only their reductions. Consequently the constant and linear coefficients
are actually zero. Dividing by s^2 merely shifts restricted integral
coefficients, giving `g/s^2 in1+5A`. Its value is a unit everywhere on Z5.
This proves that the sole zero is the center with order exactly two. DS
transports this to the other infinity disk without changing multiplicity.

The executed replay checks the rational double, curve equation, complete
division jets, relevant local valuation tests, and the alpha digit. It
reuses the already source-audited UD and ZS exact arithmetic; its hashes
are recorded in the canonical output. This is an independent replay of
the author's program, not a second implementation or a formal proof of
the analytic tail. The complete disk proof is the ordinary argument above.

Conclusion is limited to the two infinity disks: two rational zeros, each
of multiplicity two. Rationality of other local zeros, the remaining disk
orbits, intrinsic higher-genus QC loci, and uniform ABC interfaces are not
claimed here.
