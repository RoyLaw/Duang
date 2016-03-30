program Duang;

uses
  Vcl.Forms,
  frmMainUnit in 'frmMainUnit.pas' {frmMain},
  WAL in 'WAL.pas',
  lcgsmSMS_TLB in 'C:\Users\Roy\Documents\Embarcadero\Studio\17.0\Imports\lcgsmSMS_TLB.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.Title := 'Duang';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;

end.
