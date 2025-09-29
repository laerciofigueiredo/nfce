unit ValoresSerralinda;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DB, ADODB, Grids, DBGrids, ExtCtrls, ComCtrls;

type
  TfrmValoresSerralinda = class(TForm)
    Panel1: TPanel;
    edtAno: TMaskEdit;
    Label1: TLabel;
    edtMes: TMaskEdit;
    Label2: TLabel;
    rbPrimeiraQuinzena: TRadioButton;
    rbSegundaQuinzena: TRadioButton;
    btPesquisar: TButton;
    DBGrid1: TDBGrid;
    qCalculos: TADOQuery;
    dsCalculos: TDataSource;
    UpDown1: TUpDown;
    Panel2: TPanel;
    Panel3: TPanel;
    DBGrid2: TDBGrid;
    qValoresEmpresas: TADOQuery;
    dsValoresEmpresas: TDataSource;
    Label3: TLabel;
    edtFiltroEmpresa: TEdit;
    Memo1: TMemo;
    btSalvarEmArquivoi: TButton;
    procedure FormActivate(Sender: TObject);
    procedure btPesquisarClick(Sender: TObject);
    procedure edtFiltroEmpresaChange(Sender: TObject);
    procedure FecharConsultas(Sender: TObject);
    procedure btSalvarEmArquivoiClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmValoresSerralinda: TfrmValoresSerralinda;

implementation

uses DM;

{$R *.dfm}

