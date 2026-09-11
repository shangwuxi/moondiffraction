///|
test "all numerical entry points reject NaN and infinities" {
  let bad = [0.0 / 0.0, 1.0 / 0.0, -1.0 / 0.0]
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  for x in bad {
    assert_true(reciprocal(x, 1.0, 1.0, 90.0, 90.0, 90.0) is Err(_))
    assert_true(reciprocal(1.0, 1.0, 1.0, x, 90.0, 90.0) is Err(_))
    assert_true(site(x, 0.0, 0.0, 1.0) is Err(_))
    assert_true(site(0.0, 0.0, 0.0, x) is Err(_))
    assert_true(site(0.0, 0.0, 0.0, 1.0, occupancy=x) is Err(_))
    assert_true(site(0.0, 0.0, 0.0, 1.0, b_iso=x) is Err(_))
    assert_true(m.reflections(x) is Err(_))
    assert_true(two_theta(x, 1.0) is Err(_))
    assert_true(two_theta(1.0, x) is Err(_))
    assert_true(spacing_from_angle(x, 1.0) is Err(_))
    assert_true(m.simulate([], 1.0, x) is Err(_))
    assert_true(powder([], tolerance=x) is Err(_))
    assert_true(gaussian_profile([], 0.0, 1.0, 10, x) is Err(_))
    assert_true(match_peaks([x], [], 0.1) is Err(_))
  }
}

///|
test "length scaling preserves Miller membership and rescales reciprocal norms" {
  let a = reciprocal(2.0, 3.0, 4.0, 75.0, 85.0, 65.0).unwrap()
  let b = reciprocal(20.0, 30.0, 40.0, 75.0, 85.0, 65.0).unwrap()
  assert_eq(a.reflections(1.0).unwrap(), b.reflections(10.0).unwrap())
  for i in a.reflections(1.0).unwrap() {
    assert_true(near(a.q2(i), b.q2(i) * 100.0))
  }
}

///|
test "cubic shell counts are exact across several cutoffs" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  for n = 1; n <= 12; n = n + 1 {
    let mut count = 0
    for h = -4; h <= 4; h = h + 1 {
      for k = -4; k <= 4; k = k + 1 {
        for l = -4; l <= 4; l = l + 1 {
          let squared = h * h + k * k + l * l
          if squared > 0 && squared <= n {
            count = count + 1
          }
        }
      }
    }
    assert_eq(
      m.reflections(1.0 / n.to_double().sqrt()).unwrap().length(),
      count,
    )
  }
}

///|
test "work budgets are checked on empty and oversized domains" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  assert_true(m.reflections(1.0, max_candidates=0) is Err(_))
  assert_true(m.reflections(1.0, max_candidates=2000001) is Err(_))
  assert_true(m.reflections(1.0e-30) is Err(Budget(_)))
  assert_true(
    m.amplitude(
      hkl(1, 0, 0).unwrap(),
      Array::make(10001, site(0.0, 0.0, 0.0, 1.0).unwrap()),
    )
    is Err(Budget(_)),
  )
  assert_true(m.simulate([], 1.0, 1.0, max_terms=0) is Err(_))
  assert_true(gaussian_profile([], 0.0, 1.0, 100001, 1.0) is Err(_))
  assert_true(match_peaks([], [], 0.0, max_pairs=0) is Err(_))
}

///|
test "zero weight and occupancy sensitivities do not divide by zero" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let i = hkl(1, 0, 0).unwrap()
  let g = m
    .sensitivity(i, [site(0.0, 0.0, 0.0, 0.0, occupancy=0.0).unwrap()], 0)
    .unwrap()
  assert_eq([g.dx, g.dy, g.dz, g.occupancy, g.weight, g.b_iso], [
    0.0, 0.0, 0.0, 0.0, 0.0, 0.0,
  ])
}

///|
test "tiny and huge orthogonal lengths remain numerically finite" {
  for length in [1.0e-6, 1.0e6] {
    let m = reciprocal(length, length, length, 90.0, 90.0, 90.0).unwrap()
    assert_true(near(m.spacing(hkl(1, 0, 0).unwrap()) / length, 1.0))
  }
}
