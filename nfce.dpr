program nfce;

uses
  Forms,
  MainInterface in 'MainInterface.pas' {frmMainInterface},
  DM in 'DM.pas' {frmDM: TDataModule},
  PlacasNaoCadastradas in 'PlacasNaoCadastradas.pas' {frmPlacasNaoCadastradas},
  Recalcularkml in 'Recalcularkml.pas' {frmRecalcularkml},
  Menu in 'Menu.pas' {frmMenu},
  AssociarCartoes in 'AssociarCartoes.pas' {frmAssociarCartoes};

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TfrmMenu, frmMenu);
  Application.CreateForm(TfrmMainInterface, frmMainInterface);
  Application.CreateForm(TfrmDM, frmDM);
  Application.CreateForm(TfrmPlacasNaoCadastradas, frmPlacasNaoCadastradas);
  Application.CreateForm(TfrmRecalcularkml, frmRecalcularkml);
  Application.CreateForm(TfrmAssociarCartoes, frmAssociarCartoes);
  Application.Run;
end.