procedure TfrmValoresSerralinda.FormActivate(Sender: TObject);
begin
  edtAno.Text := FormatDateTime('yyyy', now());
  edtMes.Text := FormatDateTime('MM', now());

  //verifica se tem empresa com cartões mas ainda nao está na tabela de
  //controle da rede Serralinda
  frmDM.qAux.SQL.text := ' '+
    'select distinct e.id, e.NomeFantasia '+
    'from   Empresas e                    '+
    'inner  join Contratos c on c.Empresa_Id = e.id '+
    'inner  join UnidadesCredenciadas uc on uc.id = c.UnidadeCredenciada_Id '+
    'inner  join UnidadesDeControles udc on udc.Empresa_Id = e.id '+
    'inner  join Veiculos v on v.id = udc.id  '+
    'where  uc.Rede_Id = 7                    '+ // Rede Serralinda
    '  and  v.numerodocartao is not null      '+
    '  and  v.NumeroDoCartao <> ''''          '+
    '  and  e.id not in (select id from TempControleSerralinda) '+
    'order  by e.Id ';
  frmDM.qAux.Open;

  if frmDM.qAux.RecordCount = 0 then
    Memo1.Visible := false
  else
  begin
    Memo1.Lines.Text := 'EMPRESAS COM CARTÕES QUE PRECISAM SER INCLUÍDAS NA TABELA TEMP DO SERRALINDA:';

    while not frmDM.qAux.Eof do
    begin
      Memo1.Lines.Add(frmDM.qAux.FieldByName('Id').AsString+' - '+frmDM.qAux.FieldByName('NomeFantasia').AsString);
      frmDM.qAux.Next;
    end;

    Memo1.Visible := True;
  end;

  frmDM.qAux.Close;
end;

procedure TfrmValoresSerralinda.btPesquisarClick(Sender: TObject);
var
  dataIni, dataFim :String;
begin
  if rbPrimeiraQuinzena.Checked then
  begin
    dataIni := edtAno.Text+'-'+edtMes.Text+'-01';
    dataFim := edtAno.Text+'-'+edtMes.Text+'-16';
  end
  else
  begin
    dataIni := edtAno.Text+'-'+edtMes.Text+'-16';
    dataFim := FormatDateTime('yyyy-MM-dd', IncMonth(StrToDate( '01/'+edtMes.Text+'/'+edtAno.Text), 1));
  end;

  //TOTAL POR POSTO
  qCalculos.Close;
  qCalculos.SQL.text :=
    'select uc.Id, uc.cnpj, uc.NomeFantasia, sum(ia.Valor)*0.005 as faturar_gekom, '+
    '   (select sum(i.ValorTotal * 0.005)                                    '+
	  '    from   nfce n                                                       '+
		'    inner  join ItensNfce i on i.Nfce_Id = n.id                         '+
		'    where  n.DataEmissao between '''+dataIni+''' and '''+dataFim+'''    '+
		'      and  n.Status = ''Emitido''                                       '+
		'      and  n.cnpjEmitente = uc.cnpj) as faturar_nfce                    '+
		'from   UnidadesCredenciadas uc                                          '+
		'inner  join AutorizacoesUnidadesCredenciadas auc on auc.UnidadeCredenciada_Id = uc.id '+
		'inner  join Autorizacoes a on a.id = auc.id                             '+
		'inner  join ItensAutorizacoes ia on ia.Autorizacao_Id = a.id            '+
		'where  uc.id in (18, 21, 37, 50)                                        '+
		'  and  a.Data between '''+dataIni+''' and '''+dataFim+'''               '+
		'group  by uc.Id, uc.cnpj, uc.NomeFantasia                               ';
  qCalculos.Open;

  TNumericField(qCalculos.FieldByName('faturar_gekom')).DisplayFormat := '#,0.00';
  TNumericField(qCalculos.FieldByName('faturar_nfce')).DisplayFormat := '#,0.00';

  //TOTAL POR EMPRESAS
  qValoresEmpresas.Close;
  qValoresEmpresas.SQL.text :=
    'select e.CpfOuCnpj, e.NomeFantasia, sum(ia.Valor)*0.005 as faturar_gekom, '+
    '   (select sum(i.ValorTotal * 0.005)                                      '+
    '    from   nfce n                                                         '+
    '    inner  join ItensNfce i on i.Nfce_Id = n.id                           '+
    '    where  n.DataEmissao between '''+dataIni+''' and '''+dataFim+'''      '+
    '      and  n.Status = ''Emitido''                                         '+
    '      and  n.CnpjDestinatario = e.CpfOuCnpj) as faturar_nfce              '+
    'from   UnidadesCredenciadas uc                                            '+
    'inner  join AutorizacoesUnidadesCredenciadas auc on auc.UnidadeCredenciada_Id = uc.id '+
    'inner  join Autorizacoes a on a.id = auc.id                               '+
    'inner  join ItensAutorizacoes ia on ia.Autorizacao_Id = a.id              '+
    'inner  join UnidadesDeControles udc on udc.id = a.UnidadeDeControle_Id    '+
    'inner  join Empresas e on e.id = udc.Empresa_Id                           '+
    'where  uc.id in (18, 21, 37, 50)                                          '+
    '  and  a.Data between '''+dataIni+''' and '''+dataFim+'''                 '+
    'group  by e.CpfOuCnpj, e.NomeFantasia                                     '+
    'order  by e.NomeFantasia                                                  ';
  qValoresEmpresas.Open;

  TNumericField(qValoresEmpresas.FieldByName('faturar_gekom')).DisplayFormat := '#,0.00';
  TNumericField(qValoresEmpresas.FieldByName('faturar_nfce')).DisplayFormat := '#,0.00';
end;

procedure TfrmValoresSerralinda.edtFiltroEmpresaChange(Sender: TObject);
begin
  if trim(edtFiltroEmpresa.Text) = '' then
    qValoresEmpresas.Filtered := false
  else
  begin
    qValoresEmpresas.Filter := 'NomeFantasia like ''%'+edtFiltroEmpresa.Text+'%'' ';
    qValoresEmpresas.Filtered := true;
  end;
end;

procedure TfrmValoresSerralinda.FecharConsultas(Sender: TObject);
begin
  qCalculos.Close;
  qValoresEmpresas.Close;
end;

procedure TfrmValoresSerralinda.btSalvarEmArquivoiClick(Sender: TObject);
var
  Stream: TFileStream;
  i: Integer;
  OutLine: string;
  sTemp: string;
begin
  Stream := TFileStream.Create(ExtractFilePath(Application.ExeName)+'YourFile.csv', fmCreate);
  try
    qValoresEmpresas.First;

    while not qValoresEmpresas.Eof do
    begin
      // You'll need to add your special handling here where OutLine is built
      OutLine := '';
      for i := 0 to qValoresEmpresas.FieldCount - 1 do
      begin
        sTemp := qValoresEmpresas.Fields[i].AsString;
        // Special handling to sTemp here
        OutLine := OutLine + sTemp + ';';
      end;
      // Remove final unnecessary ','
      SetLength(OutLine, Length(OutLine) - 1);
      // Write line to file
      Stream.Write(OutLine[1], Length(OutLine) * SizeOf(Char));
      // Write line ending
      Stream.Write(sLineBreak, Length(sLineBreak));
      qValoresEmpresas.Next;
    end;

    qValoresEmpresas.First;
    
  finally
    Stream.Free;  // Saves the file
  end;
end;

end.
