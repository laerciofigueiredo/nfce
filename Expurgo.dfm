object frmExpurgo: TfrmExpurgo
  Left = 2276
  Top = 247
  Width = 1431
  Height = 755
  Align = alClient
  Caption = 'Exclus'#227'o de empresas inativas'
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
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 449
    Height = 716
    Align = alLeft
    TabOrder = 0
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 447
      Height = 64
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 48
        Top = 24
        Width = 25
        Height = 13
        Caption = 'Filtrar'
      end
      object btnExpurgar: TButton
        Left = 288
        Top = 20
        Width = 113
        Height = 25
        Caption = 'Expurgar'
        TabOrder = 0
        OnClick = btnExpurgarClick
      end
      object edtFiltro: TEdit
        Left = 88
        Top = 24
        Width = 121
        Height = 21
        TabOrder = 1
      end
    end
    object DBGrid1: TDBGrid
      Left = 1
      Top = 65
      Width = 447
      Height = 650
      Align = alClient
      DataSource = dsEmpresas
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
          FieldName = 'Id'
          Width = 42
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'nomefantasia'
          Width = 167
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DataDeCadastro'
          Title.Caption = 'Data Cadastro'
          Width = 86
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'DataUltimoAbastecimento'
          Title.Caption = 'Ultimo Abastecimento'
          Width = 110
          Visible = True
        end>
    end
  end
  object Panel3: TPanel
    Left = 449
    Top = 0
    Width = 966
    Height = 716
    Align = alClient
    TabOrder = 1
    object Memo1: TMemo
      Left = 1
      Top = 1
      Width = 964
      Height = 714
      Align = alClient
      TabOrder = 0
    end
  end
  object qEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      'select id, nomefantasia, razaosocial, Ativo, DataDeCadastro'
      'from   empresas '
      'order  by nomefantasia')
    Left = 32
    Top = 128
  end
  object dsEmpresas: TDataSource
    DataSet = qEmpresas
    Left = 32
    Top = 160
  end
end
