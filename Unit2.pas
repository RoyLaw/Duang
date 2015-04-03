unit Unit2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, WAL;

type
  TForm2 = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }

  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

var
  curUser: TUser;
  curAccess: TWebAccess;

  { TForm2 }

procedure TForm2.FormCreate(Sender: TObject);
begin
  curUser.username := 'luoyi';
  curUser.password := '111111';
  curAccess := TWebAccess.Create;
  curAccess.warmUp;
  // Memo1.Lines.Text := curAccess.logIn(curUser);
  curAccess.checkInAndOut(curUser, 1);
  curAccess.cleanUp;
  curAccess.Free;
  Application.Terminate;
end;

end.
