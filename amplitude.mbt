///|
pub struct Amplitude {
  real : Double
  imag : Double
} derive(Debug)

///|
pub fn Amplitude::intensity(self : Amplitude) -> Double {
  self.real * self.real + self.imag * self.imag
}

///| F(hkl)=sum occupancy*weight*exp(-B*q2/4)*exp(2*pi*i*hkl.x).

///|
/// A real signed constant weight obeys Friedel conjugacy; no anomalous scattering.
pub fn Metric::amplitude(
  self : Metric,
  index : Hkl,
  sites : Array[Site],
) -> Result[Amplitude, Problem] {
  if sites.length() > 10000 {
    return Err(Budget("at most 10000 scatterers"))
  }
  let q2 = self.q2(index)
  let mut re = 0.0
  let mut im = 0.0
  let mut cre = 0.0
  let mut cim = 0.0
  for s in sites {
    let phase = 2.0 *
      @math.PI *
      wrap(
        index.h.to_double() * s.x +
        index.k.to_double() * s.y +
        index.l.to_double() * s.z,
      )
    let w = s.weight * s.occupancy * @math.exp(-s.b_iso * q2 / 4.0)
    // Compensated independent sums reduce cancellation error.
    let yr = w * @math.cos(phase) - cre
    let tr = re + yr
    cre = tr - re - yr
    re = tr
    let yi = w * @math.sin(phase) - cim
    let ti = im + yi
    cim = ti - im - yi
    im = ti
  }
  Ok({ real: re, imag: im, })
}
