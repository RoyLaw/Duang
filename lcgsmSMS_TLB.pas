unit lcgsmSMS_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// $Rev: 52393 $
// File generated on 2016/3/29 16:38:15 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files (x86)\Logiccode\Logiccode GSM SMS ActiveX Dll\lcgsmSMS.dll (1)
// LIBID: {74D730D8-5C4F-4D99-8D57-E35A346293BA}
// LCID: 0
// Helpfile: 
// HelpString: Logiccode GSM SMS 5.4 Type Library 
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// SYS_KIND: SYS_WIN32
// ************************************************************************ //
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
{$ALIGN 4}

interface

uses Winapi.Windows, System.Classes, System.Variants, System.Win.StdVCL, Vcl.Graphics, Vcl.OleServer, Winapi.ActiveX;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  lcgsmSMSMajorVersion = 4;
  lcgsmSMSMinorVersion = 0;

  LIBID_lcgsmSMS: TGUID = '{74D730D8-5C4F-4D99-8D57-E35A346293BA}';

  IID__GSMSMS: TGUID = '{785D9450-7394-49D6-9F70-E40B23F34924}';
  CLASS_GSMSMS: TGUID = '{40E80240-4EF1-4043-8DDA-588E513ECCAB}';
type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  _GSMSMS = interface;
  _GSMSMSDisp = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  GSMSMS = _GSMSMS;


