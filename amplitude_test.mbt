///|
test "body-centered cancellation and Friedel conjugacy" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let sites = [
    site(0.0, 0.0, 0.0, 1.0).unwrap(),
    site(0.5, 0.5, 0.5, 1.0).unwrap(),
  ]
  assert_true(
    m.amplitude(hkl(1, 0, 0).unwrap(), sites).unwrap().intensity() < 1.0e-20,
  )
  assert_true(
    near(m.amplitude(hkl(1, 1, 0).unwrap(), sites).unwrap().intensity(), 4.0),
  )
  let index = hkl(1, 2, -1).unwrap()
  let a = m.amplitude(index, [site(0.17, 0.22, 0.38, 2.0).unwrap()]).unwrap()
  let b = m
    .amplitude(index.opposite(), [site(0.17, 0.22, 0.38, 2.0).unwrap()])
    .unwrap()
  assert_true(near(a.real, b.real))
  assert_true(near(a.imag, -b.imag))
}

///|
test "global translation, occupancy and Debye-Waller conventions" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  let i = hkl(1, 0, 0).unwrap()
  let sites = [
    site(0.1, 0.2, 0.3, 2.0).unwrap(),
    site(0.3, 0.5, 0.8, -1.0).unwrap(),
  ]
  let shifted = sites.map(s => s.translated(0.173, 0.27, 0.91).unwrap())
  assert_true(
    near(
      m.amplitude(i, sites).unwrap().intensity(),
      m.amplitude(i, shifted).unwrap().intensity(),
    ),
  )
  let a = m
    .amplitude(i, [site(0.0, 0.0, 0.0, 2.0, occupancy=0.5, b_iso=4.0).unwrap()])
    .unwrap()
  assert_true(near(a.real, @math.exp(-1.0)))
  assert_true(near(m.amplitude(i, []).unwrap().intensity(), 0.0))
}
