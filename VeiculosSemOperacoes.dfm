object frmVeiculosSemOperacoes: TfrmVeiculosSemOperacoes
  Left = 2809
  Top = 238
  Width = 900
  Height = 624
  Caption = 'Ve'#237'culos sem opera'#231#245'es - para inativar'
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
  object TPanel
    Left = 0
    Top = 0
    Width = 884
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 112
      Top = 24
      Width = 59
      Height = 13
      Caption = 'EMPRESAS'
    end
    object Label2: TLabel
      Left = 345
      Top = 24
      Width = 359
      Height = 13
      Caption = 'VE'#205'CULOS / EQUIPAMENTOS SEM OPERA'#199#213'ES H'#193' MAIS DE 2 MESES'
    end
  end
  object TPanel
    Left = 0
    Top = 41
    Width = 884
    Height = 503
    Align = alClient
    TabOrder = 1
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 328
      Height = 501
      Align = alLeft
      TabOrder = 0
      object gridEmpresas: TDBGrid
        Left = 1
        Top = 1
        Width = 326
        Height = 499
        Align = alClient
        DataSource = dsEmpresas
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
            FieldName = 'Empresa'
            Width = 205
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'MaiorData'
            Width = 69
            Visible = True
          end>
      end
    end
    object DBGrid1: TDBGrid
      Left = 329
      Top = 1
      Width = 554
      Height = 501
      Align = alClient
      DataSource = dsUnidadesDeControle
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
          FieldName = 'Descricao'
          Width = 378
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MaiorData'
          Width = 70
          Visible = True
        end>
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 544
    Width = 884
    Height = 41
    Align = alBottom
    TabOrder = 2
    object btInativarEmpresa: TButton
      Left = 88
      Top = 8
      Width = 121
      Height = 25
      Caption = 'Inativar Empresa'
      TabOrder = 0
      OnClick = btInativarEmpresaClick
    end
    object btInativarVeiculo: TButton
      Left = 576
      Top = 8
      Width = 113
      Height = 25
      Caption = 'Inativar Ve'#237'culo'
      TabOrder = 1
      OnClick = btInativarVeiculoClick
    end
  end
  object qEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterScroll = qEmpresasAfterScroll
    Parameters = <>
    Left = 128
    Top = 224
  end
  object dsEmpresas: TDataSource
    DataSet = qEmpresas
    Left = 128
    Top = 256
  end
  object qUnidadesDeControle: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 560
    Top = 232
  end
  object dsUnidadesDeControle: TDataSource
    DataSet = qUnidadesDeControle
    Left = 560
    Top = 264
  end
end
