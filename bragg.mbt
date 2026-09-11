///|
/// First-order Bragg 2theta in degrees; None means inaccessible at this wavelength.
pub fn two_theta(d : Double, wavelength : Double) -> Result[Double?, Problem] {
  if !finite(d) || d <= 0.0 || !finite(wavelength) || wavelength <= 0.0 {
    return Err(Invalid("positive finite spacing and wavelength required"))
  }
  let ratio = wavelength / d / 2.0
  if ratio > 1.0 {
    return Ok(None)
  }
  Ok(Some(2.0 * @math.asin(ratio) * 180.0 / @math.PI))
}

///|
/// Inverse first-order Bragg relation; excludes forward direction.
pub fn spacing_from_angle(
  angle : Double,
  wavelength : Double,
) -> Result[Double, Problem] {
  if !finite(angle) ||
    angle <= 0.0 ||
    angle > 180.0 ||
    !finite(wavelength) ||
    wavelength <= 0.0 {
    return Err(Invalid("2theta in (0,180], positive wavelength required"))
  }
  let d = wavelength / (2.0 * @math.sin(angle * @math.PI / 360.0))
  if !finite(d) || d <= 0.0 {
    return Err(Invalid("spacing outside numerical range"))
  }
  Ok(d)
}
