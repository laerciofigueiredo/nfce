object frmAssociarCartoes: TfrmAssociarCartoes
  Left = 501
  Top = 116
  Width = 587
  Height = 517
  Caption = 'Associar Cart'#245'es'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 571
    Height = 478
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 569
      Height = 168
      Align = alTop
      TabOrder = 0
      DesignSize = (
        569
        168)
      object Label1: TLabel
        Left = 16
        Top = 13
        Width = 68
        Height = 13
        Caption = 'Filtrar empresa'
      end
      object edtFiltroEmpresa: TEdit
        Left = 95
        Top = 10
        Width = 138
        Height = 21
        TabOrder = 0
        OnChange = edtFiltroEmpresaChange
      end
      object DBGrid1: TDBGrid
        Left = 1
        Top = 41
        Width = 563
        Height = 120
        Anchors = [akLeft, akTop, akRight, akBottom]
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
            Width = 40
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NomeFantasia'
            Width = 158
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'RazaoSocial'
            Width = 319
            Visible = True
          end>
      end
    end
    object Panel3: TPanel
      Left = 1
      Top = 169
      Width = 569
      Height = 308
      Align = alClient
      TabOrder = 1
      object DBGrid2: TDBGrid
        Left = 1
        Top = 42
        Width = 567
        Height = 224
        Align = alClient
        DataSource = dsVeiculos
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        OnCellClick = DBGrid2CellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'Placa'
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Identificador'
            Width = 106
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NumerodoCartao'
            Width = 138
            Visible = True
          end>
      end
      object Panel4: TPanel
        Left = 1
        Top = 1
        Width = 567
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object Label2: TLabel
          Left = 31
          Top = 13
          Width = 54
          Height = 13
          Caption = 'Filtrar placa'
        end
        object edtPlaca: TEdit
          Left = 95
          Top = 10
          Width = 94
          Height = 21
          TabOrder = 0
          OnChange = edtPlacaChange
        end
        object rbSemCartao: TRadioButton
          Left = 240
          Top = 11
          Width = 89
          Height = 17
          Caption = 'Sem cart'#227'o'
          Checked = True
          TabOrder = 1
          TabStop = True
          OnClick = rbSemCartaoClick
        end
      end
      object Panel5: TPanel
        Left = 1
        Top = 266
        Width = 567
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 2
        object Label3: TLabel
          Left = 16
          Top = 13
          Width = 124
          Height = 13
          Caption = '5 '#250'ltimos d'#237'gitos do cart'#227'o'
        end
        object edtDigitos: TEdit
          Left = 152
          Top = 10
          Width = 73
          Height = 21
          TabOrder = 0
          Text = '5'
        end
        object btAssociar: TButton
          Left = 240
          Top = 8
          Width = 75
          Height = 25
          Caption = 'Associar'
          Default = True
          TabOrder = 1
          OnClick = btAssociarClick
        end
      end
    end
  end
  object qEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    Filtered = True
    AfterScroll = qEmpresasAfterScroll
    Parameters = <>
    SQL.Strings = (
      'select e.id, e.nomefantasia, e.razaosocial'
      'from   empresas e'
      'order  by e.nomefantasia')
    Left = 145
    Top = 65
  end
  object dsEmpresas: TDataSource
    DataSet = qEmpresas
    Left = 145
    Top = 97
  end
  object qVeiculos: TADOQuery
    Connection = frmDM.ADOConnection1
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      'select e.id, e.nomefantasia, e.razaosocial'
      'from   empresas e'
      'order  by e.nomefantasia')
    Left = 153
    Top = 265
  end
  object dsVeiculos: TDataSource
    DataSet = qVeiculos
    Left = 153
    Top = 297
  end
end
