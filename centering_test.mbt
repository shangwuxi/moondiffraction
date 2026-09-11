///|
test "all centering rules agree with explicit phase sums including negatives" {
  let m = reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  for
    center in [
      Centering::Primitive,
      Body,
      Face,
      AFace,
      BFace,
      CFace,
      RhombohedralHex,
    ] {
    let sites = center
      .translations()
      .map(t => site(t.0, t.1, t.2, 1.0).unwrap())
    for h = -3; h <= 3; h = h + 1 {
      for k = -3; k <= 3; k = k + 1 {
        for l = -3; l <= 3; l = l + 1 {
          if h == 0 && k == 0 && l == 0 {
            continue
          }
          let i = hkl(h, k, l).unwrap()
          let intensity = m.amplitude(i, sites).unwrap().intensity()
          assert_eq(center.allows(i), intensity > 0.5)
        }
      }
    }
  }
}
