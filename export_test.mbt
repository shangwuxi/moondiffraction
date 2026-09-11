///|
test "exports name units and retain inaccessible reflections" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let rs = m.simulate([site(0.0, 0.0, 0.0, 1.0).unwrap()], 1.0, 3.0).unwrap()
  let csv = reflections_csv(rs).unwrap()
  assert_true(csv.has_prefix("h,k,l,d_angstrom,intensity,two_theta_degree\n"))
  assert_eq(csv.split("\n").to_array().length(), 8)
  let json = reflections_json(rs).unwrap().stringify()
  assert_true(json.contains("moondiffraction.reflections.v1"))
  assert_true(json.contains("null"))
  assert_true(
    gaussian_profile([], 0.0, 1.0, 5, 1.0)
    .unwrap()
    .csv()
    .has_prefix("two_theta_degree,intensity_per_degree\n"),
  )
}
