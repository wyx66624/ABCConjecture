/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.NeronNodeOrbitExcess
import Mathlib.Data.Fin.Rev

/-!
# Conservation for the extra two-torsion action on Frey node orbits

For a multiplicative Frey fibre of type `I_(2e)`, inversion first pairs the
`2e` geometric nodes into `e` orbits.  A nonidentity-component point of order
two induces a second involution on these `e` orbits.  Its orbit count is
`ceil(e / 2)`.  Passing only to invariant functions therefore lowers the
reduced rank from `e - 1` to `ceil(e / 2) - 1`.

The lowering is not lossless.  In odd residue characteristic the reduced
function module splits into invariant and anti-invariant character pieces,
of ranks `ceil(e / 2) - 1` and `floor(e / 2)`.  Their sum is exactly `e - 1`.
Equivalently, two copies of the reduced quotient rank recover `e - 1`, up to
one parity bit when `e` is even.

This file formalizes an abstract paired-node action and the scalar
conservation law.  The identification of `PairedNode e` with the nodes of an
actual `I_(2e)` polygon, the quotient type and Burnside orbit calculation,
and the realization of the two function types below as actual invariant and
anti-invariant submodules are paper mathematics.  In particular, the ranks
suggested by that calculation are defined here explicitly and their exact
arithmetic conservation is then kernel-checked.  The file does not formalize
Tate curves, proper regular models, quotient singularities, resolutions,
Neron models, isogenies, branch divisors, Szpiro, or abc.
-/

namespace IUTThreeClosures

noncomputable section

/-! ## The effective Klein-four action on paired nodes -/

/-- In the paired-node model, the half-polygon translation reverses the
inversion-orbit label and switches the member of the inversion pair. -/
def nodeHalfTurn {e : ℕ} (x : PairedNode e) : PairedNode e :=
  (Fin.rev x.1, !x.2)

/-- The half-turn is an involution. -/
theorem nodeHalfTurn_involutive (e : ℕ) :
    Function.Involutive (@nodeHalfTurn e) := by
  intro x
  cases x with
  | mk i b =>
      cases b <;> simp [nodeHalfTurn]

/-- The half-turn has no fixed geometric node. -/
theorem nodeHalfTurn_fixedPointFree {e : ℕ} (x : PairedNode e) :
    nodeHalfTurn x ≠ x := by
  intro h
  have hb := congrArg Prod.snd h
  cases x.2 <;> simp [nodeHalfTurn] at hb

/-- Inversion and the half-turn commute.  Thus their effective action is
Klein four (apart from degenerate very small permutation images), not a
larger nonabelian dihedral group. -/
theorem nodeHalfTurn_commutes_nodeInversion {e : ℕ}
    (x : PairedNode e) :
    nodeHalfTurn (nodeInversion x) =
      nodeInversion (nodeHalfTurn x) := by
  cases x with
  | mk i b => cases b <;> rfl

/-- The other reflection in the effective Klein-four action. -/
def nodeOtherReflection {e : ℕ} (x : PairedNode e) : PairedNode e :=
  nodeHalfTurn (nodeInversion x)

/-- For an even number of inversion-orbit labels, the other reflection has
no fixed geometric node. -/
theorem nodeOtherReflection_fixedPointFree_even
    (m : ℕ) (x : PairedNode (2 * m)) :
    nodeOtherReflection x ≠ x := by
  intro h
  have hi := congrArg (fun y => y.1.val) h
  simp [nodeOtherReflection, nodeHalfTurn, nodeInversion] at hi
  omega

/-- For `e = 2m+1`, the other reflection fixes the two members of the unique
middle inversion pair. -/
theorem nodeOtherReflection_fixes_odd_middle
    (m : ℕ) (b : Bool) :
    nodeOtherReflection
        ((⟨m, by omega⟩ : Fin (2 * m + 1)), b) =
      ((⟨m, by omega⟩ : Fin (2 * m + 1)), b) := by
  cases b <;>
    simp [nodeOtherReflection, nodeHalfTurn, nodeInversion, Fin.ext_iff]
  all_goals omega

