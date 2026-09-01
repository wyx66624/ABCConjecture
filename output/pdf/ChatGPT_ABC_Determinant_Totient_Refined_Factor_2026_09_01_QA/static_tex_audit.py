from __future__ import annotations

import json
import re
from collections import Counter
from pathlib import Path


qa_dir = Path(__file__).resolve().parent
repo_root = qa_dir.parents[2]
paper_dir = repo_root / "paper"
main_tex = paper_dir / "ChatGPT_ABC_Uniformity_2026.tex"


def strip_comments(text: str) -> str:
    lines: list[str] = []
    for line in text.splitlines():
        cut = len(line)
        for index, char in enumerate(line):
            if char != "%":
                continue
            slash_count = 0
            cursor = index - 1
            while cursor >= 0 and line[cursor] == "\\":
                slash_count += 1
                cursor -= 1
            if slash_count % 2 == 0:
                cut = index
                break
        lines.append(line[:cut])
    return "\n".join(lines)


visited: list[Path] = []


def expand(path: Path) -> str:
    path = path.resolve()
    visited.append(path)
    text = strip_comments(path.read_text(encoding="utf-8"))

    def replace(match: re.Match[str]) -> str:
        child = (path.parent / match.group(1)).with_suffix(".tex")
        return expand(child)

    return re.sub(r"\\input\{([^}]+)\}", replace, text)


expanded = expand(main_tex)
labels = re.findall(r"\\label\{([^}]+)\}", expanded)
references = re.findall(
    r"\\(?:ref|eqref|pageref|autoref)\{([^}]+)\}", expanded
)
citation_groups = re.findall(
    r"\\cite(?:\[[^\]]*\])?\{([^}]+)\}", expanded
)
citations = [
    key.strip()
    for group in citation_groups
    for key in group.split(",")
    if key.strip()
]
bib_keys = re.findall(r"\\bibitem(?:\[[^\]]*\])?\{([^}]+)\}", expanded)

label_counts = Counter(labels)
bib_counts = Counter(bib_keys)
duplicate_labels = sorted(key for key, count in label_counts.items() if count > 1)
duplicate_bib_keys = sorted(key for key, count in bib_counts.items() if count > 1)
missing_references = sorted(set(references) - set(labels))
missing_citations = sorted(set(citations) - set(bib_keys))

environment_stack: list[str] = []
environment_errors: list[str] = []
for match in re.finditer(r"\\(begin|end)\{([^}]+)\}", expanded):
    kind, name = match.groups()
    if kind == "begin":
        environment_stack.append(name)
    elif not environment_stack:
        environment_errors.append(f"unmatched end: {name}")
    else:
        opened = environment_stack.pop()
        if opened != name:
            environment_errors.append(f"opened {opened}, closed {name}")
if environment_stack:
    environment_errors.extend(f"unclosed begin: {name}" for name in environment_stack)

fragments = [
    main_tex,
    paper_dir / "iut_refined_factor_signature_2026.tex",
    paper_dir / "affine_determinant_layer_entropy_2026.tex",
    paper_dir / "mersenne_totient_divisor_concentration_2026.tex",
]
proof_audit: dict[str, dict[str, int | list[str]]] = {}
proof_total = 0
proof_missing: list[str] = []
for fragment in fragments:
    text = strip_comments(fragment.read_text(encoding="utf-8"))
    theorem_ends = list(
        re.finditer(r"\\end\{(theorem|proposition|corollary)\}", text)
    )
    missing: list[str] = []
    for match in theorem_ends:
        remainder = text[match.end() :]
        if re.match(r"\s*\\begin\{proof\}", remainder) is None:
            line = text.count("\n", 0, match.start()) + 1
            missing.append(f"{match.group(1)} ending at line {line}")
    proof_audit[fragment.name] = {
        "statements": len(theorem_ends),
        "missingImmediateProof": missing,
    }
    proof_total += len(theorem_ends)
    proof_missing.extend(f"{fragment.name}: {item}" for item in missing)

raw_qquad = [
    match.start() for match in re.finditer(r"(?<!\\)\bqquad\b", expanded)
]

result = {
    "status": "PASS",
    "main": str(main_tex.relative_to(repo_root)).replace("\\", "/"),
    "filesExpanded": len(visited),
    "inputFiles": [
        str(path.relative_to(repo_root)).replace("\\", "/") for path in visited[1:]
    ],
    "labels": len(labels),
    "references": len(references),
    "bibliographyKeys": len(bib_keys),
    "citationCommands": len(citation_groups),
    "citedKeys": len(citations),
    "duplicateLabels": duplicate_labels,
    "missingReferences": missing_references,
    "duplicateBibliographyKeys": duplicate_bib_keys,
    "missingCitations": missing_citations,
    "environmentErrors": environment_errors,
    "newFragmentProofAudit": proof_audit,
    "newFragmentStatementTotal": proof_total,
    "newFragmentMissingProofs": proof_missing,
    "rawQquadOccurrences": len(raw_qquad),
    "authorChatGPT": "\\author{ChatGPT}" in expanded,
    "honestOpenStatus":
        "remains unproved and undisproved here" in expanded,
}

assert not duplicate_labels
assert not missing_references
assert not duplicate_bib_keys
assert not missing_citations
assert not environment_errors
assert proof_total == 25
assert not proof_missing
assert not raw_qquad
assert result["authorChatGPT"]
assert result["honestOpenStatus"]

(qa_dir / "static-tex-audit.json").write_text(
    json.dumps(result, indent=2, ensure_ascii=False) + "\n", encoding="utf-8"
)
print(json.dumps(result, indent=2, ensure_ascii=False))
