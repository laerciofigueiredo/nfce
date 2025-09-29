unit MainInterface;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, DB, ADODB, StdCtrls, DBCtrls, DateUtils, StrUtils,
  Mask, ComCtrls;

type
  TfrmMainInterface = class(TForm)
    qNfce: TADOQuery;
    dsNfce: TDataSource;
    Panel4: TPanel;
    qAutorizacao: TADOQuery;
    dsAutorizacao: TDataSource;
    Panel2: TPanel;
    grdAutorizacoes: TDBGrid;
    pnlAcoes: TPanel;
    btAutorizacaoConferida: TButton;
    btInserirAutorizacao: TButton;
    Panel6: TPanel;
    Panel7: TPanel;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Panel8: TPanel;
    lblQtdRegistros: TLabel;
    Panel10: TPanel;
    pnlAutorizacoes: TPanel;
    lblProduto: TLabel;
    panelProdutos: TPanel;
    cbProdutos: TDBLookupComboBox;
    btIncluirProduto: TButton;
    Label1: TLabel;
    cbNaoConferidos: TCheckBox;
    cbGegel: TCheckBox;
    cbPCL: TCheckBox;
    cbMorada: TCheckBox;
    cbRedevax: TCheckBox;
    cbFiltrarDatas: TCheckBox;
    pnlDatas: TPanel;
    Label2: TLabel;
    btCarregar: TButton;
    btPlacasNaoCadastradas: TButton;
    btRecalcularkml: TButton;
    cbManterVeiculo: TCheckBox;
    cbAtivarRobo: TCheckBox;
    edDataInicio: TDateTimePicker;
    edDataFim: TDateTimePicker;
    cbNaoFiltrarPeloProduto: TCheckBox;
    procedure FormActivate(Sender: TObject);
    procedure qNfceAfterScroll(DataSet: TDataSet);
    procedure btAutorizacaoConferidaClick(Sender: TObject);
    procedure btIncluirProdutoClick(Sender: TObject);
    procedure btInserirAutorizacaoClick(Sender: TObject);
    procedure cbManterVeiculoClick(Sender: TObject);
    procedure cbAtivarRoboClick(Sender: TObject);
    procedure btCarregarClick(Sender: TObject);
    procedure cbFiltrarDatasClick(Sender: TObject);
    procedure btPlacasNaoCadastradasClick(Sender: TObject);
    procedure btRecalcularkmlClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConsultarRegistrosNfce();
    procedure Limpa_campos();
    function  PrecisaSincronizar():Boolean;
    procedure LimparRegistrosInconsistentes();
  public
    { Public declarations }
  end;

var
  frmMainInterface: TfrmMainInterface;

implementation

uses DM, PlacasNaoCadastradas, Recalcularkml;

{$R *.dfm}

procedure TfrmMainInterface.FormActivate(Sender: TObject);
begin
  //
  edDataInicio.Date := StartOfTheMonth(Today());
  edDataFim.Date := Today()-1;
end;

procedure TfrmMainInterface.btCarregarClick(Sender: TObject);
begin
  LimparRegistrosInconsistentes();
  ConsultarRegistrosNfce();
end;

procedure TfrmMainInterface.ConsultarRegistrosNfce();
var
  strWhere, strAux :String;
