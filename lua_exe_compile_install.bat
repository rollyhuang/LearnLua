@echo off
setlocal

set "PARENT=%CD%"

if not exist build md build
cmake -S . -B ./build
cmake --build ./build --config Release
cmake --install ./build --prefix "%PARENT%"

echo INSTALL done!
endlocal
pause