@echo off
setlocal
REM ClawTelemetry installer for Windows (CMD)
REM Uses the PowerShell installer to keep one canonical implementation.
REM Usage: curl -fsSL https://raw.githubusercontent.com/plgonzalezrx8/clawtelemetry/main/install.cmd -o install.cmd && install.cmd && del install.cmd

echo.
echo   ClawTelemetry Installer

echo   Delegating install to PowerShell script...
if exist "%~dp0install.ps1" (
  powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0install.ps1"
) else (
  powershell -NoProfile -ExecutionPolicy Bypass -Command "irm https://raw.githubusercontent.com/plgonzalezrx8/clawtelemetry/main/install.ps1 | iex"
)

if %ERRORLEVEL% NEQ 0 (
  echo.
  echo   Installation failed.
  exit /b 1
)

echo.
echo   Installation complete. Run: clawtelemetry --version
endlocal
