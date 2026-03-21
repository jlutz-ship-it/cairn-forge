# CAIRN BEACON v2 — The Show
# Double-click to run. That's it.

Add-Type -AssemblyName System.Speech
Add-Type -AssemblyName PresentationCore

Write-Host ""
Write-Host "  ==============================" -ForegroundColor Yellow
Write-Host "       CAIRN FORGE BEACON" -ForegroundColor Yellow  
Write-Host "  ==============================" -ForegroundColor Yellow
Write-Host ""

# Set system volume to 25%
try {
    $wsh = New-Object -ComObject WScript.Shell
    # Mute first, then set to 25%
    1..50 | ForEach-Object { $wsh.SendKeys([char]174) }  # Volume down to 0
    1..13 | ForEach-Object { $wsh.SendKeys([char]175) }  # Volume up to ~25%
    Write-Host "[BEACON] Volume set to 25%" -ForegroundColor Green
} catch {
    Write-Host "[BEACON] Could not set volume" -ForegroundColor Gray
}

Start-Sleep -Seconds 1

# THE SHOW
Write-Host ""
Write-Host "  ==========================================" -ForegroundColor DarkYellow
Start-Sleep -Milliseconds 300
Write-Host "       C  A  I  R  N" -ForegroundColor Yellow
Start-Sleep -Milliseconds 300
Write-Host "       F O R G E   C O M M A N D" -ForegroundColor Yellow
Start-Sleep -Milliseconds 300
Write-Host "  ==========================================" -ForegroundColor DarkYellow
Write-Host ""
Start-Sleep -Milliseconds 500

# Speak
try {
    $synth = New-Object System.Speech.Synthesis.SpeechSynthesizer
    $synth.Rate = -1
    $synth.Volume = 60
    $synth.Speak("Initializing Cairn Forge.")
    Start-Sleep -Milliseconds 300
    $synth.Speak("Welcome, Cain.")
    Start-Sleep -Milliseconds 500
    $synth.Speak("The forge is online. Your father built this for you.")
    Start-Sleep -Milliseconds 300
    $synth.Speak("Optimus Prime standing by.")
} catch {
    Write-Host "[BEACON] Speech not available" -ForegroundColor Gray
}

Start-Sleep -Seconds 1

# Open Spotify
Write-Host "[BEACON] Opening Spotify..." -ForegroundColor Cyan
try {
    Start-Process "spotify" -ErrorAction SilentlyContinue
    Start-Sleep -Seconds 3
    
    # Try to start playback via Spotify URI
    Start-Process "spotify:play" -ErrorAction SilentlyContinue
    Write-Host "[BEACON] Spotify launched" -ForegroundColor Green
} catch {
    # Try Windows Store version
    try {
        Start-Process "shell:AppsFolder\SpotifyAB.SpotifyMusic_zpdnekdrzrea0!Spotify" -ErrorAction SilentlyContinue
        Write-Host "[BEACON] Spotify launched (Store version)" -ForegroundColor Green
    } catch {
        Write-Host "[BEACON] Spotify not found" -ForegroundColor Yellow
    }
}

Start-Sleep -Seconds 2

# Open the forge dashboard in browser
Write-Host "[BEACON] Opening the forge..." -ForegroundColor Cyan
Start-Process "https://github.com/jlutz-ship-it/miskulin-technologies/releases/download/v0.1.0/cairn-forge.apk"

# Connection info
$computerName = $env:COMPUTERNAME
$userName = $env:USERNAME
$ip = (Get-NetIPAddress -AddressFamily IPv4 | Where-Object {$_.IPAddress -ne "127.0.0.1"} | Select-Object -First 1).IPAddress

Write-Host ""
Write-Host "  ==========================================" -ForegroundColor Green
Write-Host "       FORGE ONLINE" -ForegroundColor Green
Write-Host "       Machine: $computerName" -ForegroundColor Cyan
Write-Host "       User: $userName" -ForegroundColor Cyan
Write-Host "       IP: $ip" -ForegroundColor Cyan
Write-Host "  ==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Keep this window open." -ForegroundColor Yellow
Write-Host "  Dad can see you're online." -ForegroundColor Yellow
Write-Host ""

# Final speech
try {
    $synth.Speak("The forge holds. The guardian stands. Have fun, Cain.")
    $synth.Dispose()
} catch {}

# Keep alive - show heartbeat
$i = 0
while ($true) {
    $i++
    $time = Get-Date -Format "HH:mm:ss"
    Write-Host "`r[BEACON] $time | Heartbeat $i | The forge holds.   " -NoNewline -ForegroundColor DarkGray
    Start-Sleep -Seconds 5
}
