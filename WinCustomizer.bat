:: WinCustomizer is an advanced Batch script designed to automate the maintenance and personalization of Windows environments.

@echo off

:menu
cls
echo ======================================================
echo                    WinCustomizer
echo ======================================================
echo [1] MANUTENZIONE SISTEMA (SFC, DISM, Pulizia Disco)
echo [2] PRIVACY E TELEMETRIA (Disabilita tracking)
echo [3] PERSONALIZZAZIONE UI (Menu Start, Taskbar, Context Menu)
echo [4] OTTIMIZZAZIONE PERFORMANCE (Gaming, Power Plans)
echo [5] GESTIONE APP (Rimuovi Bloatware, Installa Essential)
echo [6] SICUREZZA (Windows Defender, Aggiornamenti)
echo [0] ESCI
echo ======================================================
set /p choice=Scegli un'opzione (0-6):

if "%choice%"=="1" goto manutenzione
if "%choice%"=="2" goto privacy
if "%choice%"=="3" goto ui_custom
if "%choice%"=="4" goto performance
if "%choice%"=="5" goto app_manager
if "%choice%"=="6" goto sicurezza
if "%choice%"=="0" exit
echo Opzione non valida, riprova. & pause & goto menu

:manutenzione
cls
echo ======================================================
echo          Manutenzione sistema - WinCustomizer
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

:privacy
cls
echo ======================================================
echo             Privacy e Telemetria - WinCustomizer
echo ======================================================
echo [1]  Disabilita telemetria di base (Esperienza utente)
echo [2]  Disabilita Cortana e ricerca web nel menu Start
echo [3]  Disabilita ID annunci (Advertising ID)
echo [4]  Disabilita feedback e diagnostica (Frequenza)
echo [5]  Disabilita tracciamento avvio app
echo [6]  Disabilita sensore memoria (Storage Sense)
echo [7]  Disabilita cronologia attività (Activity Feed)
echo [8]  Disabilita servizi di geolocalizzazione
echo [9]  Disabilita tracciamento dei file recenti
echo [10] Disabilita telemetria di Microsoft Edge
echo [11] Disabilita "Esperienze condivise" (Project Rome)
echo [12] Disabilita telemetria di Office (Se installato)
echo [13] Disabilita Wifi-Sense (Condivisione automatica)
echo [14] Disabilita segnalazione errori Windows (WER)
echo [15] Rimuovi permessi fotocamera per app in background
echo [16] Rimuovi permessi microfono per app in background
echo [0]  Torna al menu principale
echo ======================================================
set /p privchoice=Seleziona un'operazione (0-16): 

if "%privchoice%"=="1"  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="2"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "SearchboxTaskbarMode" /t REG_DWORD /d 0 /f & reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v "BingSearchEnabled" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="3"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\AdvertisingInfo" /v "Enabled" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="4"  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v "DoNotShowFeedbackNotifications" /t REG_DWORD /d 1 /f & pause & goto privacy
if "%privchoice%"=="5"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v "Start_TrackProgs" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="6"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\StorageSense\Parameters\StoragePolicy" /v "0" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="7"  reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\System" /v "EnableActivityFeed" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="8"  powershell -Command "Stop-Service lfsvc; Set-Service lfsvc -StartupType Disabled" & pause & goto privacy
if "%privchoice%"=="9"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v "NoRecentDocsHistory" /t REG_DWORD /d 1 /f & pause & goto privacy
if "%privchoice%"=="10" reg add "HKLM\SOFTWARE\Policies\Microsoft\Edge" /v "MetricsReportingEnabled" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="11" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CDP" /v "CdpSessionUserAuthzPolicy" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="12" reg add "HKCU\Software\Microsoft\Office\16.0\Common\Privacy" /v "PersonnelDataCollection" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="13" reg add "HKLM\SOFTWARE\Microsoft\WcmSvc\wifinetworkmanager\config" /v "AutoConnectAllowedOEM" /t REG_DWORD /d 0 /f & pause & goto privacy
if "%privchoice%"=="14" reg add "HKLM\SOFTWARE\Microsoft\Windows\Windows Error Reporting" /v "Disabled" /t REG_DWORD /d 1 /f & pause & goto privacy
if "%privchoice%"=="15" powershell -Command "Get-AppxPackage | Foreach {Add-AppxPackage -DisableDevelopmentMode -Register \"$($_.InstallLocation)\AppXManifest.xml\"}" & pause & goto privacy
if "%privchoice%"=="16" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\CapabilityAccessManager\ConsentStore\microphone" /v "Value" /t REG_SZ /d "Deny" /f & pause & goto privacy
if "%privchoice%"=="0"  goto menu

echo Scelta non valida.
timeout /t 2 >nul
goto privacy