begin
  //VERIFICA SE PELO MENOS UM DOS POSTOS ESTÁ SELECIONADO
  if not(cbPCL.Checked or cbGegel.Checked or cbRedevax.Checked or cbMorada.Checked) then
    Exit;

  strAux := '';
  if cbPCL.Checked then strAux := strAux + '21, ';
  if cbGegel.Checked then strAux := strAux + '18, ';
  if cbRedevax.Checked then strAux := strAux + '37, ';
  if cbMorada.Checked then strAux := strAux + '50, ';
  strAux := LeftStr(strAux, Length(strAux)-2);
  strWhere := '  and  uc.Id in ('+strAux+') ';

  //
  if cbNaoConferidos.Checked then
    strWhere := strWhere + ' and  i.ConferidoNfce = 0 ';

  //
  if cbFiltrarDatas.Checked then
    strWhere := strWhere + ' and n.DataEmissao between '''+FormatDateTime('yyyy-mm-dd hh:nn', edDataInicio.Date)+''' and '''+FormatDateTime('yyyy-mm-dd hh:nn', edDataFim.Date)+''' ';

  qNfce.Close;
  qNfce.SQL.Text := ''+
    'select uc.Id as UnidadeCredenciada_Id, uc.NomeFantasia, e.Id as Empresa_Id, e.RazaoSocial, '+
    '       n.NumeroNF, n.DataEmissao, n.Placa, n.Km,                                           '+
    '       i.NomeProduto, i.QtdProduto, i.ValorUnitario, i.ValorTotal,                         '+
    '       i.ConferidoNfce as Conferido_ItemNfce, i.Id as ItemNfce_Id, i.ItemAutorizacao_Id, Nfce_Id '+
    'from   Nfce n                                                    '+
    'inner  join ItensNfce i on i.Nfce_Id = n.id                      '+
    'inner  join UnidadesCredenciadas uc on uc.Cnpj = n.CnpjEmitente  '+
    'inner  join Empresas e on e.CpfOuCnpj = n.CnpjDestinatario       '+
    'where  n.Status = ''Emitido''                                    '+
    strWhere+
    //'  and  uc.Id in (21) --, 18)                                     '+
    //'  --and  i.ConferidoNfce = 0                                     '+
    //'  and  n.DataEmissao between '2022-08-15' and '2022-08-17'       '+
    'order  by uc.NomeFantasia, e.RazaoSocial, DataEmissao';
  qNfce.Open;
  lblQtdRegistros.Caption := IntToStr(qNfce.RecordCount) + ' registros';
end;

procedure TfrmMainInterface.qNfceAfterScroll(DataSet: TDataSet);
var dif:single;
begin
  Limpa_campos();

  if qAutorizacao.State = dsInactive then
  begin
    if cbAtivarRobo.Checked then if not qNfce.Eof then qNfce.Next;
    Exit;
  end;

  if qAutorizacao.RecordCount = 1 then
  begin
    //se a diferença entre as datas for maior que 12 horas, passa para o próximo
    if qNfce.FieldByName('DataEmissao').AsDateTime > qAutorizacao.FieldByName('Data').AsDateTime then
      dif := qNfce.FieldByName('DataEmissao').AsDateTime - qAutorizacao.FieldByName('Data').AsDateTime
    else
      dif := qAutorizacao.FieldByName('Data').AsDateTime - qNfce.FieldByName('DataEmissao').AsDateTime;

    dif := dif * 24;

    if dif > 12 then
    begin
      if cbAtivarRobo.Checked then if not qNfce.Eof then qNfce.Next;
      exit;
    end;

    //se já foi conferido pula para o próximo
    if not PrecisaSincronizar() then
      if cbAtivarRobo.Checked then if not qNfce.Eof then qNfce.Next;
  end
  else
  begin
    //if qAutorizacao.recordcount = 0 then
    //  if cbAtivarRobo.Checked then if not qNfce.Eof then qNfce.Next;
  end;

end;

procedure TfrmMainInterface.Limpa_campos();
begin
  frmDM.qProdutoIntegracao.Close;
  qAutorizacao.Close;
  panelProdutos.Visible := False;

  //VERIFICANDO A EXISTENCIA DA INTEGRAÇÃO DO PRODUTO NO GEKOM
  frmDM.qProdutoIntegracao.Close;
  frmDM.qProdutoIntegracao.Parameters.ParamByName('NomeProduto').Value := qNfce.FieldByName('NomeProduto').AsString;
  frmDM.qProdutoIntegracao.Open;

  if frmDM.qProdutoIntegracao.RecordCount > 0 then
  begin
    lblProduto.Caption := 'PRODUTO: '+frmDM.qProdutoIntegracao.FieldByName('Nome').AsString;
    lblProduto.Font.Color := clWindowText;
  end
  else
  begin
    lblProduto.Caption := 'PRODUTO: Não encontrado integração para este produto';
    lblProduto.Font.Color := clRed;
    frmDM.qProdutos.Open;
    panelProdutos.Visible := True;
    Exit;
  end;

  //BUSCANDO A AUTORIZAÇÃO CORRESPONDENTE
  qAutorizacao.Sql.Text := ' '+
    'select u.NomeFantasia, e.RazaoSocial, NumeroCupomFiscal, a.Data, V.Placa, ia.KmAtual, '+
    '       p.Nome as NomeProduto, ia.Quantidade, ia.ValorUnitario, ia.Valor, ia.ConferidoNfce,           '+
    '       ia.Autorizacao_Id, ia.Id as ItemAutorizacao_Id, a.UnidadeDeControle_Id         '+
    'from   Autorizacoes a                                                                 '+
    'inner  join AutorizacoesUnidadesCredenciadas auc on auc.Id = a.Id                     '+
    'inner  join UnidadesCredenciadas u on u.id = auc.UnidadeCredenciada_Id                '+
    'inner  join UnidadesDeControles uc on uc.Id = a.UnidadeDeControle_Id                  '+
    'inner  join Empresas e on e.id = uc.Empresa_Id                                        '+
    'inner  join Veiculos v on v.Id = uc.Id                                                '+
    'inner  join ItensAutorizacoes ia on ia.Autorizacao_Id = a.id                          ';
  if cbNaoFiltrarPeloProduto.Checked then
    qAutorizacao.Sql.Text := qAutorizacao.Sql.Text + 'left  join Produtos p on p.Id = ia.Produto_Id '
  else
    qAutorizacao.Sql.Text := qAutorizacao.Sql.Text + 'inner  join Produtos p on p.Id = ia.Produto_Id ';

  qAutorizacao.Sql.Text := qAutorizacao.Sql.Text +  
    'inner  join IntegracaoProdutos ip on ip.Produto_Id = p.Id and ip.NomeProduto = '''+qNfce.FieldByName('NomeProduto').AsString+''' '+
    'where  auc.UnidadeCredenciada_Id = '+qNfce.FieldByName('UnidadeCredenciada_Id').AsString+' '+
    '  and  uc.Empresa_Id = '+qNfce.FieldByName('Empresa_Id').AsString+'                   '+
    '  and  (V.Placa = '''+qNfce.FieldByName('Placa').AsString+''' or V.Placa like ''TMP%'') '+
    '  and  a.Data between '''+FormatDateTime('yyyy-mm-dd hh:nn', IncHour(qNfce.FieldByName('DataEmissao').AsDatetime, -12))+''' and '''+FormatDateTime('yyyy-mm-dd hh:nn', IncHour(qNfce.FieldByName('DataEmissao').AsDatetime, 12))+''' '+
    '  and  ia.Quantidade >= '+StringReplace(qNfce.FieldByName('QtdProduto').AsString, ',', '.', [])+' - 0.01 '+
    '  and  ia.Quantidade <  '+StringReplace(qNfce.FieldByName('QtdProduto').AsString, ',', '.', [])+' + 0.01 ';
    //'  and  ia.ConferidoNfce = 0 ';

  qAutorizacao.Open;
  Application.ProcessMessages;
end;

function TfrmMainInterface.PrecisaSincronizar():Boolean;
begin
  PrecisaSincronizar := not qNfce.FieldByName('Conferido_ItemNfce').AsBoolean;
end;

procedure TfrmMainInterface.btAutorizacaoConferidaClick(Sender: TObject);
var
  bm : TBookMark;
begin
  //VERIFICA SE O ITEM DE AUTORIZACAO SELECIONADO JA FOI CONFERIDO COM OUTRO ITEM DE NFCE
  if (qAutorizacao.FieldByName('ConferidoNfce').AsBoolean = true) or
     (qAutorizacao.recordcount = 0) then
  begin
    if not qNfce.Eof then qNfce.Next;
    if cbAtivarRobo.Checked then btAutorizacaoConferidaClick(Sender);
    Exit;
  end;

  //SE FOR O VEÍCULO TEMPORÁRIO/FICTÍCIO VAMOS OBTER O ID DO VEÍCULO REAL
  if (not cbManterVeiculo.Checked) and (leftstr(qAutorizacao.FieldByName('Placa').AsString, 3) = 'TMP') then
  begin
    frmDM.qVeiculo.Close;
    frmDM.qVeiculo.Parameters.ParamByName('Empresa_Id').Value := qNfce.FieldByName('Empresa_Id').AsInteger;
    frmDM.qVeiculo.Parameters.ParamByName('Placa').Value := trim(qNfce.FieldByName('Placa').AsString);
    frmDM.qVeiculo.Open;

    if frmDM.qVeiculo.RecordCount = 1 then
    begin
      frmDM.qAux.Sql.Text := 'update Autorizacoes '+
                             'set    UnidadeDeControle_Id = '+frmDM.qVeiculo.FieldByName('Id').AsString+', '+
                             '       CentroDeCusto_Id = '+frmDM.qVeiculo.FieldByName('CentroDeCusto_Id').AsString+', '+
                             '       PlacaOriginal = '''+qAutorizacao.FieldByName('Placa').AsString+''' '+
                             'where  id = '+qAutorizacao.FieldByName('Autorizacao_Id').AsString;
      frmDM.qAux.ExecSql;
    end
    else
    begin
      if not qNfce.Eof then qNfce.Next;
      if cbAtivarRobo.Checked then btAutorizacaoConferidaClick(Sender);
      Exit;
    end;

    frmDM.qVeiculo.Close;
  end;
  
  //PREENCHER O CUPOM DA AUTORIZAÇÃO
  frmDM.qAux.Sql.Text := 'update AutorizacoesUnidadesCredenciadas  set NumeroCupomFiscal = '''+qNfce.FieldByName('NumeroNF').AsString+''' '+
                         'where id = '+qAutorizacao.FieldByName('Autorizacao_Id').AsString;
  frmDM.qAux.ExecSql;

  //MARCAR O ITEM_DE_AUTORIZAÇÃO COMO CONFERIDO
  frmDM.qAux.Sql.Text := 'update ItensAutorizacoes '+
                         'set    ConferidoNfce = 1, '+
                         '       ValorUnitario = '+StringReplace(qNfce.FieldByName('ValorUnitario').AsString, ',', '.', [])+', '+
                         '       Valor = '+StringReplace(qNfce.FieldByName('ValorTotal').AsString, ',', '.', [])+' '+
                         'where  id = '+qAutorizacao.FieldByName('ItemAutorizacao_Id').AsString;
  frmDM.qAux.ExecSql;

  //MARCAR O ITEM_NFCE COMO CONFERIDO
  frmDM.qAux.Sql.Text := 'update ItensNfce set ConferidoNfce = 1, ItemAutorizacao_Id = '+qAutorizacao.FieldByName('ItemAutorizacao_Id').AsString+' '+
                         'where id = '+qNfce.FieldByName('ItemNfce_Id').AsString;
  frmDM.qAux.ExecSql;

  //SE TODOS OS ITENS ESTIVEREM CONFERIDOS, MARCAR O REGISTRO NFCE COMO CONFERIDO
  frmDM.qAux.Sql.Text := 'update Nfce set ConferidoNfce = 1 where id = '+qNfce.FieldByName('Nfce_Id').AsString+' '+
                         '  and  not exists(select * from itensNfce where Nfce_Id = Nfce.Id and ConferidoNfce = 0)';
  frmDM.qAux.ExecSql;

  {bm := qNfce.GetBookmark;
  qNfce.Requery;
  qNfce.GotoBookmark(bm);
  }
  if not qNfce.Eof then
    qNfce.Next
  else
    if cbAtivarRobo.Checked then btAutorizacaoConferidaClick(Sender);
end;

procedure TfrmMainInterface.btIncluirProdutoClick(Sender: TObject);
begin
  frmDM.qAux.SQL.Text := 'insert into IntegracaoProdutos '+
                         '(NomeProduto, DataDeCadastro, DataUltimaAlteracao, Produto_Id) '+
                         'Values '+
                         '('''+Trim(qNfce.FieldByName('NomeProduto').AsString)+''' , GETDATE(), GETDATE(), '+frmDM.qProdutos.FieldByName('Id').AsString+')';
  frmDM.qAux.ExecSQL;
  panelProdutos.Visible := False;
end;

procedure TfrmMainInterface.btInserirAutorizacaoClick(Sender: TObject);
var
  Operador_Id, Produto_Id :String;
  UnidadeDeControle_Id, CentroDeCusto_Id :String;
  DataAutorizacao, Autorizacao_Id, ItemAutorizacao_Id :String;
  bm : TBookMark;
begin
  //NÃO PERMITIR INSERIR A AUTORIZAÇÃO ENQUANTO NÃO TIVER PASSADO 12H DO CUPOM
  if MinutesBetween(qNfce.FieldByName('DataEmissao').AsDateTime, Now()) < 6 * 60 then
  begin
    ShowMessage('Muito recente para já incluir a autorização. Dê um tempo para o posto.');
    Exit;
  end;

  //BUSCANDO INFORMAÇÕES DO VEÍCULO
  frmDM.qVeiculo.Parameters.ParamByName('Empresa_Id').Value := qNfce.FieldByName('Empresa_Id').AsInteger;
  frmDM.qVeiculo.Parameters.ParamByName('Placa').Value := qNfce.FieldByName('Placa').AsString;
  frmDM.qVeiculo.Open;

  if frmDM.qVeiculo.RecordCount = 0 then
    Exit;

  UnidadeDeControle_Id := frmDM.qVeiculo.FieldByName('Id').AsString;
  CentroDeCusto_Id     := frmDM.qVeiculo.FieldByName('CentroDeCusto_Id').AsString;

  frmDM.qVeiculo.Close;

  //BUSCANDO ID DO MOTORISTA NÃO IDENTIFICADO PARA ESSA EMPRESA
  frmDM.qAux.SQL.Text := 'select id                       '+
                         'from   Operadores o             '+
                         'where  o.empresa_id = '+qNfce.FieldByName('Empresa_Id').AsString+' '+
                         '  and  Cpf = ''800.000.000-86'' ';
  frmDM.qAux.Open;

  if frmDM.qAux.RecordCount = 0 then
    Exit
  else
    Operador_Id := frmDM.qAux.FieldByName('Id').AsString;

  frmDM.qAux.Close;

  //BUSCANDO O CÓDIGO DO PRODUTO
  frmDM.qAux.SQL.Text := 'select Produto_Id '+
                         'from   IntegracaoProdutos i '+
                         'where  i.NomeProduto = '''+qNfce.FieldByName('NomeProduto').AsString+''' ';
  frmDM.qAux.Open;

  if frmDM.qAux.RecordCount = 0 then
    Exit
  else
    Produto_Id := frmDM.qAux.FieldByName('Produto_Id').AsString;

  frmDM.qAux.Close;

  //INICIA TRANSAÇÃO NO BD PARA CRIAÇÃO DOS REGISTROS
  frmDM.ADOConnection1.BeginTrans;
  try
    DataAutorizacao := FormatDateTime('yyyy-mm-dd hh:nn', qNfce.FieldByName('DataEmissao').AsDateTime);

    {cria o registro de autorização}
    frmDM.qAux.SQL.text := 'insert into Autorizacoes '+
                           '(Data, DataDeCadastro, DataUltimaAlteracao, CentroDeCusto_Id, Operador_Id, UnidadeDeControle_Id) '+
                           'values '+
                           '('''+DataAutorizacao+''', '+
                           'getdate(), getdate(), '+CentroDeCusto_Id+', '+Operador_Id+', '+UnidadeDeControle_Id+')';
    frmDM.qAux.ExecSQL;

    {obtem o id do autorização}
    frmDM.qAux.SQL.Text := 'select Id from autorizacoes '+
                           'where  Data = '''+DataAutorizacao+''' '+
                           '  and  UnidadeDeControle_Id = '+UnidadeDeControle_Id+' '+
                           'order  by Id desc ';
    frmDM.qAux.Open;
    Autorizacao_Id := frmDM.qAux.FieldByName('Id').AsString;
    frmDM.qAux.Close;

    {Cria o registro de AutorizacoesUnidadesCredenciadas}
    frmDM.qAux.SQL.text := 'insert into AutorizacoesUnidadesCredenciadas '+
                           '(Id, UnidadeCredenciada_Id, ValorAutorizado, NumeroCupomFiscal, OrigemSincronizacao) '+
                           'values '+
                           '('+Autorizacao_Id+', '+
                            qNfce.FieldByName('UnidadeCredenciada_Id').AsString+', '+
                            StringReplace(qNfce.FieldByName('ValorTotal').AsString, ',', '.', [])+', '+
                            ' '''+qNfce.FieldByName('NumeroNF').AsString+''', '+
                            ' ''EmailPosto'')';

    frmDM.qAux.ExecSQL;

    {cria o registro de itensAutorizacoes}
    frmDM.qAux.SQL.text := 'insert into ItensAutorizacoes '+
                           '(Quantidade, KmAtual, DataDeCadastro, DataUltimaAlteracao, Valor, '+
                           ' Autorizacao_Id, Produto_Id, ValorUnitario, ConferidoNfce, KmAnterior, '+
                           ' HorimetroAnterior, HorimetroAtual, Discriminator) '+
                           'values '+
                           '('+StringReplace(qNfce.FieldByName('QtdProduto').AsString, ',', '.', [])+', '+
                              StringReplace(qNfce.FieldByName('Km').AsString, ',', '.', [])+', '+
                             'getdate(), getdate(), '+
                              StringReplace(qNfce.FieldByName('ValorTotal').AsString, ',', '.', [])+', '+
                              Autorizacao_Id+', '+
                              Produto_Id+', '+
                              StringReplace(qNfce.FieldByName('ValorUnitario').AsString, ',', '.', [])+', '+
                              '1, 0, 0, 0, ''ItemAutorizacaoUnidadeCredenciada'')';

    frmDM.qAux.ExecSQL;

    //OBTENDO O CÓDIGO DO ITEM CRIADO
    frmDM.qAux.SQL.Text := 'select id '+
                           'from   ItensAutorizacoes '+
                           'where  Autorizacao_Id = '+Autorizacao_Id+' '+
                           '  and  Produto_Id = '+Produto_Id+' '+
                           'order  by Id desc ';

    frmDM.qAux.Open;
    ItemAutorizacao_Id := frmDM.qAux.FieldByName('Id').AsString;
    frmDM.qAux.Close;

    //MARCAR O ITEM_NFCE COMO CONFERIDO
    frmDM.qAux.Sql.Text := 'update ItensNfce '+
                           'set    ConferidoNfce = 1, ItemAutorizacao_Id = '+ItemAutorizacao_Id+' '+
                           'where id = '+qNfce.FieldByName('ItemNfce_Id').AsString;
    frmDM.qAux.ExecSql;

    //SE TODOS OS ITENS ESTIVEREM CONFERIDOS, MARCAR O REGISTRO NFCE COMO CONFERIDO
    frmDM.qAux.Sql.Text := 'update Nfce set ConferidoNfce = 1 where id = '+qNfce.FieldByName('Nfce_Id').AsString+' '+
                           '  and  not exists(select * from itensNfce where Nfce_Id = Nfce.Id and ConferidoNfce = 0)';
    frmDM.qAux.ExecSql;

    frmDM.ADOConnection1.CommitTrans;

    bm := qNfce.GetBookmark;
    qNfce.Requery;
    qAutorizacao.Requery;
    qNfce.GotoBookmark(bm);
    if not qNfce.Eof then qNfce.Next;
  except
    on E: Exception do
    begin
      frmDM.ADOConnection1.RollbackTrans;
      ShowMessage('Erro: ' + E.Message); // Mostrar o erro
    end;
  end;
end;

procedure TfrmMainInterface.cbManterVeiculoClick(Sender: TObject);
begin
  if cbManterVeiculo.Checked then cbAtivarRobo.Checked := False;

  if cbManterVeiculo.Checked then
    cbManterVeiculo.Font.Color := clRed
  else
    cbManterVeiculo.Font.Color := clBlack;
end;

procedure TfrmMainInterface.cbAtivarRoboClick(Sender: TObject);
begin
  if cbAtivarRobo.Checked then cbManterVeiculo.Checked := False;
end;

procedure TfrmMainInterface.cbFiltrarDatasClick(Sender: TObject);
begin
  pnlDatas.Visible := cbFiltrarDatas.Checked;
end;

procedure TfrmMainInterface.btPlacasNaoCadastradasClick(Sender: TObject);
begin
  frmPlacasNaoCadastradas.ShowModal;
end;

procedure TfrmMainInterface.btRecalcularkmlClick(Sender: TObject);
begin
  frmRecalcularkml.ShowModal;
end;

{LIMPA REGISTROS INCONSISTENTES, SE HOUVEREM}
procedure TfrmMainInterface.LimparRegistrosInconsistentes();
var
  qItensNfceUnidos, qItensNfce: TADOQuery;
begin
  //GARANTINDO QUE NAO EXISTEM AUTORIZAÇÕES "CONFERIDAS" SEM O ITEM DE NFCE CORRESPONDENTE
  frmDM.qAux.SQL.Text := ' '+
    'update ItensAutorizacoes '+
    'set    ConferidoNfce = 0 '+
    'where  ConferidoNfce = 1 '+
    '  and  not exists (select * from ItensNfce i where i.ItemAutorizacao_Id = ItensAutorizacoes.id) ';
  frmDM.qAux.ExecSQL;

  //GARANTINDO QUE NÃO EXISTE ITEM DE NFCE "CONFERIDO" SEM A AUTORIZAÇÃO CORRESPONDENTE
  frmDM.qAux.SQL.Text := ' '+
    'update ItensNfce         '+
    'set    ConferidoNfce = 0 '+
    'where  ConferidoNfce = 1 '+
    '  and  not exists (select * from ItensAutorizacoes ia where ia.id = ItemAutorizacao_Id)';
  frmDM.qAux.ExecSQL;

  //GARANTINDO QUE NÃO EXISTE NFCE "CONFERIDA" SEM QUE TODOS OS ITENS TAMBÉM ESTEJAM CONFERIDOS
  frmDM.qAux.SQL.Text := ' '+
    'update nfce              '+
    'set    ConferidoNfce = 0 '+
    'where  ConferidoNfce = 1 '+
    '  and  exists(select * from ItensNfce i where i.Nfce_Id = nfce.id and i.ConferidoNfce = 0) ';
  frmDM.qAux.ExecSQL;

  //UNINDO ITENS DE NFCE IGUAIS NUMA MESMA NFCE EM 1 SÓ REGISTRO
  qItensNfceUnidos := TADOQuery.Create(frmMainInterface);
  qItensNfceUnidos.Connection := frmDM.ADOConnection1;
  qItensNfce := TADOQuery.Create(frmMainInterface);
  qItensNfce.Connection := frmDM.ADOConnection1;

  qItensNfceUnidos.SQL.Text := ' '+
    'select n.CnpjEmitente, n.CnpjDestinatario, n.NumeroNF, n.DataEmissao, i.NomeProduto, i.ValorUnitario, '+
    '       sum(i.QtdProduto) QtdProduto, sum(i.ValorTotal) ValorTotal, count(*) QtdRegistros '+
    'from   nfce n '+
    'inner  join ItensNfce i on i.Nfce_Id = n.id '+
    'where  i.ConferidoNfce = 0 '+
    'group  by n.CnpjEmitente, n.CnpjDestinatario, n.NumeroNF, n.DataEmissao, i.NomeProduto, i.ValorUnitario '+
    'having count(*) > 1 ';
  qItensNfceUnidos.Open;
  while not qItensNfceUnidos.Eof do
  begin
    //consultar os itens desagrupados de cada item agrupado
    //qItensNfce.SQL.Text := '

    //colocar no primeiro item a quantidade e valor totais

    //excluir os outros itens


    qItensNfceUnidos.Next;
  end;

  qItensNfceUnidos.Close;
  qItensNfceUnidos.Free;
  qItensNfce.Free;
end;

end.
