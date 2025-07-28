@echo off
echo Building and running modelpdf Docker container...
echo.

echo Step 1: Building Docker image...
docker-compose build

if %ERRORLEVEL% NEQ 0 (
    echo Error: Docker build failed!
    pause
    exit /b 1
)

echo.
echo Step 2: Running the container...
docker-compose up

echo.
echo Done! Check the output directory for results.
pause
