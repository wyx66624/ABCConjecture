#!/usr/bin/env python3
"""Generate the declaration-level audit for the 2026-08-31 dual-route stage."""

from __future__ import annotations

import hashlib
import json
import re
from pathlib import Path


HERE = Path(__file__).resolve().parent
LEAN_ROOT = HERE.parents[1]
REPO_ROOT = LEAN_ROOT.parent

MODULES = [
    ("ABCMixedFullCampana20260831", 8, 2),
    ("FreyIsogenyConductorSharpness20260831", 28, 5),
    ("IUTFiniteProductProjectionSpan20260831", 5, 1),
    ("ABCThreePrimeSignatures20260831", 16, 0),
    ("ABCSubcriticalLocusUniformity20260831", 16, 4),
    ("PellCampanaCounterexample20260831", 21, 3),
]

DECL_RE = re.compile(
    r"^\s*(?:@\[[^\]]+\]\s*)?(?:noncomputable\s+)?"
    r"(def|theorem|structure)\s+([A-Za-z0-9_']+)"
)
NAMESPACE_RE = re.compile(r"^\s*namespace\s+([A-Za-z0-9_.]+)\s*$")
END_RE = re.compile(r"^\s*end\s+([A-Za-z0-9_.]+)\s*$")


def sha256(path: Path) -> str:
    return hashlib.sha256(path.read_bytes()).hexdigest()


def declarations(path: Path) -> list[dict[str, str]]:
    namespace_stack: list[str] = []
    found: list[dict[str, str]] = []
    for line in path.read_text(encoding="utf-8").splitlines():
        namespace_match = NAMESPACE_RE.match(line)
        if namespace_match:
            namespace_stack.append(namespace_match.group(1))
            continue
        end_match = END_RE.match(line)
        if end_match and namespace_stack:
            label = end_match.group(1)
            if label == namespace_stack[-1] or label == ".".join(namespace_stack):
                namespace_stack.pop()
            continue
        declaration_match = DECL_RE.match(line)
        if not declaration_match:
            continue
        kind, name = declaration_match.groups()
        namespace = ".".join(namespace_stack)
        full_name = f"{namespace}.{name}" if namespace else name
        module_prefix = f"IUTThreeClosures.{path.stem}."
        if not full_name.startswith(module_prefix):
            raise RuntimeError(
                f"unexpected namespace for {path.name}: {full_name}"
            )
        relative_name = full_name[len(module_prefix) :]
        found.append(
            {
                "kind": kind,
                "name": relative_name,
                "full_name": full_name,
            }
        )
    return found


def main() -> None:
    audit_lines = [
        "/-",
        "Copyright (c) 2026 ChatGPT. All rights reserved.",
        "Released under Apache 2.0 license as described in the file LICENSE.",
        "Authors: ChatGPT",
        "-/",
    ]
    for module, _, _ in MODULES:
        audit_lines.append(f"import IUTThreeClosures.{module}")
    audit_lines.extend(
        [
            "",
            "/-! Declaration types and kernel dependencies for the dual-route",
            "continuation. This file supplies no proof of ABCConjecture or its negation. -/",
            "",
            "set_option linter.style.longLine false",
            "",
            "#print IUTThreeClosures.ABCConjecture",
            "",
        ]
    )

    manifest: dict[str, object] = {}
    total_theorems = 0
    total_additional = 0

    for module, expected_theorems, expected_additional in MODULES:
        source = LEAN_ROOT / "IUTThreeClosures" / f"{module}.lean"
        found = declarations(source)
        theorems = [item for item in found if item["kind"] == "theorem"]
        additional = [item for item in found if item["kind"] != "theorem"]
        if (len(theorems), len(additional)) != (
            expected_theorems,
            expected_additional,
        ):
            raise RuntimeError(
                f"{module}: expected {expected_theorems}/{expected_additional}, "
                f"found {len(theorems)}/{len(additional)}"
            )

        total_theorems += len(theorems)
        total_additional += len(additional)
        audit_lines.append(f"-- {module}")
        for item in [*theorems, *additional]:
            audit_lines.append(f"#check {item['full_name']}")
            audit_lines.append(f"#print axioms {item['full_name']}")
        audit_lines.append("")

        rel_source = source.relative_to(REPO_ROOT).as_posix()
        manifest[module] = {
            "source": rel_source,
            "source_sha256": sha256(source),
            "source_bytes": source.stat().st_size,
            "public_theorems": [item["name"] for item in theorems],
            "additional_proof_bearing_declarations": [
                item["name"] for item in additional
            ],
        }

    if (total_theorems, total_additional) != (94, 15):
        raise RuntimeError(
            f"unexpected totals: {total_theorems} theorems, "
            f"{total_additional} additional declarations"
        )

    audit_path = (
        LEAN_ROOT
        / "IUTThreeClosures"
        / "ResearchDualRouteContinuation20260831Audit.lean"
    )
    audit_path.write_text("\n".join(audit_lines) + "\n", encoding="utf-8")
    (HERE / "declarations.json").write_text(
        json.dumps(manifest, indent=2, ensure_ascii=False) + "\n",
        encoding="utf-8",
    )
    print(
        json.dumps(
            {
                "audit": audit_path.relative_to(REPO_ROOT).as_posix(),
                "modules": len(MODULES),
                "public_theorems": total_theorems,
                "additional_declarations": total_additional,
                "audited_declarations": total_theorems + total_additional,
            },
            indent=2,
        )
    )


if __name__ == "__main__":
    main()
