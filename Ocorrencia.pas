unit Ocorrencia;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, DB, ADODB;

type
  TfrmOcorrencia = class(TForm)
    qOcorrencias: TADOQuery;
    dsOcorrencias: TDataSource;
    qUnidadesCredenciadas: TADOQuery;
    dsUnidadesCredenciadas: TDataSource;
    Posto: TLabel;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBLookupComboBox1: TDBLookupComboBox;
    qEmpresas: TADOQuery;
    dsEmpresas: TDataSource;
    Label3: TLabel;
    DBLookupComboBox2: TDBLookupComboBox;
    btSalvar: TButton;
    DBEdit2: TDBEdit;
    procedure FormActivate(Sender: TObject);
    procedure btSalvarClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOcorrencia: TfrmOcorrencia;

implementation

uses DM;

{$R *.dfm}

procedure TfrmOcorrencia.FormActivate(Sender: TObject);
begin
  //

  qUnidadesCredenciadas.Close;
  qUnidadesCredenciadas.SQL.text :=
    'select distinct uc.Id, uc.NomeFantasia  '+
    'from   View_Autorizacoes v       '+
    'inner  join UnidadesCredenciadas uc on uc.id = v.UnidadeCredenciada_Id '+
    'where  v.Data > getdate() - 30   '+
    'order  by uc.NomeFantasia        ';
  qUnidadesCredenciadas.Open;

  qEmpresas.Close;
  qEmpresas.SQL.text :=
    'select distinct e.Id, e.NomeFantasia  '+
    'from   View_Autorizacoes v       '+
    'inner  join Empresas e on e.id = v.Empresa_Id '+
    'where  v.Data > getdate() - 30   '+
    'order  by e.NomeFantasia        ';
  qEmpresas.Open;

  qOcorrencias.Close;
  qOcorrencias.SQL.text :=
    'select *                '+
    'from   FapesOcorrencias ';
  qOcorrencias.Open;

  qOcorrencias.Insert;
end;

procedure TfrmOcorrencia.btSalvarClick(Sender: TObject);
begin
  qOcorrencias.Post;

  frmOcorrencia.Close;
end;

end.
