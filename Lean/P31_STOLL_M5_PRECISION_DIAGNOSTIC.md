# P31 Stoll first-m5-node precision diagnostic

The frozen 8000-bit failure package remains byte-for-byte unchanged.  Two
isolated diagnostics evaluated the seven halving residuals along the first
`m=5`, odd-unit `1` chain at 10000 and 12000 bits.  Neither run enumerated a
complete shell.  Because the diagnostic source set its operative threshold to
zero, its initial-divisor assertion is not an independent `>2000` certificate;
the later formal source must check that residual separately.

The node has seven halving layers.  At 10000 bits the triples `(c1,c2,c3)`
have minima

```text
7716, 4877, 3078, 2315, 2557, 2507, 2474.
```

`c2` is exact (`+Infinity`) at every layer.  The bottleneck is layer 4,
specifically `c3=2315` versus `c1=3246`.  Thus the 8000-bit failure is caused
by precision loss in the reduced-divisor residual `c3`, not the main
polynomial identity `c2`.  The returned accumulated certificate valuation is
2315, strictly 315 above the proposed threshold 2000.

At 12000 bits every finite valuation is exactly 2000 larger.  The bottleneck
remains layer-4 `c3=4315`, giving strict margin 2315 above threshold 2000.
This exact affine shift is strong calibration evidence for this node.

Consequently 10000 bits is the lowest tested precision that rigorously
certifies all seven halving residuals above 2000 on this chain.  For a future complete formal run, the recommended
minimum is 12000 bits with the unchanged strict threshold 2000.  This is a
cost/risk recommendation, not a proof about the other `m=5` representatives:
the full run must retain and pass the per-layer exact assertions.  No 16000-bit
diagnostic and no full run was started.
