///|
test "complete simulation retains extinct and inaccessible reflections" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let sites = [
    site(0.0, 0.0, 0.0, 1.0).unwrap(),
    site(0.5, 0.5, 0.5, 1.0).unwrap(),
  ]
  let all = m.simulate(sites, 1.0, 3.0).unwrap()
  assert_eq(all.length(), 6)
  assert_true(all.all(r => r.intensity < 1.0e-20 && r.angle == None))
  assert_eq(m.simulate(sites, 1.0, 1.0, centering=Body).unwrap().length(), 0)
  assert_true(m.simulate(sites, 1.0, 1.0, max_terms=1) is Err(Budget(_)))
  assert_true(m.simulate(sites, 1.0, 0.0) is Err(Invalid(_)))
}
