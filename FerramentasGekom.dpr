program FerramentasGekom;

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
  ConferirAutorizacoes in 'ConferirAutorizacoes.pas' {frmConferirAutorizacoes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmDM, frmDM);
  Application.CreateForm(TfrmMainInterface, frmMainInterface);
  Application.CreateForm(TfrmPlacasNaoCadastradas, frmPlacasNaoCadastradas);
  Application.CreateForm(TfrmRecalcularkml, frmRecalcularkml);
  Application.CreateForm(TfrmAssociarCartoes, frmAssociarCartoes);
  Application.CreateForm(TfrmEstatisticasSerralinda, frmEstatisticasSerralinda);
  Application.CreateForm(TfrmValoresSerralinda, frmValoresSerralinda);
  Application.CreateForm(TfrmEmpresas, frmEmpresas);
  Application.CreateForm(TfrmConferirAutorizacoes, frmConferirAutorizacoes);
  Application.Run;
end.
