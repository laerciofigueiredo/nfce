object frmRecalcularkml: TfrmRecalcularkml
  Left = 244
  Top = 124
  Width = 1019
  Height = 507
  Caption = 'Recalcular km/l'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1003
    Height = 49
    Align = alTop
    TabOrder = 0
    object lblQtdManipulada: TLabel
      Left = 544
      Top = 16
      Width = 78
      Height = 13
      Caption = 'Qtd Manipulada:'
    end
    object cbAtivarRobo: TCheckBox
      Left = 192
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Ativar Rob'#244
      Checked = True
      State = cbChecked
      TabOrder = 0
    end
    object Button1: TButton
      Left = 304
      Top = 13
      Width = 121
      Height = 25
      Caption = 'Recalcular km'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object Panel3: TPanel
    Left = 0
    Top = 49
    Width = 297
    Height = 419
    Align = alLeft
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 1
      Top = 186
      Width = 295
      Height = 232
      Align = alClient
      DataSource = dsVeiculos
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Descricao'
          Width = 252
          Visible = True
        end>
    end
    object Panel4: TPanel
      Left = 1
      Top = 161
      Width = 295
      Height = 25
      Align = alTop
      Caption = 'Ve'#237'culos'
      TabOrder = 1
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 26
      Width = 295
      Height = 135
      Align = alTop
      DataSource = dsEmpresas
      Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 2
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NomeFantasia'
          Width = 252
          Visible = True
        end>
    end
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 295
      Height = 25
      Align = alTop
      Caption = 'Empresas'
      TabOrder = 3
    end
  end
  object Panel6: TPanel
    Left = 297
    Top = 49
    Width = 706
    Height = 419
    Align = alClient
    TabOrder = 2
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 704
      Height = 24
      Align = alTop
      Caption = 'Autoriza'#231#245'es'
      TabOrder = 0
    end
    object DBGrid3: TDBGrid
      Left = 1
      Top = 25
      Width = 704
      Height = 393
      Align = alClient
      DataSource = dsAutorizacoes
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Nome'
          Width = 139
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'data'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'NumeroCupomFiscal'
          Width = 69
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Quantidade'
          Width = 62
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KmAnterior'
          Width = 61
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KmAtual'
          Width = 54
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Km_l'
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KmPorLitroMinimo'
          Width = 67
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'KmPorLitroMaximo'
          Width = 71
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'ItemAutorizacaoControle_Id'
          Visible = True
        end>
    end
  end
  object qEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterScroll = qEmpresasAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select e.id Empresa_Id, e.NomeFantasia'
      'from   empresas e'
      
        'inner  join contratos c on c.Empresa_Id = e.Id and UnidadeCreden' +
        'ciada_Id = 21'
      'where  not e.id in (65, 59, 67) --Velten, BRSamor e Fibravit '
      'order  by e.NomeFantasia')
    Left = 104
    Top = 97
  end
  object qVeiculos: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterScroll = qVeiculosAfterScroll
    Parameters = <>
    Left = 112
    Top = 329
  end
  object qAutorizacoes: TADOQuery
    Connection = frmDM.ADOConnection1
    CursorType = ctStatic
    Parameters = <>
    SQL.Strings = (
      
        'select p.Nome, a.data, auc.NumeroCupomFiscal, i.Quantidade, i.Km' +
        'Anterior, i.KmAtual,(i.KmAtual-i.KmAnterior)/i.Quantidade Km_l, ' +
        'v.KmPorLitroMinimo, v.KmPorLitroMaximo, i.ItemAutorizacaoControl' +
        'e_Id, i.Id ItemAutorizacao_Id'
      'from   Autorizacoes a'
      'inner  join ItensAutorizacoes i on i.autorizacao_id = a.id'
      
        'inner  join Produtos p on p.id = i.Produto_Id and p.GrupoDeProdu' +
        'to_Id = 1'
      'inner  join Veiculos v on v.Id = a.UnidadeDeControle_Id'
      
        'inner  join AutorizacoesUnidadesCredenciadas auc on auc.Id = a.i' +
        'd'
      'where  a.UnidadeDeControle_Id = 8909'
      'order  by a.Data')
    Left = 505
    Top = 209
    object qAutorizacoesNome: TWideStringField
      FieldName = 'Nome'
      Size = 150
    end
    object qAutorizacoesdata: TDateTimeField
      FieldName = 'data'
    end
    object qAutorizacoesNumeroCupomFiscal: TIntegerField
      FieldName = 'NumeroCupomFiscal'
    end
    object qAutorizacoesQuantidade: TBCDField
      FieldName = 'Quantidade'
      DisplayFormat = '0.00'
      Precision = 15
    end
    object qAutorizacoesKmAnterior: TBCDField
      FieldName = 'KmAnterior'
      DisplayFormat = '0.0'
      Precision = 15
      Size = 3
    end
    object qAutorizacoesKmAtual: TBCDField
      FieldName = 'KmAtual'
      DisplayFormat = '0.0'
      Precision = 15
      Size = 3
    end
    object qAutorizacoesKm_l: TBCDField
      FieldName = 'Km_l'
      ReadOnly = True
      DisplayFormat = '0.00'
      Precision = 36
      Size = 19
    end
    object qAutorizacoesKmPorLitroMinimo: TBCDField
      FieldName = 'KmPorLitroMinimo'
      Precision = 15
      Size = 3
    end
    object qAutorizacoesKmPorLitroMaximo: TBCDField
      FieldName = 'KmPorLitroMaximo'
      Precision = 15
      Size = 3
    end
    object qAutorizacoesItemAutorizacaoControle_Id: TIntegerField
      FieldName = 'ItemAutorizacaoControle_Id'
    end
    object qAutorizacoesItemAutorizacao_Id: TAutoIncField
      FieldName = 'ItemAutorizacao_Id'
      ReadOnly = True
    end
  end
  object dsEmpresas: TDataSource
    DataSet = qEmpresas
    Left = 104
    Top = 129
  end
  object dsVeiculos: TDataSource
    DataSet = qVeiculos
    Left = 112
    Top = 361
  end
  object dsAutorizacoes: TDataSource
    DataSet = qAutorizacoes
    Left = 505
    Top = 241
  end
end
