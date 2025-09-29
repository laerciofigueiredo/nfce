object frmMenu: TfrmMenu
  Left = 359
  Top = 121
  Width = 720
  Height = 511
  Caption = 'Ferramentas do Gekom'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  DesignSize = (
    704
    452)
  PixelsPerInch = 96
  TextHeight = 13
  object lblTentandoConexao: TLabel
    Left = 24
    Top = 429
    Width = 211
    Height = 13
    Anchors = [akLeft, akBottom]
    Caption = 'Tentando conex'#227'o com o banco de dados...'
    Color = clBtnFace
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clNavy
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object MainMenu1: TMainMenu
    Left = 184
    Top = 40
    object mnuEstatisticasSerralinda: TMenuItem
      Caption = 'Estatisticas Serralinda'
      OnClick = mnuEstatisticasSerralindaClick
    end
    object mnuValoresFaturamento: TMenuItem
      Caption = 'Valores Faturamento'
      Visible = False
      OnClick = mnuValoresFaturamentoClick
    end
    object Antigo1: TMenuItem
      Caption = 'Antigo'
      Visible = False
      OnClick = Antigo1Click
    end
    object mnuChavesMaquininhas: TMenuItem
      Caption = 'Chaves Maquininhas'
      Visible = False
    end
    object ALTORIZAES1: TMenuItem
      Caption = 'AUTORIZA'#199#213'ES'
      Visible = False
      object mnuEmpresas: TMenuItem
        Caption = 'Empresas'
        OnClick = mnuEmpresasClick
      end
      object mnuPlacasnocadastradas: TMenuItem
        Caption = 'Placas n'#227'o cadastradas'
        OnClick = mnuPlacasnocadastradasClick
      end
      object mnuConferirautorizaes: TMenuItem
        Caption = 'Conferir autoriza'#231#245'es'
        OnClick = mnuConferirautorizaesClick
      end
      object CorrigirAutorizacoes: TMenuItem
        Caption = 'Corrigir Autoriza'#231#245'es'
        OnClick = CorrigirAutorizacoesClick
      end
      object mnuProdutosnoreconhecidos: TMenuItem
        Caption = 'Produtos n'#227'o reconhecidos'
      end
    end
    object VEICULOS1: TMenuItem
      Caption = 'VE'#205'CULOS'
      Visible = False
      object mnuAssociarCartoes: TMenuItem
        Caption = 'Associar cart'#245'es'
        OnClick = mnuAssociarCartoesClick
      end
      object mnuCoringasZZZ: TMenuItem
        Caption = 'Coringas ZZZ'
        OnClick = mnuCoringasZZZClick
      end
      object mnuVeiculosSemOperacoes: TMenuItem
        Caption = 'Sem opera'#231#245'es'
        OnClick = mnuVeiculosSemOperacoesClick
      end
    end
    object mnuExpurgo: TMenuItem
      Caption = 'Expurgo'
      OnClick = mnuExpurgoClick
    end
    object mnuOcorrncias: TMenuItem
      Caption = 'Ocorr'#234'ncias'
      OnClick = mnuOcorrnciasClick
    end
    object mnuScore: TMenuItem
      Caption = 'Score'
      OnClick = mnuScoreClick
    end
  end
end
