import Mathlib

/-!
# Marginalization of product packet weights

For a finite label type `L`, a finite place fiber `V`, and normalized place
weights `w`, the product weight on components `c : L → V` has marginal `w`
at every distinguished label. This is the finite product-measure identity
needed to reduce a packet q-pilot calculation to the weighted local place sum.

The marginal theorem accepts an explicit `Fintype (L → V)` instance. This is
important for public packet components, whose finite enumeration is produced
by `Fintype.ofFinite` rather than definitionally by `Pi.instFintype`; the sum
is independent of that implementation choice.
-/

namespace IUTThreeClosures

open scoped BigOperators

universe u v

variable {L : Type u} {V : Type v}

def splitAtEquiv [DecidableEq L] (j₀ : L) :
    (L → V) ≃ V × ({j : L // j ≠ j₀} → V) where
  toFun c := (c j₀, fun j => c j.1)
  invFun x j := if h : j = j₀ then x.1 else x.2 ⟨j, h⟩
  left_inv c := by
    funext j
    by_cases h : j = j₀
    · subst j
      simp
    · simp [h]
  right_inv x := by
    apply Prod.ext
    · simp
    · funext j
      simp [j.property]

theorem sum_product_weights_eq_one
    [Fintype L] [DecidableEq L] [Fintype V] [DecidableEq V]
    (w : V → ℝ) (hw : ∑ v, w v = 1) :
    (∑ c : L → V, ∏ j, w (c j)) = 1 := by
  have h := Finset.sum_prod_piFinset
    (ι := L) (s := (Finset.univ : Finset V))
    (g := fun _ v => w v)
  simpa [hw] using h

theorem product_weight_marginal
    [Fintype L] [DecidableEq L] [Fintype V] [DecidableEq V]
    [Fintype (L → V)]
    (j₀ : L) (w f : V → ℝ) (hw : ∑ v, w v = 1) :
    (∑ c : L → V, (∏ j, w (c j)) * f (c j₀)) =
      ∑ v, w v * f v := by
  let E := splitAtEquiv (V := V) j₀
  have hrest :
      (∑ g : ({j : L // j ≠ j₀} → V), ∏ j, w (g j)) = 1 :=
    sum_product_weights_eq_one
      (L := {j : L // j ≠ j₀}) (V := V) w hw
  have hterm
      (x : V × ({j : L // j ≠ j₀} → V)) :
      (∏ j, w ((E.symm x) j)) * f ((E.symm x) j₀) =
        (w x.1 * f x.1) * ∏ j, w (x.2 j) := by
    have hhead : (E.symm x) j₀ = x.1 := by
      simp [E, splitAtEquiv]
    have htail (j : {j : L // j ≠ j₀}) :
        (E.symm x) j.1 = x.2 j := by
      simp [E, splitAtEquiv, j.property]
    have hprod :
        (∏ j : {j : L // j ≠ j₀}, w ((E.symm x) j.1)) =
          ∏ j, w (x.2 j) := by
      apply Fintype.prod_congr
      intro j
      rw [htail j]
    rw [Fintype.prod_eq_mul_prod_subtype_ne
      (fun j => w ((E.symm x) j)) j₀, hhead, hprod]
    ring
  calc
    (∑ c : L → V, (∏ j, w (c j)) * f (c j₀))
        =
      ∑ x : V × ({j : L // j ≠ j₀} → V),
        (∏ j, w ((E.symm x) j)) * f ((E.symm x) j₀) := by
          exact (Equiv.sum_comp E.symm
            (fun c : L → V => (∏ j, w (c j)) * f (c j₀))).symm
    _ =
      ∑ x : V × ({j : L // j ≠ j₀} → V),
        (w x.1 * f x.1) * ∏ j, w (x.2 j) := by
          apply Finset.sum_congr rfl
          intro x hx
          exact hterm x
    _ =
      ∑ v : V, ∑ g : ({j : L // j ≠ j₀} → V),
        (w v * f v) * ∏ j, w (g j) := by
          rw [Fintype.sum_prod_type]
    _ =
      ∑ v : V, (w v * f v) *
        (∑ g : ({j : L // j ≠ j₀} → V), ∏ j, w (g j)) := by
          apply Finset.sum_congr rfl
          intro v hv
          rw [Finset.mul_sum]
    _ = ∑ v, w v * f v := by
          simp [hrest]

end IUTThreeClosures