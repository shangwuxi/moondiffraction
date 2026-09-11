///|
/// Reciprocal plane angle; signed hkl retains angle in [0,180].
pub fn Metric::plane_angle(self : Metric, x : Hkl, y : Hkl) -> Double {
  let hx = x.h.to_double()
  let kx = x.k.to_double()
  let lx = x.l.to_double()
  let hy = y.h.to_double()
  let ky = y.k.to_double()
  let ly = y.l.to_double()
  let dot = self.aa * hx * hy +
    self.bb * kx * ky +
    self.cc * lx * ly +
    self.ab * (hx * ky + kx * hy) +
    self.ac * (hx * ly + lx * hy) +
    self.bc * (kx * ly + lx * ky)
  let raw = dot / (self.q2(x).sqrt() * self.q2(y).sqrt())
  let clamped = if raw > 1.0 { 1.0 } else if raw < -1.0 { -1.0 } else { raw }
  @math.acos(clamped) * 180.0 / @math.PI
}

///|
/// Zone law h*u+k*v+l*w = 0. Direction is a nonzero bounded integer triple.
pub fn in_zone(index : Hkl, u : Int, v : Int, w : Int) -> Result[Bool, Problem] {
  let direction = match hkl(u, v, w) {
    Ok(x) => x
    Err(e) => return Err(e)
  }
  Ok(index.h * direction.h + index.k * direction.k + index.l * direction.l == 0)
}

///|
/// Zone-filter a complete finite reflection sphere.
pub fn Metric::zone(
  self : Metric,
  d_min : Double,
  u : Int,
  v : Int,
  w : Int,
  max_candidates? : Int = 200000,
) -> Result[Array[Hkl], Problem] {
  let direction = match hkl(u, v, w) {
    Ok(x) => x
    Err(e) => return Err(e)
  }
  let indices = match self.reflections(d_min, max_candidates~) {
    Ok(x) => x
    Err(e) => return Err(e)
  }
  Ok(
    indices.filter(i => {
      i.h * direction.h + i.k * direction.k + i.l * direction.l == 0
    }),
  )
}
