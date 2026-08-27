# P31 class-number-one certificate via the BDF factor base

## Result and trust boundary

Let `K=Q(alpha)`, where `alpha^31=2`.  The two audited stages in this
repository establish the following accepted-interface result:

```text
Cl(K)=1.
```

The deduction is short.  The unconditional Belabas--Diaz y Diaz--Friedman
Corollary 5.2 calculation has a strictly positive lower endpoint at the
strict cutoff `T=80,000,000`, so prime ideals of norm `<T` generate `Cl(K)`.
The independent exact verifier then proves every one of those `4,668,356`
prime ideals principal.  Hence every ideal class is trivial.

This is a finite external certificate checked with Sage exact arithmetic and
Arb `RealBall` arithmetic, together with the published BDF theorem and the
standard pure-field index criterion.  It is not yet a theorem checked wholly
inside the Lean kernel.  It also does not by itself prove the abc conjecture
or settle any p=31 Diophantine residual case.

## Analytic generation bound

The field data are

```text
O_K=Z[alpha],  r1=1,  |Delta_K|=2^30*31^31.
```

Here `x^31-2` is Eisenstein at 2 and `2^30 mod 31^2=187 != 1`, so the
pure-prime-degree index criterion gives the displayed integral basis and
discriminant.  The complete BDF sum (all residue degrees and all powers with
strict cutoff `N(P)^m<T`) at 80M is

```text
full_margin = [0.2944058601757084546999811576257929871041149041402660860920359033231 +/- 5.14e-68]
full_margin_lower_endpoint = 0.2944058601757084546999811576257929871041149041402660860920359033230486824475
```

The degree-one-only lower sub-sum remains strictly negative at 80M.  It is
therefore the complete formula, not the degree-one sub-sum, that supplies the
generation theorem.  See `P31_CHEBYSHEV_BDF_THRESHOLD_SCAN.md` and its frozen
audit package for formula, enumeration, image digest, and reproducibility.

The exact strict factor base has

```text
total ideals:                         4,668,356
counts by residue degree:             {1: 4667696, 2: 600, 3: 60}
higher-degree ideals:                 660
```

## Exact principal certificate

The certificate is split into 16 gzip-compressed TSV shards.  Every record
contains `q`, residue degree `f`, 31 coefficients for the chosen factor
polynomial `beta`, and 31 coefficients for a candidate generator `alpha`.
The producer was allowed to use PARI `bnfinit` only to discover candidates.
Its class-group output is not evidence used by the verifier.

The independent verifier constructs no BNF, class group, unit group, or
regulator.  It independently checks:

1. every shard header, strict bound, and rational-prime interval;
2. contiguous coverage of `[2,80000000)` without gaps or overlaps;
3. exact prime enumeration and the splitting law for `x^31-2` modulo each
   rational prime;
4. record ordering, absence of duplicates, and the selected irreducible
   factor of degree `f`;
5. membership of the candidate generator in `(q,beta(alpha))` modulo that
   factor; and
6. the exact identity
   `abs(Resultant(x^31-2, generator))=q^f`.

Containment in the encoded prime ideal together with equality of absolute
norms proves equality of ideals.  The verifier reports

```text
VERIFIED_SHARDS=16
VERIFIED_FACTOR_BASE_IDEALS=4668356
VERIFIED_HIGHER_DEGREE_IDEALS=660
VERIFIED_COUNTS_BY_RESIDUE_DEGREE={1: 4667696, 2: 600, 3: 60}
NO_BNF_OR_CLASS_GROUP_USED=1
NO_UNIT_GROUP_OR_REGULATOR_USED=1
P31_BDF_PRINCIPAL_EXACT_VERIFY_PASS
EXIT_CODE=0
```

## Failure and recovery provenance

Two failed publishing attempts are deliberately retained.

- Attempt 1 generated all 16 compressed shards, but the background RSS
  monitor raced a disappearing worker under `set -euo pipefail`; the wrapper
  stopped before summary and verification.  Its exit code is 1.
- Attempt 2 reused and validated those shards, obtained the independent exact
  verifier pass, then stopped after that pass and before the atomic publish
  move.  Because that wrapper had no `ERR` trap, the exact failing shell
  command is not recoverable from the transcript; the observable failure
  boundary is preserved rather than guessed.  Its exit code is 1.

The generation-version producer also emitted a GP syntax diagnostic from a
multiline top-level environment range guard.  GP skipped that guard but
continued generation.  This does not supply or remove a proof premise: the
independent verifier itself validates each shard range, proves complete
contiguous coverage, reconstructs every expected prime ideal, and checks all
records and totals.  The current producer places the guard on one line, and a
fresh 100,000 smoke run has no syntax diagnostic and passes the independent
verifier.

The final recovery did not regenerate certificates.  It bound attempt 2 by
hash, checked all 16 shard hashes and gzip streams, reran the independent
verifier from scratch, and performed the atomic publish.  The final transcript
ends in `P31_BDF_PRINCIPAL_PUBLISH_RECOVERY_PASS` and `EXIT_CODE=0`.

Fresh generation occupied about 46 minutes wall time across 16 workers
(individual shard times 2592--2759 seconds).  The final compressed shard set
is 200,764,930 bytes.  Resource observations during the run were roughly
80--82 MiB RSS per worker and about 3.2 GiB total system memory used, with no
swap; these are observational, not frozen peak-RSS certificates, because the
attempt-1 monitor failed.

## Frozen artifacts

The overall manifest is
`audit_scripts/p31_chebyshev_cl1_bdf_principal.sha256`.  Its maker checks the
analytic 80M positive lower endpoint, both historical exit-1 ledgers, the
generation-version producer hash, the corrected smoke run, the final exit-0
recovery markers, the exact counts, the 16-shard hash manifest and gzip
integrity, and then hashes every source, wrapper, ledger, shard, and this
report.  The immutable generation bytes are retained separately as
`p31_chebyshev_cl1_bdf_principal_generators_generation_v1.gp`.
