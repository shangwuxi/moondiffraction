///|
/// Individual reciprocal reflection. Both Friedel partners are retained.
pub struct Reflection {
  index : Hkl
  d : Double
  intensity : Double
  angle : Double?
} derive(Debug)

///|
/// Simulate a complete bounded reciprocal sphere. Centering is a filter, NOT expansion.
pub fn Metric::simulate(
  self : Metric,
  sites : Array[Site],
  d_min : Double,
  wavelength : Double,
  centering? : Centering = Primitive,
  max_candidates? : Int = 200000,
  max_terms? : Int = 2000000,
) -> Result[Array[Reflection], Problem] {
  if !finite(wavelength) || wavelength <= 0.0 {
    return Err(Invalid("positive finite wavelength required"))
  }
  if sites.length() > 10000 || max_terms <= 0 || max_terms > 20000000 {
    return Err(Budget("invalid phase-sum work budget"))
  }
  let indices = match self.reflections(d_min, max_candidates~) {
    Ok(x) => x
    Err(e) => return Err(e)
  }
  let selected = indices.filter(i => centering.allows(i))
  if selected.length().to_int64() * sites.length().to_int64() >
    max_terms.to_int64() {
    return Err(Budget("phase-sum work exceeds budget"))
  }
  let out = []
  for i in selected {
    let d = self.spacing(i)
    let a = match self.amplitude(i, sites) {
      Ok(x) => x
      Err(e) => return Err(e)
    }
    let angle = match two_theta(d, wavelength) {
      Ok(x) => x
      Err(e) => return Err(e)
    }
    out.push({ index: i, d, intensity: a.intensity(), angle, })
  }
  Ok(out)
}
