/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.ArakelovCongruenceDegreeBarrier

/-!
# Node-orbit carriers for multiplicative Frey fibers

For a multiplicative fiber of Kodaira type `I_(2e)`, inversion pairs the
`2e` geometric nodes without fixed points.  The quotient node scheme has
degree `e`.  Modding its coordinate algebra out by the constant functions
therefore leaves an `(e - 1)`-dimensional residue-field vector space.  Over
`F_p` its additive cardinality is `p^(e - 1)`, so its arithmetic degree is
exactly `(e - 1) log p`.

This file formalizes the finite combinatorial and scalar core of that
construction.  It does not formalize minimal regular models, Kodaira fibers,
extension of inversion, finite-etale quotients, Neron models, modularity,
congruence ideals, Szpiro, or abc.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The free node pairing and the quotient-coordinate model -/

/-- A split model for `2e` nodes paired by inversion. -/
abbrev PairedNode (e : ℕ) := Fin e × Bool

/-- The split model has exactly `2e` nodes. -/
theorem pairedNode_card (e : ℕ) :
    Nat.card (PairedNode e) = 2 * e := by
  simp [PairedNode, Nat.mul_comm]

/-- The combinatorial action of inversion on the paired node set. -/
def nodeInversion {e : ℕ} (x : PairedNode e) : PairedNode e :=
  (x.1, !x.2)

/-- The node pairing is an involution. -/
theorem nodeInversion_involutive (e : ℕ) :
    Function.Involutive (@nodeInversion e) := by
  intro x
  cases x with
  | mk i b => cases b <;> rfl

/-- Inversion has no fixed node in the even polygon model. -/
theorem nodeInversion_fixedPointFree {e : ℕ} (x : PairedNode e) :
    nodeInversion x ≠ x := by
  intro h
  have hb := congrArg Prod.snd h
  cases x.2 <;> simp [nodeInversion] at hb

/-- After taking the free node-pair quotient, functions on the `e` orbits
are modeled by functions on `Fin e`. -/
abbrev NodeOrbitFunctions (p e : ℕ) :=
  Fin e → ZMod p

/-- Functions on `e` node orbits have additive cardinality `p^e`. -/
theorem nodeOrbitFunctions_card (p e : ℕ) :
    Nat.card (NodeOrbitFunctions p e) = p ^ e := by
  unfold NodeOrbitFunctions
  rw [Nat.card_fun, Nat.card_zmod, Nat.card_fin]

/-- Normalize a function on `m+1` node orbits by subtracting its constant
value at the distinguished zeroth orbit.  This is a concrete representative
of the quotient of the function algebra by constant functions. -/
def normalizeNodeOrbitFunction {p m : ℕ}
    (f : NodeOrbitFunctions p (m + 1)) : Fin m → ZMod p :=
  fun i => f i.succ - f 0

/-- Every reduced orbit function has a normalized lift. -/
def liftNormalizedNodeOrbitFunction {p m : ℕ}
    (g : Fin m → ZMod p) : NodeOrbitFunctions p (m + 1) :=
  Fin.cases 0 g

/-- Normalization after the explicit lift is the identity. -/
theorem normalize_liftNormalizedNodeOrbitFunction {p m : ℕ}
    (g : Fin m → ZMod p) :
    normalizeNodeOrbitFunction (liftNormalizedNodeOrbitFunction g) = g := by
  funext i
  simp [normalizeNodeOrbitFunction, liftNormalizedNodeOrbitFunction]

/-- The kernel of normalization consists exactly of constant functions. -/
theorem normalizeNodeOrbitFunction_eq_zero_iff_constant
    {p m : ℕ} (f : NodeOrbitFunctions p (m + 1)) :
    normalizeNodeOrbitFunction f = 0 ↔ ∀ i, f i = f 0 := by
  constructor
  · intro h i
    cases i using Fin.cases with
    | zero => rfl
    | succ j =>
        have hj : f j.succ - f 0 = 0 := by
          simpa only [normalizeNodeOrbitFunction, Pi.zero_apply] using
            congr_fun h j
        exact sub_eq_zero.mp hj
  · intro h
    funext i
    simp [normalizeNodeOrbitFunction, h i.succ]

