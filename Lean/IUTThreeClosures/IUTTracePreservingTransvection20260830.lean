/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib.LinearAlgebra.Transvection.Basic
import Mathlib.Tactic.LinearCombination

/-!
# Common avoidance by an actual trace-preserving transvection

The mathematical proof is in `research/UNIFORM_GATE_STRUCTURAL_TESTS_2026_08_30.md`.
No Galois-image or local-field identification is inferred from this linear theorem.
-/

namespace IUTThreeClosures.IUTTracePreservingTransvection20260830

open Module

variable {K V : Type*} [Field K] [AddCommGroup V] [Module K V]

/-- A linear functional can be chosen nonzero on two prescribed nonzero vectors. -/
theorem exists_dual_nonzero_pair (x y : V) (hx : x ≠ 0) (hy : y ≠ 0) :
    ∃ f : Dual K V, f x ≠ 0 ∧ f y ≠ 0 := by
  obtain ⟨f, hfx⟩ := Module.Projective.exists_dual_eq_one K hx
  by_cases hfy : f y = 0
  · obtain ⟨g, hgy⟩ := Module.Projective.exists_dual_eq_one K hy
    by_cases hgx : g x = 0
    · refine ⟨f + g, ?_, ?_⟩ <;> simp [hfx, hfy, hgx, hgy]
    · exact ⟨g, hgx, by simp [hgy]⟩
  · exact ⟨f, by simp [hfx], hfy⟩

/-- The same choice imposes no condition on an input that is zero. -/
theorem exists_dual_nonzero_when_nonzero (x y : V) :
    ∃ f : Dual K V, (x ≠ 0 → f x ≠ 0) ∧ (y ≠ 0 → f y ≠ 0) := by
  by_cases hx : x = 0
  · by_cases hy : y = 0
    · exact ⟨0, by simp [hx], by simp [hy]⟩
    · obtain ⟨f, hf⟩ := Module.Projective.exists_dual_eq_one K hy
      exact ⟨f, by simp [hx], fun _ => by simp [hf]⟩
  · by_cases hy : y = 0
    · obtain ⟨f, hf⟩ := Module.Projective.exists_dual_eq_one K hx
      exact ⟨f, fun _ => by simp [hf], by simp [hy]⟩
    · obtain ⟨f, hfx, hfy⟩ := exists_dual_nonzero_pair (K := K) x y hx hy
      exact ⟨f, fun _ => hfx, fun _ => hfy⟩

/-- Two nonzero affine polynomials cannot vanish at all of `0,1,-1`. -/
theorem exists_scalar_avoiding_two_affine
    (h_two : (2 : K) ≠ 0) (a b c d : K)
    (hab : a ≠ 0 ∨ b ≠ 0) (hcd : c ≠ 0 ∨ d ≠ 0) :
    ∃ z : K, a + z * b ≠ 0 ∧ c + z * d ≠ 0 := by
  have hfirst (a b c d : K) (ha : a = 0) (hb : b ≠ 0)
      (hcd : c ≠ 0 ∨ d ≠ 0) :
      ∃ z : K, a + z * b ≠ 0 ∧ c + z * d ≠ 0 := by
    by_cases hpos : c + d = 0
    · have hd : d ≠ 0 := by
        intro hd
        have hc : c = 0 := by simpa [hd] using hpos
        exact hcd.elim (fun h => h hc) (fun h => h hd)
      refine ⟨-1, by simpa [ha] using neg_ne_zero.mpr hb, ?_⟩
      intro hneg
      have htwod : (2 : K) * d = 0 := by linear_combination hpos - hneg
      exact (mul_ne_zero h_two hd) htwod
    · exact ⟨1, by simpa [ha] using hb, by simpa using hpos⟩
  by_cases ha : a = 0
  · exact hfirst a b c d ha (hab.resolve_left (not_not.mpr ha)) hcd
  · by_cases hc : c = 0
    · obtain ⟨z, hz₁, hz₂⟩ :=
        hfirst c d a b hc (hcd.resolve_left (not_not.mpr hc)) hab
      exact ⟨z, hz₂, hz₁⟩
    · exact ⟨0, by simpa using ha, by simpa using hc⟩

/-- A possibly trivial transvection preserves `t` and places both inputs outside
`ker l`. This is a theorem about the full linear stabilizer, not about its
realization by a source Galois group. -/
theorem exists_trace_preserving_common_avoidance
    (h_two : (2 : K) ≠ 0) (t l : Dual K V) (w x y : V)
    (htw : t w = 0) (hlw : l w = 1) (hx : x ≠ 0) (hy : y ≠ 0) :
    ∃ F : V ≃ₗ[K] V, (∀ v, t (F v) = t v) ∧ l (F x) ≠ 0 ∧ l (F y) ≠ 0 := by
  let P : V →ₗ[K] V := LinearMap.id - (LinearMap.toSpanSingleton K V w).comp l
  have hP (v : V) : P v = v - l v • w := rfl
  have hPw : P w = 0 := by simp [hP, hlw]
  obtain ⟨h, hhx, hhy⟩ := exists_dual_nonzero_when_nonzero (K := K) (P x) (P y)
  let f : Dual K V := h.comp P
  have hfw : f w = 0 := by simp [f, hPw]
  have hfx : l x ≠ 0 ∨ f x ≠ 0 := by
    by_cases hlx : l x = 0
    · right
      have hPx : P x = x := by simp [hP, hlx]
      exact hhx (by simpa [hPx] using hx)
    · exact Or.inl hlx
  have hfy : l y ≠ 0 ∨ f y ≠ 0 := by
    by_cases hly : l y = 0
    · right
      have hPy : P y = y := by simp [hP, hly]
      exact hhy (by simpa [hPy] using hy)
    · exact Or.inl hly
  obtain ⟨z, hzx, hzy⟩ := exists_scalar_avoiding_two_affine h_two (l x) (f x)
    (l y) (f y) hfx hfy
  have hzw : f (z • w) = 0 := by simp [hfw]
  let F : V ≃ₗ[K] V := LinearEquiv.transvection hzw
  refine ⟨F, ?_, ?_, ?_⟩
  · intro v
    simp [F, LinearMap.transvection.apply, htw]
  · simpa [F, LinearMap.transvection.apply, hlw, mul_comm, smul_smul] using hzx
  · simpa [F, LinearMap.transvection.apply, hlw, mul_comm, smul_smul] using hzy

end IUTThreeClosures.IUTTracePreservingTransvection20260830
