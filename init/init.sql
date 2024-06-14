USE [master];
GO

IF NOT EXISTS (SELECT * FROM sys.sql_logins WHERE name = 'root')
BEGIN
    CREATE LOGIN [root] WITH PASSWORD = 'root', CHECK_POLICY = OFF;
    ALTER SERVER ROLE [sysadmin] ADD MEMBER [root];
END
GO
