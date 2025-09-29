unit ChavesMaquininhas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls, Mask, DBCtrls;

type
  TfrmChavesMaquininhas = class(TForm)
    dsChavesMaquininhas: TDataSource;
    DBGrid1: TDBGrid;
    qChavesMaquininhas: TADOQuery;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    edtFiltroPosto: TEdit;
    DBGrid2: TDBGrid;
    Label2: TLabel;
    Panel1: TPanel;
    Label3: TLabel;
    qPostos: TADOQuery;
    dsPostos: TDataSource;
    btnCriarChave: TButton;
    DBEdit1: TDBEdit;
    procedure FormActivate(Sender: TObject);
    procedure edtFiltroPostoChange(Sender: TObject);
    procedure qPostosAfterScroll(DataSet: TDataSet);
    procedure btnCriarChaveClick(Sender: TObject);
  private
    { Private declarations }
    procedure ConsultarMaquininhas();
  public
    { Public declarations }
  end;

var
  frmChavesMaquininhas: TfrmChavesMaquininhas;

implementation

uses DM;

{$R *.dfm}

procedure TfrmChavesMaquininhas.FormActivate(Sender: TObject);
begin
  qPostos.Close;
  qPostos.SQL.text :=
    'select id, NomeFantasia, RazaoSocial '+
    'from   UnidadesCredenciadas uc '+
    'where  uc.Ativo = 1            '+
    'order  by NomeFantasia         ';
  qPostos.Open;
end;

procedure TfrmChavesMaquininhas.ConsultarMaquininhas();
begin
  qChavesMaquininhas.Close;
  qChavesMaquininhas.SQL.text :=
    '';

  qChavesMaquininhas.Open;
end;

procedure TfrmChavesMaquininhas.edtFiltroPostoChange(Sender: TObject);
begin
  if trim(edtFiltroPosto.Text) = '' then
    qPostos.Filtered := false
  else
  begin
    qPostos.Filter := 'NomeFantasia like ''%'+edtFiltroPosto.Text+'%'' or '+
                      'RazaoSocial like ''%'+edtFiltroPosto.Text+'%'' ';
    qPostos.Filtered := true;
  end;
end;

procedure TfrmChavesMaquininhas.qPostosAfterScroll(DataSet: TDataSet);
begin
  qChavesMaquininhas.Close;
  qChavesMaquininhas.SQL.text :=
    'select Id, MacAndress, ChaveRegistro '+
    'from   RegistrosMaquinetas           '+
    'where  UnidadeCredenciada_Id = '+qPostos.FieldByName('Id').AsString+' '+
    '  and  StatusRegistroMaquineta = 0   ';
  qChavesMaquininhas.Open;
end;

procedure TfrmChavesMaquininhas.btnCriarChaveClick(Sender: TObject);
var
  novaChave :String;
begin
  //CALCULANDO A CHAVE PARA A UNIDADE CREDENCIADA (POSTO)
  frmDM.qAux.SQL.Text :=
    'select max(ChaveRegistro) maiorchave '+
    'from   RegistrosMaquinetas           '+
    'where  UnidadeCredenciada_Id = '+qPostos.FieldByName('Id').AsString+' '+
    '  and  ChaveRegistro like CAST(UnidadeCredenciada_Id as varchar)+''%'' ';
  frmDM.qAux.Open;

  if frmDM.qAux.FieldByName('maiorchave').IsNull then
    novaChave := qPostos.FieldByName('Id').AsString+'001'
  else
    novaChave := IntToStr(frmDM.qAux.FieldByName('maiorchave').AsInteger + 1);

  frmDM.qAux.Close;

  frmDM.qAux.SQL.Text :=
    'insert into RegistrosMaquinetas                             '+
    '(MacAndress, StatusRegistroMaquineta, DataDeCadastro,       '+
    ' DataUltimaAlteracao, UnidadeCredenciada_Id, ChaveRegistro) '+
    'values                                                      '+
    '('''+qPostos.FieldByName('NomeFantasia').AsString+''', 0, getdate(), getdate(), '+
          qPostos.FieldByName('Id').AsString+', '''+novaChave+''')';
  frmDM.qAux.ExecSql;

  qChavesMaquininhas.Requery();
end;

end.
