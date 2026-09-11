///|
test "matching preserves order, unmatched points and candidate residuals" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let peaks = powder(
    m.simulate([site(0.0, 0.0, 0.0, 1.0).unwrap()], 0.7, 1.0).unwrap(),
  ).unwrap()
  let found = match_peaks([60.03, 20.0, 89.98], peaks, 0.1).unwrap()
  assert_eq(found[0].candidates, [0])
  assert_true(near(found[0].residuals[0], 0.03))
  assert_eq(found[1].candidates, [])
  assert_eq(found[2].candidates, [1])
  assert_true(match_peaks([60.0], peaks, 0.1, max_pairs=1) is Err(Budget(_)))
  assert_true(match_peaks([-1.0], peaks, 0.1) is Err(Invalid(_)))
}
