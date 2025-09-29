unit Menu;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls;

type
  TfrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    mnuAssociarCartoes: TMenuItem;
    mnuEstatisticasSerralinda: TMenuItem;
    mnuValoresFaturamento: TMenuItem;
    mnuEmpresas: TMenuItem;
    mnuConferirautorizaes: TMenuItem;
    mnuPlacasnocadastradas: TMenuItem;
    CorrigirAutorizacoes: TMenuItem;
    Antigo1: TMenuItem;
    mnuChavesMaquininhas: TMenuItem;
    lblTentandoConexao: TLabel;
    ALTORIZAES1: TMenuItem;
    mnuProdutosnoreconhecidos: TMenuItem;
    mnuCoringasZZZ: TMenuItem;
    VEICULOS1: TMenuItem;
    mnuVeiculosSemOperacoes: TMenuItem;
    mnuExpurgo: TMenuItem;
    mnuScore: TMenuItem;
    mnuOcorrncias: TMenuItem;
    procedure mnuAssociarCartoesClick(Sender: TObject);
    procedure mnuEstatisticasSerralindaClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure mnuValoresFaturamentoClick(Sender: TObject);
    procedure mnuEmpresasClick(Sender: TObject);
    procedure mnuConferirautorizaesClick(Sender: TObject);
    procedure mnuPlacasnocadastradasClick(Sender: TObject);
    procedure CorrigirAutorizacoesClick(Sender: TObject);
    procedure Antigo1Click(Sender: TObject);
    procedure mnuCoringasZZZClick(Sender: TObject);
    procedure mnuVeiculosSemOperacoesClick(Sender: TObject);
    procedure mnuExpurgoClick(Sender: TObject);
    procedure mnuScoreClick(Sender: TObject);
    procedure mnuOcorrnciasClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMenu: TfrmMenu;

implementation

uses AssociarCartoes, EstatisticasSerralinda, DM, ValoresSerralinda,
  Empresas, ConferirAutorizacoes, PlacasNaoCadastradas, MainInterface,
  CorrecaoDeAutorizacoes, CorrigirValorAutorizacaoPelosItens,
  ChavesMaquininhas, CoringasZZZ, VeiculosSemOperacoes, Expurgo,
  Ocorrencias;

{$R *.dfm}

procedure TfrmMenu.mnuAssociarCartoesClick(Sender: TObject);
begin
  frmAssociarCartoes.ShowModal;
end;

procedure TfrmMenu.mnuEstatisticasSerralindaClick(Sender: TObject);
begin
  frmEstatisticasSerralinda.ShowModal;
end;

procedure TfrmMenu.FormActivate(Sender: TObject);
begin
  lblTentandoConexao.Visible := true;
  Application.ProcessMessages;
  frmDM.ADOConnection1.Connected := true;

  lblTentandoConexao.Caption := 'Conectado';
  Application.ProcessMessages;
  lblTentandoConexao.Visible := false;
end;

procedure TfrmMenu.mnuValoresFaturamentoClick(Sender: TObject);
begin
  frmValoresSerralinda.ShowModal;
end;

procedure TfrmMenu.mnuEmpresasClick(Sender: TObject);
begin
  frmEmpresas.ShowModal;
end;

procedure TfrmMenu.mnuConferirautorizaesClick(Sender: TObject);
begin
  frmConferirAutorizacoes.ShowModal;
end;

procedure TfrmMenu.mnuPlacasnocadastradasClick(Sender: TObject);
begin
  frmPlacasNaoCadastradas.ShowModal;
end;

procedure TfrmMenu.CorrigirAutorizacoesClick(Sender: TObject);
begin
  frmCorrecaoDeAutorizacoes.ShowModal;
end;

procedure TfrmMenu.Antigo1Click(Sender: TObject);
begin
  frmMainInterface.ShowModal;
end;

procedure TfrmMenu.mnuCoringasZZZClick(Sender: TObject);
begin
  frmCoringasZZZ.ShowModal;
end;

procedure TfrmMenu.mnuVeiculosSemOperacoesClick(Sender: TObject);
begin
  frmVeiculosSemOperacoes.ShowModal;
end;

procedure TfrmMenu.mnuExpurgoClick(Sender: TObject);
begin
  //
  frmExpurgo.ShowModal;
end;

procedure TfrmMenu.mnuScoreClick(Sender: TObject);
begin
  //
  
end;

procedure TfrmMenu.mnuOcorrnciasClick(Sender: TObject);
begin
  //
  frmOcorrencias.ShowModal;
end;

end.
