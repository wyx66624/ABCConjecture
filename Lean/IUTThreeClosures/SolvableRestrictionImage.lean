import Mathlib

/-!
# Perfect image persistence under solvable base change

A central step in constructing an actual admissible-prime family is to pass
from a large mod-ℓ Galois image over a ground field to the image over a finite
solvable extension used to rationalize the auxiliary torsion and adjoin
`√(-1)`.  The group-theoretic content is independent of elliptic curves:

* every homomorphism from a perfect group to a solvable group is trivial;
* if `ρ : G → K` is surjective and `N ◁ G` has solvable quotient, then every
  perfect subgroup of `K` lies in `ρ(N)`;
* equivalently, the restriction of `ρ` to `N` still contains that perfect
  subgroup.

For the intended application the perfect subgroup is `SL₂(𝔽_ℓ)` inside
`GL₂(𝔽_ℓ)`, while `G/N` is the Galois group of the solvable auxiliary base
extension.
-/

namespace IUTThreeClosures

/-- A homomorphism from a perfect group to a solvable group is trivial. -/
theorem perfect_hom_eq_one_of_solvable
    {P Q : Type*} [Group P] [Group Q]
    [Group.IsPerfect P] [IsSolvable Q]
    (f : P →* Q) : f = 1 := by
  haveI : Group.IsPerfect f.range := Group.IsPerfect.range f
  haveI : IsSolvable f.range := subgroup_solvable_of_solvable f.range
  obtain ⟨n, hn⟩ := (inferInstance : IsSolvable f.range)
  have htopbot : (⊤ : Subgroup f.range) = ⊥ := by
    calc
      (⊤ : Subgroup f.range) = derivedSeries f.range n :=
        (Group.IsPerfect.derivedSeries_eq_top f.range n).symm
      _ = ⊥ := hn
  apply MonoidHom.ext
  intro x
  change f x = 1
  let y : f.range := ⟨f x, ⟨x, rfl⟩⟩
  have hyMem : y ∈ (⊥ : Subgroup f.range) := by
    rw [← htopbot]
    exact Subgroup.mem_top y
  have hy : y = 1 := Subgroup.mem_bot.mp hyMem
  exact congrArg Subtype.val hy

/-- Let `ρ : G → K` be surjective and let `N ◁ G` have solvable quotient.
Every perfect subgroup of `K` is contained in the image of `N`. -/
theorem perfect_subgroup_le_normal_image_of_solvable_quotient
    {G K : Type*} [Group G] [Group K]
    (ρ : G →* K) (hρ : Function.Surjective ρ)
    (N : Subgroup G) [hN : N.Normal]
    [IsSolvable (G ⧸ N)]
    (S : Subgroup K) [Group.IsPerfect S] :
    S ≤ N.map ρ := by
  letI hmapNormal : (N.map ρ).Normal := hN.map ρ hρ
  let qρ : G ⧸ N →* K ⧸ N.map ρ :=
    QuotientGroup.map N (N.map ρ) ρ le_comap_map
  have hqρ : Function.Surjective qρ := by
    intro y
    rcases QuotientGroup.mk'_surjective (N.map ρ) y with ⟨k, rfl⟩
    rcases hρ k with ⟨g, rfl⟩
    refine ⟨QuotientGroup.mk' N g, ?_⟩
    rfl
  letI : IsSolvable (K ⧸ N.map ρ) := solvable_of_surjective hqρ
  let restrictedQuotient : S →* K ⧸ N.map ρ :=
    (QuotientGroup.mk' (N.map ρ)).comp S.subtype
  have htrivial : restrictedQuotient = 1 :=
    perfect_hom_eq_one_of_solvable restrictedQuotient
  intro k hk
  have hEq := DFunLike.congr_fun htrivial ⟨k, hk⟩
  have hOne : (QuotientGroup.mk' (N.map ρ)) k = 1 := by
    simpa [restrictedQuotient] using hEq
  exact (QuotientGroup.eq_one_iff k).mp hOne

/-- Under the hypotheses above, the restricted homomorphism `N → K` still
contains every perfect subgroup of the original codomain. -/
theorem perfect_subgroup_le_range_restriction_of_solvable_quotient
    {G K : Type*} [Group G] [Group K]
    (ρ : G →* K) (hρ : Function.Surjective ρ)
    (N : Subgroup G) [N.Normal]
    [IsSolvable (G ⧸ N)]
    (S : Subgroup K) [Group.IsPerfect S] :
    S ≤ (ρ.comp N.subtype).range := by
  intro k hk
  have himage : k ∈ N.map ρ :=
    perfect_subgroup_le_normal_image_of_solvable_quotient ρ hρ N S hk
  rcases himage with ⟨g, hgN, rfl⟩
  exact ⟨⟨g, hgN⟩, rfl⟩

/-- The elementary commutator criterion used to make `SL₂(F)` perfect. -/
theorem sl2_isPerfect_of_element
    {F : Type*} [Field F]
    {a : F} (ha : a ≠ 0) (hasq : a ^ 2 ≠ 1) :
    Group.IsPerfect (Matrix.SpecialLinearGroup (Fin 2) F) :=
  ⟨Matrix.SL2.commutator_eq_top ha hasq⟩

/-- A surjective representation into `GL(ι,R)` retains the full embedded
special-linear subgroup after restriction to a normal subgroup with solvable
quotient, provided the special-linear group is perfect. -/
theorem specialLinear_mem_range_restriction_of_solvable_quotient
    {G ι R : Type*} [Group G] [Fintype ι] [DecidableEq ι] [Field R]
    (ρ : G →* Matrix.GeneralLinearGroup ι R)
    (hρ : Function.Surjective ρ)
    (N : Subgroup G) [N.Normal]
    [IsSolvable (G ⧸ N)]
    [Group.IsPerfect (Matrix.SpecialLinearGroup ι R)]
    (A : Matrix.SpecialLinearGroup ι R) :
    A.toGL ∈ (ρ.comp N.subtype).range := by
  let toGLHom : Matrix.SpecialLinearGroup ι R →*
      Matrix.GeneralLinearGroup ι R := Matrix.SpecialLinearGroup.toGL
  let S : Subgroup (Matrix.GeneralLinearGroup ι R) := toGLHom.range
  letI : Group.IsPerfect S := Group.IsPerfect.range toGLHom
  apply perfect_subgroup_le_range_restriction_of_solvable_quotient
    ρ hρ N S
  exact ⟨A, rfl⟩

end IUTThreeClosures