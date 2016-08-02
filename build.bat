@echo off
echo == Setting vars...
set projpath=%cd%
set unitypath=C:\Program Files\Unity\Editor\Unity.exe
set gamename=YourGame
set buildname=%1
set basepath=%projpath%Builds\%buildname%\

set buildargs=-projectPath "%projpath%" -batchmode -s ASSERTIONS=1 -logFile "%projpath%build-%gamename%-%buildname%.log" -quit

echo == Making folders...
set winpath=%basepath%win
mkdir "%winpath%32\"
mkdir "%winpath%64\"
set buildargs=-buildWindowsPlayer "%winpath%32\%gamename%.exe" -buildWindows64Player "%winpath%64\%gamename%.exe" %buildargs%
del /F "%winpath%32\player_win_x86.pdb" "%winpath%32\player_win_x86_s.pdb" "%winpath%64\player_win_x64.pdb" "%winpath%64\player_win_x64_s.pdb"

set linuxpath=%basepath%linux\
mkdir "%linuxpath%"
set buildargs=-buildLinuxUniversalPlayer "%linuxpath%%gamename%" %buildargs%

set macpath=%basepath%mac\
mkdir "%macpath%"
set buildargs=-buildOSXUniversalPlayer "%macpath%%gamename%.app" %buildargs%

set webpath=%basepath%web
mkdir "%webpath%gl\"
set buildargs=-executeMethod UnityBuild.Build_WebGL "%webpath%gl\%gamename%" %buildargs%

echo == Beginning build...
"%unitypath%" %buildargs%
echo == Reviewing output...
notepad "%projpath%\build-%gamename%-%buildname%.log"