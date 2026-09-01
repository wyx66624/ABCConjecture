# Reproducing the Danilov recursive-lift evidence

All scripts use only the Python standard library.  The commands below are
PowerShell commands from the repository root.  Any Python 3 interpreter with
the standard library is sufficient.

```powershell
$python = (Get-Command python -ErrorAction Stop).Source
$dir = 'research/computation/2026_09_01_danilov_recursive_lift'

& $python "$dir/search_recursive_lifts.py" --limit 1000000 --output "$dir/search_stage0_1m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage0_1m.json" --limit 1000000 --output "$dir/search_stage1_1m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage1_1m.json" --limit 1000000 --output "$dir/search_stage2_1m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage2_1m.json" --limit 1000000 --output "$dir/search_stage3_1m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage3_1m.json" --limit 1000000 --output "$dir/search_stage4_1m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage4_1m.json" --limit 1000000 --output "$dir/search_stage5_1m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage5_1m.json" --limit 1000000 --output "$dir/search_stage6_1m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage6_1m.json" --limit 10000000 --output "$dir/search_stage7_10m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage7_10m.json" --limit 10000000 --output "$dir/search_stage8_10m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage8_10m.json" --limit 10000000 --output "$dir/search_stage9_10m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage9_10m.json" --limit 50000000 --output "$dir/search_stage10_50m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage10_50m.json" --limit 50000000 --output "$dir/search_stage11_50m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage11_50m.json" --limit 100000000 --output "$dir/search_stage12_100m.json"
& $python "$dir/search_recursive_lifts.py" --previous "$dir/search_stage12_100m.json" --limit 100000000 --output "$dir/search_stage13_100m.json"

& $python "$dir/verify_fibonacci_structure.py"
& $python "$dir/verify_recursive_chain.py"
& $python "$dir/build_manifest.py"
```

The generator's sieve is exhaustive only up to the endpoint supplied on each
command line.  Replaying it is what certifies that no eligible prime was
omitted below that endpoint.  `verify_recursive_chain.py` independently
checks all saved modular rows and transitions, but deliberately does not
claim an unbounded prime search.

To verify the frozen artifact hashes:

```powershell
$python -c "import hashlib,json,pathlib; d=pathlib.Path('research/computation/2026_09_01_danilov_recursive_lift'); m=json.loads((d/'FILE_MANIFEST.json').read_text()); assert all(hashlib.sha256((d/x['path']).read_bytes()).hexdigest()==x['sha256'] and (d/x['path']).stat().st_size==x['bytes'] for x in m['files']); print('manifest PASS',len(m['files']))"
Get-Content "$dir/SHA256SUMS"
```

The primary Carmichael source is not regenerated.  Its expected SHA-256 is
`69543ae7c2fd2193ce633a5cfbae1f448204f114fd07da11b3add2ef694eff70`.
