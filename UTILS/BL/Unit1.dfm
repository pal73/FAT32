object Form1: TForm1
  Left = 229
  Top = 125
  Width = 1119
  Height = 880
  Caption = 'BL-STM8'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 48
    Top = 520
    Width = 32
    Height = 13
    Caption = '�����'
  end
  object Label2: TLabel
    Left = 152
    Top = 520
    Width = 48
    Height = 13
    Caption = '��������'
  end
  object Label3: TLabel
    Left = 56
    Top = 368
    Width = 32
    Height = 13
    Caption = '�����'
  end
  object Label4: TLabel
    Left = 592
    Top = 768
    Width = 32
    Height = 13
    Caption = 'Label4'
  end
  object Label5: TLabel
    Left = 856
    Top = 776
    Width = 32
    Height = 13
    Caption = 'Label5'
  end
  object Label6: TLabel
    Left = 912
    Top = 776
    Width = 32
    Height = 13
    Caption = 'Label6'
  end
  object Label7: TLabel
    Left = 592
    Top = 784
    Width = 32
    Height = 13
    Caption = 'Label7'
  end
  object Memo1: TMemo
    Left = 248
    Top = 24
    Width = 841
    Height = 729
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    Lines.Strings = (
      'Memo1')
    ParentFont = False
    ScrollBars = ssVertical
    TabOrder = 0
  end
  object B1: TButton
    Left = 26
    Top = 64
    Width = 93
    Height = 25
    Caption = '�������'
    TabOrder = 1
    OnClick = B1Click
  end
  object ComboBox1: TComboBox
    Left = 18
    Top = 26
    Width = 93
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 2
    Items.Strings = (
      'COM1'
      'COM2'
      'COM3'
      'COM4'
      'COM5'
      'COM6'
      'COM7'
      'COM8'
      'COM9'
      'COM10')
  end
  object Button2: TButton
    Left = 16
    Top = 104
    Width = 217
    Height = 25
    Caption = '�������� �����'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 16
    Top = 128
    Width = 217
    Height = 25
    Caption = '������ ������-��������'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 152
    Width = 217
    Height = 25
    Caption = '����������������� �������� ���������'
    TabOrder = 5
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 16
    Top = 184
    Width = 217
    Height = 25
    Caption = '��������� ����� 1'
    TabOrder = 6
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 16
    Top = 208
    Width = 217
    Height = 25
    Caption = '��������� ����� 2'
    TabOrder = 7
    Visible = False
  end
  object Button7: TButton
    Left = 16
    Top = 240
    Width = 217
    Height = 25
    Caption = '�������� ����� 1'
    TabOrder = 8
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 16
    Top = 264
    Width = 217
    Height = 25
    Caption = '�������� ����� 2'
    TabOrder = 9
    Visible = False
  end
  object Button18: TButton
    Left = 16
    Top = 336
    Width = 217
    Height = 25
    Caption = '��������'
    TabOrder = 10
    Visible = False
    OnClick = Button18Click
  end
  object ComboBox4: TComboBox
    Left = 34
    Top = 386
    Width = 95
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 11
    Items.Strings = (
      '1'
      '2')
  end
  object Button11: TButton
    Left = 16
    Top = 416
    Width = 217
    Height = 25
    Caption = '������������������ 1'
    TabOrder = 12
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 16
    Top = 440
    Width = 217
    Height = 25
    Caption = '������������������ 2'
    TabOrder = 13
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 16
    Top = 464
    Width = 217
    Height = 25
    Caption = '������������������ 3'
    TabOrder = 14
    OnClick = Button13Click
  end
  object ComboBox2: TComboBox
    Left = 26
    Top = 538
    Width = 95
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 15
    Items.Strings = (
      '1'
      '2')
  end
  object ComboBox3: TComboBox
    Left = 130
    Top = 538
    Width = 93
    Height = 21
    Style = csDropDownList
    ItemHeight = 13
    TabOrder = 16
    Items.Strings = (
      '0'
      '1'
      '2'
      '3'
      '4'
      '5'
      '6'
      '7'
      '8'
      '9'
      '10')
  end
  object Button9: TButton
    Left = 16
    Top = 568
    Width = 217
    Height = 25
    Caption = '����� � ��������'
    TabOrder = 17
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 16
    Top = 592
    Width = 217
    Height = 25
    Caption = '�������� � �����'
    TabOrder = 18
    OnClick = Button10Click
  end
  object Button14: TButton
    Left = 16
    Top = 644
    Width = 108
    Height = 25
    Caption = '������� ����'
    TabOrder = 19
    OnClick = Button14Click
  end
  object Button15: TButton
    Left = 124
    Top = 644
    Width = 108
    Height = 25
    Caption = '��������� ����'
    TabOrder = 20
  end
  object Button16: TButton
    Left = 16
    Top = 688
    Width = 217
    Height = 25
    Caption = '�������� ���� �� ��������'
    TabOrder = 21
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 16
    Top = 768
    Width = 217
    Height = 25
    Caption = '�������������'
    TabOrder = 22
  end
  object Button1: TButton
    Left = 128
    Top = 64
    Width = 105
    Height = 25
    Caption = '�������� ����'
    TabOrder = 23
    OnClick = Button1Click
  end
  object Button19: TButton
    Left = 248
    Top = 768
    Width = 217
    Height = 25
    Caption = '������� ����������'
    TabOrder = 24
    OnClick = Button19Click
  end
  object Button20: TButton
    Left = 496
    Top = 768
    Width = 75
    Height = 17
    Caption = '����'
    TabOrder = 25
    OnClick = Button20Click
  end
  object Button21: TButton
    Left = 648
    Top = 768
    Width = 75
    Height = 25
    Caption = '�����'
    TabOrder = 26
    OnClick = Button21Click
  end
  object Button22: TButton
    Left = 736
    Top = 768
    Width = 75
    Height = 25
    Caption = '����������'
    TabOrder = 27
    OnClick = Button22Click
  end
  object Button23: TButton
    Left = 496
    Top = 784
    Width = 75
    Height = 17
    Caption = '������'
    TabOrder = 28
    OnClick = Button23Click
  end
  object CheckBox1: TCheckBox
    Left = 128
    Top = 32
    Width = 97
    Height = 17
    Caption = '�������'
    TabOrder = 29
    OnClick = CheckBox1Click
  end
  object ComPort1: TComPort
    BaudRate = br9600
    Port = 'COM1'
    Parity.Bits = prNone
    StopBits = sbOneStopBit
    DataBits = dbEight
    Events = [evRxChar, evTxEmpty, evRxFlag, evRing, evBreak, evCTS, evDSR, evError, evRLSD, evRx80Full]
    FlowControl.OutCTSFlow = False
    FlowControl.OutDSRFlow = False
    FlowControl.ControlDTR = dtrDisable
    FlowControl.ControlRTS = rtsDisable
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    OnRxChar = ComPort1RxChar
    Left = 32
    Top = 784
  end
  object Timer1: TTimer
    Left = 72
    Top = 784
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '640'
    Options = [ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Left = 116
    Top = 788
  end
  object SaveDialog1: TSaveDialog
    Options = [ofHideReadOnly, ofCreatePrompt, ofEnableSizing]
    Left = 160
    Top = 784
  end
end
