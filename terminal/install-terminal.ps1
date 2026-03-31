# ============================================
#  BATTLE STATION — Windows Terminal Installer
#  Right-click > Run with PowerShell
# ============================================

Write-Host ""
Write-Host "  BATTLE STATION — Terminal Setup" -ForegroundColor Yellow
Write-Host "  ================================" -ForegroundColor DarkYellow
Write-Host ""

# 1. Check for Windows Terminal
$wtSettingsDir = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
$wtSettingsPath = Join-Path $wtSettingsDir "settings.json"
$forgeSettings = Join-Path $PSScriptRoot "windows-terminal-settings.json"

if (Test-Path $wtSettingsDir) {
    # Back up existing settings
    if (Test-Path $wtSettingsPath) {
        $backup = "$wtSettingsPath.backup.$(Get-Date -Format 'yyyyMMdd-HHmmss')"
        Copy-Item $wtSettingsPath $backup -Force
        Write-Host "  [+] Backed up existing settings:" -ForegroundColor Cyan
        Write-Host "      $backup" -ForegroundColor DarkCyan
    }

    if (Test-Path $forgeSettings) {
        Copy-Item $forgeSettings $wtSettingsPath -Force
        Write-Host "  [+] Installed Battle Station terminal theme" -ForegroundColor Green
    } else {
        Write-Host "  [!] windows-terminal-settings.json not found next to this script" -ForegroundColor Red
    }
} else {
    Write-Host "  [!] Windows Terminal not detected." -ForegroundColor Yellow
    Write-Host "      Install from Microsoft Store:" -ForegroundColor Yellow
    Write-Host "      ms-windows-store://pdp/?productid=9N0DX20HK701" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "      After installing, re-run this script." -ForegroundColor Yellow
}

# 2. Install Cascadia Code font check
$cascadia = Get-ChildItem -Path "$env:LOCALAPPDATA\Microsoft\Windows\Fonts" -Filter "CascadiaCode*" -ErrorAction SilentlyContinue
$cascadiaSys = Get-ChildItem -Path "C:\Windows\Fonts" -Filter "CascadiaCode*" -ErrorAction SilentlyContinue
if ($cascadia -or $cascadiaSys) {
    Write-Host "  [=] Cascadia Code font already installed" -ForegroundColor Gray
} else {
    Write-Host "  [!] Cascadia Code font not found." -ForegroundColor Yellow
    Write-Host "      It ships with Windows Terminal, but if missing:" -ForegroundColor Yellow
    Write-Host "      https://github.com/microsoft/cascadia-code/releases" -ForegroundColor Cyan
}

# 3. Set execution policy
try {
    Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned -Force
    Write-Host "  [+] Execution policy: RemoteSigned" -ForegroundColor Green
} catch {
    Write-Host "  [!] Could not set execution policy (may need admin)" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "  ================================" -ForegroundColor DarkYellow
Write-Host "  Done. Open Windows Terminal to see the new theme." -ForegroundColor Green
Write-Host ""

Read-Host "  Press Enter to close"
