@echo off
setlocal

set "PARENT=%CD%\.."

cmake --build ./build --config Release
cmake --install ./build --prefix "%PARENT%"

echo INSTALL lualib done!
endlocal
pause