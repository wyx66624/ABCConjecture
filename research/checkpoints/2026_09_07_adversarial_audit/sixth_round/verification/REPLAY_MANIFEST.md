# Sixth-round exact finite replay manifest

All four commands below were rerun with `--check` on2026-09-07 and
returned exit code0 with their recorded counts and hashes. The JSON
hashes here are the SHA256 of actual UTF-8 LF file bytes, not an
internal reserialization. Commands are relative to the repository root.
No file in this list certifies a global prime tail, an ABC proof, or a
new Lean declaration.

## Actual root intervals

    python research/checkpoints/2026_09_07_adversarial_audit/sixth_round/replay_root_windows.py --check

Output: `root_window_results.json` in this directory.

SHA256: `9c955ba3ed8d7a5c6f1ff1f7ac0e453377ca81d64cad08cb3b43d190d6fa80ce`.

Scope:27 actual blocks,216 prime rows,1008 individual lifting identities,
864 simple-root lifts and4904 actual layer inequalities. These are
finite integer checks of the ordinary RW proof.

## Boundary Frobenius and actual local shadows

    python research/checkpoints/2026_09_07_adversarial_audit/sixth_round/replay_boundary_shadow.py --check

Output: `boundary_shadow_results.json`.

SHA256: `fecf29fe68b332d60cfdd3143f6a1639b335b5db94d3557b8ba41fa09862f5fa`.

Scope: complete point counts34,12,4 at the norm25 and two norm7
reductions, and16 exact simultaneous positive primitive residue shadows.
Both other research agents independently reran this certificate.
The general local-shadow and non-CM conclusions additionally require
their independently reviewed ordinary proofs.

## Fixed splitting character

    python research/checkpoints/2026_09_07_adversarial_audit/sixth_round/replay_boundary_character.py --check

Output: `boundary_character_results.json`.

SHA256: `7eff33ce6623cca2544f5f4cd5c52a16d53a9cef8f0aa128903d800e7543c22a`.

Scope: all48 units modulo8, all2304 multiplication pairs and the two
complete norm13 point counts18,10. Their character-twisted traces
are both-4. Independently rerun by the independent-route agent.
This is not an unconditional E0 eigenform identification.

## Modular newspaces

    python research/checkpoints/2026_09_07_adversarial_audit/sixth_round/replay_modular_spaces.py --check

Output: `modular_space_results.json`.

SHA256: `a9a8d26becc22223498c7402d7d13c9ac9520eb2ba2b331cb3f7764580bb3521`.

Requires PARI/GP2.15.4. The wrapper invokes WSL Ubuntu-24.04 on
Windows and gp directly on Linux; the exact GP source is additionally
sealed within its result. Scope: five weight-two character12 newspaces
at levels36,72,144,288,576, dimensions2,0,2,4,8, six eigenorbits,
exact field-degree checks and coefficients through25. This separate
implementation agrees with the independent-route probe. It does not
prove a candidate level or exclude either non-CM orbit.

## Separate critical-agent rank replay

The separately maintained
`2026_09_07_critical_bottleneck/sixth_round/rank_root_replay.py`
was independently read and run with `--check` here. Its21 local
precision rows,24 blocks,1592 individual first-depth/LTE checks,
891 interval layers and632 progression/totient checks passed.
Its JSON file byte SHA256 is
`7eefa2aa8936d2125dc5851456d9036eaf4666a00ea4daf211c4b54dc02a56fd`;
the distinct internal compact-payload SHA256 reported by that script is
`d4dfd5aeebe2d2eb55dcf119aa578a4f392d10ae67360afa9508c7afaf84ebe4`.
The owning agent's manifest remains authoritative for that separate file.
