object frmCorrigirValorAutorizacaoPelosItens: TfrmCorrigirValorAutorizacaoPelosItens
  Left = 3137
  Top = 302
  Width = 626
  Height = 495
  Caption = 'Corrigir Valor Autorizacao Pelos Itens'
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
    Width = 610
    Height = 81
    Align = alTop
    TabOrder = 0
    object btCorrigir: TButton
      Left = 232
      Top = 24
      Width = 75
      Height = 25
      Caption = 'Corrigir'
      TabOrder = 0
      OnClick = btCorrigirClick
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 81
    Width = 610
    Height = 375
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
        FieldName = 'id'
        Width = 76
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorAutorizado'
        Width = 94
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ValorItens'
        Width = 82
        Visible = True
      end>
  end
  object qAutorizacoes: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      ''
      'select a.id, auc.ValorAutorizado, sum(ia.Valor) ValorItens'
      'from   Autorizacoes a'
      
        'inner  join AutorizacoesUnidadesCredenciadas auc on auc.id = a.i' +
        'd'
      'inner  join ItensAutorizacoes ia on ia.Autorizacao_Id = a.id'
      'where  a.data between '#39'2022-09-12'#39' and '#39'2022-09-19'#39' '
      'group  by a.id, auc.ValorAutorizado'
      'having auc.ValorAutorizado <> sum(ia.Valor)')
    Left = 176
    Top = 160
  end
  object dsAutorizacoes: TDataSource
    DataSet = qAutorizacoes
    Left = 176
    Top = 192
  end
end
