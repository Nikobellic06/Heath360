###############################################################################
#  Health360 — Stop All Services
#  Stops all Node.js and Python processes started by start_all.ps1
###############################################################################

Write-Host ""
Write-Host "  Stopping all Health360 services..." -ForegroundColor Yellow

$nodeProcs   = Get-Process node   -ErrorAction SilentlyContinue
$pythonProcs = Get-Process python -ErrorAction SilentlyContinue

if ($nodeProcs) {
    $nodeProcs | Stop-Process -Force
    Write-Host "  [OK] Stopped $($nodeProcs.Count) Node.js process(es)" -ForegroundColor Green
} else {
    Write-Host "  [--] No Node.js processes found" -ForegroundColor DarkGray
}

if ($pythonProcs) {
    $pythonProcs | Stop-Process -Force
    Write-Host "  [OK] Stopped $($pythonProcs.Count) Python process(es)" -ForegroundColor Green
} else {
    Write-Host "  [--] No Python processes found" -ForegroundColor DarkGray
}

Write-Host ""
Write-Host "  All services stopped." -ForegroundColor Cyan
Write-Host ""
