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
  IdTCPClient, IdHTTP, Vcl.StdCtrls, IdCompressorZLib;

type
  TUser = record // 用户账户
    userame: string;
    password: string;
  end;

  TWebAccess = class(TThread)

    aIdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    aIdHTTP: TIdHTTP;
    aCookie: TIdCookieManager;
    aIdCompressorZLib: TIdCompressorZLib;

    aUser: TUser;
    postParams: TStrings; // POST提交请求的参数

  private
    { Private declarations }
  public
    { Public declarations }

    function logIn(thisUser: TUser): bool; // 登陆
    function checkInAndOut(thisUser: TUser): bool; // 考勤

  end;

implementation

{ TWebAccess }

function TWebAccess.checkInAndOut(thisUser: TUser): bool;
begin

end;

function TWebAccess.logIn(thisUser: TUser): bool;
begin
  // init

  postParams := TStrings.Create;

  aIdHTTP := TIdHTTP.Create();
  aIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();
  aCookie := TIdCookieManager.Create();
  aIdCompressorZLib := TIdCompressorZLib.Create();

  aIdHTTP.AllowCookies := TRUE;
  aIdHTTP.CookieManager := aCookie;
  aIdHTTP.HandleRedirects := TRUE;

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

  postParams.Add('username=' + thisUser.userame);
  postParams.Add('password=' + thisUser.password);
  // postParams.Add('lt=_c1FE7477B-DFB4-415E-9750-9EE7B6A76405_k1F8DD927-4404-5D89-F42B-AE2B869EC4DD');
  postParams.Add('_eventId=submit');
  postParams.Add('submit.x=30');
  postParams.Add('submit.y=8');

  try
    aIdHTTP.Post
      ('https://10.1.30.89:8443/cas/login?service=http%3A%2F%2F10.1.30.89%2Fmain.jsp',
      postParams);
    Result := TRUE;
  except
    on E: Exception do
    begin
      ShowMessage('ERR: Can''t Login.' + E.Message);
      Result := FALSE;
    end;
  end;

end;

end.
