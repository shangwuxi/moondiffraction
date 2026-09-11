///|
/// Prototype developer: triclinic points -> complete list -> powder groups -> sampled density.
fn main {
  let metric = @diff.reciprocal(3.1, 4.2, 5.3, 72.0, 81.0, 64.0).unwrap()
  let sites = [
    @diff.site(0.13, 0.27, 0.39, 2.0, occupancy=0.8, b_iso=0.6).unwrap(),
    @diff.site(0.42, 0.18, 0.63, -1.0).unwrap(),
  ]
  let reflections = metric.simulate(sites, 1.5, 1.0).unwrap()
  let groups = @diff.powder(reflections).unwrap()
  let profile = @diff.gaussian_profile(groups, 0.0, 180.0, 7201, 0.15).unwrap()
  let mut expected = 0.0
  for p in groups {
    expected = expected + p.intensity
  }
  guard (profile.area() - expected).abs() < 1.0e-7 * (1.0 + expected) else {
    abort("powder area acceptance failed")
  }
  let observations = [groups[0].angle + 0.01, 179.0]
  let matches = @diff.match_peaks(observations, groups, 0.02).unwrap()
  guard matches[0].candidates.contains(0) && matches[1].candidates.is_empty() else {
    abort("matching acceptance failed")
  }
  println(
    "POWDER: \{reflections.length()} reflections; \{groups.length()} groups; 7201 density samples; integrated area verified",
  )
  println(
    "MATCH: first synthetic observation matched; 179-degree observation remains unmatched",
  )
  println(@diff.reflections_csv(reflections).unwrap())
}
