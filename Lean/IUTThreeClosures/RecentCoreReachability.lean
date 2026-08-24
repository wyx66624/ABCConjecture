/-
Copyright (c) 2026 ChatGPT. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
Authors: ChatGPT
-/

/-!
# Reachability audit for recently merged core modules

The default Lake target builds `IUTThreeClosures.lean`. A standalone file that
is not reachable from that root may therefore escape kernel compilation even
when its pull request reports a green build. This module imports the recently
merged mathematical cores that were added as standalone files, so the umbrella
target genuinely checks them and all of their dependencies.

This is a CI/reachability module only; it introduces no mathematical axioms or
new theorem hypotheses.
-/

import IUTThreeClosures.GenEllLemma41CountingBridge
import IUTThreeClosures.ExceptionalPrimeMassProduct
import IUTThreeClosures.EuclidAuxiliaryPrimeSelector
import IUTThreeClosures.EuclidAuxiliaryPrimeAvoidance
import IUTThreeClosures.EuclidAuxiliaryPrimeAvoidOne
import IUTThreeClosures.UniformAvoidanceLargeImage
import IUTThreeClosures.TransvectionLargeImageCriterion
import IUTThreeClosures.GenEllBoundedLargeImagePrime

import IUTThreeClosures.Ind2PermutationVolumeQuotient
import IUTThreeClosures.Ind2UnionVolumeCounterexample

import IUTThreeClosures.PuncturedTorsionCover
import IUTThreeClosures.TemperedCycleSkeleton
import IUTThreeClosures.TemperedCycleSkeletonBridge
import IUTThreeClosures.TateCycleCuspGraphModel
import IUTThreeClosures.TateThetaRootZOrbitProperness
import IUTThreeClosures.TateThetaRootCycleQuotient
import IUTThreeClosures.TateThetaRootCompactProperness
import IUTThreeClosures.AddCircleEllCovering
