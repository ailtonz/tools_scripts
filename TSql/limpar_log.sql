


-- 1) Colocar o nome do banco que deseja limpar o log no comando USE
-- 2) Pegar o campo Name do arquivo de Log com o comando abaixo
USE DB_SISCOB; 
SELECT * FROM sysfiles 
GO
 
-- 3) Colocar o nome do banco que deseja limpar o log nas variáves 
-- 4) Colocar o nome do arquivo de log na variável da linha SHRINKFILE
USE DB_SISCOB;
GO
ALTER DATABASE db_churn
SET RECOVERY SIMPLE;
GO
DBCC SHRINKFILE (DB_SISCOB_log, 1);
GO
ALTER DATABASE DB_SISCOB
SET RECOVERY FULL;
GO