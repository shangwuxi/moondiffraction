///|
/// Fractional point scatterer. Weight is user-supplied constant, not an element table.
pub struct Site {
  x : Double
  y : Double
  z : Double
  weight : Double
  occupancy : Double
  b_iso : Double
} derive(Debug)

///|
fn wrap(x : Double) -> Double {
  x - @math.floor(x)
}

///|
pub fn site(
  x : Double,
  y : Double,
  z : Double,
  weight : Double,
  occupancy? : Double = 1.0,
  b_iso? : Double = 0.0,
) -> Result[Site, Problem] {
  for v in [x, y, z] {
    if !finite(v) || v.abs() > 1.0e6 {
      return Err(Invalid("fractional coordinate outside +/-1e6"))
    }
  }
  if !finite(weight) || weight.abs() > 1.0e6 {
    return Err(Invalid("constant weight outside +/-1e6"))
  }
  if !finite(occupancy) || occupancy < 0.0 || occupancy > 1.0 {
    return Err(Invalid("occupancy outside [0,1]"))
  }
  if !finite(b_iso) || b_iso < 0.0 || b_iso > 1.0e6 {
    return Err(Invalid("B_iso outside [0,1e6] square angstrom"))
  }
  Ok({ x: wrap(x), y: wrap(y), z: wrap(z), weight, occupancy, b_iso, })
}

///|
/// A global fractional translation preserves intensities, not complex phase.
pub fn Site::translated(
  self : Site,
  dx : Double,
  dy : Double,
  dz : Double,
) -> Result[Site, Problem] {
  site(
    self.x + dx,
    self.y + dy,
    self.z + dz,
    self.weight,
    occupancy=self.occupancy,
    b_iso=self.b_iso,
  )
}
