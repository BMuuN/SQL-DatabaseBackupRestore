/*
    Title:
    	Database Restore
    
    Created By:
    	Bleddyn Richards

    Description:
        Restore database backup (*.bak) from a local or network location.

    Notes:
		1) You need to run each step in isolation.  Do run run the entire script.
		2) Ensure the directory "C:\DB_BACKUPS" exists on your local machine.
		3) Step 1 and 2 only need to be ran once.  You do not need to run these steps each time you execute the script.
		4) Once Step 3 in completed ensure you alter the database name in Step 4.
*/

-- Step: 1
-- Enable advanced options
sp_configure 'show advanced options', 1
RECONFIGURE
GO

-- Step: 2
-- Enable command shell
sp_configure 'xp_cmdshell', 1
RECONFIGURE
GO

-- Step: 3
-- Copy latest backup file from the share. 

-- Copy the latest file
--EXEC master..xp_cmdshell 'robocopy \\SqlShare\ContosoUniversity\ C:\DB_BACKUPS\ /b /xo /r:10 /zb /XJD /XJF /maxage:1'

-- Copy a specific file
--EXEC master.dbo.xp_cmdshell 'COPY /Y \\SqlShare\ContosoUniversity\ContosoUniversity_20160424_002427.bak C:\DB_BACKUPS\ContosoUniversity_20160424_002427.bak'

-- Copy the latest file
EXEC master.dbo.xp_cmdshell 'FOR /F "delims=|" %I IN (''DIR "\\SqlShare\ContosoUniversity\*.bak" /B /O:-D'') DO COPY /Y "\\SqlShare\ContosoUniversity\%I" "C:\DB_BACKUPS\%I" & EXIT'
GO

-- Step: 4
-- Restore the database on the local machine.
USE [master]
RESTORE DATABASE [ContosoUniversity] 
FROM  DISK = N'C:\DB_BACKUPS\ContosoUniversity_20160424_002427.bak' 
--FROM DISK = N'\\SqlShare\ContosoUniversity\ContosoUniversity_20160424_002427.bak'
WITH  FILE = 1,  
MOVE N'ContosoUniversity' TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity.mdf',  
MOVE N'ContosoUniversity2' TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity_1.ndf', 
MOVE N'ContosoUniversity_log' TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity.ldf',  
NOUNLOAD,  STATS = 5
GO
