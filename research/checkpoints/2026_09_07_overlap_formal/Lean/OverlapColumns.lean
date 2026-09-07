import ExponentProfiles

/-!
Finite shared-column reconstruction in the actual integer-pair algebra.
The ordinary proof is recorded in the adjacent README before formalization.
No coprimality or disjoint-support premise is used. Analytic estimates and
the unrestricted ABC conjecture are outside this module's scope.
-/
set_option autoImplicit false

namespace ABCOverlapColumns20260907
open ABCEisenstein20260905 ABCExponentProfiles20260906

def columnProduct (xs : List (Pair × Nat × Nat)) (first : Bool) : Pair :=
  eprod (xs.map fun s ↦ epow s.1 (if first then s.2.1 else s.2.2))

def sharedProduct (xs : List (Pair × Nat × Nat)) (k : Nat) : Pair :=
  eprod (xs.map fun s ↦ epow s.1 (s.2.1 * k + s.2.2))

theorem shared_columns_reconstruct (xs : List (Pair × Nat × Nat)) (k : Nat) :
    sharedProduct xs k = mul (epow (columnProduct xs true) k) (columnProduct xs false) := by
  induction xs with
  | nil =>
    simp only [sharedProduct, columnProduct, List.map_nil, eprod]
    have h : epow (1, 0) k = (1, 0) := by
      induction k with
      | zero => rfl
      | succ k ih => simp [epow, ih, mul_one]
    rw [h, mul_one]
  | cons s xs ih =>
    change mul (epow s.1 (s.2.1 * k + s.2.2)) (sharedProduct xs k) =
      mul (epow (mul (epow s.1 s.2.1) (columnProduct xs true)) k)
        (mul (epow s.1 s.2.2) (columnProduct xs false))
    rw [epow_add, epow_mul, ih, epow_product]
    exact mul_interchange (epow (epow s.1 s.2.1) k) (epow s.1 s.2.2)
      (epow (columnProduct xs true) k) (columnProduct xs false)

theorem shared_columns_norm (xs : List (Pair × Nat × Nat)) (k : Nat) :
    norm (sharedProduct xs k) = norm (columnProduct xs true) ^ k *
      norm (columnProduct xs false) := by
  rw [shared_columns_reconstruct, norm_mul, norm_epow]

theorem euclidean_exponent_split (e k : Nat) :
    e = (e / k) * k + e % k := by
  simpa only [Nat.mul_comm, Nat.add_comm] using (Nat.mod_add_div e k).symm

#print axioms shared_columns_reconstruct
#print axioms shared_columns_norm
#print axioms euclidean_exponent_split
end ABCOverlapColumns20260907
