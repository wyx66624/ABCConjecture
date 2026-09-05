#!/usr/bin/env python3
"""Check this checkpoint's explicit axiom-query output against a whitelist.
This checks declared dependency reports for one supplied module, not an ABC proof.
"""
from pathlib import Path
import re
import sys

ALLOWED = {'propext', 'Classical.choice', 'Quot.sound'}

def main():
    if len(sys.argv) != 3:
        raise SystemExit('Usage: check_axioms.py MODULE.lean COMPILER_OUTPUT.txt')
    source = Path(sys.argv[1]).read_text()
    output = Path(sys.argv[2]).read_text()
    namespace = re.search(r'^namespace\s+(\w+)\s*$', source, re.M)
    if not namespace:
        raise SystemExit('Expected an explicit module namespace')
    names = re.findall(r'^#print axioms\s+(\w+)\s*$', source, re.M)
    if len(names) != len(set(names)) or not names:
        raise SystemExit('Axiom-query names must be nonempty and unique')
    union = set()
    for name in names:
        full = namespace.group(1) + '.' + name
        marker = "'" + re.escape(full) + "' "
        match = re.search(marker+r'depends on axioms:\s*\[([^\]]*)\]', output)
        if match:
            axioms = {s.strip() for s in match.group(1).split(',') if s.strip()}
            if not axioms <= ALLOWED:
                raise SystemExit(f'Unapproved axiom dependencies: {full}: {sorted(axioms-ALLOWED)}')
            union |= axioms
        elif not re.search(marker+r'does not depend on any axioms',output):
            raise SystemExit(f'Missing axiom report for {full}')
    if 'sorryAx' in output:
        raise SystemExit('Rejected sorryAx in compiler output')
    print(f'AXIOM AUDIT PASS: {len(names)} named queries; union={sorted(union)}')

if __name__ == '__main__': main()
