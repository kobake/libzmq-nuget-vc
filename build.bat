@echo.
@echo "==============================="
@echo "clean packaging output files"
@echo "==============================="

del packaging\bin_x86_debug\*.lib
del packaging\bin_x86_release\*.lib
del packaging\bin_x64_debug\*.lib
del packaging\bin_x64_release\*.lib


@echo.
@echo "==============================="
@echo "x86"
@echo "==============================="

setlocal
pushd libzmq
rmdir /S /Q cmake-make32
mkdir cmake-make32
pushd cmake-make32

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars32.bat"

cmake .. -G "Visual Studio 16 2019" -A Win32 -DZMQ_BUILD_TESTS=OFF
msbuild libzmq-static.vcxproj -p:Configuration=Debug   -p:Platform=Win32
msbuild libzmq-static.vcxproj -p:Configuration=Release -p:Platform=Win32

xcopy lib\Debug\*.lib   ..\..\packaging\bin_x86_debug\.
xcopy lib\Release\*.lib ..\..\packaging\bin_x86_release\.

popd
popd
endlocal
@echo.


@echo.
@echo "==============================="
@echo "x64"
@echo "==============================="

setlocal
pushd libzmq
rmdir /S /Q cmake-make64
mkdir cmake-make64
pushd cmake-make64

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2019\Community\VC\Auxiliary\Build\vcvars64.bat"

cmake .. -G "Visual Studio 16 2019" -A x64 -DZMQ_BUILD_TESTS=OFF
msbuild libzmq-static.vcxproj -p:Configuration=Debug   -p:Platform=x64
msbuild libzmq-static.vcxproj -p:Configuration=Release -p:Platform=x64

xcopy lib\Debug\*.lib   ..\..\packaging\bin_x64_debug\.
xcopy lib\Release\*.lib ..\..\packaging\bin_x64_release\.

popd
popd
endlocal
@echo.
