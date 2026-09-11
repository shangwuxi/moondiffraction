///|
test "analytic intensity sensitivity agrees with independent central differences" {
  let m = reciprocal(3.0, 4.0, 5.0, 75.0, 85.0, 65.0).unwrap()
  let i = hkl(1, 2, -1).unwrap()
  let base = site(0.17, 0.29, 0.41, 2.0, occupancy=0.7, b_iso=0.4).unwrap()
  let other = site(0.37, 0.11, 0.08, -0.3).unwrap()
  let grad = m.sensitivity(i, [base, other], 0).unwrap()
  let params = [0.17, 0.29, 0.41, 2.0, 0.7, 0.4]
  let expected = [
    grad.dx,
    grad.dy,
    grad.dz,
    grad.weight,
    grad.occupancy,
    grad.b_iso,
  ]
  let eps = 1.0e-6
  for n = 0; n < 6; n = n + 1 {
    let lo = params.copy()
    let hi = params.copy()
    lo[n] = lo[n] - eps
    hi[n] = hi[n] + eps
    let a = site(lo[0], lo[1], lo[2], lo[3], occupancy=lo[4], b_iso=lo[5]).unwrap()
    let b = site(hi[0], hi[1], hi[2], hi[3], occupancy=hi[4], b_iso=hi[5]).unwrap()
    let finite_difference = (
        m.amplitude(i, [b, other]).unwrap().intensity() -
        m.amplitude(i, [a, other]).unwrap().intensity()
      ) /
      (2.0 * eps)
    assert_true((finite_difference - expected[n]).abs() < 1.0e-6)
  }
  assert_true(m.sensitivity(i, [base], 1) is Err(Invalid(_)))
}
