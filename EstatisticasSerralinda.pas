unit EstatisticasSerralinda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, jpeg, ExtCtrls;

type
  TfrmEstatisticasSerralinda = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtConveniosAtivos: TEdit;
    edtConveniosComCartao: TEdit;
    Label5: TLabel;
    edtPercentualCartoes: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    edtQtdVeiculos: TEdit;
    edtVeiculosComCartao: TEdit;
    Label8: TLabel;
    edtPercentualVeiculosComCartoes: TEdit;
    edtQtdMotoristas: TEdit;
    Label9: TLabel;
    lblAguarde: TLabel;
    Memo1: TMemo;
    Label11: TLabel;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEstatisticasSerralinda: TfrmEstatisticasSerralinda;

implementation

uses DM;

{$R *.dfm}

procedure TfrmEstatisticasSerralinda.FormActivate(Sender: TObject);
var
  qtdConvenios, qtdConveniosComCartao :Integer;
  qtdVeiculos, qtdVeiculosComCartao :Integer;
  qtdMotoristas :integer;
begin
  lblAguarde.Visible := true;
  Application.ProcessMessages;

  //QTD DE EMPRESAS ATIVAS
  frmDM.qAux.SQL.text :=
    'select count(*) QtdEmpresas '+
    'from   empresas e           '+
    'inner  join Contratos c on c.Empresa_Id = e.id and UnidadeCredenciada_Id = 21 '+ //pao com linguica
    'where  e.id > 74            '+
    '  and  e.Ativo = 1          ';
  frmDM.qAux.Open;
  qtdConvenios := frmDM.qAux.FieldByName('QtdEmpresas').AsInteger;
  edtConveniosAtivos.Text := formatfloat('#,##0', qtdConvenios);
  frmDM.qAux.Close;
  Application.ProcessMessages;

  //QTD DE EMPRESAS COM CARTÃO
  frmDM.qAux.SQL.text :=
    'select count(*) QtdEmpresas                   '+
    'from   empresas e                             '+
    'inner  join Contratos c on c.Empresa_Id = e.id and UnidadeCredenciada_Id = 21 '+ //pao com linguica
    'where  e.id > 74                              '+
    '  and  e.Ativo = 1                            '+
    '  and  exists(select *                        '+
    '              from   UnidadesDeControles u    '+
    '			  inner  join veiculos v on v.id = u.id  '+
    '			  where  u.empresa_id = e.id             '+
    '			    and  v.NumeroDoCartao is not null)   ';
  frmDM.qAux.Open;
  qtdConveniosComCartao   := frmDM.qAux.FieldByName('QtdEmpresas').AsInteger;
  edtConveniosComCartao.Text := formatfloat('#,##0', qtdConveniosComCartao);
  edtPercentualCArtoes.Text := formatfloat('#,##0.0', (qtdConveniosComCartao*100)/qtdConvenios);
  frmDM.qAux.Close;
  Application.ProcessMessages;

  //QTD DE VEÍCULOS ATIVOS
  frmDM.qAux.SQL.text :=
    'select count(*) QtdVeiculos '+
    'from   empresas e           '+
    'inner  join Contratos c on c.Empresa_Id = e.id and UnidadeCredenciada_Id = 21 '+ //pao com linguica
    'inner  join UnidadesDeControles u on u.Empresa_Id = e.id and u.Ativo = 1 '+
    'inner  join veiculos v on v.id = u.id and not(v.placa like ''TMP%'') '+
    'where  e.id > 74            '+
    '  and  e.Ativo = 1          ';
  frmDM.qAux.Open;
  qtdVeiculos := frmDM.qAux.FieldByName('QtdVeiculos').AsInteger;
  edtQtdVeiculos.Text := formatfloat('#,##0', qtdVeiculos);
  frmDM.qAux.Close;
  Application.ProcessMessages;

  //QTD DE VEÍCULOS ATIVOS COM CARTÃO
  frmDM.qAux.SQL.text :=
    'select count(*) QtdVeiculos '+
    'from   empresas e           '+
    'inner  join Contratos c on c.Empresa_Id = e.id and UnidadeCredenciada_Id = 21 '+ //pao com linguica
    'inner  join UnidadesDeControles u on u.Empresa_Id = e.id and u.Ativo = 1 '+
    'inner  join veiculos v on v.id = u.id and not(v.placa like ''TMP%'') and v.NumeroDoCartao is not null '+
    'where  e.id > 74            '+
    '  and  e.Ativo = 1          ';
  frmDM.qAux.Open;
  qtdVeiculosComCartao := frmDM.qAux.FieldByName('QtdVeiculos').AsInteger;
  edtVeiculosComCartao.Text := formatfloat('#,##0', qtdVeiculosComCartao);
  edtPercentualVeiculosComCartoes.Text := formatfloat('#,##0.0', (qtdVeiculosComCartao*100)/qtdVeiculos);
  frmDM.qAux.Close;
  Application.ProcessMessages;

  //QTD MOTORISTAS
  frmDM.qAux.SQL.text :=
    'select count(*) QtdMotoristas '+
    'from   empresas e           '+
    'inner  join Contratos c on c.Empresa_Id = e.id and UnidadeCredenciada_Id = 21 '+ //pao com linguica
    'inner  join Operadores o on o.empresa_id = e.id and o.Cpf <> ''800.000.000-86'' '+
    'where  e.id > 74            '+
    '  and  e.Ativo = 1          ';
  frmDM.qAux.Open;
  qtdMotoristas := frmDM.qAux.FieldByName('QtdMotoristas').AsInteger;
  edtQtdMotoristas.Text := formatfloat('#,##0', qtdMotoristas);
  frmDM.qAux.Close;
  Application.ProcessMessages;

  //EMPRESAS COM VEÍCULOS COM CARTÕES
  frmDM.qAux.SQL.text :=
    'select e.NomeFantasia '+
    'from   empresas e                             '+
    'inner  join Contratos c on c.Empresa_Id = e.id and UnidadeCredenciada_Id = 21 '+ //pao com linguica
    'where  e.id > 74                              '+
    '  and  e.Ativo = 1                            '+
    '  and  exists(select *                        '+
    '              from   UnidadesDeControles u    '+
    '			  inner  join veiculos v on v.id = u.id  '+
    '			  where  u.empresa_id = e.id             '+
    '			    and  v.NumeroDoCartao is not null)   '+
    'order  by 1 ';
  frmDM.qAux.Open;

  //PREENCHE A LISTA DE EMPRESAS QUE JÁ POSSUEM CARTÕES
  Memo1.Lines.Clear;
  while not frmDM.qAux.Eof do
  begin
    Memo1.Lines.Text := Memo1.Lines.Text + IntToStr(Memo1.lines.Count+1)+'- '+
                        frmDM.qAux.FieldByName('NomeFantasia').AsString + #13;
    frmDM.qAux.Next;
  end;

  frmDM.qAux.Close;
  Application.ProcessMessages;

  lblAguarde.Visible := false;

end;

end.
