///|
test "anchor grouping prevents tolerance chaining" {
  let rs = [
    Reflection::{
      index: hkl(1, 0, 0).unwrap(),
      d: 1.0,
      intensity: 1.0,
      angle: Some(10.0),
    },
    Reflection::{
      index: hkl(2, 0, 0).unwrap(),
      d: 1.0,
      intensity: 2.0,
      angle: Some(10.09),
    },
    Reflection::{
      index: hkl(3, 0, 0).unwrap(),
      d: 1.0,
      intensity: 3.0,
      angle: Some(10.18),
    },
  ]
  let peaks = powder(rs, tolerance=0.1).unwrap()
  assert_eq(peaks.length(), 2)
  assert_eq(peaks[0].multiplicity(), 2)
  assert_true((peaks[0].width - 0.09).abs() < 1.0e-9)
}
