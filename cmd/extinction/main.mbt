///|
/// Teaching simulation: explicitly sum centered point scatterers, not rule-only output.
fn main {
  let metric = @diff.reciprocal(1.0, 1.0, 1.0, 90.0, 90.0, 90.0).unwrap()
  for center in [@diff.Centering::Body, Face] {
    let sites = center
      .translations()
      .map(t => @diff.site(t.0, t.1, t.2, 1.0).unwrap())
    let all = metric.simulate(sites, 0.55, 1.0).unwrap()
    let mut extinct = 0
    for r in all {
      let absent = r.intensity < 1.0e-18
      guard absent != center.allows(r.index) else {
        abort("centering acceptance failed")
      }
      if absent {
        extinct = extinct + 1
      }
    }
    println(
      "Centered lattice: checked \{all.length()} signed reflections; \{extinct} extinct",
    )
  }
  println("EXTINCTION: direct phase sums agree with BCC/FCC translation rules")
}
