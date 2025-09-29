object frmConferirAutorizacoes: TfrmConferirAutorizacoes
  Left = 125
  Top = 20
  Width = 1058
  Height = 663
  Caption = 'Conferir autoriza'#231#245'es'
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
  object Panel5: TPanel
    Left = 0
    Top = 0
    Width = 305
    Height = 624
    Align = alLeft
    TabOrder = 0
    object Panel7: TPanel
      Left = 1
      Top = 1
      Width = 303
      Height = 128
      Align = alTop
      TabOrder = 0
      object dtInicial: TDateTimePicker
        Left = 24
        Top = 20
        Width = 97
        Height = 24
        Date = 44805.431773657410000000
        Format = 'yyyy-MM-dd'
        Time = 44805.431773657410000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 0
        TabStop = False
      end
      object rbPCL: TRadioButton
        Left = 136
        Top = 27
        Width = 73
        Height = 17
        Caption = 'PCL'
        Checked = True
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 1
        TabStop = True
      end
      object rbGegel: TRadioButton
        Left = 136
        Top = 51
        Width = 73
        Height = 17
        Caption = 'Gegel'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 2
      end
      object rbRedevax: TRadioButton
        Left = 197
        Top = 27
        Width = 73
        Height = 17
        Caption = 'Redevax'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 3
      end
      object rbMorada: TRadioButton
        Left = 197
        Top = 51
        Width = 73
        Height = 17
        Caption = 'Morada'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -11
        Font.Name = 'MS Sans Serif'
        Font.Style = [fsBold]
        ParentFont = False
        TabOrder = 4
      end
      object dtFinal: TDateTimePicker
        Left = 24
        Top = 52
        Width = 97
        Height = 24
        Date = 44805.431773657410000000
        Format = 'yyyy-MM-dd'
        Time = 44805.431773657410000000
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -13
        Font.Name = 'MS Sans Serif'
        Font.Style = []
        ParentFont = False
        TabOrder = 5
        TabStop = False
      end
      object btPesquisar: TButton
        Left = 104
        Top = 96
        Width = 89
        Height = 25
        Caption = 'Pesquisar'
        TabOrder = 6
        OnClick = btPesquisarClick
      end
    end
    object DBGrid3: TDBGrid
      Left = 1
      Top = 129
      Width = 303
      Height = 494
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
          FieldName = 'NomeFantasia'
          Width = 262
          Visible = True
        end>
    end
  end
  object Panel6: TPanel
    Left = 314
    Top = 0
    Width = 728
    Height = 624
    Align = alClient
    TabOrder = 1
    object Panel1: TPanel
      Left = 1
      Top = 1
      Width = 726
      Height = 622
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 0
      object Panel2: TPanel
        Left = 0
        Top = 0
        Width = 726
        Height = 33
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 13
          Width = 91
          Height = 16
          Caption = 'Autoriza'#231#245'es'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'MS Sans Serif'
          Font.Style = [fsBold]
          ParentFont = False
        end
      end
      object DBGrid1: TDBGrid
        Left = 0
        Top = 33
        Width = 726
        Height = 221
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
            FieldName = 'Data'
            Width = 98
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Placa'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Produto'
            Width = 126
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Quantidade'
            Width = 65
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Valor'
            Width = 68
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'NumeroCupomFiscal'
            Title.Caption = 'Cupom Fiscal'
            Width = 74
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'ItemAutorizacao_Id'
            Width = 97
            Visible = True
          end>
      end
      object Panel10: TPanel
        Left = 0
        Top = 254
        Width = 726
        Height = 210
        Align = alBottom
        TabOrder = 2
        object Panel3: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 159
          Align = alClient
          BevelOuter = bvNone
          Color = clCream
          TabOrder = 0
          object Panel4: TPanel
            Left = 0
            Top = 0
            Width = 724
            Height = 41
            Align = alTop
            BevelOuter = bvNone
            Color = clCream
            TabOrder = 0
            object Label2: TLabel
              Left = 8
              Top = 21
              Width = 40
              Height = 16
              Caption = 'NFCe'
              Font.Charset = DEFAULT_CHARSET
              Font.Color = clWindowText
              Font.Height = -13
              Font.Name = 'MS Sans Serif'
              Font.Style = [fsBold]
              ParentFont = False
            end
            object btSomar: TButton
              Left = 376
              Top = 8
              Width = 75
              Height = 25
              Caption = 'Somar'
              TabOrder = 0
              OnClick = btSomarClick
            end
            object edtSoma: TEdit
              Left = 459
              Top = 10
              Width = 81
              Height = 21
              Color = clBtnFace
              Enabled = False
              ReadOnly = True
              TabOrder = 1
            end
          end
          object DBGrid2: TDBGrid
            Left = 0
            Top = 41
            Width = 724
            Height = 118
            Align = alClient
            DataSource = dsNfce
            Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
            TabOrder = 1
            TitleFont.Charset = DEFAULT_CHARSET
            TitleFont.Color = clWindowText
            TitleFont.Height = -11
            TitleFont.Name = 'MS Sans Serif'
            TitleFont.Style = []
            OnDrawColumnCell = DBGrid2DrawColumnCell
            Columns = <
              item
                Expanded = False
                FieldName = 'DataEmissao'
                Width = 100
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'Placa'
                Width = 62
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NomeProduto'
                Width = 129
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'QtdProduto'
                Width = 66
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ValorTotal'
                Width = 69
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'NumeroNF'
                Width = 78
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ItemAutorizacao_Id'
                Width = 96
                Visible = True
              end
              item
                Expanded = False
                FieldName = 'ConferidoNfce'
                Width = 78
                Visible = True
              end>
          end
        end
        object Panel8: TPanel
          Left = 1
          Top = 160
          Width = 724
          Height = 49
          Align = alBottom
          Color = clCream
          TabOrder = 1
          object btnRelacionar: TButton
            Left = 256
            Top = 11
            Width = 97
            Height = 25
            Caption = 'Relacionar'
            TabOrder = 0
            OnClick = btnRelacionarClick
          end
        end
      end
      object Panel11: TPanel
        Left = 0
        Top = 464
        Width = 726
        Height = 158
        Align = alBottom
        TabOrder = 3
        object Panel12: TPanel
          Left = 1
          Top = 1
          Width = 724
          Height = 24
          Align = alTop
          TabOrder = 0
          object Label3: TLabel
            Left = 8
            Top = 3
            Width = 165
            Height = 16
            Caption = 'NFCe n'#227'o relacionadas'
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowText
            Font.Height = -13
            Font.Name = 'MS Sans Serif'
            Font.Style = [fsBold]
            ParentFont = False
          end
        end
        object DBGrid4: TDBGrid
          Left = 1
          Top = 25
          Width = 724
          Height = 132
          Align = alClient
          Color = clBtnFace
          DataSource = dsNFCeNaoRelacionadas
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
              FieldName = 'DataEmissao'
              Width = 100
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'Placa'
              Width = 62
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NomeProduto'
              Width = 129
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'QtdProduto'
              Width = 66
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ValorTotal'
              Width = 69
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'NumeroNF'
              Width = 78
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ItemAutorizacao_Id'
              Width = 96
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'ConferidoNfce'
              Width = 78
              Visible = True
            end>
        end
      end
    end
  end
  object Panel9: TPanel
    Left = 305
    Top = 0
    Width = 9
    Height = 624
    Align = alLeft
    Color = clMedGray
    TabOrder = 2
  end
  object qAutorizacoes: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterScroll = qAutorizacoesAfterScroll
    Parameters = <>
    Left = 664
    Top = 160
  end
  object dsAutorizacoes: TDataSource
    DataSet = qAutorizacoes
    Left = 664
    Top = 192
  end
  object qEmpresas: TADOQuery
    Connection = frmDM.ADOConnection1
    AfterScroll = qEmpresasAfterScroll
    Parameters = <>
    Left = 128
    Top = 224
  end
  object dsEmpresas: TDataSource
    DataSet = qEmpresas
    Left = 128
    Top = 256
  end
  object qNfce: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 747
    Top = 352
  end
  object dsNfce: TDataSource
    DataSet = qNfce
    Left = 747
    Top = 384
  end
  object qNFCeNaoRelacionadas: TADOQuery
    Connection = frmDM.ADOConnection1
    Parameters = <>
    Left = 739
    Top = 536
  end
  object dsNFCeNaoRelacionadas: TDataSource
    DataSet = qNFCeNaoRelacionadas
    Left = 739
    Top = 568
  end
end
