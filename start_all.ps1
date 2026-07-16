###############################################################################
#  Health360 — Start All Services
#  Run from the project root:  .\start_all.ps1
###############################################################################

$Root = Split-Path -Parent $MyInvocation.MyCommand.Path

Write-Host ""
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host "  |         Health360 - Starting All Services           |" -ForegroundColor Cyan
Write-Host "  ======================================================" -ForegroundColor Cyan
Write-Host ""

# ── Service definitions ─────────────────────────────────────────────────────
$services = @(
    @{ Name = "Portal Backend";     Dir = "Health360_Portal\backend";  Cmd = "npm run dev";                                                              Port = 4000; Color = "Green"      },
    @{ Name = "Portal Frontend";    Dir = "Health360_Portal\frontend"; Cmd = "npm run dev";                                                              Port = 5173; Color = "Blue"       },
    @{ Name = "UserApp Backend";    Dir = "Health360_UserApp\backend"; Cmd = "node server.js";                                                           Port = 5000; Color = "Yellow"     },
    @{ Name = "ML Summary";         Dir = "Health360_ml";              Cmd = "python -m uvicorn app.main:app --host 0.0.0.0 --port 8000 --reload";       Port = 8000; Color = "Magenta"    },
    @{ Name = "Face Login ML";      Dir = "Health360_ml1";             Cmd = "python -m uvicorn main:app --host 0.0.0.0 --port 8001 --reload";           Port = 8001; Color = "Red"        },
    @{ Name = "Face Recognition";   Dir = "Health360_face";            Cmd = "python -m uvicorn main:app --host 0.0.0.0 --port 8002 --reload";           Port = 8002; Color = "DarkYellow" },
    @{ Name = "LLM Service";        Dir = "Health360_LLM";             Cmd = "python -m uvicorn app.main:app --host 0.0.0.0 --port 8003 --reload";       Port = 8003; Color = "DarkCyan"   }
)

# ── Print port map ──────────────────────────────────────────────────────────
Write-Host "  Port Map:" -ForegroundColor White
Write-Host "  -------------------------------------------------" -ForegroundColor DarkGray
foreach ($svc in $services) {
    $line = "    {0,-25} -> localhost:{1}" -f $svc.Name, $svc.Port
    Write-Host $line -ForegroundColor $svc.Color
}
Write-Host "  -------------------------------------------------" -ForegroundColor DarkGray
Write-Host ""

# ── Launch each service in its own terminal window ──────────────────────────
foreach ($svc in $services) {
    $fullDir = Join-Path $Root $svc.Dir
    $svcName = $svc.Name
    $svcPort = $svc.Port
    $svcCmd  = $svc.Cmd

    if (-not (Test-Path $fullDir)) {
        Write-Host "  [SKIP] Directory not found: $fullDir" -ForegroundColor DarkGray
        continue
    }

    Write-Host "  [START] $svcName on port $svcPort ..." -ForegroundColor $svc.Color

    $cmdBlock = "Set-Location -LiteralPath '$fullDir'; " +
                "Write-Host ''; " +
                "Write-Host '  $svcName - port $svcPort' -ForegroundColor Cyan; " +
                "Write-Host '  Command: $svcCmd' -ForegroundColor DarkGray; " +
                "Write-Host ''; " +
                "$svcCmd"

    Start-Process powershell -ArgumentList "-NoExit", "-Command", $cmdBlock

    Start-Sleep -Milliseconds 500
}

Write-Host ""
Write-Host "  ======================================================" -ForegroundColor Green
Write-Host "  |    All services launched - check individual windows |" -ForegroundColor Green
Write-Host "  ======================================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Portal Frontend:  http://localhost:5173" -ForegroundColor Blue
Write-Host "  Portal Backend:   http://localhost:4000" -ForegroundColor Green
Write-Host "  UserApp Backend:  http://localhost:5000" -ForegroundColor Yellow
Write-Host "  ML Summary:       http://localhost:8000/health" -ForegroundColor Magenta
Write-Host "  Face Login ML:    http://localhost:8001/docs" -ForegroundColor Red
Write-Host "  Face Recognition: http://localhost:8002/docs" -ForegroundColor DarkYellow
Write-Host "  LLM Service:      http://localhost:8003" -ForegroundColor DarkCyan
Write-Host ""
Write-Host "  To stop all: close each window, or run .\stop_all.ps1" -ForegroundColor DarkGray
Write-Host ""
