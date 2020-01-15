USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[GerarEntidade]    Script Date: 8/6/2018 4:01:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--select so.name Tabela, sc.name Coluna,sc.length, sc.isnullable,sc. from sysobjects so 
--inner join syscolumns sc on so.id = sc.id 
--inner join systypes st on st.xtype = sc.xtype 
--where so.xtype = 'U' 
--and so.name = 'area' 
ALTER PROCEDURE [dbo].[GerarEntidade] (@tablecreate VARCHAR(100)) 
AS 
  BEGIN 
      SET nocount ON; 

      DECLARE @Tabela     NVARCHAR(50), 
              @Coluna     NVARCHAR(50), 
              @length     INT, 
              @isnullable BIT, 
              @Tipo       NVARCHAR(50), 
              @colorder   INT 

      PRINT 'using System; using System.Collections.Generic; using System.ComponentModel.DataAnnotations; using System.ComponentModel.DataAnnotations.Schema; using System.Data.Entity.Spatial; using System.Runtime.Serialization; namespace BPO.E2E.Entidade { [Table("' + @tablecreate 
            + '")] [DataContract] public partial class ' + @tablecreate + ' { '; 

      DECLARE vendor_cursor CURSOR FOR 
        SELECT so.NAME Tabela, 
               sc.NAME Coluna, 
               sc.length, 
               sc.isnullable, 
               st.NAME tipo, 
               sc.colorder 
        FROM   sysobjects so 
               INNER JOIN syscolumns sc 
                       ON so.id = sc.id 
               INNER JOIN systypes st 
                       ON st.xtype = sc.xtype 
        WHERE  so.xtype = 'U' 
               AND so.NAME = @tablecreate 
               AND st.status = 0 
        ORDER  BY sc.colorder 

      OPEN vendor_cursor 

      FETCH next FROM vendor_cursor INTO @Tabela, @Coluna, @length, @isnullable, 
      @tipo, @colorder 

      WHILE @@FETCH_STATUS = 0 
        BEGIN 
            --inicio tipo --aqu 
            DECLARE @tipoconvertido VARCHAR(200) = @Tipo 

            IF( @Tipo = 'varchar' 
                 OR @Tipo = 'nvarchar' 
                 OR @Tipo = 'text' ) 
              BEGIN 
                  SET @tipoconvertido = 'string' 

                  IF( @length = -1 ) 
                    BEGIN 
                        SET @length = 8000 
                    END 
              END 

            IF( @Tipo = 'nvarchar' ) 
              BEGIN 
                  SET @tipoconvertido = 'string' 

                  IF( @length = -1 ) 
                    BEGIN 
                        SET @length = 4000 
                    END 
              END 
            ELSE IF( @Tipo = 'smalldatetime' ) 
              BEGIN 
                  SET @tipoconvertido = 'DateTime' 
              END 
            ELSE IF( @Tipo = 'bit' ) 
              BEGIN 
                  SET @tipoconvertido = 'bool' 
              END 
            ELSE IF( @Tipo = 'datetime' ) 
              BEGIN 
                  SET @tipoconvertido = 'DateTime' 
              END 

            IF( @colorder = 1 ) 
              BEGIN 
                  PRINT '	[Key]' 
              END 

            PRINT '	[Column("' + @Coluna + '")]' 

            IF( @Tipo = 'varchar' ) 
              BEGIN 
                  PRINT '	[StringLength(' 
                        + Cast(@length AS VARCHAR(50)) + ')]' 
              END 

            IF( @isnullable = 0 
                AND @colorder > 1 ) 
              BEGIN 
                  DECLARE @descriptioncampo VARCHAR(8000) 

                  SELECT @descriptioncampo = Cast(sep.value AS VARCHAR(8000)) 
                  FROM   sys.tables st 
                         INNER JOIN sys.columns sc 
                                 ON st.object_id = sc.object_id 
                         LEFT JOIN sys.extended_properties sep 
                                ON st.object_id = sep.major_id 
                                   AND sc.column_id = sep.minor_id 
                                   AND sep.NAME = 'MS_Description' 
                  WHERE  st.NAME = @tablecreate 
                         AND sc.NAME = @Coluna 

                  IF( @descriptioncampo IS NULL ) 
                    BEGIN 
                        SET @descriptioncampo = @Coluna 
                    END 

                  PRINT '	[Required(ErrorMessage = "Informe o ' 
                        + @descriptioncampo + '")]' 
              END 

            DECLARE @nomeClasseFK VARCHAR(800) 
            DECLARE @column_nameFK VARCHAR(800) 

            SET @nomeClasseFK = '' 
            SET @column_nameFK = '' 

            IF ( @colorder > 1 ) 
              BEGIN 
                  SELECT @column_nameFK = ccu.column_name 
                  FROM   information_schema.constraint_column_usage ccu 
                         INNER JOIN information_schema.referential_constraints 
                                    rc 
                                 ON ccu.constraint_name = rc.constraint_name 
                         INNER JOIN information_schema.key_column_usage kcu 
                                 ON kcu.constraint_name = 
                                    rc.unique_constraint_name 
                  WHERE  ccu.table_name = @tablecreate 
                         AND ccu.column_name = @Coluna 

                  IF( @column_nameFK IS NOT NULL 
                      AND @column_nameFK != '' ) 
                    BEGIN 
                        SET @nomeClasseFK = '	[ForeignKey("' 
                                            + Replace(@column_nameFK, 'Id', '') 
                                            + 
                                            '")]'; 
                    END 
                  ELSE 
                    BEGIN 
                        SET @column_nameFK = '' 
                        SET @nomeClasseFK = '' 
                    END 
              END 

            IF( @nomeClasseFK != '' ) 
              BEGIN 
                  PRINT @nomeClasseFK 
              END 

            DECLARE @variableNull VARCHAR(1) 

            SET @variableNull = '' 

            IF( @isnullable = 1 
                AND ( @tipoconvertido = 'int' 
                       OR @tipoconvertido = 'decimal' 
                       OR @tipoconvertido = 'DateTime' 
                       OR @tipoconvertido = 'bool' ) ) 
              BEGIN 
                  SET @variableNull='? ' 
              END 

            PRINT '	[DataMember]' 

            IF ( @colorder = 1 ) 
              BEGIN 
                  PRINT '	public ' + @tipoconvertido 
                        + ' Id { get; set; }' 
              END 
            ELSE 
              BEGIN 
                  PRINT '	public ' + @tipoconvertido + @variableNull 
                        + ' ' + @Coluna + ' { get; set; }' 
              END 

            PRINT '	' 

            FETCH next FROM vendor_cursor INTO @Tabela, @Coluna, @length, 
            @isnullable, 
            @tipo, @colorder 
        END 

      CLOSE vendor_cursor; 

      DEALLOCATE vendor_cursor; 

      DECLARE @SourceColumn VARCHAR(100), 
              @TabelaFk     VARCHAR(100) 
      DECLARE fk_cursor CURSOR FOR 
        SELECT 
        --ccu.table_name AS SourceTable 
        --,ccu.constraint_name AS SourceConstraint 
        ccu.column_name AS SourceColumn, 
        kcu.table_name  AS TargetTable 
        --,kcu.column_name AS TargetColumn 
        FROM   information_schema.constraint_column_usage ccu 
               INNER JOIN information_schema.referential_constraints rc 
                       ON ccu.constraint_name = rc.constraint_name 
               INNER JOIN information_schema.key_column_usage kcu 
                       ON kcu.constraint_name = rc.unique_constraint_name 
        WHERE  ccu.table_name = @tablecreate 

      OPEN fk_cursor 

      FETCH next FROM fk_cursor INTO @SourceColumn, @TabelaFk 

      WHILE @@FETCH_STATUS = 0 
        BEGIN 
            PRINT '	[DataMember]' 

            PRINT '	public ' + @TabelaFk + ' ' 
                  + Replace(@SourceColumn, 'Id', '') 
                  + ' { get; set; }' 

            PRINT '	' 

            FETCH next FROM fk_cursor INTO @SourceColumn, @TabelaFk 
        END 

      CLOSE fk_cursor; 

      DEALLOCATE fk_cursor; 

      PRINT '	} }' 
  END 