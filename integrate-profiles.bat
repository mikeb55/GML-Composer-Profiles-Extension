@echo off
echo ========================================
echo Profile Integration Script
echo Connecting all apps to central profiles
echo ========================================
echo.

set PROFILE_REPO=https://github.com/mikeb55/GML-Composer-Profiles-Extension.git
set PROFILE_URL=https://raw.githubusercontent.com/mikeb55/GML-Composer-Profiles-Extension/main/complete_profiles.js

:: List of local directories to update
set DIRS=^
C:\Users\mike\Documents\gml-workspace\gml-ecosystem ^
C:\Users\mike\Documents\gml-workspace\drum-engine ^
C:\Users\mike\Documents\gml-workspace\quintet-composer ^
C:\Users\mike\Documents\gml-workspace\gml-quartet-v2 ^
C:\Users\mike\Documents\gml-workspace\gml-riffgen ^
C:\Users\mike\Documents\gml-workspace\triadgen ^
C:\Users\mike\Documents\gml-workspace\gml-quartet ^
C:\Users\mike\Documents\gml-workspace\GML-Codex ^
C:\Users\mike\Documents\gml-workspace\gml-enhancement-suite ^
C:\Users\mike\Documents\gml-workspace\gml-ace ^
C:\Users\mike\Documents\gml-workspace\GML-Guitar-Profiles-Library

echo Creating profile loader module...
(
echo // Profile Loader - Auto-generated
echo // Source: GML-Composer-Profiles-Extension
echo // Updated: %date% %time%
echo.
echo const PROFILE_SOURCE = '%PROFILE_URL%';
echo.
echo async function loadProfiles() {
echo     try {
echo         const response = await fetch(PROFILE_SOURCE^);
echo         const scriptText = await response.text(^);
echo         eval(scriptText^);
echo         return window.composerProfiles;
echo     } catch (error^) {
echo         console.error('Failed to load profiles:', error^);
echo         // Fallback to local copy if exists
echo         if (typeof composerProfiles !== 'undefined'^) {
echo             return composerProfiles;
echo         }
echo         return null;
echo     }
echo }
echo.
echo // For Node.js environments
echo if (typeof module !== 'undefined' ^&^& module.exports^) {
echo     module.exports = { loadProfiles };
echo }
) > profile-loader.js

echo.
echo Installing profile loader in each directory...
echo.

for %%D in (%DIRS%) do (
    if exist "%%D" (
        echo Processing: %%D
        copy profile-loader.js "%%D\profile-loader.js" >nul 2>&1
        
        :: Create integration HTML if app uses HTML
        if exist "%%D\*.html" (
            echo   - Added profile-loader.js
            echo   - Creating integration snippet...
            (
                echo ^<!-- Add this to your HTML files --^>
                echo ^<script src="profile-loader.js"^>^</script^>
                echo ^<script^>
                echo loadProfiles(^).then(profiles =^> {
                echo     console.log('Loaded', Object.keys(profiles^).length, 'profiles'^);
                echo     window.profiles = profiles;
                echo }^);
                echo ^</script^>
            ) > "%%D\profile-integration.html"
        )
        
        :: Check if it's a git repo and add remote
        cd /d "%%D"
        git remote -v >nul 2>&1
        if %errorlevel% == 0 (
            echo   - Git repo detected
            :: Add profiles as submodule or remote
            git remote add profiles %PROFILE_REPO% 2>nul
            if %errorlevel% == 0 (
                echo   - Added profiles remote
            )
        )
    ) else (
        echo Skipping: %%D [not found]
    )
    echo.
)

echo ========================================
echo Creating sync script...
(
echo @echo off
echo echo Syncing profiles from GitHub...
echo curl -o complete_profiles.js %PROFILE_URL%
echo echo Profiles updated!
echo pause
) > sync-profiles.bat

echo.
echo ========================================
echo INTEGRATION COMPLETE!
echo ========================================
echo.
echo Next steps:
echo 1. In each app, add: ^<script src="profile-loader.js"^>^</script^>
echo 2. Run sync-profiles.bat to update profiles from GitHub
echo 3. Apps will now load profiles from central source
echo.
echo To update all apps when profiles change:
echo   - Push changes to GML-Composer-Profiles-Extension
echo   - Run sync-profiles.bat in each app directory
echo.
pause