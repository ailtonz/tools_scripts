#
# DUMP FILE
#
# Database is ported from MS Access
#------------------------------------------------------------------
# Created using "MS Access to MySQL" form http://www.bullzip.com
# Program Version 5.4.274
#
# OPTIONS:
#   sourcefilename=C:\Users\ailton.z.da.silva\OneDrive\_wkspace\dbHigia_Analise_v03.mdb
#   sourceusername=
#   sourcepassword=
#   sourcesystemdatabase=
#   destinationdatabase=dbOperacional
#   storageengine=MyISAM
#   dropdatabase=0
#   createtables=1
#   unicode=1
#   autocommit=1
#   transferdefaultvalues=1
#   transferindexes=1
#   transferautonumbers=1
#   transferrecords=1
#   columnlist=1
#   tableprefix=
#   negativeboolean=0
#   ignorelargeblobs=0
#   memotype=LONGTEXT
#   datetimetype=DATETIME
#

CREATE DATABASE IF NOT EXISTS `dbOperacional`;
USE `dbOperacional`;

#
# Table structure for table 'tbl_Auxiliar_Feriados'
#

DROP TABLE IF EXISTS `tbl_Auxiliar_Feriados`;

CREATE TABLE `tbl_Auxiliar_Feriados` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `DT_FERIADO` DATETIME, 
  `ID_EMPRESA` INTEGER DEFAULT 0, 
  INDEX (`ID_EMPRESA`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Auxiliar_Feriados'
#

INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (1, '2017-12-25 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (2, '2017-11-15 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (3, '2017-11-02 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (4, '2017-10-12 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (5, '2017-09-07 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (6, '2017-06-15 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (7, '2017-05-01 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (8, '2017-04-21 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (9, '2017-04-16 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (10, '2017-04-14 00:00:00', 1);
INSERT INTO `tbl_Auxiliar_Feriados` (`ID`, `DT_FERIADO`, `ID_EMPRESA`) VALUES (11, '2017-01-01 00:00:00', 1);
# 11 records

#
# Table structure for table 'tbl_Clientes'
#

DROP TABLE IF EXISTS `tbl_Clientes`;

CREATE TABLE `tbl_Clientes` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `Nome` VARCHAR(255), 
  `ID_EMPRESA` INTEGER, 
  `CPF_CNPJ` VARCHAR(20), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Clientes'
#

# 0 records

#
# Table structure for table 'tbl_Clientes_Contratos'
#

DROP TABLE IF EXISTS `tbl_Clientes_Contratos`;

CREATE TABLE `tbl_Clientes_Contratos` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_CLIENTE` INTEGER DEFAULT 0, 
  `ID_ENDERECO` INTEGER DEFAULT 0, 
  `ID_CONDICOES` INTEGER DEFAULT 0, 
  `ID_TRANSACAO` INTEGER DEFAULT 0, 
  INDEX (`ID_CLIENTE`), 
  INDEX (`ID_CONDICOES`), 
  INDEX (`ID_ENDERECO`), 
  INDEX (`ID_TRANSACAO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Clientes_Contratos'
#

# 0 records

#
# Table structure for table 'tbl_Clientes_Enderecos'
#

DROP TABLE IF EXISTS `tbl_Clientes_Enderecos`;

CREATE TABLE `tbl_Clientes_Enderecos` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_CLIENTE` INTEGER DEFAULT 0, 
  `ID_ENDERECO` INTEGER DEFAULT 0, 
  INDEX (`ID_CLIENTE`), 
  INDEX (`ID_ENDERECO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Clientes_Enderecos'
#

# 0 records

#
# Table structure for table 'tbl_Contatos'
#

DROP TABLE IF EXISTS `tbl_Contatos`;

CREATE TABLE `tbl_Contatos` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `Nome` VARCHAR(255), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Contatos'
#

# 0 records

#
# Table structure for table 'tbl_Contatos_Meios'
#

DROP TABLE IF EXISTS `tbl_Contatos_Meios`;

CREATE TABLE `tbl_Contatos_Meios` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_USUARIO` INTEGER DEFAULT 0, 
  `ID_MEIOS` INTEGER DEFAULT 0, 
  INDEX (`ID_MEIOS`), 
  INDEX (`ID_USUARIO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Contatos_Meios'
#

# 0 records

#
# Table structure for table 'tbl_Contatos_Meios_Categorias'
#

DROP TABLE IF EXISTS `tbl_Contatos_Meios_Categorias`;

CREATE TABLE `tbl_Contatos_Meios_Categorias` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `DESCRICAO` VARCHAR(255), 
  `ID_EMPRESA` INTEGER, 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Contatos_Meios_Categorias'
#

INSERT INTO `tbl_Contatos_Meios_Categorias` (`ID`, `DESCRICAO`, `ID_EMPRESA`) VALUES (1, 'Celular', 1);
INSERT INTO `tbl_Contatos_Meios_Categorias` (`ID`, `DESCRICAO`, `ID_EMPRESA`) VALUES (2, 'Fixo', 1);
INSERT INTO `tbl_Contatos_Meios_Categorias` (`ID`, `DESCRICAO`, `ID_EMPRESA`) VALUES (3, 'E-mail', 1);
INSERT INTO `tbl_Contatos_Meios_Categorias` (`ID`, `DESCRICAO`, `ID_EMPRESA`) VALUES (4, 'Site', 1);
# 4 records

#
# Table structure for table 'tbl_Empresas'
#

DROP TABLE IF EXISTS `tbl_Empresas`;

CREATE TABLE `tbl_Empresas` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `NOME` VARCHAR(255), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Empresas'
#

INSERT INTO `tbl_Empresas` (`ID`, `NOME`) VALUES (1, 'CIA');
# 1 records

#
# Table structure for table 'tbl_Empresas_Carteira'
#

DROP TABLE IF EXISTS `tbl_Empresas_Carteira`;

CREATE TABLE `tbl_Empresas_Carteira` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_EMPRESA` INTEGER DEFAULT 0, 
  `ID_USUARIO` INTEGER DEFAULT 0, 
  `ID_CLIENTE` INTEGER DEFAULT 0, 
  INDEX (`ID_USUARIO`), 
  INDEX (`ID_CLIENTE`), 
  INDEX (`ID_EMPRESA`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Empresas_Carteira'
#

# 0 records

#
# Table structure for table 'tbl_Enderecos'
#

DROP TABLE IF EXISTS `tbl_Enderecos`;

CREATE TABLE `tbl_Enderecos` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_TIPO_ENDERECOS` INTEGER DEFAULT 0, 
  `CEP` VARCHAR(255), 
  INDEX (`ID_TIPO_ENDERECOS`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Enderecos'
#

# 0 records

#
# Table structure for table 'tbl_Enderecos_Contatos'
#

DROP TABLE IF EXISTS `tbl_Enderecos_Contatos`;

CREATE TABLE `tbl_Enderecos_Contatos` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_ENDERECO` INTEGER DEFAULT 0, 
  `ID_CONTATO` INTEGER DEFAULT 0, 
  INDEX (`ID_ENDERECO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Enderecos_Contatos'
#

# 0 records

#
# Table structure for table 'tbl_Enderecos_Tipo'
#

DROP TABLE IF EXISTS `tbl_Enderecos_Tipo`;

CREATE TABLE `tbl_Enderecos_Tipo` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `Tipo` VARCHAR(255), 
  `ID_EMPRESA` INTEGER, 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Enderecos_Tipo'
#

INSERT INTO `tbl_Enderecos_Tipo` (`ID`, `Tipo`, `ID_EMPRESA`) VALUES (1, 'Filial', 1);
INSERT INTO `tbl_Enderecos_Tipo` (`ID`, `Tipo`, `ID_EMPRESA`) VALUES (2, 'Matriz', 1);
INSERT INTO `tbl_Enderecos_Tipo` (`ID`, `Tipo`, `ID_EMPRESA`) VALUES (3, 'Obra', 1);
INSERT INTO `tbl_Enderecos_Tipo` (`ID`, `Tipo`, `ID_EMPRESA`) VALUES (4, 'Cobrança', 1);
INSERT INTO `tbl_Enderecos_Tipo` (`ID`, `Tipo`, `ID_EMPRESA`) VALUES (5, 'Entrega', 1);
# 5 records

#
# Table structure for table 'tbl_Financeiro_Cobranca'
#

DROP TABLE IF EXISTS `tbl_Financeiro_Cobranca`;

CREATE TABLE `tbl_Financeiro_Cobranca` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_SERVICO_ITEM` INTEGER DEFAULT 0, 
  `ID_CONTRATO` INTEGER DEFAULT 0, 
  INDEX (`ID_SERVICO_ITEM`), 
  INDEX (`ID_CONTRATO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Financeiro_Cobranca'
#

# 0 records

#
# Table structure for table 'tbl_Financeiro_Condicao'
#

DROP TABLE IF EXISTS `tbl_Financeiro_Condicao`;

CREATE TABLE `tbl_Financeiro_Condicao` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `Condicao` VARCHAR(255), 
  `Dias` VARCHAR(255), 
  `ID_EMPRESA` INTEGER DEFAULT 0, 
  INDEX (`ID_EMPRESA`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Financeiro_Condicao'
#

INSERT INTO `tbl_Financeiro_Condicao` (`ID`, `Condicao`, `Dias`, `ID_EMPRESA`) VALUES (1, 'Avista', '0', 1);
INSERT INTO `tbl_Financeiro_Condicao` (`ID`, `Condicao`, `Dias`, `ID_EMPRESA`) VALUES (2, '15 Dias', '15', 1);
INSERT INTO `tbl_Financeiro_Condicao` (`ID`, `Condicao`, `Dias`, `ID_EMPRESA`) VALUES (3, '30 Dias', '30', 1);
INSERT INTO `tbl_Financeiro_Condicao` (`ID`, `Condicao`, `Dias`, `ID_EMPRESA`) VALUES (5, 'Avista + 15 Dias', '0;15', 1);
# 4 records

#
# Table structure for table 'tbl_Financeiro_Movimento'
#

DROP TABLE IF EXISTS `tbl_Financeiro_Movimento`;

CREATE TABLE `tbl_Financeiro_Movimento` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_PLANO` INTEGER DEFAULT 0, 
  `ID_COBRANCA` INTEGER DEFAULT 0, 
  `ID_MOVIMENTO` INTEGER DEFAULT 0, 
  `ID_CONDICAO` INTEGER DEFAULT 0, 
  `ID_TRANSACAO` INTEGER DEFAULT 0, 
  `ID_EMPRESA` INTEGER, 
  INDEX (`ID_COBRANCA`), 
  INDEX (`ID_CONDICAO`), 
  INDEX (`ID_MOVIMENTO`), 
  INDEX (`ID_PLANO`), 
  INDEX (`ID_TRANSACAO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Financeiro_Movimento'
#

# 0 records

#
# Table structure for table 'tbl_Financeiro_Plano_Contas'
#

DROP TABLE IF EXISTS `tbl_Financeiro_Plano_Contas`;

CREATE TABLE `tbl_Financeiro_Plano_Contas` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_EMPRESA` INTEGER DEFAULT 0, 
  `ID_MOVIMENTO` INTEGER DEFAULT 0, 
  `PLANO` VARCHAR(255), 
  INDEX (`ID_EMPRESA`), 
  INDEX (`ID_MOVIMENTO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Financeiro_Plano_Contas'
#

# 0 records

#
# Table structure for table 'tbl_Financeiro_Transacao'
#

DROP TABLE IF EXISTS `tbl_Financeiro_Transacao`;

CREATE TABLE `tbl_Financeiro_Transacao` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `Transacao` VARCHAR(255), 
  `ID_EMPRESA` INTEGER, 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Financeiro_Transacao'
#

INSERT INTO `tbl_Financeiro_Transacao` (`ID`, `Transacao`, `ID_EMPRESA`) VALUES (1, 'Deposito', 1);
INSERT INTO `tbl_Financeiro_Transacao` (`ID`, `Transacao`, `ID_EMPRESA`) VALUES (2, 'Transferencia', 1);
INSERT INTO `tbl_Financeiro_Transacao` (`ID`, `Transacao`, `ID_EMPRESA`) VALUES (3, 'Boleto', 1);
INSERT INTO `tbl_Financeiro_Transacao` (`ID`, `Transacao`, `ID_EMPRESA`) VALUES (4, 'Cartão', 1);
# 4 records

#
# Table structure for table 'tbl_Funcionarios'
#

DROP TABLE IF EXISTS `tbl_Funcionarios`;

CREATE TABLE `tbl_Funcionarios` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_EMPRESA` INTEGER, 
  `ID_CARGO` INTEGER DEFAULT 0, 
  `Nome` VARCHAR(255), 
  INDEX (`ID_CARGO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Funcionarios'
#

# 0 records

#
# Table structure for table 'tbl_Funcionarios_Cargos'
#

DROP TABLE IF EXISTS `tbl_Funcionarios_Cargos`;

CREATE TABLE `tbl_Funcionarios_Cargos` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `Cargo` VARCHAR(255), 
  `ID_EMPRESA` INTEGER DEFAULT 0, 
  INDEX (`ID_EMPRESA`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Funcionarios_Cargos'
#

INSERT INTO `tbl_Funcionarios_Cargos` (`ID`, `Cargo`, `ID_EMPRESA`) VALUES (1, 'Atendente', 1);
INSERT INTO `tbl_Funcionarios_Cargos` (`ID`, `Cargo`, `ID_EMPRESA`) VALUES (2, 'Auxiliar', 1);
INSERT INTO `tbl_Funcionarios_Cargos` (`ID`, `Cargo`, `ID_EMPRESA`) VALUES (3, 'Motorista', 1);
INSERT INTO `tbl_Funcionarios_Cargos` (`ID`, `Cargo`, `ID_EMPRESA`) VALUES (4, 'Gerente', 1);
INSERT INTO `tbl_Funcionarios_Cargos` (`ID`, `Cargo`, `ID_EMPRESA`) VALUES (5, 'Financeiro', 1);
# 5 records

#
# Table structure for table 'tbl_Material'
#

DROP TABLE IF EXISTS `tbl_Material`;

CREATE TABLE `tbl_Material` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `MATERIAL` VARCHAR(255), 
  `ID_EMPRESA` INTEGER, 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Material'
#

INSERT INTO `tbl_Material` (`ID`, `MATERIAL`, `ID_EMPRESA`) VALUES (1, 'Pedra', 1);
INSERT INTO `tbl_Material` (`ID`, `MATERIAL`, `ID_EMPRESA`) VALUES (2, 'Madeira', 1);
INSERT INTO `tbl_Material` (`ID`, `MATERIAL`, `ID_EMPRESA`) VALUES (3, 'Entulho', 1);
INSERT INTO `tbl_Material` (`ID`, `MATERIAL`, `ID_EMPRESA`) VALUES (4, 'Gesso', 1);
# 4 records

#
# Table structure for table 'tbl_Perfis'
#

DROP TABLE IF EXISTS `tbl_Perfis`;

CREATE TABLE `tbl_Perfis` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `Perfil` VARCHAR(255), 
  `ID_EMPRESA` INTEGER, 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Perfis'
#

INSERT INTO `tbl_Perfis` (`ID`, `Perfil`, `ID_EMPRESA`) VALUES (1, 'Atendimento', 1);
INSERT INTO `tbl_Perfis` (`ID`, `Perfil`, `ID_EMPRESA`) VALUES (2, 'Roteiro', 1);
INSERT INTO `tbl_Perfis` (`ID`, `Perfil`, `ID_EMPRESA`) VALUES (3, 'Financeiro', 1);
INSERT INTO `tbl_Perfis` (`ID`, `Perfil`, `ID_EMPRESA`) VALUES (4, 'Gerencia', 1);
# 4 records

#
# Table structure for table 'tbl_Solicitacoes_Agenda'
#

DROP TABLE IF EXISTS `tbl_Solicitacoes_Agenda`;

CREATE TABLE `tbl_Solicitacoes_Agenda` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_CLIENTE` INTEGER DEFAULT 0, 
  `ID_ENDERECO` INTEGER NOT NULL DEFAULT 0, 
  `ID_MATERIAL` INTEGER DEFAULT 0, 
  `QD_MATERIAL` INTEGER DEFAULT 0, 
  `DT_SOLICITACAO` DATETIME, 
  `ID_STATUS` TINYINT(1) DEFAULT 0, 
  INDEX (`ID_CLIENTE`), 
  INDEX (`ID_ENDERECO`), 
  INDEX (`ID_MATERIAL`), 
  INDEX (`ID_STATUS`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Solicitacoes_Agenda'
#

# 0 records

#
# Table structure for table 'tbl_Solicitacoes_Servicos'
#

DROP TABLE IF EXISTS `tbl_Solicitacoes_Servicos`;

CREATE TABLE `tbl_Solicitacoes_Servicos` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_ITEM` INTEGER DEFAULT 0, 
  `ID_VEICULO` INTEGER DEFAULT 0, 
  `ID_FUNCIONARIO` INTEGER DEFAULT 0, 
  `ID_STATUS` TINYINT(1) DEFAULT 0, 
  `DT_SERVICO` DATETIME, 
  INDEX (`ID_FUNCIONARIO`), 
  INDEX (`ID_ITEM`), 
  INDEX (`ID_STATUS`), 
  INDEX (`ID_VEICULO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Solicitacoes_Servicos'
#

# 0 records

#
# Table structure for table 'tbl_Solicitacoes_Servicos_Itens'
#

DROP TABLE IF EXISTS `tbl_Solicitacoes_Servicos_Itens`;

CREATE TABLE `tbl_Solicitacoes_Servicos_Itens` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_AGENDA` INTEGER DEFAULT 0, 
  `ID_STATUS` TINYINT(1) DEFAULT 0, 
  INDEX (`ID_AGENDA`), 
  INDEX (`ID_STATUS`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Solicitacoes_Servicos_Itens'
#

# 0 records

#
# Table structure for table 'tbl_Usuarios'
#

DROP TABLE IF EXISTS `tbl_Usuarios`;

CREATE TABLE `tbl_Usuarios` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_EMPRESA` INTEGER DEFAULT 0, 
  `Nome` VARCHAR(255), 
  INDEX (`ID_EMPRESA`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Usuarios'
#

# 0 records

#
# Table structure for table 'tbl_Usuarios_Perfis'
#

DROP TABLE IF EXISTS `tbl_Usuarios_Perfis`;

CREATE TABLE `tbl_Usuarios_Perfis` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `ID_PERFIL` INTEGER, 
  `ID_USUARIO` INTEGER DEFAULT 0, 
  INDEX (`ID_PERFIL`), 
  INDEX (`ID_USUARIO`), 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Usuarios_Perfis'
#

# 0 records

#
# Table structure for table 'tbl_Veiculos'
#

DROP TABLE IF EXISTS `tbl_Veiculos`;

CREATE TABLE `tbl_Veiculos` (
  `ID` INTEGER NOT NULL AUTO_INCREMENT, 
  `Placa` VARCHAR(255), 
  `ID_EMPRESA` INTEGER, 
  PRIMARY KEY (`ID`)
) ENGINE=myisam DEFAULT CHARSET=utf8;

SET autocommit=1;

#
# Dumping data for table 'tbl_Veiculos'
#

# 0 records

