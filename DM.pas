unit DM;

interface

uses
  SysUtils, Classes, DBXpress, FMTBcd, ADODB, SqlExpr, DB, IniFiles;

type
  TfrmDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    qVeiculo: TADOQuery;
    qProdutoIntegracao: TADOQuery;
    qAux: TADOQuery;
    qProdutos: TADOQuery;
    dsProdutos: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmDM: TfrmDM;

implementation

{$R *.dfm}

procedure TfrmDM.DataModuleCreate(Sender: TObject);
var
  cmd, ip_server:string;
  ArquivoINI: TIniFile;
begin
  ArquivoINI := TIniFile.Create('.\Configuracoes.ini');
  ip_server := ArquivoINI.ReadString('Secao1', 'ip_server', 'localserver');
  ArquivoINI.Free;

  cmd := 'Provider=SQLNCLI11.1;Persist Security Info=False;User ID=sa; Password=R#45@tyM94;Initial Catalog=GekomProd;Data Source='+ip_server+';Use Procedure for Prepare=1;';
  cmd := cmd + 'Auto Translate=True;Packet Size=4096;Use Encryption for Data=False;Tag with column collation when possible=False;MARS Connection=False;DataTypeCompatibility=0;Trust Server Certificate=False;Application Intent=READWRITE;';
  ADOConnection1.ConnectionString := cmd;
end;

end.