// *********************************************************************//
// Interface: _GSMSMS
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {785D9450-7394-49D6-9F70-E40B23F34924}
// *********************************************************************//
  _GSMSMS = interface(IDispatch)
    ['{785D9450-7394-49D6-9F70-E40B23F34924}']
    function Get_BaudRate: Integer; safecall;
    procedure Set_BaudRate(Param1: Integer); safecall;
    function Get_BatteryIndicator: Smallint; safecall;
    function Get_CharEncoding: Smallint; safecall;
    procedure Set_CharEncoding(Param1: Smallint); safecall;
    function Get_DataBits: Smallint; safecall;
    procedure Set_DataBits(Param1: Smallint); safecall;
    function Get_Parity: WideString; safecall;
    procedure Set_Parity(const Param1: WideString); safecall;
    function Get_StopBits: WideString; safecall;
    procedure Set_StopBits(const Param1: WideString); safecall;
    function Get_COMPort: WideString; safecall;
    procedure Set_COMPort(const Param1: WideString); safecall;
    function Get_ValidityPeriod: WideString; safecall;
    procedure Set_ValidityPeriod(const Param1: WideString); safecall;
    function Get_Concatenate: WordBool; safecall;
    procedure Set_Concatenate(Param1: WordBool); safecall;
    function SendMessage(const MessageText: WideString; const DestinationNo: WideString; 
                         DelReport: WordBool; Alert: WordBool): WideString; safecall;
    function OpenCOMPort: WordBool; safecall;
    function CloseCOMPort: WordBool; safecall;
    function Get_SMSC: WideString; safecall;
    procedure Set_SMSC(const Param1: WideString); safecall;
    function SendCommand(const Command: WideString): WideString; safecall;
    function Get_SMSInterval: Smallint; safecall;
    procedure Set_SMSInterval(Param1: Smallint); safecall;
    function Get_Timeout: Smallint; safecall;
    procedure Set_Timeout(Param1: Smallint); safecall;
    function Get_SMSRetry: Smallint; safecall;
    procedure Set_SMSRetry(Param1: Smallint); safecall;
    function Get_SMSSupported: WordBool; safecall;
    function Get_ErrorNo: Smallint; safecall;
    function Get_ErrorDescription: WideString; safecall;
    procedure Set_PIN(const Param1: WideString); safecall;
    function Get_Version: WideString; safecall;
    function Get_IsLicensed: WordBool; safecall;
    function License(const LicenseName: WideString; const LicenseKey: WideString; 
                     const LicenseType: WideString): WordBool; safecall;
    function Get_FlowControl: Smallint; safecall;
    procedure Set_FlowControl(Param1: Smallint); safecall;
    function Get_IMEI: WideString; safecall;
    function Get_IMSI: WideString; safecall;
    function Get_Manufacturer: WideString; safecall;
    function Get_Model: WideString; safecall;
    function Get_Firmware: WideString; safecall;
    function Get_SignalStrength: Smallint; safecall;
    function Get_NetworkInfo: WideString; safecall;
    function ReadInbox(ReadType: Smallint): WordBool; safecall;
    function Get_InboxMessage(Number: Integer): WideString; safecall;
    function Get_InboxSMSC(Number: Integer): WideString; safecall;
    function Get_InboxPhone(Number: Integer): WideString; safecall;
    function Get_InboxTime(Number: Integer): WideString; safecall;
    function Get_InboxPart(Number: Integer): WideString; safecall;
    function Get_InboxConcatenate: WordBool; safecall;
    procedure Set_InboxConcatenate(Param1: WordBool); safecall;
    function Get_InboxCount: Integer; safecall;
    procedure Set_InboxMemory(const Param1: WideString); safecall;
    function Get_InboxMemory: WideString; safecall;
    function InboxDelete(Number: Integer): WordBool; safecall;
    function InboxClear: WordBool; safecall;
    procedure Set_WapPushCreatedOn(Param1: WordBool); safecall;
    function Get_WapPushCreatedOn: WordBool; safecall;
    function Get_WapPushExpiryTime: WideString; safecall;
    procedure Set_WapPushExpiryTime(const Param1: WideString); safecall;
    function Get_WapPushAction: Smallint; safecall;
    procedure Set_WapPushAction(Param1: Smallint); safecall;
    function WapPushEncode(const Destination: WideString; const Message: WideString; 
                           const URL: WideString; DelReport: WordBool): WordBool; safecall;
    function WapPushCheckLength: WordBool; safecall;
    function WapPushSend: WideString; safecall;
    procedure SplitPDU(var strRec: WideString; var blnInboxConcatenate: WordBool); safecall;
    function USSD(const strCommand: WideString; InputEncoding: Smallint; OutputEncoding: Smallint): WideString; safecall;
    function Get_LogPath: WideString; safecall;
    procedure Set_LogPath(const Param1: WideString); safecall;
    function Get_Log: WordBool; safecall;
    procedure Set_Log(Param1: WordBool); safecall;
    function GetAvailableCOMPorts: WideString; safecall;
    function DetectModem(const COMPort: WideString; Timeout: Integer): WideString; safecall;
    function DialCall(const PhoneNo: WideString): WordBool; safecall;
    function EndCall: WordBool; safecall;
    function Get_PhoneBookMemory: WideString; safecall;
    procedure Set_PhoneBookMemory(const Param1: WideString); safecall;
    function ReadPhoneBook: WordBool; safecall;
    function Get_PhoneBookName(Number: Integer): WideString; safecall;
    function Get_PhoneBookPhone(Number: Integer): WideString; safecall;
    function Get_PhoneBookCount: Integer; safecall;
    property BaudRate: Integer read Get_BaudRate write Set_BaudRate;
    property BatteryIndicator: Smallint read Get_BatteryIndicator;
    property CharEncoding: Smallint read Get_CharEncoding write Set_CharEncoding;
    property DataBits: Smallint read Get_DataBits write Set_DataBits;
    property Parity: WideString read Get_Parity write Set_Parity;
    property StopBits: WideString read Get_StopBits write Set_StopBits;
    property COMPort: WideString read Get_COMPort write Set_COMPort;
    property ValidityPeriod: WideString read Get_ValidityPeriod write Set_ValidityPeriod;
    property Concatenate: WordBool read Get_Concatenate write Set_Concatenate;
    property SMSC: WideString read Get_SMSC write Set_SMSC;
    property SMSInterval: Smallint read Get_SMSInterval write Set_SMSInterval;
    property Timeout: Smallint read Get_Timeout write Set_Timeout;
    property SMSRetry: Smallint read Get_SMSRetry write Set_SMSRetry;
    property SMSSupported: WordBool read Get_SMSSupported;
    property ErrorNo: Smallint read Get_ErrorNo;
    property ErrorDescription: WideString read Get_ErrorDescription;
    property PIN: WideString write Set_PIN;
    property Version: WideString read Get_Version;
    property IsLicensed: WordBool read Get_IsLicensed;
    property FlowControl: Smallint read Get_FlowControl write Set_FlowControl;
    property IMEI: WideString read Get_IMEI;
    property IMSI: WideString read Get_IMSI;
    property Manufacturer: WideString read Get_Manufacturer;
    property Model: WideString read Get_Model;
    property Firmware: WideString read Get_Firmware;
    property SignalStrength: Smallint read Get_SignalStrength;
    property NetworkInfo: WideString read Get_NetworkInfo;
    property InboxMessage[Number: Integer]: WideString read Get_InboxMessage;
    property InboxSMSC[Number: Integer]: WideString read Get_InboxSMSC;
    property InboxPhone[Number: Integer]: WideString read Get_InboxPhone;
    property InboxTime[Number: Integer]: WideString read Get_InboxTime;
    property InboxPart[Number: Integer]: WideString read Get_InboxPart;
    property InboxConcatenate: WordBool read Get_InboxConcatenate write Set_InboxConcatenate;
    property InboxCount: Integer read Get_InboxCount;
    property InboxMemory: WideString read Get_InboxMemory write Set_InboxMemory;
    property WapPushCreatedOn: WordBool read Get_WapPushCreatedOn write Set_WapPushCreatedOn;
    property WapPushExpiryTime: WideString read Get_WapPushExpiryTime write Set_WapPushExpiryTime;
    property WapPushAction: Smallint read Get_WapPushAction write Set_WapPushAction;
    property LogPath: WideString read Get_LogPath write Set_LogPath;
    property Log: WordBool read Get_Log write Set_Log;
    property PhoneBookMemory: WideString read Get_PhoneBookMemory write Set_PhoneBookMemory;
    property PhoneBookName[Number: Integer]: WideString read Get_PhoneBookName;
    property PhoneBookPhone[Number: Integer]: WideString read Get_PhoneBookPhone;
    property PhoneBookCount: Integer read Get_PhoneBookCount;
  end;

