# Sixteenth-round review status

QS1--QS4: full ordinary PASS from root, critical_bottleneck and
adversarial_audit. The reviewed mathematical text before the status-only
header update was SHA
ca3672e3c0533b2e3ef7c04e8308d1d8e4e744df3bb6a4abccffd42fda0aaea3.
Root verified the complete chain; both peers also actually re-opened the
Milne primary inputs. Critical independently enumerated all squared fibres
in F25 and F49. Adversarial independently used the different field models
F25=F5[sqrt3] and F49=F7[sqrt5], with write and --check both PASS.
Its certificate is adversarial sixteen/verification/quotient_counts.json,
SHA ab19e8d24b6eecbcda662aaed88dc4706702732abe149f2e5f1e3d8247643a65.

The author's complete replay uses F5[sqrt2] and F7[sqrt3]. It independently
checks direct square-fibre counts against norm-character counts and checks
all four sextic derivative gcds. Canonical result SHA:
6ba65a743aa190819b6d3b43c7e357d0f5aacb1e53508078cab882a46f240883.
The earlier two-item certificate b2586e...e8f10 was a preliminary five-only
probe, superseded by this four-item certificate and not a frozen release.

QH1--QH3: complete bounded ordinary candidate with actual primary-source
inspection. Both peers have been asked for a bounded full review; pending
unless a subsequent addendum records their actual responses. This note
separates an unconditional finite-container theorem through H1 from the
conditional direct full-curve quadratic-Chabauty criterion. It does not
compute either set or complete a rational-point determination.

No sixteenth-round theorem in these files has been formalized in Lean or
integrated into the main manuscript. Fifteenth-round sources are frozen.
