USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[ModeloPaginacao]    Script Date: 8/6/2018 4:05:57 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE [dbo].[ModeloPaginacao]
									/* 1) SEUS PARAMETROS */

									/*PARAMETROS FIXOS*/
									@OrderByCampo         NVARCHAR(100),
                                    @OrderbySort          NVARCHAR(4),
                                    @NumPagina         INT = 0,
                                    @QtdeRegistros		  INT = 0

AS
BEGIN
	
	DECLARE @sql_command NVARCHAR(MAX);
	DECLARE @consulta	NVARCHAR(MAX);
	DECLARE @parameters NVARCHAR(MAX);

	/* 2) INSIRA SUA QUERY AQUI */
	SET @consulta = 'SELECT * FROM TABELA WHERE 1 = 1';

	SET @sql_command = 
		
				'SELECT	*	
				FROM   (
		
								SELECT Row_number()
										OVER (ORDER BY ' + @orderByCampo + ' ' + @orderbySort + ') AS RowNum,
										*,
										CASE WHEN @QtdeRegistros = 0 THEN 1
										ELSE
											CEILING((COUNT(*) OVER())/CAST(@QtdeRegistros AS DECIMAL)) 
										END AS TOTALPAGE,
										COUNT(*) OVER() AS TOTALREG	
								FROM 
								( ' + @consulta + ') TEMP

						) TABELA_SELECT

				WHERE 
					(@NumPagina = 0 OR @QtdeRegistros = 0) OR
					((TABELA_SELECT.RowNum <= (@NumPagina * @QtdeRegistros) AND
					TABELA_SELECT.RowNum > ((@NumPagina - 1) * @QtdeRegistros))) 

				ORDER  BY RowNum';

	PRINT @sql_command;

						
	SET @parameters =   N'' +
						/* 3) SEUS PARAMETROS */

						/* PARAMETROS FIXOS */
						'@OrderByCampo         NVARCHAR(100),
						@OrderbySort           NVARCHAR(4),
						@NumPagina         INT,
						@QtdeRegistros		  INT'

	EXEC sp_executesql	@sql_command, @parameters, 
						/* 4) SEUS PARAMETROS */
 
						/* PARAMETROS FIXOS */
						@OrderByCampo, @OrderbySort, @NumPagina, @QtdeRegistros

END