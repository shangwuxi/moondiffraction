# Run from repository root. MOON_HOME/PATH may select an isolated toolchain.
param([switch]$Native)
$ErrorActionPreference='Stop'
function Checked([scriptblock]$Action) {
  & $Action
  if ($LASTEXITCODE -ne 0) { throw "Verification command failed: $Action" }
}
Checked { moon version --all }
Checked { moon fmt --check }
$targets=@('wasm-gc','wasm','js')
if ($Native) { $targets += 'native' }
foreach ($target in $targets) {
  Write-Output "=== $target ==="
  Checked { moon check --target $target --deny-warn }
  Checked { moon build --target $target --deny-warn }
  Checked { moon test --target $target --deny-warn }
  foreach ($example in @('cubic','extinction','powder')) {
    Checked { moon run "cmd/$example" --target $target }
  }
  Checked { python scripts/oracle.py $target }
}
if (-not $Native) { Checked { moon check --target native --deny-warn } }
Checked { moon info }
Checked { git diff --exit-code -- '*.mbti' }
