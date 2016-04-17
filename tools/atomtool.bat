@REM ###################################################
@REM AtomPower team made this tool (http://www.cleanbing.cn)
@REM @copyright 2015, author: atompower-team
@REM ###################################################

@ECHO OFF


@REM !!!! 系统应用MySQL/WinRAR等安装路径，自行修改
set mysql_bin=D:\wamp\bin\mysql\mysql5.6.17\bin\
set winrar_bin="C:\Program Files\WinRAR\winrar"

@REM !!!! 数据库配置，自行修改
set db_name=otbt3
set db_user=otbt3_root

@REM !!!! tool内部配置，一般不用改
set sql_script_file=sqlscript.sql



@REM Main Menu
@REM 首先显示当前配置，如果不正确，请自行修改该BAT文件
:mainmenu
cls
ECHO.
ECHO =========================================================================
ECHO Windows tools for OnethinkBt3 (atompower: http://www.cleanbing.cn)
ECHO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ECHO Current configuration: (please quit if incorrect!)
ECHO.
ECHO database: %db_name%
ECHO db  user: %db_user%
ECHO ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
ECHO Valid Command:
ECHO.
ECHO d - Export database to local 'onethinkdb.sql'
ECHO i - Import local 'onethinkdb.sql' to database
ECHO r - Reinstall OnethinkBt3
ECHO p - Zip to release package (remove runtime and package all by winrar)
ECHO q - Quit
ECHO =========================================================================
ECHO.
set /p answer=Your choice? [d/i/r/p/q]
ECHO.
ECHO.
if %answer%==d goto dumpdb 
if %answer%==i goto importdb
if %answer%==r goto reinstall
if %answer%==p goto package
if %answer%==q goto quitme

:quitme
ECHO bye
@exit

:dumpdb
ECHO Your choice is "d - Export database to local onethinkdb.sql"
ECHO.
@ECHO on
%mysql_bin%mysqldump -u%db_user% -p %db_name% > onethinkdb.sql
@ECHO off
@ECHO.
@ECHO %db_name% has dump to 'onethinkdb.sql', please check its updated!
@ECHO.
@ECHO.
pause
goto mainmenu

:importdb
ECHO Your choice is "i - Import local onethinkdb.sql to database"
%mysql_bin%mysql -u%db_user% -p < importdb.sql 
@ECHO.
@ECHO db import finished!
@ECHO.
@ECHO.
pause
goto mainmenu

:reinstall
ECHO Your choice is 'r - Reinstall OnethinkBt3'
del ..\Application\User\Conf\config.php
del ..\Data\install.lock
ECHO file removed: \Application\User\Conf\config.php
ECHO file removed: \Data\install.lock
ECHO ready for reinstall
start http://localhost/OnethinkBt3
@ECHO reinstall finished!
@ECHO.
@ECHO.
pause
goto mainmenu

:package
ECHO Your choice is 'p - Zip to release package (remove runtime and package all by winrar)'
ECHO.
set mypath=%~d0%~p0
set package=%mypath:~0,-7%
set runtime=%package%\Runtime
ECHO.
ECHO remove Runtime folder if exist
if exist %runtime% (rd /S %runtime%)
ECHO.
ECHO remove previous package if exist
if exist %package%.zip (del %package%.zip)
ECHO.
ECHO zip package
set winrar_cmd= %winrar_bin% -afzip a %package%.zip %package%
%winrar_cmd%
@ECHO.
@ECHO package ready for release!
@ECHO.
@ECHO.
pause
goto mainmenu