# Lean diagnostic

The previous run failed while reducing a dependent `Function.update` in the off-diagonal component of `PrimePowerGeneratedThetaHull.lean`.

The proof has now been changed to unfold the local definition first and then rewrite with `Function.update_noteq`:

```lean
have hzd : z d = 0 := by
  dsimp [z]
  rw [Function.update_noteq hdc]
```

This commit triggers a fresh pinned Lean 4.32 kernel build of the corrected branch.
