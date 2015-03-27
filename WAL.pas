unit WAL;

{ THIS IS WORK ATTANDANCE HELPER FUNC LIBARY }
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient, IdBaseComponent, IdComponent, IdIOHandler,
  IdCookieManager,
  IdIOHandlerSocket, IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdTCPConnection,
  IdTCPClient, IdHTTP, Vcl.StdCtrls, IdCompressorZLib, ActiveX;

type
  TUser = record // 用户账户
    username: string;
    password: string;
  end;

  TWebAccess = class(TThread)

    aIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    aIdHTTP: TIdHTTP;
    aCookie: TIdCookieManager;
    aIdCompressorZLib: TIdCompressorZLib;

    aUser: TUser;
    postParams: TStrings; // POST提交请求的参数

  protected
    { Protected declarations }
    procedure Execute; override;

  private
    { Private declarations }

  public
    { Public declarations }

    function logIn(thisUser: TUser): string; // 登陆
    function checkInAndOut(thisUser: TUser): string; // 考勤
    procedure cleanUp();

  end;

implementation

{ TWebAccess }

function TWebAccess.checkInAndOut(thisUser: TUser): string;
begin
  // reform params for check-in and check-out actions.
  postParams.Clear;
  postParams.Add('userName=' + thisUser.username);
  postParams.Add('singFlag=1');

  aIdHTTP.Request.Referer :=
    'http://10.1.30.89/jttoa/checkwork/checkWorkDocumentary/checkWorkDocumentaryList.jsp';
  try
    Result := aIdHTTP.Post('http://10.1.30.89/jttoa/checkWorkController/doSign',
      postParams);
  except
    on E: Exception do
      Result := 'Error occured when check-in or check-out.' + #13#10 +
        E.Message;
  end;

end;

procedure TWebAccess.cleanUp;
begin
  // do some memory clean up.
  aIdHTTP.Free;
  aIdSSLIOHandlerSocketOpenSSL.Free;
  aCookie.Free;
  aIdCompressorZLib.Free;
  postParams.Free;
end;

procedure TWebAccess.Execute;
begin
  inherited;
  try
    // some action
  except
    on E: Exception do
    begin
      showmessage(E.Message);
    end;
  end;
end;

function TWebAccess.logIn(thisUser: TUser): string;
begin
  // init
  // COINITIALIZE(nil);

  postParams := TStringList.Create;

  aIdHTTP := TIdHTTP.Create();
  aIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();
  aCookie := TIdCookieManager.Create();
  aIdCompressorZLib := TIdCompressorZLib.Create();

  aIdHTTP.AllowCookies := True;
  aIdHTTP.CookieManager := aCookie;
  aIdHTTP.HandleRedirects := True;

  aIdSSLIOHandlerSocketOpenSSL.SSLOptions.Method := sslvSSLv3;
  aIdHTTP.IOHandler := aIdSSLIOHandlerSocketOpenSSL;
  aIdHTTP.Compressor := aIdCompressorZLib;

  aIdHTTP.Request.UserAgent :=
    'Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/6.0)';
  aIdHTTP.Request.Accept :=
    'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8';
  aIdHTTP.Request.AcceptLanguage := 'en-US,zh-CN;q=0.7,en;q=0.3';
  aIdHTTP.Request.AcceptEncoding := 'gzip, deflate';
  aIdHTTP.Request.Referer :=
    'https://10.1.30.89:8443/cas/login?service=http%3A%2F%2F10.1.30.89%2Fmain.jsp';

  // aIdHTTP.ProxyParams.ProxyServer := '';
  // aIdHTTP.ProxyParams.ProxyPort := '';

  postParams.Add('username=' + thisUser.username);
  postParams.Add('password=' + thisUser.password);
  // postParams.Add('lt=_c1FE7477B-DFB4-415E-9750-9EE7B6A76405_k1F8DD927-4404-5D89-F42B-AE2B869EC4DD');
  postParams.Add('_eventId=submit');
  postParams.Add('submit.x=30');
  postParams.Add('submit.y=8');

  try
    Result := aIdHTTP.Post
      ('https://10.1.30.89:8443/cas/login?service=http%3A%2F%2F10.1.30.89%2Fmain.jsp',
      postParams);

  except
    on E: Exception do
    begin
      // showmessage('ERR: Can''t Login.' + E.Message);
      Result := 'Error occured when log-in.' + #13#10 + E.Message;
    end;
  end;

  // CoUninitialize;

end;

end.
