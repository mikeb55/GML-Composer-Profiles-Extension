@echo off
echo ========================================
echo Profile Integration Script
echo Connecting all apps to central profiles
echo ========================================
echo.

echo Creating profile-loader.js...
(
echo // Profile Loader - Auto-generated
echo // Source: GML-Composer-Profiles-Extension
echo // Updated: %date% %time%
echo.
echo const PROFILE_SOURCE = 'https://raw.githubusercontent.com/mikeb55/GML-Composer-Profiles-Extension/main/complete_profiles.js';
echo.
echo async function loadProfiles^(^) {
echo     try {
echo         const response = await fetch^(PROFILE_SOURCE^);
echo         const scriptText = await response.text^(^);
echo         eval^(scriptText^);
echo         return window.composerProfiles;
echo     } catch ^(error^) {
echo         console.error^('Failed to load profiles:', error^);
echo         return null;
echo     }
echo }
) > profile-loader.js

echo.
echo Installing in all directories...
echo.

set count=0

if exist "C:\Users\mike\Documents\gml-workspace\gml-ecosystem" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\gml-ecosystem\profile-loader.js" >nul
    echo   [OK] gml-ecosystem
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\drum-engine" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\drum-engine\profile-loader.js" >nul
    echo   [OK] drum-engine
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\quintet-composer" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\quintet-composer\profile-loader.js" >nul
    echo   [OK] quintet-composer
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\gml-quartet-v2" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\gml-quartet-v2\profile-loader.js" >nul
    echo   [OK] gml-quartet-v2
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\gml-riffgen" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\gml-riffgen\profile-loader.js" >nul
    echo   [OK] gml-riffgen
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\triadgen" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\triadgen\profile-loader.js" >nul
    echo   [OK] triadgen
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\gml-quartet" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\gml-quartet\profile-loader.js" >nul
    echo   [OK] gml-quartet
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\GML-Codex" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\GML-Codex\profile-loader.js" >nul
    echo   [OK] GML-Codex
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\gml-enhancement-suite" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\gml-enhancement-suite\profile-loader.js" >nul
    echo   [OK] gml-enhancement-suite
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\gml-ace" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\gml-ace\profile-loader.js" >nul
    echo   [OK] gml-ace
    set /a count+=1
)

if exist "C:\Users\mike\Documents\gml-workspace\GML-Guitar-Profiles-Library" (
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\GML-Guitar-Profiles-Library\profile-loader.js" >nul
    echo   [OK] GML-Guitar-Profiles-Library
    set /a count+=1
)

echo.
echo ========================================
echo COMPLETE: Installed in %count% directories
echo ========================================
echo.
echo To use in your apps, add this to HTML files:
echo ^<script src="profile-loader.js"^>^</script^>
echo ^<script^>
echo   loadProfiles^(^).then^(profiles =^> {
echo     console.log^('Loaded profiles'^);
echo     window.profiles = profiles;
echo   }^);
echo ^</script^>
echo.
pause