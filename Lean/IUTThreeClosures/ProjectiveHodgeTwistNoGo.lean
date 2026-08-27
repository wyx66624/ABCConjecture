/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/
import Mathlib

/-!
# Projective invariance under a common line-bundle shift

A common metrized line factor adds the same logarithmic quantity to every
coordinate of a packet.  Projective normalization subtracts the coordinate
average, so this common term disappears exactly.

This module formalizes the finite-dimensional scalar core of that observation.
It prevents the degree of a common Hodge twist from being used as an upper
bound for the centered/projective packet without an additional relative metric
theorem.
-/

namespace IUTThreeClosures

open Finset
open scoped BigOperators

variable {ι : Type*} [Fintype ι]

/-- Average of a finite real packet. -/
noncomputable def packetAverage (x : ι → ℝ) : ℝ :=
  (∑ i, x i) / (Fintype.card ι : ℝ)

/-- Coordinate after removing the common scalar component. -/
noncomputable def centeredPacketCoordinate
    (x : ι → ℝ) (i : ι) : ℝ :=
  x i - packetAverage x

/-- Adding one common logarithmic term shifts the packet average by that term. -/
theorem packetAverage_add_const
    [Nonempty ι]
    (x : ι → ℝ) (c : ℝ) :
    packetAverage (fun i => x i + c) = packetAverage x + c := by
  have hcard : (Fintype.card ι : ℝ) ≠ 0 := by
    exact_mod_cast Fintype.card_ne_zero
  unfold packetAverage
  rw [Finset.sum_add_distrib]
  simp only [Finset.sum_const, Finset.card_univ, nsmul_eq_mul]
  field_simp [hcard]

/-- Every centered coordinate is invariant under a common scalar shift. -/
theorem centeredPacketCoordinate_add_const
    [Nonempty ι]
    (x : ι → ℝ) (c : ℝ) (i : ι) :
    centeredPacketCoordinate (fun j => x j + c) i =
      centeredPacketCoordinate x i := by
  unfold centeredPacketCoordinate
  rw [packetAverage_add_const]
  ring

/-- Coordinate differences are invariant under a common scalar shift. -/
theorem packetDifference_add_const
    (x : ι → ℝ) (c : ℝ) (i j : ι) :
    (x i + c) - (x j + c) = x i - x j := by
  ring

/-- The two-valued Tate packet has average zero when the canonical coefficient
plus `ell` noncanonical coefficients vanishes. -/
theorem tateTwoValuedPacket_average_zero
    {ell : ℕ}
    (hell : 0 < ell)
    (A B L : ℝ)
    (hbalance : A + (ell : ℝ) * B = 0) :
    ((A * L) + (ell : ℝ) * (B * L)) / ((ell : ℝ) + 1) = 0 := by
  have hden : (ell : ℝ) + 1 ≠ 0 := by positivity
  have hnum : A * L + (ell : ℝ) * (B * L) = 0 := by
    calc
      A * L + (ell : ℝ) * (B * L) =
          (A + (ell : ℝ) * B) * L := by ring
      _ = 0 := by rw [hbalance, zero_mul]
  rw [hnum, zero_div]

/-- A common Hodge-line term disappears from the centered canonical
coordinate of a balanced Tate packet. -/
theorem centeredCanonicalTateCoordinate
    {ell : ℕ}
    (hell : 0 < ell)
    (A B L h : ℝ)
    (hbalance : A + (ell : ℝ) * B = 0) :
    (h + A * L) -
        (((h + A * L) +
          (ell : ℝ) * (h + B * L)) / ((ell : ℝ) + 1)) =
      A * L := by
  have hden : (ell : ℝ) + 1 ≠ 0 := by positivity
  have hbalanceL : A * L + (ell : ℝ) * (B * L) = 0 := by
    calc
      A * L + (ell : ℝ) * (B * L) =
          (A + (ell : ℝ) * B) * L := by ring
      _ = 0 := by rw [hbalance, zero_mul]
  field_simp [hden]
  nlinarith

end IUTThreeClosures
