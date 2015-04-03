unit frmMainUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, lcgsmSMS_TLB, ShellAPI,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, System.StrUtils,
  Vcl.ExtCtrls;

const
  WM_TRAYMSG = WM_USER + 101;

type
  TfrmMain = class(TForm)
    cboPort: TComboBox;
    cboBaudRate: TComboBox;
    cboDataBits: TComboBox;
    cboParity: TComboBox;
    cboStopBits: TComboBox;
    cboFlowControl: TComboBox;
    GroupBox1: TGroupBox;
    lblPort: TLabel;
    lblBaudRate: TLabel;
    lblDataBits: TLabel;
    lblParity: TLabel;
    lblStopBits: TLabel;
    lblFlowControl: TLabel;
    btnOpenCOMPort: TButton;
    btnCloseCOMPort: TButton;
    tmrReadInbox: TTimer;
    cboMsgMemory: TComboBox;
    chkInboxTimer: TCheckBox;
    edtInterval: TEdit;
    btnClear: TButton;
    lblInterval: TLabel;
    btnReadSMS: TButton;
    memLogMsg: TMemo;
    lblMsgMemory: TLabel;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;

    procedure InitSMSComm;
    procedure InitReadSMSService;

    procedure CheckValidMessages;
    function ProceedValidMessage(strValidMsg: string;
      strPhoneNumber: string): BOOL;
    function SplitString(const source, ch: string): TStringList;
    procedure SendHelpSMS(strPhoneNumber: string);
    procedure SendCustomSMS(strSMSContent: string; strPhoneNumber: string);
    procedure LogMessage(strMsg: string);
    function GetTimeNow(): string;

    procedure btnOpenCOMPortClick(Sender: TObject);
    procedure btnCloseCOMPortClick(Sender: TObject);

    procedure cboPortChange(Sender: TObject);
    procedure cboBaudRateChange(Sender: TObject);
    procedure cboDataBitsChange(Sender: TObject);
    procedure cboParityChange(Sender: TObject);
    procedure cboStopBitsChange(Sender: TObject);
    procedure cboFlowControlChange(Sender: TObject);
    procedure btnReadSMSClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure chkInboxTimerClick(Sender: TObject);
    procedure tmrReadInboxTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestory(Sender: TObject);

  private
    { Private declarations }
    procedure WMTrayMsg(var Msg: TMessage); message WM_TRAYMSG; // 声明托盘消息
    procedure WMSysCommand(var Msg: TMessage); message WM_SYSCOMMAND;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;
  NotifyIcon: TNotifyIconData; // 定义托盘图标结构体

implementation

{$R *.dfm}

uses WAL;

var
  objAccess: TWebAccess; // HTTP接口实例
  objSMS: GSMSMS; // 短信接口实例

  mblnTimerEnabled: Boolean; // 读短信计时器开关

procedure TfrmMain.btnClearClick(Sender: TObject);
var
  ReadType: smallint;
begin
  If mblnTimerEnabled Then
  begin
    tmrReadInbox.Enabled := False;
  end;

  ReadType := 4;
  objSMS.ReadInbox(ReadType);
  If objSMS.ErrorNo = 0 Then
  begin
    objSMS.InboxClear;
  end;
  // ShowMessage(objSMS.InboxCount.ToString());

  If objSMS.ErrorNo = 0 Then
  begin
    ShowMessage('Successfully deleted all messages from Inbox memory.');
  end
  Else
  begin
    ShowMessage(objSMS.ErrorDescription);
  end;

  If mblnTimerEnabled Then
  begin
    tmrReadInbox.Enabled := True;
  end;
end;

procedure TfrmMain.btnCloseCOMPortClick(Sender: TObject);
begin
  If objSMS.OpenCOMPort Then
  begin
    ShowMessage('Successfully closed the specified COM port.');
  end
  Else
  begin
    ShowMessage('Error: ' + objSMS.ErrorDescription);
  end;
end;

procedure TfrmMain.btnOpenCOMPortClick(Sender: TObject);
begin
  If objSMS.OpenCOMPort Then
  begin
    ShowMessage('Successfully opened the specified COM port.');
  end
  Else
  begin
    ShowMessage('Error: ' + objSMS.ErrorDescription);
  end;
end;

procedure TfrmMain.btnReadSMSClick(Sender: TObject);
var
  ReadType: smallint;
  i, j: integer;
