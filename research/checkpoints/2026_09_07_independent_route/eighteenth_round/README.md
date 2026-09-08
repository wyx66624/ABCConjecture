# Exact height transport and the complete local target value

This directory contains new eighteenth-round ordinary mathematics and
explicit finite/source evidence. It modifies no sealed sixteenth source,
public Lean module, master manuscript, PDF or Git reference.

## Completed ordinary results

`height_transport.md` gives HT1--HT4. Both peers completed full ordinary,
primary-source and pinned PARI implementation audits, and both actually
ran the exact wrapper in check mode. All passed. The only subsequent
mathematical-domain clarification explicitly restricts the isolated sigma
formula to an infinite-order rational point and a positive multiplier.
The scalar and differential transport are ordinary proofs; the raw output
statement is specific to the inspected PARI 2.15.4 source bytes.

The practical corrected pipeline uses the canonical scalar on the
minimal curve, divides the logarithm by two on the standard quotient, and
multiplies the height/logarithm-square ratio by four. The naive raw
nonminimal PARI combination differs at valuation one in both examples,
proved by exact rational arithmetic and an all-tail sigma estimate modulo
25, independently of the numerical height routine.

`local_height_value_set.md` gives LH1--LH3. Both peers completed full
ordinary and primary-source audits with PASS, binding the unchanged
mathematical source SHA256
`05572c7e4740badfe093aad999f719fcbca892bda8a47252feb6173df6cad22a`.
Its initial status line predates these completed reviews. The full local
curve at three gives J3=(4/3)log5(3), the full local curve at two gives
J2=0, and every other prime away from five gives zero. The exact target is
therefore Omega={-(4/3)log5(3)}. The proof covers z=0 and both infinity
points wherever they exist, and cancels the two common model constants.
This is a universal valuation proof, not an observed finite pattern.

## Publication sources and evidence

* `paper/height_normalization.tex`: complete HT proof, pinned source
  analysis, exact recovery formula and the modulo-25 all-tail proof.
* `paper/local_height_value_set.tex`: complete LH proof including local
  normalization, all valuation ranges and every projective exception.
* `paper/bibliography_additions.tex`: three new primary references.
  The existing Cremona and BD bibliography keys are reused.
* `verification/height_transport.json`: canonical exact/source replay,
  SHA256 `70ec75594f205336757496605750b1302e5f3b271afd6acf5b12275a36c9de05`.
* `source_provenance.json`: provenance for the official pinned archive,
  its two inspected C files and four relevant function-documentation
  files. The local audit copies in `source/` are not publication inputs.
  They can be recovered from the fixed versioned archive. Archive SHA256
  `c3545bfee0c6dfb40b77fb4bbabaf999d82e60069b9f6d28bcb6cf004c8c5c0f`.
  No library installation was altered.

The complete TeX transfer review status and source hashes are kept in
`review_status.json`. `verification_inventory.json` binds the fixed
publication files and deliberately excludes all `next_*` work, local
third-party `source/` copies and Python caches. There is no new Lean or
PDF-render claim in this directory.

Reproduction with the existing WSL PARI/GP 2.15.4 installation:

    python replay_height_transport.py --check

The wrapper first performs exact independent binary elliptic arithmetic
and the rigorous modulo-25 proof, then checks the source-predicted
identities using explicit p-adic balls at precisions 12 and 24. The latter
retains the trusted PARI algorithm boundary; two-precision agreement is
not used in place of the ordinary all-tail proof.

## Remaining computation and global scope

The exact target value is known, but its five-adic analytic zero set has
not been calculated. The next work needs compatible local analytic
expressions, certified truncation bounds on all required residue disks,
complete zero and multiplicity certification, and a rational sieve.
The zero fiber is over Q(i), not Q; translated formulas must not assume
the corresponding point is rational. A classification of this fixed
curve must still pass the second-square and positive common-source tests.
It does not classify varying exponents or residuals, establish all
integral inverse conditions, or supply the uniform point-height estimate
needed for the global ABC problem. New computations go only into
`next_*` files and are excluded from the publication evidence.
