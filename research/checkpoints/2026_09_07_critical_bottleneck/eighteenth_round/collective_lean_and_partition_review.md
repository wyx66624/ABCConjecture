# Bounded full reviews: collective arithmetic and actual large-prime barrier

2026-09-07. All reviewed sources were read without editing them.

## Root seventeenth-round Lean core

Full source, proof and ordinary-scope review: PASS.

ComplementContent.lean:
5ce0713043405dffb2bc15e111b9082d6ea9a5335a7b7e80ecedd3de3c806b3d.
All 24 theorem signatures and proofs were read. The content is the
literal Int.gcd, the primitive coordinates use integer division, and the
cleared equalities follow from the actual multiplication and reconstruction.
Bezout proves normalizer divisibility, not a supplied premise. Positivity
and cancellation give the exact multiplier and actual two- and three-entry
gcd. Recovered absolute boundary equality feeds the literal primeFactors
radical and actual factorization/Real.log signed sum by substitution.
The identities also handle zero individual coordinates; the arithmetic
observable at boundary zero uses Lean's explicit definitions and is not
an analytic assertion about log zero.

SquarefreePowerExtraction.lean:
a51957c6846595f7dd2b760f3f5aa80211bdf7002645c905325bc5ace426c745.
All 16 theorem signatures and proofs were read. Actual squarefreeness and
coprimality of R,D yield Q|D, R|V and Q^g|D without requiring gcd(V,Q)=1.
An actual prime divisor of Q gives a factorization-depth bound on g.
The logarithmic inequalities retain nonzero/positive denominator premises.
The final result proves the exact delta log(7) B/6 conclusion from the
explicit actual-natural profile and mass lower bound, with B>=36.
Realizing that profile on Eisenstein interval products, PNT, and the
asymptotic uniform mass statement remain ordinary input.

Both source hashes were independently recomputed and matched the root's
current validation manifest. The reported 40 new/55 dependency fresh build
was performed by root, not repeated by this reviewer. This review does not
claim an independent additional compiler run.

The SquarefreePowerExtraction digest above was recomputed from the actual
source and corrected after a transcription omission in this review. The
reviewed source bytes and the root validation evidence were not changed.

## LP1--LP4 actual large-prime partition

Full ordinary proof and full exact verifier source: PASS.
Source: adversarial_audit/eighteenth_round/large_prime_partition_barrier.md.

The divisor dichotomy H|R or H>=q determines the exact central gap using
both available endpoint divisors R and q. All balance/no-face/scalar
hypotheses are retained. The concrete non-square endpoint has complete
factorization 13^2 q, not an omitted radical cofactor.

The recursive Lucas criterion proves every node using complete p-1
factorizations and witnesses separately for each prime divisor; no
probable-prime predicate is trusted. Independently executed the read-only
--check: PASS, 25 prime nodes and 70 modular/gcd witnesses. Canonical SHA:
3b4de60c0f5fb1fcba68b7def3b655db4b406047de5ea764f7b29b66f729fb51.
The exact rational-power comparison proves Gamma>52D.

The conditional infinite p^2 q continuation is explicitly conditional;
its eventual scalar defect and one-half budget asymptotic are correct.
The finite example refutes Gamma<=D and Gamma=0 on the displayed class,
but not a gate allowing arbitrary C_epsilon, and not ABC. No correction.
