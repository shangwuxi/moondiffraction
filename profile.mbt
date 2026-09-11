///|
/// Uniform 2theta grid, density per degree; finite window is not renormalized.
pub struct Profile {
  start : Double
  step : Double
  values : Array[Double]
} derive(Debug)

///|
/// Gaussian lines with unit continuous area. Requires >=4 samples per sigma.
pub fn gaussian_profile(
  peaks : Array[Peak],
  start : Double,
  end : Double,
  samples : Int,
  sigma : Double,
  max_terms? : Int = 2000000,
) -> Result[Profile, Problem] {
  if !finite(start) ||
    !finite(end) ||
    start < 0.0 ||
    end > 180.0 ||
    end <= start ||
    samples < 2 ||
    samples > 100000 {
    return Err(Invalid("invalid 2theta grid"))
  }
  if !finite(sigma) || sigma <= 0.0 || sigma > 180.0 {
    return Err(Invalid("invalid Gaussian sigma"))
  }
  let step = (end - start) / (samples - 1).to_double()
  if step > sigma / 4.0 {
    return Err(Invalid("grid undersamples Gaussian: step > sigma/4"))
  }
  if max_terms <= 0 ||
    max_terms > 20000000 ||
    samples.to_int64() * peaks.length().to_int64() > max_terms.to_int64() {
    return Err(Budget("profile work exceeds budget"))
  }
  let values = Array::make(samples, 0.0)
  let norm = 1.0 / (sigma * (2.0 * @math.PI).sqrt())
  for n = 0; n < samples; n = n + 1 {
    let angle = start + n.to_double() * step
    let mut sum = 0.0
    for p in peaks {
      let z = (angle - p.angle) / sigma
      sum = sum + p.intensity * norm * @math.exp(-0.5 * z * z)
    }
    values[n] = sum
  }
  Ok({ start, step, values, })
}

///|
/// Trapezoidal integral over the sampled window only.
pub fn Profile::area(self : Profile) -> Double {
  let mut sum = 0.0
  for n = 1; n < self.values.length(); n = n + 1 {
    sum = sum + (self.values[n - 1] + self.values[n]) * 0.5 * self.step
  }
  sum
}
