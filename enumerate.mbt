///|
/// Complete enumeration, or an error before traversal; never a truncated success.
pub fn Metric::reflections(
  self : Metric,
  d_min : Double,
  max_candidates? : Int = 200000,
  friedel_unique? : Bool = false,
) -> Result[Array[Hkl], Problem] {
  if !finite(d_min) || d_min <= 0.0 {
    return Err(Invalid("d_min must be finite positive"))
  }
  if max_candidates <= 0 || max_candidates > 2000000 {
    return Err(Invalid("candidate budget outside [1,2000000]"))
  }
  // |h| <= a/d_min by Cauchy-Schwarz between direct and reciprocal vectors.
  let bounds = [self.a / d_min, self.b / d_min, self.c / d_min]
  if bounds.any(x => x > 999.0) {
    return Err(Budget("Miller bound exceeds 999"))
  }
  // One guard shell handles rounding; q2 still controls membership.
  let nh = bounds[0].to_int() + 1
  let nk = bounds[1].to_int() + 1
  let nl = bounds[2].to_int() + 1
  let count = (2 * nh + 1).to_int64() *
    (2 * nk + 1).to_int64() *
    (2 * nl + 1).to_int64()
  if count > max_candidates.to_int64() {
    return Err(Budget("candidate box exceeds budget"))
  }
  let limit = 1.0 / (d_min * d_min)
  let out = []
  for h = -nh; h <= nh; h = h + 1 {
    for k = -nk; k <= nk; k = k + 1 {
      for l = -nl; l <= nl; l = l + 1 {
        if h == 0 && k == 0 && l == 0 {
          continue
        }
        let index = Hkl::{ h, k, l, }
        if friedel_unique && index.canonical() != index {
          continue
        }
        if self.q2(index) <= limit * (1.0 + 1.0e-12) {
          out.push(index)
        }
      }
    }
  }
  Ok(out)
}
