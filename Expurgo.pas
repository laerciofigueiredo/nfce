unit Expurgo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, ExtCtrls;

type
  TfrmExpurgo = class(TForm)
    qEmpresas: TADOQuery;
    dsEmpresas: TDataSource;
    Panel2: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    btnExpurgar: TButton;
    edtFiltro: TEdit;
    DBGrid1: TDBGrid;
    Panel3: TPanel;
    Memo1: TMemo;
    procedure FormActivate(Sender: TObject);
    procedure btnExpurgarClick(Sender: TObject);
  private
    { Private declarations }
    procedure EscreverLinha(nivel:integer; txt:string);
    procedure ExcluirEmpresa(nivel:integer; IdEmpresa:String);
    procedure ExcluirCentrosDeCustos(nivel:integer; IdEmpresa:String);
    procedure ExcluirAutorizacoesPorCC(nivel:integer; IdCentroDeCusto:String);
    procedure ExcluirAutorizacoesPorUnidControle(nivel:integer; IdUnidControle:String);
    procedure ExcluirItensAutorizacoes(nivel:integer; IdAutorizacao:String);
    procedure ExcluirAutorizacoesUnidadesCredenciadas(nivel:integer; IdAutorizacao:String);
    procedure ExcluirUnidadesDeControles(nivel:integer; IdCentroDeCusto:String);
    procedure ExcluirVeiculo(nivel:integer; IdUnidadeDeControle:String);
    procedure ExcluirEquipamento(nivel:integer; IdUnidadeDeControle:String);
    procedure ExcluirComboio(nivel:integer; IdUnidadeDeControle:String);
    procedure ExcluirTanqueInterno(nivel:integer; IdUnidadeDeControle:String);
    procedure ExcluirTanquesComboio(nivel:integer; IdComboio:String);
    procedure ExcluirTanquesTanqueInterno(nivel:integer; IdTanqueInterno:String);
    procedure ExcluirMovimentacoesDeEstoquesEmTanques(nivel:integer; IdTanque:String);
    procedure ExcluirTurnos(nivel:integer; IdTanque:String);
    procedure ExcluirTransferencias(nivel:integer; IdTanque:String);
    procedure ExcluirTransferenciasPorTurno(nivel:integer; IdTurno:String);
    procedure ExcluirContatosEmpresas(nivel:integer; IdEmpresa:String);
    procedure ExcluirContratos(nivel:integer; IdEmpresa:String);
    procedure ExcluirContratosGekomEmpresas(nivel:integer; IdEmpresa:String);
    procedure ExcluirOperadores(nivel:integer; IdEmpresa:String);
    procedure ExcluirLogsAplicativosDoOperador(nivel:integer; IdOperador:String);
    procedure ExcluirLogsAplicativosDoUsuario(nivel:integer; IdUsuario:String);
    procedure ExcluirPapeis(nivel:integer; IdEmpresa:String);
    procedure ExcluirPapeisCasosDeUsos(nivel:integer; IdPapel:String);
    procedure ExcluirPapeisUsuarios(nivel:integer; IdPapel:String);
    procedure ExcluirUsuarios(nivel:integer; IdEmpresa:String);
    procedure ExcluirLogsDeConsumosNaoAutorizados(nivel:integer; IdUnidadeDeControle:String);
    procedure ExcluirEmpresasPrePago(nivel:integer; IdEmpresa:String);
    procedure ExcluirRegistrosCreditoPrePago(nivel:integer; IdEmpresa:String);

  public
    { Public declarations }
  end;

var
  frmExpurgo: TfrmExpurgo;

implementation

uses DM;

{$R *.dfm}

procedure TfrmExpurgo.FormActivate(Sender: TObject);
begin
  edtFiltro.SetFocus;

  qEmpresas.SQL.Text := 'select id, nomefantasia, DataDeCadastro, '+
                        '       (select max(a.Data)               '+
                        '        from   Autorizacoes a            '+
                        '        inner  join CentrosDeCustos cc on cc.id = a.CentroDeCusto_Id '+
                        '        where  cc.Empresa_Id = e.id) as DataUltimoAbastecimento      '+
                        'from   empresas e             '+
                        'where  ativo = 0              '+
                        'order  by nomefantasia        ';
  qEmpresas.Open;
end;

