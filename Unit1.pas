unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    Memo2: TMemo;
    procedure Button1Click(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses WAL;

var
  curUser: TUser;
  curAccess: TWebaccess;

procedure TForm1.Button1Click(Sender: TObject);
begin
  curUser.userame := 'lzy';
  curUser.password := '111111';
  curAccess := TWebaccess.Create;
  Memo1.Lines.Text :=curAccess.logIn(curUser);
  Memo2.Lines.Text :=curAccess.checkInAndOut(curUser);
end;

end.