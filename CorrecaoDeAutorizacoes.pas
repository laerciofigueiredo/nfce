unit CorrecaoDeAutorizacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, ExtCtrls, ComCtrls, Mask, DateUtils;

type
  TfrmCorrecaoDeAutorizacoes = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Panel2: TPanel;
    edtPlaca: TEdit;
    Label1: TLabel;
    qAutorizacoes: TADOQuery;
    dsAutorizacoes: TDataSource;
    Label2: TLabel;
    edtValor: TEdit;
    btnCorrigirValor: TButton;
    Label3: TLabel;
    Panel3: TPanel;
    rbPCL: TRadioButton;
    rbGegel: TRadioButton;
    rbMorada: TRadioButton;
    rbRedevax: TRadioButton;
    Label4: TLabel;
    btSomar: TButton;
    edtSoma: TEdit;
    edtDataIni: TDateTimePicker;
    edtDataFim: TDateTimePicker;
    procedure FormActivate(Sender: TObject);
    procedure qAutorizacoesAfterScroll(DataSet: TDataSet);
    procedure edtPlacaChange(Sender: TObject);
    procedure btnCorrigirValorClick(Sender: TObject);
    procedure edtValorKeyPress(Sender: TObject; var Key: Char);
    procedure AbrirConsulta(Sender: TObject);
    procedure btSomarClick(Sender: TObject);
    procedure qAutorizacoesAfterClose(DataSet: TDataSet);
    procedure qAutorizacoesAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCorrecaoDeAutorizacoes: TfrmCorrecaoDeAutorizacoes;
  dataini, datafim :String;

implementation

uses DM;

{$R *.dfm}

procedure TfrmCorrecaoDeAutorizacoes.FormActivate(Sender: TObject);
begin
  edtDataIni.Date := date();
  edtDataFim.Date := date();

  AbrirConsulta(Sender);
end;

procedure TfrmCorrecaoDeAutorizacoes.AbrirConsulta(Sender: TObject);
var
  idposto :String;
begin
  if rbPCL.Checked then
    idposto := '21'
  else
  if rbGegel.Checked then
    idposto := '18'
  else
  if rbRedevax.Checked then
    idposto := '37'
  else
    idposto := '50';

  dataIni := '2022-12-09';
  dataFim := '2023-01-16'; //sempre o dia posterior

  //
  qAutorizacoes.Close;
  qAutorizacoes.SQL.Text :=
    'select e.NomeFantasia empresa, uc.NomeFantasia, v.placa, a.data, p.Nome produto, '+
    '       ia.Valor, ia.id ItensAutorizacoes_Id, Quantidade, a.Id Autorizacao_Id, auc.NumeroCupomFiscal '+
    'from   UnidadesCredenciadas uc                                                          '+
    'inner  join AutorizacoesUnidadesCredenciadas auc on auc.UnidadeCredenciada_Id = uc.id   '+
    'inner  join Autorizacoes a on a.id = auc.id                                             '+
    'inner  join CentrosDeCustos cc on cc.id = a.CentroDeCusto_Id                            '+
    'inner  join empresas e on e.id = cc.Empresa_Id                                          '+
    'inner  join ItensAutorizacoes ia on ia.Autorizacao_Id = a.id                            '+
    'inner  join Produtos p on p.id = ia.Produto_Id                                          '+
    'inner  join Veiculos v on v.id = a.UnidadeDeControle_Id                                 '+
    'where  uc. id = '+idposto+
    '  and  e.id = 65 '+  {VELTEN LOG}
    '  and  a.Data between '''+dataini+''' and '''+datafim+''' '+
    'order  by a.data ';

  if frmDM.ADOConnection1.Connected then
    qAutorizacoes.Open;
end;


procedure TfrmCorrecaoDeAutorizacoes.qAutorizacoesAfterScroll(
  DataSet: TDataSet);
begin
  edtValor.Text := qAutorizacoes.FieldByName('Valor').AsString;
end;

procedure TfrmCorrecaoDeAutorizacoes.edtPlacaChange(Sender: TObject);
begin
  if trim(edtPlaca.Text) = '' then
    qAutorizacoes.Filtered := false
  else
  begin
    qAutorizacoes.Filter := 'Placa like ''%'+edtPlaca.Text+'%'' ';
    qAutorizacoes.Filtered := true;
  end;
end;

procedure TfrmCorrecaoDeAutorizacoes.btnCorrigirValorClick(Sender: TObject);
var
  valor, valorUnitario :Double;
  strValor, strValorUnitario :String;
  bm : TBookMark;
begin
  valor := StrToFloat(StringReplace(edtValor.Text, '.', '', []));
  valorUnitario := valor / qAutorizacoes.FieldByName('Quantidade').AsFloat;

  strValor := StringReplace(FloatToStr(valor), ',', '.', []);
  strValorUnitario := StringReplace(FloatToStr(valorUnitario), ',', '.', []);

  frmDM.qAux.SQL.text :=
    'update ItensAutorizacoes '+
    'set    Valor = '+strValor+', '+
    '       ValorUnitario = '+strValorUnitario+' '+
    'where  id = '+qAutorizacoes.FieldByName('ItensAutorizacoes_Id').AsString;
  frmDM.qAux.ExecSQL;

  frmDM.qAux.SQL.text :=
    'update AutorizacoesUnidadesCredenciadas               '+
    'set    ValorAutorizado = (select sum(Valor)           '+
    '                          from   ItensAutorizacoes    '+
    '                          where  Autorizacao_Id = AutorizacoesUnidadesCredenciadas.Id)'+
    'where  id = '+qAutorizacoes.FieldByName('Autorizacao_Id').AsString;
  frmDM.qAux.ExecSQL;

  bm := qAutorizacoes.GetBookmark;
  qAutorizacoes.Requery();
  qAutorizacoes.GotoBookmark(bm);
end;

procedure TfrmCorrecaoDeAutorizacoes.edtValorKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key = #13 then
    btnCorrigirValorClick(Sender);
end;

procedure TfrmCorrecaoDeAutorizacoes.btSomarClick(Sender: TObject);
var
  soma :Double;
begin
  soma := 0;

  //CALCULA A SOMA DOS REGISTROS FILTRADOS
  qAutorizacoes.First;
  while not qAutorizacoes.Eof do
  begin
    soma := soma + qAutorizacoes.FieldByName('Valor').AsFloat;
    qAutorizacoes.Next;
  end;
  qAutorizacoes.First;

  edtSoma.Text := FloatToStr(soma);
end;

procedure TfrmCorrecaoDeAutorizacoes.qAutorizacoesAfterClose(DataSet: TDataSet);
begin
  edtSoma.Text := '';
end;

procedure TfrmCorrecaoDeAutorizacoes.qAutorizacoesAfterOpen(DataSet: TDataSet);
begin
  edtSoma.Text := '';
end;

end.