begin

  If cboMsgMemory.ItemIndex = 0 then
  begin
    objSMS.InboxMemory := 'SM';
  end
  Else
  begin
    objSMS.InboxMemory := 'ME';
  end;

  If objSMS.ErrorNo <> 0 Then
  begin
    ShowMessage(objSMS.ErrorDescription);

    Exit;
  end;

  // ReadInbox method has ReadType as Optional Parameter
  // If ReadType = 0: then Read all unread messages from Inbox
  // If ReadType = 1: then Read all read messages from Inbox
  // If ReadType = 4: then Read all messages from Inbox

  ReadType := 4;
  objSMS.ReadInbox(ReadType);
  If objSMS.ErrorNo <> 0 Then
  begin
    ShowMessage(objSMS.ErrorDescription);

    Exit;
  end;

  If objSMS.InboxCount > 0 Then
  begin
    // 返回的短信数组序列从1开始计数，至objSMS.InboxCount结束
    ShowMessage(objSMS.InboxCount.ToString() + ' Message(s).');
    for i := 1 to objSMS.InboxCount do
    begin
      j := i;
      LogMessage(objSMS.InboxMessage[j]);
    end;

  end
  Else
  begin
    ShowMessage('No Messages found.');
  end;

end;

procedure TfrmMain.cboBaudRateChange(Sender: TObject);
begin
  objSMS.BaudRate := StrToInt(cboBaudRate.Text);
end;

procedure TfrmMain.cboDataBitsChange(Sender: TObject);
begin
  objSMS.DataBits := StrToInt(cboDataBits.Text);
end;

procedure TfrmMain.cboFlowControlChange(Sender: TObject);
begin
  objSMS.FlowControl := cboFlowControl.ItemIndex;
end;

procedure TfrmMain.cboParityChange(Sender: TObject);
begin
  objSMS.Parity := MidStr(cboParity.Text, 1, 1);
end;

procedure TfrmMain.cboPortChange(Sender: TObject);
begin
  objSMS.COMPort := cboPort.Text;
end;

procedure TfrmMain.cboStopBitsChange(Sender: TObject);
begin
  objSMS.StopBits := cboStopBits.Text;
end;

procedure TfrmMain.CheckValidMessages;
var
  i, j: integer;
begin
  for i := 1 to objSMS.InboxCount do
  begin
    j := i;
    if (objSMS.InboxPhone[j] = '+8618606198301') or
      (objSMS.InboxPhone[j] = '+8615851808999') then
      LogMessage('A valid message has been recevied.');

    if ProceedValidMessage(objSMS.InboxMessage[j], objSMS.InboxPhone[j]) then
      SendCustomSMS('Congrates! Your request ' +
        QuotedStr(objSMS.InboxMessage[j]) + ' is succeded.',
        objSMS.InboxPhone[j])
    else
      SendCustomSMS('Sorry. Your request ' + QuotedStr(objSMS.InboxMessage[j]) +
        ' is failed. Please try it again.', objSMS.InboxPhone[j]);
  end;
end;

procedure TfrmMain.chkInboxTimerClick(Sender: TObject);
begin
  If chkInboxTimer.Checked Then
  begin
    tmrReadInbox.Interval := StrToInt(edtInterval.Text) * 1000;
    tmrReadInbox.Enabled := True;
    mblnTimerEnabled := True;
  end
  Else
  begin
    tmrReadInbox.Enabled := False;
    mblnTimerEnabled := False;
  end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  objAccess := TWebAccess.Create;
  objAccess.warmUp;
  memLogMsg.Clear;
  InitSMSComm;
  InitReadSMSService;
  // objAccess.cleanUp;
  // objAccess.Free;

  with NotifyIcon do
  begin
    // cbSize := SizeOf(TNotifyIconData);
    Wnd := Self.Handle;
    uID := 1;
    uFlags := NIF_ICON + NIF_MESSAGE + NIF_TIP; // 图标、消息、提示信息
    uCallbackMessage := WM_TRAYMSG;
    hIcon := Application.Icon.Handle;
    szTip := 'Duang';
  end;
  Shell_NotifyIcon(NIM_ADD, @NotifyIcon);

end;

procedure TfrmMain.FormDestory(Sender: TObject);
begin
  Shell_NotifyIcon(NIM_DELETE, @NotifyIcon);
end;

