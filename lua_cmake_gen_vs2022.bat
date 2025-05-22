if not exist build md build
cmake -G "Visual Studio 17 2022" -A x64 -H. -Bbuild ^
-DCMAKE_GENERATOR_INSTANCE="C:/Program Files/Microsoft Visual Studio/2022/Professional"
pause