/-! ## Exact ranks of the retained and discarded character pieces -/

/-- The scalar orbit count supplied by the paper Burnside calculation.  This
definition is not itself a construction of a quotient type. -/
def dihedralNodeOrbitCount (e : ℕ) : ℕ :=
  (e + 1) / 2

/-- Rank left after taking functions on the further node quotient and
removing constants. -/
def dihedralInvariantRank (e : ℕ) : ℕ :=
  dihedralNodeOrbitCount e - 1

/-- Rank of the complementary sign-character piece. -/
def dihedralMissingCharacterRank (e : ℕ) : ℕ :=
  e / 2

/-- The effective orbit count is `e/2` for even `e`. -/
theorem dihedralNodeOrbitCount_even (m : ℕ) :
    dihedralNodeOrbitCount (2 * m) = m := by
  simp [dihedralNodeOrbitCount]
  omega

/-- The effective orbit count is `(e+1)/2` for odd `e`. -/
theorem dihedralNodeOrbitCount_odd (m : ℕ) :
    dihedralNodeOrbitCount (2 * m + 1) = m + 1 := by
  simp [dihedralNodeOrbitCount]
  omega

/-- Exact character conservation: invariant rank plus missing sign rank is
the original inversion-orbit excess rank. -/
theorem dihedral_character_rank_conservation
    {e : ℕ} (he : 0 < e) :
    dihedralInvariantRank e + dihedralMissingCharacterRank e = e - 1 := by
  rcases Nat.even_or_odd' e with ⟨m, hm | hm⟩
  · subst e
    simp [dihedralInvariantRank, dihedralNodeOrbitCount,
      dihedralMissingCharacterRank]
    omega
  · subst e
    simp [dihedralInvariantRank, dihedralNodeOrbitCount,
      dihedralMissingCharacterRank]
    omega

/-- Parity form of the same conservation law.  Two copies of the reduced
quotient rank miss exactly one dimension when `e` is even. -/
theorem dihedral_rank_conservation_even (m : ℕ) (hm : 0 < m) :
    2 * dihedralInvariantRank (2 * m) + 1 = 2 * m - 1 := by
  simp [dihedralInvariantRank, dihedralNodeOrbitCount]
  omega

/-- For odd `e`, two copies of the reduced quotient rank recover the whole
original excess rank. -/
theorem dihedral_rank_conservation_odd (m : ℕ) :
    2 * dihedralInvariantRank (2 * m + 1) = 2 * m := by
  simp [dihedralInvariantRank, dihedralNodeOrbitCount]
  omega

/-! ## Node count after quotient inertia and local desingularization -/

/-- Every ordinary effective orbit has identity-component `mu_2` inertia.
Resolving its thickness-two quotient produces two ordinary nodes. -/
def resolvedAffineQuotientNodeCount (e : ℕ) : ℕ :=
  2 * (e / 2)

/-- Resolution restores `e` nodes up to the single odd-parity orbit which is
smoothed by a branch-swapping reflection. -/
theorem resolvedAffineQuotientNodeCount_add_oddParity (e : ℕ) :
    resolvedAffineQuotientNodeCount e + e % 2 = e := by
  unfold resolvedAffineQuotientNodeCount
  omega

theorem resolvedAffineQuotientNodeCount_even (m : ℕ) :
    resolvedAffineQuotientNodeCount (2 * m) = 2 * m := by
  simp [resolvedAffineQuotientNodeCount]

theorem resolvedAffineQuotientNodeCount_odd (m : ℕ) :
    resolvedAffineQuotientNodeCount (2 * m + 1) = 2 * m := by
  simp [resolvedAffineQuotientNodeCount]
  omega

/-! ## Finite residue-field modules and arithmetic-degree conservation -/

/-- An abstract finite module with the rank predicted for quotient-invariant
functions modulo constants.  No actual invariant-submodule identification
is asserted in Lean. -/
abbrev DihedralInvariantNodeModule (p e : ℕ) :=
  Fin (dihedralInvariantRank e) → ZMod p

