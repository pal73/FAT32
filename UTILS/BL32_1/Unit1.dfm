object Form1: TForm1
  Left = 193
  Top = 118
  Width = 1113
  Height = 857
  Caption = 'BL-STM8-25P32'
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
  object Label4: TLabel
    Left = 104
    Top = 336
    Width = 31
    Height = 13
    Caption = 'Адрес'
  end
  object Label5: TLabel
    Left = 104
    Top = 480
    Width = 31
    Height = 13
    Caption = 'Адрес'
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
    Left = 18
    Top = 64
    Width = 93
    Height = 25
    Caption = 'Открыть'
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
    Caption = 'Проверка связи'
    TabOrder = 3
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 16
    Top = 128
    Width = 217
    Height = 25
    Caption = 'Чтение статус-регистра'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 16
    Top = 152
    Width = 217
    Height = 25
    Caption = 'Запрограммировать линейную адресацию'
    TabOrder = 5
    Visible = False
    OnClick = Button4Click
  end
  object Button5: TButton
    Left = 16
    Top = 184
    Width = 217
    Height = 25
    Caption = 'Прочитать буфер 1'
    TabOrder = 6
    Visible = False
    OnClick = Button5Click
  end
  object Button6: TButton
    Left = 16
    Top = 208
    Width = 217
    Height = 25
    Caption = 'Прочитать буфер 2'
    TabOrder = 7
    Visible = False
  end
  object Button7: TButton
    Left = 16
    Top = 240
    Width = 217
    Height = 25
    Caption = 'Очистить буфер 1'
    TabOrder = 8
    Visible = False
    OnClick = Button7Click
  end
  object Button8: TButton
    Left = 16
    Top = 264
    Width = 217
    Height = 25
    Caption = 'Очистить буфер 2'
    TabOrder = 9
    Visible = False
  end
  object Button11: TButton
    Left = 16
    Top = 384
    Width = 217
    Height = 25
    Caption = 'Последовательность 1 - > Адрес'
    TabOrder = 10
    OnClick = Button11Click
  end
  object Button12: TButton
    Left = 16
    Top = 408
    Width = 217
    Height = 25
    Caption = 'Последовательность 2 - > Адрес'
    TabOrder = 11
    OnClick = Button12Click
  end
  object Button13: TButton
    Left = 16
    Top = 432
    Width = 217
    Height = 25
    Caption = 'Последовательность 3 - > Адрес'
    TabOrder = 12
    OnClick = Button13Click
  end
  object Button9: TButton
    Left = 16
    Top = 528
    Width = 217
    Height = 25
    Caption = 'Прочитать 256 байт с адреса'
    TabOrder = 13
    OnClick = Button9Click
  end
  object Button10: TButton
    Left = 16
    Top = 592
    Width = 217
    Height = 25
    Caption = 'Страницу в буфер'
    TabOrder = 14
    Visible = False
    OnClick = Button10Click
  end
  object Button14: TButton
    Left = 16
    Top = 660
    Width = 217
    Height = 25
    Caption = 'Открыть файл'
    TabOrder = 15
    OnClick = Button14Click
  end
  object Button16: TButton
    Left = 16
    Top = 688
    Width = 217
    Height = 25
    Caption = 'Записать файл со страницы'
    TabOrder = 16
    OnClick = Button16Click
  end
  object Button17: TButton
    Left = 16
    Top = 768
    Width = 217
    Height = 25
    Caption = 'Воспроизвести'
    TabOrder = 17
    OnClick = Button17Click
  end
  object Button1: TButton
    Left = 128
    Top = 64
    Width = 105
    Height = 25
    Caption = 'Очистить окно'
    TabOrder = 18
    OnClick = Button1Click
  end
  object Button19: TButton
    Left = 16
    Top = 296
    Width = 217
    Height = 25
    Caption = 'Стереть микросхему'
    TabOrder = 19
    OnClick = Button19Click
  end
  object Edit1: TEdit
    Left = 56
    Top = 354
    Width = 129
    Height = 21
    TabOrder = 20
  end
  object Edit2: TEdit
    Left = 56
    Top = 498
    Width = 129
    Height = 21
    TabOrder = 21
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
