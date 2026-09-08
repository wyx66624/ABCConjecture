#!/usr/bin/env python3
"""Replay HT's exact leading digits and the arithmetic of its recorded p-adic balls.

This portable check does not call PARI or regenerate high-precision heights.
The separately version-pinned full GP replay supplies those recorded balls.
The ordinary sigma-integrality proof supplies the omitted-series bound.
"""
from pathlib import Path
from fractions import Fraction as F
import hashlib
import importlib.util
import json

ROOT = Path(__file__).resolve().parents[3]
SOURCE = ROOT/'research/checkpoints/2026_09_07_independent_route/eighteenth_round'
PIN = '70ec75594f205336757496605750b1302e5f3b271afd6acf5b12275a36c9de05'


def main():
    script = SOURCE/'replay_height_transport.py'
    certificate = SOURCE/'verification/height_transport.json'
    raw = certificate.read_bytes()
    assert hashlib.sha256(raw).hexdigest() == PIN
    data = json.loads(raw)
    spec = importlib.util.spec_from_file_location('ht_exact_replay', script)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    leading = module.exact_leading()
    assert leading == data['exact_leading']
    assert hashlib.sha256((SOURCE/'replay_height_transport.gp').read_bytes()).hexdigest() == data['gp_sha256']
    assert len(data['rows']) == 4
    for j, n, change, aa, bb, ss, tt, ll, mm in data['rows']:
        u, r, s0, t0 = change
        assert (u,r,s0,t0) == (2,9 if j == 1 else -33,0,0)
        assert n in [12,24]
        a,b = map(module.ball,aa)
        A,B = map(module.ball,bb)
        s,t,L,M = map(module.ball,[ss,tt,ll,mm])
        precision = min(z[1] for z in aa+bb+[ss,tt,ll,mm])
        assert precision >= n
        errors = [A-(a+r*b)/u,B-u*b,t-(u*u*s-r),M-L/u,
                  u*A-(r+s)*B/u-(a-s*b)]
        assert all(module.vp(e) >= precision for e in errors)
        height = a-s*b
        assert module.residue(height,25) == leading[j-1]['height_mod25']
        assert module.residue(A-t*B-height,25) == leading[j-1]['naive_minus_intrinsic_mod25']
        assert module.vp(A-t*B-height) == 1
        assert module.vp(height/(M*M)-4*height/(L*L)) >= precision-2
    for r in [9,-33]:
        T = [[F(1,2),F(r,2)],[F(0),F(2)]]
        U = [[F(2),F(-r,2)],[F(0),F(1,2)]]
        assert [[sum(U[i][k]*T[k][j] for k in range(2)) for j in range(2)]
                for i in range(2)] == [[1,0],[0,1]]
    print('PASS: exact HT leading digits and recorded-ball arithmetic; PARI heights not recomputed')


if __name__ == '__main__':
    main()
