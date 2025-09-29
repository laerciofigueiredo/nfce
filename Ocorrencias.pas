unit Ocorrencias;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, DB, ADODB, StdCtrls, ExtCtrls, Mask, DBCtrls,
  Buttons, ShellAPI;

type
  TfrmOcorrencias = class(TForm)
    qAbastecimentos: TADOQuery;
    dsAbastecimentos: TDataSource;
    qEmpresas: TADOQuery;
    dsEmpresas: TDataSource;
    Panel2: TPanel;
    qOcorrencias: TADOQuery;
    dsOcorrencias: TDataSource;
    DBText1: TDBText;
    DBText2: TDBText;
    qSerasa: TADOQuery;
    dsSerasa: TDataSource;
    Label10: TLabel;
    DBText4: TDBText;
    qAtrasos: TADOQuery;
    dsAtrasos: TDataSource;
    GroupBox1: TGroupBox;
    DBText3: TDBText;
    Label9: TLabel;
    Label11: TLabel;
    DBText5: TDBText;
    Label12: TLabel;
    DBText6: TDBText;
    Label13: TLabel;
    Label14: TLabel;
    DBText7: TDBText;
    btAbrirConsulta: TBitBtn;
    Label15: TLabel;
    DBText8: TDBText;
    GroupBox2: TGroupBox;
    Panel3: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label2: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit1: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    GroupBox3: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox4: TGroupBox;
    DBGrid2: TDBGrid;
    btIncluirOcorrencia: TButton;
    procedure FormActivate(Sender: TObject);
    procedure qEmpresasAfterScroll(DataSet: TDataSet);
    procedure btIncluirOcorrenciaClick(Sender: TObject);
    procedure btAbrirConsultaClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmOcorrencias: TfrmOcorrencias;

implementation

uses Ocorrencia;

{$R *.dfm}

procedure TfrmOcorrencias.FormActivate(Sender: TObject);
begin
  //vamos abrir as empresas que têm convênio com o posto escolhido
  qEmpresas.Close;
  qEmpresas.SQL.text :=
    'select v.Empresa_Id, v.Empresa, e.RazaoSocial, e.CpfOuCnpj, count(*) Autorizacoes '+
    'from   View_Autorizacoes v                             '+
    'inner  join empresas e on e.id = v.Empresa_Id          '+
    'where  v.Data > getdate() - 180                        '+
    '  and  exists (select * from View_Autorizacoes v2 where  v2.Data > getdate() - 30 and v2.Empresa_Id = v.Empresa_Id) '+
    'group  by v.Empresa_Id, v.Empresa, e.RazaoSocial, e.CpfOuCnpj '+
    'order  by 3 desc                                       ';
  qEmpresas.Open;


end;

