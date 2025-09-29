object frmCorrecaoDeAutorizacoes: TfrmCorrecaoDeAutorizacoes
  Left = 2917
  Top = 260
  Width = 926
  Height = 517
  Caption = 'Corre'#231#227'o de Autoriza'#231#245'es da VELTEN'
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
    Width = 910
    Height = 89
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 411
      Top = 42
      Width = 72
      Height = 13
      Caption = 'Filtrar por placa'
    end
    object Label3: TLabel
      Left = 176
      Top = 24
      Width = 39
      Height = 13
      Caption = 'Semana'
    end
    object Label4: TLabel
      Left = 273
      Top = 42
      Width = 6
      Height = 13
      Caption = 'a'
    end
    object edtPlaca: TEdit
      Left = 491
      Top = 39
      Width = 97
      Height = 21
      TabOrder = 3
      OnChange = edtPlacaChange
    end
    object Panel3: TPanel
      Left = 24
      Top = 16
      Width = 145
      Height = 65
      BevelOuter = bvNone
      TabOrder = 0
      object rbPCL: TRadioButton
        Left = 8
        Top = 11
        Width = 57
        Height = 17
        Caption = 'PCL'
        Checked = True
        TabOrder = 0
        TabStop = True
        OnClick = AbrirConsulta
      end
      object rbGegel: TRadioButton
        Left = 8
        Top = 35
        Width = 57
        Height = 17
        Caption = 'Gegel'
        TabOrder = 1
        OnClick = AbrirConsulta
      end
      object rbMorada: TRadioButton
        Left = 64
        Top = 35
        Width = 73
        Height = 17
        Caption = 'Morada'
        TabOrder = 3
        OnClick = AbrirConsulta
      end
      object rbRedevax: TRadioButton
        Left = 64
        Top = 11
        Width = 73
        Height = 17
        Caption = 'Redevax'
        TabOrder = 2
        OnClick = AbrirConsulta
      end
    end
    object edtDataIni: TDateTimePicker
      Left = 176
      Top = 40
      Width = 89
      Height = 21
      Date = 44936.555062928240000000
      Format = 'yyyy-MM-dd'
      Time = 44936.555062928240000000
      TabOrder = 1
    end
    object edtDataFim: TDateTimePicker
      Left = 288
      Top = 40
      Width = 89
      Height = 21
      Date = 44936.555062928240000000
      Format = 'yyyy-MM-dd'
      Time = 44936.555062928240000000
      TabOrder = 2
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 89
    Width = 910
    Height = 292
    Align = alClient
    DataSource = dsAutorizacoes
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
        FieldName = 'empresa'
        Width = 142
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NomeFantasia'
        Width = 208
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'placa'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'data'
        Width = 69
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'produto'
        Width = 142
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
        FieldName = 'valor'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NumeroCupomFiscal'
        Title.Caption = 'Cupom'
        Width = 59
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 381
    Width = 910
    Height = 97
    Align = alBottom
    TabOrder = 2
    object Label2: TLabel
      Left = 172
      Top = 35
      Width = 24
      Height = 13
      Caption = 'Valor'
    end
    object edtValor: TEdit
      Left = 208
      Top = 32
      Width = 97
      Height = 21
      TabOrder = 0
      OnKeyPress = edtValorKeyPress
    end
    object btnCorrigirValor: TButton
      Left = 316
      Top = 29
      Width = 105
      Height = 25
      Caption = 'Corrigir Valor'
      TabOrder = 1
      OnClick = btnCorrigirValorClick
    end
    object btSomar: TButton
      Left = 536
      Top = 32
      Width = 75
      Height = 25
      Caption = 'Somar'
      TabOrder = 2
      OnClick = btSomarClick
    end
    object edtSoma: TEdit
      Left = 624
      Top = 32
      Width = 81
      Height = 21
      Enabled = False
      TabOrder = 3
    end
  end
  object qAutorizacoes: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterOpen = qAutorizacoesAfterOpen
    AfterClose = qAutorizacoesAfterClose
    AfterScroll = qAutorizacoesAfterScroll
    Parameters = <>
    Left = 312
    Top = 176
  end
  object dsAutorizacoes: TDataSource
    DataSet = qAutorizacoes
    Left = 312
    Top = 208
  end
end
