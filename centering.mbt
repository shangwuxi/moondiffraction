///|
/// Translational centering only, not a full space-group absence predictor.
pub(all) enum Centering {
  Primitive
  Body
  Face
  AFace
  BFace
  CFace
  RhombohedralHex
} derive(Eq, Debug)

///|
pub fn Centering::allows(self : Centering, i : Hkl) -> Bool {
  match self {
    Primitive => true
    Body => (i.h + i.k + i.l) % 2 == 0
    Face => (i.h - i.k) % 2 == 0 && (i.k - i.l) % 2 == 0
    AFace => (i.k + i.l) % 2 == 0
    BFace => (i.h + i.l) % 2 == 0
    CFace => (i.h + i.k) % 2 == 0
    RhombohedralHex => (-i.h + i.k + i.l) % 3 == 0
  }
}

///|
/// Fractional translations in conventional cell; R uses obverse hexagonal setting.
pub fn Centering::translations(
  self : Centering,
) -> Array[(Double, Double, Double)] {
  match self {
    Primitive => [(0.0, 0.0, 0.0)]
    Body => [(0.0, 0.0, 0.0), (0.5, 0.5, 0.5)]
    Face => [(0.0, 0.0, 0.0), (0.0, 0.5, 0.5), (0.5, 0.0, 0.5), (0.5, 0.5, 0.0)]
    AFace => [(0.0, 0.0, 0.0), (0.0, 0.5, 0.5)]
    BFace => [(0.0, 0.0, 0.0), (0.5, 0.0, 0.5)]
    CFace => [(0.0, 0.0, 0.0), (0.5, 0.5, 0.0)]
    RhombohedralHex =>
      [
        (0.0, 0.0, 0.0),
        (2.0 / 3.0, 1.0 / 3.0, 1.0 / 3.0),
        (1.0 / 3.0, 2.0 / 3.0, 2.0 / 3.0),
      ]
  }
}
