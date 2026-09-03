# Reproduction

From the repository root in PowerShell:

```powershell
python research/computation/2026_09_02_pell_hensel_specialization/produce_pell_hensel_specialization.py `
  *> research/computation/2026_09_02_pell_hensel_specialization/producer_stdout.txt

python research/computation/2026_09_02_pell_hensel_specialization/verify_pell_hensel_specialization.py `
  *> research/computation/2026_09_02_pell_hensel_specialization/verifier_stdout.txt
```

Both commands must exit with code zero, and the verifier must return
`"status": "PASS"` with an empty error list.

The bounded index-three search and its independent C++ replay are:

```powershell
python research/computation/2026_09_02_pell_hensel_specialization/search_index3_moving_squarefull.py

g++ -std=c++20 -O2 `
  research/computation/2026_09_02_pell_hensel_specialization/verify_index3_moving_squarefull.cpp `
  -o research/computation/2026_09_02_pell_hensel_specialization/verify_index3_moving_squarefull.exe

research/computation/2026_09_02_pell_hensel_specialization/verify_index3_moving_squarefull.exe
```

Both search programs must report `43,355,470` canonical powerful
representations, the sole `F3` candidate `s=341`, and zero two-channel hits.
The generated executable is intentionally omitted from the repository seal.
