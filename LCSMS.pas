unit LCSMS;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, lcgsmSMS_TLB, OleServer;

type
  TGSMSMS = class(TObject)
    objSMS: GSMSMS;

  protected
    { Protected declarations }

  private
    { Private declarations }
    procedure Split(strText: string; const Delimiter: Char;
      const strDelimitedText: TStrings);
  public
    { Public declarations }
    procedure initComm;

  end;

implementation

{ TGSMSMS }

procedure TGSMSMS.initComm;

var
  i: Integer;
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
   If objSMS.License(strLicName, strLicKey, strLicType) = false Then
   begin
   showmessage('LC SMS is not Licensed');
   end;
end;

procedure TGSMSMS.Split(strText: string; const Delimiter: Char;
  const strDelimitedText: TStrings);
begin

end;

end.
