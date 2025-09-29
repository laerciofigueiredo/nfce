object frmPlacasNaoCadastradas: TfrmPlacasNaoCadastradas
  Left = 3070
  Top = 277
  Width = 724
  Height = 420
  Caption = 'Placas N'#227'o Cadastradas'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 708
    Height = 41
    Align = alTop
    TabOrder = 0
    object btRefresh: TButton
      Left = 272
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Refresh'
      TabOrder = 0
      OnClick = btRefreshClick
    end
    object btCadastrarVeiculo: TButton
      Left = 80
      Top = 8
      Width = 113
      Height = 25
      Caption = 'Cadastrar Ve'#237'culo'
      TabOrder = 1
      OnClick = btCadastrarVeiculoClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 708
    Height = 311
    Align = alClient
    DataSource = dsPlacasNaoCadastradas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Empresa_Id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NomeFantasia'
        Width = 240
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Placa'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'JaExisteNaEmpresa'
        Width = 271
        Visible = True
      end>
  end
  object pnlRodape: TPanel
    Left = 0
    Top = 352
    Width = 708
    Height = 29
    Align = alBottom
    TabOrder = 2
  end
  object qPlacasNaoCadastradas: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterOpen = qPlacasNaoCadastradasAfterOpen
    Parameters = <>
    SQL.Strings = (
      'select distinct e. id, e.NomeFantasia, n.Placa'#10
      'from   Nfce n'#10
      'inner  join ItensNfce i on i.Nfce_Id = n.id'#10
      'inner  join Empresas e on e.CpfOuCnpj = n.CnpjDestinatario'#10
      'where  not exists(select * '#10
      '                  from   veiculos v '#10
      #9#9#9#9'  inner  join UnidadesDeControles u on u.id = v.id '#10
      #9#9#9#9'  inner  join Empresas p on p.id = u.Empresa_Id'#10
      #9#9#9#9'  where  p.id = e.id'#10
      #9#9#9#9'    and  v.placa = n.placa)'#10
      'order  by e.NomeFantasia, n.Placa')
    Left = 272
    Top = 176
  end
  object dsPlacasNaoCadastradas: TDataSource
    DataSet = qPlacasNaoCadastradas
    Left = 272
    Top = 216
  end
end
