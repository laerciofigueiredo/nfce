unit AssociarCartoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, ExtCtrls;

type
  TfrmAssociarCartoes = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    edtFiltroEmpresa: TEdit;
    DBGrid1: TDBGrid;
    qEmpresas: TADOQuery;
    dsEmpresas: TDataSource;
    Panel3: TPanel;
    DBGrid2: TDBGrid;
    Panel4: TPanel;
    Label2: TLabel;
    edtPlaca: TEdit;
    Panel5: TPanel;
    Label3: TLabel;
    edtDigitos: TEdit;
    btAssociar: TButton;
    rbSemCartao: TRadioButton;
    qVeiculos: TADOQuery;
    dsVeiculos: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure edtFiltroEmpresaChange(Sender: TObject);
    procedure qEmpresasAfterScroll(DataSet: TDataSet);
    procedure btAssociarClick(Sender: TObject);
    procedure DBGrid2CellClick(Column: TColumn);
    procedure rbSemCartaoClick(Sender: TObject);
    procedure edtPlacaChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmAssociarCartoes: TfrmAssociarCartoes;

implementation

uses DM;

{$R *.dfm}

procedure TfrmAssociarCartoes.FormShow(Sender: TObject);
begin
  qEmpresas.Open;
end;

procedure TfrmAssociarCartoes.edtFiltroEmpresaChange(Sender: TObject);
begin
  if trim(edtFiltroEmpresa.Text) = '' then
    qEmpresas.Filtered := false
  else
  begin
    qEmpresas.Filter := 'NomeFantasia like ''%'+edtFiltroEmpresa.Text+'%'' ';
    qEmpresas.Filtered := true;
  end;
end;

procedure TfrmAssociarCartoes.qEmpresasAfterScroll(DataSet: TDataSet);
begin
  qVeiculos.Close;
  qVeiculos.Sql.Text := 'select v.id, v.placa, v.identificador, v.NumeroDoCartao '+
                        'from   veiculos v                                              '+
                        'inner  join UnidadesDeControles u on u.id = v.id               '+
                        'where  u.ativo = 1                                             '+
                        '  and  u.empresa_id = '+qEmpresas.FieldByName('Id').AsString;


  if rbSemCartao.Checked then
    qVeiculos.Sql.Text := qVeiculos.Sql.Text + 'and NumeroDoCartao is null';

  qVeiculos.Sql.Text := qVeiculos.Sql.Text + ' order  by v.placa ';

  qVeiculos.Open;
end;

procedure TfrmAssociarCartoes.btAssociarClick(Sender: TObject);
var
  numeroDoCartao :String;
begin
  if Length(trim(edtDigitos.Text)) <> 5 then
  begin
    ShowMessage('Precisa ter 5 dígitos.');
    Exit;
  end;

  numeroDoCartao := '60859700205'+edtDigitos.Text;

  //verifica existencia do cartão
  frmDM.qAux.SQL.Text :=
    'select id, atribuido '+
    'from   Cartoes       '+
    'where  NumeroDoCartao = '''+numeroDoCartao+'''';
  frmDM.qAux.Open;

  if frmDM.qAux.RecordCount > 1 then
  begin
    ShowMessage('Atenção, existe mais de um cartão com estes últimos 4 dígitos');
    Exit;
  end
  else if frmDM.qAux.RecordCount = 0 then
  begin
    frmDM.qAux.Close;
    ShowMessage('Cartão não existe');
    Exit;
  end;
  frmDM.qAux.Close;

  //verifica se algum veículo está usando o cartão
  frmDM.qAux.SQL.Text :=
    'select id '+
    'from   veiculos      '+
    'where  NumeroDoCartao = '''+numeroDoCartao+'''';
  frmDM.qAux.Open;

  if frmDM.qAux.RecordCount = 1 then
  begin
    frmDM.qAux.Close;
    ShowMessage('Cartão já atribuido a outro veículo');
    Exit;
  end;
  frmDM.qAux.Close;

  //Atribui o cartão ao veículo
  frmDM.qAux.SQL.Text :=
    'update veiculos      '+
    'set    NumeroDoCartao = '''+numeroDoCartao+''' '+
    'where  id = '+qVeiculos.FieldByName('Id').AsString+'; '+
    ' '+
    'update cartoes      '+
    'set    Atribuido = 1 '+
    'where  NumeroDoCartao = '''+numeroDoCartao+''' ';
  frmDM.qAux.ExecSQL;

  edtDigitos.Text := '5';
  edtPlaca.Text := '';
  edtPlaca.SetFocus;
  qEmpresasAfterScroll(qEmpresas);
  ShowMessage('Cartão atribuido com sucesso.');

end;

procedure TfrmAssociarCartoes.DBGrid2CellClick(Column: TColumn);
begin
  edtDigitos.SetFocus;
end;

procedure TfrmAssociarCartoes.rbSemCartaoClick(Sender: TObject);
begin
  qEmpresasAfterScroll(qEmpresas);
end;

procedure TfrmAssociarCartoes.edtPlacaChange(Sender: TObject);
begin
  if trim(edtPlaca.Text) = '' then
    qVeiculos.Filtered := false
  else
  begin
    qVeiculos.Filter := 'Placa like ''%'+edtPlaca.Text+'%'' ';
    qVeiculos.Filtered := true;
  end;
end;

end.
