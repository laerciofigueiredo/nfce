object frmOcorrencias: TfrmOcorrencias
  Left = 216
  Top = 112
  Width = 1071
  Height = 567
  Caption = 'An'#225'lise de Cr'#233'dito de Empresas'
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
  object Label10: TLabel
    Left = 328
    Top = 96
    Width = 97
    Height = 16
    Alignment = taRightJustify
    Caption = #218'ltima consulta :'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBText4: TDBText
    Left = 432
    Top = 96
    Width = 161
    Height = 17
    DataField = 'DataConsulta'
    DataSource = dsSerasa
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 1055
    Height = 528
    Align = alClient
    Color = 15790305
    TabOrder = 0
    object DBText1: TDBText
      Left = 336
      Top = 17
      Width = 689
      Height = 17
      Alignment = taCenter
      DataField = 'CpfOuCnpj'
      DataSource = dsEmpresas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object DBText2: TDBText
      Left = 336
      Top = 41
      Width = 689
      Height = 17
      Alignment = taCenter
      DataField = 'RazaoSocial'
      DataSource = dsEmpresas
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object GroupBox1: TGroupBox
      Left = 336
      Top = 72
      Width = 689
      Height = 201
      Caption = ' Informa'#231#245'es Serasa '
      Color = clWhite
      ParentColor = False
      TabOrder = 0
      object DBText3: TDBText
        Left = 144
        Top = 24
        Width = 105
        Height = 17
        DataField = 'DataConsulta'
        DataSource = dsSerasa
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label9: TLabel
        Left = 40
        Top = 24
        Width = 97
        Height = 16
        Alignment = taRightJustify
        Caption = #218'ltima consulta :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 95
        Top = 48
        Width = 42
        Height = 16
        Alignment = taRightJustify
        Caption = 'Score :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText5: TDBText
        Left = 144
        Top = 48
        Width = 161
        Height = 17
        DataField = 'ScoreSerasa'
        DataSource = dsSerasa
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label12: TLabel
        Left = 12
        Top = 72
        Width = 125
        Height = 16
        Alignment = taRightJustify
        Caption = 'Prob. Inadimpl'#234'ncia :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText6: TDBText
        Left = 144
        Top = 72
        Width = 25
        Height = 17
        DataField = 'ProbabilidadeInadimplencia'
        DataSource = dsSerasa
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label13: TLabel
        Left = 173
        Top = 72
        Width = 12
        Height = 16
        Alignment = taRightJustify
        Caption = '%'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label14: TLabel
        Left = 31
        Top = 96
        Width = 106
        Height = 16
        Alignment = taRightJustify
        Caption = 'Risco de Cr'#233'dito :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText7: TDBText
        Left = 144
        Top = 96
        Width = 161
        Height = 17
        DataField = 'RiscoDeCredito'
        DataSource = dsSerasa
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object Label15: TLabel
        Left = 52
        Top = 120
        Width = 85
        Height = 16
        Alignment = taRightJustify
        Caption = 'Interpreta'#231#227'o :'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object DBText8: TDBText
        Left = 144
        Top = 120
        Width = 529
        Height = 17
        DataField = 'InterpretacaoSerasa'
        DataSource = dsSerasa
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
      end
      object btAbrirConsulta: TBitBtn
        Left = 64
        Top = 160
        Width = 137
        Height = 25
        Caption = 'Abrir Consulta Serasa'
        TabOrder = 0
        OnClick = btAbrirConsultaClick
      end
    end
    object GroupBox2: TGroupBox
      Left = 1
      Top = 280
      Width = 1053
      Height = 247
      Align = alBottom
      Caption = ' Informa'#231#245'es Gekom '
      Color = clCream
      ParentColor = False
      TabOrder = 1
      object Panel3: TPanel
        Left = 16
        Top = 15
        Width = 458
        Height = 218
        Color = clWhite
        TabOrder = 0
        object Label3: TLabel
          Left = 56
          Top = 70
          Width = 91
          Height = 16
          Alignment = taRightJustify
          Caption = '150 e 180 dias :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 56
          Top = 94
          Width = 91
          Height = 16
          Alignment = taRightJustify
          Caption = '120 e 150 dias :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 56
          Top = 118
          Width = 90
          Height = 16
          Alignment = taRightJustify
          Caption = '  90 e 120 dias :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label6: TLabel
          Left = 62
          Top = 142
          Width = 83
          Height = 16
          Alignment = taRightJustify
          Caption = '  60 e 90 dias :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 62
          Top = 166
          Width = 83
          Height = 16
          Alignment = taRightJustify
          Caption = '  30 e 60 dias :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label8: TLabel
          Left = 51
          Top = 190
          Width = 94
          Height = 16
          Alignment = taRightJustify
          Caption = #250'ltimos 30 dias :'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label2: TLabel
          Left = 178
          Top = 46
          Width = 32
          Height = 16
          Alignment = taRightJustify
          Caption = 'Litros'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 88
          Top = 16
          Width = 213
          Height = 20
          Caption = 'Dados de Consumo e Atrasos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object Label18: TLabel
          Left = 252
          Top = 46
          Width = 46
          Height = 16
          Alignment = taRightJustify
          Caption = 'Atrasos'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
        end
        object DBEdit2: TDBEdit
          Left = 165
          Top = 70
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_150_180'
          DataSource = dsAbastecimentos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 0
        end
        object DBEdit3: TDBEdit
          Left = 165
          Top = 94
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_120_150'
          DataSource = dsAbastecimentos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 1
        end
        object DBEdit4: TDBEdit
          Left = 165
          Top = 118
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_90_120'
          DataSource = dsAbastecimentos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 2
        end
        object DBEdit5: TDBEdit
          Left = 165
          Top = 142
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_60_90'
          DataSource = dsAbastecimentos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 3
        end
        object DBEdit6: TDBEdit
          Left = 165
          Top = 166
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_30_60'
          DataSource = dsAbastecimentos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 4
        end
        object DBEdit7: TDBEdit
          Left = 165
          Top = 190
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_Ate_30'
          DataSource = dsAbastecimentos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 5
        end
        object DBEdit1: TDBEdit
          Left = 253
          Top = 70
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_150_180'
          DataSource = dsAtrasos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 6
        end
        object DBEdit8: TDBEdit
          Left = 253
          Top = 94
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_120_150'
          DataSource = dsAtrasos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 7
        end
        object DBEdit9: TDBEdit
          Left = 253
          Top = 118
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_90_120'
          DataSource = dsAtrasos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 8
        end
        object DBEdit10: TDBEdit
          Left = 253
          Top = 142
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_60_90'
          DataSource = dsAtrasos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 9
        end
        object DBEdit11: TDBEdit
          Left = 253
          Top = 166
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_30_60'
          DataSource = dsAtrasos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 10
        end
        object DBEdit12: TDBEdit
          Left = 253
          Top = 190
          Width = 57
          Height = 21
          TabStop = False
          BorderStyle = bsNone
          DataField = 'dias_Ate_30'
          DataSource = dsAtrasos
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentColor = True
          ParentFont = False
          ReadOnly = True
          TabOrder = 11
        end
      end
      object GroupBox4: TGroupBox
        Left = 496
        Top = 24
        Width = 545
        Height = 201
        Caption = ' Ocorr'#234'ncias de atrasos '
        TabOrder = 1
        object DBGrid2: TDBGrid
          Left = 2
          Top = 15
          Width = 541
          Height = 146
          DataSource = dsOcorrencias
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
          ParentFont = False
          TabOrder = 0
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -11
          TitleFont.Name = 'MS Sans Serif'
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'NomeFantasia'
              Title.Caption = 'Posto'
              Width = 240
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DataVencimento'
              Title.Alignment = taCenter
              Title.Caption = 'Vencimento'
              Width = 99
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'DataPagamento'
              Title.Alignment = taCenter
              Title.Caption = 'Pagamento'
              Width = 94
              Visible = True
            end
            item
              Alignment = taCenter
              Expanded = False
              FieldName = 'Dias'
              Title.Alignment = taCenter
              Title.Caption = 'Atraso'
              Width = 59
              Visible = True
            end>
        end
        object btIncluirOcorrencia: TButton
          Left = 241
          Top = 167
          Width = 121
          Height = 25
          Caption = 'Incluir Ocorr'#234'ncia'
          TabOrder = 1
          OnClick = btIncluirOcorrenciaClick
        end
      end
    end
    object GroupBox3: TGroupBox
      Left = 16
      Top = 16
      Width = 273
      Height = 249
      Caption = ' Empresas para avalia'#231#227'o '
      TabOrder = 2
      object DBGrid1: TDBGrid
        Left = 2
        Top = 15
        Width = 269
        Height = 232
        Align = alClient
        DataSource = dsEmpresas
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'MS Sans Serif'
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'Empresa'
            Width = 229
            Visible = True
          end>
      end
    end
  end
  object qAbastecimentos: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 8
    Top = 304
  end
  object dsAbastecimentos: TDataSource
    DataSet = qAbastecimentos
    Left = 40
    Top = 304
  end
  object qEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterScroll = qEmpresasAfterScroll
    Parameters = <>
    Left = 936
    Top = 24
  end
  object dsEmpresas: TDataSource
    DataSet = qEmpresas
    Left = 968
    Top = 24
  end
  object qOcorrencias: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 528
    Top = 408
  end
  object dsOcorrencias: TDataSource
    DataSet = qOcorrencias
    Left = 560
    Top = 408
  end
  object qSerasa: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 936
    Top = 56
  end
  object dsSerasa: TDataSource
    DataSet = qSerasa
    Left = 968
    Top = 56
  end
  object qAtrasos: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 8
    Top = 336
  end
  object dsAtrasos: TDataSource
    DataSet = qAtrasos
    Left = 40
    Top = 336
  end
end
