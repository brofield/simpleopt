@echo off

set TESTDIR=
set EXPECTED=
set OUTPUT=

if exist .\fullSample.exe (
    set EXPECTED=..\runtests.txt
    call :runtests .
    exit /b 0
)

set EXPECTED=runtests.txt
for %%d in (fullDebug fullDebugUnicode fullRelease fullReleaseUnicode) do call :runtests %%d
pause
exit /b 0

:runtests
set TESTDIR=%1

if not exist %TESTDIR% (
    echo Skipping %TESTDIR%
    exit /b 0
)
if not exist %TESTDIR%\fullSample.exe (
    echo Skipping %TESTDIR%
    exit /b 0
)

set TESTNAME=%TESTDIR%
set OUTPUT=runtests.%TESTNAME%

if %TESTNAME%.==.. (
    set TESTNAME=CurrentDir
    set OUTPUT=runtests.out
)

if exist %OUTPUT% del %OUTPUT%


call :testcase -d -e -f -g -flag --flag
call :testcase -s SEP1 -sep SEP2 --sep SEP3
call :testcase -s -s SEP1 -sep SEP2 --sep SEP3
call :testcase --noerr -s -s SEP1 -sep SEP2 --sep SEP3
call :testcase FILE0 -s SEP1 FILE1 -sep SEP2 FILE2 --sep SEP3 FILE3 
call :testcase FILE0 -s=SEP1 FILE1 -sep=SEP2 FILE2 --sep=SEP3 FILE3 
call :testcase --pedantic FILE0 -s=SEP1 FILE1 -sep=SEP2 FILE2 --sep=SEP3 FILE3 
call :testcase -c=COM1 -com=COM2 --com=COM3
call :testcase --shortarg -cCOM 
call :testcase --shortarg -cCOM1 -c=COM2 
call :testcase --shortarg --clump -defgcCOM1 -c=COM2 
call :testcase -o -opt --opt -o=OPT1 -opt=OPT2 --opt=OPT3
call :testcase --shortarg -oOPT1 
call :testcase -man -mand -mandy -manda -mandat -mandate
call :testcase --man --mand --mandy --manda --mandat --mandate
call :testcase --exact -man -mand -mandy -manda -mandat -mandate 
call :testcase FILE0 FILE1
call :testcase --multi0 --multi1 ARG1 --multi2 ARG1 ARG2
call :testcase FILE0 --multi0 FILE1 --multi1 ARG1 FILE2 --multi2 ARG1 ARG2 FILE3
call :testcase FILE0 --multi 0 FILE1 --multi 4 ARG1 ARG2 ARG3 ARG4 FILE3
call :testcase --multi 0
call :testcase --multi 1
call :testcase FILE0 --multi 1
call :testcase /-sep SEP1
call :testcase /sep SEP1
call :testcase --noslash /sep SEP1
call :testcase --multi 1 -sep
call :testcase --noerr --multi 1 -sep


fc /A %OUTPUT% %EXPECTED% > nul
if errorlevel 1 goto error
echo %TESTNAME%: All tests passed!
exit /b 0

:error
echo %TESTNAME%: Test results (%OUTPUT%) don't match expected (%EXPECTED%)
exit /b 1

:testcase
echo. >> %OUTPUT%
echo fullSample %* >> %OUTPUT%
%TESTDIR%\fullSample %* >> %OUTPUT%
exit /b 0


