@echo off
echo Updating all profile loaders to use profiles-data.js...
echo.

:: Create new loader
(
echo // Fixed Profile Loader - Points to profiles-data.js
echo const PROFILE_SOURCE = 'https://raw.githubusercontent.com/mikeb55/GML-Composer-Profiles-Extension/main/profiles-data.js';
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
) > profile-loader-fixed.js

:: Copy to all directories
copy profile-loader-fixed.js "C:\Users\mike\Documents\gml-workspace\triadgen\profile-loader.js" >nul
copy profile-loader-fixed.js "C:\Users\mike\Documents\gml-workspace\gml-riffgen\profile-loader.js" >nul
copy profile-loader-fixed.js "C:\Users\mike\Documents\gml-workspace\gml-quartet\profile-loader.js" >nul

echo Updated 3 key apps with fixed loader
echo.
echo Testing...
pause