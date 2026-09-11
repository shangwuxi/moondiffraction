///|
test "Bragg accessibility and angle roundtrip" {
  assert_true(near(two_theta(1.0, 1.0).unwrap().unwrap(), 60.0))
  assert_true(near(two_theta(0.5, 1.0).unwrap().unwrap(), 180.0))
  assert_eq(two_theta(0.49, 1.0).unwrap(), None)
  assert_true(two_theta(0.0, 1.0) is Err(_))
  assert_true(spacing_from_angle(0.0, 1.0) is Err(_))
  for n = 1; n <= 180; n = n + 1 {
    let a = n.to_double()
    let d = spacing_from_angle(a, 1.54).unwrap()
    assert_true(near(two_theta(d, 1.54).unwrap().unwrap(), a))
  }
}