procedure TfrmExpurgo.btnExpurgarClick(Sender: TObject);
var nivel:Integer;
begin
  //
  Memo1.Lines.Clear;
  Application.ProcessMessages;
  nivel := 0;
  EscreverLinha(nivel, 'Expurgando EMPRESA: '+qEmpresas.FieldByName('nomefantasia').AsString);

  try
    ExcluirCentrosDeCustos(nivel+1, qEmpresas.FieldByName('Id').AsString);
    ExcluirContatosEmpresas(nivel+1, qEmpresas.FieldByName('Id').AsString);
    ExcluirContratos(nivel+1, qEmpresas.FieldByName('Id').AsString);
    ExcluirContratosGekomEmpresas(nivel+1, qEmpresas.FieldByName('Id').AsString);
    ExcluirOperadores(nivel+1, qEmpresas.FieldByName('Id').AsString);
    ExcluirPapeis(nivel+1, qEmpresas.FieldByName('Id').AsString);
    ExcluirUsuarios(nivel+1, qEmpresas.FieldByName('Id').AsString);
    ExcluirEmpresasPrePago(nivel+1, qEmpresas.FieldByName('Id').AsString);

    ExcluirEmpresa(nivel, qEmpresas.FieldByName('Id').AsString);
    qEmpresas.Close;
    qEmpresas.Open;
  Except
    on E: Exception do
    EscreverLinha(nivel, 'Erro: ' + E.Message );
  end;
end;

