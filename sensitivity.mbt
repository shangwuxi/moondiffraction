///| Derivatives of intensity w.r.t. one site's fractional coordinates, occupancy,

///|
/// constant weight and B_iso. This is local sensitivity, NOT structure refinement.
pub struct Sensitivity {
  dx : Double
  dy : Double
  dz : Double
  occupancy : Double
  weight : Double
  b_iso : Double
} derive(Debug)

///|
pub fn Metric::sensitivity(
  self : Metric,
  index : Hkl,
  sites : Array[Site],
  selected : Int,
) -> Result[Sensitivity, Problem] {
  if selected < 0 || selected >= sites.length() {
    return Err(Invalid("selected site out of range"))
  }
  let a = match self.amplitude(index, sites) {
    Ok(x) => x
    Err(e) => return Err(e)
  }
  let s = sites[selected]
  let q2 = self.q2(index)
  let phase = 2.0 *
    @math.PI *
    wrap(
      index.h.to_double() * s.x +
      index.k.to_double() * s.y +
      index.l.to_double() * s.z,
    )
  let atten = @math.exp(-s.b_iso * q2 / 4.0)
  let co = @math.cos(phase)
  let si = @math.sin(phase)
  let projection = 2.0 * atten * (a.real * co + a.imag * si)
  let rotation = 4.0 *
    @math.PI *
    atten *
    s.weight *
    s.occupancy *
    (-a.real * si + a.imag * co)
  Ok({
    dx: rotation * index.h.to_double(),
    dy: rotation * index.k.to_double(),
    dz: rotation * index.l.to_double(),
    occupancy: projection * s.weight,
    weight: projection * s.occupancy,
    b_iso: -projection * s.weight * s.occupancy * q2 / 4.0,
  })
}
