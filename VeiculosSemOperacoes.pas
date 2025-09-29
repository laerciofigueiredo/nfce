unit VeiculosSemOperacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TfrmVeiculosSemOperacoes = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Label1: TLabel;
    Label2: TLabel;
    qEmpresas: TADOQuery;
    dsEmpresas: TDataSource;
    gridEmpresas: TDBGrid;
    Panel2: TPanel;
    btInativarEmpresa: TButton;
    btInativarVeiculo: TButton;
    qUnidadesDeControle: TADOQuery;
    dsUnidadesDeControle: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure btInativarEmpresaClick(Sender: TObject);
    procedure qEmpresasAfterScroll(DataSet: TDataSet);
    procedure btInativarVeiculoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmVeiculosSemOperacoes: TfrmVeiculosSemOperacoes;

implementation

uses DM;

{$R *.dfm}

procedure TfrmVeiculosSemOperacoes.FormActivate(Sender: TObject);
begin
  qEmpresas.SQL.text :=
    'select udc.Empresa_Id, e.NomeFantasia Empresa, format(max(a.Data), ''yyyy-MM-dd'') MaiorData '+
    'from   Autorizacoes a                                                   '+
    'inner  join UnidadesDeControles udc on udc.id = a.UnidadeDeControle_Id  '+
    'inner  join Empresas e on e.id = udc.Empresa_Id                         '+
    'where  e.Ativo = 1                                                      '+
    'group  by udc.Empresa_Id, e.NomeFantasia                                '+
    'order  by max(Data)  ';
  qEmpresas. Open;

end;

procedure TfrmVeiculosSemOperacoes.btInativarEmpresaClick(Sender: TObject);
begin
  frmDM.qAux.SQL.Text := 'update empresas   '+
                         'set    ativo = 0, '+
                         '       dataultimaalteracao = getdate() '+
                         'where  id = '+qEmpresas.FieldByName('Empresa_Id').AsString;
  frmDM.qAux.ExecSQL;

  qEmpresas.Requery();
end;

procedure TfrmVeiculosSemOperacoes.qEmpresasAfterScroll(DataSet: TDataSet);
begin
  qUnidadesDeControle.SQL.Text :=
    'select a.UnidadeDeControle_Id, udc.Descricao, format(max(a.Data), ''yyyy-MM-dd'') MaiorData '+
    'from   Autorizacoes a                                     '+
    'inner  join UnidadesDeControles udc on udc.id = a.UnidadeDeControle_Id '+
    'inner  join Empresas e on e.id = udc.Empresa_Id           '+
    'where  e.Id = '+qEmpresas.FieldByName('Empresa_Id').AsString+' '+
    '  and  udc.Ativo = 1                                      '+
    'group  by a.UnidadeDeControle_Id, udc.Empresa_Id, e.NomeFantasia, udc.Descricao   '+
    'having max(a.Data) < DATEADD(month, -2, getdate())        '+
    'order  by max(a.Data)                                     ';
  qUnidadesDeControle.Open;
end;

procedure TfrmVeiculosSemOperacoes.btInativarVeiculoClick(Sender: TObject);
begin
  frmDM.qAux.SQL.Text := 'update UnidadesDeControles   '+
                         'set    ativo = 0, '+
                         '       dataultimaalteracao = getdate() '+
                         'where  id = '+qUnidadesDeControle.FieldByName('UnidadeDeControle_Id').AsString;
  frmDM.qAux.ExecSQL;

  qUnidadesDeControle.Requery();
end;

end.
