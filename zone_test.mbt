///|
test "zone law and reciprocal angles respect metric" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  assert_true(
    near(m.plane_angle(hkl(1, 0, 0).unwrap(), hkl(0, 1, 0).unwrap()), 90.0),
  )
  assert_true(
    near(m.plane_angle(hkl(1, 0, 0).unwrap(), hkl(1, 1, 0).unwrap()), 45.0),
  )
  assert_true(
    near(m.plane_angle(hkl(1, 0, 0).unwrap(), hkl(-1, 0, 0).unwrap()), 180.0),
  )
  assert_eq(m.zone(1.0, 0, 0, 1).unwrap().length(), 4)
  assert_true(in_zone(hkl(1, -1, 0).unwrap(), 1, 1, 1).unwrap())
  assert_true(m.zone(1.0, 0, 0, 0) is Err(Invalid(_)))
}
