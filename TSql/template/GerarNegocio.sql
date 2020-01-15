USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[GerarNegocio]    Script Date: 8/6/2018 4:05:19 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

ALTER procedure [dbo].[GerarNegocio] (
    @tablecreate varchar(100),
	@context varchar(100)
)
as
begin

	SET NOCOUNT ON;  
  
	PRINT 'using System.Collections.Generic;
using BPO.E2E.NegocioInterface;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using BPO.E2E.Entidade;
using BPO.E2E.Negocio;
using System;
using System.Data.Entity;

namespace BPO.E2E.Negocio
{
    internal partial class '+@tablecreate+'Negocio : I'+@tablecreate+'Negocio
    {       
        public virtual '+@tablecreate+' Save('+@tablecreate+' entrada)
        {
            using ('+@context+' context = new '+@context+'())
            {
                try
                {
                    context.'+@tablecreate+'.Add(entrada);
                    context.SaveChanges();
                }
                catch (Exception ex)
                {

                    throw;
                }
            }
            return entrada;
        }

        public List<'+@tablecreate+'> Get()
        {
            List<'+@tablecreate+'> saida = new List<'+@tablecreate+'>();
            using ('+@context+' context = new '+@context+'())
            {
                saida = context.'+@tablecreate+'.ToList();
            }
            return saida;
        }

        public '+@tablecreate+' Get(int id)
        {
            using ('+@context+' context = new '+@context+'())
            {
                return context.'+@tablecreate+'.Where(u => u.Id == id).FirstOrDefault();
            }
        }

        public void Delete(int id)
        {
            using ('+@context+' context = new '+@context+'())
            {
                var object_delete = new '+@tablecreate+' { Id = id };
                context.Entry(object_delete).State = EntityState.Deleted;
                context.SaveChanges();
            }
        }

        public '+@tablecreate+' Update('+@tablecreate+' entrada)
        {
            using ('+@context+' context = new '+@context+'())
            {
                var object_update = context.'+@tablecreate+'.Where(u => u.Id == entrada.Id).FirstOrDefault();

                if (object_update != null)
                {
                    context.Entry(object_update).CurrentValues.SetValues(entrada);
                    context.SaveChanges();
                }
                else
                {
                    entrada = null;
                }
            }

            return entrada;

        }
    }
}
'
end