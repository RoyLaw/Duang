unit WAL;

{ THIS IS WORK ATTANDANCE HELPER FUNC LIBARY }
interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, System.JSON,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Soap.InvokeRegistry, Soap.Rio,
  Soap.SOAPHTTPClient, IdBaseComponent, IdComponent, IdIOHandler,
  IdCookieManager,frmMainUnit,
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

    JSONObject: TJSONObject; // 解析考勤返回的JSON数据

  protected
    { Protected declarations }
    procedure Execute; override;

  private
    { Private declarations }

  public
    { Public declarations }
    function logIn(thisUser: TUser): string; // 登陆
    function checkInAndOut(thisUser: TUser; actionOfCheck: integer): BOOL;
    // 考勤
    procedure warmUp();
    procedure cleanUp();

  end;

implementation

{ TWebAccess }

function TWebAccess.checkInAndOut(thisUser: TUser;
  actionOfCheck: integer): BOOL;
var
  tmpHTTPResp: string; // temporary string for HTTP Response in XML format.
  strTempResult: string;
begin
  // normalize actionOfCheck variable
  if (actionOfCheck <> 1) and (actionOfCheck <> 2) then
    actionOfCheck := 1;

  // reform params for check-in and check-out actions.
  postParams.Clear;
  postParams.Add('userName=' + thisUser.username);
  postParams.Add('singFlag=' + actionOfCheck.ToString);

  aIdHTTP.Request.Referer :=
    'http://10.1.30.89/jttoa/checkwork/checkWorkDocumentary/checkWorkDocumentaryList.jsp';

  tmpHTTPResp := '';
  try
    begin
      tmpHTTPResp := aIdHTTP.Post
        ('http://10.1.30.89/jttoa/checkWorkController/doSign', postParams);
      JSONObject := TJSONObject.ParseJSONValue(Trim(tmpHTTPResp))
        as TJSONObject;
      strTempResult := JSONObject.Values['success'].ToString;
      if LowerCase(strTempResult) = 'true' then
        Result := true
      else
        Result := false;
    end;
  except
    on E: Exception do
    begin
      frmMain.LogMessage('CHK-IN-OUT Action Error:' + E.Message);
      Result := false;
    end;
  end;
end;

procedure TWebAccess.cleanUp;
begin
  // destruction for varibles.
  aIdHTTP.Free;
  aIdSSLIOHandlerSocketOpenSSL.Free;
  aCookie.Free;
  aIdCompressorZLib.Free;
  postParams.Free;
  JSONObject.Free;
end;

procedure TWebAccess.Execute;
begin
  inherited;
  try
    // some action
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
    end;
  end;
end;

function TWebAccess.logIn(thisUser: TUser): string;
begin
  // init
  // COINITIALIZE(nil);

  aIdHTTP.AllowCookies := true;
  aIdHTTP.CookieManager := aCookie;
  aIdHTTP.HandleRedirects := true;

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

procedure TWebAccess.warmUp;
begin
  // initialization for variables.
  postParams := TStringList.Create;

  aIdHTTP := TIdHTTP.Create();
  aIdSSLIOHandlerSocketOpenSSL := TIdSSLIOHandlerSocketOpenSSL.Create();
  aCookie := TIdCookieManager.Create();
  aIdCompressorZLib := TIdCompressorZLib.Create();

  JSONObject := TJSONObject.Create;
  JSONObject := nil;

end;

end.
