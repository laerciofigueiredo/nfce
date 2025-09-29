object frmEmpresas: TfrmEmpresas
  Left = 2456
  Top = 198
  Width = 848
  Height = 601
  Caption = 'Empresas'
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
    Width = 832
    Height = 57
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 24
      Width = 25
      Height = 13
      Caption = 'Filtrar'
    end
    object btnAtivarDesativar: TButton
      Left = 328
      Top = 24
      Width = 113
      Height = 25
      Caption = 'Ativar/Desativar'
      TabOrder = 0
      OnClick = btnAtivarDesativarClick
    end
    object edtFiltro: TEdit
      Left = 88
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 1
      OnChange = edtFiltroChange
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 57
    Width = 832
    Height = 505
    Align = alClient
    DataSource = dsEmpresas
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDrawColumnCell = DBGrid1DrawColumnCell
    Columns = <
      item
        Expanded = False
        FieldName = 'nomefantasia'
        Width = 245
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'razaosocial'
        Width = 329
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Cidade'
        Width = 117
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'UF'
        Width = 34
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Ativo'
        Width = 58
        Visible = True
      end>
  end
  object qEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      
        'select id, nomefantasia, razaosocial, Cidade, uf, Ativo, DataUlt' +
        'imaAlteracao'
      'from   empresas '
      'order  by nomefantasia')
    Left = 144
    Top = 176
  end
  object dsEmpresas: TDataSource
    DataSet = qEmpresas
    Left = 144
    Top = 208
  end
end
