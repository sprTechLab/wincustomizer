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
