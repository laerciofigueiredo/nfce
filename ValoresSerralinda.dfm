object frmValoresSerralinda: TfrmValoresSerralinda
  Left = 3189
  Top = 179
  Width = 580
  Height = 647
  Caption = 'Valores a faturar Serralinda'
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
    Width = 564
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 80
      Top = 16
      Width = 19
      Height = 13
      Caption = 'Ano'
    end
    object Label2: TLabel
      Left = 128
      Top = 16
      Width = 20
      Height = 13
      Caption = 'M'#234's'
    end
    object edtAno: TMaskEdit
      Left = 80
      Top = 32
      Width = 37
      Height = 21
      EditMask = '!0000;1;_'
      MaxLength = 4
      TabOrder = 0
      Text = '2022'
      OnChange = FecharConsultas
    end
    object edtMes: TMaskEdit
      Left = 128
      Top = 32
      Width = 36
      Height = 21
      EditMask = '!00;1;_'
      MaxLength = 2
      TabOrder = 1
      Text = ' 8'
      OnChange = FecharConsultas
    end
    object rbPrimeiraQuinzena: TRadioButton
      Left = 205
      Top = 8
      Width = 89
      Height = 17
      Caption = '1a Quinzena'
      Checked = True
      TabOrder = 2
      TabStop = True
      OnClick = FecharConsultas
    end
    object rbSegundaQuinzena: TRadioButton
      Left = 205
      Top = 27
      Width = 89
      Height = 17
      Caption = '2a Quinzena'
      TabOrder = 3
      OnClick = FecharConsultas
    end
    object btPesquisar: TButton
      Left = 203
      Top = 54
      Width = 94
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 4
      OnClick = btPesquisarClick
    end
    object UpDown1: TUpDown
      Left = 164
      Top = 32
      Width = 16
      Height = 21
      Associate = edtMes
      Min = 1
      Max = 12
      Position = 8
      TabOrder = 5
    end
    object Memo1: TMemo
      Left = 336
      Top = 0
      Width = 228
      Height = 89
      Align = alRight
      Color = clInfoBk
      Lines.Strings = (
        'Empresas com cart'#227'o que precisam ser '
        'inclu'#237'das no controle Serralinda:')
      TabOrder = 6
      Visible = False
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 89
    Width = 564
    Height = 128
    Align = alTop
    DataSource = dsCalculos
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'NomeFantasia'
        Width = 230
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'faturar_gekom'
        Width = 93
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'faturar_nfce'
        Width = 89
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 217
    Width = 564
    Height = 391
    Align = alClient
    TabOrder = 2
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 562
      Height = 40
      Align = alTop
      TabOrder = 0
      object Label3: TLabel
        Left = 72
        Top = 14
        Width = 68
        Height = 13
        Caption = 'Filtrar empresa'
      end
      object edtFiltroEmpresa: TEdit
        Left = 152
        Top = 10
        Width = 121
        Height = 21
        TabOrder = 0
        OnChange = edtFiltroEmpresaChange
      end
      object btSalvarEmArquivoi: TButton
        Left = 336
        Top = 8
        Width = 145
        Height = 25
        Caption = 'Salvar em arquivo'
        TabOrder = 1
        OnClick = btSalvarEmArquivoiClick
      end
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 41
      Width = 562
      Height = 349
      Align = alClient
      DataSource = dsValoresEmpresas
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'NomeFantasia'
          Title.Caption = 'Empresa'
          Width = 239
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'faturar_gekom'
          Title.Caption = 'Total Gekom'
          Width = 94
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'faturar_nfce'
          Title.Caption = 'Total NFCE'
          Width = 95
          Visible = True
        end>
    end
  end
  object qCalculos: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 280
    Top = 136
  end
  object dsCalculos: TDataSource
    DataSet = qCalculos
    Left = 280
    Top = 168
  end
  object qValoresEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 288
    Top = 355
  end
  object dsValoresEmpresas: TDataSource
    DataSet = qValoresEmpresas
    Left = 288
    Top = 387
  end
end
