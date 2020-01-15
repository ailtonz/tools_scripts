USE [DBE2E]
GO
/****** Object:  StoredProcedure [dbo].[gerarControllerBase]    Script Date: 8/6/2018 4:00:43 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER procedure [dbo].[gerarControllerBase] (
    @tablecreate varchar(100)
)
as
begin
declare @primeira varchar(1)
declare @restante  varchar(200)
declare @juncao varchar(200)

SELECT @primeira = lower(substring(@tablecreate, 1,1)) 


SELECT @restante  = substring(@tablecreate, 2,len(@tablecreate))

set @juncao = @primeira+@restante

PRINT '
using BPO.E2E.API.Models;
using BPO.E2E.Entidade;
using BPO.E2E.NegocioInterface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using static BPO.E2E.API.Models.Util;

namespace BPO.E2E.API.Controllers
{
	[Authorize]
    public partial class '+@tablecreate+'Controller : ApiController
    {
        I'+@tablecreate+'Negocio '+@juncao+'Negocio;
		IUsuarioNegocio usuarioNegocio;

        public '+@tablecreate+'Controller(I'+@tablecreate+'Negocio _'+@juncao+'Negocio, IUsuarioNegocio _usuarioNegocio)
        {
            '+@juncao+'Negocio = _'+@juncao+'Negocio;
			usuarioNegocio = _usuarioNegocio;
        }

        [HttpGet]
        public ObjectRetorno Get()
        {
            ObjectRetorno objectRetorno = new ObjectRetorno();
            try
            {
                List<'+@tablecreate+'> saida = '+@juncao+'Negocio.Get();
                if (saida.Count() > 0)
                {
                    objectRetorno.data = saida;
                }
                else
                {
                    objectRetorno = new ObjectRetorno(codeEnum.RetornoVazio);
                }
            }
            catch (Exception ex)
            {
                objectRetorno = new ObjectRetorno(codeEnum.ErroCritico);
                throw;
            }
            return objectRetorno;
        }

        [HttpGet]
        public ObjectRetorno Get(int id)
        {
            ObjectRetorno objectRetorno = new ObjectRetorno();
            try
            {
                '+@tablecreate+' saida = '+@juncao+'Negocio.Get(id);
                if (saida != null)
                {
                    objectRetorno.data = saida;
                }
                else
                {
                    objectRetorno = new ObjectRetorno(codeEnum.RegistroNaoEncontrado);
                }
                
            }
            catch (Exception ex)
            {
                objectRetorno = new ObjectRetorno(codeEnum.ErroCritico);
                throw;
            }
            return objectRetorno;
        }

        [HttpPost]
        public ObjectRetorno Save('+@tablecreate+' entrada)
        {
			Usuario user = usuarioNegocio.BuscarUsuarioByLogin(User.Identity.Name);
			ObjectRetorno objectRetorno = new ObjectRetorno();	
            
            try
            {
                var erros = Util.getValidationErros(entrada);
				if (erros.Count() == 0)
				{
					entrada.DataInclusao = DateTime.Now;
					entrada.IdUsuarioInclusao = user.Id;
					objectRetorno.data = '+@juncao+'Negocio.Save(entrada);
				}
				else
				{
					objectRetorno.data = erros.Select(p => p.ErrorMessage).ToList();
				}     
            }
            catch (Exception ex)
            {
                objectRetorno = new ObjectRetorno(codeEnum.ErroCritico);
                throw;
            }

            return objectRetorno;

        }

        [HttpPost]
        public ObjectRetorno Update('+@tablecreate+' entrada)
        {
			Usuario user = usuarioNegocio.BuscarUsuarioByLogin(User.Identity.Name);
            ObjectRetorno objectRetorno = new ObjectRetorno();
            try
            {
				var erros = Util.getValidationErros(entrada);
                if (erros.Count() == 0)
                {
					entrada.DataAlteracao = DateTime.Now;
					entrada.IdUsuarioAlteracao = user.Id;
                    '+@tablecreate+' saida = '+@juncao+'Negocio.Update(entrada);
                    if (saida != null)
                    {
                        objectRetorno.data = saida;
                    }
                    else
                    {
                        objectRetorno = new ObjectRetorno(codeEnum.RegistroNaoEncontrado);
                    }
                }
                else
                {
                    objectRetorno.data = erros.Select(p => p.ErrorMessage).ToList();
                }
            }
            catch (Exception ex)
            {
                objectRetorno = new ObjectRetorno(codeEnum.ErroCritico);
                throw;
            }
            return objectRetorno;
        }

		[HttpPost]
        public ObjectRetorno Delete(int id)
        {
            ObjectRetorno objectRetorno = new ObjectRetorno();
            try
            {
                '+@juncao+'Negocio.Delete(id);
                objectRetorno = new ObjectRetorno(codeEnum.ResulOk);
            }
            catch (Exception ex)
            {
                objectRetorno = new ObjectRetorno(codeEnum.ErroCritico);
                throw;
            }
            return objectRetorno;
        }
    }
}
'
END