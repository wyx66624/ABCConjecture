# Accepted-theorem dependency policy

Author: ChatGPT  
Effective date: 2026-08-27

## Purpose

The sole mathematical objective of this repository is to prove or disprove
the abc conjecture.  The earlier diagnostic preference that every exported
Lean theorem have only `propext`, `Classical.choice`, and `Quot.sound` in its
kernel axiom report is not a restriction on the methods that may be used.
`#print axioms` remains an audit instrument, not a three-axiom admission rule.

## Admissible inputs

An argument may use any precisely stated definition, theorem, method, or exact
computer-assisted calculation that has already been proved and is accepted in
the mathematical literature.  This includes results not yet formalized in
mathlib.  If such a result is represented in Lean by a named external theorem
interface or an axiom, the accompanying audit must give:

1. the exact mathematical statement actually used;
2. a primary bibliographic source, including theorem and page identifiers
   where available;
3. every hypothesis and normalization needed for the application;
4. the trust chain for any computer algebra or certified computation; and
5. the output of `#print axioms`, separating Lean-kernel dependencies from
   explicitly imported mathematical results.

Reproducible exact CAS computations are admissible when the input, software
version, transcript, and independent mathematical interpretation are
preserved.  A numerical heuristic or an uncertified conditional class-group
bound is not an exact computation for this purpose.

## What the relaxation does not license

The following do not count as an unconditional proof merely because they are
given a Lean name or stored as a field:

* `ABCConjecture` itself, Szpiro in an abc-equivalent strength, or any other
  reformulation already proved equivalent to abc;
* a theorem conditional on GRH, BSD, finiteness of a Tate--Shafarevich group,
  or another open conjecture, unless the final result is explicitly labelled
  conditional on that conjecture;
* a disputed assertion whose proof is the point at issue, including the
  source-to-height and common-scale estimates in the present IUT audit;
* a floating-point experiment, finite search, or candidate CAS output without
  the certificate needed to justify the universal statement; or
* a definition whose mere inhabitation encodes the desired conclusion.

Definitions may be introduced freely, but a definition supplies no existence
or inequality theorem by itself.

## Completion labels

Every claimed endpoint must use one of the following descriptions.

* **Lean-kernel closed:** all mathematical inputs used by the endpoint are
  themselves formalized in the checked dependency graph.
* **Closed relative to accepted theorem interfaces:** Lean verifies the
  deduction, and the remaining named interfaces are exact statements of
  independently accepted theorems or certified computations documented as
  above.
* **Conditional:** at least one named input is open, disputed, heuristic, or
  not yet certified.

Only the first two labels may be called an unconditional proof of abc, and in
the second case the external dependency ledger must be published with the
proof.  This policy supersedes any earlier use of a three-axiom subset as a
methodological gate while preserving the repository's no-hidden-target and
no-hidden-conjecture requirements.
