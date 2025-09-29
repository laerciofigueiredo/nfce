object frmCoringasZZZ: TfrmCoringasZZZ
  Left = 393
  Top = 128
  Width = 700
  Height = 540
  Caption = 'Coringas ZZZ'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 684
    Height = 501
    Align = alClient
    DataSource = dsCoringas
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
        FieldName = 'placa'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Descricao'
        Width = 253
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NomeFantasia'
        Title.Caption = 'Empresa'
        Width = 212
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Id'
        Width = 70
        Visible = True
      end>
  end
  object qCoringas: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      '--LISTA TODOS OS CORINGAS DO PADR'#195'O ZZZ0Z EM ORDEM'
      'select v.Id, v.placa, u.Descricao, e.NomeFantasia'
      'from   UnidadesDeControles u'
      'inner  join Veiculos v on v.id = u.id'
      'inner  join CentrosDeCustos cc on cc.id = u.CentroDeCusto_Id '
      'inner  join Empresas e on e.id = cc.Empresa_Id '
      'where  v.placa like '#39'ZZZ0Z%'#39
      'order  by v.Placa desc')
    Left = 208
    Top = 72
  end
  object dsCoringas: TDataSource
    DataSet = qCoringas
    Left = 208
    Top = 104
  end
end
