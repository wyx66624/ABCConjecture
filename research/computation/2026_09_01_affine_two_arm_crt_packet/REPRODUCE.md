# Reproduction

From the repository root, using Python 3.10 or newer:

```powershell
python research/computation/2026_09_01_affine_two_arm_crt_packet/verify_two_arm_packet.py
```

In the Codex bundled runtime used to generate the captured output:

```powershell
& 'C:\Users\Admin\.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe' `
  research/computation/2026_09_01_affine_two_arm_crt_packet/verify_two_arm_packet.py
```

The last line must be `captured_output_match=true`.

To regenerate `OUTPUT.txt` deliberately:

```powershell
python research/computation/2026_09_01_affine_two_arm_crt_packet/verify_two_arm_packet.py --write-output
```

