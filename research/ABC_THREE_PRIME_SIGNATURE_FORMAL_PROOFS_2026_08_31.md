# Formal proof record for the elementary three-prime signatures

Date: 2026-08-31. Author: ChatGPT.

This record concerns only
`Lean/IUTThreeClosures/ABCThreePrimeSignatures20260831.lean`.
Its mathematical proofs appear first in
`research/ANALYTIC_THREE_PRIME_SUPPORT_2026_08_31.md`, especially
Propositions 4.2 and 4.3.  The module does not formalize Fermat's Last
Theorem, Mihăilescu's theorem, the Arif--Abu Muriefah theorem, the complete
signature `(2,2,n)`, or the general abc conjecture.

## 1. Audited artifact

* file size: 10,888 bytes;
* SHA-256:
  `A324E6BE05574949BDD3FB1E95E0134164937F08019586332673CBEE8745ADF9`;
* namespace:
  `IUTThreeClosures.ABCThreePrimeSignatures20260831`;
* public declarations: 16 theorems, no definitions and no project-specific
  or nonstandard axioms.

The imports are narrow:

* `Mathlib.Data.Nat.Prime.Basic`;
* `Mathlib.Tactic.Linarith`;
* `Mathlib.Tactic.NormNum`;
* `Mathlib.Tactic.Ring`.

## 2. Mathematical content

The first six declarations prove reusable factor and parity facts:

1. a smaller factor of a prime square is one;
2. two nonunit factors of a prime square are equal;
3. a natural square is not prime;
4. consecutive primes are `(2,3)`;
5. `q+1=r^2` for primes forces `(q,r)=(3,2)`;
6. `q^2+1=r` for primes forces `(q,r)=(2,5)`.

The next six declarations implement the factorization arguments:

* `P^2+Q^3` is neither a prime cube nor a prime sixth power;
* cubes of two distinct nonunits cannot sum to a prime square;
* in particular, cubes of distinct primes cannot sum to a prime square;
* `P^2+Q^6` is not a prime cube;
* `P^3+Q^6` is not a prime square.

The final four declarations package every input order and every output
placement of signatures `(2,3,3)` and `(2,3,6)`.  The only distinctness
hypothesis needed explicitly by the `(2,3,3)` package is `P != Q` in the
two-cubes case.  In the sixth-power two-cubes reduction, distinctness of
`P` and `Q^2` is proved internally from the primality of `P`.

## 3. Reproducible checks

From the `Lean` directory, both checks returned exit code zero:

```text
lake env lean IUTThreeClosures/ABCThreePrimeSignatures20260831.lean
lake build IUTThreeClosures.ABCThreePrimeSignatures20260831
```

The target build completed all 828 jobs successfully with no warning.  The
current module also prints the axiom dependencies of the principal factor
lemma and the four final signature packages, so direct compilation and a
replayed target build emit five informational `#print axioms` records.

An earlier clean target build, before those informational commands were
appended, reported:

```text
Built IUTThreeClosures.ABCThreePrimeSignatures20260831
Build completed successfully (828 jobs).
```

There was no target warning.  A separate temporary audit imported the module
and ran `#print axioms` on all 16 public theorems.  Every theorem reported only

```text
[propext, Classical.choice, Quot.sound]
```

which are the standard Lean/Mathlib logical axioms.  No theorem depends on a
project-specific axiom, an abc statement, or an external Diophantine
classification interface.

## 4. Exact boundary

The module proves equation-level exclusions.  It does not prove the preceding
support reduction from an arbitrary primitive triple with `omega(abc) <= 3`;
that reduction remains a paper theorem in the companion report.  Nor does it
claim that the still-open signatures `(2,3,4)`, `(2,3,5)`, the linear-exponent
branch, or the hyperbolic Fermat--Catalan branch are empty.
