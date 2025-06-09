object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Contact Manager'
  ClientHeight = 400
  ClientWidth = 563
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object lblFirstName: TLabel
    Left = 48
    Top = 16
    Width = 66
    Height = 15
    Caption = 'First Name:  '
  end
  object lblLastName: TLabel
    Left = 49
    Top = 47
    Width = 65
    Height = 15
    Caption = 'Last Name:  '
  end
  object lblPhoneNumber: TLabel
    Left = 24
    Top = 79
    Width = 90
    Height = 15
    Caption = 'Phone Number:  '
  end
  object lblEmail: TLabel
    Left = 76
    Top = 111
    Width = 38
    Height = 15
    Caption = 'Email:  '
  end
  object edtFirstName: TEdit
    Left = 120
    Top = 15
    Width = 273
    Height = 23
    TabOrder = 0
  end
  object edtLastName: TEdit
    Left = 120
    Top = 44
    Width = 273
    Height = 23
    TabOrder = 1
  end
  object edtPhone: TEdit
    Left = 120
    Top = 79
    Width = 273
    Height = 23
    TabOrder = 2
  end
  object edtEmail: TEdit
    Left = 120
    Top = 108
    Width = 273
    Height = 23
    TabOrder = 3
  end
  object btnAdd: TButton
    Left = 436
    Top = 11
    Width = 100
    Height = 25
    Caption = 'Add'
    TabOrder = 4
    OnClick = btnAddClick
  end
  object btnDelete: TButton
    Left = 436
    Top = 43
    Width = 100
    Height = 25
    Caption = 'Delete'
    TabOrder = 5
    OnClick = btnDeleteClick
  end
  object btnSave: TButton
    Left = 436
    Top = 75
    Width = 100
    Height = 25
    Caption = 'Save to File'
    TabOrder = 6
    OnClick = btnSaveClick
  end
  object btnLoad: TButton
    Left = 436
    Top = 107
    Width = 100
    Height = 25
    Caption = 'Load from File'
    TabOrder = 7
    OnClick = btnLoadClick
  end
  object StringGrid: TStringGrid
    Left = 16
    Top = 150
    Width = 529
    Height = 200
    ColCount = 4
    DefaultColWidth = 130
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goEditing, goRowSelect]
    TabOrder = 8
  end
  object OpenDialog: TOpenDialog
    Filter = 'CSV Files|*.csv|All Files|*.*'
  end
  object SaveDialog: TSaveDialog
    Filter = 'CSV Files|*.csv|All Files|*.*'
  end
end
