# Dependencies and references

## Runtime/build

- MoonBit standard library `moonbitlang/core`, Apache-2.0 with its upstream notices: https://github.com/moonbitlang/core . Only core math is explicitly imported; no vendored core code.
- Python standard library is used only by an independent development oracle. Not a runtime library dependency.
- GitHub Actions checkout and official MoonBit installation are build infrastructure, not copied project implementation.

## Non-code references (not ports)

- Gemmi scattering documentation: https://gemmi.readthedocs.io/en/stable/scattering.html . Reviewed definitions of direct summation, occupancy/ADP and distinctions from real atomic form factors. Gemmi source is MPL-2.0, https://github.com/project-gemmi/gemmi ; no code, scattering tables or fixtures copied, no Gemmi runtime dependency.
- IvanAXu/BioSeqs 0.1.9, Apache-2.0, https://github.com/paipai-Studio/BioSeqs . Source inspected for duplication boundary and public scalar fields. No code copied, no claim of a compiled integration. See docs/UPSTREAM.md.
- Reciprocal Gram inversion, Cauchy-Schwarz, Bragg relation, finite Fourier phase sums and Gaussian normalization are mathematical definitions. MoonBit implementation and independent Cartesian oracle were written for this project. We do not claim to have invented diffraction mathematics.

Search-result metadata is preserved as evidence with source URLs; metadata-only fuzzy neighbors are not implied dependencies or source audits. No third-party source or full README is bundled in evidence.
