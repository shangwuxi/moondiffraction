///|
/// A deterministic numeric wire format consumed by the independent Python oracle.
fn main {
  let cells = [
    (2.0, 3.0, 4.0, 90.0, 90.0, 90.0),
    (3.1, 4.2, 5.3, 72.0, 81.0, 64.0),
    (2.5, 2.5, 6.0, 90.0, 90.0, 120.0),
    (5.0, 4.0, 3.0, 110.0, 95.0, 75.0),
  ]
  for n = 0; n < cells.length(); n = n + 1 {
    let c = cells[n]
    let m = @diff.reciprocal(c.0, c.1, c.2, c.3, c.4, c.5).unwrap()
    let sites = [
      @diff.site(0.13, 0.27, 0.39, 2.0, occupancy=0.8, b_iso=0.6).unwrap(),
      @diff.site(0.42, 0.18, 0.63, -1.0, occupancy=0.4, b_iso=1.1).unwrap(),
    ]
    for h = -2; h <= 2; h = h + 1 {
      for k = -2; k <= 2; k = k + 1 {
        for l = -2; l <= 2; l = l + 1 {
          if h == 0 && k == 0 && l == 0 {
            continue
          }
          let i = @diff.hkl(h, k, l).unwrap()
          let f = m.amplitude(i, sites).unwrap()
          println("\{n},\{h},\{k},\{l},\{m.q2(i)},\{f.real},\{f.imag}")
        }
      }
    }
  }
}
