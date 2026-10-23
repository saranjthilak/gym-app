@echo off
echo Starting API server on port 3000...
start "openGym API" cmd /k "cd api && npm start"

echo Starting Frontend Vite dev server...
start "openGym Frontend" cmd /k "cd frontend && npm run dev"

timeout /t 3 /nobreak >nul

echo Starting Cloudflare Public Internet Tunnel...
echo Look for the https://*.trycloudflare.com URL below:
echo ========================================================
.\cloudflared.exe tunnel --url http://localhost:5173
pause
