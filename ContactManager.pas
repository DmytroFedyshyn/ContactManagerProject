unit ContactManager;

interface

uses
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Grids,
  System.Generics.Collections, System.RegularExpressions;

type
  TContact = class
    FirstName: string;
    LastName: string;
    PhoneNumber: string;
    Email: string;
  end;

  TForm1 = class(TForm)
    edtFirstName: TEdit;
    edtLastName: TEdit;
    edtPhone: TEdit;
    edtEmail: TEdit;
    btnAdd: TButton;
    btnDelete: TButton;
    btnSave: TButton;
    btnLoad: TButton;
    StringGrid: TStringGrid;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    lblFirstName: TLabel;
    lblLastName: TLabel;
    lblPhoneNumber: TLabel;
    lblEmail: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
  private
    procedure UpdateGrid;
    function CreateContact: TContact;
    procedure ClearInputs;
    function IsValidEmail(const Email: string): Boolean;
    function IsValidPhone(const Phone: string): Boolean;
  public
    Contacts: TObjectList<TContact>;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  Contacts := TObjectList<TContact>.Create;

  // Fix form size and disable maximize
  BorderStyle := bsSingle;
  BorderIcons := BorderIcons - [biMaximize];

  StringGrid.Cells[0, 0] := 'First Name';
  StringGrid.Cells[1, 0] := 'Last Name';
  StringGrid.Cells[2, 0] := 'Phone';
  StringGrid.Cells[3, 0] := 'Email';

  Font.Name := 'Segoe UI';
  Font.Size := 10;
  Color := clWhite;

  StringGrid.FixedColor := clSkyBlue;
  StringGrid.Font.Color := clBlack;
end;

function TForm1.CreateContact: TContact;
begin
  Result := TContact.Create;
  Result.FirstName := edtFirstName.Text;
  Result.LastName := edtLastName.Text;
  Result.PhoneNumber := edtPhone.Text;
  Result.Email := edtEmail.Text;
end;

procedure TForm1.ClearInputs;
begin
  edtFirstName.Clear;
  edtLastName.Clear;
  edtPhone.Clear;
  edtEmail.Clear;
end;

function TForm1.IsValidEmail(const Email: string): Boolean;
begin
  Result := TRegEx.IsMatch(Email, '^([a-zA-Z0-9_\.\-]+)@([a-zA-Z0-9\-]+)\.([a-zA-Z]{2,})$');
end;

function TForm1.IsValidPhone(const Phone: string): Boolean;
begin
  Result := TRegEx.IsMatch(Phone, '^\+?[0-9\-\s]{7,15}$');
end;

procedure TForm1.UpdateGrid;
var
  i: Integer;
begin
  StringGrid.RowCount := Contacts.Count + 1;
  for i := 0 to Contacts.Count - 1 do
  begin
    StringGrid.Cells[0, i + 1] := Contacts[i].FirstName;
    StringGrid.Cells[1, i + 1] := Contacts[i].LastName;
    StringGrid.Cells[2, i + 1] := Contacts[i].PhoneNumber;
    StringGrid.Cells[3, i + 1] := Contacts[i].Email;
  end;
end;

procedure TForm1.btnAddClick(Sender: TObject);
var
  Msg: string;
begin
  Msg := '';
  if Trim(edtFirstName.Text) = '' then
    Msg := Msg + 'First Name is required.'#13;
  if not IsValidPhone(edtPhone.Text) then
    Msg := Msg + 'Phone number is invalid.'#13;
  if not IsValidEmail(edtEmail.Text) then
    Msg := Msg + 'Email is invalid.'#13;

  if Msg <> '' then
  begin
    ShowMessage(Msg);
    Exit;
  end;

  Contacts.Add(CreateContact);
  UpdateGrid;
  ClearInputs;
end;

procedure TForm1.btnDeleteClick(Sender: TObject);
begin
  if (StringGrid.Row > 0) and (StringGrid.Row <= Contacts.Count) then
  begin
    Contacts.Delete(StringGrid.Row - 1);
    UpdateGrid;
  end
  else
    ShowMessage('Please select a contact to delete.');
end;

procedure TForm1.btnSaveClick(Sender: TObject);
var
  F: TextFile;
  i: Integer;
begin
  if SaveDialog.Execute then
  begin
    AssignFile(F, SaveDialog.FileName);
    Rewrite(F);
    for i := 0 to Contacts.Count - 1 do
      Writeln(F, Contacts[i].FirstName + ',' +
                  Contacts[i].LastName + ',' +
                  Contacts[i].PhoneNumber + ',' +
                  Contacts[i].Email);
    CloseFile(F);
    ShowMessage('Contacts saved successfully.');
  end;
end;

procedure TForm1.btnLoadClick(Sender: TObject);
var
  F: TextFile;
  Line: string;
  Parts: TArray<string>;
  Contact: TContact;
begin
  if OpenDialog.Execute then
  begin
    Contacts.Clear;
    AssignFile(F, OpenDialog.FileName);
    Reset(F);
    while not Eof(F) do
    begin
      ReadLn(F, Line);
      Parts := Line.Split([',']);
      if Length(Parts) = 4 then
      begin
        Contact := TContact.Create;
        Contact.FirstName := Parts[0];
        Contact.LastName := Parts[1];
        Contact.PhoneNumber := Parts[2];
        Contact.Email := Parts[3];
        Contacts.Add(Contact);
      end;
    end;
    CloseFile(F);
    UpdateGrid;
    ShowMessage('Contacts loaded successfully.');
  end;
end;

end.

