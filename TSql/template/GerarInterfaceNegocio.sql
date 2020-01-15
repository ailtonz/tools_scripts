USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[GerarInterfaceNegocio]    Script Date: 8/6/2018 4:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GerarInterfaceNegocio] (
    @tablecreate varchar(100)
)
as
begin

	SET NOCOUNT ON;  
  
	PRINT 'using BPO.E2E.Entidade;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace BPO.E2E.NegocioInterface
{
    public partial interface I'+@tablecreate+'Negocio
    {
        '+@tablecreate+' Save('+@tablecreate+' entrada);

        List<'+@tablecreate+'> Get();

        void Delete(int id);

        '+@tablecreate+' Update('+@tablecreate+' model);

        '+@tablecreate+' Get(int id);
    }
}
'
end