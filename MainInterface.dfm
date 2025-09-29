object frmMainInterface: TfrmMainInterface
  Left = 2818
  Top = 366
  Width = 1021
  Height = 591
  Caption = 'frmMainInterface'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  WindowState = wsMaximized
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel4: TPanel
    Left = 0
    Top = 0
    Width = 1005
    Height = 552
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 331
      Width = 1003
      Height = 220
      Align = alBottom
      BevelOuter = bvNone
      Color = clInfoBk
      TabOrder = 0
      object grdAutorizacoes: TDBGrid
        Left = 0
        Top = 22
        Width = 1003
        Height = 154
        Align = alClient
        DataSource = dsAutorizacao
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NomeFantasia'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RazaoSocial'
            Width = 186
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NumeroCupomFiscal'
            Width = 66
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Data'
            Width = 89
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Placa'
            Width = 77
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'KmAtual'
            Width = 52
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NomeProduto'
            Width = 103
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Quantidade'
            Width = 54
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorUnitario'
            Width = 52
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Valor'
            Width = 62
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ConferidoNfce'
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ItemAutorizacao_Id'
            Visible = True
          end>
      end
      object pnlAcoes: TPanel
        Left = 0
        Top = 176
        Width = 1003
        Height = 44
        Align = alBottom
        Color = clInfoBk
        TabOrder = 1
        object btAutorizacaoConferida: TButton
          Left = 360
          Top = 7
          Width = 129
          Height = 29
          Caption = 'Sincronizar Autoriza'#231#227'o'
          TabOrder = 0
          OnClick = btAutorizacaoConferidaClick
        end
        object btInserirAutorizacao: TButton
          Left = 504
          Top = 6
          Width = 153
          Height = 29
          Caption = 'Inserir Autoriza'#231#227'o'
          TabOrder = 1
          OnClick = btInserirAutorizacaoClick
        end
        object cbAtivarRobo: TCheckBox
          Left = 265
          Top = 15
          Width = 81
          Height = 17
          Caption = 'Ativar Rob'#244
          TabOrder = 2
          OnClick = cbAtivarRoboClick
        end
      end
      object pnlAutorizacoes: TPanel
        Left = 0
        Top = 0
        Width = 1003
        Height = 22
        Align = alTop
        BevelOuter = bvNone
        Caption = 'AUTORIZA'#199#213'ES'
        Color = clInfoBk
        TabOrder = 2
      end
    end
    object Panel6: TPanel
      Left = 1
      Top = 297
      Width = 1003
      Height = 34
      Align = alBottom
      Color = clMoneyGreen
      TabOrder = 1
      object lblProduto: TLabel
        Left = 23
        Top = 9
        Width = 60
        Height = 13
        Caption = 'PRODUTO: '
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object panelProdutos: TPanel
        Left = 670
        Top = 1
        Width = 332
        Height = 32
        Align = alRight
        Color = clMoneyGreen
        TabOrder = 0
        object cbProdutos: TDBLookupComboBox
          Left = 31
          Top = 4
          Width = 145
          Height = 21
          KeyField = 'Id'
          ListField = 'Nome'
          ListSource = frmDM.dsProdutos
          TabOrder = 0
        end
        object btIncluirProduto: TButton
          Left = 186
          Top = 5
          Width = 97
          Height = 23
          Caption = 'Incluir Produto'
          TabOrder = 1
          OnClick = btIncluirProdutoClick
        end
      end
      object cbManterVeiculo: TCheckBox
        Left = 296
        Top = 9
        Width = 169
        Height = 17
        Caption = 'Manter ve'#237'culo da autoriza'#231#227'o'
        TabOrder = 1
        OnClick = cbManterVeiculoClick
      end
      object cbNaoFiltrarPeloProduto: TCheckBox
        Left = 480
        Top = 8
        Width = 129
        Height = 17
        Caption = 'N'#227'o filtrar pelo produto'
        TabOrder = 2
      end
    end
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 1003
      Height = 287
      Align = alClient
      Color = clSkyBlue
      TabOrder = 2
      object DBGrid1: TDBGrid
        Left = 1
        Top = 49
        Width = 1001
        Height = 201
        Align = alClient
        DataSource = dsNfce
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'NomeFantasia'
            Width = 156
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RazaoSocial'
            Width = 178
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NumeroNF'
            Width = 59
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'DataEmissao'
            Width = 100
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Placa'
            Width = 70
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Km'
            Width = 56
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NomeProduto'
            Width = 101
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'QtdProduto'
            Width = 49
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorUnitario'
            Width = 52
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ValorTotal'
            Width = 59
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Conferido_ItemNfce'
            Width = 95
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'UnidadeCredenciada_Id'
            Width = 75
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Empresa_Id'
            Width = 67
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ItemAutorizacao_Id'
            Width = 69
            Visible = True
          end>
      end
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 1001
        Height = 48
        Align = alTop
        Color = clSkyBlue
        TabOrder = 1
        object Label1: TLabel
          Left = 20
          Top = 17
          Width = 103
          Height = 13
          Caption = 'CUPONS FISCAIS'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
        object cbNaoConferidos: TCheckBox
          Left = 184
          Top = 15
          Width = 145
          Height = 17
          Caption = 'Apenas os n'#227'o conferidos'
          TabOrder = 0
        end
        object cbGegel: TCheckBox
          Left = 346
          Top = 24
          Width = 54
          Height = 17
          Caption = 'Gegel'
          TabOrder = 1
        end
        object cbPCL: TCheckBox
          Left = 346
          Top = 6
          Width = 45
          Height = 17
          Caption = 'PCL'
          TabOrder = 2
        end
        object cbMorada: TCheckBox
          Left = 405
          Top = 24
          Width = 65
          Height = 17
          Caption = 'Morada'
          TabOrder = 3
        end
        object cbRedevax: TCheckBox
          Left = 405
          Top = 6
          Width = 73
          Height = 17
          Caption = 'Redevax'
          TabOrder = 4
        end
        object cbFiltrarDatas: TCheckBox
          Left = 511
          Top = 15
          Width = 77
          Height = 17
          Caption = 'Filtrar datas'
          Checked = True
          State = cbChecked
          TabOrder = 5
          OnClick = cbFiltrarDatasClick
        end
        object pnlDatas: TPanel
          Left = 599
          Top = 5
          Width = 210
          Height = 37
          ParentColor = True
          TabOrder = 6
          object Label2: TLabel
            Left = 102
            Top = 13
            Width = 6
            Height = 13
            Caption = 'a'
          end
          object edDataInicio: TDateTimePicker
            Left = 10
            Top = 8
            Width = 89
            Height = 21
            Date = 44795.000000000000000000
            Format = 'yyyy-MM-dd'
            Time = 44795.000000000000000000
            TabOrder = 0
          end
          object edDataFim: TDateTimePicker
            Left = 112
            Top = 8
            Width = 89
            Height = 21
            Date = 44795.000000000000000000
            Format = 'yyyy-MM-dd'
            Time = 44795.000000000000000000
            TabOrder = 1
          end
        end
        object btCarregar: TButton
          Left = 823
          Top = 12
          Width = 75
          Height = 25
          Caption = 'Carregar'
          TabOrder = 7
          OnClick = btCarregarClick
        end
      end
      object Panel8: TPanel
        Left = 1
        Top = 250
        Width = 1001
        Height = 36
        Align = alBottom
        BevelOuter = bvNone
        Color = clSkyBlue
        TabOrder = 2
        object lblQtdRegistros: TLabel
          Left = 8
          Top = 13
          Width = 61
          Height = 13
          Caption = 'QtdRegistros'
        end
        object btPlacasNaoCadastradas: TButton
          Left = 864
          Top = 8
          Width = 123
          Height = 25
          Caption = 'Placas n'#227'o cadastradas'
          TabOrder = 0
          OnClick = btPlacasNaoCadastradasClick
        end
        object btRecalcularkml: TButton
          Left = 744
          Top = 8
          Width = 97
          Height = 25
          Caption = 'Recalcular km/l'
          TabOrder = 1
          OnClick = btRecalcularkmlClick
        end
      end
    end
    object Panel10: TPanel
      Left = 1
      Top = 288
      Width = 1003
      Height = 9
      Align = alBottom
      Color = clBlack
      TabOrder = 3
    end
  end
  object qNfce: TADOQuery
    AutoCalcFields = False
    Connection = frmDM.ADOConnection1
    CursorType = ctStatic
    AfterScroll = qNfceAfterScroll
    ParamCheck = False
    Parameters = <>
    Prepared = True
    SQL.Strings = (
      
        'select uc.Id as UnidadeCredenciada_Id, uc.NomeFantasia, e.Id as ' +
        'Empresa_Id, e.RazaoSocial, '
      '       n.NumeroNF, n.DataEmissao, n.Placa, n.Km,'
      
        '       i.NomeProduto, i.QtdProduto, i.ValorUnitario, i.ValorTota' +
        'l,  '
      
        '       i.ConferidoNfce as Conferido_ItemNfce, i.Id as ItemNfce_I' +
        'd, i.ItemAutorizacao_Id, Nfce_Id'
      'from   Nfce n'
      'inner  join ItensNfce i on i.Nfce_Id = n.id'
      'inner  join UnidadesCredenciadas uc on uc.Cnpj = n.CnpjEmitente'
      'inner  join Empresas e on e.CpfOuCnpj = n.CnpjDestinatario'
      'where  uc.Id in (21) --, 18)'
      '  and  n.Status = '#39'Emitido'#39
      '  --and  i.ConferidoNfce = 0'
      '  and  n.DataEmissao between '#39'2022-08-15'#39' and '#39'2022-08-17'#39
      'order  by uc.NomeFantasia, e.RazaoSocial, DataEmissao')
    Left = 240
    Top = 112
  end
  object dsNfce: TDataSource
    AutoEdit = False
    DataSet = qNfce
    Left = 272
    Top = 112
  end
  object qAutorizacao: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Prepared = True
    SQL.Strings = (
      
        'select a.Id as Autorizacao_Id, a.Data, NumeroCupomFiscal as Cupo' +
        'm, v.Placa, ia.Quantidade, ia.Valor, ia.KmAtual,'
      '       ia.Id as ItemAutorizacao_Id, a.UnidadeDeControle_Id'
      'from   Autorizacoes a'
      
        'inner  join AutorizacoesUnidadesCredenciadas auc on auc.Id = a.I' +
        'd'
      
        'inner  join UnidadesDeControles uc on uc.Id = a.UnidadeDeControl' +
        'e_Id'
      'inner  join Veiculos v on v.Id = uc.Id'
      'inner  join ItensAutorizacoes ia on ia.Autorizacao_Id = a.id'
      '')
    Left = 240
    Top = 440
  end
  object dsAutorizacao: TDataSource
    DataSet = qAutorizacao
    Left = 273
    Top = 440
  end
end
