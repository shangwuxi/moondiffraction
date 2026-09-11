///|
/// Common typed failures; numerical inputs never silently clamp invalid cells.
pub(all) enum Problem {
  Invalid(String)
  Budget(String)
} derive(Eq, Debug)

///|
/// Reciprocal metric in inverse square angstroms (no 2*pi factor).
pub struct Metric {
  aa : Double
  bb : Double
  cc : Double
  ab : Double
  ac : Double
  bc : Double
  a : Double
  b : Double
  c : Double
} derive(Debug)

///|
fn finite(x : Double) -> Bool {
  x == x && x.abs() < 1.0e300
}

///|
/// Positive lengths in angstroms; angles in degrees. Reject ill-conditioned cells.
pub fn reciprocal(
  a : Double,
  b : Double,
  c : Double,
  alpha : Double,
  beta : Double,
  gamma : Double,
) -> Result[Metric, Problem] {
  for x in [a, b, c] {
    if !finite(x) || x < 1.0e-6 || x > 1.0e6 {
      return Err(Invalid("length outside [1e-6,1e6] angstrom"))
    }
  }
  for x in [alpha, beta, gamma] {
    if !finite(x) || x <= 0.0 || x >= 180.0 {
      return Err(Invalid("angle outside (0,180) degrees"))
    }
  }
  let ca = @math.cos(alpha * @math.PI / 180.0)
  let cb = @math.cos(beta * @math.PI / 180.0)
  let cg = @math.cos(gamma * @math.PI / 180.0)
  let det = 1.0 + 2.0 * ca * cb * cg - ca * ca - cb * cb - cg * cg
  if det <= 1.0e-10 {
    return Err(Invalid("singular or ill-conditioned cell"))
  }
  Ok({
    aa: (1.0 - ca * ca) / (a * a * det),
    bb: (1.0 - cb * cb) / (b * b * det),
    cc: (1.0 - cg * cg) / (c * c * det),
    ab: (cb * ca - cg) / (a * b * det),
    ac: (cg * ca - cb) / (a * c * det),
    bc: (cg * cb - ca) / (b * c * det),
    a,
    b,
    c,
  })
}
