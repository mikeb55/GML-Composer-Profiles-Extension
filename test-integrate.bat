@echo off
echo Testing profile integration...
echo.

echo Current directory:
cd
echo.

echo Creating profile-loader.js...
echo // Profile Loader Test > profile-loader.js
echo const PROFILE_URL = 'https://raw.githubusercontent.com/mikeb55/GML-Composer-Profiles-Extension/main/complete_profiles.js'; >> profile-loader.js

echo.
echo Checking if directories exist:
if exist "C:\Users\mike\Documents\gml-workspace\gml-riffgen" (
    echo   FOUND: gml-riffgen
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\gml-riffgen\profile-loader.js"
    echo   Copied to gml-riffgen
) else (
    echo   NOT FOUND: gml-riffgen
)

if exist "C:\Users\mike\Documents\gml-workspace\triadgen" (
    echo   FOUND: triadgen
    copy profile-loader.js "C:\Users\mike\Documents\gml-workspace\triadgen\profile-loader.js"
    echo   Copied to triadgen
) else (
    echo   NOT FOUND: triadgen
)

echo.
echo Done!
pause