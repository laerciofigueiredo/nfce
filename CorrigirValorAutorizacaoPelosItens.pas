unit CorrigirValorAutorizacaoPelosItens;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, ExtCtrls;

type
  TfrmCorrigirValorAutorizacaoPelosItens = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    btCorrigir: TButton;
    qAutorizacoes: TADOQuery;
    dsAutorizacoes: TDataSource;
    procedure FormActivate(Sender: TObject);
    procedure btCorrigirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCorrigirValorAutorizacaoPelosItens: TfrmCorrigirValorAutorizacaoPelosItens;

implementation

uses DM;

{$R *.dfm}

procedure TfrmCorrigirValorAutorizacaoPelosItens.FormActivate(
  Sender: TObject);
begin
  qAutorizacoes.Open;
end;

procedure TfrmCorrigirValorAutorizacaoPelosItens.btCorrigirClick(Sender: TObject);
var
  strValor :String;
begin

  while not qAutorizacoes.Eof do
  begin
    strValor := StringReplace(FloatToStr(qAutorizacoes.FieldByName('ValorItens').AsFloat), ',', '.', []);

    frmDM.qAux.SQL.text := 'update AutorizacoesUnidadesCredenciadas '+
                           'set    ValorAutorizado = '+strValor+' '+
                           'where  id = '+qAutorizacoes.FieldByName('Id').AsString;
    frmDM.qAux.ExecSQL;

    qAutorizacoes.Next;
  end;

  qAutorizacoes.Requery();
end;

end.