function TfrmMain.GetTimeNow(): string;
var
  dtmTimeStamp: TDateTime;
begin
  dtmTimeStamp := now;
  Result := DateTimeToStr(dtmTimeStamp);
end;

function TfrmMain.ProceedValidMessage(strValidMsg: string;
  strPhoneNumber: string): BOOL;
var
  tslTempMsgList: TStringList;
  usrTempUser: TUser;
begin
  tslTempMsgList := TStringList.Create;
  tslTempMsgList := SplitString(trim(strValidMsg), ',');

  if tslTempMsgList.Count = 2 then
  begin
    if LowerCase(tslTempMsgList[0]) = 'in' then
    begin
      usrTempUser.username := tslTempMsgList[1];
      usrTempUser.password := '';
      Result := objAccess.checkInAndOut(usrTempUser, 1);
    end
    else if LowerCase(tslTempMsgList[0]) = 'out' then
    begin
      usrTempUser.username := tslTempMsgList[1];
      usrTempUser.password := '';
      Result := objAccess.checkInAndOut(usrTempUser, 2);
    end
    else
    begin
      Result := False;
      SendHelpSMS(strPhoneNumber);
    end;
  end
  else
  begin
    Result := False;
    SendHelpSMS(strPhoneNumber);
  end;
end;

procedure TfrmMain.InitReadSMSService;
begin
  mblnTimerEnabled := False;

  With cboMsgMemory do
  begin
    Items.Add('SIM Memory');
    Items.Add('Phone Memory');
    ItemIndex := 0;
  end;
end;

procedure TfrmMain.InitSMSComm;
var
  i: integer;
  strLicName, strLicType, strLicKey, strCOMPort, strBaudrate: WideString;
  strDataBits, strParity, strStopBits: WideString;
begin
  objSMS := CoGSMSMS.Create;
  // ------------------------------------------------------------------------
  // If you have purchased LC SMS license, then pass the license information
  // to the below license method

  // objSMS.License(strLicName,strLicKey,strLicType);

  // This method is used to check whether the license is valid i.e to check
  // whether License information entered is correct
  // If objSMS.IsLicensed = false Then
  // begin
  // ShowMessage('LC SMS is not Licensed');
  // end;

  // Alternate way of checking validity of License Information is
  strLicName := 'Roy Law';
  strLicKey := '749311334';
  strLicType := 'ADVANCED-DEVELOPER';
  If objSMS.License(strLicName, strLicKey, strLicType) = False Then
  begin
    ShowMessage('LC SMS is not Licensed');
  end;

  // 初始化通信设置界面

  // ------------------------------------------------------
  // Fill COM Port Combo Box and set its default value
  cboPort.Items.Add('Select Port');
  For i := 1 To 32 do
  begin
    cboPort.Items.Add('COM' + IntToStr(i));
  end;
  strCOMPort := objSMS.COMPort;
  For i := 0 To (cboPort.Items.Count - 1) do
  begin
    If cboPort.Items.Strings[i] = strCOMPort Then
    begin
      cboPort.ItemIndex := i;
    end;
  end;
  // ------------------------------------------------------

  // ------------------------------------------------------
  // Fill BaudRate Combo Box and set its default value
  With cboBaudRate do
  begin
    Items.Add('110');
    Items.Add('300');
    Items.Add('1200');
    Items.Add('2400');
    Items.Add('4800');
    Items.Add('9600');
    Items.Add('19200');
    Items.Add('38400');
    Items.Add('57600');
    Items.Add('115200');
    Items.Add('230400');
    Items.Add('460800');
    Items.Add('921600');
  end;

  strBaudrate := IntToStr(objSMS.BaudRate);
  For i := 0 To (cboBaudRate.Items.Count - 1) do
  begin
    If cboBaudRate.Items.Strings[i] = strBaudrate Then
    begin
      cboBaudRate.ItemIndex := i;
    end;
  end;
  // ------------------------------------------------------

  // ------------------------------------------------------
  // Fill DataBits Combo Box and set its default value
  With cboDataBits do
  begin
    Items.Add('5');
    Items.Add('6');
    Items.Add('7');
    Items.Add('8');
  end;

  strDataBits := IntToStr(objSMS.DataBits);
  For i := 0 To (cboDataBits.Items.Count - 1) do
  begin
    If cboDataBits.Items.Strings[i] = strDataBits Then
    begin
      cboDataBits.ItemIndex := i;
    end;
  end;
  // ------------------------------------------------------

  // ------------------------------------------------------
  // Fill Parity Combo Box and set its default value
  With cboParity do
  begin
    Items.Add('None');
    Items.Add('Odd');
    Items.Add('Even');
    Items.Add('Mark');
    Items.Add('Space');
  end;

  strParity := objSMS.Parity;
  For i := 0 To (cboParity.Items.Count - 1) do
  begin
    If MidStr(cboParity.Items.Strings[i], 1, 1) = strParity Then
    begin
      cboParity.ItemIndex := i;
    end;
  end;

  // ------------------------------------------------------

  // ------------------------------------------------------
  // Fill StopBits Combo Box and set its default value
  With cboStopBits do
  begin
    Items.Add('1');
    Items.Add('1.5');
    Items.Add('"2');
  end;

  strStopBits := objSMS.StopBits;
  For i := 0 To (cboStopBits.Items.Count - 1) do
  begin
    If cboStopBits.Items.Strings[i] = strStopBits Then
    begin
      cboStopBits.ItemIndex := i;
    end;
  end;

  // ------------------------------------------------------

  // ------------------------------------------------------
  // Fill Flow Control Combo Box and set its default value
  With cboFlowControl do
  begin
    Items.Add('None');
    Items.Add('Hardware');
    Items.Add('Xon / Xoff');
    ItemIndex := 0;
  end;

  // ------------------------------------------------------

