program FerramentasGekom2;

uses
  Forms,
  MainInterface in 'MainInterface.pas' {frmMainInterface},
  DM in 'DM.pas' {frmDM: TDataModule},
  PlacasNaoCadastradas in 'PlacasNaoCadastradas.pas' {frmPlacasNaoCadastradas},
  Recalcularkml in 'Recalcularkml.pas' {frmRecalcularkml},
  Menu in 'Menu.pas' {frmMenu},
  AssociarCartoes in 'AssociarCartoes.pas' {frmAssociarCartoes},
  EstatisticasSerralinda in 'EstatisticasSerralinda.pas' {frmEstatisticasSerralinda},
  ValoresSerralinda in 'ValoresSerralinda.pas' {frmValoresSerralinda},
  Empresas in 'Empresas.pas' {frmEmpresas},
  ConferirAutorizacoes in 'ConferirAutorizacoes.pas' {frmConferirAutorizacoes},
  CorrecaoDeAutorizacoes in 'CorrecaoDeAutorizacoes.pas' {frmCorrecaoDeAutorizacoes},
  CorrigirValorAutorizacaoPelosItens in 'CorrigirValorAutorizacaoPelosItens.pas' {frmCorrigirValorAutorizacaoPelosItens},
  ChavesMaquininhas in 'ChavesMaquininhas.pas' {frmChavesMaquininhas},
  ProdutosNaoReconhecidos in 'ProdutosNaoReconhecidos.pas' {frmProdutosNaoReconhecidos},
  CoringasZZZ in 'CoringasZZZ.pas' {frmCoringasZZZ},
  VeiculosSemOperacoes in 'VeiculosSemOperacoes.pas' {frmVeiculosSemOperacoes},
  Expurgo in 'Expurgo.pas' {frmExpurgo},
  Ocorrencias in 'Ocorrencias.pas' {frmOcorrencias},
  Ocorrencia in 'Ocorrencia.pas' {frmOcorrencia};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmDM, frmDM);
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmMainInterface, frmMainInterface);
  Application.CreateForm(TfrmPlacasNaoCadastradas, frmPlacasNaoCadastradas);
  Application.CreateForm(TfrmRecalcularkml, frmRecalcularkml);
  Application.CreateForm(TfrmAssociarCartoes, frmAssociarCartoes);
  Application.CreateForm(TfrmEstatisticasSerralinda, frmEstatisticasSerralinda);
  Application.CreateForm(TfrmValoresSerralinda, frmValoresSerralinda);
  Application.CreateForm(TfrmEmpresas, frmEmpresas);
  Application.CreateForm(TfrmConferirAutorizacoes, frmConferirAutorizacoes);
  Application.CreateForm(TfrmCorrecaoDeAutorizacoes, frmCorrecaoDeAutorizacoes);
  Application.CreateForm(TfrmCorrigirValorAutorizacaoPelosItens, frmCorrigirValorAutorizacaoPelosItens);
  Application.CreateForm(TfrmChavesMaquininhas, frmChavesMaquininhas);
  Application.CreateForm(TfrmProdutosNaoReconhecidos, frmProdutosNaoReconhecidos);
  Application.CreateForm(TfrmCoringasZZZ, frmCoringasZZZ);
  Application.CreateForm(TfrmVeiculosSemOperacoes, frmVeiculosSemOperacoes);
  Application.CreateForm(TfrmExpurgo, frmExpurgo);
  Application.CreateForm(TfrmOcorrencias, frmOcorrencias);
  Application.CreateForm(TfrmOcorrencia, frmOcorrencia);
  Application.Run;
end.
