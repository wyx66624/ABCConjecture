/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Exponent-residue encoding for radical-small integers

For a fixed positive integer `m`, every prime exponent `e` decomposes uniquely
as

`e = (e % m) + m * (e / m)`.

The residue belongs to `Fin m`.  On a support of cardinality `s`, all residue
vectors therefore form a type of cardinality `m^s`; positive `m`-free residue
choices form a type of cardinality `(m-1)^s`.  These are the finite local
encoding facts used in the counting theorem for integers with small radical.

This module does not yet multiply the local exponent decompositions over the
prime factorization of a natural number.  That arithmetic assembly and the
summatory divisor estimate are subsequent layers.
-/

namespace IUTThreeClosures

/-- Quotient part of an exponent with respect to the `m`-th-power
factorization. -/
def exponentPowerQuotient (e m : ℕ) : ℕ :=
  e / m

/-- Residue exponent in the canonical `m`-free part. -/
def exponentPowerResidue (e m : ℕ) : ℕ :=
  e % m

/-- Euclidean division reconstructs the original exponent. -/
theorem exponentPower_reconstruct (e m : ℕ) :
    exponentPowerResidue e m +
        m * exponentPowerQuotient e m = e := by
  exact Nat.mod_add_div e m

/-- For positive `m`, the residue exponent lies in the expected range. -/
theorem exponentPowerResidue_lt
    (e m : ℕ) (hm : 0 < m) :
    exponentPowerResidue e m < m := by
  exact Nat.mod_lt e hm

/-- Package the residue exponent as an element of `Fin m`. -/
def exponentPowerResidueFin
    (e m : ℕ) (hm : 0 < m) : Fin m :=
  ⟨exponentPowerResidue e m, exponentPowerResidue_lt e m hm⟩

/-- A support with `s` primes has exactly `m^s` unrestricted residue vectors. -/
theorem card_exponentResidueVectors (s m : ℕ) :
    Fintype.card (Fin s → Fin m) = m ^ s := by
  simp

/-- If every supported prime must occur with a positive residue exponent, the
number of choices is `(m-1)^s`. -/
theorem card_positiveExponentResidueVectors (s m : ℕ) :
    Fintype.card (Fin s → Fin (m - 1)) = (m - 1) ^ s := by
  simp

/-- Ordered assignment of each of `s` distinct supported primes to one of `m`
factors has cardinality `m^s`.  For a squarefree radical this is the elementary
combinatorial interpretation of the ordered divisor function `tau_m`. -/
theorem card_orderedFactorAssignments (s m : ℕ) :
    Fintype.card (Fin s → Fin m) = m ^ s := by
  simp

end IUTThreeClosures