end;

procedure TfrmMain.LogMessage(strMsg: string);
begin
  memLogMsg.Lines.Add(GetTimeNow() + ' ' + strMsg);
end;

procedure TfrmMain.SendCustomSMS(strSMSContent, strPhoneNumber: string);
var
  blnDeliveryReport, blnAlert: WordBool;
begin
  blnDeliveryReport := False;
  blnAlert := False;
  objSMS.SendMessage(strSMSContent, strPhoneNumber, blnDeliveryReport,
    blnAlert);
end;

procedure TfrmMain.SendHelpSMS(strPhoneNumber: string);
var
  blnDeliveryReport, blnAlert: WordBool;
  helpMessage: string;
begin
  blnDeliveryReport := False;
  blnAlert := False;
  helpMessage :=
    'Wrong Request! Please notice the way of messaging format. That is ACTION,USER(ACTION can be IN or OUT which means Check-in or Check-out). For example, in,guest.';
  // 帮助信息
  objSMS.SendMessage(helpMessage, strPhoneNumber, blnDeliveryReport, blnAlert);
end;

function TfrmMain.SplitString(const source, ch: string): TStringList;
var
  temp, t2: string;
  i: integer;
begin
  Result := TStringList.Create;
  temp := source;
  i := pos(ch, source);
  while i <> 0 do
  begin
    t2 := copy(temp, 0, i - 1);
    if (t2 <> '') then
      Result.Add(t2);
    delete(temp, 1, i - 1 + Length(ch));
    i := pos(ch, temp);
  end;
  Result.Add(temp);
end;

procedure TfrmMain.tmrReadInboxTimer(Sender: TObject);
var
  ReadType: smallint;
begin
  tmrReadInbox.Enabled := False;

  ReadType := 0; // Read unread messages. 0=unread 1=read 4=all
  objSMS.ReadInbox(ReadType);

  If objSMS.ErrorNo = 0 Then
  begin
    If objSMS.InboxCount > 0 Then
    begin
      CheckValidMessages();
    end
    Else
    begin
      // 没有短信的情况
    end;
  end
  Else
  begin
    LogMessage(objSMS.ErrorDescription);
  end;

  tmrReadInbox.Enabled := True;

end;

procedure TfrmMain.WMSysCommand(var Msg: TMessage);
begin
  if Msg.WParam = SC_ICON then
    Self.Visible := False
  else
    DefWindowProc(Self.Handle, Msg.Msg, Msg.WParam, Msg.LParam);
end;

procedure TfrmMain.WMTrayMsg(var Msg: TMessage);
var
  p: TPoint;
begin
  case Msg.LParam of
    WM_LBUTTONDOWN:
      Self.Visible := True; // 显示窗体
    WM_RBUTTONDOWN:
      begin
        SetForegroundWindow(Self.Handle); // 把窗口提前
        GetCursorPos(p);
      end;
  end;
end;

end.
