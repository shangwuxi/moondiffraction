"""Independent oracle: Cartesian cross products, not the library Gram cofactors.
Only Python standard library. Runs 496 reciprocal/complex-amplitude cases.
"""
import cmath
import math
import subprocess
import sys

CELLS = [(2, 3, 4, 90, 90, 90), (3.1, 4.2, 5.3, 72, 81, 64),
         (2.5, 2.5, 6, 90, 90, 120), (5, 4, 3, 110, 95, 75)]
SITES = [(0.13, 0.27, 0.39, 2, 0.8, 0.6), (0.42, 0.18, 0.63, -1, 0.4, 1.1)]

def dot(a, b):
    return sum(x*y for x, y in zip(a, b))

def cross(a, b):
    return (a[1]*b[2]-a[2]*b[1], a[2]*b[0]-a[0]*b[2], a[0]*b[1]-a[1]*b[0])

def reciprocal_basis(cell):
    a, b, c, alpha, beta, gamma = cell
    ca, cb, cg = [math.cos(math.radians(x)) for x in (alpha, beta, gamma)]
    sg = math.sin(math.radians(gamma))
    av = (a, 0, 0)
    bv = (b*cg, b*sg, 0)
    cx, cy = c*cb, c*(ca-cb*cg)/sg
    cv = (cx, cy, math.sqrt(c*c-cx*cx-cy*cy))
    volume = dot(av, cross(bv, cv))
    return [tuple(x/volume for x in v) for v in (cross(bv, cv), cross(cv, av), cross(av, bv))]

def main():
    target = sys.argv[1] if len(sys.argv) > 1 else 'wasm-gc'
    out = subprocess.run(['moon', 'run', 'cmd/oracle', '--target', target],
                         check=True, stdout=subprocess.PIPE, text=True).stdout
    cases = 0
    for line in out.splitlines():
        values = line.split(',')
        if len(values) != 7:
            raise AssertionError('Unexpected oracle row: ' + line)
        cell, h, k, l = map(int, values[:4])
        actual = list(map(float, values[4:]))
        basis = reciprocal_basis(CELLS[cell])
        g = [sum(i*v[axis] for i, v in zip((h, k, l), basis)) for axis in range(3)]
        q2 = dot(g, g)
        f = sum(w*occ*math.exp(-b*q2/4)*cmath.exp(2j*math.pi*(h*x+k*y+l*z))
                for x, y, z, w, occ, b in SITES)
        for a, e in zip(actual, (q2, f.real, f.imag)):
            assert math.isclose(a, e, rel_tol=1e-10, abs_tol=1e-10), (line, e)
        cases += 1
    assert cases == 496, cases
    print('Independent Cartesian/complex oracle: 496 cases passed (' + target + ')')

if __name__ == '__main__':
    main()
