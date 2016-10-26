@echo off
tasm /z /zi /n %1,%1,%1
if errorlevel 1 goto err
tlink /v /x %1,%1
goto end
:err
echo Translation error!
goto fin
:end
echo Done
:fin
echo .
