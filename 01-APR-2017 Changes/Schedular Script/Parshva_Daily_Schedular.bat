
:: ECHO  "*******Scheduling script started ON" %date% %time% >> "F:\sTUDy\@MyWorks\Projects\Parshva Design\Dbscript\parshva_scheduling_log.txt"
:: SQLCMD -E -S LOCALHOST\SQLSERVER -i "F:\sTUDy\@MyWorks\Projects\Parshva Design\Dbscript\Parshva_Schedule_Script.sql"  >> "F:\sTUDy\@MyWorks\Projects\Parshva Design\Dbscript\parshva_scheduling_log.txt"
::  ECHO  "******* Scheduling script ENDED ON" %date% %time% >> "F:\sTUDy\@MyWorks\Projects\Parshva Design\Dbscript\parshva_scheduling_log.txt"

set logpath="F:\sTUDy\@MyWorks\Projects\Parshva Design\01-APR-2017 Changes\Schedular Script\parshva_scheduling_log.txt"
echo  "Log file Path :" %logpath%  >> %logpath%
 ECHO  "*******Scheduling script started ON" %date% %time% >> %logpath%
SQLCMD -E -S localhost\SQLSERVER -i "F:\sTUDy\@MyWorks\Projects\Parshva Design\01-APR-2017 Changes\Schedular Script\Parshva_Schedule_Script.sql"  >> %logpath%
 ECHO  "******* Scheduling script ENDED ON" %date% %time% >> %logpath%
