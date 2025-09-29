unit Recalcularkml;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls;

type
  TfrmRecalcularkml = class(TForm)
    Panel1: TPanel;
    Panel3: TPanel;
    DBGrid1: TDBGrid;
    Panel4: TPanel;
    DBGrid2: TDBGrid;
    Panel5: TPanel;
    Panel6: TPanel;
    Panel7: TPanel;
    DBGrid3: TDBGrid;
    qEmpresas: TADOQuery;
    qVeiculos: TADOQuery;
    qAutorizacoes: TADOQuery;
    dsEmpresas: TDataSource;
    dsVeiculos: TDataSource;
    dsAutorizacoes: TDataSource;
    qAutorizacoesNome: TWideStringField;
    qAutorizacoesdata: TDateTimeField;
    qAutorizacoesNumeroCupomFiscal: TIntegerField;
    qAutorizacoesQuantidade: TBCDField;
    qAutorizacoesKmAnterior: TBCDField;
    qAutorizacoesKmAtual: TBCDField;
    qAutorizacoesKm_l: TBCDField;
    qAutorizacoesKmPorLitroMinimo: TBCDField;
    qAutorizacoesKmPorLitroMaximo: TBCDField;
    qAutorizacoesItemAutorizacaoControle_Id: TIntegerField;
    cbAtivarRobo: TCheckBox;
    Button1: TButton;
    qAutorizacoesItemAutorizacao_Id: TAutoIncField;
    lblQtdManipulada: TLabel;
    procedure qEmpresasAfterScroll(DataSet: TDataSet);
    procedure FormActivate(Sender: TObject);
    procedure qVeiculosAfterScroll(DataSet: TDataSet);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRecalcularkml: TfrmRecalcularkml;

implementation

uses DM;

{$R *.dfm}

procedure TfrmRecalcularkml.qEmpresasAfterScroll(DataSet: TDataSet);
begin
  qVeiculos.Close;
  qVeiculos.SQL.Text := 'select v.Id Veiculo_Id, u.Descricao  '+
                        'from   Veiculos v                    '+
                        'inner  join UnidadesDeControles u on u.Id = v.Id '+
                        'where  u.Empresa_Id = '+qEmpresas.FieldByName('Empresa_Id').AsString+' '+
                        'Order  by u.Descricao ';
  qVeiculos.Open;
end;

procedure TfrmRecalcularkml.FormActivate(Sender: TObject);
begin
  qEmpresas.Open;
end;

procedure TfrmRecalcularkml.qVeiculosAfterScroll(DataSet: TDataSet);
begin
  qAutorizacoes.Close;
  qAutorizacoes.SQL.Text := ' '+
    'select p.Nome, a.Data, auc.NumeroCupomFiscal, i.Quantidade, i.KmAnterior, i.KmAtual,(i.KmAtual-i.KmAnterior)/i.Quantidade Km_l, '+
    '       v.KmPorLitroMinimo, v.KmPorLitroMaximo, i.ItemAutorizacaoControle_Id, i.Id ItemAutorizacao_Id '+
    'from   Autorizacoes a                                       '+
    'inner  join ItensAutorizacoes i on i.autorizacao_id = a.id  '+
    'inner  join Produtos p on p.id = i.Produto_Id and p.GrupoDeProduto_Id = 1 '+
    'inner  join Veiculos v on v.Id = a.UnidadeDeControle_Id '+
    'inner  join AutorizacoesUnidadesCredenciadas auc on auc.Id = a.id '+
    'where  a.UnidadeDeControle_Id = '+qVeiculos.FieldByName('Veiculo_Id').AsString+' '+
    'order  by a.Data ';
  qAutorizacoes.Open;
end;

procedure TfrmRecalcularkml.Button1Click(Sender: TObject);
var
  KmAnterior :double;
  ItemAutorizacaoControle_Id :String;
  QtdManipulada :Integer;
begin
  //para garantir que na primeira chamada dessa rotina o registro selecionado seja o primeiro
  qAutorizacoes.First;
  QtdManipulada := 0;
  lblQtdManipulada.Caption := 'Qtd Manipulada: 0';

  while not qEmpresas.Eof do
  begin
    while not qVeiculos.Eof do
    begin

      KmAnterior := 0;

      while not qAutorizacoes.Eof do
      begin
        //CORRIGE O KM ANTERIOR
        if qAutorizacoes.FieldByName('KmAnterior').AsFloat <> KmAnterior then
        begin
          frmDM.qAux.sql.Text := 'update ItensAutorizacoes '+
                                 'set    KmAnterior = '+StringReplace(FloatToStr(KmAnterior), ',', '.', [])+' '+
                                 'where  Id = '+qAutorizacoes.FieldByName('ItemAutorizacao_Id').AsString;
          frmDM.qAux.ExecSQL;

          QtdManipulada := QtdManipulada + 1;
          lblQtdManipulada.Caption := 'Qtd Manipulada: '+IntToStr(QtdManipulada);
        end;

        //EXCLUI REGISTRO INFORMANDO ERRO DE MÉDIA DE KM
        if qAutorizacoes.FieldByName('ItemAutorizacaoControle_Id').AsString <> '' then
        begin
          ItemAutorizacaoControle_Id := qAutorizacoes.FieldByName('ItemAutorizacaoControle_Id').AsString;

          frmDM.qAux.sql.Text := 'update ItensAutorizacoes '+
                                 'set    ItemAutorizacaoControle_Id = null '+
                                 'where  Id = '+qAutorizacoes.FieldByName('ItemAutorizacao_Id').AsString;
          frmDM.qAux.ExecSQL;

          frmDM.qAux.sql.Text := 'delete '+
                                 'from   ItensAutorizacoesControles '+
                                 'where  Id = '+ItemAutorizacaoControle_Id;
          frmDM.qAux.ExecSQL;
        end;

        KmAnterior := qAutorizacoes.FieldByName('KmAtual').AsFloat;

        Application.ProcessMessages;
        if cbAtivarRobo.Checked then
          qAutorizacoes.Next
        else
          Exit;
      end;

      if not cbAtivarRobo.Checked then
        Exit;

      qVeiculos.Next;
    end;

    if not cbAtivarRobo.Checked then
      Exit;

    qEmpresas.Next;
  end;
end;

end.
