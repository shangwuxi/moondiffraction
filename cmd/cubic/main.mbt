///|
/// Teaching tool: a=3A cubic cell -> d(122)=1A -> 2theta=60deg at lambda=1A.
fn main {
  let metric = @diff.reciprocal(3.0, 3.0, 3.0, 90.0, 90.0, 90.0).unwrap()
  let index = @diff.hkl(1, 2, 2).unwrap()
  let d = metric.spacing(index)
  let angle = @diff.two_theta(d, 1.0).unwrap().unwrap()
  guard (d - 1.0).abs() < 1.0e-10 && (angle - 60.0).abs() < 1.0e-9 else {
    abort("cubic acceptance failed")
  }
  let zone = metric.zone(2.9, 0, 0, 1).unwrap()
  guard zone.length() == 4 else { abort("zone acceptance failed") }
  println(
    "CUBIC: d(122)=1 angstrom; 2theta=60 degree; [001] zone has 4 first-shell reflections",
  )
}
