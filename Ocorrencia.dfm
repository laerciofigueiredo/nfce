object frmOcorrencia: TfrmOcorrencia
  Left = 393
  Top = 156
  Width = 512
  Height = 372
  Caption = 'Ocorr'#234'ncia'
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
  object Posto: TLabel
    Left = 88
    Top = 32
    Width = 31
    Height = 13
    Caption = 'Posto*'
  end
  object Label1: TLabel
    Left = 89
    Top = 154
    Width = 60
    Height = 13
    Caption = 'Vencimento*'
  end
  object Label2: TLabel
    Left = 89
    Top = 206
    Width = 54
    Height = 13
    Caption = 'Pagamento'
  end
  object Label3: TLabel
    Left = 88
    Top = 88
    Width = 48
    Height = 13
    Caption = 'Empresa *'
  end
  object DBEdit1: TDBEdit
    Left = 88
    Top = 168
    Width = 121
    Height = 21
    DataField = 'DataVencimento'
    DataSource = dsOcorrencias
    TabOrder = 2
  end
  object DBLookupComboBox1: TDBLookupComboBox
    Left = 88
    Top = 48
    Width = 265
    Height = 21
    DataField = 'UnidadeCredenciada_Id'
    DataSource = dsOcorrencias
    KeyField = 'Id'
    ListField = 'NomeFantasia'
    ListSource = dsUnidadesCredenciadas
    TabOrder = 0
  end
  object DBLookupComboBox2: TDBLookupComboBox
    Left = 88
    Top = 104
    Width = 265
    Height = 21
    DataField = 'Empresa_Id'
    DataSource = dsOcorrencias
    KeyField = 'Id'
    ListField = 'NomeFantasia'
    ListSource = dsEmpresas
    TabOrder = 1
  end
  object btSalvar: TButton
    Left = 240
    Top = 288
    Width = 75
    Height = 25
    Caption = 'Salvar'
    TabOrder = 4
    OnClick = btSalvarClick
  end
  object DBEdit2: TDBEdit
    Left = 88
    Top = 224
    Width = 121
    Height = 21
    DataField = 'DataPagamento'
    DataSource = dsOcorrencias
    TabOrder = 3
  end
  object qOcorrencias: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 376
    Top = 24
  end
  object dsOcorrencias: TDataSource
    DataSet = qOcorrencias
    Left = 408
    Top = 24
  end
  object qUnidadesCredenciadas: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 376
    Top = 56
  end
  object dsUnidadesCredenciadas: TDataSource
    DataSet = qUnidadesCredenciadas
    Left = 408
    Top = 56
  end
  object qEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 376
    Top = 88
  end
  object dsEmpresas: TDataSource
    DataSet = qEmpresas
    Left = 408
    Top = 88
  end
end
