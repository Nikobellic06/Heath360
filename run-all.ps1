# run-all.ps1 - Start all Health360 services

$projectRoot = "c:/Users/prakh/Desktop/GIthub/Health360"
$python = "$projectRoot/.venv/Scripts/python.exe"

Write-Host "Starting all Health360 services..." -ForegroundColor Green

Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$projectRoot/Health360_ML'; `$env:ML_HOST='127.0.0.1'; `$env:ML_PORT='8000'; & '$python' -m app.main`""
Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$projectRoot/Health360_ml1'; `$env:FACE_HOST='127.0.0.1'; `$env:FACE_PORT='8001'; & '$python' main.py`""
Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$projectRoot/Health360_LLM'; & '$python' -m uvicorn app.main:app --host 127.0.0.1 --port 8003 --reload`""
Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$projectRoot/Health360_face'; & '$python' -m uvicorn main:app --host 127.0.0.1 --port 8004 --reload`""
Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$projectRoot/Health360_Portal/backend'; `$env:PORT='4000'; npm run dev`""
Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$projectRoot/Health360_UserApp/backend'; `$env:PORT='5000'; npm start`""
Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$projectRoot/Health360_UserApp'; npm start`""
Start-Process powershell -ArgumentList "-NoExit -Command `"cd '$projectRoot/Health360Mobile'; npx expo start --port 19006`""

Write-Host "All services started!" -ForegroundColor Green