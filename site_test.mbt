///|
test "scatterer normalization and strict physical domains" {
  let s = site(-0.25, 2.5, 0.0, -2.0, occupancy=0.5, b_iso=3.0).unwrap()
  assert_true(near(s.x, 0.75))
  assert_true(near(s.y, 0.5))
  assert_true(near(s.translated(1.0, 0.0, 0.0).unwrap().x, s.x))
  assert_true(site(0.0, 0.0, 0.0, 1.0, occupancy=1.1) is Err(_))
  assert_true(site(0.0, 0.0, 0.0, 1.0, b_iso=-1.0) is Err(_))
  assert_true(site(1.0e10, 0.0, 0.0, 1.0) is Err(_))
}
