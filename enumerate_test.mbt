///|
test "complete cubic sphere and bounded failure" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  assert_eq(m.reflections(1.0).unwrap().length(), 6)
  assert_eq(m.reflections(1.0, friedel_unique=true).unwrap().length(), 3)
  assert_eq(m.reflections(1.1).unwrap().length(), 0)
  assert_true(m.reflections(0.01, max_candidates=100) is Err(Budget(_)))
  assert_true(m.reflections(0.0) is Err(Invalid(_)))
}

///|
test "triclinic bounds agree with independent enclosing cube" {
  let m = reciprocal(2.0, 3.0, 4.0, 70.0, 80.0, 65.0).unwrap()
  let found = m.reflections(1.0).unwrap()
  let mut count = 0
  for h = -6; h <= 6; h = h + 1 {
    for k = -6; k <= 6; k = k + 1 {
      for l = -6; l <= 6; l = l + 1 {
        if h == 0 && k == 0 && l == 0 {
          continue
        }
        let idx = hkl(h, k, l).unwrap()
        if m.q2(idx) <= 1.0 * (1.0 + 1.0e-12) {
          assert_true(found.contains(idx))
          count = count + 1
        }
      }
    }
  }
  assert_eq(found.length(), count)
}
