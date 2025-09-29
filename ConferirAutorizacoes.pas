unit ConferirAutorizacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Grids, DBGrids, ExtCtrls, DB, ADODB;

type
  TfrmConferirAutorizacoes = class(TForm)
    qAutorizacoes: TADOQuery;
    dsAutorizacoes: TDataSource;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    Panel7: TPanel;
    dtInicial: TDateTimePicker;
    rbPCL: TRadioButton;
    rbGegel: TRadioButton;
    rbRedevax: TRadioButton;
    rbMorada: TRadioButton;
    dtFinal: TDateTimePicker;
    btPesquisar: TButton;
    DBGrid3: TDBGrid;
    qEmpresas: TADOQuery;
    dsEmpresas: TDataSource;
    Panel9: TPanel;
    qNfce: TADOQuery;
    dsNfce: TDataSource;
    Panel10: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Label2: TLabel;
    btSomar: TButton;
    edtSoma: TEdit;
    DBGrid2: TDBGrid;
    Panel8: TPanel;
    btnRelacionar: TButton;
    Panel11: TPanel;
    Panel12: TPanel;
    Label3: TLabel;
    DBGrid4: TDBGrid;
    qNFCeNaoRelacionadas: TADOQuery;
    dsNFCeNaoRelacionadas: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure qEmpresasAfterScroll(DataSet: TDataSet);
    procedure btnRelacionarClick(Sender: TObject);
    procedure qAutorizacoesAfterScroll(DataSet: TDataSet);
    procedure btSomarClick(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
    function idposto():String;
  public
    { Public declarations }
  end;

var
  frmConferirAutorizacoes: TfrmConferirAutorizacoes;
  dataini, datafim :string;

implementation

uses DM, DateUtils;

{$R *.dfm}

procedure TfrmConferirAutorizacoes.FormActivate(Sender: TObject);
begin
  dtInicial.Date := Now();
  dtFinal.Date := Now();
end;

function TfrmConferirAutorizacoes.idposto():String;
begin
  if rbGegel.Checked then idposto := '18'
  else if rbPCL.Checked then idposto := '21'
  else if rbPCL.Checked then idposto := '37'
  else if rbPCL.Checked then idposto := '50'
  else idposto := '0';
end;

procedure TfrmConferirAutorizacoes.btPesquisarClick(Sender: TObject);
begin
  qEmpresas.SQL.text :=
    'select e.id empresa_id, e.NomeFantasia  '+
    'from   empresas e                       '+
    'inner  join Contratos c on c.Empresa_Id =e.Id '+
    //'inner  join TempControleSerralinda t on t.id = e.id '+
    'where  c.UnidadeCredenciada_Id = '+idposto()+
    '  and  c.Ativo = 1                      '+
    '  and  e.Ativo = 1                      '+
    'order  by e.NomeFantasia ';
  qEmpresas.Open;
end;

procedure TfrmConferirAutorizacoes.qEmpresasAfterScroll(DataSet: TDataSet);
var
  data :TDateTime;
begin
  data := dtInicial.Date;
  dataini := FormatDateTime( 'yyyy', data)+'-'+FormatDateTime('MM', data)+'-'+FormatDateTime('dd', data);
  data := IncDay(dtFinal.Date);
  datafim := FormatDateTime('yyyy', data)+'-'+FormatDateTime('MM', data)+'-'+FormatDateTime('dd', data);

  qAutorizacoes.Close;
  qAutorizacoes.SQL.Text :=
    'select uc.NomeFantasia, e.NomeFantasia empresa, a.data, v.placa, p.Nome produto,        '+
    '       ia.Valor, ia.id ItemAutorizacao_Id, Quantidade, a.Id Autorizacao_Id, KmAtual,  '+
    '       auc.NumeroCupomFiscal, ia.ConferidoNfce                                          '+
    'from   UnidadesCredenciadas uc                                                          '+
    'inner  join AutorizacoesUnidadesCredenciadas auc on auc.UnidadeCredenciada_Id = uc.id   '+
    'inner  join Autorizacoes a on a.id = auc.id                                             '+
    'inner  join CentrosDeCustos cc on cc.id = a.CentroDeCusto_Id                            '+
    'inner  join empresas e on e.id = cc.Empresa_Id                                          '+
    'inner  join ItensAutorizacoes ia on ia.Autorizacao_Id = a.id                            '+
    'inner  join Produtos p on p.id = ia.Produto_Id                                          '+
    'inner  join Veiculos v on v.id = a.UnidadeDeControle_Id                                 '+
    'where  uc. id = '+idposto()+
    '  and  a.Data between '''+dataini+''' and '''+datafim+''' '+
    '  and  auc.UnidadeCredenciada_Id = '+idposto()+' '+
    '  and  cc.Empresa_Id = '+qEmpresas.FieldByName('empresa_id').AsString+' '+
    'order  by 3, 4 ';
  qAutorizacoes.Open;

  qNFCeNaoRelacionadas.Close;
  qNFCeNaoRelacionadas.SQL.Text :=
    'select n.Id Nfce_Id, n.DataEmissao, n.Placa, i.NomeProduto, i.QtdProduto, '+
    '       i.ValorUnitario, i.ValorTotal, i.ItemAutorizacao_Id, n.NumeroNF, i.Id ItemNfce_Id, n.ConferidoNfce '+
    'from   Nfce n                               '+
    'inner  join ItensNfce i on i.Nfce_Id = n.id  '+
    'inner  join UnidadesCredenciadas uc on uc.Cnpj = n.CnpjEmitente '+
    'inner  join Empresas e on e.CpfOuCnpj = n.CnpjDestinatario      '+
    'where  uc.Id = '+idposto()+' '+
    '  and  e.Id = '+qEmpresas.FieldByName('empresa_id').AsString+' '+
    '  and  n.DataEmissao between '''+dataini+''' and '''+datafim+''' '+
    '  and  n.Status = ''Emitido'' '+
    '  and  i.ConferidoNfce = 0 '+
    'order  by n.DataEmissao, n.Placa ';
  qNFCeNaoRelacionadas.Open;
end;

procedure TfrmConferirAutorizacoes.btnRelacionarClick(Sender: TObject);
var
  valor, valorUnitario :Double;
  strValor, strValorUnitario :String;
  bm :TBookMark;
begin
  if not qNfce.FieldByName('ItemAutorizacao_Id').IsNull then
  begin
    ShowMessage('Ops! Esse cupom já foi associado a outra autorização.');
    Exit;
  end;

  valorUnitario := qNfce.FieldByName('ValorUnitario').AsFloat;
  strValorUnitario := StringReplace(FloatToStr(valorUnitario), ',', '.', []);

  valor := StrToFloat(StringReplace(qNfce.FieldByName('ValorTotal').AsString, '.', '', []));
  strValor := StringReplace(FloatToStr(valor), ',', '.', []);


  //ITENS AUTORIZAÇÕES
  frmDM.qAux.SQL.text :=
    'update ItensAutorizacoes     '+
    'set    ConferidoNfce = 1     '+
    'where  id = '+qAutorizacoes.FieldByName('ItemAutorizacao_Id').AsString;
  frmDM.qAux.ExecSQL;


  //AUTORIZAÇÕES UNIDADES CREDENCIADAS
  frmDM.qAux.SQL.text :=
    'update AutorizacoesUnidadesCredenciadas               '+
    'set    NumeroCupomFiscal = '+qNfce.FieldByName('NumeroNF').AsString+', '+
    '       ValorAutorizado = '+strValor+' '+
    'where  id = '+qAutorizacoes.FieldByName('Autorizacao_Id').AsString;
  frmDM.qAux.ExecSQL;


  //MARCAR O ITEM_NFCE COMO CONFERIDO
  frmDM.qAux.Sql.Text := 'update ItensNfce '+
                         'set    ConferidoNfce = 1, '+
                         '       ItemAutorizacao_Id = '+qAutorizacoes.FieldByName('ItemAutorizacao_Id').AsString+' '+
                         'where  id = '+qNfce.FieldByName('ItemNfce_Id').AsString;
  frmDM.qAux.ExecSql;


  //SE TODOS OS ITENS ESTIVEREM CONFERIDOS, MARCAR O REGISTRO NFCE COMO CONFERIDO
  frmDM.qAux.Sql.Text := 'update Nfce '+
                         'set    ConferidoNfce = 1 '+
                         'where  id = '+qNfce.FieldByName('Nfce_Id').AsString+' '+
                         '  and  not exists(select * from itensNfce where Nfce_Id = Nfce.Id and ConferidoNfce = 0)';
  frmDM.qAux.ExecSql;

  bm := qAutorizacoes.GetBookmark;
  qAutorizacoes.Requery();
  qAutorizacoes.GotoBookmark(bm);
  qAutorizacoes.Next;

  qNFCeNaoRelacionadas.Requery();
end;

procedure TfrmConferirAutorizacoes.qAutorizacoesAfterScroll(DataSet: TDataSet);
var
  data :TDateTime;
  datai, dataf :string;
begin
  data := qAutorizacoes.FieldByName('data').AsDateTime;
  datai := FormatDateTime('yyyy', data)+'-'+FormatDateTime('MM', data)+'-'+FormatDateTime('dd', data);
  data  := IncDay(data); //pega o dia todo
  dataf := FormatDateTime('yyyy', data)+'-'+FormatDateTime('MM', data)+'-'+FormatDateTime('dd', data);

  qNfce.Close;
  qNfce.SQL.Text :=
    'select n.Id Nfce_Id, n.DataEmissao, n.Placa, i.NomeProduto, i.QtdProduto, '+
    '       i.ValorUnitario, i.ValorTotal, i.ItemAutorizacao_Id, n.NumeroNF, i.Id ItemNfce_Id, n.ConferidoNfce '+
    'from   Nfce n                               '+
    'inner  join ItensNfce i on i.Nfce_Id = n.id  '+
    'inner  join UnidadesCredenciadas uc on uc.Cnpj = n.CnpjEmitente '+
    'inner  join Empresas e on e.CpfOuCnpj = n.CnpjDestinatario      '+
    'where  uc.Id = '+idposto()+' '+
    '  and  e.Id = '+qEmpresas.FieldByName('empresa_id').AsString+' '+
    '  and  n.DataEmissao between '''+datai+''' and '''+dataf+''' '+
    '  and  n.Status = ''Emitido'' '+
    '  and  (i.QtdProduto >= '+StringReplace(qAutorizacoes.FieldByName('Quantidade').AsString, ',', '.', [])+'-0.01 and '+
    '        i.QtdProduto <= '+StringReplace(qAutorizacoes.FieldByName('Quantidade').AsString, ',', '.', [])+'+0.01) '+
    'order  by n.Placa, n.DataEmissao ';
  qNfce.Open;

end;

procedure TfrmConferirAutorizacoes.btSomarClick(Sender: TObject);
begin

  frmDM.qAux.SQL.Text :=
    'select sum(ia.Valor) Valor  '+
    'from   AutorizacoesUnidadesCredenciadas auc                   '+
    'inner  join Autorizacoes a on a.id = auc.id                   '+
    'inner  join ItensAutorizacoes ia on ia.Autorizacao_Id = a.id  '+
    'inner  join CentrosDeCustos cc on cc.id = a.CentroDeCusto_Id  '+
    'where  auc.UnidadeCredenciada_id = '+idposto()+
    '  and  a.Data between '''+dataini+''' and '''+datafim+''' '+
    '  and  cc.Empresa_Id = '+qEmpresas.FieldByName('empresa_id').AsString;
  frmDM.qAux.Open;

  edtSoma.Text := frmDM.qAux.FieldByName('Valor').AsString;

  frmDM.qAux.Close;
end;

procedure TfrmConferirAutorizacoes.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  if qNfce.FieldByName('ValorTotal').AsFloat <> qAutorizacoes.FieldByName('Valor').AsFloat then
  begin
    DBGrid2.Canvas.Font.Color:= clYellow;
    DBGrid2.Canvas.FillRect(Rect);
    DBGrid2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;
end;

end.
