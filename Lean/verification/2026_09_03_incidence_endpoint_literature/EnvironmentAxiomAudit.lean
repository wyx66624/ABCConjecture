import IUTThreeClosures.ABCValuationIncidenceComplex20260903
import IUTThreeClosures.ABCValuationIncidenceFixedBudgetObstruction20260903
import IUTThreeClosures.ABCValuationIncidenceScaleBudgetObstruction20260903
import IUTThreeClosures.ABCSignedEndpointPrimeTokenTransport20260903
import IUTThreeClosures.ABCThreeArmIncidenceSuccessor20260903
import IUTThreeClosures.ABCThreeArmComplementTransportObstruction20260903
import IUTThreeClosures.ABCBidirectionalPrimeTransportSuccessor20260903
import IUTThreeClosures.ABCBidirectionalEnergyPythagoreanObstruction20260903
import IUTThreeClosures.ABCPrimePacketBoundaryTransportSuccessor20260903
import IUTThreeClosures.ABCPrimePacketBoundaryLinnikObstruction20260903
import IUTThreeClosures.ABCSharedCRTIncidenceSuccessor20260903
import Lean.Util.CollectAxioms
import Mathlib.Tactic.Linter.PrivateModule

/-!
# Compiled-environment axiom audit

This is independent of the source-command inventory and the handwritten
`#print axioms` lists. It visits every public, non-reserved declaration emitted
by the checkpoint modules, including generated declarations. The command
fails on any transitive logical dependency outside the three standard
foundational axioms, or on any unsafe or partial declaration.
-/

open Lean Elab Command

private def auditedRoots : List Name := [
  `IUTThreeClosures.ABCValuationIncidenceComplex20260903,
  `IUTThreeClosures.ABCValuationIncidenceFixedBudgetObstruction20260903,
  `IUTThreeClosures.ABCValuationIncidenceScaleBudgetObstruction20260903,
  `IUTThreeClosures.ABCSignedEndpointPrimeTokenTransport20260903,
  `IUTThreeClosures.ABCThreeArmIncidenceSuccessor20260903,
  `IUTThreeClosures.ABCThreeArmComplementTransportObstruction20260903,
  `IUTThreeClosures.ABCBidirectionalPrimeTransportSuccessor20260903,
  `IUTThreeClosures.ABCBidirectionalEnergyPythagoreanObstruction20260903,
  `IUTThreeClosures.ABCPrimePacketBoundaryTransportSuccessor20260903,
  `IUTThreeClosures.ABCPrimePacketBoundaryLinnikObstruction20260903,
  `IUTThreeClosures.ABCSharedCRTIncidenceSuccessor20260903
]

private def allowedAxioms : List Name :=
  [``propext, ``Quot.sound, ``Classical.choice]

private def isAuditedPublicName (env : Environment) (declName : Name) : Bool :=
  !isPrivateName declName && !isReservedName env declName

private def visitedDeclarations : CoreM (Array (Name × Name)) := do
  let env ← getEnv
  env.constants.foldM (init := #[]) fun names declName _ => do
    let some moduleName ← findModuleOf? declName | return names
    if auditedRoots.contains moduleName && isAuditedPublicName env declName then
      return names.push (moduleName, declName)
    return names

private def sortDeclarations (names : Array (Name × Name)) : Array (Name × Name) :=
  names.qsort fun left right => left.2.toString < right.2.toString

run_cmd do
  liftCoreM do
    let env ← getEnv
    let declarations := sortDeclarations (← visitedDeclarations)
    if declarations.isEmpty then
      throwError "compiled-environment audit selected no declarations"
    let mut logicalViolations : Array (Name × Array Name) := #[]
    let mut unsafeDeclarations : Array Name := #[]
    let mut partialDeclarations : Array Name := #[]
    for (moduleName, declName) in declarations do
      let some info := env.find? declName |
        throwError "compiled declaration disappeared: {declName}"
      if info.isUnsafe then
        unsafeDeclarations := unsafeDeclarations.push declName
      if info.isPartial then
        partialDeclarations := partialDeclarations.push declName
      let dependencies := (← collectAxioms declName).qsort fun left right =>
        left.toString < right.toString
      IO.println s!"AXIOM_AUDIT|DECL|{moduleName}|{declName}|{String.intercalate ","
        (dependencies.toList.map Name.toString)}"
      let forbidden := dependencies.filter fun name => !allowedAxioms.contains name
      unless forbidden.isEmpty do
        logicalViolations := logicalViolations.push (declName, forbidden)
    unless logicalViolations.isEmpty do
      let messages := logicalViolations.toList.map fun (declName, dependencies) =>
        s!"{declName}: {String.intercalate ", "
          (dependencies.toList.map Name.toString)}"
      throwError "disallowed transitive axioms:\n{String.intercalate "\n" messages}"
    unless unsafeDeclarations.isEmpty do
      throwError "unsafe declarations: {unsafeDeclarations}"
    unless partialDeclarations.isEmpty do
      throwError "partial declarations: {partialDeclarations}"
    for moduleName in auditedRoots do
      let count := declarations.foldl (init := 0) fun count entry =>
        if entry.1 == moduleName then count + 1 else count
      if count == 0 then
        throwError "compiled-environment audit selected no declarations from {moduleName}"
      IO.println s!"AXIOM_AUDIT|MODULE|{moduleName}|{count}"
    IO.println s!"AXIOM_AUDIT|SUMMARY|{declarations.size}|unsafe=0|partial=0"
