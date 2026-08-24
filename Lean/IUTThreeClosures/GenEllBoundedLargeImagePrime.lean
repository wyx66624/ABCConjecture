/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import IUTThreeClosures.MathlibChebyshevPNTInstantiation
import IUTThreeClosures.TransvectionLargeImageCriterion

/-!
# From a bounded escaping prime to full `SL₂` image

The prescribed-size-prime theorem and the finite-group large-image theorem are
logically independent.  This module joins them without storing full image as
an input field.

For every prime in the selected interval outside a finite exceptional set, the
source-facing arithmetic hypotheses provide only:

* one nonzero upper transvection in the image;
* one determinant-one image element moving the transvection's fixed line.

The explicit transvection-and-mover theorem then proves that the image contains
every determinant-one matrix.  The Chebyshev/GenEll theorem supplies a prime
with these properties and an explicit upper endpoint.

Thus the remaining Frey/Galois work is exactly to construct the two displayed
image elements uniformly outside the exceptional set, rather than to assume a
large-image conclusion.
-/

namespace IUTThreeClosures

open Finset Nat Real
open scoped Nat.Prime
open TransvectionLargeImage
open TransvectionLargeImage.Matrix2

/-- Source-facing local and irreducibility ingredients for every prime in one
prescribed interval outside a finite exceptional set. -/
structure IntervalTransvectionMoverData
    (A : Finset ℕ) (H X : ℕ) where
  /-- The actual multiplicatively closed mod-prime image carrier. -/
  image : ∀ p : ℕ,
    MultiplicativeCarrier (Matrix2 (ZMod p))
  /-- Multiplicative inertia supplies a nonzero transvection. -/
  transvection :
    ∀ p : ℕ, p.Prime → H < p → p ≤ X → p ∉ A →
      ∃ u : ZMod p,
        u ≠ 0 ∧ upper u ∈ (image p).carrier
  /-- Irreducibility supplies an element moving the transvection's fixed
  line.  The determinant-one normalization is part of the explicit source
  obligation. -/
  mover :
    ∀ p : ℕ, p.Prime → H < p → p ≤ X → p ∉ A →
      ∃ g : Matrix2 (ZMod p),
        g ∈ (image p).carrier ∧ det g = 1 ∧ g.c ≠ 0

namespace IntervalTransvectionMoverData

/-- One escaping prime with the transvection/mover ingredients has full
`SL₂` image. -/
theorem full_SL2_at_escaping_prime
    {A : Finset ℕ} {H X p : ℕ}
    (D : IntervalTransvectionMoverData A H X)
    (hp : p.Prime) (hHp : H < p) (hpX : p ≤ X) (hpA : p ∉ A) :
    ∀ M : Matrix2 (ZMod p),
      det M = 1 → M ∈ (D.image p).carrier := by
  letI : Fact p.Prime := ⟨hp⟩
  rcases D.transvection p hp hHp hpX hpA with
    ⟨u, hu, hU⟩
  rcases D.mover p hp hHp hpX hpA with
    ⟨g, hg, hdet, hgc⟩
  exact all_det_one_mem_of_transvection_and_mover
    p (D.image p) hu hU g hg hdet hgc

/-- A nonempty escaping-prime set gives a bounded prime with full `SL₂`
image. -/
theorem exists_bounded_full_SL2_prime_of_card_pos
    {A : Finset ℕ} {H X : ℕ}
    (D : IntervalTransvectionMoverData A H X)
    (hcard : 1 ≤ (escapingPrimes A H X).card) :
    ∃ p : ℕ,
      p.Prime ∧ H < p ∧ p ≤ X ∧ p ∉ A ∧
      (∀ M : Matrix2 (ZMod p),
        det M = 1 → M ∈ (D.image p).carrier) := by
  have hnonempty : (escapingPrimes A H X).Nonempty :=
    Finset.card_pos.mp (lt_of_lt_of_le Nat.zero_lt_one hcard)
  rcases hnonempty with ⟨p, hpEsc⟩
  have hpData := (mem_escapingPrimes_iff A H X p).mp hpEsc
  refine ⟨p, hpData.1, hpData.2.1,
    hpData.2.2.1, hpData.2.2.2, ?_⟩
  exact D.full_SL2_at_escaping_prime
    hpData.1 hpData.2.1 hpData.2.2.1 hpData.2.2.2

end IntervalTransvectionMoverData

/-- **GenEll bounded large-image prime theorem.**  With the ceiling endpoints
from the printed radius and Mathlib's PNT, the scalar hypotheses produce an
explicitly bounded prime outside `A`; the transvection/mover source data then
force full `SL₂` image at that prime. -/
theorem genEll_exists_bounded_full_SL2_prime
    (A : Finset ℕ)
    (hA : ∀ p ∈ A, p.Prime)
    (hBase : ℝ)
    {ε xε xA : ℝ}
    (hεpos : 0 < ε)
    (hεlt : ε < 1 / 4)
    (hxεpos : 0 < xε)
    (hendpointBudget : (5 / 4 : ℝ) < ε * xε)
    (hxA : xε < xA)
    (hhBase : 0 ≤ hBase)
    (hxA_mass : xA = primeLogMass A)
    (hradius_nonneg :
      0 ≤ genEllLemma41Radius ε xA hBase)
    (hradius_one :
      1 ≤ genEllLemma41Radius ε xA hBase)
    (hlarge :
      let N := Classical.choose
        (exists_mathlib_chebyshev_window_threshold hεpos)
      N ≤ naturalCeilingEndpoint ((1 + 6 * ε) * hBase) ∧
      N ≤ naturalCeilingEndpoint
        (genEllLemma41Radius ε xA hBase))
    (hlog :
      Real.log
          (naturalCeilingEndpoint
            (genEllLemma41Radius ε xA hBase)) ≤
        ε * genEllLemma41Radius ε xA hBase)
    (D : IntervalTransvectionMoverData A
      (naturalCeilingEndpoint ((1 + 6 * ε) * hBase))
      (naturalCeilingEndpoint
        (genEllLemma41Radius ε xA hBase))) :
    ∃ p : ℕ,
      p.Prime ∧
      naturalCeilingEndpoint ((1 + 6 * ε) * hBase) < p ∧
      p ≤ naturalCeilingEndpoint
        (genEllLemma41Radius ε xA hBase) ∧
      p ∉ A ∧
      (∀ M : Matrix2 (ZMod p),
        det M = 1 → M ∈ (D.image p).carrier) := by
  have hcard :
      1 ≤
        (escapingPrimes A
          (naturalCeilingEndpoint ((1 + 6 * ε) * hBase))
          (naturalCeilingEndpoint
            (genEllLemma41Radius ε xA hBase))).card := by
    apply genEllLemma41_ceiling_endpoints
      A hA hBase 1
      mathlib_chebyshev_theta_ratio_tendsto_one
      hεpos hεlt hxεpos hendpointBudget hxA hhBase
        hxA_mass hradius_nonneg hradius_one hlarge
    simpa using hlog
  exact D.exists_bounded_full_SL2_prime_of_card_pos hcard

end IUTThreeClosures
