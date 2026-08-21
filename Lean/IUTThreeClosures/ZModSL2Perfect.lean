import IUTThreeClosures.SolvableRestrictionImage

/-!
# Perfectness of `SL₂(𝔽_ℓ)` for admissible primes

For a prime `ℓ ≥ 5`, the element `2 ∈ 𝔽_ℓ` is nonzero and its square is not
one.  The elementary commutator calculation in Mathlib therefore proves that
`SL₂(𝔽_ℓ)` is perfect.  Combining this with
`SolvableRestrictionImage` gives the exact group-theoretic large-image lemma
needed after adjoining a solvable auxiliary field.
-/

namespace IUTThreeClosures

/-- The class of `2` is nonzero modulo every prime `ℓ ≥ 5`. -/
theorem two_ne_zero_zmod_of_five_le
    {ℓ : ℕ} (h5 : 5 ≤ ℓ) : (2 : ZMod ℓ) ≠ 0 := by
  intro h
  have hdiv : ℓ ∣ 2 := (ZMod.natCast_eq_zero_iff 2 ℓ).mp h
  have hle : ℓ ≤ 2 := Nat.le_of_dvd (by norm_num) hdiv
  omega

/-- The square of `2` is not one modulo every prime `ℓ ≥ 5`. -/
theorem two_sq_ne_one_zmod_of_five_le
    {ℓ : ℕ} (h5 : 5 ≤ ℓ) : (2 : ZMod ℓ) ^ 2 ≠ 1 := by
  intro h
  have hthree : (3 : ZMod ℓ) = 0 := by
    calc
      (3 : ZMod ℓ) = (2 : ZMod ℓ) ^ 2 - 1 := by norm_num
      _ = 0 := by rw [h]; ring
  have hdiv : ℓ ∣ 3 := (ZMod.natCast_eq_zero_iff 3 ℓ).mp hthree
  have hle : ℓ ≤ 3 := Nat.le_of_dvd (by norm_num) hdiv
  omega

/-- `SL₂(𝔽_ℓ)` is perfect for every prime `ℓ ≥ 5`. -/
theorem zmod_sl2_isPerfect
    {ℓ : ℕ} (hℓ : ℓ.Prime) (h5 : 5 ≤ ℓ) :
    Group.IsPerfect (Matrix.SpecialLinearGroup (Fin 2) (ZMod ℓ)) := by
  letI : Fact ℓ.Prime := ⟨hℓ⟩
  exact sl2_isPerfect_of_element
    (two_ne_zero_zmod_of_five_le h5)
    (two_sq_ne_one_zmod_of_five_le h5)

/-- A surjective mod-`ℓ` representation retains every special-linear matrix
after restriction to a normal subgroup with solvable quotient. -/
theorem zmod_specialLinear_mem_range_restriction
    {G : Type*} [Group G]
    {ℓ : ℕ} (hℓ : ℓ.Prime) (h5 : 5 ≤ ℓ)
    (ρ : G →* Matrix.GeneralLinearGroup (Fin 2) (ZMod ℓ))
    (hρ : Function.Surjective ρ)
    (N : Subgroup G) [N.Normal]
    [IsSolvable (G ⧸ N)]
    (A : Matrix.SpecialLinearGroup (Fin 2) (ZMod ℓ)) :
    A.toGL ∈ (ρ.comp N.subtype).range := by
  letI : Fact ℓ.Prime := ⟨hℓ⟩
  letI : Group.IsPerfect
      (Matrix.SpecialLinearGroup (Fin 2) (ZMod ℓ)) :=
    zmod_sl2_isPerfect hℓ h5
  exact specialLinear_mem_range_restriction_of_solvable_quotient
    ρ hρ N A

end IUTThreeClosures