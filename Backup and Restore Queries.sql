
/*
-- Registering the Mapped Network Path on SQL Server Management Studio
-- Read more: http://developmentsimplyput.blogspot.com/2012/11/restorebackup-sql-database-fromto.html#ixzz45WgQ2gxq
EXEC sp_configure 'show advanced options', 1
GO
RECONFIGURE
GO
EXEC sp_configure 'xp_cmdshell', 1
GO
RECONFIGURE
GO
EXEC XP_CMDSHELL 'net use N: /delete'
EXEC XP_CMDSHELL 'net use N: \\SqlShare\ContosoUniversity\'
EXEC XP_CMDSHELL 'Dir N:'
*/



/*
	Backup
*/
BACKUP DATABASE [ContosoUniversity]
TO DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\Backup\Localhost_ContosoUniversity_20160408.bak'
WITH FORMAT,
	 MEDIANAME = 'ContosoUniversity',
     NAME = 'Full Backup of ContosoUniversity';
GO



/*
	Restore from Network Share
*/
RESTORE DATABASE [ContosoUniversity] 
FROM DISK = N'\\SqlShare\ContosoUniversity\ContosoUniversity_20160324_003350.bak'
WITH  FILE = 1,
MOVE N'ContosoUniversity'
TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity.mdf',
MOVE N'ContosoUniversity2'
TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity_1.ndf',
MOVE N'ContosoUniversity_Log'
TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity_log.ldf',
NOUNLOAD, STATS = 10;
GO



/*
	Restore from Local Disk
*/
RESTORE DATABASE [ContosoUniversity] 
FROM DISK = N'C:\ContosoUniversity_20160324_003350.bak'
WITH  FILE = 1,
MOVE N'ContosoUniversity'
TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity.mdf',
MOVE N'ContosoUniversity2'
TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity_1.ndf',
MOVE N'ContosoUniversity_Log'
TO N'C:\Program Files\Microsoft SQL Server\MSSQL12.MSSQLSERVER2014\MSSQL\DATA\ContosoUniversity_log.ldf',
NOUNLOAD, STATS = 10;
GO
