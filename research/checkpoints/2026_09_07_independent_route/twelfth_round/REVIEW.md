# Review and verification ledger

## Ordinary proofs

Root, critical_bottleneck and adversarial_audit each read RL1--RL4,
UG1--UG3 and HG1--HG3 completely and returned ordinary PASS.
The authors' final status headers merely record those reviews.
The main points independently checked were the full projective
inverse domain, rational norm-one and Galois conditions, actual
primitive seed reconstruction using CI, odd-unit absorption and
Gaussian uniqueness, geometric relative ramification, exact torsion
by the Kummer-degree contradiction, and the Q-defined norm/pullback
isogeny with its positive rational point domain.

Milne's Jacobian Varieties, Theorem 1.1 and Remark 1.5, were actually
opened and read by the author and independently by root and peers.
They support the natural map from degree-zero line bundles without
assuming a rational base point. The Stacks curve/RH inputs were
actually opened. The author's reading of Lange--Recillas is context
for the general group-action method; its complex-field formulation
was not silently used as an arithmetic isogeny descent theorem.

## Final TeX review

Both peers read the three final TeX files in full and returned PASS.
RL final SHA-256:
300f4c9403cc188a0ee29d758e1d42fd63f737bafd31397d2b97c6f0eb5cc5d5.
UG final SHA-256:
9c54990e807e9086de902cf8b1f51efb49bb535a449e40d15fa4249fdf6b06f6.
HG final SHA-256:
829c397b5cb825f2981d45232b3e4daf630e9bdff804d7da8881162351cda518.

One wording defect was caught in UG and corrected in the ordinary
proof and TeX: simple Kummer zeros belong to the base P1_t, while
their pullbacks on D have order g. Both peers actually reread the
fixed line and returned final PASS. The conclusions did not change.
Root's final integrated-paper read/build and new PDF visual QA are
recorded by parent separately; this ledger does not presume them.

## Finite exact certificate

The author actually ran replay_rational_geometry.py --write and
then --check. Both passed with canonical JSON SHA-256
9ccf3ce5e8c3e4316f880afdb44edfd0687744935beb98b17baa70a18efd9efa.
The output uses UTF-8 LF through write_bytes and contains its script
hash. Its exact scope is specified in README and in the JSON flags.
It does not test all g or all rational points, compute a Jacobian
rank or torsion group, or substitute for an infinite ordinary proof.
No independent execution by a peer is claimed at the time of this
ledger; parent may subsequently record one in the integration audit.

## Cross-reviews given by this agent

The complete MC and PN ordinary proofs and current final TeX files
were actually read and independently passed. Final reviewed TeX
SHA-256 values are MC
a02e9bb5c9bba5a4aeeede93c8623207ad8928b73d9113277b395350466a1234
and PN
c1377ebb296ee983e5337da9977ae3fe795a6ffa5525697c5fe5bcd59d309f89.
The subsequent MC layout-only change places the J/L/W definitions
on two gather lines. Those exact lines and the new hash were actually
rechecked: 48359c4a0779858092fc89dbe8d08b1962edec2f65e396438f50d5085680b1eb.
It makes no mathematical change and retains the transcription PASS.
The complete PF ordinary proof and final TeX were likewise read and
passed; the TeX SHA-256 is
612596b982278f950d5add784203f2a27ca5cdf8e63975657a0b4f653b0730de.
Those final transcriptions retain the interval endpoints, exception
fractions, actual private-prime premise, fixed-nu limits, exact
phase examples and full far-tail scope. Their finite replay totals
were not re-executed by this reviewer.

The full 15-declaration DeepRootPhaseArithmetic.lean and the full
six-declaration ActualDeepRootCount.lean received theorem-signature,
proof and scope PASS after actual source reading. The latter source
SHA-256 was 06e2e8b5bbc7f0f3906de91964488bc6965a4b7fdb934a05c3b9823df41c9891.
This is not a further fresh compilation or independent axiom scan.
Both files retain their stated finite-ring interfaces rather than
claiming analytic torsion/lifting/sieve conclusions formalized.
