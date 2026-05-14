:: WinCustomizer is an advanced Batch script designed to automate the maintenance and personalization of Windows environments.

@echo off

:menu
cls
echo ======================================================
echo                    WinCustomizer
echo ======================================================
echo [1] MANUTENZIONE SISTEMA (SFC, DISM, Pulizia Disco)
echo [2] PRIVACY & TELEMETRIA (Disabilita tracking)
echo [3] PERSONALIZZAZIONE UI (Menu Start, Taskbar, Context Menu)
echo [4] OTTIMIZZAZIONE PERFORMANCE (Gaming, Power Plans)
echo [5] GESTIONE APP (Rimuovi Bloatware, Installa Essential)
echo [6] SICUREZZA (Windows Defender, Aggiornamenti)
echo [0] ESCI
echo ======================================================
set /p choice=Scegli un'opzione (0-6):


:manutenzione
cls
echo ======================================================
echo             Manutenzione sistema - WinCustomizer
echo ======================================================
echo [1]  Esegui SFC (System File Checker)
echo [2]  Esegui DISM (ScanHealth)
echo [3]  Esegui DISM (RestoreHealth)
echo [4]  Pulizia disco avanzata (Cleanmgr)
echo [5]  Svuota cache DNS
echo [6]  Reimposta Winsock (Rete)
echo [7]  Svuota cartelle temporanee (Temp)
echo [8]  Pulisci cache Windows Update
echo [9]  Ottimizza e deframmenta dischi
echo [10] Controlla errori disco (Chkdsk - Solo read-only)
echo [11] Forza svuotamento cestino
echo [12] Pulisci cache icone ed esplora file
echo [13] Rimuovi log visualizzatore eventi
echo [14] Disabilita file di ibernazione (Libera spazio)
echo [15] Compatta OS (Lzx compression)
echo [16] Reset componenti Windows Update (via PowerShell)
echo [17] Pulisci cache Microsoft Store
echo [18] Disabilita indexing (Ricerca) su C:
echo [19] Pulisci prefetch
echo [20] Ottimizzazione registro (Pulisci file obsoleti)
echo [0]  Torna al menu principale
echo ======================================================
set /p subchoice=Seleziona un'operazione (0-20): 

if "%subchoice%"=="1"  sfc /scannow & pause & goto manutenzione
if "%subchoice%"=="2"  Dism /Online /Cleanup-Image /ScanHealth & pause & goto manutenzione
if "%subchoice%"=="3"  Dism /Online /Cleanup-Image /RestoreHealth & pause & goto manutenzione
if "%subchoice%"=="4"  cleanmgr /sageset:65535 & cleanmgr /sagerun:65535 & goto manutenzione
if "%subchoice%"=="5"  ipconfig /flushdns & pause & goto manutenzione
if "%subchoice%"=="6"  netsh winsock reset & pause & goto manutenzione
if "%subchoice%"=="7"  del /q /f /s %temp%\* & del /q /f /s C:\Windows\Temp\* & pause & goto manutenzione
if "%subchoice%"=="8"  net stop wuauserv & rd /s /q %systemroot%\SoftwareDistribution & net start wuauserv & pause & goto manutenzione
if "%subchoice%"=="9"  defrag C: /O & pause & goto manutenzione
if "%subchoice%"=="10" chkdsk C: & pause & goto manutenzione
if "%subchoice%"=="11" rd /s /q %systemdrive%\$Recycle.bin & pause & goto manutenzione
if "%subchoice%"=="12" taskkill /f /im explorer.exe & del /a /f /q "%localappdata%\IconCache.db" & start explorer.exe & pause & goto manutenzione
if "%subchoice%"=="13" powershell -Command "Get-EventLog -LogName * | ForEach { Clear-EventLog $_.Log }" & pause & goto manutenzione
if "%subchoice%"=="14" powercfg -h off & pause & goto manutenzione
if "%subchoice%"=="15" compact.exe /compactos:always & pause & goto manutenzione
if "%subchoice%"=="16" powershell -Command "Stop-Service wuauserv, bits; Remove-Item -Path $env:windir\SoftwareDistribution -Recurse -Force; Start-Service wuauserv, bits" & pause & goto manutenzione
if "%subchoice%"=="17" wsreset.exe & pause & goto manutenzione
if "%subchoice%"=="18" sc stop WSearch & sc config WSearch start=disabled & pause & goto manutenzione
if "%subchoice%"=="19" del /q /f /s %systemroot%\Prefetch\* & pause & goto manutenzione
if "%subchoice%"=="20" reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\VolumeCaches\Active Setup Temp Folders" /v "StateFlags0001" /t REG_DWORD /d 2 /f & pause & goto manutenzione
if "%subchoice%"=="0"  goto menu

echo Scelta non valida.
timeout /t 2 >nul
goto manutenzione
