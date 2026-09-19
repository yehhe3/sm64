@REM  Make and run batch file, for easy build without manually typing commands.
@REM  For the moment, only Windows and WSL is supported but native linux and MacOS support is planned
@REM  by the way this requires the n64 emulator as the default app to run .z64 files.

wsl --cd "%~dp0." -- make -j%NUMBER_OF_PROCESSORS% COMPARE=0
powershell -NoProfile -Command "$p=(Get-ItemProperty 'Registry::HKEY_CLASSES_ROOT\.z64' -ErrorAction SilentlyContinue).'(default)'; if(-not $p){$p=(Get-ItemProperty 'Registry::HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.z64\UserChoice' -ErrorAction SilentlyContinue).ProgId}; if($p){$c=(Get-ItemProperty ('Registry::HKEY_CLASSES_ROOT\'+$p+'\shell\open\command') -ErrorAction SilentlyContinue).'(default)'; if($c){if($c -match '^\x22([^\x22]+)\x22'){$e=$matches[1]}elseif($c -match '^([^\s]+)'){$e=$matches[1]}; if($e){Get-Process | Where-Object { $_.Path -eq $e } | ForEach-Object { & taskkill /F /PID $_.Id /T }}}}"
powershell start '%~dp0build\us\sm64.us.z64'