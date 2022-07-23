@ECHO OFF
COLOR 0F
Setlocal
::EchoANSI.cmd
cls
:: Requires windows 1909 or newer
:: Define foreground and background ANSI colors:
Set _fBlack=[30m
Set _bBlack=[40m
Set _fRed=[31m
Set _bRed=[41m
Set _fGreen=[32m
Set _bGreen=[42m
Set _fYellow=[33m
Set _bYellow=[43m
Set _fBlue=[34m
Set _bBlue=[44m
Set _fMag=[35m
Set _bMag=[45m
Set _fCyan=[36m
Set _bCyan=[46m
Set _fLGray=[37m
Set _bLGray=[47m
Set _fDGray=[90m
Set _bDGray=[100m
Set _fBRed=[91m
Set _bBRed=[101m
Set _fBGreen=[92m
Set _bBGreen=[102m
Set _fBYellow=[93m
Set _bBYellow=[103m
Set _fBBlue=[94m
Set _bBBlue=[104m
Set _fBMag=[95m
Set _bBMag=[105m
Set _fBCyan=[96m
Set _bBCyan=[106m
Set _fBWhite=[97m
Set _bBWhite=[107m
Set _RESET=[0m


:: Checking Administrator
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	ECHO %_fGreen%%_bBlack%------------------------- Administrator PRIVILEGES Detected! ------------------------------------- %_RESET%	
    ECHO %_fMag%%_bBlack% 
	echo "  _____  ____  ____     ___ __    __   ____  _      _          ____  __ __  _        ___  _____ "
	echo " |     ||    ||    \   /  _]  |__|  | /    || |    | |        |    \|  |  || |      /  _]/ ___/ "
	echo " |   __| |  | |  D  ) /  [_|  |  |  ||  o  || |    | |        |  D  )  |  || |     /  [_(   \_  "
	echo " |  |_   |  | |    / |    _]  |  |  ||     || |___ | |___     |    /|  |  || |___ |    _]\__  | "
	echo " |   _]  |  | |    \ |   [_|  `  '  ||  _  ||     ||     |    |    \|  :  ||     ||   [_ /  \ | "
	echo " |  |    |  | |  .  \|     |\      / |  |  ||     ||     |    |  .  \     ||     ||     |\    | "
	echo " |__|   |____||__|\_||_____| \_/\_/  |__|__||_____||_____|    |__|\_|\__,_||_____||_____| \___| "
	echo %_RESET% 
	ECHO %_fGreen%%_bBlack%------------------------------- Firewall Rules Changer ------------------------------------------- %_RESET%		
	
) ELSE (
   echo.
   echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
   ECHO %_fRed%%_bBlack% 
   TITLE ERROR: ADMINISTRATOR PRIVILEGES REQUIRED
   echo     ######## ########  ########   #######  ########  
   echo     ##       ##     ## ##     ## ##     ## ##     ## 
   echo     ##       ##     ## ##     ## ##     ## ##     ## 
   echo     ######   ########  ########  ##     ## ########  
   echo     ##       ##   ##   ##   ##   ##     ## ##   ##   
   echo     ##       ##    ##  ##    ##  ##     ## ##    ##  
   echo     ######## ##     ## ##     ##  #######  ##     ## 
   echo. %_RESET%
   echo ##########################################################
   echo.
   echo      Right click and select %_fRed%%_bBlack%"Run As Administrator"%_RESET%. 
   echo.
   PAUSE
   EXIT /B 1
)

TITLE Firewall Rules Changer

ECHO           Path:  %~dp0     Name:  %~nx0
ECHO.

:: Input Option
:INPUT_CASE
PUSHD
ECHO.
ECHO                          %_fMag%%_bBlack%-------:Options:---------%_RESET% 
ECHO                          %_fMag%%_bBlack%^| %_RESET%  %_fCyan%%_bBlack%1 List .exe  %_RESET%       %_fMag%%_bBlack%^| %_RESET%  
ECHO                          %_fMag%%_bBlack%^| %_RESET%  %_fGreen%%_bBlack%2 Add Rules %_RESET%        %_fMag%%_bBlack%^| %_RESET%  
ECHO                          %_fMag%%_bBlack%^| %_RESET%  %_fRed%%_bBlack%3 Delete Rules %_RESET%     %_fMag%%_bBlack%^| %_RESET%  
ECHO                          %_fMag%%_bBlack%^| %_RESET%  %_fYellow%%_bBlack%4 Check FWrule %_RESET%     %_fMag%%_bBlack%^| %_RESET%  
ECHO                          %_fMag%%_bBlack%^| %_RESET%  %_f1Grey%%_bBlack%5 Exit program %_RESET%     %_fMag%%_bBlack%^| %_RESET%  
ECHO                          %_fMag%%_bBlack%^| %_RESET%  %_f1Grey%%_bBlack%6 Install program %_RESET%  %_fMag%%_bBlack%^| %_RESET%  
ECHO                          %_fMag%%_bBlack%-------------------------%_RESET% 
ECHO.

:: Input Option
SET /P OPTION=" Enter Option: "

::  jump to :1, :2, etc.
2>NUL CALL :CASE_%OPTION% 

:: If CASE_label doesn't exist Exit the programm
IF ERRORLEVEL 1 CALL :DEFAULT_CASE 
EXIT /B

:: List the exe files 
:CASE_1
  ECHO.
  ECHO %_fCyan%%_bBlack%------------------------------------- Option 1: -------------------------------------------------- 
  Echo                                     All .exe files %_RESET% 
  ECHO.
  ECHO.These EXE files will be added to the windows firewall:
  ECHO.
  for /f tokens^=* %%i in ('where .:*.exe')do (
  echo/  %%i 
)
  ECHO.
  ECHO %_fCyan%%_bBlack%-------------------------------------End of list-------------------------------------------------- %_RESET%  
  GOTO INPUT_CASE 
  
  
:: Add the Rules  
:CASE_2
echo  %_fGreen%%_bBlack%-------------------------------------2 Add Rules--------------------------------------------------%_RESET% 
ECHO.
ECHO.The following IN and OUT rules will be added to the windows firewall:
ECHO.
  for /f tokens^=* %%i in ('where .:*.exe')do (
  echo/              Path: %%~dpi ^| Name: %%~nxi ^|   
  netsh advfirewall firewall add rule name="%%~pi%%~ni" dir=in program="%%~dpi%%~nxi" profile=any action=block  
  netsh advfirewall firewall add rule name="%%~pi%%~ni" dir=out program="%%~dpi%%~nxi" profile=any action=block   
  ECHO.
  )
echo  %_fGreen%%_bBlack%-------------------------------------Rules added--------------------------------------------------%_RESET% 
ECHO.
ECHO.
  GOTO INPUT_CASE
  
:: Delete the Rules
:CASE_3
echo                           %_fRed%%_bBlack%3 Delete Rules %_RESET%  
  for /f tokens^=* %%i in ('where .:*.exe')do (
  netsh advfirewall firewall delete rule name="%%~ni" 
  ::verbose
  ECHO.  
  )
ECHO.
  GOTO INPUT_CASE
  
::  Check for FWrule
:CASE_4
ECHO %_fYellow%%_bBlack%-------------------------------------4 Check for FWrule-------------------------------------%_RESET%
  for /f tokens^=* %%i in ('where .:*.exe')do (
  echo ----------------------------------------------------------------------
  echo/ Path: %%~pi ^| Name: %%~nxi ^|   
  echo ----------------------------------------------------------------------
  echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$  
  netsh advfirewall firewall show rule name="%%~ni" verbose 
  netsh advfirewall firewall show rule name="%%~pi%%~ni" verbose 
  echo $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$   
  )
ECHO.
ECHO %_fYellow%%_bBlack%-------------------------------------End of Check for FWrule-------------------------------------%_RESET%
  GOTO INPUT_CASE


:: Exit the Program
:CASE_5
  GOTO END_CASE  
 
:: Install the Program
:CASE_6
ECHO %_fRed%%_bBlack%-------------------------------------6 Install (not yet for real)-------------------------------------%_RESET%
ECHO making backupfile AdvancedSystemSettingsEnvironmentalVariables.txt
ECHO %PATH% > AdvancedSystemSettingsEnvironmentalVariables.txt
SET /P SURE=" Are You Sure? (Y/N): "

::  jump to :(Y)es, :(N)o.
2>NUL CALL :CASE_%SURE% 
:CASE_Y
::  Make a folder and add it to PATH
IF EXIST C:\CMD_HOME ( 
ECHO Folder C:\CMD_HOME exist 
ECHO setx PATH "%PATH%;C:\CMD_HOME\"
) ELSE ( 
ECHO Folder C:\CMD_HOME does not exist
mkdir C:\CMD_HOME
IF EXIST C:\CMD_HOME  (
ECHO now it exist
ECHO setx PATH "%PATH%;C:\CMD_HOME\"
) ELSE ( 
ECHO You first need to manually make the directory C:\CMD_HOME to install
)
)
ECHO %_fRed%%_bBlack%-------------------------------------6 Install (not yet for real)-------------------------------------%_RESET%
GOTO INPUT_CASE
 
:CASE_N
ECHO %_fRed%%_bBlack%-------------------------------------6 Install (not yet for real)-------------------------------------%_RESET%
GOTO INPUT_CASE
 
:: Wrong Input 
:DEFAULT_CASE
  ECHO                           Unknown option "%OPTION%"
  GOTO INPUT_CASE

:: End the programm 
:END_CASE
	ECHO %_fGreen%%_bBlack%-----------------------------------------------------------------%_RESET% %_fMag%%_bBlack% 
 	echo    ______  __ __   ____  ____   __  _      __ __   ___   __ __  
	echo " |      ||  |  | /    ||    \ |  |/ ]    |  |  | /   \ |  |  | "
	echo " |      ||  |  ||  o  ||  _  ||  ' /     |  |  ||     ||  |  | "
	echo " |_|  |_||  _  ||     ||  |  ||    \     |  ~  ||  O  ||  |  | "
	echo "   |  |  |  |  ||  _  ||  |  ||     \    |___, ||     ||  :  | "
	echo "   |  |  |  |  ||  |  ||  |  ||  .  |    |     ||     ||     | "
	echo "   |__|  |__|__||__|__||__|__||__|\_|    |____/  \___/  \__,_| "                                                             
	echo %_RESET%%_fGreen%%_bBlack%-----------------------------------------------------------------%_RESET%	

::  # reset ERRORLEVEL
::  # return from CALL
  VER > NUL
  GOTO :EOF
