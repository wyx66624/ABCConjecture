import Std

/-!
Author: ChatGPT, September 7, 2026.
Exact counting of actual residue-class hits in [0,N), and an actual recursive
Eisenstein family whose boundary has exactly one factor of five at every index.
No abstract counting-error hypothesis, ABC statement or custom axiom is used.
-/

set_option autoImplicit false
set_option maxRecDepth 10000

namespace ABCShiftedResidueCounts20260907

/-- The exact number of nonnegative progression indices before N. -/
def residueCount (d a N : Nat) : Nat :=
  if N ≤ a then 0 else (N - 1 - a) / d + 1

/-- Euclidean division proves the actual progression-index bound. -/
theorem progression_index_iff (d a N j : Nat) (hd : 0 < d) :
    a + d * j < N ↔ j < residueCount d a N := by
  by_cases hNa : N ≤ a
  · simp only [residueCount, if_pos hNa]
    omega
  · simp only [residueCount, if_neg hNa]
    let q := (N - 1 - a) / d
    let r := (N - 1 - a) % d
    have hr : r < d := Nat.mod_lt _ hd
    have hrepr : N = a + d * q + r + 1 := by
      have hdiv := Nat.mod_add_div (N - 1 - a) d
      change r + d * q = N - 1 - a at hdiv
      omega
    change a + d * j < N ↔ j < q + 1
    constructor
    · intro hj
      by_cases hjq : j < q + 1
      · exact hjq
      have hqj : q + 1 ≤ j := by omega
      have hm := Nat.mul_le_mul_left d hqj
      rw [Nat.mul_add, Nat.mul_one] at hm
      omega
    · intro hj
      have hjq : j ≤ q := by omega
      have hm := Nat.mul_le_mul_left d hjq
      omega

/-- Every actual residue hit has one bounded progression index, and conversely. -/
theorem residue_hit_iff (d a N n : Nat) (hd : 0 < d) (ha : a < d) :
    (n < N ∧ n % d = a) ↔
      ∃ j : Nat, j < residueCount d a N ∧ n = a + d * j := by
  constructor
  · intro hn
    have hrepr : n = a + d * (n / d) := by
      have hh := Nat.mod_add_div n d
      omega
    refine ⟨n / d, ?_, hrepr⟩
    exact (progression_index_iff d a N (n / d) hd).mp (by omega)
  · intro ⟨j, hj, hrepr⟩
    constructor
    · have hh := (progression_index_iff d a N j hd).mpr hj
      omega
    · rw [hrepr]
      simp [Nat.add_mod, Nat.mod_eq_of_lt ha]

/-- The parameterization of residue hits is injective. -/
theorem progression_index_unique (d a j k : Nat) (hd : 0 < d)
    (h : a + d * j = a + d * k) : j = k := by
  have hm : d * j = d * k := by omega
  exact Nat.eq_of_mul_eq_mul_left hd hm

/-- An exact cross-multiplied discrepancy smaller than one period. -/
theorem residue_count_discrepancy (d a N : Nat) (hd : 0 < d) (ha : a < d) :
    d * residueCount d a N ≤ N + d - 1 ∧
      N ≤ d * residueCount d a N + d - 1 := by
  by_cases hNa : N ≤ a
  · simp only [residueCount, if_pos hNa, Nat.mul_zero]
    omega
  · simp only [residueCount, if_neg hNa]
    let q := (N - 1 - a) / d
    let r := (N - 1 - a) % d
    have hr : r < d := Nat.mod_lt _ hd
    have hrepr : N = a + d * q + r + 1 := by
      have hdiv := Nat.mod_add_div (N - 1 - a) d
      change r + d * q = N - 1 - a at hdiv
      omega
    change d * (q + 1) ≤ N + d - 1 ∧ N ≤ d * (q + 1) + d - 1
    rw [Nat.mul_add, Nat.mul_one]
    omega

/-- Integer-pair multiplication in the actual Eisenstein ring. -/
def emul (z w : Int × Int) : Int × Int :=
  (z.1 * w.1 - z.2 * w.2, z.1 * w.2 + z.2 * w.1 + z.2 * w.2)

/-- The actual family (1+5*zeta)*(1+50*zeta)^n. -/
def stoppingOrbit : Nat → Int × Int
  | 0 => (1, 5)
  | n + 1 => emul (stoppingOrbit n) (1, 50)

/-- The actual cubic boundary polynomial. -/
def boundary (z : Int × Int) : Int := z.1 * z.2 * (z.1 + z.2)

/-- Multiplication preserves both coordinate residues at every index. -/
theorem stopping_orbit_coordinates (n : Nat) :
    (stoppingOrbit n).1 % 25 = 1 ∧ (stoppingOrbit n).2 % 25 = 5 := by
  induction n with
  | zero => decide
  | succ n ih =>
    simp only [stoppingOrbit, emul]
    constructor
    · simp [Int.sub_emod, Int.mul_emod, ih.1, ih.2]
    · simp [Int.add_emod, Int.mul_emod, ih.1, ih.2]

/-- Every actual boundary has the same nonzero residue modulo 25. -/
theorem stopping_boundary_mod25 (n : Nat) : boundary (stoppingOrbit n) % 25 = 5 := by
  have h := stopping_orbit_coordinates n
  simp [boundary, Int.mul_emod, Int.add_emod, h.1, h.2]

/-- The actual tower stops at precisely depth one, for all n. -/
theorem stopping_boundary_exact_depth (n : Nat) :
    5 ∣ boundary (stoppingOrbit n) ∧ ¬ 25 ∣ boundary (stoppingOrbit n) := by
  have hm := stopping_boundary_mod25 n
  constructor
  · apply Int.dvd_of_emod_eq_zero
    omega
  · intro h
    have hz := Int.emod_eq_zero_of_dvd h
    omega

/-- The step orbit has strictly greater first depth than the stopping family. -/
theorem step_exact_depth_two :
    25 ∣ boundary (1, 50) ∧ ¬ 125 ∣ boundary (1, 50) := by
  decide

#print axioms progression_index_iff
#print axioms residue_hit_iff
#print axioms progression_index_unique
#print axioms residue_count_discrepancy
#print axioms stopping_orbit_coordinates
#print axioms stopping_boundary_mod25
#print axioms stopping_boundary_exact_depth
#print axioms step_exact_depth_two

end ABCShiftedResidueCounts20260907
