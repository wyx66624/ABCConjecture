/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.RingTheory.Trace.Basic
import Mathlib.RingTheory.Valuation.Basic

/-!
# Actual algebra trace and return to the coefficient field

The complete mathematical proofs precede this module in
`research/TRACE_COVARIANT_RATIONAL_RETURN_PROOFS_2026_08_31.md`.

We use the actual algebra trace, actual algebra maps and actual module
dimensions. The trace-transport identity remains an explicit hypothesis;
this file does not reconstruct local Galois or Kummer arrows. One nonzero
return to the coefficient field forces the whole coefficient line to
follow the same scalar when dimensions agree. A valuation-zero scalar
then preserves the valuation of every specified return.

The p-adic logarithm, arithmetic prime-support fibre and ABC are separate
results and are not claimed to be formalized by these lemmas.
-/

namespace IUTThreeClosures.TraceCovariantRationalReturn20260831

universe uK uS uT uV

variable {K : Type uK} [Field K]
variable {S : Type uS} [CommRing S] [Algebra K S]
variable {T : Type uT} [CommRing T] [Algebra K T]

/-- Scalar traces retain both actual dimensions before any cancellation. -/
theorem scalar_return_trace_balance (F : S →ₗ[K] T) (c a b : K)
    (htrace : ∀ x, Algebra.trace K T (F x) = c * Algebra.trace K S x)
    (hreturn : F (algebraMap K S a) = algebraMap K T b) :
    (Module.finrank K T : K) * b = c * ((Module.finrank K S : K) * a) := by
  have h := htrace (algebraMap K S a)
  rw [hreturn, Algebra.trace_algebraMap, Algebra.trace_algebraMap] at h
  simpa only [nsmul_eq_mul] using h

section EqualDimension

variable [CharZero K] [Nontrivial S] [Module.Finite K S]

/-- Equal positive dimensions cancel in the field, even if a residue prime divides them. -/
theorem scalar_return_of_equal_finrank (F : S →ₗ[K] T) (c a b : K)
    (hdegree : Module.finrank K S = Module.finrank K T)
    (htrace : ∀ x, Algebra.trace K T (F x) = c * Algebra.trace K S x)
    (hreturn : F (algebraMap K S a) = algebraMap K T b) :
    b = c * a := by
  have hdim : (Module.finrank K S : K) ≠ 0 :=
    Nat.cast_ne_zero.mpr (ne_of_gt (Module.finrank_pos (R := K) (M := S)))
  have h := scalar_return_trace_balance F c a b htrace hreturn
  rw [← hdegree] at h
  apply mul_left_cancel₀ hdim
  simpa only [mul_left_comm c (Module.finrank K S : K) a] using h

/-- A single nonzero return determines the image of the actual algebra unit. -/
theorem map_one_of_nonzero_scalar_return (F : S →ₗ[K] T) (c a b : K)
    (hdegree : Module.finrank K S = Module.finrank K T)
    (htrace : ∀ x, Algebra.trace K T (F x) = c * Algebra.trace K S x)
    (ha : a ≠ 0) (hreturn : F (algebraMap K S a) = algebraMap K T b) :
    F 1 = algebraMap K T c := by
  have hb := scalar_return_of_equal_finrank F c a b hdegree htrace hreturn
  have hscaled : a • F (1 : S) = a • algebraMap K T c := by
    calc
      a • F (1 : S) = F (algebraMap K S a) := by
        rw [Algebra.algebraMap_eq_smul_one, map_smul]
      _ = algebraMap K T b := hreturn
      _ = a • algebraMap K T c := by
        rw [hb, Algebra.smul_def, map_mul, mul_comm]
  have h := congrArg (fun x : T => a⁻¹ • x) hscaled
  simpa only [smul_smul, inv_mul_cancel₀ ha, one_smul] using h

/-- One nonzero return forces the entire coefficient line to use the same scalar. -/
theorem scalar_line_of_nonzero_return (F : S →ₗ[K] T) (c a b : K)
    (hdegree : Module.finrank K S = Module.finrank K T)
    (htrace : ∀ x, Algebra.trace K T (F x) = c * Algebra.trace K S x)
    (ha : a ≠ 0) (hreturn : F (algebraMap K S a) = algebraMap K T b)
    (t : K) :
    F (algebraMap K S t) = algebraMap K T (c * t) := by
  have hunit := map_one_of_nonzero_scalar_return F c a b hdegree htrace ha hreturn
  rw [Algebra.algebraMap_eq_smul_one, map_smul, hunit]
  simp only [Algebra.smul_def, map_mul, mul_comm]

/-- Rational return is an explicit point condition, equivalent here to a full scalar-line action. -/
theorem exists_nonzero_return_iff_scalar_line (F : S →ₗ[K] T) (c : K)
    (hdegree : Module.finrank K S = Module.finrank K T)
    (htrace : ∀ x, Algebra.trace K T (F x) = c * Algebra.trace K S x) :
    (∃ a b : K, a ≠ 0 ∧ F (algebraMap K S a) = algebraMap K T b) ↔
      ∀ t : K, F (algebraMap K S t) = algebraMap K T (c * t) := by
  constructor
  · rintro ⟨a, b, ha, hreturn⟩ t
    exact scalar_line_of_nonzero_return F c a b hdegree htrace ha hreturn t
  · intro h
    exact ⟨1, c, one_ne_zero, by simpa only [mul_one] using h 1⟩

/-- Valuation zero, rather than merely field invertibility, is the relevant scalar condition. -/
theorem scalar_return_addValuation
    {V : Type uV} [LinearOrderedAddCommMonoidWithTop V]
    (v : AddValuation K V) (F : S →ₗ[K] T) (c a b : K)
    (hdegree : Module.finrank K S = Module.finrank K T)
    (htrace : ∀ x, Algebra.trace K T (F x) = c * Algebra.trace K S x)
    (hc : v c = 0) (hreturn : F (algebraMap K S a) = algebraMap K T b) :
    v b = v a := by
  rw [scalar_return_of_equal_finrank F c a b hdegree htrace hreturn,
    v.map_mul, hc, zero_add]

/-- Different valuations exclude the prescribed return under the actual algebra trace. -/
theorem no_scalar_return_of_addValuation_ne
    {V : Type uV} [LinearOrderedAddCommMonoidWithTop V]
    (v : AddValuation K V) (F : S →ₗ[K] T) (c a b : K)
    (hdegree : Module.finrank K S = Module.finrank K T)
    (htrace : ∀ x, Algebra.trace K T (F x) = c * Algebra.trace K S x)
    (hc : v c = 0) (hne : v b ≠ v a) :
    F (algebraMap K S a) ≠ algebraMap K T b := by
  intro hreturn
  exact hne (scalar_return_addValuation v F c a b hdegree htrace hc hreturn)

end EqualDimension

end IUTThreeClosures.TraceCovariantRationalReturn20260831
