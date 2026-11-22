@echo off
setlocal
cd /d "%~dp0"
echo Tai MicroPython v1.29.0 (ESP32-S3 SPIRAM_OCT) tu micropython.org...
powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "$ErrorActionPreference='Stop'; $u='https://micropython.org/resources/firmware/ESP32_GENERIC_S3-SPIRAM_OCT-20260824-v1.29.0.bin'; Invoke-WebRequest -Uri $u -OutFile 'firmware.bin'; if ((Get-Item 'firmware.bin').Length -lt 200000) { throw 'Firmware qua nho, download co the hong' }; Write-Host 'OK: firmware.bin'"
if errorlevel 1 (
  echo Khong tai duoc firmware. Hay tai thu cong tu https://micropython.org/download/ESP32_GENERIC_S3/
  pause
  exit /b 1
)
echo Hoan thanh. Bay gio tai thu muc len website HTTPS.
pause
