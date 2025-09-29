unit CoringasZZZ;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids;

type
  TfrmCoringasZZZ = class(TForm)
    DBGrid1: TDBGrid;
    qCoringas: TADOQuery;
    dsCoringas: TDataSource;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmCoringasZZZ: TfrmCoringasZZZ;

implementation

uses DM;

{$R *.dfm}

procedure TfrmCoringasZZZ.FormActivate(Sender: TObject);
begin
  qCoringas.Open;
end;

end.
