///|
test "Gaussian grid conserves well-contained line area" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let peaks = powder(
    m.simulate([site(0.0, 0.0, 0.0, 1.0).unwrap()], 1.0, 1.0).unwrap(),
  ).unwrap()
  let p = gaussian_profile(peaks, 50.0, 70.0, 801, 0.2).unwrap()
  assert_true(near(p.area(), 6.0))
  assert_eq(p.values.length(), 801)
  assert_true(gaussian_profile(peaks, 0.0, 180.0, 10, 0.2) is Err(Invalid(_)))
  assert_true(
    gaussian_profile(peaks, 50.0, 70.0, 801, 0.2, max_terms=10)
    is Err(Budget(_)),
  )
  let half = gaussian_profile(peaks, 60.0, 70.0, 401, 0.2).unwrap()
  assert_true(near(half.area(), 3.0))
}
