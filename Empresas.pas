unit Empresas;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, ExtCtrls, StdCtrls;

type
  TfrmEmpresas = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    qEmpresas: TADOQuery;
    dsEmpresas: TDataSource;
    btnAtivarDesativar: TButton;
    Label1: TLabel;
    edtFiltro: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure edtFiltroChange(Sender: TObject);
    procedure btnAtivarDesativarClick(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEmpresas: TfrmEmpresas;

implementation

uses DM;

{$R *.dfm}

procedure TfrmEmpresas.FormActivate(Sender: TObject);
begin
  edtFiltro.SetFocus;
  qEmpresas.Open;
end;

procedure TfrmEmpresas.edtFiltroChange(Sender: TObject);
begin
  if trim(edtFiltro.Text) = '' then
    qEmpresas.Filtered := false
  else
  begin
    qEmpresas.Filter := 'NomeFantasia like ''%'+edtFiltro.Text+'%'' or '+
                        'RazaoSocial like ''%'+edtFiltro.Text+'%'' ';
    qEmpresas.Filtered := true;
  end;
end;

procedure TfrmEmpresas.btnAtivarDesativarClick(Sender: TObject);
begin
  qEmpresas.Edit;
  qEmpresas.FieldByName('Ativo').AsBoolean := not qEmpresas.FieldByName('Ativo').AsBoolean;
  qEmpresas.FieldByName('DataUltimaAlteracao').AsDateTime := Now();
  qEmpresas.Post;
  qEmpresas.Requery();
end;

procedure TfrmEmpresas.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
  //if (Column.Field.FieldName = 'Ativo') then
  //begin
    if qEmpresas.FieldByName('Ativo').AsBoolean = False then
    begin
      //DBGrid1.Canvas.Brush.Color:= clLtGray; //"pinta" a celula inteira
      DBGrid1.Canvas.Font.Color:= clRed; //"Pinta" a letra
      DBGrid1.Canvas.FillRect(Rect);
      DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
    end;
  //end;
end;

end.
