///|
test "Miller spacing and Friedel canonicalization" {
  let m = reciprocal(3.0, 3.0, 3.0, 90.0, 90.0, 90.0).unwrap()
  let x = hkl(1, 2, 2).unwrap()
  assert_true(near(m.spacing(x), 1.0))
  assert_true(near(m.q2(x), m.q2(x.opposite())))
  assert_eq(x.opposite().canonical(), x)
  assert_true(hkl(0, 0, 0) is Err(_))
  assert_true(hkl(-2147483648, 0, 0) is Err(_))
  assert_eq(hkl(0, 0, -2).unwrap().canonical(), hkl(0, 0, 2).unwrap())
}
