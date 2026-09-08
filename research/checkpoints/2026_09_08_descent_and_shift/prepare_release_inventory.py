#!/usr/bin/env python3
"""Bind the reviewed ordinary sources and their actual TeX transfer records.

This records completed reviews; it is not a mathematical verifier. It does
not mark a PDF visually reviewed or install an artifact.
"""
from pathlib import Path
import hashlib
import json

ROOT = Path(__file__).resolve().parents[3]
HERE = Path(__file__).resolve().parent
PREFIX = HERE.relative_to(ROOT).as_posix()
CRIT = 'research/checkpoints/2026_09_07_critical_bottleneck/eighteenth_round/'
INDEP = 'research/checkpoints/2026_09_07_independent_route/nineteenth_round/'
ADV = 'research/checkpoints/2026_09_07_adversarial_audit/nineteenth_round/'


def sha(relative):
    return hashlib.sha256((ROOT / relative).read_bytes()).hexdigest()


def main():
    ordinary = {
        CRIT+'next_shifted_boundary_resultants.md': '3c7f8cce60282796ec07df5cc5f079c8958efff8eb3bdea048f9472633a51e03',
        CRIT+'next_shifted_owner_scope.md': '6eeaf3521aab29eb8d7cf5aa516eff52aa499d20ae7ece22dab1b1a58d6d70f7',
        PREFIX+'/next_all_owner_paired_depth.md': '66de6fec5ac15e28380c1e3f1fafdbcc08655369ea9065e66c6517a7333489fb',
        INDEP+'next_zeta_squared_quotient.md': '8175504e0746e69219401f123b81b822ba6ba0f7a036afc638425ec797e088d5',
        INDEP+'next_zeta_squared_two_descent.md': 'ecbd3ace69864dd32541157d013f82c6260fda2eac2274a54c839f967bb55d5a',
        INDEP+'next_actual_square_cube_exclusion.md': '0c54700c944cc8d10df08d3af03d9f3ccff4407154cca89eeb2ec4b01a738fe4',
        INDEP+'next_ramified_square_cube.md': '8c840dd90e2193b974a647b29133b9b8ce04d655b55e7cdbbb70c8088c685341',
    }
    for path, digest in ordinary.items():
        assert sha(path) == digest, 'Reviewed ordinary source changed: '+path
    tex = {
        PREFIX+'/paper/shifted_boundary_resultants.tex': '33e6a9d44784147c22e33872a2cee1971d2663b16c7b8ebbe194ab1d65ffac92',
        PREFIX+'/paper/all_owner_paired_depth.tex': '8305ef641811e638de24c2fb54ec068ee03f6255571cb552f6b581d721d2e551',
        PREFIX+'/paper/zeta_squared_quotient.tex': '597578f7da9a98a19ff272b0d4843c7a3b3d08731d3d4d95496d1f334a31a012',
        PREFIX+'/paper/zeta_squared_two_descent.tex': '7ee7c298f08d6ee2245d923309338fc7aaeb2cfe4ade05e66fe10c7d19efdd91',
        PREFIX+'/paper/ramified_cubic_exclusion.tex': '3eb6c1b95c557d19790fade596a77049138dafc7af12ed81aa6f1a1c412cf4cf',
        PREFIX+'/paper/f13_formal_scope.tex': '2bd7e074a77ae3d78df7d504a48bb712b1c45283e3ccd8cb0739c4a0a21bedba',
        PREFIX+'/paper/descent_shift_status.tex': '928be5c73963134187a814e2b4ee46aa33133fcdca56bc2850d5752a1968cc22',
        PREFIX+'/paper/bibliography_geometry.tex': '02384a34e3d293e466b007ed11781303394b523af67a3f06d672f1813d675b7c',
    }
    for path, digest in tex.items():
        assert sha(path) == digest, 'Reviewed TeX changed: '+path
    tex['paper/ChatGPT_ABC_Uniformity_2026.tex'] = sha('paper/ChatGPT_ABC_Uniformity_2026.tex')
    reviews = [
        PREFIX+'/root_ordinary_review.md', PREFIX+'/root_two_descent_review.md',
        PREFIX+'/root_f13_formal_review.md', PREFIX+'/root_ramified_review.md',
        PREFIX+'/root_transcription_review.md', PREFIX+'/independent_shift_transcription_review.md',
        CRIT+'next_squared_unit_descent_review.md', CRIT+'next_zeta_squared_review.md',
        CRIT+'next_all_owner_paired_review.md', CRIT+'next_f13_kernel_review.md',
        CRIT+'next_ramified_cube_review.md',
        ADV+'next_shifted_resultant_review.md', ADV+'next_zeta_squared_review.md',
        ADV+'next_zeta_squared_descent_review.md', ADV+'next_actual_square_cube_review.md',
        ADV+'next_all_owner_paired_review.md', ADV+'next_geometry_transcription_review.md',
        ADV+'next_shift_transcription_review.md', ADV+'next_ramified_square_cube_review.md',
    ]
    record = dict(status='PASS: complete ordinary-to-TeX review',
                  tex_sha256=tex, independent_review_records_sha256={p:sha(p) for p in reviews},
                  not_claimed=['external peer review', 'complete geometric Lean proof', 'ABC'])
    (HERE/'verification/ordinary_source_inventory.json').write_text(json.dumps(ordinary, indent=2)+'\n')
    (HERE/'verification/transcription_review.json').write_text(json.dumps(record, indent=2)+'\n')
    print(json.dumps({'ordinary_sources':len(ordinary), 'new_tex_inputs':len(tex)-1,
                      'review_records':len(reviews)}))


if __name__ == '__main__':
    main()
