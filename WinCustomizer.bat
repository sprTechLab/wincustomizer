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
echo [5] GESTIONE APP (Rimuovi bloatware, installa essentials)
echo [6] SICUREZZA (Windows Defender, aggiornamenti)
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

:ui_custom
cls
echo ======================================================
echo          Personalizzazione UI - WinCustomizer
echo ======================================================
echo [1]  Ripristina menu contestuale classico (Win10 style)
echo [2]  Ripristina menu contestuale moderno (Win11 default)
echo [3]  Allinea icone taskbar a sinistra
echo [4]  Allinea icone taskbar al centro (Default)
echo [5]  Disabilita widget della taskbar
echo [6]  Abilita widget della taskbar
echo [7]  Nascondi icona ricerca dalla taskbar
echo [8]  Mostra icona ricerca nella taskbar
echo [9]  Disabilita chat (Microsoft Teams) dalla taskbar
echo [10] Nascondi icone di sistema sul desktop (Cestino, PC, etc.)
echo [11] Mostra icone di sistema sul desktop
echo [12] Disabilita trasparenza (Effetti mica e acrilico)
echo [13] Abilita trasparenza di sistema
echo [14] Rimpicciolisci icone della taskbar (Small mode)
echo [15] Taskbar dimensioni standard
echo [16] Disabilita suggerimenti nel menu Start
echo [17] Disabilita animazioni di Windows
echo [18] Abilita animazioni di Windows
echo [19] Rimuovi il suffisso "- Collegamento" dai nuovi link
echo [20] Mostra estensioni file conosciuti in Esplora File
echo [21] Mostra file, cartelle e drive nascosti
echo [22] Apri Esplora File su "Questo PC" invece di "Home"
echo [23] Disabilita i suoni di sistema
echo [24] Disabilita schermata di blocco (Lock screen)
echo [25] Abilita il "God Mode" sul desktop
echo [26] Rimuovi filigrana "Requisiti di sistema non soddisfatti"
echo [27] Cambia tema in Dark Mode (Sistema e App)
echo [28] Cambia tema in Light Mode (Sistema e App)
echo [29] Riavvia il processo Explorer (Per applicare modifiche)
echo [0]  Torna al menu principale
echo ======================================================
set /p uichoice=Seleziona un'operazione (0-29): 

if "%uichoice%"=="1"  reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve & goto ui_custom
if "%uichoice%"=="2"  reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f & goto ui_custom
if "%uichoice%"=="3"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="4"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarAl /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="5"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="6"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarDa /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="7"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="8"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Search" /v SearchboxTaskbarMode /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="9"  reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarMn /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="10" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="11" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" /v "{20D04FE0-3AEA-1069-A2D8-08002B30309D}" /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="12" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="13" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize" /v EnableTransparency /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="14" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSi /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="15" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v TaskbarSi /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="16" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Start_IrisRecommendations /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="17" reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9012028010000000 /f & goto ui_custom
if "%uichoice%"=="18" reg add "HKCU\Control Panel\Desktop" /v UserPreferencesMask /t REG_BINARY /d 9e3e078012000000 /f & goto ui_custom
if "%uichoice%"=="19" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer" /v link /t REG_BINARY /d 00000000 /f & goto ui_custom
if "%uichoice%"=="20" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="21" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v Hidden /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="22" reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v LaunchTo /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="23" reg add "HKCU\AppEvents\Schemes" /ve /t REG_SZ /d ".None" /f & goto ui_custom
if "%uichoice%"=="24" reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\Personalization" /v NoLockScreen /t REG_DWORD /d 1 /f & goto ui_custom
if "%uichoice%"=="25" mkdir "%userprofile%\Desktop\GodMode.{ED7BA470-8E54-465E-825C-99712043E01C}" & goto ui_custom
if "%uichoice%"=="26" reg add "HKCU\Control Panel\UnsupportedHardwareNotificationCache" /v SV2 /t REG_DWORD /d 0 /f & goto ui_custom
if "%uichoice%"=="27" powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name SystemUsesLightTheme -Value 0; Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name AppsUseLightTheme -Value 0" & goto ui_custom
if "%uichoice%"=="28" powershell -Command "Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name SystemUsesLightTheme -Value 1; Set-ItemProperty -Path 'HKCU:\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize' -Name AppsUseLightTheme -Value 1" & goto ui_custom
if "%uichoice%"=="29" taskkill /f /im explorer.exe & start explorer.exe & goto ui_custom
if "%uichoice%"=="0"  goto menu

echo Scelta non valida.
timeout /t 2 >nul
goto ui_custom
