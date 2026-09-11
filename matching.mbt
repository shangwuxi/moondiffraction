///|
/// All compatible simulated groups for one observed angle; no forced assignment.
pub struct PeakMatch {
  observed : Double
  candidates : Array[Int]
  residuals : Array[Double]
} derive(Debug)

///|
/// Independent bounded matching. Ambiguities and unmatched observations remain visible.
pub fn match_peaks(
  observed : Array[Double],
  peaks : Array[Peak],
  tolerance : Double,
  max_pairs? : Int = 2000000,
) -> Result[Array[PeakMatch], Problem] {
  if !finite(tolerance) || tolerance < 0.0 || tolerance > 10.0 {
    return Err(Invalid("matching tolerance outside [0,10] degrees"))
  }
  if observed.length() > 100000 ||
    max_pairs <= 0 ||
    max_pairs > 20000000 ||
    observed.length().to_int64() * peaks.length().to_int64() >
    max_pairs.to_int64() {
    return Err(Budget("matching pair budget exceeded"))
  }
  for x in observed {
    if !finite(x) || x < 0.0 || x > 180.0 {
      return Err(Invalid("observation outside [0,180] degrees"))
    }
  }
  let out = []
  for x in observed {
    let candidates = []
    let residuals = []
    for n = 0; n < peaks.length(); n = n + 1 {
      let delta = x - peaks[n].angle
      if delta.abs() <= tolerance {
        candidates.push(n)
        residuals.push(delta)
      }
    }
    out.push({ observed: x, candidates, residuals, })
  }
  Ok(out)
}
