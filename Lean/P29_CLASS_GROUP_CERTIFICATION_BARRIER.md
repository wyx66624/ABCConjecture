# P29 generic class-group certification barrier

## Status

This ledger freezes two independent **aborted diagnostic attempts** for

\[
  K=\mathbf Q(a),\qquad a^{29}=2.
\]

Neither attempt is a class-group certificate.  Both first obtained the
candidate trivial class group and then exposed the size of the generic
unconditional proof phase.  Every frozen transcript explicitly says
`CERTIFICATE_COMPLETED=false`.

## PARI 2.17.1 diagnostic

The Sage/cypari input calls `bnfinit(x^29-2,0)`, checks only its tentative
`CLGP=[1,[],[]]`, enables PARI debug output, and calls `bnfcertify(b,1)`.
The proof phase reported

    Testing primes <= 2660292872242387

and was manually interrupted after the progress line for 572,827.  The
candidate class number and regulator printed before this phase are not
promoted to certified values.

## Oscar/Hecke diagnostic

An independent Oscar 1.8.1 / Hecke 0.39.22 run constructs the maximal order,
checks its exact discriminant `2^28*29^29`, and calls
`class_group(O; GRH=false, redo=true)`.  It reported

    Testing all primes up to 2660292872242388

and was manually terminated.  The subsequent SIGTERM and cleanup SIGSEGV in
the transcript are consequences of stopping the still-running container, not
a successful return and not a mathematical counterexample.  The recorded
`ORPHAN_CONTAINER_STOP_EXIT=0` means only that `docker stop` succeeded; the
Julia calculation has no successful exit code.

## Frozen evidence and limitations

The canonical evidence consists of the PARI debug and Oscar five-file sets:
their input, wrapper, metadata, transcript, and exit ledger.  The checksum
manifest is `audit_scripts/p29_class_group_barrier.sha256`; its generator
validates the exact bounds, the false completion markers, input hashes,
versions, and wrapper syntax without rerunning either infeasible proof.

The wrappers are preserved as executed provenance, including their defects:
they have no signal trap or `END_UTC` after interruption, and the Oscar depot
volume was not frozen by a Project/Manifest snapshot.  They should not be
used unattended.  The immutable container image identifiers and exact input
hashes still make the recorded diagnostics auditable, but not a successful
certificate.

## Audit of the 2026 Lean class-group certificate generator

The framework of Chavarri Villarello--Dahmen,
[*Formally certifying number field invariants*](https://arxiv.org/abs/2607.26230)
and its [official `v1` source](https://github.com/alainchmt/CertifyingInvariantsNF/tree/v1),
can turn suitable external data into kernel-checked class-group proofs.  Its
current generator does not bypass the present barrier.  It first certifies a
full Minkowski factor base and, for this field, the bound is

    2.66029287224239e15.

The `v1` Sage script materializes `list(primes(bound))`; this would contain
about `7.5e13` rational primes before any class-group saturation proof is
generated.  The later `p`-saturation certificate assumes that the proposed
ideal classes already generate the whole class group.  It controls the
kernel of that presentation, not an omitted 2-primary cokernel, so it cannot
by itself prove `Cl(K)[2]=0`.  A new 2-primary generation or odd-cokernel
certificate would be required before this formal framework becomes practical
for the present field.

The mathematical consequence of these two diagnostics is only strategic:
generic full-class-group certification reaches a prime bound around
`2.66e15`.  This generic barrier has since been bypassed by the unconditional
Belabas--Diaz y Diaz--Friedman factor-base criterion.  The certified
RealBall gate in `P29_CL2_BDF_FACTORBASE_ROUTE.md` lowers the complete
generation bound to `40,000,000`.  What remains is an exact relation or
principal-generator certificate for that finite factor base, not a hidden
odd-cokernel assumption.  The independent Galois-module route and the sharp
norm-relation no-go remain recorded in
`P29_CL2_GALOIS_MODULE_AMPLIFICATION_AUDIT.md` and
`P29_CL2_NORM_RELATION_AUDIT.md` as alternative audits.
