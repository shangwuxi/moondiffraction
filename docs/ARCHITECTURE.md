# Architecture and numerical contract

## Computational boundary

This library consumes a cell already parsed elsewhere. Direct space metadata/CIF belongs upstream. We implement a reciprocal-space computation, not a crystal object editor. Only standard MoonBit math is a runtime dependency.

1. `reciprocal`: normalize direct Gram to a dimensionless cosine matrix; validate its determinant; compute six inverse-metric coefficients without large determinant scaling. Lengths in [1e-6,1e6] A and positive angles below 180 degrees; normalized determinant must exceed 1e-10.
2. `hkl`: nonzero indices in [-1000,1000]. `q2=h^T G^-1 h`, spacing=1/sqrt(q2).
3. `reflections`: Cauchy-Schwarz yields |h|≤a/dmin, etc. One integer guard shell absorbs rounded division; final membership q2≤(1+1e-12)/dmin². Preflight Int64 candidate product prevents integer overflow or partial success. Bounds >999 reject before integer conversion. Default box budget 200k; hard cap 2m.
4. `amplitude`: at most 10k validated fractional sites. Wrap positions into [0,1), wrap phase, attenuate by exp(-B q2/4), and Kahan-sum real/imag independently. Zero sites gives zero amplitude. Sensitivity differentiates the same model without dividing by weight or occupancy.
5. `simulate`: enumerate, filter centering, preflight selected reflections × sites (default 2m/hard 20m), compute amplitudes and optional accessible Bragg angles. No silent intensity threshold.
6. `powder`: bounded list (100k), unique hkl, exactly same wavelength, sort angle then h/k/l. Group against first angle, retain min-angle anchor and span; sum each supplied reflection once. Equal-angle order canonicalized for deterministic sums.
7. Gaussian: O(samples × peaks), default 2m/hard20m terms; ≤100k samples. Unit continuous area, no window renormalization. `area` trapezoid approximates captured window, not total physical intensity. Matching is O(observations × groups) with independent pair budget and explicit all-candidate results.

## Failure and ownership

Public constructors validate their scalar arguments. Result error variants distinguish invalid domain from budget rejection; messages describe the cause, but exact message strings are not a versioned diagnostic protocol. Array outputs are caller-owned mutable objects, not deep immutable snapshots. No file/network I/O in library code; numeric-only exporters do not accept arbitrary labels.

The hard numerical ranges are engineering limits, not scientifically universal thresholds. Ill-conditioned triclinic cells outside the range are rejected, not repaired. Integer zone products cannot overflow because bounded components are ≤1000. Reciprocal squared norms remain within Double dynamic range under accepted input ranges; small cancellation error near an extinction is expected.

## Validation strategy

- External black-box MoonBit tests of constructors/workflows and targeted white-box grouping test.
- 7 centerings ×342 signed hkl =2394 independent integer-rule/direct-sum comparisons.
- Cubic integer shells; scale and Friedel/translation invariants; finite difference derivatives.
- Python oracle builds direct Cartesian basis and cross-product reciprocal basis, versus production inverse metric; complex exponential sum versus production scalar trigonometry. Four cells ×124 nonzero hkl =496 cases, tolerance 1e-10 absolute/relative.
- 3 executable workflow assertions are distinct from unit tests. CI executes all three on each target.

## Physical non-goals

No CIF parsing, automatic symmetry operations, element-specific form factors, anomalous scattering, texture/Lorentz/polarization factors, detector geometry, background, calibration, Rietveld refinement, phase identification, experimental accuracy certification, or FFT acceleration. Constant scattering weights are deliberately supplied by the caller.
