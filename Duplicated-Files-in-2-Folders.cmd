@echo OFF
SETLOCAL

:DropFolder1
ECHO Drag and drop the Folder from which you would like to remove the Duplicates
SET /p Folder1= 
IF '%Folder1%' == '' ( 
	ECHO You entered an empty message, so please
	goto DropFolder1
)
SET Folder1=%Folder1:~1,-1%

:DropFolder2
ECHO Drag and drop the 2nd Folder
SET /p Folder2= 
IF '%Folder2%' == '' ( 
	ECHO You entered an empty message, so please
	goto DropFolder2
)
SET Folder2=%Folder2:~1,-1%


SET /A nbrFolder1=0
setlocal ENABLEDELAYEDEXPANSION
FOR %%n IN ("%Folder1%\*") DO (
	SET /A nbrFolder1=nbrFolder1+1
)
SET /A nbrFolder2=0
FOR %%n IN ("%Folder2%\*") DO (
	SET /A nbrFolder2=nbrFolder2+1
)
SET /A product=!nbrFolder1!*!nbrFolder2!
SET /A estimatedTime=%product%*25/10000
SET /A estimatedTimeLeft=%estimatedTime%*7/10
SET /A estimatedTimeRight=%estimatedTime%*13/10
SET /A estimatedTimeLeftMinutes=%estimatedTimeLeft%/60
SET /A estimatedTimeRightMinutes=%estimatedTimeRight%/60
ECHO Estimated Duration between:
ECHO %estimatedTimeLeft% - %estimatedTimeRight% secondes
ECHO %estimatedTimeLeftMinutes% - %estimatedTimeRightMinutes% minutes

pause Start Duplicate Search ?
ECHO Start Time :
TIME /T
ECHO Searching for duplicated files...
FOR %%f IN ("%Folder1%\*") DO FOR %%d IN ("%Folder2%\*") DO (
	IF "%%~nf" == "%%~nd" (
		MD "%%~dpfDuplicates" 2>NUL
		MOVE "%%f" "%%~dpfDuplicates" >NUL
		ECHO Duplicate Found: %%~nf and moved to the "Duplicates" Directory
	)
)
ECHO Done :)
pause