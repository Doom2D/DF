unit f_mapcheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, g_basic;

type
  TMapCheckForm = class(TForm)
    Panel1: TPanel;
    lbErrorList: TListBox;
    bClose: TButton;
    bCheckMap: TButton;
    mErrorDescription: TMemo;
    procedure bCloseClick(Sender: TObject);
    procedure bCheckMapClick(Sender: TObject);
    procedure lbErrorListClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  MapCheckForm: TMapCheckForm;
  ErrorsNum:    Array of Byte;

implementation

uses f_main, g_map, MAPDEF;

{$R *.dfm}

procedure TMapCheckForm.bCloseClick(Sender: TObject);
begin
 Close;
end;

procedure TMapCheckForm.bCheckMapClick(Sender: TObject);
var
  a: Integer;
  b, bb, bbb: Integer;
  c: Boolean;
begin
 lbErrorList.Clear;
 mErrorDescription.Clear;
 ErrorsNum := nil;

 if gAreas <> nil then
 for a := 0 to High(gAreas) do
 begin
  if gAreas[a].AreaType in [AREA_PLAYERPOINT1, AREA_PLAYERPOINT2,
                            AREA_DMPOINT, AREA_REDTEAMPOINT, AREA_BLUETEAMPOINT] then
  with gAreas[a] do
  begin
   c := False;
   if gPanels <> nil then
    for b := 0 to High(gPanels) do
     if gPanels[b].PanelType = PANEL_CLOSEDOOR then
      if ObjectCollide(OBJECT_AREA, a, gPanels[b].X, gPanels[b].Y, gPanels[b].Width, gPanels[b].Height) then
      begin
       c := True;
       Break;
      end;

   if c or ObjectCollideLevel(a, OBJECT_AREA, 0, 0) then
   begin
    lbErrorList.Items.Add(Format('������� #%d ������������ � ������ (%d:%d)', [a, X, Y]));
    SetLength(ErrorsNum, Length(ErrorsNum)+1);
    ErrorsNum[High(ErrorsNum)] := 1;
   end;
  end;
 end;

 if gMonsters <> nil then
 for a := 0 to High(gMonsters) do
 if gMonsters[a].MonsterType <> MONSTER_NONE then
 begin
  with gMonsters[a] do
  begin
   c := False;
   if gPanels <> nil then
    for b := 0 to High(gPanels) do
     if gPanels[b].PanelType = PANEL_CLOSEDOOR then
      if ObjectCollide(OBJECT_MONSTER, a, gPanels[b].X, gPanels[b].Y, gPanels[b].Width, gPanels[b].Height) then
      begin
       c := True;
       Break;
      end;

   if c or ObjectCollideLevel(a, OBJECT_MONSTER, 0, 0) then
   begin
    lbErrorList.Items.Add(Format('������ #%d ������������ � ������ (%d:%d)', [a, X, Y]));
    SetLength(ErrorsNum, Length(ErrorsNum)+1);
    ErrorsNum[High(ErrorsNum)] := 5;
   end;
  end;
 end;

 b := 0;
 bb := 0;
 bbb := 0;

 if gAreas <> nil then
 for a := 0 to High(gAreas) do
  case gAreas[a].AreaType of
   AREA_PLAYERPOINT1: Inc(b);
   AREA_PLAYERPOINT2: Inc(bb);
   AREA_DMPOINT, AREA_REDTEAMPOINT, AREA_BLUETEAMPOINT: Inc(bbb);
  end;

 if b > 1 then
 begin
  lbErrorList.Items.Add('��������� ����� ��������� ������� ������');
  SetLength(ErrorsNum, Length(ErrorsNum)+1);
  ErrorsNum[High(ErrorsNum)] := 2;
 end;

 if bb > 1 then
 begin
  lbErrorList.Items.Add('��������� ����� ��������� ������� ������');
  SetLength(ErrorsNum, Length(ErrorsNum)+1);
  ErrorsNum[High(ErrorsNum)] := 3;
 end;

 if bbb = 0 then
 begin
  lbErrorList.Items.Add('�� ����� ��� ����� DM');
  SetLength(ErrorsNum, Length(ErrorsNum)+1);
  ErrorsNum[High(ErrorsNum)] := 4;
 end;
end;

procedure TMapCheckForm.lbErrorListClick(Sender: TObject);
begin
 if lbErrorList.ItemIndex <> -1 then
 case ErrorsNum[lbErrorList.ItemIndex] of
  1: mErrorDescription.Text := '������� ������������ � ������, ���� � ���� ����� �������� �����, �� �� ��������� � ����� � �� ������ ���������';
  2, 3: mErrorDescription.Text := '����� ��������� ����� ���������, ����� ��� ����� ����� ���������� ������ �� ������ �����';
  4: mErrorDescription.Text := '�� ����� ��� ����� DM, �������� ��������� ������ � ������ "Single Player"';
  5: mErrorDescription.Text := '������ ������������ � ������, �� ��������� � ����� � �� ������ ���������';
 end;
end;

end.
