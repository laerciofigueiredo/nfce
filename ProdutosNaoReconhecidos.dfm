object frmProdutosNaoReconhecidos: TfrmProdutosNaoReconhecidos
  Left = 2885
  Top = 300
  Width = 671
  Height = 508
  Caption = 'Produtos N'#227'o Reconhecidos'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 416
    Width = 655
    Height = 53
    Align = alBottom
    TabOrder = 0
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 329
    Height = 416
    Align = alLeft
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 327
      Height = 41
      Align = alTop
      Caption = 'PRODUTOS NAO RECONHECIDOS'
      TabOrder = 0
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 42
      Width = 327
      Height = 373
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object Panel4: TPanel
    Left = 329
    Top = 0
    Width = 326
    Height = 416
    Align = alClient
    TabOrder = 2
    object Panel5: TPanel
      Left = 1
      Top = 1
      Width = 324
      Height = 41
      Align = alTop
      Caption = 'PRODUTOS GEKOM'
      TabOrder = 0
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 42
      Width = 324
      Height = 373
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
    end
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 144
    Top = 144
  end
end
