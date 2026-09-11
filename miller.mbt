///|
/// Integer plane indices, bounded to avoid overflow in combinatorial operations.
pub struct Hkl {
  h : Int
  k : Int
  l : Int
} derive(Eq, Debug)

///|
pub fn hkl(h : Int, k : Int, l : Int) -> Result[Hkl, Problem] {
  if h < -1000 || h > 1000 || k < -1000 || k > 1000 || l < -1000 || l > 1000 {
    return Err(Invalid("Miller index outside [-1000,1000]"))
  }
  if h == 0 && k == 0 && l == 0 {
    return Err(Invalid("origin is not a reflection"))
  }
  Ok({ h, k, l, })
}

///|
pub fn Hkl::opposite(self : Hkl) -> Hkl {
  { h: -self.h, k: -self.k, l: -self.l, }
}

///|
/// Select one of a Friedel pair without changing index magnitude.
pub fn Hkl::canonical(self : Hkl) -> Hkl {
  if self.h < 0 ||
    (self.h == 0 && self.k < 0) ||
    (self.h == 0 && self.k == 0 && self.l < 0) {
    self.opposite()
  } else {
    self
  }
}

///|
/// Squared reciprocal length, 1/d^2; NOT (2*pi/d)^2.
pub fn Metric::q2(self : Metric, index : Hkl) -> Double {
  let h = index.h.to_double()
  let k = index.k.to_double()
  let l = index.l.to_double()
  self.aa * h * h +
  self.bb * k * k +
  self.cc * l * l +
  2.0 * (self.ab * h * k + self.ac * h * l + self.bc * k * l)
}

///|
pub fn Metric::spacing(self : Metric, index : Hkl) -> Double {
  1.0 / self.q2(index).sqrt()
}