procedure TfrmOcorrencias.qEmpresasAfterScroll(DataSet: TDataSet);
begin
  //
  qSerasa.Close;
  qSerasa.Sql.Text :=
    'select *            '+
    'from   FapesSerasa  '+
    'where  Empresa_Id = '+ qEmpresas.FieldByName('Empresa_Id').AsString;
  qSerasa.Open;

  //
  qAbastecimentos.Close;
  qAbastecimentos.SQL.text :=
    'select v.Empresa_Id, v.Empresa, sum(v.quantidade) Abastecimentos,                   '+
    '       (select sum(v2.quantidade)                                                   '+
    '       from   View_Autorizacoes v2                                                  '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.Data between getdate() - 180 and getdate() - 150) as dias_150_180, '+
    '       (select sum(v2.quantidade)                                                   '+
    '       from   View_Autorizacoes v2                                                  '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.Data between getdate() - 150 and getdate() - 120) as dias_120_150, '+
    '       (select sum(v2.quantidade)                                                   '+
    '       from   View_Autorizacoes v2                                                  '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.Data between getdate() - 120 and getdate() - 90) as dias_90_120,   '+
    '       (select sum(v2.quantidade)                                                   '+
    '       from   View_Autorizacoes v2                                                  '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.Data between getdate() - 90 and getdate() - 60) as dias_60_90,     '+
    '       (select sum(v2.quantidade)                                                   '+
    '       from   View_Autorizacoes v2                                                  '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.Data between getdate() - 60 and getdate() - 30) as dias_30_60,     '+
    '       (select sum(v2.quantidade)                                                   '+
    '       from   View_Autorizacoes v2                                                  '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.Data between getdate() - 30 and getdate() - 0) as dias_Ate_30      '+
    'from   View_Autorizacoes v                                                          '+
    'where  v.Data > getdate() - 180                                                     '+
    '  and  v.Empresa_Id = '+ qEmpresas.FieldByName('Empresa_Id').AsString            +' '+
    'group  by v.Empresa_Id, v.Empresa                                                   ';
  qAbastecimentos.Open;

  TNumericField(qAbastecimentos.FieldByName('Abastecimentos')).DisplayFormat := '#,0.00';
  TNumericField(qAbastecimentos.FieldByName('dias_150_180')).DisplayFormat := '#,0.00';
  TNumericField(qAbastecimentos.FieldByName('dias_120_150')).DisplayFormat := '#,0.00';
  TNumericField(qAbastecimentos.FieldByName('dias_90_120')).DisplayFormat := '#,0.00';
  TNumericField(qAbastecimentos.FieldByName('dias_60_90')).DisplayFormat := '#,0.00';
  TNumericField(qAbastecimentos.FieldByName('dias_30_60')).DisplayFormat := '#,0.00';
  TNumericField(qAbastecimentos.FieldByName('dias_Ate_30')).DisplayFormat := '#,0.00';

  //
  qOcorrencias.Close;
  qOcorrencias.SQL.text :=
    'select uc.NomeFantasia, o.DataVencimento, o.DataPagamento, datediff(day, o.DataVencimento, isnull(o.DataPagamento, getdate())) Dias '+
    'from   FapesOcorrencias o '+
    'inner  join UnidadesCredenciadas uc on uc.id = o.UnidadeCredenciada_Id '+
    'where  Empresa_Id = '+ qEmpresas.FieldByName('Empresa_Id').AsString +' '+
    'Order  by DataVencimento ';
  qOcorrencias.Open;

  //
  qAtrasos.Close;
  qAtrasos.SQL.Text :=
    'select v.Empresa_Id, v.Empresa,                                                     '+
    '       (select Count(*)                                                   '+
    '       from   FapesOcorrencias v2                                                   '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.DataVencimento between getdate() - 180 and getdate() - 150) as dias_150_180, '+
    '       (select Count(*)                                                   '+
    '       from   FapesOcorrencias v2                                                   '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.DataVencimento between getdate() - 150 and getdate() - 120) as dias_120_150, '+
    '       (select Count(*)                                                   '+
    '       from   FapesOcorrencias v2                                                   '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.DataVencimento between getdate() - 120 and getdate() - 90) as dias_90_120,   '+
    '       (select Count(*)                                                   '+
    '       from   FapesOcorrencias v2                                                   '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.DataVencimento between getdate() - 90 and getdate() - 60) as dias_60_90,     '+
    '       (select Count(*)                                                   '+
    '       from   FapesOcorrencias v2                                                   '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.DataVencimento between getdate() - 60 and getdate() - 30) as dias_30_60,     '+
    '       (select Count(*)                                                   '+
    '       from   FapesOcorrencias v2                                                   '+
    '       where  v2.Empresa_Id = v.Empresa_Id                                          '+
    '         and  v2.DataVencimento between getdate() - 30 and getdate() - 0) as dias_Ate_30      '+
    'from   View_Autorizacoes v                                                          '+
    'where  v.Data > getdate() - 180                                                     '+
    '  and  v.Empresa_Id = '+ qEmpresas.FieldByName('Empresa_Id').AsString            +' '+
    'group  by v.Empresa_Id, v.Empresa                                                   ';
  qAtrasos.Open;


end;

procedure TfrmOcorrencias.btIncluirOcorrenciaClick(Sender: TObject);
begin
  //
  frmOcorrencia.ShowModal;
  qOcorrencias.Requery();
end;

procedure TfrmOcorrencias.btAbrirConsultaClick(Sender: TObject);
var
  Result: HINST;
begin
  Result := ShellExecute(Handle, 'open', PChar(qSerasa.FieldByName('LinkConsulta').AsString), nil, nil, SW_SHOWNORMAL);
  if Integer(Result) <= 32 then
  begin
    // Houve um erro ao executar o arquivo
    ShowMessage('Erro ao tentar abrir o arquivo: ' + IntToStr(Integer(Result)));
  end;
end;

end.
