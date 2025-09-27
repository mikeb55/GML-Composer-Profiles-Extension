@echo off
echo ========================================
echo Git Commit & Push - All Today's Work
echo ========================================
echo.

cd /d C:\Users\mike\Documents\gml-workspace\gml-composer-profiles-extension

echo Current directory:
cd
echo.

echo Checking git status...
git status --short
echo.

echo Adding all new files...
git add .

echo.
echo Creating commit with today's work...
git commit -m "Add complete profile system with 77+ profiles, MusicXML export, and multi-app integration"

echo.
echo Pushing to GitHub...
git push

echo.
echo ========================================
echo Other directories to consider committing:
echo ========================================
echo.

echo Checking TriadGen...
cd /d C:\Users\mike\Documents\gml-workspace\triadgen 2>nul
if %errorlevel% == 0 (
    git status --short
    echo To commit TriadGen: git add . ^&^& git commit -m "Add profile integration" ^&^& git push
)

echo.
echo ========================================
echo DONE! Main profile system committed.
echo ========================================
pause