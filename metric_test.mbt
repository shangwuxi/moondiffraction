///|
fn near(a : Double, b : Double) -> Bool {
  (a - b).abs() <= 1.0e-9 * (1.0 + b.abs())
}

///|
test "cubic reciprocal metric and invalid cells" {
  let m = reciprocal(2.0, 3.0, 4.0, 90.0, 90.0, 90.0).unwrap()
  assert_true(near(m.aa, 0.25))
  assert_true(near(m.bb, 1.0 / 9.0))
  assert_true(near(m.cc, 1.0 / 16.0))
  assert_true(near(m.ab, 0.0))
  assert_true(reciprocal(0.0, 1.0, 1.0, 90.0, 90.0, 90.0) is Err(_))
  assert_true(reciprocal(1.0, 1.0, 1.0, 170.0, 10.0, 10.0) is Err(_))
  assert_true(reciprocal(1.0, 1.0, 1.0, 0.0, 90.0, 90.0) is Err(_))
}