/-! ## The finite `p`-weighted excess module -/

/-- The reduced coordinate module for an orbit scheme of degree `e`.
For a Frey fiber of type `I_(2e)`, this models
`Gamma(Sing/[-1], O) / F_p`. -/
abbrev NodeOrbitExcessModule (p e : ℕ) :=
  Fin (e - 1) → ZMod p

/-- Its additive cardinality is `p^(e-1)`. -/
theorem nodeOrbitExcessModule_card (p e : ℕ) :
    Nat.card (NodeOrbitExcessModule p e) = p ^ (e - 1) := by
  unfold NodeOrbitExcessModule
  rw [Nat.card_fun, Nat.card_zmod, Nat.card_fin]

/-- At every genuine residue characteristic, the carrier is a finite type. -/
theorem nodeOrbitExcessModule_finite
    {p e : ℕ} (hp : p ≠ 0) :
    Finite (NodeOrbitExcessModule p e) := by
  letI : NeZero p := ⟨hp⟩
  exact Finite.of_fintype (NodeOrbitExcessModule p e)

/-- Its arithmetic degree is exactly the removed-prime weighted exponent
excess. -/
theorem nodeOrbitExcessModule_degree
    {p e : ℕ} (_hp : p ≠ 0) :
    finiteTorsionArithmeticDegree (NodeOrbitExcessModule p e) =
      ((e - 1 : ℕ) : ℝ) * Real.log (p : ℝ) := by
  letI : NeZero p := ⟨_hp⟩
  unfold finiteTorsionArithmeticDegree
  rw [nodeOrbitExcessModule_card]
  push_cast
  rw [Real.log_pow]

/-! ## Exact Szpiro-strength boundary -/

/-- Once total exponent weight is split as radical weight plus node-orbit
excess, an upper bound on the new module with coefficient `2 + eps/2` is
equivalent, by exact scalar algebra, to the Frey discriminant slope
`6 + eps`.  This theorem proves neither inequality. -/
theorem nodeOrbitExcess_upper_iff_freyDiscriminant_slopeSix
    {total radical excess eps C : ℝ}
    (hsplit : total = radical + excess) :
    excess ≤ (2 + eps / 2) * radical + C ↔
      2 * total ≤ (6 + eps) * radical + 2 * C := by
  rw [hsplit]
  constructor <;> intro h <;> linarith

/-- Finite-profile specialization of the same exact equivalence. -/
theorem nodeOrbitProfile_upper_iff_freyDiscriminant_slopeSix
    {ι : Type*} (s : Finset ι) (weight : ι → ℝ)
    (exponent : ι → ℕ)
    (hexponent : ∀ i ∈ s, 0 < exponent i) (eps C : ℝ) :
    exponentExcessDegree s weight exponent ≤
        (2 + eps / 2) * exponentRadicalWeight s weight + C ↔
      2 * exponentTotalWeight s weight exponent ≤
        (6 + eps) * exponentRadicalWeight s weight + 2 * C := by
  apply nodeOrbitExcess_upper_iff_freyDiscriminant_slopeSix
  exact exponentTotalWeight_eq_radical_add_excess
    s weight exponent hexponent

/-! ## Strict local obstruction to a reduced-support-only upper bound -/

/-- At the fixed support prime three, the node-orbit carrier is unbounded as
the multiplicative exponent grows. -/
theorem nodeOrbitExcessModule_unbounded_at_three (B : ℕ) :
    ∃ e : ℕ,
      B < Nat.card (NodeOrbitExcessModule 3 e) := by
  refine ⟨B + 1, ?_⟩
  rw [nodeOrbitExcessModule_card]
  simp only [Nat.add_sub_cancel]
  exact lt_of_lt_of_le B.lt_two_pow_self
    (Nat.pow_le_pow_left (by omega : 2 ≤ 3) B)

/-- Fully quantified form: no function of the reduced support prime alone
bounds these local carriers. -/
theorem no_local_reducedSupport_nodeOrbitCarrier_bound (F : ℕ → ℕ) :
    ∃ e : ℕ,
      F 3 < Nat.card (NodeOrbitExcessModule 3 e) :=
  nodeOrbitExcessModule_unbounded_at_three (F 3)

end

end IUTThreeClosures
