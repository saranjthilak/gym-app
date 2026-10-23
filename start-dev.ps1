# Start both backend and frontend servers
$root = $PSScriptRoot
Write-Host "Starting API server on port 3000..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$root/api'; npm start"

Write-Host "Starting Frontend Vite dev server..." -ForegroundColor Green
Start-Process powershell -ArgumentList "-NoExit", "-Command", "cd '$root/frontend'; npm run dev"