procedure TfrmExpurgo.ExcluirEmpresa(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'delete from Empresas where id = '+IdEmpresa;
    ExecSql;
    Free;
  end;
end;

procedure TfrmExpurgo.EscreverLinha(nivel:integer; txt:string);
begin
  Memo1.Lines.Add(StringOfChar(' ', nivel*4) + txt);
end;

procedure TfrmExpurgo.ExcluirCentrosDeCustos(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id, Descricao from CentrosDeCustos where empresa_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      ExcluirAutorizacoesPorCC(nivel+1, FieldByName('Id').AsString);
      Next;
    end;

    First;
    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando CENTRO DE CUSTO: '+ FieldByName('Descricao').AsString);
      ExcluirUnidadesDeControles(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirAutorizacoesPorCC(nivel:integer; IdCentroDeCusto:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id, Data from Autorizacoes where CentroDeCusto_id = '+IdCentroDeCusto;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando AUTORIZAÇÃO: '+ FieldByName('Data').AsString);
      ExcluirItensAutorizacoes(nivel+1, FieldByName('Id').AsString);
      ExcluirAutorizacoesUnidadesCredenciadas(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirAutorizacoesPorUnidControle(nivel:integer; IdUnidControle:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id, Data from Autorizacoes where UnidadeDeControle_id = '+IdUnidControle;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando AUTORIZAÇÃO: '+ FieldByName('Data').AsString);
      ExcluirItensAutorizacoes(nivel+1, FieldByName('Id').AsString);
      ExcluirAutorizacoesUnidadesCredenciadas(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirItensAutorizacoes(nivel:integer; IdAutorizacao:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from ItensAutorizacoes where Autorizacao_id = '+IdAutorizacao;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando ITEM DE AUTORIZAÇÃO: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirAutorizacoesUnidadesCredenciadas(nivel:integer; IdAutorizacao:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from AutorizacoesUnidadesCredenciadas where id = '+IdAutorizacao;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando AUTORIZAÇÃO UNIDADES CREDENCIADAS: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirUnidadesDeControles(nivel:integer; IdCentroDeCusto:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id, Descricao from unidadesdecontroles where CentroDeCusto_id = '+IdCentroDeCusto;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando UNIDADE DE CONTROLE: '+ FieldByName('Descricao').AsString);
      ExcluirVeiculo(nivel+1, FieldByName('Id').AsString);
      ExcluirEquipamento(nivel+1, FieldByName('Id').AsString);
      ExcluirComboio(nivel+1, FieldByName('Id').AsString);
      ExcluirTanqueInterno(nivel+1, FieldByName('Id').AsString);
      ExcluirAutorizacoesPorUnidControle(nivel+1, FieldByName('Id').AsString);
      ExcluirLogsDeConsumosNaoAutorizados(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirVeiculo(nivel:integer; IdUnidadeDeControle:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from Veiculos where id = '+IdUnidadeDeControle;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando VEICULO: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirEquipamento(nivel:integer; IdUnidadeDeControle:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from Equipamentos where id = '+IdUnidadeDeControle;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando EQUIPAMENTO: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirComboio(nivel:integer; IdUnidadeDeControle:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from Comboios where id = '+IdUnidadeDeControle;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando COMBOIO: '+ FieldByName('Id').AsString);
      ExcluirTanquesComboio(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirTanqueInterno(nivel:integer; IdUnidadeDeControle:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from TanquesInternos where id = '+IdUnidadeDeControle;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando TANQUE INTERNO: '+ FieldByName('Id').AsString);
      ExcluirTanquesTanqueInterno(nivel, IdUnidadeDeControle);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirTanquesComboio(nivel:integer; IdComboio:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from Tanques where Comboio_Id = '+IdComboio;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando TANQUE: '+ FieldByName('Id').AsString);
      ExcluirMovimentacoesDeEstoquesEmTanques(nivel+1, FieldByName('Id').AsString);
      ExcluirTransferencias(nivel+1, FieldByName('Id').AsString);
      ExcluirTurnos(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirTanquesTanqueInterno(nivel:integer; IdTanqueInterno:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from Tanques where TanqueInterno_Id = '+IdTanqueInterno;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando TANQUE: '+ FieldByName('Id').AsString);
      ExcluirMovimentacoesDeEstoquesEmTanques(nivel+1, FieldByName('Id').AsString);
      ExcluirTransferencias(nivel+1, FieldByName('Id').AsString);
      ExcluirTurnos(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirMovimentacoesDeEstoquesEmTanques(nivel:integer; IdTanque:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from MovimentacoesDeEstoquesEmTanques where Tanque_Id = '+IdTanque;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando MOVIMENTAÇÃO DE ESTOQUE: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirTurnos(nivel:integer; IdTanque:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from TurnosDosTanques where Tanque_Id = '+IdTanque;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando TURNO: '+ FieldByName('Id').AsString);
      ExcluirTransferenciasPorTurno(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirTransferencias(nivel:integer; IdTanque:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from TransferenciasTanques where TanqueEntrada_Id = '+IdTanque;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando TRANSFERENCIA: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirTransferenciasPorTurno(nivel:integer; IdTurno:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select id from TransferenciasTanques where TurnoDoTanque_Id = '+IdTurno;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando TRANSFERENCIA: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirContatosEmpresas(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id, Nome from ContatosEmpresas where empresa_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando CONTATOS EMPRESAS: '+ FieldByName('Nome').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirContratos(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id from Contratos where empresa_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando CONTRATOS: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirContratosGekomEmpresas(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'update empresas set ContratoGekomEmpresa_Id = null where id = '+IdEmpresa;
    ExecSql;

    SQL.Text := 'select Id from ContratosGekomEmpresas where empresa_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando CONTRATOS GEKOM EMPRESAS: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirOperadores(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id, Nome from Operadores where empresa_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando OPERADORES: '+ FieldByName('Nome').AsString);
      ExcluirLogsAplicativosDoOperador(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirLogsAplicativosDoOperador(nivel:integer; IdOperador:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id from logsAplicativos where operador_id = '+IdOperador;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando LOGS APLICATIVOS: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirLogsAplicativosDoUsuario(nivel:integer; IdUsuario:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id from logsAplicativos where usuario_id = '+IdUsuario;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando LOGS APLICATIVOS: '+ FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirPapeis(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id, Descricao from Papeis where Empresa_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando PAPEL CASO DE USO: '+ FieldByName('Descricao').AsString);
      ExcluirPapeisCasosDeUsos(nivel+1, FieldByName('Id').AsString);
      ExcluirPapeisUsuarios(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirPapeisCasosDeUsos(nivel:integer; IdPapel:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'delete from PapeisCasosDeUsos where Papel_id = '+IdPapel;
    EscreverLinha(nivel, 'Expurgando PAPEIS CASO DE USO.');
    ExecSql;
    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirPapeisUsuarios(nivel:integer; IdPapel:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'delete from PapeisUsuarios where Papel_id = '+IdPapel;
    EscreverLinha(nivel, 'Expurgando PAPEL USUARIO.');
    ExecSql;
    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirUsuarios(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id, Nome from Usuarios where empresa_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando USUARIOS: '+ FieldByName('Nome').AsString);
      ExcluirLogsAplicativosDoUsuario(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirEmpresasPrePago(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id from EmpresasPrePago where empresa_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando EMPRESA PRÉ-PAGO: '+ FieldByName('Id').AsString);
      ExcluirRegistrosCreditoPrePago(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirRegistrosCreditoPrePago(nivel:integer; IdEmpresa:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'select Id from RegistrosCreditoPrePago where EmpresaPrePago_id = '+IdEmpresa;
    Open;

    while not eof do
    begin
      EscreverLinha(nivel, 'Expurgando REGISTRO CREDITO PRÉ-PAGO: '+ FieldByName('Id').AsString);
      ExcluirLogsAplicativosDoUsuario(nivel+1, FieldByName('Id').AsString);
      Delete;
    end;

    Free;
  end;
end;

procedure TfrmExpurgo.ExcluirLogsDeConsumosNaoAutorizados(nivel:integer; IdUnidadeDeControle:String);
var qAux: TADOQuery;
begin
  qAux := TADOQuery.Create(nil);

  with qAux do
  begin
    Connection := frmDM.ADOConnection1;
    SQL.Text := 'delete from LogsDeConsumosNaoAutorizados where UnidadeDeControle_id = '+IdUnidadeDeControle;
    EscreverLinha(nivel, 'Expurgando LOGS DE CONSUMO NÃO AUTORIZADO.');
    ExecSql;
    Free;
  end;
end;

end.
