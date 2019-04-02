EXEC sp_configure 'contained database authentication', 1
GO
RECONFIGURE
GO
PRINT 'RECONFIGURE statement has run successfully.'
GO