///|
/// Accessible powder group; intensity SUMS members, multiplicity counts supplied reflections.
pub struct Peak {
  angle : Double
  intensity : Double
  members : Array[Hkl]
  width : Double
} derive(Debug)

///|
pub fn Peak::multiplicity(self : Peak) -> Int {
  self.members.length()
}

///| Stable grouping against first angle, not transitive chaining. Tolerance in degrees.

///|
/// Caller must supply one wavelength and each hkl once; duplicates are rejected.
pub fn powder(
  reflections : Array[Reflection],
  tolerance? : Double = 1.0e-7,
) -> Result[Array[Peak], Problem] {
  if !finite(tolerance) || tolerance < 0.0 || tolerance > 1.0 {
    return Err(Invalid("group tolerance outside [0,1] degree"))
  }
  if reflections.length() > 100000 {
    return Err(Budget("powder list exceeds 100000"))
  }
  let seen : Map[String, Bool] = Map([])
  let ordered = []
  for r in reflections {
    let key = "\{r.index.h},\{r.index.k},\{r.index.l}"
    if seen.contains(key) {
      return Err(Invalid("duplicate hkl in powder input"))
    }
    seen[key] = true
    match r.angle {
      Some(_) => ordered.push(r)
      None => ()
    }
  }
  ordered.sort_by((a, b) => a.angle.unwrap().compare(b.angle.unwrap()))
  let peaks = []
  let mut start = 0
  while start < ordered.length() {
    let anchor = ordered[start].angle.unwrap()
    let members = []
    let mut intensity = 0.0
    let mut end = start
    let mut last = anchor
    while end < ordered.length() &&
          ordered[end].angle.unwrap() - anchor <= tolerance {
      let r = ordered[end]
      members.push(r.index)
      intensity = intensity + r.intensity
      last = r.angle.unwrap()
      end = end + 1
    }
    peaks.push(Peak::{
      angle: anchor,
      intensity,
      members,
      width: last - anchor,
    })
    start = end
  }
  Ok(peaks)
}
