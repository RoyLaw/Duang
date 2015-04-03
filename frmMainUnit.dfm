object frmMain: TfrmMain
  Left = 0
  Top = 0
  Caption = 'Duang'
  ClientHeight = 282
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestory
  PixelsPerInch = 96
  TextHeight = 13
  object lblInterval: TLabel
    Left = 334
    Top = 61
    Width = 43
    Height = 13
    Caption = 'seconds.'
  end
  object lblMsgMemory: TLabel
    Left = 175
    Top = 32
    Width = 87
    Height = 13
    Caption = 'Message Memory:'
  end
  object GroupBox3: TGroupBox
    Left = 167
    Top = 95
    Width = 226
    Height = 146
    Caption = 'LOGGING'
    TabOrder = 16
  end
  object GroupBox2: TGroupBox
    Left = 167
    Top = 8
    Width = 226
    Height = 81
    Caption = 'MSG SETTING'
    TabOrder = 15
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 153
    Height = 233
    Caption = 'COMM. SETTING'
    TabOrder = 6
    object lblPort: TLabel
      Left = 48
      Top = 24
      Width = 24
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Port:'
      ParentBiDiMode = False
    end
    object lblBaudRate: TLabel
      Left = 18
      Top = 51
      Width = 54
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Baud Rate:'
      ParentBiDiMode = False
    end
    object lblDataBits: TLabel
      Left = 25
      Top = 78
      Width = 47
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Data Bits:'
      ParentBiDiMode = False
    end
    object lblParity: TLabel
      Left = 40
      Top = 105
      Width = 32
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Parity:'
      ParentBiDiMode = False
    end
    object lblStopBits: TLabel
      Left = 26
      Top = 132
      Width = 46
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Stop Bits:'
      ParentBiDiMode = False
    end
    object lblFlowControl: TLabel
      Left = 8
      Top = 160
      Width = 64
      Height = 13
      Alignment = taRightJustify
      BiDiMode = bdLeftToRight
      Caption = 'Flow Control:'
      ParentBiDiMode = False
    end
  end
  object cboPort: TComboBox
    Left = 88
    Top = 31
    Width = 65
    Height = 21
    TabOrder = 0
    Text = 'cboPort'
    OnChange = cboPortChange
  end
  object cboBaudRate: TComboBox
    Left = 88
    Top = 58
    Width = 65
    Height = 21
    TabOrder = 1
    Text = 'cboBaudRate'
    OnChange = cboBaudRateChange
  end
  object cboDataBits: TComboBox
    Left = 88
    Top = 85
    Width = 65
    Height = 21
    TabOrder = 2
    Text = 'cboDataBits'
    OnChange = cboDataBitsChange
  end
  object cboParity: TComboBox
    Left = 88
    Top = 112
    Width = 65
    Height = 21
    TabOrder = 3
    Text = 'cboParity'
    OnChange = cboParityChange
  end
  object cboStopBits: TComboBox
    Left = 88
    Top = 139
    Width = 65
    Height = 21
    TabOrder = 4
    Text = 'cboStopBits'
    OnChange = cboStopBitsChange
  end
  object cboFlowControl: TComboBox
    Left = 88
    Top = 166
    Width = 65
    Height = 21
    TabOrder = 5
    Text = 'cboFlowControl'
    OnChange = cboFlowControlChange
  end
  object btnOpenCOMPort: TButton
    Left = 16
    Top = 203
    Width = 66
    Height = 25
    Caption = 'Open'
    TabOrder = 7
    OnClick = btnOpenCOMPortClick
  end
  object btnCloseCOMPort: TButton
    Left = 88
    Top = 203
    Width = 66
    Height = 25
    Caption = 'Close'
    TabOrder = 8
    OnClick = btnCloseCOMPortClick
  end
  object cboMsgMemory: TComboBox
    Left = 264
    Top = 29
    Width = 113
    Height = 21
    TabOrder = 9
  end
  object chkInboxTimer: TCheckBox
    Left = 175
    Top = 58
    Width = 113
    Height = 17
    Caption = 'Check Inbox every'
    TabOrder = 10
    OnClick = chkInboxTimerClick
  end
  object edtInterval: TEdit
    Left = 285
    Top = 56
    Width = 43
    Height = 21
    TabOrder = 11
    Text = '5'
  end
  object btnClear: TButton
    Left = 320
    Top = 249
    Width = 75
    Height = 25
    Caption = 'Clear Inbox'
    TabOrder = 12
    OnClick = btnClearClick
  end
  object btnReadSMS: TButton
    Left = 230
    Top = 249
    Width = 75
    Height = 25
    Caption = 'Read Inbox'
    TabOrder = 13
    OnClick = btnReadSMSClick
  end
  object memLogMsg: TMemo
    Left = 176
    Top = 113
    Width = 208
    Height = 119
    Lines.Strings = (
      'memLogMsg')
    ScrollBars = ssVertical
    TabOrder = 14
  end
  object tmrReadInbox: TTimer
    Enabled = False
    OnTimer = tmrReadInboxTimer
    Left = 360
    Top = 80
  end
end
