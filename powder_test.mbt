///|
test "powder multiplicities conserve intensity and reject duplicate input" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let rs = m.simulate([site(0.0, 0.0, 0.0, 1.0).unwrap()], 0.7, 1.0).unwrap()
  let peaks = powder(rs).unwrap()
  assert_eq(peaks.length(), 2)
  assert_eq(peaks[0].multiplicity(), 6)
  assert_eq(peaks[1].multiplicity(), 12)
  assert_true(near(peaks[0].intensity, 6.0))
  assert_true(near(peaks[1].intensity, 12.0))
  assert_true(powder([rs[0], rs[0]]) is Err(Invalid(_)))
  assert_eq(powder([]).unwrap().length(), 0)
}

///|
test "powder rejects mixed wavelengths and is invariant to input order" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let sites = [site(0.0, 0.0, 0.0, 1.0).unwrap()]
  let a = m.simulate(sites, 0.7, 1.0).unwrap()
  let b = m.simulate(sites, 0.7, 1.5).unwrap()
  assert_true(powder([a[0], b[1]]) is Err(Invalid(_)))
  let reversed = Array::makei(a.length(), n => a[a.length() - 1 - n])

  let p = powder(a).unwrap()
  let q = powder(reversed).unwrap()
  assert_eq(p.length(), q.length())
  for n = 0; n < p.length(); n = n + 1 {
    assert_eq(p[n].members, q[n].members)
    assert_eq(p[n].intensity, q[n].intensity)
    assert_eq(p[n].angle, q[n].angle)
  }
}