/-- An abstract finite module with the rank predicted for the complementary
sign character.  No actual anti-invariant-submodule identification is
asserted in Lean. -/
abbrev DihedralMissingCharacterModule (p e : ℕ) :=
  Fin (dihedralMissingCharacterRank e) → ZMod p

theorem dihedralInvariantNodeModule_card (p e : ℕ) :
    Nat.card (DihedralInvariantNodeModule p e) =
      p ^ dihedralInvariantRank e := by
  unfold DihedralInvariantNodeModule
  rw [Nat.card_fun, Nat.card_zmod, Nat.card_fin]

theorem dihedralMissingCharacterModule_card (p e : ℕ) :
    Nat.card (DihedralMissingCharacterModule p e) =
      p ^ dihedralMissingCharacterRank e := by
  unfold DihedralMissingCharacterModule
  rw [Nat.card_fun, Nat.card_zmod, Nat.card_fin]

theorem dihedralInvariantNodeModule_degree
    {p e : ℕ} (_hp : p ≠ 0) :
    finiteTorsionArithmeticDegree (DihedralInvariantNodeModule p e) =
      (dihedralInvariantRank e : ℝ) * Real.log (p : ℝ) := by
  letI : NeZero p := ⟨_hp⟩
  unfold finiteTorsionArithmeticDegree
  rw [dihedralInvariantNodeModule_card]
  push_cast
  rw [Real.log_pow]

theorem dihedralMissingCharacterModule_degree
    {p e : ℕ} (_hp : p ≠ 0) :
    finiteTorsionArithmeticDegree
        (DihedralMissingCharacterModule p e) =
      (dihedralMissingCharacterRank e : ℝ) * Real.log (p : ℝ) := by
  letI : NeZero p := ⟨_hp⟩
  unfold finiteTorsionArithmeticDegree
  rw [dihedralMissingCharacterModule_card]
  push_cast
  rw [Real.log_pow]

/-- Cardinality conservation for the two character pieces. -/
theorem dihedral_character_card_conservation
    {p e : ℕ} (he : 0 < e) :
    Nat.card (DihedralInvariantNodeModule p e) *
        Nat.card (DihedralMissingCharacterModule p e) =
      Nat.card (NodeOrbitExcessModule p e) := by
  rw [dihedralInvariantNodeModule_card,
    dihedralMissingCharacterModule_card, nodeOrbitExcessModule_card,
    ← pow_add, dihedral_character_rank_conservation he]

/-- Arithmetic degrees also add exactly. -/
theorem dihedral_character_degree_conservation
    {p e : ℕ} (hp : p ≠ 0) (he : 0 < e) :
    finiteTorsionArithmeticDegree (DihedralInvariantNodeModule p e) +
        finiteTorsionArithmeticDegree
          (DihedralMissingCharacterModule p e) =
      finiteTorsionArithmeticDegree (NodeOrbitExcessModule p e) := by
  rw [dihedralInvariantNodeModule_degree hp,
    dihedralMissingCharacterModule_degree hp,
    nodeOrbitExcessModule_degree hp, ← add_mul, ← Nat.cast_add,
    dihedral_character_rank_conservation he]

/-! ## Local contact conservation across the three order-two quotients -/

/-- At a split multiplicative `I_n` fibre with full two-torsion and even
`n`, the three cyclic order-two quotients have contact multiplicities
`2n`, `n/2`, and `n/2`.  Their sum is exactly three copies of `n`.
This is the scalar core; the Tate/isogeny interpretation is paper-only. -/
theorem three_twoIsogeny_contact_conservation (n : ℕ) (hn : Even n) :
    2 * n + n / 2 + n / 2 = 3 * n := by
  obtain ⟨e, rfl⟩ := hn
  omega

/-- Frey normalization `n=2e` of the same contact conservation. -/
theorem three_twoIsogeny_frey_contact_conservation (e : ℕ) :
    4 * e + e + e = 3 * (2 * e) := by
  omega

end

end IUTThreeClosures
