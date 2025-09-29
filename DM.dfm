object frmDM: TfrmDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 379
  Top = 369
  Height = 310
  Width = 516
  object ADOConnection1: TADOConnection
    ConnectionString = 
      'Provider=SQLNCLI11.1;Persist Security Info=False;User ID=sa;Init' +
      'ial Catalog=GekomDev;Data Source=sistema.gekom.com.br;Use Proced' +
      'ure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstati' +
      'on ID=LAERCIO-UBOOK;Initial File Name="";Use Encryption for Data' +
      '=False;Tag with column collation when possible=False;MARS Connec' +
      'tion=False;DataTypeCompatibility=0;Trust Server Certificate=Fals' +
      'e;Server SPN="";Application Intent=READWRITE;'
    LoginPrompt = False
    Provider = 'SQLNCLI11.1'
    Left = 48
    Top = 48
  end
  object qVeiculo: TADOQuery
    Connection = ADOConnection1
    Parameters = <
      item
        Name = 'Placa'
        Size = -1
        Value = Null
      end
      item
        Name = 'Empresa_Id'
        Size = -1
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'select uc.Id, uc.Descricao, uc.CentroDeCusto_Id'
      'from   Veiculos v'
      'inner  join UnidadesDeControles uc on uc.id = v.id'
      'where  v.Placa = :Placa'
      '  and  uc.Empresa_Id = :Empresa_Id')
    Left = 320
    Top = 48
  end
  object qProdutoIntegracao: TADOQuery
    Connection = ADOConnection1
    Parameters = <
      item
        Name = 'NomeProduto'
        Size = -1
        Value = Null
      end>
    Prepared = True
    SQL.Strings = (
      'select p.Id, p.Nome'
      'from   IntegracaoProdutos i'
      'inner  join Produtos p on p.Id = i.Produto_Id'
      'where  i.NomeProduto = :NomeProduto')
    Left = 408
    Top = 48
  end
  object qAux: TADOQuery
    Connection = ADOConnection1
    ParamCheck = False
    Parameters = <>
    Left = 152
    Top = 152
  end
  object qProdutos: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'select Id, Nome'
      'from   Produtos'
      'where  Ativo = 1'
      'order  by Nome ')
    Left = 248
    Top = 152
  end
  object dsProdutos: TDataSource
    DataSet = qProdutos
    Left = 248
    Top = 200
  end
end
