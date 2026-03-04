@echo off
REM ClawTelemetry installer for Windows (CMD)
REM Uses the PowerShell installer to keep one canonical implementation.
REM PATH verification happens in CI after install using LOCALAPPDATA\\clawtelemetry\\Scripts.
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

REM PowerShell child processes do not propagate PATH updates back to CMD.
REM Prepend the expected Scripts directory so clawtelemetry resolves now.
set "CLAWTELEMETRY_SCRIPTS=%LOCALAPPDATA%\clawtelemetry\Scripts"
if exist "%CLAWTELEMETRY_SCRIPTS%\clawtelemetry.exe" (
  set "PATH=%CLAWTELEMETRY_SCRIPTS%;%PATH%"
)

echo.
echo   Installation complete. Run: clawtelemetry --version
