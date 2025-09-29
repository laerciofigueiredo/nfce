object frmChavesMaquininhas: TfrmChavesMaquininhas
  Left = 545
  Top = 179
  Width = 612
  Height = 414
  Caption = 'Chaves Maquininhas'
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 265
    Width = 596
    Height = 110
    Align = alClient
    DataSource = dsChavesMaquininhas
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
        FieldName = 'MacAndress'
        Title.Caption = 'Descri'#231#227'o'
        Width = 297
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ChaveRegistro'
        Title.Caption = 'Chave Livre'
        Width = 94
        Visible = True
      end>
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 596
    Height = 225
    Align = alTop
    TabOrder = 1
    object Panel3: TPanel
      Left = 1
      Top = 1
      Width = 594
      Height = 48
      Align = alTop
      TabOrder = 0
      object Label1: TLabel
        Left = 186
        Top = 19
        Width = 22
        Height = 13
        Caption = 'Filtro'
      end
      object Label2: TLabel
        Left = 13
        Top = 31
        Width = 154
        Height = 13
        Caption = 'Postos (Unidades Credenciadas)'
      end
      object edtFiltroPosto: TEdit
        Left = 216
        Top = 16
        Width = 113
        Height = 21
        TabOrder = 0
        OnChange = edtFiltroPostoChange
      end
    end
    object DBGrid2: TDBGrid
      Left = 1
      Top = 49
      Width = 594
      Height = 175
      Align = alClient
      DataSource = dsPostos
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
          FieldName = 'NomeFantasia'
          Width = 249
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'RazaoSocial'
          Width = 295
          Visible = True
        end>
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 225
    Width = 596
    Height = 40
    Align = alTop
    TabOrder = 2
    object Label3: TLabel
      Left = 13
      Top = 15
      Width = 93
      Height = 13
      Caption = 'Chaves dispon'#237'veis'
    end
    object btnCriarChave: TButton
      Left = 168
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Criar chave'
      TabOrder = 0
      OnClick = btnCriarChaveClick
    end
    object DBEdit1: TDBEdit
      Left = 384
      Top = 10
      Width = 81
      Height = 21
      DataField = 'ChaveRegistro'
      DataSource = dsChavesMaquininhas
      ReadOnly = True
      TabOrder = 1
    end
  end
  object dsChavesMaquininhas: TDataSource
    DataSet = qChavesMaquininhas
    Left = 208
    Top = 320
  end
  object qChavesMaquininhas: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 208
    Top = 288
  end
  object qPostos: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterScroll = qPostosAfterScroll
    Parameters = <>
    Left = 208
    Top = 104
  end
  object dsPostos: TDataSource
    DataSet = qPostos
    Left = 208
    Top = 136
  end
end
