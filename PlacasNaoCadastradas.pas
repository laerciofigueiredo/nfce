unit PlacasNaoCadastradas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Grids, DBGrids, ExtCtrls;

type
  TfrmPlacasNaoCadastradas = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    qPlacasNaoCadastradas: TADOQuery;
    dsPlacasNaoCadastradas: TDataSource;
    btRefresh: TButton;
    btCadastrarVeiculo: TButton;
    pnlRodape: TPanel;
    procedure FormActivate(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btCadastrarVeiculoClick(Sender: TObject);
    procedure qPlacasNaoCadastradasAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
    procedure ConsultarPlacasNaoCadastradas();
  public
    { Public declarations }
  end;

var
  frmPlacasNaoCadastradas: TfrmPlacasNaoCadastradas;

implementation

uses DM;

{$R *.dfm}

procedure TfrmPlacasNaoCadastradas.FormActivate(Sender: TObject);
begin
  ConsultarPlacasNaoCadastradas();
end;

procedure TfrmPlacasNaoCadastradas.ConsultarPlacasNaoCadastradas();
begin
  qPlacasNaoCadastradas.SQL.Text := ' '+
    'select distinct e.id Empresa_Id, e.NomeFantasia, n.Placa,  '+
    '       (select top 1 e.NomeFantasia                        '+
	  '        from   Veiculos v                                  '+
	  '        inner  join UnidadesDeControles u on u.id = v.id   '+
	  '        inner  join Empresas e on e.id = u.Empresa_Id      '+
	  '        where  v.placa = n.placa and e.CpfOuCnpj <> n.CnpjDestinatario) as JaExisteNaEmpresa '+
    'from   Nfce n                                  '+
    'inner  join ItensNfce i on i.Nfce_Id = n.id    '+
    'inner  join Empresas e on e.CpfOuCnpj = n.CnpjDestinatario '+
    'where  not exists(select *                                 '+
    '                  from   veiculos v                        '+
    '          inner  join UnidadesDeControles u on u.id = v.id '+
    '          inner  join Empresas p on p.id = u.Empresa_Id    '+
    '          where  p.id = e.id                               '+
    '            and  v.placa = n.placa)                        '+
    '  and  n.placa not in (''XXXXXXX'', ''PACARRE'', ''1111111'', ''AAAAAAA'', ''QQQQQQQ'', '+
    '                       ''TMPQ108'', ''0000000'', ''BBBBBBB'', ''NNNNNNN'', ''COMPACT'', ''TMPQ120'') '+
    '  and  not (n.placa like ''RETR%'') '+
    '  and  len(n.placa) = 7           '+
    '  and  e.id not in (65, 67, 66) --velten e Fibravit e emflora '+
    'order  by e.NomeFantasia, n.Placa ';
  qPlacasNaoCadastradas.Open;
end;

procedure TfrmPlacasNaoCadastradas.btRefreshClick(Sender: TObject);
begin
  qPlacasNaoCadastradas.Requery();
end;

procedure TfrmPlacasNaoCadastradas.btCadastrarVeiculoClick(Sender: TObject);
var
  placa, empresa_id, uc_id :String;
  bm : TBookMark;
begin
  if not qPlacasNaoCadastradas.FieldByName('JaExisteNaEmpresa').IsNull then
  begin
    ShowMessage('Placa já existe em outra empresa');
    Exit;
  end;

  placa := qPlacasNaoCadastradas.FieldByName('Placa').AsString;
  empresa_id := qPlacasNaoCadastradas.FieldByName('Empresa_Id').AsString;

  //INSERINDO REGISTRO DE UNIDADE DE CONTROLE
  frmDM.qAux.Sql.Text := ' '+
    'insert into UnidadesDeControles '+
    '(descricao, ativo, datadecadastro, dataultimaalteracao, tipodecombustivel_id, empresa_id, '+
    ' permitircomprasemcartao, modelodeunidadedecontrole_id, autorizarcomkminconsistente, centrodecusto_id) '+
    'values '+
    '('''+placa+''', '+
    ' 1, getdate(), getdate(), 10, '+
     empresa_id+', '+
    '1, 1, 1, '+
    '(select top 1 id from CentrosDeCustos where  empresa_id = '+empresa_id+')) ';
  frmDM.qAux.ExecSQL;

  //OBTENDO O ID CRIADO
  frmDM.qAux.SQL.Text := 'select max(id) as id from UnidadesDeControles where empresa_id = '+empresa_id;
  frmDM.qAux.Open;
  uc_id := frmDM.qAux.FieldByName('id').AsString;
  frmDM.qAux.Close;

  //INSERINDO O REGISTRO DE VEÍCULO
  frmDM.qAux.SQL.Text := ' '+
    'insert into Veiculos  '+
    '(id, placa, Identificador, capacidadedotanque, kmporlitrominimo, kmporlitromaximo, deveinformarkm, '+
    ' bloqueadofds, deveinformarhorimetro, litroporhoraminimo, litroporhoramaximo,       '+
    ' LimiteCredito, ControlaLimiteCredito, PeriodicidadeLimiteCredito)                  '+
    'values '+
    '('+uc_id+', '''+placa+''', '''+placa+''', 999, 0, 999, 1, 0, 0, 0, 999, 0, 0, 1)';
  frmDM.qAux.ExecSQL;

  //INSERINDO OS REGISTROS DE PRODUTOS PERMITIDOS
  frmDM.qAux.SQL.Text := ' '+
  'insert into ProdutosUnidadesDeControles '+
  '(UnidadeDeControle_Id, Produto_Id)      '+
  'select '''+uc_id+''', p.id from Produtos p ';
  frmDM.qAux.ExecSQL;

  //showmessage('Veículo incluído com sucesso');
  bm := qPlacasNaoCadastradas.GetBookmark;
  qPlacasNaoCadastradas.Close;
  qPlacasNaoCadastradas.Open;
  qPlacasNaoCadastradas.GotoBookmark(bm);
end;

procedure TfrmPlacasNaoCadastradas.qPlacasNaoCadastradasAfterOpen(
  DataSet: TDataSet);
begin
  pnlRodape.Caption := IntToStr(qPlacasNaoCadastradas.RecordCount)+' Placas não cadastradas';
end;

end.
