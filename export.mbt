///|
/// Numeric CSV only, no free-text labels and no user formula cells.
pub fn reflections_csv(
  reflections : Array[Reflection],
) -> Result[String, Problem] {
  if reflections.length() > 100000 {
    return Err(Budget("CSV reflection count exceeds 100000"))
  }
  let lines = ["h,k,l,d_angstrom,intensity,two_theta_degree"]
  for r in reflections {
    let angle = match r.angle {
      Some(x) => x.to_string()
      None => ""
    }
    lines.push(
      "\{r.index.h},\{r.index.k},\{r.index.l},\{r.d},\{r.intensity},\{angle}",
    )
  }
  Ok(lines.join("\n") + "\n")
}

///|
/// Versioned structured output; null angles explicitly mark inaccessible reflections.
pub fn reflections_json(
  reflections : Array[Reflection],
) -> Result[Json, Problem] {
  if reflections.length() > 100000 {
    return Err(Budget("JSON reflection count exceeds 100000"))
  }
  let rows : Array[Json] = reflections.map(r => {
    let angle : Json = match r.angle {
      Some(x) => x.to_json()
      None => Json::null()
    }
    {
      "h": r.index.h,
      "k": r.index.k,
      "l": r.index.l,
      "d_angstrom": r.d,
      "intensity": r.intensity,
      "wavelength_angstrom": r.wavelength,
      "two_theta_degree": angle,
    }
  })
  Ok({
    "format": "moondiffraction.reflections.v1",
    "q_convention": "1/d; no 2pi",
    "model": "real constant scatterers",
    "reflections": rows,
  })
}

///|
/// Profile density per degree, not counts per bin.
pub fn Profile::csv(self : Profile) -> String {
  let lines = ["two_theta_degree,intensity_per_degree"]
  for n = 0; n < self.values.length(); n = n + 1 {
    let angle = self.start + n.to_double() * self.step
    lines.push("\{angle},\{self.values[n]}")
  }
  lines.join("\n") + "\n"
}