// *********************************************************************//
// DispIntf:  _GSMSMSDisp
// Flags:     (4560) Hidden Dual NonExtensible OleAutomation Dispatchable
// GUID:      {785D9450-7394-49D6-9F70-E40B23F34924}
// *********************************************************************//
  _GSMSMSDisp = dispinterface
    ['{785D9450-7394-49D6-9F70-E40B23F34924}']
    property BaudRate: Integer dispid 1745027424;
    property BatteryIndicator: Smallint readonly dispid 1745027423;
    property CharEncoding: Smallint dispid 1745027422;
    property DataBits: Smallint dispid 1745027421;
    property Parity: WideString dispid 1745027420;
    property StopBits: WideString dispid 1745027419;
    property COMPort: WideString dispid 1745027418;
    property ValidityPeriod: WideString dispid 1745027417;
    property Concatenate: WordBool dispid 1745027416;
    function SendMessage(const MessageText: WideString; const DestinationNo: WideString; 
                         DelReport: WordBool; Alert: WordBool): WideString; dispid 1610809698;
    function OpenCOMPort: WordBool; dispid 1610809699;
    function CloseCOMPort: WordBool; dispid 1610809700;
    property SMSC: WideString dispid 1745027415;
    function SendCommand(const Command: WideString): WideString; dispid 1610809703;
    property SMSInterval: Smallint dispid 1745027414;
    property Timeout: Smallint dispid 1745027413;
    property SMSRetry: Smallint dispid 1745027412;
    property SMSSupported: WordBool readonly dispid 1745027411;
    property ErrorNo: Smallint readonly dispid 1745027410;
    property ErrorDescription: WideString readonly dispid 1745027409;
    property PIN: WideString writeonly dispid 1745027408;
    property Version: WideString readonly dispid 1745027407;
    property IsLicensed: WordBool readonly dispid 1745027406;
    function License(const LicenseName: WideString; const LicenseKey: WideString; 
                     const LicenseType: WideString): WordBool; dispid 1610809709;
    property FlowControl: Smallint dispid 1745027405;
    property IMEI: WideString readonly dispid 1745027404;
    property IMSI: WideString readonly dispid 1745027403;
    property Manufacturer: WideString readonly dispid 1745027402;
    property Model: WideString readonly dispid 1745027401;
    property Firmware: WideString readonly dispid 1745027400;
    property SignalStrength: Smallint readonly dispid 1745027399;
    property NetworkInfo: WideString readonly dispid 1745027398;
    function ReadInbox(ReadType: Smallint): WordBool; dispid 1610809710;
    property InboxMessage[Number: Integer]: WideString readonly dispid 1745027397;
    property InboxSMSC[Number: Integer]: WideString readonly dispid 1745027396;
    property InboxPhone[Number: Integer]: WideString readonly dispid 1745027395;
    property InboxTime[Number: Integer]: WideString readonly dispid 1745027394;
    property InboxPart[Number: Integer]: WideString readonly dispid 1745027393;
    property InboxConcatenate: WordBool dispid 1745027392;
    property InboxCount: Integer readonly dispid 1745027391;
    property InboxMemory: WideString dispid 1745027390;
    function InboxDelete(Number: Integer): WordBool; dispid 1610809711;
    function InboxClear: WordBool; dispid 1610809712;
    property WapPushCreatedOn: WordBool dispid 1745027389;
    property WapPushExpiryTime: WideString dispid 1745027388;
    property WapPushAction: Smallint dispid 1745027387;
    function WapPushEncode(const Destination: WideString; const Message: WideString; 
                           const URL: WideString; DelReport: WordBool): WordBool; dispid 1610809714;
    function WapPushCheckLength: WordBool; dispid 1610809715;
    function WapPushSend: WideString; dispid 1610809716;
    procedure SplitPDU(var strRec: WideString; var blnInboxConcatenate: WordBool); dispid 1610809734;
    function USSD(const strCommand: WideString; InputEncoding: Smallint; OutputEncoding: Smallint): WideString; dispid 1610809740;
    property LogPath: WideString dispid 1745027386;
    property Log: WordBool dispid 1745027385;
    function GetAvailableCOMPorts: WideString; dispid 1610809744;
    function DetectModem(const COMPort: WideString; Timeout: Integer): WideString; dispid 1610809745;
    function DialCall(const PhoneNo: WideString): WordBool; dispid 1610809747;
    function EndCall: WordBool; dispid 1610809748;
    property PhoneBookMemory: WideString dispid 1745027384;
    function ReadPhoneBook: WordBool; dispid 1610809750;
    property PhoneBookName[Number: Integer]: WideString readonly dispid 1745027383;
    property PhoneBookPhone[Number: Integer]: WideString readonly dispid 1745027382;
    property PhoneBookCount: Integer readonly dispid 1745027381;
  end;

// *********************************************************************//
// The Class CoGSMSMS provides a Create and CreateRemote method to          
// create instances of the default interface _GSMSMS exposed by              
// the CoClass GSMSMS. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoGSMSMS = class
    class function Create: _GSMSMS;
    class function CreateRemote(const MachineName: string): _GSMSMS;
  end;

implementation

uses System.Win.ComObj;

class function CoGSMSMS.Create: _GSMSMS;
begin
  Result := CreateComObject(CLASS_GSMSMS) as _GSMSMS;
end;

class function CoGSMSMS.CreateRemote(const MachineName: string): _GSMSMS;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_GSMSMS) as _GSMSMS;
end;

end.
