unit f_main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, ImgList, StdCtrls, Buttons,
  ComCtrls, ValEdit, Types, ToolWin, Menus, ExtCtrls,
  CheckLst, Grids, XPMan;

type
  TMainForm = class(TForm)
  // ������� ����:
    MainMenu: TMainMenu;
  // "����":
    miMenuFile: TMenuItem;
    miNewMap: TMenuItem;
    miOpenMap: TMenuItem;
    miSaveMap: TMenuItem;
    miSaveMapAs: TMenuItem;
    miOpenWadMap: TMenuItem;
    miLine1: TMenuItem;
    miSaveMiniMap: TMenuItem;
    miDeleteMap: TMenuItem;
    miPackMap: TMenuItem;
    miLine2: TMenuItem;
    miExit: TMenuItem;
  // "������":
    miMenuEdit: TMenuItem;
    miUndo: TMenuItem;
    miLine3: TMenuItem;
    miCopy: TMenuItem;
    miCut: TMenuItem;
    miPaste: TMenuItem;
    miLine4: TMenuItem;
    miSelectAll: TMenuItem;
    miLine5: TMenuItem;
    miToFore: TMenuItem;
    miToBack: TMenuItem;
  // "�����������":
    miMenuTools: TMenuItem;
    miSnapToGrid: TMenuItem;
    miMiniMap: TMenuItem;
    miSwitchGrid: TMenuItem;
    miShowEdges: TMenuItem;
    miLayers: TMenuItem;
    miLayer1: TMenuItem;
    miLayer2: TMenuItem;
    miLayer3: TMenuItem;
    miLayer4: TMenuItem;
    miLayer5: TMenuItem;
    miLayer6: TMenuItem;
    miLayer7: TMenuItem;
    miLayer8: TMenuItem;
    miLayer9: TMenuItem;
  // "������":
    miMenuService: TMenuItem;
    miCheckMap: TMenuItem;
    miOptimmization: TMenuItem;
    miMapPreview: TMenuItem;
    miTestMap: TMenuItem;
  // "���������":
    miMenuSettings: TMenuItem;
    miMapOptions: TMenuItem;
    miLine6: TMenuItem;
    miOptions: TMenuItem;
    miLine7: TMenuItem;
    miMapTestSettings: TMenuItem;
  // "�������":
    miMenuHelp: TMenuItem;
    miAbout: TMenuItem;
  // ������� ����� ���� ��� Ctrl+Tab:
    miHidden1: TMenuItem;
    minexttab: TMenuItem;

  // ������ ������������:
    MainToolBar: TToolBar;
    tbNewMap: TToolButton;
    tbOpenMap: TToolButton;
    tbSaveMap: TToolButton;
    tbOpenWadMap: TToolButton;
    tbLine1: TToolButton;
    tbShowMap: TToolButton;
    tbLine2: TToolButton;
    tbShow: TToolButton;
    tbLine3: TToolButton;
    tbGridOn: TToolButton;
    tbGrid: TToolButton;
    tbLine4: TToolButton;
    tbTestMap: TToolButton;
  // ����������� ���� ��� ������ �����:
    pmShow: TPopupMenu;
    miLayerP1: TMenuItem;
    miLayerP2: TMenuItem;
    miLayerP3: TMenuItem;
    miLayerP4: TMenuItem;
    miLayerP5: TMenuItem;
    miLayerP6: TMenuItem;
    miLayerP7: TMenuItem;
    miLayerP8: TMenuItem;
    miLayerP9: TMenuItem;
  // ����������� ���� ��� ������ ����� �����:
    pmMapTest: TPopupMenu;
    miMapTestPMSet: TMenuItem;

  // ������ �����:
    PanelMap: TPanel;
  // ������ ����������� �����:
    RenderPanel: TPanel;
  // ������ ��������:
    pLoadProgress: TPanel;
    lLoad: TLabel;
    pbLoad: TProgressBar;
  // ������ ���������:
    sbHorizontal: TScrollBar;
    sbVertical: TScrollBar;

  // ������ �������:
    PanelProps: TPanel;
  // ������ ���������� �������:
    PanelPropApply: TPanel;
    bApplyProperty: TButton;
  // �������� ������� ��������:
    vleObjectProperty: TValueListEditor;

  // ������ �������� - �������:
    PanelObjs: TPanel;
    pcObjects: TPageControl;
  // ������� "������":
    tsPanels: TTabSheet;
    lbTextureList: TListBox;
  // ������ ��������� �������:
    PanelTextures: TPanel;
    LabelTxW: TLabel;
    lTextureWidth: TLabel;
    LabelTxH: TLabel;
    lTextureHeight: TLabel;
    cbPreview: TCheckBox;
    bbAddTexture: TBitBtn;
    bbRemoveTexture: TBitBtn;
    bClearTexture: TButton;
  // ������ ����� �������:
    PanelPanelType: TPanel;
    lbPanelType: TListBox;
  // ������� "��������":
    tsItems: TTabSheet;
    lbItemList: TListBox;
    cbOnlyDM: TCheckBox;
    cbFall: TCheckBox;
  // ������� "�������":
    tsMonsters: TTabSheet;
    lbMonsterList: TListBox;
    rbMonsterLeft: TRadioButton;
    rbMonsterRight: TRadioButton;
  // ������� "�������":
    tsAreas: TTabSheet;
    lbAreasList: TListBox;
    rbAreaLeft: TRadioButton;
    rbAreaRight: TRadioButton;
  // ������� "��������":
    tsTriggers: TTabSheet;
    lbTriggersList: TListBox;
    clbActivationType: TCheckListBox;
    clbKeys: TCheckListBox;

  // ��������� ������
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    StatusBar: TStatusBar;

  // ����������� �������:
    ImageList: TImageList;
    ilToolbar: TImageList;
    OpenDialog: TOpenDialog;
    SaveDialog: TSaveDialog;
    selectall1: TMenuItem;
    XPManifest: TXPManifest;

    procedure aAboutExecute(Sender: TObject);
    procedure aCheckMapExecute(Sender: TObject);
    procedure aMoveToFore(Sender: TObject);
    procedure aMoveToBack(Sender: TObject);
    procedure aCopyObjectExecute(Sender: TObject);
    procedure aCutObjectExecute(Sender: TObject);
    procedure aEditorOptionsExecute(Sender: TObject);
    procedure aExitExecute(Sender: TObject);
    procedure aMapOptionsExecute(Sender: TObject);
    procedure aNewMapExecute(Sender: TObject);
    procedure aOpenMapExecute(Sender: TObject);
    procedure aOptimizeExecute(Sender: TObject);
    procedure aPasteObjectExecute(Sender: TObject);
    procedure aSelectAllExecute(Sender: TObject);
    procedure aSaveMapExecute(Sender: TObject);
    procedure aSaveMapAsExecute(Sender: TObject);
    procedure aUndoExecute(Sender: TObject);
    procedure aDeleteMap(Sender: TObject);
    procedure bApplyPropertyClick(Sender: TObject);
    procedure bbAddTextureClick(Sender: TObject);
    procedure bbRemoveTextureClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormResize(Sender: TObject);
    procedure lbTextureListClick(Sender: TObject);
    procedure RenderPanelMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RenderPanelMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure RenderPanelMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure RenderPanelResize(Sender: TObject);
    procedure vleObjectPropertyEditButtonClick(Sender: TObject);
    procedure vleObjectPropertyGetPickList(Sender: TObject; const KeyName: String; Values: TStrings);
    procedure vleObjectPropertyKeyDown(Sender: TObject; var Key: Word;
                                       Shift: TShiftState);
    procedure tbGridOnClick(Sender: TObject);
    procedure miMapPreviewClick(Sender: TObject);
    procedure miLayer1Click(Sender: TObject);
    procedure miLayer2Click(Sender: TObject);
    procedure miLayer3Click(Sender: TObject);
    procedure miLayer4Click(Sender: TObject);
    procedure miLayer5Click(Sender: TObject);
    procedure miLayer6Click(Sender: TObject);
    procedure miLayer7Click(Sender: TObject);
    procedure miLayer8Click(Sender: TObject);
    procedure miLayer9Click(Sender: TObject);
    procedure tbShowClick(Sender: TObject);
    procedure miSnapToGridClick(Sender: TObject);
    procedure miMiniMapClick(Sender: TObject);
    procedure miSwitchGridClick(Sender: TObject);
    procedure miShowEdgesClick(Sender: TObject);
    procedure minexttabClick(Sender: TObject);
    procedure miSaveMiniMapClick(Sender: TObject);
    procedure bClearTextureClick(Sender: TObject);
    procedure miPackMapClick(Sender: TObject);
    procedure aRecentFileExecute(Sender: TObject);
    procedure miMapTestSettingsClick(Sender: TObject);
    procedure miTestMapClick(Sender: TObject);
    procedure sbVerticalScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure sbHorizontalScroll(Sender: TObject; ScrollCode: TScrollCode;
      var ScrollPos: Integer);
    procedure miOpenWadMapClick(Sender: TObject);
    procedure selectall1Click(Sender: TObject);
    procedure Splitter1CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure Splitter2CanResize(Sender: TObject; var NewSize: Integer;
      var Accept: Boolean);
    procedure vleObjectPropertyEnter(Sender: TObject);
    procedure vleObjectPropertyExit(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure lbTextureListDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
  private
    procedure Draw();
    procedure OnIdle(Sender: TObject; var Done: Boolean);
  public
    procedure RefreshRecentMenu();
  end;

const
  LAYER_BACK       = 0;
  LAYER_WALLS      = 1;
  LAYER_FOREGROUND = 2;
  LAYER_STEPS      = 3;
  LAYER_WATER      = 4;
  LAYER_ITEMS      = 5;
  LAYER_MONSTERS   = 6;
  LAYER_AREAS      = 7;
  LAYER_TRIGGERS   = 8;

  TEST_MAP_NAME = '$$$_TEST_$$$';
  LANGUAGE_FILE_NAME = '_Editor.txt';

var
  MainForm: TMainForm;
  EditorDir: String;
  OpenedMap: String;
  OpenedWAD: String;

  DotColor: TColor;
  DotEnable: Boolean;
  DotStep: Byte;
  DotStepOne, DotStepTwo: Byte;
  DotSize: Byte;
  DrawTexturePanel: Boolean;
  DrawPanelSize: Boolean;
  BackColor: TColor;
  PreviewColor: TColor;
  Scale: Byte;
  RecentCount: Integer;
  RecentFiles: TStringList;
  slInvalidTextures: TStringList;

  TestGameMode: String;
  TestLimTime: String;
  TestLimScore: String;
  TestOptionsTwoPlayers: Boolean;
  TestOptionsTeamDamage: Boolean;
  TestOptionsAllowExit: Boolean;
  TestOptionsWeaponStay: Boolean;
  TestOptionsMonstersDM: Boolean;
  TestD2dExe: String;
  TestMapOnce: Boolean;

  LayerEnabled: Array [LAYER_BACK..LAYER_TRIGGERS] of Boolean =
    (True, True, True, True, True, True, True, True, True);
  PreviewMode: Boolean = False;
  gLanguage: String;

  FormCaption: String;


procedure OpenMap(FileName: String; mapN: String);
function  AddTexture(aWAD, aSection, aTex: String; silent: Boolean): Boolean;
procedure RemoveSelectFromObjects();
procedure ChangeShownProperty(Name: String; NewValue: String);

implementation

uses
  f_options, e_graphics, e_log, dglOpenGL, Math,
  f_mapoptions, g_basic, f_about, f_mapoptimization,
  f_mapcheck, f_addresource_texture, g_textures,
  f_activationtype, f_keys, MAPWRITER, MAPSTRUCT,
  MAPREADER, f_selectmap, f_savemap, WADEDITOR, MAPDEF,
  g_map, f_saveminimap, f_addresource, CONFIG, f_packmap,
  f_addresource_sound, f_maptest, f_choosetype,
  g_language, f_selectlang, ClipBrd;

const
  UNDO_DELETE_PANEL   = 1;
  UNDO_DELETE_ITEM    = 2;
  UNDO_DELETE_AREA    = 3;
  UNDO_DELETE_MONSTER = 4;
  UNDO_DELETE_TRIGGER = 5;
  UNDO_ADD_PANEL      = 6;
  UNDO_ADD_ITEM       = 7;
  UNDO_ADD_AREA       = 8;
  UNDO_ADD_MONSTER    = 9;
  UNDO_ADD_TRIGGER    = 10;
  UNDO_MOVE_PANEL     = 11;
  UNDO_MOVE_ITEM      = 12;
  UNDO_MOVE_AREA      = 13;
  UNDO_MOVE_MONSTER   = 14;
  UNDO_MOVE_TRIGGER   = 15;
  UNDO_RESIZE_PANEL   = 16;
  UNDO_RESIZE_TRIGGER = 17;

  MOUSEACTION_NONE        = 0;
  MOUSEACTION_DRAWPANEL   = 1;
  MOUSEACTION_DRAWTRIGGER = 2;
  MOUSEACTION_MOVEOBJ     = 3;
  MOUSEACTION_RESIZE      = 4;
  MOUSEACTION_MOVEMAP     = 5;
  MOUSEACTION_DRAWPRESS   = 6;
  MOUSEACTION_NOACTION    = 7;

  RESIZETYPE_NONE       = 0;
  RESIZETYPE_VERTICAL   = 1;
  RESIZETYPE_HORIZONTAL = 2;

  RESIZEDIR_NONE  = 0;
  RESIZEDIR_DOWN  = 1;
  RESIZEDIR_UP    = 2;
  RESIZEDIR_RIGHT = 3;
  RESIZEDIR_LEFT  = 4;

  SELECTFLAG_NONE       = 0;
  SELECTFLAG_TELEPORT   = 1;
  SELECTFLAG_DOOR       = 2;
  SELECTFLAG_TEXTURE    = 3;
  SELECTFLAG_LIFT       = 4;
  SELECTFLAG_MONSTER    = 5;
  SELECTFLAG_SPAWNPOINT = 6;
  SELECTFLAG_SELECTED   = 7;

  RECENT_FILES_MENU_START = 11;

  CLIPBOARD_SIG         = 'DF:ED';

type
  TUndoRec = record
    UndoType: Byte;
    case Byte of
      UNDO_DELETE_PANEL:   (Panel: ^TPanel);
      UNDO_DELETE_ITEM:    (Item: TItem);
      UNDO_DELETE_AREA:    (Area: TArea);
      UNDO_DELETE_MONSTER: (Monster: TMonster);
      UNDO_DELETE_TRIGGER: (Trigger: TTrigger);
      UNDO_ADD_PANEL,
      UNDO_ADD_ITEM,
      UNDO_ADD_AREA,
      UNDO_ADD_MONSTER,
      UNDO_ADD_TRIGGER:    (AddID: DWORD);
      UNDO_MOVE_PANEL,
      UNDO_MOVE_ITEM,
      UNDO_MOVE_AREA,
      UNDO_MOVE_MONSTER,
      UNDO_MOVE_TRIGGER:   (MoveID: DWORD; dX, dY: Integer);
      UNDO_RESIZE_PANEL,
      UNDO_RESIZE_TRIGGER: (ResizeID: DWORD; dW, dH: Integer);
  end;

  TCopyRec = record
    ObjectType: Byte;
    ID: Cardinal;
    case Byte of
      OBJECT_PANEL: (Panel: ^TPanel);
      OBJECT_ITEM: (Item: TItem);
      OBJECT_AREA: (Area: TArea);
      OBJECT_MONSTER: (Monster: TMonster);
      OBJECT_TRIGGER: (Trigger: TTrigger);
  end;

  TCopyRecArray = Array of TCopyRec;

var
  hDC: THandle;
  hRC: THandle;
  gEditorFont: DWORD;
  ShowMap: Boolean = False;
  DrawRect: PRect = nil;
  SnapToGrid: Boolean = True;

  MousePos: Types.TPoint;
  LastMovePoint: Types.TPoint;
  MouseLDown: Boolean;
  MouseRDown: Boolean;
  MouseLDownPos: Types.TPoint;
  MouseRDownPos: Types.TPoint;

  SelectFlag: Byte = SELECTFLAG_NONE;
  MouseAction: Byte = MOUSEACTION_NONE;
  ResizeType: Byte = RESIZETYPE_NONE;
  ResizeDirection: Byte = RESIZEDIR_NONE;

  DrawPressRect: Boolean = False;
  EditingProperties: Boolean = False;

  UndoBuffer: Array of Array of TUndoRec = nil;


{$R *.dfm}

//----------------------------------------
//����� ���� ��������������� ���������
//----------------------------------------

function NameToBool(Name: String): Boolean;
begin
  if Name = BoolNames[True] then
    Result := True
  else
    Result := False;
end;

function NameToDir(Name: String): TDirection;
begin
  if Name = DirNames[D_LEFT] then
    Result := D_LEFT
  else
    Result := D_RIGHT;
end;

function NameToDirAdv(Name: String): Byte;
begin
  if Name = DirNamesAdv[1] then
    Result := 1
  else
    if Name = DirNamesAdv[2] then
      Result := 2
    else
      if Name = DirNamesAdv[3] then
        Result := 3
      else
        Result := 0;
end;

function ActivateToStr(ActivateType: Byte): String;
begin
  Result := '';

  if ByteBool(ACTIVATE_PLAYERCOLLIDE and ActivateType) then
    Result := Result + '+PC';
  if ByteBool(ACTIVATE_MONSTERCOLLIDE and ActivateType) then
    Result := Result + '+MC';
  if ByteBool(ACTIVATE_PLAYERPRESS and ActivateType) then
    Result := Result + '+PP';
  if ByteBool(ACTIVATE_MONSTERPRESS and ActivateType) then
    Result := Result + '+MP';
  if ByteBool(ACTIVATE_SHOT and ActivateType) then
    Result := Result + '+SH';
  if ByteBool(ACTIVATE_NOMONSTER and ActivateType) then
    Result := Result + '+NM';

  if (Result <> '') and (Result[1] = '+') then
    Delete(Result, 1, 1);
end;

function StrToActivate(Str: String): Byte;
begin
  Result := 0;

  if Pos('PC', Str) > 0 then
    Result := ACTIVATE_PLAYERCOLLIDE;
  if Pos('MC', Str) > 0 then
    Result := Result or ACTIVATE_MONSTERCOLLIDE;
  if Pos('PP', Str) > 0 then
    Result := Result or ACTIVATE_PLAYERPRESS;
  if Pos('MP', Str) > 0 then
    Result := Result or ACTIVATE_MONSTERPRESS;
  if Pos('SH', Str) > 0 then
    Result := Result or ACTIVATE_SHOT;
  if Pos('NM', Str) > 0 then
    Result := Result or ACTIVATE_NOMONSTER;
end;

function KeyToStr(Key: Byte): String;
begin
  Result := '';

  if ByteBool(KEY_RED and Key) then
    Result := Result + '+RK';
  if ByteBool(KEY_GREEN and Key) then
    Result := Result + '+GK';
  if ByteBool(KEY_BLUE and Key) then
    Result := Result + '+BK';
  if ByteBool(KEY_REDTEAM and Key) then
    Result := Result + '+RT';
  if ByteBool(KEY_BLUETEAM and Key) then
    Result := Result + '+BT';

  if (Result <> '') and (Result[1] = '+') then
    Delete(Result, 1, 1);
end;

function StrToKey(Str: String): Byte;
begin
  Result := 0;

  if Pos('RK', Str) > 0 then
    Result := KEY_RED;
  if Pos('GK', Str) > 0 then
    Result := Result or KEY_GREEN;
  if Pos('BK', Str) > 0 then
    Result := Result or KEY_BLUE;
  if Pos('RT', Str) > 0 then
    Result := Result or KEY_REDTEAM;
  if Pos('BT', Str) > 0 then
    Result := Result or KEY_BLUETEAM;
end;

function EffectToStr(Effect: Byte): String;
begin
  if Effect in [EFFECT_TELEPORT..EFFECT_FIRE] then
    Result := EffectNames[Effect]
  else
    Result := EffectNames[EFFECT_NONE];
end;

function StrToEffect(Str: String): Byte;
var
  i: Integer;
begin
  Result := EFFECT_NONE;
  for i := EFFECT_TELEPORT to EFFECT_FIRE do
    if EffectNames[i] = Str then
      begin
        Result := i;
        Exit;
      end;
end;

function MonsterToStr(MonType: Byte): String;
begin
  if MonType in [MONSTER_DEMON..MONSTER_MAN] then
    Result := MonsterNames[MonType]
  else
    Result := MonsterNames[MONSTER_ZOMBY];
end;

function StrToMonster(Str: String): Byte;
var
  i: Integer;
begin
  Result := MONSTER_ZOMBY;
  for i := MONSTER_DEMON to MONSTER_MAN do
    if MonsterNames[i] = Str then
      begin
        Result := i;
        Exit;
      end;
end;

function ItemToStr(ItemType: Byte): String;
begin
  if ItemType in [ITEM_MEDKIT_SMALL..ITEM_MAX] then
    Result := ItemNames[ItemType]
  else
    Result := ItemNames[ITEM_AMMO_BULLETS];
end;

function StrToItem(Str: String): Byte;
var
  i: Integer;
begin
  Result := ITEM_AMMO_BULLETS;
  for i := ITEM_MEDKIT_SMALL to ITEM_MAX do
    if ItemNames[i] = Str then
      begin
        Result := i;
        Exit;
      end;
end;

function ShotToStr(ShotType: Byte): String;
begin
  if ShotType in [TRIGGER_SHOT_BULLET..TRIGGER_SHOT_REV] then
    Result := ShotNames[ShotType]
  else
    Result := ShotNames[TRIGGER_SHOT_BULLET];
end;

function StrToShot(Str: String): Byte;
var
  i: Integer;
begin
  Result := TRIGGER_SHOT_BULLET;
  for i := TRIGGER_SHOT_BULLET to TRIGGER_SHOT_REV do
    if ShotNames[i] = Str then
      begin
        Result := i;
        Exit;
      end;
end;

function SelectedObjectCount(): Word;
var
  a: Integer;
begin
  Result := 0;

  if SelectedObjects = nil then
    Exit;

  for a := 0 to High(SelectedObjects) do
    if SelectedObjects[a].Live then
      Result := Result + 1;
end;

function GetFirstSelected(): Integer;
var
  a: Integer;
begin
  Result := -1;

  if SelectedObjects = nil then
    Exit;

  for a := 0 to High(SelectedObjects) do
    if SelectedObjects[a].Live then
    begin
      Result := a;
      Exit;
    end;
end;

function Normalize16(x: Integer): Integer;
begin
  Result := (x div 16) * 16;
end;

procedure MoveMap(X, Y: Integer);
var
  rx, ry, ScaleSz: Integer;
begin
  with MainForm.RenderPanel do
  begin
    ScaleSz := 16 div Scale;
  // ������ ������� ����� �����:
    rx := min(Normalize16(Width), Normalize16(gMapInfo.Width)) div 2;
    ry := min(Normalize16(Height), Normalize16(gMapInfo.Height)) div 2;
  // ����� ����� �� ����-�����:
    MapOffset.X := X - (Width-max(gMapInfo.Width div ScaleSz, 1)-1);
    MapOffset.Y := Y - 1;
  // ��� �� ����� �� "�������" �����:
    MapOffset.X := MapOffset.X * ScaleSz;
    MapOffset.Y := MapOffset.Y * ScaleSz;
  // ����� ������� ���� ����� ������� ����� �����:
    MapOffset.X := MapOffset.X - rx;
    MapOffset.Y := MapOffset.Y - ry;
  // ����� �� �������:
    if MapOffset.X < 0 then
      MapOffset.X := 0;
    if MapOffset.Y < 0 then
      MapOffset.Y := 0;
    if MapOffset.X > MainForm.sbHorizontal.Max then
      MapOffset.X := MainForm.sbHorizontal.Max;
    if MapOffset.Y > MainForm.sbVertical.Max then
      MapOffset.Y := MainForm.sbVertical.Max;
  // ������ 16:
    MapOffset.X := Normalize16(MapOffset.X);
    MapOffset.Y := Normalize16(MapOffset.Y);
  end;

  MainForm.sbHorizontal.Position := MapOffset.X;
  MainForm.sbVertical.Position := MapOffset.Y;

  MapOffset.X := -MapOffset.X;
  MapOffset.Y := -MapOffset.Y;

  MainForm.Resize();
end;

function IsTexturedPanel(PanelType: Word): Boolean;
begin
  Result := WordBool(PanelType and (PANEL_WALL or PANEL_BACK or PANEL_FORE or
                                    PANEL_STEP or PANEL_OPENDOOR or PANEL_CLOSEDOOR or
                                    PANEL_WATER or PANEL_ACID1 or PANEL_ACID2));
end;

procedure FillProperty();
var
  _id: DWORD;
  str: String;
begin
  MainForm.vleObjectProperty.Strings.Clear();

// ���������� �������� ���� ������� ������ ���� ������:
  if SelectedObjectCount() <> 1 then
    Exit;
    
  _id := GetFirstSelected();
  if not SelectedObjects[_id].Live then
    Exit;

  with MainForm.vleObjectProperty do
    with ItemProps[InsertRow(_lc[I_PROP_ID], IntToStr(SelectedObjects[_id].ID), True)-1] do
    begin
      EditStyle := esSimple;
      ReadOnly := True;
    end;

  case SelectedObjects[0].ObjectType of
    OBJECT_PANEL:
      begin
        with MainForm.vleObjectProperty,
             gPanels[SelectedObjects[_id].ID] do
        begin
          with ItemProps[InsertRow(_lc[I_PROP_X], IntToStr(X), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_Y], IntToStr(Y), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_WIDTH], IntToStr(Width), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_HEIGHT], IntToStr(Height), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_PANEL_TYPE], GetPanelName(PanelType), True)-1] do
          begin
            EditStyle := esPickList;
            ReadOnly := True;
          end;

          if IsTexturedPanel(PanelType) then
          begin // ����� ���� ��������
            with ItemProps[InsertRow(_lc[I_PROP_PANEL_TEX], TextureName, True)-1] do
            begin
              EditStyle := esEllipsis;
              ReadOnly := True;
            end;

            if TextureName <> '' then
            begin // ���� ��������
              with ItemProps[InsertRow(_lc[I_PROP_PANEL_ALPHA], IntToStr(Alpha), True)-1] do
              begin
                EditStyle := esSimple;
                MaxLength := 3;
              end;

              with ItemProps[InsertRow(_lc[I_PROP_PANEL_BLEND], BoolNames[Blending], True)-1] do
              begin
                EditStyle := esPickList;
                ReadOnly := True;
              end;
            end;
          end;
        end;
      end;

    OBJECT_ITEM:
      begin
        with MainForm.vleObjectProperty,
             gItems[SelectedObjects[_id].ID] do
        begin
          with ItemProps[InsertRow(_lc[I_PROP_X], IntToStr(X), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_Y], IntToStr(Y), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_DM_ONLY], BoolNames[OnlyDM], True)-1] do
          begin
            EditStyle := esPickList;
            ReadOnly := True;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_ITEM_FALLS], BoolNames[Fall], True)-1] do
          begin
            EditStyle := esPickList;
            ReadOnly := True;
          end;
        end;
      end;

    OBJECT_MONSTER:
      begin
        with MainForm.vleObjectProperty,
             gMonsters[SelectedObjects[_id].ID] do
        begin
          with ItemProps[InsertRow(_lc[I_PROP_X], IntToStr(X), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_Y], IntToStr(Y), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_DIRECTION], DirNames[Direction], True)-1] do
          begin
            EditStyle := esPickList;
            ReadOnly := True;
          end;
        end;
      end;

    OBJECT_AREA:
      begin
        with MainForm.vleObjectProperty,
             gAreas[SelectedObjects[_id].ID] do
        begin
          with ItemProps[InsertRow(_lc[I_PROP_X], IntToStr(X), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_Y], IntToStr(Y), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_DIRECTION], DirNames[Direction], True)-1] do
          begin
            EditStyle := esPickList;
            ReadOnly := True;
          end;
        end;
      end;

    OBJECT_TRIGGER:
      begin
        with MainForm.vleObjectProperty,
             gTriggers[SelectedObjects[_id].ID] do
        begin
          with ItemProps[InsertRow(_lc[I_PROP_TR_TYPE], GetTriggerName(TriggerType), True)-1] do
          begin
            EditStyle := esSimple;
            ReadOnly := True;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_X], IntToStr(X), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_Y], IntToStr(Y), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_WIDTH], IntToStr(Width), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_HEIGHT], IntToStr(Height), True)-1] do
          begin
            EditStyle := esSimple;
            MaxLength := 5;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_TR_ENABLED], BoolNames[Enabled], True)-1] do
          begin
            EditStyle := esPickList;
            ReadOnly := True;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_TR_TEXTURE_PANEL], IntToStr(TexturePanel), True)-1] do
          begin
            EditStyle := esEllipsis;
            ReadOnly := True;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_TR_ACTIVATION], ActivateToStr(ActivateType), True)-1] do
          begin
            EditStyle := esEllipsis;
            ReadOnly := True;
          end;

          with ItemProps[InsertRow(_lc[I_PROP_TR_KEYS], KeyToStr(Key), True)-1] do
          begin
            EditStyle := esEllipsis;
            ReadOnly := True;
          end;

          case TriggerType of
            TRIGGER_EXIT:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_NEXT_MAP], Data.MapName, True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_TELEPORT:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_TELEPORT_TO], Format('(%d:%d)', [Data.TargetPoint.X, Data.TargetPoint.Y]), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_D2D], BoolNames[Data.d2d_teleport], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_TELEPORT_SILENT], BoolNames[Data.silent_teleport], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_TELEPORT_DIR], DirNamesAdv[Data.TlpDir], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_OPENDOOR, TRIGGER_CLOSEDOOR,
            TRIGGER_DOOR, TRIGGER_DOOR5:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_DOOR_PANEL], IntToStr(Data.PanelID), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SILENT], BoolNames[Data.NoSound], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_D2D], BoolNames[Data.d2d_doors], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_CLOSETRAP, TRIGGER_TRAP:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_TRAP_PANEL], IntToStr(Data.PanelID), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SILENT], BoolNames[Data.NoSound], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_D2D], BoolNames[Data.d2d_doors], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_PRESS, TRIGGER_ON, TRIGGER_OFF,
            TRIGGER_ONOFF:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_EX_AREA],
                                 Format('(%d:%d %d:%d)', [Data.tX, Data.tY, Data.tWidth, Data.tHeight]), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_EX_DELAY], IntToStr(Data.Wait), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_EX_COUNT], IntToStr(Data.Count), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_EX_MONSTER], IntToStr(Data.MonsterID-1), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                if TriggerType = TRIGGER_PRESS then
                  with ItemProps[InsertRow(_lc[I_PROP_TR_EX_RANDOM], BoolNames[Data.ExtRandom], True)-1] do
                  begin
                    EditStyle := esPickList;
                    ReadOnly := True;
                  end;
              end;

            TRIGGER_SECRET:
              ;

            TRIGGER_LIFTUP, TRIGGER_LIFTDOWN, TRIGGER_LIFT:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_LIFT_PANEL], IntToStr(Data.PanelID), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SILENT], BoolNames[Data.NoSound], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_D2D], BoolNames[Data.d2d_doors], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_TEXTURE:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_TEXTURE_ONCE], BoolNames[Data.ActivateOnce], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_TEXTURE_ANIM_ONCE], BoolNames[Data.AnimOnce], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_SOUND:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_SOUND_NAME], Data.SoundName, True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SOUND_VOLUME], IntToStr(Data.Volume), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 3;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SOUND_PAN], IntToStr(Data.Pan), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 3;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SOUND_COUNT], IntToStr(Data.PlayCount), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 3;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SOUND_LOCAL], BoolNames[Data.Local], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SOUND_SWITCH], BoolNames[Data.SoundSwitch], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_SPAWNMONSTER:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_MONSTER_TYPE], MonsterToStr(Data.MonType), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SPAWN_TO],
                                 Format('(%d:%d)', [Data.MonPos.X, Data.MonPos.Y]), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_DIRECTION], DirNames[TDirection(Data.MonDir)], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_HEALTH], IntToStr(Data.MonHealth), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_MONSTER_ACTIVE], BoolNames[Data.MonActive], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_COUNT], IntToStr(Data.MonCount), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_FX_TYPE], EffectToStr(Data.MonEffect), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SPAWN_MAX], IntToStr(Data.MonMax), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SPAWN_DELAY], IntToStr(Data.MonDelay), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                case Data.MonBehav of
                  1: str := _lc[I_PROP_TR_MONSTER_BEHAVIOUR_1];
                  2: str := _lc[I_PROP_TR_MONSTER_BEHAVIOUR_2];
                  3: str := _lc[I_PROP_TR_MONSTER_BEHAVIOUR_3];
                  4: str := _lc[I_PROP_TR_MONSTER_BEHAVIOUR_4];
                  5: str := _lc[I_PROP_TR_MONSTER_BEHAVIOUR_5];
                  else str := _lc[I_PROP_TR_MONSTER_BEHAVIOUR_0];
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_MONSTER_BEHAVIOUR], str, True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_SPAWNITEM:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_ITEM_TYPE], ItemToStr(Data.ItemType), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SPAWN_TO],
                                 Format('(%d:%d)', [Data.ItemPos.X, Data.ItemPos.Y]), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_DM_ONLY], BoolNames[Data.ItemOnlyDM], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_ITEM_FALLS], BoolNames[Data.ItemFalls], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_COUNT], IntToStr(Data.ItemCount), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_FX_TYPE], EffectToStr(Data.ItemEffect), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SPAWN_MAX], IntToStr(Data.ItemMax), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SPAWN_DELAY], IntToStr(Data.ItemDelay), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;
              end;

           TRIGGER_MUSIC:
             begin
               with ItemProps[InsertRow(_lc[I_PROP_TR_MUSIC_NAME], Data.MusicName, True)-1] do
               begin
                 EditStyle := esEllipsis;
                 ReadOnly := True;
               end;

               if Data.MusicAction = 1 then
                 str := _lc[I_PROP_TR_MUSIC_ON]
               else
                 str := _lc[I_PROP_TR_MUSIC_OFF];

               with ItemProps[InsertRow(_lc[I_PROP_TR_MUSIC_ACT], str, True)-1] do
               begin
                 EditStyle := esPickList;
                 ReadOnly := True;
               end;
             end;

            TRIGGER_PUSH:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_PUSH_ANGLE], IntToStr(Data.PushAngle), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 4;
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_PUSH_FORCE], IntToStr(Data.PushForce), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 4;
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_PUSH_RESET], BoolNames[Data.ResetVel], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_SCORE:
              begin
                case Data.ScoreAction of
                  1: str := _lc[I_PROP_TR_SCORE_ACT_1];
                  2: str := _lc[I_PROP_TR_SCORE_ACT_2];
                  3: str := _lc[I_PROP_TR_SCORE_ACT_3];
                  else str := _lc[I_PROP_TR_SCORE_ACT_0];
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_SCORE_ACT], str, True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_COUNT], IntToStr(Data.ScoreCount), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 3;
                end;
                case Data.ScoreTeam of
                  1: str := _lc[I_PROP_TR_SCORE_TEAM_1];
                  2: str := _lc[I_PROP_TR_SCORE_TEAM_2];
                  3: str := _lc[I_PROP_TR_SCORE_TEAM_3];
                  else str := _lc[I_PROP_TR_SCORE_TEAM_0];
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_SCORE_TEAM], str, True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_MESSAGE:
              begin
                case Data.MessageKind of
                  1: str := _lc[I_PROP_TR_MESSAGE_KIND_1];
                  else str := _lc[I_PROP_TR_MESSAGE_KIND_0];
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_MESSAGE_KIND], str, True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
                case Data.MessageSendTo of
                  1: str := _lc[I_PROP_TR_MESSAGE_TO_1];
                  2: str := _lc[I_PROP_TR_MESSAGE_TO_2];
                  3: str := _lc[I_PROP_TR_MESSAGE_TO_3];
                  4: str := _lc[I_PROP_TR_MESSAGE_TO_4];
                  5: str := _lc[I_PROP_TR_MESSAGE_TO_5];
                  else str := _lc[I_PROP_TR_MESSAGE_TO_0];
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_MESSAGE_TO], str, True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_MESSAGE_TEXT], Data.MessageText, True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 100;
                end;
              end;

            TRIGGER_DAMAGE:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_DAMAGE_VALUE], IntToStr(Data.DamageValue), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_INTERVAL], IntToStr(Data.DamageInterval), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;
              end;

            TRIGGER_HEALTH:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_HEALTH], IntToStr(Data.HealValue), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_INTERVAL], IntToStr(Data.HealInterval), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_HEALTH_MAX], BoolNames[Data.HealMax], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_SILENT], BoolNames[Data.HealSilent], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;

            TRIGGER_SHOT:
              begin
                with ItemProps[InsertRow(_lc[I_PROP_TR_SHOT_TYPE], ShotToStr(Data.ShotType), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                case Data.ShotTarget of
                  1: str := _lc[I_PROP_TR_SHOT_TO_1];
                  2: str := _lc[I_PROP_TR_SHOT_TO_2];
                  3: str := _lc[I_PROP_TR_SHOT_TO_3];
                  4: str := _lc[I_PROP_TR_SHOT_TO_4];
                  else str := _lc[I_PROP_TR_SHOT_TO_0];
                end;
                with ItemProps[InsertRow(_lc[I_PROP_TR_SHOT_TO], str, True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SPAWN_TO],
                                 Format('(%d:%d)', [Data.ShotPos.X, Data.ShotPos.Y]), True)-1] do
                begin
                  EditStyle := esEllipsis;
                  ReadOnly := True;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_EX_DELAY], IntToStr(Data.ShotWait), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 5;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SHOT_ANGLE], IntToStr(Data.ShotAngle), True)-1] do
                begin
                  EditStyle := esSimple;
                  MaxLength := 4;
                end;

                with ItemProps[InsertRow(_lc[I_PROP_TR_SHOT_SOUND], BoolNames[Data.ShotSound], True)-1] do
                begin
                  EditStyle := esPickList;
                  ReadOnly := True;
                end;
              end;
          end; //case TriggerType
        end;
      end; // OBJECT_TRIGGER:
  end;
end;

procedure ChangeShownProperty(Name: String; NewValue: String);
var
  row: Integer;
begin
  if SelectedObjectCount() <> 1 then
    Exit;
  if not SelectedObjects[GetFirstSelected()].Live then
    Exit;

// ���� �� ����� ����:
  if MainForm.vleObjectProperty.FindRow(Name, row) then
  begin
    MainForm.vleObjectProperty.Values[Name] := NewValue;
  end;
end;

procedure SelectObject(fObjectType: Byte; fID: DWORD; Multi: Boolean);
var
  a: Integer;
  b: Boolean;
begin
  if Multi then
    begin
      b := False;

    // ��� ������� - �������:
      if SelectedObjects <> nil then
        for a := 0 to High(SelectedObjects) do
          with SelectedObjects[a] do
           if Live and (ID = fID) and
              (ObjectType = fObjectType) then
           begin
             Live := False;
             b := True;
           end;

      if b then
        Exit;

      SetLength(SelectedObjects, Length(SelectedObjects)+1);

      with SelectedObjects[High(SelectedObjects)] do
      begin
        ObjectType := fObjectType;
        ID := fID;
        Live := True;
      end;
    end
  else // not Multi
    begin
      SetLength(SelectedObjects, 1);

      with SelectedObjects[0] do
      begin
        ObjectType := fObjectType;
        ID := fID;
        Live := True;
      end;
    end;

  MainForm.miCopy.Enabled := True;
  MainForm.miCut.Enabled := True;

  if fObjectType = OBJECT_PANEL then
  begin
    MainForm.miToFore.Enabled := True;
    MainForm.miToBack.Enabled := True;
  end;
end;

procedure RemoveSelectFromObjects();
begin
  SelectedObjects := nil;
  DrawPressRect := False;
  MouseLDown := False;
  MouseRDown := False;
  MouseAction := MOUSEACTION_NONE;
  SelectFlag := SELECTFLAG_NONE;
  ResizeType := RESIZETYPE_NONE;
  ResizeDirection := RESIZEDIR_NONE;

  MainForm.vleObjectProperty.Strings.Clear();
  
  MainForm.miCopy.Enabled := False;
  MainForm.miCut.Enabled := False;
  MainForm.miToFore.Enabled := False;
  MainForm.miToBack.Enabled := False;
end;

procedure DeleteSelectedObjects();
var
  i, a, ii: Integer;
  b: Boolean;
begin
  if SelectedObjects = nil then
    Exit;

  b := False;
  i := 0;

  for a := 0 to High(SelectedObjects) do
    with SelectedObjects[a] do
      if Live then
      begin
        if not b then
        begin
          SetLength(UndoBuffer, Length(UndoBuffer)+1);
          i := High(UndoBuffer);
          b := True;
        end;

        SetLength(UndoBuffer[i], Length(UndoBuffer[i])+1);
        ii := High(UndoBuffer[i]);

        case ObjectType of
          OBJECT_PANEL:
            begin
              UndoBuffer[i, ii].UndoType := UNDO_DELETE_PANEL;
              New(UndoBuffer[i, ii].Panel);
              UndoBuffer[i, ii].Panel^ := gPanels[ID];
            end;
          OBJECT_ITEM:
            begin
              UndoBuffer[i, ii].UndoType := UNDO_DELETE_ITEM;
              UndoBuffer[i, ii].Item := gItems[ID];
            end;
          OBJECT_AREA:
            begin
              UndoBuffer[i, ii].UndoType := UNDO_DELETE_AREA;
              UndoBuffer[i, ii].Area := gAreas[ID];
            end;
          OBJECT_TRIGGER:
            begin
              UndoBuffer[i, ii].UndoType := UNDO_DELETE_TRIGGER;
              UndoBuffer[i, ii].Trigger := gTriggers[ID];
            end;
        end;

        RemoveObject(ID, ObjectType);
      end;

  RemoveSelectFromObjects();

  MainForm.miUndo.Enabled := UndoBuffer <> nil;
end;

procedure Undo_Add(ObjectType: Byte; ID: DWORD; Group: Boolean = False);
var
  i, ii: Integer;
begin
  if (not Group) or (Length(UndoBuffer) = 0) then
    SetLength(UndoBuffer, Length(UndoBuffer)+1);
  SetLength(UndoBuffer[High(UndoBuffer)], Length(UndoBuffer[High(UndoBuffer)])+1);
  i := High(UndoBuffer);
  ii := High(UndoBuffer[i]);

  case ObjectType of
    OBJECT_PANEL:
      UndoBuffer[i, ii].UndoType := UNDO_ADD_PANEL;
    OBJECT_ITEM:
      UndoBuffer[i, ii].UndoType := UNDO_ADD_ITEM;
    OBJECT_MONSTER:
      UndoBuffer[i, ii].UndoType := UNDO_ADD_MONSTER;
    OBJECT_AREA:
      UndoBuffer[i, ii].UndoType := UNDO_ADD_AREA;
    OBJECT_TRIGGER:
      UndoBuffer[i, ii].UndoType := UNDO_ADD_TRIGGER;
  end;

  UndoBuffer[i, ii].AddID := ID;

  MainForm.miUndo.Enabled := UndoBuffer <> nil;
end;

procedure FullClear();
begin
  RemoveSelectFromObjects();
  ClearMap();
  UndoBuffer := nil;
  slInvalidTextures.Clear();
  MapCheckForm.lbErrorList.Clear();
  MapCheckForm.mErrorDescription.Clear();

  MainForm.miUndo.Enabled := False;
  MainForm.sbHorizontal.Position := 0;
  MainForm.sbVertical.Position := 0;
  MainForm.FormResize(nil);
  MainForm.Caption := FormCaption;
  OpenedMap := '';
  OpenedWAD := '';
end;

procedure ErrorMessageBox(str: String);
begin
  MessageBox(0, PChar(str), PChar(_lc[I_MSG_ERROR]),
             MB_ICONINFORMATION or MB_OK or
             MB_TASKMODAL or MB_DEFBUTTON1);
end;

function CheckProperty(): Boolean;
var
  _id: Integer;
begin
  Result := False;

  _id := GetFirstSelected();

  if SelectedObjects[_id].ObjectType = OBJECT_PANEL then
    with gPanels[SelectedObjects[_id].ID] do
    begin
      if TextureWidth <> 0 then
        if StrToIntDef(MainForm.vleObjectProperty.Values[_lc[I_PROP_WIDTH]], 1) mod TextureWidth <> 0 then
        begin
          ErrorMessageBox(Format(_lc[I_MSG_WRONG_TEXWIDTH],
                                 [TextureWidth]));
          Exit;
        end;

      if TextureHeight <> 0 then
        if StrToIntDef(Trim(MainForm.vleObjectProperty.Values[_lc[I_PROP_HEIGHT]]), 1) mod TextureHeight <> 0 then
        begin
          ErrorMessageBox(Format(_lc[I_MSG_WRONG_TEXHEIGHT],
                                 [TextureHeight]));
          Exit;
        end;

      if IsTexturedPanel(PanelType) and (TextureName <> '') then
        if not (StrToIntDef(MainForm.vleObjectProperty.Values[_lc[I_PROP_PANEL_ALPHA]], -1) in [0..255]) then
        begin
          ErrorMessageBox(_lc[I_MSG_WRONG_ALPHA]);
          Exit;
        end;
    end;

  if SelectedObjects[_id].ObjectType in [OBJECT_PANEL, OBJECT_TRIGGER] then
    if (StrToIntDef(MainForm.vleObjectProperty.Values[_lc[I_PROP_WIDTH]], 0) <= 0) or
       (StrToIntDef(MainForm.vleObjectProperty.Values[_lc[I_PROP_HEIGHT]], 0) <= 0) then
    begin
      ErrorMessageBox(_lc[I_MSG_WRONG_SIZE]);
      Exit;
    end;

  if (Trim(MainForm.vleObjectProperty.Values[_lc[I_PROP_X]]) = '') or
     (Trim(MainForm.vleObjectProperty.Values[_lc[I_PROP_Y]]) = '') then
  begin
    ErrorMessageBox(_lc[I_MSG_WRONG_XY]);
    Exit;
  end;

  Result := True;
end;

procedure SelectTexture(ID: Integer);
begin
  MainForm.lbTextureList.ItemIndex := ID;
  MainForm.lbTextureListClick(nil);
end;

function AddTexture(aWAD, aSection, aTex: String; silent: Boolean): Boolean;
var
  a: Integer;
  ok: Boolean;
  FileName: String;
  ResourceName: String;
  FullResourceName: String;
  SectionName: String;
  Data: Pointer;
  Width, Height: Word;
  fn: String;
begin
  if aSection = '..' then
    SectionName := ''
  else
    SectionName := aSection;

  if aWAD = _lc[I_WAD_SPECIAL_MAP] then
    begin // ���� �����
      g_ProcessResourceStr(OpenedMap, @fn, nil, nil);
    //FileName := EditorDir+'maps\'+ExtractFileName(fn);
      FileName := fn;
      ResourceName := ':'+SectionName+'\'+aTex;
    end
  else
    if aWAD = _lc[I_WAD_SPECIAL_TEXS] then
      begin // ����. ��������
        FileName := '';
        ResourceName := aTex;
      end
    else
      begin // ������� WAD
        FileName := EditorDir+'wads\'+aWAD;
        ResourceName := aWAD+':'+SectionName+'\'+aTex;
      end;

  ok := True;

// ���� �� ��� ����� ��������:
  for a := 0 to MainForm.lbTextureList.Items.Count-1 do
    if ResourceName = MainForm.lbTextureList.Items[a] then
    begin
      if not silent then
        ErrorMessageBox(Format(_lc[I_MSG_TEXTURE_ALREADY],
                               [ResourceName]));
      ok := False;
    end;

// �������� ������� <= 64 ��������:
  if Length(ResourceName) > 64 then
  begin
    if not silent then
      ErrorMessageBox(Format(_lc[I_MSG_RES_NAME_64],
                             [ResourceName]));
    ok := False;
  end;

  if ok then
  begin
    a := -1;
    if aWAD = _lc[I_WAD_SPECIAL_TEXS] then
    begin
      a := MainForm.lbTextureList.Items.Add(ResourceName);
      if not silent then
        SelectTexture(a);
      Result := True;
      Exit;
    end;

    FullResourceName := FileName+':'+SectionName+'\'+aTex;

    if IsAnim(FullResourceName) then
      begin // ����. ��������
        GetFrame(FullResourceName, Data, Width, Height);

        if g_CreateTextureMemorySize(Data, ResourceName, 0, 0, Width, Height, 1) then
          a := MainForm.lbTextureList.Items.Add(ResourceName);
      end
    else // ������� ��������
      begin
        if g_CreateTextureWAD(ResourceName, FullResourceName) then
          a := MainForm.lbTextureList.Items.Add(ResourceName);
      end;
    if (a > -1) and (not silent) then
      SelectTexture(a);
  end;

  Result := ok;
end;

procedure UpdateCaption(sMap, sFile, sRes: String);
begin
  with MainForm do
    if (sFile = '') and (sRes = '') and (sMap = '') then
      Caption := FormCaption
    else
      if sMap = '' then
        Caption := Format('%s - %s:%s', [FormCaption, sFile, sRes])
      else
        if (sFile <> '') and (sRes <> '') then
          Caption := Format('%s - %s (%s:%s)', [FormCaption, sMap, sFile, sRes])
        else
          Caption := Format('%s - %s', [FormCaption, sMap]);
end;

procedure OpenMap(FileName: String; mapN: String);
var
  MapName: String;
  idx: Integer;
begin
  SelectMapForm.GetMaps(FileName);

  if (FileName = OpenedWAD) and
     (OpenedMap <> '') then
  begin
    MapName := OpenedMap;
    while (Pos(':\', MapName) > 0) do
      Delete(MapName, 1, Pos(':\', MapName) + 1);

    idx := SelectMapForm.lbMapList.Items.IndexOf(MapName);
    SelectMapForm.lbMapList.ItemIndex := idx;
  end;

  if mapN = '' then
    idx := -1
  else
    idx := SelectMapForm.lbMapList.Items.IndexOf(mapN);

  if idx < 0 then
  begin
    if (SelectMapForm.ShowModal() = mrOK) and
       (SelectMapForm.lbMapList.ItemIndex <> -1) then
      idx := SelectMapForm.lbMapList.ItemIndex
    else
      Exit;
  end;

  MapName := SelectMapForm.lbMapList.Items[idx];

  with MainForm do
  begin
    FullClear();

    pLoadProgress.Left := (RenderPanel.Width div 2)-(pLoadProgress.Width div 2);
    pLoadProgress.Top := (RenderPanel.Height div 2)-(pLoadProgress.Height div 2);
    pLoadProgress.Show();

    OpenedMap := FileName+':\'+MapName;
    OpenedWAD := FileName;

    idx := RecentFiles.IndexOf(OpenedMap);
  // ����� ����� ��� ������� �����������:
    if idx >= 0 then
      RecentFiles.Delete(idx);
    RecentFiles.Insert(0, OpenedMap);
    RefreshRecentMenu();

    LoadMap(OpenedMap);

    pLoadProgress.Hide();
    FormResize(nil);

    lbTextureList.Sorted := True;
    lbTextureList.Sorted := False;

    UpdateCaption(gMapInfo.Name, ExtractFileName(FileName), MapName);
  end;
end;

procedure MoveSelectedObjects(Wall, alt: Boolean; dx, dy: Integer);
var
  okX, okY: Boolean;
  a: Integer;
begin
  if SelectedObjects = nil then
    Exit;

  okX := True;
  okY := True;

  if Wall then
    for a := 0 to High(SelectedObjects) do
      if SelectedObjects[a].Live then
      begin
        if ObjectCollideLevel(SelectedObjects[a].ID, SelectedObjects[a].ObjectType, dx, 0) then
          okX := False;

        if ObjectCollideLevel(SelectedObjects[a].ID, SelectedObjects[a].ObjectType, 0, dy) then
          okY := False;

        if (not okX) or (not okY) then
          Break;
      end;

  if okX or okY then
  begin
    for a := 0 to High(SelectedObjects) do
      if SelectedObjects[a].Live then
      begin
        if okX then
          MoveObject(SelectedObjects[a].ObjectType, SelectedObjects[a].ID, dx, 0);

        if okY then
          MoveObject(SelectedObjects[a].ObjectType, SelectedObjects[a].ID, 0, dy);

        if alt and (SelectedObjects[a].ObjectType = OBJECT_TRIGGER) then
        begin
          if gTriggers[SelectedObjects[a].ID].TriggerType in [TRIGGER_PRESS,
               TRIGGER_ON, TRIGGER_OFF, TRIGGER_ONOFF] then
          begin // ������� ���� �����������
            if okX then
              gTriggers[SelectedObjects[a].ID].Data.tX := gTriggers[SelectedObjects[a].ID].Data.tX+dx;
            if okY then
              gTriggers[SelectedObjects[a].ID].Data.tY := gTriggers[SelectedObjects[a].ID].Data.tY+dy;
          end;

          if gTriggers[SelectedObjects[a].ID].TriggerType in [TRIGGER_TELEPORT] then
          begin // ������� ����� ���������� ���������
            if okX then
              gTriggers[SelectedObjects[a].ID].Data.TargetPoint.X := gTriggers[SelectedObjects[a].ID].Data.TargetPoint.X+dx;
            if okY then
              gTriggers[SelectedObjects[a].ID].Data.TargetPoint.Y := gTriggers[SelectedObjects[a].ID].Data.TargetPoint.Y+dy;
          end;

          if gTriggers[SelectedObjects[a].ID].TriggerType in [TRIGGER_SPAWNMONSTER] then
          begin // ������� ����� �������� �������
            if okX then
              gTriggers[SelectedObjects[a].ID].Data.MonPos.X := gTriggers[SelectedObjects[a].ID].Data.MonPos.X+dx;
            if okY then
              gTriggers[SelectedObjects[a].ID].Data.MonPos.Y := gTriggers[SelectedObjects[a].ID].Data.MonPos.Y+dy;
          end;

          if gTriggers[SelectedObjects[a].ID].TriggerType in [TRIGGER_SPAWNITEM] then
          begin // ������� ����� �������� ��������
            if okX then
              gTriggers[SelectedObjects[a].ID].Data.ItemPos.X := gTriggers[SelectedObjects[a].ID].Data.ItemPos.X+dx;
            if okY then
              gTriggers[SelectedObjects[a].ID].Data.ItemPos.Y := gTriggers[SelectedObjects[a].ID].Data.ItemPos.Y+dy;
          end;

          if gTriggers[SelectedObjects[a].ID].TriggerType in [TRIGGER_SHOT] then
          begin // ������� ����� �������� ��������
            if okX then
              gTriggers[SelectedObjects[a].ID].Data.ShotPos.X := gTriggers[SelectedObjects[a].ID].Data.ShotPos.X+dx;
            if okY then
              gTriggers[SelectedObjects[a].ID].Data.ShotPos.Y := gTriggers[SelectedObjects[a].ID].Data.ShotPos.Y+dy;
          end;
        end;
      end;

    LastMovePoint := MousePos;
  end;
end;

procedure ShowLayer(Layer: Byte; show: Boolean);
begin
  LayerEnabled[Layer] := show;

  case Layer of
    LAYER_BACK:
      begin
        MainForm.miLayer1.Checked := show;
        MainForm.miLayerP1.Checked := show;
      end;
    LAYER_WALLS:
      begin
        MainForm.miLayer2.Checked := show;
        MainForm.miLayerP2.Checked := show;
      end;
    LAYER_FOREGROUND:
      begin
        MainForm.miLayer3.Checked := show;
        MainForm.miLayerP3.Checked := show;
      end;
    LAYER_STEPS:
      begin
        MainForm.miLayer4.Checked := show;
        MainForm.miLayerP4.Checked := show;
      end;
    LAYER_WATER:
      begin
        MainForm.miLayer5.Checked := show;
        MainForm.miLayerP5.Checked := show;
      end;
    LAYER_ITEMS:
      begin
        MainForm.miLayer6.Checked := show;
        MainForm.miLayerP6.Checked := show;
      end;
    LAYER_MONSTERS:
      begin
        MainForm.miLayer7.Checked := show;
        MainForm.miLayerP7.Checked := show;
      end;
    LAYER_AREAS:
      begin
        MainForm.miLayer8.Checked := show;
        MainForm.miLayerP8.Checked := show;
      end;
    LAYER_TRIGGERS:
      begin
        MainForm.miLayer9.Checked := show;
        MainForm.miLayerP9.Checked := show;
      end;
  end;

  RemoveSelectFromObjects();
end;

procedure SwitchLayer(Layer: Byte);
begin
  ShowLayer(Layer, not LayerEnabled[Layer]);
end;

procedure SwitchMap();
begin
  ShowMap := not ShowMap;
  MainForm.tbShowMap.Down := ShowMap;
end;

procedure ShowEdges();
begin
  if drEdge[3] < 255 then
    drEdge[3] := 255
  else
    drEdge[3] := gAlphaEdge;
end;

function SelectedTexture(): String;
begin
  if MainForm.lbTextureList.ItemIndex <> -1 then
    Result := MainForm.lbTextureList.Items[MainForm.lbTextureList.ItemIndex]
  else
    Result := '';
end;

function IsSpecialTextureSel(): Boolean;
begin
  Result := (MainForm.lbTextureList.ItemIndex <> -1) and
            IsSpecialTexture(MainForm.lbTextureList.Items[MainForm.lbTextureList.ItemIndex]);
end;

function CopyBufferToString(var CopyBuf: TCopyRecArray): String;
var
  i, j: Integer;
  Res: String;

  procedure AddInt(x: Integer);
  begin
    Res := Res + IntToStr(x) + ' ';
  end;

begin
  Result := '';

  if Length(CopyBuf) = 0 then
    Exit;

  Res := CLIPBOARD_SIG + ' ';

  for i := 0 to High(CopyBuf) do
  begin
    if (CopyBuf[i].ObjectType = OBJECT_PANEL) and
       (CopyBuf[i].Panel = nil) then
      Continue;

  // ��� �������:
    AddInt(CopyBuf[i].ObjectType);
    Res := Res + '; ';

  // �������� �������:
    case CopyBuf[i].ObjectType of
      OBJECT_PANEL:
        with CopyBuf[i].Panel^ do
        begin
          AddInt(PanelType);
          AddInt(X);
          AddInt(Y);
          AddInt(Width);
          AddInt(Height);
          Res := Res + '"' + TextureName + '" ';
          AddInt(Alpha);
          AddInt(IfThen(Blending, 1, 0));
        end;

      OBJECT_ITEM:
        with CopyBuf[i].Item do
        begin
          AddInt(ItemType);
          AddInt(X);
          AddInt(Y);
          AddInt(IfThen(OnlyDM, 1, 0));
          AddInt(IfThen(Fall, 1, 0));
        end;

      OBJECT_MONSTER:
        with CopyBuf[i].Monster do
        begin
          AddInt(MonsterType);
          AddInt(X);
          AddInt(Y);
          AddInt(IfThen(Direction = D_LEFT, 1, 0));
        end;

      OBJECT_AREA:
        with CopyBuf[i].Area do
        begin
          AddInt(AreaType);
          AddInt(X);
          AddInt(Y);
          AddInt(IfThen(Direction = D_LEFT, 1, 0));
        end;

      OBJECT_TRIGGER:
        with CopyBuf[i].Trigger do
        begin
          AddInt(TriggerType);
          AddInt(X);
          AddInt(Y);
          AddInt(Width);
          AddInt(Height);
          AddInt(ActivateType);
          AddInt(Key);
          AddInt(IfThen(Enabled, 1, 0));
          AddInt(TexturePanel);

          for j := 0 to 127 do
            AddInt(Data.Default[j]);
        end;
    end;
  end;

  Result := Res;
end;

procedure StringToCopyBuffer(Str: String; var CopyBuf: TCopyRecArray);
var
  i, j, t: Integer;

  function GetNext(): String;
  var
    p: Integer;

  begin
    if Str[1] = '"' then
      begin
        Delete(Str, 1, 1);
        p := Pos('"', Str);

        if p = 0 then
          begin
            Result := Str;
            Str := '';
          end
        else
          begin
            Result := Copy(Str, 1, p-1);
            Delete(Str, 1, p);
            Str := Trim(Str);
          end;
      end
    else
      begin
        p := Pos(' ', Str);

        if p = 0 then
          begin
            Result := Str;
            Str := '';
          end
        else
          begin
            Result := Copy(Str, 1, p-1);
            Delete(Str, 1, p);
            Str := Trim(Str);
          end;
      end;
  end;

begin
  Str := Trim(Str);

  if GetNext() <> CLIPBOARD_SIG then
    Exit;

  while Str <> '' do
  begin
  // ��� �������:
    t := StrToIntDef(GetNext(), 0);

    if (t < OBJECT_PANEL) or (t > OBJECT_TRIGGER) or
       (GetNext() <> ';') then
    begin // ���-�� �� �� => ����������:
      t := Pos(';', Str);
      Delete(Str, 1, t);
      Str := Trim(Str);

      Continue;
    end;

    i := Length(CopyBuf);
    SetLength(CopyBuf, i + 1);

    CopyBuf[i].ObjectType := t;
    CopyBuf[i].Panel := nil;

  // �������� �������:
    case t of
      OBJECT_PANEL:
        begin
          New(CopyBuf[i].Panel);
          
          with CopyBuf[i].Panel^ do
          begin
            PanelType := StrToIntDef(GetNext(), PANEL_WALL);
            X := StrToIntDef(GetNext(), 0);
            Y := StrToIntDef(GetNext(), 0);
            Width := StrToIntDef(GetNext(), 16);
            Height := StrToIntDef(GetNext(), 16);
            TextureName := GetNext();
            Alpha := StrToIntDef(GetNext(), 0);
            Blending := (GetNext() = '1');
          end;
        end;

      OBJECT_ITEM:
        with CopyBuf[i].Item do
        begin
          ItemType := StrToIntDef(GetNext(), ITEM_MEDKIT_SMALL);
          X := StrToIntDef(GetNext(), 0);
          Y := StrToIntDef(GetNext(), 0);
          OnlyDM := (GetNext() = '1');
          Fall := (GetNext() = '1');
        end;

      OBJECT_MONSTER:
        with CopyBuf[i].Monster do
        begin
          MonsterType := StrToIntDef(GetNext(), MONSTER_DEMON);
          X := StrToIntDef(GetNext(), 0);
          Y := StrToIntDef(GetNext(), 0);

          if GetNext() = '1' then
            Direction := D_LEFT
          else
            Direction := D_RIGHT;
        end;

      OBJECT_AREA:
        with CopyBuf[i].Area do
        begin
          AreaType := StrToIntDef(GetNext(), AREA_PLAYERPOINT1);
          X := StrToIntDef(GetNext(), 0);
          Y := StrToIntDef(GetNext(), 0);
          if GetNext() = '1' then
            Direction := D_LEFT
          else
            Direction := D_RIGHT;
        end;

      OBJECT_TRIGGER:
        with CopyBuf[i].Trigger do
        begin
          TriggerType := StrToIntDef(GetNext(), TRIGGER_EXIT);
          X := StrToIntDef(GetNext(), 0);
          Y := StrToIntDef(GetNext(), 0);
          Width := StrToIntDef(GetNext(), 16);
          Height := StrToIntDef(GetNext(), 16);
          ActivateType := StrToIntDef(GetNext(), 0);
          Key := StrToIntDef(GetNext(), 0);
          Enabled := (GetNext() = '1');
          TexturePanel := StrToIntDef(GetNext(), 0);

          for j := 0 to 127 do
            Data.Default[j] := StrToIntDef(GetNext(), 0);
        end;
    end;
  end;
end;

//----------------------------------------
//����������� ��������������� ���������
//----------------------------------------

procedure TMainForm.RefreshRecentMenu();
var
  i: Integer;
  MI: TMenuItem;
begin
// ������ ����������� �����:
  while RecentFiles.Count > RecentCount do
    RecentFiles.Delete(RecentFiles.Count-1);

// ������ ������ ����:
  while MainMenu.Items[0].Count > RECENT_FILES_MENU_START do
    MainMenu.Items[0].Delete(MainMenu.Items[0].Count-1);

// ��������� ������ ���� �� ������ "�����":
  if RecentFiles.Count > 0 then
  begin
    MI := TMenuItem.Create(MainMenu.Items[0]);
    MI.Caption := '-';
    MainMenu.Items[0].Add(MI);
  end;

// ���������� � ���� ������ ����������� ����:
  for i := 0 to RecentFiles.Count-1 do
  begin
    MI := TMenuItem.Create(MainMenu.Items[0]);
    MI.Caption := IntToStr(i+1) + '  ' + RecentFiles[i];
    MI.OnClick := aRecentFileExecute;
    MainMenu.Items[0].Add(MI);
  end;
end;

procedure TMainForm.aRecentFileExecute(Sender: TObject);
var
  n, pw: Integer;
  s, fn: String;
begin
  s := LowerCase((Sender as TMenuItem).Caption);
  Delete(s, Pos('&', s), 1);
  s := Trim(Copy(s, 1, 2));
  n := StrToIntDef(s, 0) - 1;

  if (n < 0) or (n >= RecentFiles.Count) then
    Exit;

  s := RecentFiles[n];
  pw := Pos('.wad:\', LowerCase(s));
  
  if pw > 0 then
    begin // Map name included
      fn := Copy(s, 1, pw + 3);
      Delete(s, 1, pw + 5);
      if (FileExists(fn)) then
        OpenMap(fn, s);
    end
  else // Only wad name
    if (FileExists(s)) then
      OpenMap(s, '');
end;

procedure TMainForm.aEditorOptionsExecute(Sender: TObject);
begin
  OptionsForm.ShowModal();
end;

procedure TMainForm.FormCreate(Sender: TObject);
var
  PixelFormat: GLuint;
  pfd: TPIXELFORMATDESCRIPTOR;
  config: TConfig;
  i: Integer;
  s: String;
begin
  Randomize();

  EditorDir := ExtractFilePath(Application.ExeName);

  e_InitLog(EditorDir+'Editor.log', WM_NEWFILE);

  e_WriteLog('Init OpenGL', MSG_NOTIFY);

  InitOpenGL();
  hDC := GetDC(RenderPanel.Handle);

  FillChar(pfd, SizeOf(pfd), 0);
  with pfd do
  begin
    nSize := SizeOf(pfd);
    nVersion := 1;
    dwFlags := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
    dwLayerMask := PFD_MAIN_PLANE;
    iPixelType := PFD_TYPE_RGBA;
    cColorBits := 24;
    cDepthBits := 32;
    iLayerType := PFD_MAIN_PLANE;
  end;
  PixelFormat := ChoosePixelFormat (hDC, @pfd);
  SetPixelFormat(hDC, PixelFormat, @pfd);

  hRC := wglCreateContext(hDC);
  ActivateRenderingContext(hDC, hRC);

  e_InitGL(False);

  gEditorFont := e_SimpleFontCreate('Arial Cyr', 12, FW_BOLD, hDC);

  slInvalidTextures := TStringList.Create;

  e_WriteLog('Loading data', MSG_NOTIFY);
  LoadData();

  ShowLayer(LAYER_BACK, True);
  ShowLayer(LAYER_WALLS, True);
  ShowLayer(LAYER_FOREGROUND, True);
  ShowLayer(LAYER_STEPS, True);
  ShowLayer(LAYER_WATER, True);
  ShowLayer(LAYER_ITEMS, True);
  ShowLayer(LAYER_MONSTERS, True);
  ShowLayer(LAYER_AREAS, True);
  ShowLayer(LAYER_TRIGGERS, True);

  ClearMap();

  FormCaption := MainForm.Caption;
  OpenedMap := '';
  OpenedWAD := '';

  config := TConfig.CreateFile(EditorDir+'\Editor.cfg');

  if config.ReadBool('Editor', 'Maximize', False) then
    WindowState := wsMaximized;
  ShowMap := config.ReadBool('Editor', 'Minimap', False);
  DotEnable := config.ReadBool('Editor', 'DotEnable', True);
  DotColor := config.ReadInt('Editor', 'DotColor', $FFFFFF);
  DotStepOne := config.ReadInt('Editor', 'DotStepOne', 16);
  DotStepTwo := config.ReadInt('Editor', 'DotStepTwo', 8);
  DotStep := config.ReadInt('Editor', 'DotStep', DotStepOne);
  DrawTexturePanel := config.ReadBool('Editor', 'DrawTexturePanel', True);
  DrawPanelSize := config.ReadBool('Editor', 'DrawPanelSize', True);
  BackColor := config.ReadInt('Editor', 'BackColor', $7F6040);
  PreviewColor := config.ReadInt('Editor', 'PreviewColor', $00FF00);
  gColorEdge := config.ReadInt('Editor', 'EdgeColor', COLOR_EDGE);
  gAlphaEdge := config.ReadInt('Editor', 'EdgeAlpha', ALPHA_EDGE);
  if gAlphaEdge = 255 then
    gAlphaEdge := ALPHA_EDGE;
  drEdge[0] := GetRValue(gColorEdge);
  drEdge[1] := GetGValue(gColorEdge);
  drEdge[2] := GetBValue(gColorEdge);
  if not config.ReadBool('Editor', 'EdgeShow', True) then
    drEdge[3] := 255
  else
    drEdge[3] := gAlphaEdge;
  gAlphaTriggerLine := config.ReadInt('Editor', 'LineAlpha', ALPHA_LINE);
  if gAlphaTriggerLine = 255 then
    gAlphaTriggerLine := ALPHA_LINE;
  gAlphaTriggerArea := config.ReadInt('Editor', 'TriggerAlpha', ALPHA_AREA);
  if gAlphaTriggerArea = 255 then
    gAlphaTriggerArea := ALPHA_AREA;
  if config.ReadInt('Editor', 'Scale', 0) = 1 then
    Scale := 2
  else
    Scale := 1;
  if config.ReadInt('Editor', 'DotSize', 0) = 1 then
    DotSize := 2
  else
    DotSize := 1;
  OpenDialog.InitialDir := config.ReadStr('Editor', 'LastOpenDir', EditorDir);
  SaveDialog.InitialDir := config.ReadStr('Editor', 'LastSaveDir', EditorDir);

  s := config.ReadStr('Editor', 'Language', '');
  gLanguage := s;

  RecentCount := config.ReadInt('Editor', 'RecentCount', 5);
  if RecentCount > 10 then
    RecentCount := 10;
  if RecentCount < 2 then
    RecentCount := 2;

  RecentFiles := TStringList.Create();
  for i := 0 to RecentCount-1 do
  begin
    s := config.ReadStr('RecentFiles', IntToStr(i+1), '');
    if s <> '' then
      RecentFiles.Add(s);
  end;
  RefreshRecentMenu();

  config.Free();

  tbShowMap.Down := ShowMap;
  tbGridOn.Down := DotEnable;
  pcObjects.ActivePageIndex := 0;
  Application.Title := _lc[I_EDITOR_TITLE];

  Application.OnIdle := OnIdle;
end;

procedure TMainForm.Draw();
var
  ps: TPaintStruct;
  x, y: Integer;
  a, b: Integer;
  ID: DWORD;
  Width, Height: Word;
  Rect: TRectWH;
  ObjCount: Word;
  aX, aY, aX2, aY2, XX, ScaleSz: Integer;
begin
  BeginPaint(Handle, ps);
  e_BeginRender();

  e_Clear(GL_COLOR_BUFFER_BIT,
          GetRValue(BackColor)/255,
          GetGValue(BackColor)/255,
          GetBValue(BackColor)/255);

  DrawMap();

  ObjCount := SelectedObjectCount();

// ������� ���������� ������� ������� ������:
  if ObjCount > 0 then
  begin
    for a := 0 to High(SelectedObjects) do
      if SelectedObjects[a].Live then
      begin
        Rect := ObjectGetRect(SelectedObjects[a].ObjectType, SelectedObjects[a].ID);

        with Rect do
        begin
          e_DrawQuad(X+MapOffset.X, Y+MapOffset.Y,
                     X+MapOffset.X+Width-1, Y+MapOffset.Y+Height-1,
                     255, 0, 0);

        // ������ ����� ��������� ��������:
          if (ObjCount = 1) and
             (SelectedObjects[GetFirstSelected].ObjectType in [OBJECT_PANEL, OBJECT_TRIGGER]) then
          begin
            e_DrawPoint(5, X+MapOffset.X, Y+MapOffset.Y+(Height div 2), 255, 255, 255);
            e_DrawPoint(5, X+MapOffset.X+Width-1, Y+MapOffset.Y+(Height div 2), 255, 255, 255);
            e_DrawPoint(5, X+MapOffset.X+(Width div 2), Y+MapOffset.Y, 255, 255, 255);
            e_DrawPoint(5, X+MapOffset.X+(Width div 2), Y+MapOffset.Y+Height-1, 255, 255, 255);

            e_DrawPoint(3, X+MapOffset.X, Y+MapOffset.Y+(Height div 2), 255, 0, 0);
            e_DrawPoint(3, X+MapOffset.X+Width-1, Y+MapOffset.Y+(Height div 2), 255, 0, 0);
            e_DrawPoint(3, X+MapOffset.X+(Width div 2), Y+MapOffset.Y, 255, 0, 0);
            e_DrawPoint(3, X+MapOffset.X+(Width div 2), Y+MapOffset.Y+Height-1, 255, 0, 0);
          end;
        end;
      end;
  end;

// ������ �����:
  if DotEnable and (not PreviewMode) then
  begin
    if DotSize = 2 then
      a := -1
    else
      a := 0;

    for x := 0 to (RenderPanel.Width div DotStep) do
      for y := 0 to (RenderPanel.Height div DotStep) do
        e_DrawPoint(DotSize, x*DotStep + a, y*DotStep + a,
                    GetRValue(DotColor),
                    GetGValue(DotColor),
                    GetBValue(DotColor));
  end;

// ������ ��������:
  if (lbTextureList.ItemIndex <> -1) and (cbPreview.Checked) and
     (not IsSpecialTextureSel()) and (not PreviewMode) then
  begin
    if not g_GetTexture(SelectedTexture(), ID) then
      g_GetTexture('NOTEXTURE', ID);
    g_GetTextureSizeByID(ID, Width, Height);
    e_DrawFillQuad(RenderPanel.Width-Width-2, RenderPanel.Height-Height-2,
                   RenderPanel.Width-1, RenderPanel.Height-1,
                   GetRValue(PreviewColor), GetGValue(PreviewColor), GetBValue(PreviewColor), 0);
    e_Draw(ID, RenderPanel.Width-Width-1, RenderPanel.Height-Height-1, 0, True, False);
  end;

// ��������� ��� ������ ����� ���������:
  if SelectFlag = SELECTFLAG_TELEPORT then
  begin
    with gTriggers[SelectedObjects[GetFirstSelected()].ID] do
      if Data.d2d_teleport then
        e_DrawLine(2, MousePos.X-16, MousePos.Y-1,
                   MousePos.X+16, MousePos.Y-1,
                   0, 0, 255)
      else
        e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+AreaSize[AREA_DMPOINT].Width-1,
                   MousePos.Y+AreaSize[AREA_DMPOINT].Height-1, 255, 255, 255);

    e_DrawFillQuad(MousePos.X, MousePos.Y, MousePos.X+180, MousePos.Y+18, 192, 192, 192, 127);
    e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+180, MousePos.Y+18, 255, 255, 255);
    e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(_lc[I_HINT_TELEPORT]), gEditorFont, 0, 0, 0);
  end;

// ��������� ��� ������ ����� ���������:
  if SelectFlag = SELECTFLAG_SPAWNPOINT then
  begin
    e_DrawLine(2, MousePos.X-16, MousePos.Y-1,
               MousePos.X+16, MousePos.Y-1,
               0, 0, 255);
    e_DrawFillQuad(MousePos.X, MousePos.Y, MousePos.X+180, MousePos.Y+18, 192, 192, 192, 127);
    e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+180, MousePos.Y+18, 255, 255, 255);
    e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(_lc[I_HINT_SPAWN]), gEditorFont, 0, 0, 0);
  end;

// ��������� ��� ������ ������ �����:
  if SelectFlag = SELECTFLAG_DOOR then
  begin
    e_DrawFillQuad(MousePos.X, MousePos.Y, MousePos.X+180, MousePos.Y+18, 192, 192, 192, 127);
    e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+180, MousePos.Y+18, 255, 255, 255);
    e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(_lc[I_HINT_PANEL_DOOR]), gEditorFont, 0, 0, 0);
  end;

// ��������� ��� ������ ������ � ���������:
  if SelectFlag = SELECTFLAG_TEXTURE then
  begin
    e_DrawFillQuad(MousePos.X, MousePos.Y, MousePos.X+196, MousePos.Y+18, 192, 192, 192, 127);
    e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+196, MousePos.Y+18, 255, 255, 255);
    e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(_lc[I_HINT_PANEL_TEXTURE]), gEditorFont, 0, 0, 0);
  end;

// ��������� ��� ������ ������ �����:
  if SelectFlag = SELECTFLAG_LIFT then
  begin
    e_DrawFillQuad(MousePos.X, MousePos.Y, MousePos.X+180, MousePos.Y+18, 192, 192, 192, 127);
    e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+180, MousePos.Y+18, 255, 255, 255);
    e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(_lc[I_HINT_PANEL_LIFT]), gEditorFont, 0, 0, 0);
  end;

// ��������� ��� ������ �������:
  if SelectFlag = SELECTFLAG_MONSTER then
  begin
    e_DrawFillQuad(MousePos.X, MousePos.Y, MousePos.X+120, MousePos.Y+18, 192, 192, 192, 127);
    e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+120, MousePos.Y+18, 255, 255, 255);
    e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(_lc[I_HINT_MONSTER]), gEditorFont, 0, 0, 0);
  end;

// ��������� ��� ������ ������� �����������:
  if DrawPressRect then
  begin
    e_DrawFillQuad(MousePos.X, MousePos.Y, MousePos.X+204, MousePos.Y+18, 192, 192, 192, 127);
    e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+204, MousePos.Y+18, 255, 255, 255);
    e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(_lc[I_HINT_EXT_AREA]), gEditorFont, 0, 0, 0);
  end;

// ������ ��������, ���� ������ ������:
  if (MouseAction = MOUSEACTION_DRAWPANEL) and (DrawTexturePanel) and
     (lbTextureList.ItemIndex <> -1) and (DrawRect <> nil) and
     (lbPanelType.ItemIndex in [0..8]) and not IsSpecialTextureSel() then
  begin
    if not g_GetTexture(SelectedTexture(), ID) then
      g_GetTexture('NOTEXTURE', ID);
    g_GetTextureSizeByID(ID, Width, Height);
    with DrawRect^ do
      e_DrawFill(ID, Min(Left, Right), Min(Top, Bottom), Abs(Right-Left) div Width,
                 Abs(Bottom-Top) div Height, 0, True, False);
  end;

// ������������� ���������:
  if DrawRect <> nil then
    with DrawRect^ do
      e_DrawQuad(Left, Top, Right-1, Bottom-1, 255, 255, 255);

// ������ ����� ������/������� ��� ������ ����� �� ������:
  if (MouseAction in [MOUSEACTION_DRAWPANEL, MOUSEACTION_DRAWTRIGGER, MOUSEACTION_RESIZE]) and
     (DrawPanelSize) then
  begin
    e_DrawFillQuad(MousePos.X, MousePos.Y, MousePos.X+88, MousePos.Y+33, 192, 192, 192, 127);
    e_DrawQuad(MousePos.X, MousePos.Y, MousePos.X+88, MousePos.Y+33, 255, 255, 255);

    if MouseAction in [MOUSEACTION_DRAWPANEL, MOUSEACTION_DRAWTRIGGER] then
      begin // ������ �����
        e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(Format(_lc[I_HINT_WIDTH],
                          [Abs(MousePos.X-MouseLDownPos.X)])), gEditorFont, 0, 0, 0);
        e_SimpleFontPrint(MousePos.X+8, MousePos.Y+28, PChar(Format(_lc[I_HINT_HEIGHT],
                          [Abs(MousePos.Y-MouseLDownPos.Y)])), gEditorFont, 0, 0, 0);
      end
    else // ����������� ������������
      if SelectedObjects[GetFirstSelected].ObjectType in [OBJECT_PANEL, OBJECT_TRIGGER] then
      begin
        if SelectedObjects[GetFirstSelected].ObjectType = OBJECT_PANEL then
          begin
            Width := gPanels[SelectedObjects[GetFirstSelected].ID].Width;
            Height := gPanels[SelectedObjects[GetFirstSelected].ID].Height;
          end
        else
          begin
            Width := gTriggers[SelectedObjects[GetFirstSelected].ID].Width;
            Height := gTriggers[SelectedObjects[GetFirstSelected].ID].Height;
          end;

        e_SimpleFontPrint(MousePos.X+8, MousePos.Y+14, PChar(Format(_lc[I_HINT_WIDTH], [Width])),
                          gEditorFont, 0, 0, 0);
        e_SimpleFontPrint(MousePos.X+8, MousePos.Y+28, PChar(Format(_lc[I_HINT_HEIGHT], [Height])),
                          gEditorFont, 0, 0, 0);
      end;
  end;

// ��������� � ������� ���� ����� �� �����:
  e_DrawPoint(3, MousePos.X, MousePos.Y, 0, 0, 255);

// ����-�����:
  if ShowMap and
     ((gMapInfo.Width > RenderPanel.Width) or
      (gMapInfo.Height > RenderPanel.Height)) then
  begin
  // ������� �������� ����� � 1 ������� ����-�����:
    ScaleSz := 16 div Scale;
  // ������� ����-�����:
    aX := max(gMapInfo.Width div ScaleSz, 1);
    aY := max(gMapInfo.Height div ScaleSz, 1);
  // X-���������� �� RenderPanel ������� x-���������� �����: 
    XX := RenderPanel.Width - aX - 1;
  // ����� �����:
    e_DrawFillQuad(XX-1, 0, RenderPanel.Width-1, aY+1, 0, 0, 0, 0);
    e_DrawQuad(XX-1, 0, RenderPanel.Width-1, aY+1, 197, 197, 197);

    if gPanels <> nil then
    begin
    // ������ ������:
      for a := 0 to High(gPanels) do
        with gPanels[a] do
          if PanelType <> 0 then
          begin
          // ����� ������� ����:
            aX := XX + (X div ScaleSz);
            aY := 1 + (Y div ScaleSz);
          // �������:
            aX2 := max(Width div ScaleSz, 1);
            aY2 := max(Height div ScaleSz, 1);
          // ������ ������ ����:
            aX2 := aX + aX2 - 1;
            aY2 := aY + aY2 - 1;

            case PanelType of
              PANEL_WALL:      e_DrawFillQuad(aX, aY, aX2, aY2, 208, 208, 208, 0);
              PANEL_WATER:     e_DrawFillQuad(aX, aY, aX2, aY2,   0,   0, 192, 0);
              PANEL_ACID1:     e_DrawFillQuad(aX, aY, aX2, aY2,   0, 176,   0, 0);
              PANEL_ACID2:     e_DrawFillQuad(aX, aY, aX2, aY2, 176,   0,   0, 0);
              PANEL_STEP:      e_DrawFillQuad(aX, aY, aX2, aY2, 128, 128, 128, 0);
              PANEL_LIFTUP:    e_DrawFillQuad(aX, aY, aX2, aY2, 116,  72,  36, 0);
              PANEL_LIFTDOWN:  e_DrawFillQuad(aX, aY, aX2, aY2, 116, 124,  96, 0);
              PANEL_LIFTLEFT:  e_DrawFillQuad(aX, aY, aX2, aY2, 200,  80,   4, 0);
              PANEL_LIFTRIGHT: e_DrawFillQuad(aX, aY, aX2, aY2, 252, 140,  56, 0);
              PANEL_OPENDOOR:  e_DrawFillQuad(aX, aY, aX2, aY2, 100, 220,  92, 0);
              PANEL_CLOSEDOOR: e_DrawFillQuad(aX, aY, aX2, aY2, 212, 184,  64, 0);
              PANEL_BLOCKMON:  e_DrawFillQuad(aX, aY, aX2, aY2, 192,   0, 192, 0);
            end;
          end;

    // ������ ������� ���������� ������:
      if SelectedObjects <> nil then
        for b := 0 to High(SelectedObjects) do
          with SelectedObjects[b] do
            if Live and (ObjectType = OBJECT_PANEL) then
              with gPanels[SelectedObjects[b].ID] do
                if PanelType and not(PANEL_BACK or PANEL_FORE) <> 0 then
                begin
                // ����� ������� ����:
                  aX := XX + (X div ScaleSz);
                  aY := 1 + (Y div ScaleSz);
                // �������:
                  aX2 := max(Width div ScaleSz, 1);
                  aY2 := max(Height div ScaleSz, 1);
                // ������ ������ ����:
                  aX2 := aX + aX2 - 1;
                  aY2 := aY + aY2 - 1;

                  e_DrawFillQuad(aX, aY, aX2, aY2, 255, 0, 0, 0)
                end;
    end;

  // ����, ������������ ������� ��������� ������ �� �����:
  // ������� ����:
    x := max(min(RenderPanel.Width, gMapInfo.Width) div ScaleSz, 1);
    y := max(min(RenderPanel.Height, gMapInfo.Height) div ScaleSz, 1);
  // ����� ������� ����:
    aX := XX + ((-MapOffset.X) div ScaleSz);
    aY := 1 + ((-MapOffset.Y) div ScaleSz);
  // ������ ������ ����:
    aX2 := aX + x - 1;
    aY2 := aY + y - 1;
    
    e_DrawFillQuad(aX, aY, aX2, aY2, 127, 192, 127, 127, B_BLEND);
    e_DrawQuad(aX, aY, aX2, aY2, 255, 0, 0);
  end; // ����-�����

  e_EndRender();
  SwapBuffers(hDC);
  EndPaint(Handle, ps);
end;

procedure TMainForm.FormResize(Sender: TObject);
begin
  e_SetViewPort(0, 0, RenderPanel.Width, RenderPanel.Height);

  if gMapInfo.Width >= RenderPanel.Width then
    sbHorizontal.Max := Normalize16(gMapInfo.Width-RenderPanel.Width+16)
  else
    sbHorizontal.Max := 0;

  if gMapInfo.Height >= RenderPanel.Height then
    sbVertical.Max := Normalize16(gMapInfo.Height-RenderPanel.Height+16)
  else
    sbVertical.Max := 0;

  MapOffset.X := -Normalize16(sbHorizontal.Position);
  MapOffset.Y := -Normalize16(sbVertical.Position);
end;

procedure SelectNextObject(X, Y: Integer; ObjectType: Byte; ID: DWORD);
var
  j, j_max: Integer;
  res: Boolean;
begin
  j_max := 0; // shut up compiler
  case ObjectType of
    OBJECT_PANEL:
      begin
        res := (gPanels <> nil) and
               PanelInShownLayer(gPanels[ID].PanelType) and
               g_CollidePoint(X, Y, gPanels[ID].X, gPanels[ID].Y,
                              gPanels[ID].Width,
                              gPanels[ID].Height);
        j_max := Length(gPanels) - 1;
      end;

    OBJECT_ITEM:
      begin
        res := (gItems <> nil) and
               LayerEnabled[LAYER_ITEMS] and
               g_CollidePoint(X, Y, gItems[ID].X, gItems[ID].Y,
                              ItemSize[gItems[ID].ItemType][0],
                              ItemSize[gItems[ID].ItemType][1]);
        j_max := Length(gItems) - 1;
      end;

    OBJECT_MONSTER:
      begin
        res := (gMonsters <> nil) and
               LayerEnabled[LAYER_MONSTERS] and
               g_CollidePoint(X, Y, gMonsters[ID].X, gMonsters[ID].Y,
                              MonsterSize[gMonsters[ID].MonsterType].Width,
                              MonsterSize[gMonsters[ID].MonsterType].Height);
        j_max := Length(gMonsters) - 1;
      end;

    OBJECT_AREA:
      begin
        res := (gAreas <> nil) and
               LayerEnabled[LAYER_AREAS] and
               g_CollidePoint(X, Y, gAreas[ID].X, gAreas[ID].Y,
                              AreaSize[gAreas[ID].AreaType].Width,
                              AreaSize[gAreas[ID].AreaType].Height);
        j_max := Length(gAreas) - 1;
      end;

    OBJECT_TRIGGER:
      begin
        res := (gTriggers <> nil) and
               LayerEnabled[LAYER_TRIGGERS] and 
               g_CollidePoint(X, Y, gTriggers[ID].X, gTriggers[ID].Y,
                              gTriggers[ID].Width,
                              gTriggers[ID].Height);
        j_max := Length(gTriggers) - 1;
      end;

    else
      res := False;
  end;

  if not res then
    Exit;

// ������� ID: �� ID-1 �� 0; ����� �� High �� ID+1:
  j := ID;
  
  while True do
  begin
    Dec(j);
            
    if j < 0 then
      j := j_max;
    if j = Integer(ID) then
      Break;

    case ObjectType of
      OBJECT_PANEL:
        res := PanelInShownLayer(gPanels[j].PanelType) and
               g_CollidePoint(X, Y, gPanels[j].X, gPanels[j].Y,
                              gPanels[j].Width,
                              gPanels[j].Height);
      OBJECT_ITEM:
        res := (gItems[j].ItemType <> ITEM_NONE) and
               g_CollidePoint(X, Y, gItems[j].X, gItems[j].Y,
                              ItemSize[gItems[j].ItemType][0],
                              ItemSize[gItems[j].ItemType][1]);
      OBJECT_MONSTER:
        res := (gMonsters[j].MonsterType <> MONSTER_NONE) and
               g_CollidePoint(X, Y, gMonsters[j].X, gMonsters[j].Y,
                              MonsterSize[gMonsters[j].MonsterType].Width,
                              MonsterSize[gMonsters[j].MonsterType].Height);
      OBJECT_AREA:
        res := (gAreas[j].AreaType <> AREA_NONE) and
               g_CollidePoint(X, Y, gAreas[j].X, gAreas[j].Y,
                              AreaSize[gAreas[j].AreaType].Width,
                              AreaSize[gAreas[j].AreaType].Height);
      OBJECT_TRIGGER:
        res := (gTriggers[j].TriggerType <> TRIGGER_NONE) and
               g_CollidePoint(X, Y, gTriggers[j].X, gTriggers[j].Y,
                              gTriggers[j].Width,
                              gTriggers[j].Height);
      else
        res := False;
    end;
    
    if res then
    begin
      SetLength(SelectedObjects, 1);

      SelectedObjects[0].ObjectType := ObjectType;
      SelectedObjects[0].ID := j;
      SelectedObjects[0].Live := True;

      FillProperty();
      Break;
    end;
  end;
end;

procedure TMainForm.RenderPanelMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  i: Integer;
  Rect: TRectWH;
  c1, c2, c3, c4: Boolean;
  item: TItem;
  area: TArea;
  monster: TMonster;
  IDArray: DWArray;
begin
  MainForm.ActiveControl := RenderPanel;
  RenderPanel.SetFocus();

  RenderPanelMouseMove(RenderPanel, Shift, X, Y);

  if Button = mbLeft then // Left Mouse Button
  begin
  // ������� ����� � ������� ���� � ����-�����:
    if ShowMap and
       ((gMapInfo.Width > RenderPanel.Width) or
        (gMapInfo.Height > RenderPanel.Height)) and
       g_CollidePoint(X, Y,
                      RenderPanel.Width-max(gMapInfo.Width div (16 div Scale), 1)-1,
                      1,
                      max(gMapInfo.Width div (16 div Scale), 1),
                      max(gMapInfo.Height div (16 div Scale), 1) ) then
      begin
        MoveMap(X, Y);
        MouseAction := MOUSEACTION_MOVEMAP;
      end
    else // ������ �������/�������/�������:
      if (pcObjects.ActivePageIndex in [1, 2, 3]) and
         (not (ssShift in Shift)) then
        begin
          case pcObjects.ActivePageIndex of
            1:
              if lbItemList.ItemIndex = -1 then
                ErrorMessageBox(_lc[I_MSG_CHOOSE_ITEM])
              else
                begin
                  item.ItemType := lbItemList.ItemIndex + ITEM_MEDKIT_SMALL;
                  if item.ItemType >= ITEM_WEAPON_KASTET then
                    item.ItemType := item.ItemType + 2;
                  item.X := MousePos.X-MapOffset.X;
                  item.Y := MousePos.Y-MapOffset.Y;

                  if not (ssCtrl in Shift) then
                  begin
                    item.X := item.X - (ItemSize[item.ItemType][0] div 2);
                    item.Y := item.Y - ItemSize[item.ItemType][1];
                  end;

                  item.OnlyDM := cbOnlyDM.Checked;
                  item.Fall := cbFall.Checked;
                  Undo_Add(OBJECT_ITEM, AddItem(item));
                end;
            2:
              if lbMonsterList.ItemIndex = -1 then
                ErrorMessageBox(_lc[I_MSG_CHOOSE_MONSTER])
              else
                begin
                  monster.MonsterType := lbMonsterList.ItemIndex + MONSTER_DEMON;
                  monster.X := MousePos.X-MapOffset.X;
                  monster.Y := MousePos.Y-MapOffset.Y;

                  if not (ssCtrl in Shift) then
                  begin
                    monster.X := monster.X - (MonsterSize[monster.MonsterType].Width div 2);
                    monster.Y := monster.Y - MonsterSize[monster.MonsterType].Height;
                  end;

                  if rbMonsterLeft.Checked then
                    monster.Direction := D_LEFT
                  else
                    monster.Direction := D_RIGHT;
                  Undo_Add(OBJECT_MONSTER, AddMonster(monster));
                end;
            3:
              if lbAreasList.ItemIndex = -1 then
                ErrorMessageBox(_lc[I_MSG_CHOOSE_AREA])
              else
                if (lbAreasList.ItemIndex + 1) <> AREA_DOMFLAG then
                  begin
                    area.AreaType := lbAreasList.ItemIndex + AREA_PLAYERPOINT1;
                    area.X := MousePos.X-MapOffset.X;
                    area.Y := MousePos.Y-MapOffset.Y;

                    if not (ssCtrl in Shift) then
                    begin
                      area.X := area.X - (AreaSize[area.AreaType].Width div 2);
                      area.Y := area.Y - AreaSize[area.AreaType].Height;
                    end;

                    if rbAreaLeft.Checked then
                      area.Direction := D_LEFT
                    else
                      area.Direction := D_RIGHT;
                    Undo_Add(OBJECT_AREA, AddArea(area));
                  end
                else
                  Beep();
          end;
        end
      else
        begin
          i := GetFirstSelected();

        // �������� ������ ��� �������:
          if (SelectedObjects <> nil) and
             (ssShift in Shift) and (i >= 0) and
             (SelectedObjects[i].Live) then
            begin
              if SelectedObjectCount() = 1 then
                SelectNextObject(X-MapOffset.X, Y-MapOffset.Y,
                                 SelectedObjects[i].ObjectType,
                                 SelectedObjects[i].ID);
            end
          else
            begin
            // ������ ������� �������� "�����������":
              if DrawPressRect and (i >= 0) and
                 (SelectedObjects[i].ObjectType = OBJECT_TRIGGER) and
                 (gTriggers[SelectedObjects[i].ID].TriggerType in
                   [TRIGGER_PRESS, TRIGGER_ON, TRIGGER_OFF, TRIGGER_ONOFF]) then
                MouseAction := MOUSEACTION_DRAWPRESS
              else // ������ ������:
                if pcObjects.ActivePageIndex = 0 then
                  begin
                    if (lbPanelType.ItemIndex >= 0) then
                      MouseAction := MOUSEACTION_DRAWPANEL
                  end
                else // ������ �������:
                  if (lbTriggersList.ItemIndex >= 0) then
                  begin
                    MouseAction := MOUSEACTION_DRAWTRIGGER;
                  end;
            end;
        end;
  end; // if Button = mbLeft

  if Button = mbRight then // Right Mouse Button
  begin
  // ���� �� ����-�����:
    if ShowMap and
       ((gMapInfo.Width > RenderPanel.Width) or
        (gMapInfo.Height > RenderPanel.Height)) and
       g_CollidePoint(X, Y,
                      RenderPanel.Width-max(gMapInfo.Width div (16 div Scale), 1)-1,
                      1,
                      max(gMapInfo.Width div (16 div Scale), 1),
                      max(gMapInfo.Height div (16 div Scale), 1) ) then
      begin
        MouseAction := MOUSEACTION_NOACTION;
      end
    else // ����� ���-�� ������� �����:
      if SelectFlag <> SELECTFLAG_NONE then
        begin
          case SelectFlag of
            SELECTFLAG_TELEPORT:
            // ����� ���������� ������������:
              with gTriggers[SelectedObjects[
                     GetFirstSelected() ].ID].Data.TargetPoint do
              begin
                X := MousePos.X-MapOffset.X;
                Y := MousePos.Y-MapOffset.Y;
              end;

            SELECTFLAG_SPAWNPOINT:
            // ����� �������� �������:
              with gTriggers[SelectedObjects[GetFirstSelected()].ID] do
                if TriggerType = TRIGGER_SPAWNMONSTER then
                  begin
                    Data.MonPos.X := MousePos.X-MapOffset.X;
                    Data.MonPos.Y := MousePos.Y-MapOffset.Y;
                  end
                else if TriggerType = TRIGGER_SPAWNITEM then
                  begin // ����� �������� ��������:
                    Data.ItemPos.X := MousePos.X-MapOffset.X;
                    Data.ItemPos.Y := MousePos.Y-MapOffset.Y;
                  end
                else if TriggerType = TRIGGER_SHOT then
                  begin // ����� �������� ��������:
                    Data.ShotPos.X := MousePos.X-MapOffset.X;
                    Data.ShotPos.Y := MousePos.Y-MapOffset.Y;
                  end;

            SELECTFLAG_DOOR:
            // �����:
              begin
                IDArray := ObjectInRect(MousePos.X-MapOffset.X,
                                        MousePos.Y-MapOffset.Y,
                                        2, 2, OBJECT_PANEL, True);
                if IDArray <> nil then
                  begin
                    for i := 0 to High(IDArray) do
                      if (gPanels[IDArray[i]].PanelType = PANEL_OPENDOOR) or
                         (gPanels[IDArray[i]].PanelType = PANEL_CLOSEDOOR) then
                      begin
                        gTriggers[SelectedObjects[
                          GetFirstSelected() ].ID].Data.PanelID := IDArray[i];
                        Break;
                      end;
                  end
                else
                  gTriggers[SelectedObjects[
                    GetFirstSelected() ].ID].Data.PanelID := -1;
              end;

            SELECTFLAG_TEXTURE:
            // ������ � ���������:
              begin
                IDArray := ObjectInRect(MousePos.X-MapOffset.X,
                             MousePos.Y-MapOffset.Y,
                             2, 2, OBJECT_PANEL, True);
                if IDArray <> nil then
                  begin
                    for i := 0 to High(IDArray) do
                      if ((gPanels[IDArray[i]].PanelType in
                           [PANEL_WALL, PANEL_BACK, PANEL_FORE,
                            PANEL_WATER, PANEL_ACID1, PANEL_ACID2,
                            PANEL_STEP]) or
                          (gPanels[IDArray[i]].PanelType = PANEL_OPENDOOR) or
                          (gPanels[IDArray[i]].PanelType = PANEL_CLOSEDOOR)) and
                         (gPanels[IDArray[i]].TextureName <> '') then
                      begin
                        gTriggers[SelectedObjects[
                          GetFirstSelected() ].ID].TexturePanel := IDArray[i];
                        Break;
                      end;
                  end
                else
                  gTriggers[SelectedObjects[
                    GetFirstSelected() ].ID].TexturePanel := -1;
              end;

            SELECTFLAG_LIFT:
            // ����:
              begin
                IDArray := ObjectInRect(MousePos.X-MapOffset.X,
                                        MousePos.Y-MapOffset.Y,
                                        2, 2, OBJECT_PANEL, True);
                if IDArray <> nil then
                  begin
                    for i := 0 to High(IDArray) do
                      if (gPanels[IDArray[i]].PanelType = PANEL_LIFTUP) or
                         (gPanels[IDArray[i]].PanelType = PANEL_LIFTDOWN) or
                         (gPanels[IDArray[i]].PanelType = PANEL_LIFTLEFT) or
                         (gPanels[IDArray[i]].PanelType = PANEL_LIFTRIGHT) then
                      begin
                        gTriggers[SelectedObjects[
                          GetFirstSelected() ].ID].Data.PanelID := IDArray[i];
                        Break;
                      end;
                  end
                else
                  gTriggers[SelectedObjects[
                    GetFirstSelected() ].ID].Data.PanelID := -1;
              end;

            SELECTFLAG_MONSTER:
            // �������:
              begin
                IDArray := ObjectInRect(MousePos.X-MapOffset.X,
                                        MousePos.Y-MapOffset.Y,
                                        2, 2, OBJECT_MONSTER, False);
                if IDArray <> nil then
                  gTriggers[SelectedObjects[
                    GetFirstSelected() ].ID].Data.MonsterID := IDArray[0]+1
                else
                  gTriggers[SelectedObjects[
                    GetFirstSelected() ].ID].Data.MonsterID := 0;
              end;
          end;

          SelectFlag := SELECTFLAG_SELECTED;
        end
      else // if SelectFlag <> SELECTFLAG_NONE...
        begin
        // ��� ��� ������� � �� ����� Ctrl:
          if (SelectedObjects <> nil) and
             (not (ssCtrl in Shift)) then
            for i := 0 to High(SelectedObjects) do
              with SelectedObjects[i] do
                if Live then
                begin
                  if (ObjectType in [OBJECT_PANEL, OBJECT_TRIGGER]) and
                     (SelectedObjectCount() = 1) then
                  begin
                    Rect := ObjectGetRect(ObjectType, ID);

                    c1 := g_Collide(X-MapOffset.X-1, Y-MapOffset.Y-1, 2, 2,
                            Rect.X-2, Rect.Y+(Rect.Height div 2)-2, 4, 4);
                    c2 := g_Collide(X-MapOffset.X-1, Y-MapOffset.Y-1, 2, 2,
                            Rect.X+Rect.Width-3, Rect.Y+(Rect.Height div 2)-2, 4, 4);
                    c3 := g_Collide(X-MapOffset.X-1, Y-MapOffset.Y-1, 2, 2,
                            Rect.X+(Rect.Width div 2)-2, Rect.Y-2, 4, 4);
                    c4 := g_Collide(X-MapOffset.X-1, Y-MapOffset.Y-1, 2, 2,
                            Rect.X+(Rect.Width div 2)-2, Rect.Y+Rect.Height-3, 4, 4);

                  // ������ ������ ������ ��� ��������:
                    if c1 or c2 or c3 or c4 then
                    begin
                      MouseAction := MOUSEACTION_RESIZE;
                      LastMovePoint := MousePos;

                      if c1 or c2 then
                        begin // ����/���
                          ResizeType := RESIZETYPE_HORIZONTAL;
                          if c1 then
                            ResizeDirection := RESIZEDIR_LEFT
                          else
                            ResizeDirection := RESIZEDIR_RIGHT;
                          RenderPanel.Cursor := crSizeWE;
                        end
                      else
                        begin // ����/����
                          ResizeType := RESIZETYPE_VERTICAL;
                          if c3 then
                            ResizeDirection := RESIZEDIR_UP
                          else
                            ResizeDirection := RESIZEDIR_DOWN;
                          RenderPanel.Cursor := crSizeNS;
                        end;

                      Break;
                    end;
                  end;

                // ���������� ������ ��� �������:
                  if ObjectCollide(ObjectType, ID,
                       MousePos.X-MapOffset.X-1,
                       MousePos.Y-MapOffset.Y-1, 2, 2) then
                  begin
                    MouseAction := MOUSEACTION_MOVEOBJ;
                    LastMovePoint := MousePos;

                    Break;
                  end;
                end;
        end;
  end; // if Button = mbRight

  MouseRDown := Button = mbRight;
  if MouseRDown then
    MouseRDownPos := MousePos;

  MouseLDown := Button = mbLeft;
  if MouseLDown then
    MouseLDownPos := MousePos;
end;

procedure TMainForm.RenderPanelMouseUp(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  panel: TPanel;
  trigger: TTrigger;
  i: Integer;
  IDArray: DWArray;
  rRect: TRectWH;
  rSelectRect: Boolean;
begin
  if Button = mbLeft then
    MouseLDown := False;
  if Button = mbRight then
    MouseRDown := False;

  DrawRect := nil;
  ResizeType := RESIZETYPE_NONE;

  if Button = mbLeft then // Left Mouse Button
    begin
      if MouseAction <> MOUSEACTION_NONE then
      begin // ���� �������� �����
      // ���� ���������� �� ����� ��������� �������:
        if (MousePos.X <> MouseLDownPos.X) and
           (MousePos.Y <> MouseLDownPos.Y) then
          case MouseAction of
          // �������� ������:
            MOUSEACTION_DRAWPANEL:
              begin
              // ��� ��� �������� ���� ��� �������� - ������:
                if (lbPanelType.ItemIndex in [1, 2]) and
                   (lbTextureList.ItemIndex = -1) then
                  ErrorMessageBox(_lc[I_MSG_CHOOSE_TEXTURE])
                else // ��������� ��������� ������:
                  begin
                    case lbPanelType.ItemIndex of
                      0: Panel.PanelType := PANEL_WALL;
                      1: Panel.PanelType := PANEL_BACK;
                      2: Panel.PanelType := PANEL_FORE;
                      3: Panel.PanelType := PANEL_OPENDOOR;
                      4: Panel.PanelType := PANEL_CLOSEDOOR;
                      5: Panel.PanelType := PANEL_STEP;
                      6: Panel.PanelType := PANEL_WATER;
                      7: Panel.PanelType := PANEL_ACID1;
                      8: Panel.PanelType := PANEL_ACID2;
                      9: Panel.PanelType := PANEL_LIFTUP;
                      10: Panel.PanelType := PANEL_LIFTDOWN;
                      11: Panel.PanelType := PANEL_LIFTLEFT;
                      12: Panel.PanelType := PANEL_LIFTRIGHT;
                      13: Panel.PanelType := PANEL_BLOCKMON;
                    end;

                    Panel.X := Min(MousePos.X-MapOffset.X, MouseLDownPos.X-MapOffset.X);
                    Panel.Y := Min(MousePos.Y-MapOffset.Y, MouseLDownPos.Y-MapOffset.Y);
                    Panel.Width := Abs(MousePos.X-MouseLDownPos.X);
                    Panel.Height := Abs(MousePos.Y-MouseLDownPos.Y);

                  // �����, ������� ��� ���������� �������� - ������ ��������:
                    if (lbPanelType.ItemIndex in [9, 10, 11, 12, 13]) or
                       (lbTextureList.ItemIndex = -1) then
                      begin
                        Panel.TextureHeight := 1;
                        Panel.TextureWidth := 1;
                        Panel.TextureName := '';
                        Panel.TextureID := TEXTURE_SPECIAL_NONE;
                      end
                    else // ���� ��������:
                      begin
                        Panel.TextureName := SelectedTexture();

                      // ������� ��������:
                        if not IsSpecialTextureSel() then
                          begin
                            g_GetTextureSizeByName(Panel.TextureName,
                              Panel.TextureWidth, Panel.TextureHeight);
                            g_GetTexture(Panel.TextureName, Panel.TextureID);
                          end
                        else // ����.��������:
                          begin
                            Panel.TextureHeight := 1;
                            Panel.TextureWidth := 1;
                            Panel.TextureID := SpecialTextureID(SelectedTexture());
                          end;
                      end;

                    Panel.Alpha := 0;
                    Panel.Blending := False;

                    Undo_Add(OBJECT_PANEL, AddPanel(Panel));
                  end;
              end;

          // �������� �������:
            MOUSEACTION_DRAWTRIGGER:
              begin
                trigger.X := Min(MousePos.X-MapOffset.X, MouseLDownPos.X-MapOffset.X);
                trigger.Y := Min(MousePos.Y-MapOffset.Y, MouseLDownPos.Y-MapOffset.Y);
                trigger.Width := Abs(MousePos.X-MouseLDownPos.X);
                trigger.Height := Abs(MousePos.Y-MouseLDownPos.Y);

                trigger.Enabled := True;
                trigger.TriggerType := lbTriggersList.ItemIndex+1;
                trigger.TexturePanel := -1;

              // ���� ���������:
                trigger.ActivateType := 0;

                if clbActivationType.Checked[0] then
                  trigger.ActivateType := Trigger.ActivateType or ACTIVATE_PLAYERCOLLIDE;
                if clbActivationType.Checked[1] then
                  trigger.ActivateType := Trigger.ActivateType or ACTIVATE_MONSTERCOLLIDE;
                if clbActivationType.Checked[2] then
                  trigger.ActivateType := Trigger.ActivateType or ACTIVATE_PLAYERPRESS;
                if clbActivationType.Checked[3] then
                  trigger.ActivateType := Trigger.ActivateType or ACTIVATE_MONSTERPRESS;
                if clbActivationType.Checked[4] then
                  trigger.ActivateType := Trigger.ActivateType or ACTIVATE_SHOT;
                if clbActivationType.Checked[5] then
                  trigger.ActivateType := Trigger.ActivateType or ACTIVATE_NOMONSTER;

              // ����������� ��� ��������� �����:
                trigger.Key := 0;

                if clbKeys.Checked[0] then
                  trigger.Key := Trigger.Key or KEY_RED;
                if clbKeys.Checked[1] then
                  trigger.Key := Trigger.Key or KEY_GREEN;
                if clbKeys.Checked[2] then
                  trigger.Key := Trigger.Key or KEY_BLUE;
                if clbKeys.Checked[3] then
                  trigger.Key := Trigger.Key or KEY_REDTEAM;
                if clbKeys.Checked[4] then
                  trigger.Key := Trigger.Key or KEY_BLUETEAM;

              // ��������� ��������:
                ZeroMemory(@trigger.Data.Default[0], 128);

                case trigger.TriggerType of
                // ������������� ������:
                  TRIGGER_OPENDOOR, TRIGGER_CLOSEDOOR, TRIGGER_DOOR,
                  TRIGGER_DOOR5, TRIGGER_CLOSETRAP, TRIGGER_TRAP,
                  TRIGGER_LIFTUP, TRIGGER_LIFTDOWN, TRIGGER_LIFT:
                    begin
                      Trigger.Data.PanelID := -1;
                    end;

                // ������������:
                  TRIGGER_TELEPORT:
                    begin
                      trigger.Data.TargetPoint.X := trigger.X-64;
                      trigger.Data.TargetPoint.Y := trigger.Y-64;
                      trigger.Data.d2d_teleport := True;
                      trigger.Data.TlpDir := 0;
                    end;

                // ��������� ������ ���������:
                  TRIGGER_PRESS, TRIGGER_ON, TRIGGER_OFF,
                  TRIGGER_ONOFF:
                    begin
                      trigger.Data.Count := 1;
                    end;

                // ����:
                  TRIGGER_SOUND:
                    begin
                      trigger.Data.Volume := 255;
                      trigger.Data.Pan := 127;
                      trigger.Data.PlayCount := 1;
                      trigger.Data.Local := True;
                      trigger.Data.SoundSwitch := False;
                    end;

                // ������:
                  TRIGGER_MUSIC:
                    begin
                      trigger.Data.MusicAction := 1;
                    end;

                // �������� �������:
                  TRIGGER_SPAWNMONSTER:
                    begin
                      trigger.Data.MonType := MONSTER_ZOMBY;
                      trigger.Data.MonPos.X := trigger.X-64;
                      trigger.Data.MonPos.Y := trigger.Y-64;
                      trigger.Data.MonHealth := 0;
                      trigger.Data.MonActive := False;
                      trigger.Data.MonCount := 1;
                    end;

                // �������� ��������:
                  TRIGGER_SPAWNITEM:
                    begin
                      trigger.Data.ItemType := ITEM_AMMO_BULLETS;
                      trigger.Data.ItemPos.X := trigger.X-64;
                      trigger.Data.ItemPos.Y := trigger.Y-64;
                      trigger.Data.ItemOnlyDM := False;
                      trigger.Data.ItemFalls := False;
                      trigger.Data.ItemCount := 1;
                      trigger.Data.ItemMax := 0;
                      trigger.Data.ItemDelay := 0;
                    end;

                // ���������:
                  TRIGGER_PUSH:
                    begin
                      trigger.Data.PushAngle := 90;
                      trigger.Data.PushForce := 10;
                      trigger.Data.ResetVel := True;
                    end;

                  TRIGGER_SCORE:
                    begin
                      trigger.Data.ScoreCount := 1;
                    end;

                  TRIGGER_MESSAGE:
                    begin
                      trigger.Data.MessageKind := 0;
                      trigger.Data.MessageText := '';
                      trigger.Data.MessageSendTo := 0;
                    end;

                  TRIGGER_DAMAGE:
                    begin
                      trigger.Data.DamageValue := 5;
                      trigger.Data.DamageInterval := 12;
                    end;

                  TRIGGER_HEALTH:
                    begin
                      trigger.Data.HealValue := 5;
                      trigger.Data.HealInterval := 36;
                    end;

                  TRIGGER_SHOT:
                    begin
                      trigger.Data.ShotType := TRIGGER_SHOT_BULLET;
                      trigger.Data.ShotAngle := 0;
                      trigger.Data.ShotTarget := 0;
                      trigger.Data.ShotPos.X := trigger.X-64;
                      trigger.Data.ShotPos.Y := trigger.Y-64;
                      trigger.Data.ShotAmmo := 0;
                      trigger.Data.ShotSound := True;
                      trigger.Data.ShotWait := 18;
                      trigger.Data.ShotIntPreload := 0;
                      trigger.Data.ShotIntReload := 36;
                    end;
                end;

                Undo_Add(OBJECT_TRIGGER, AddTrigger(trigger));
              end;

          // �������� ������� �������� "�����������":
            MOUSEACTION_DRAWPRESS:
              with gTriggers[SelectedObjects[GetFirstSelected].ID] do
              begin
                Data.tX := Min(MousePos.X-MapOffset.X, MouseLDownPos.X-MapOffset.X);
                Data.tY := Min(MousePos.Y-MapOffset.Y, MouseLDownPos.Y-MapOffset.Y);
                Data.tWidth := Abs(MousePos.X-MouseLDownPos.X);
                Data.tHeight := Abs(MousePos.Y-MouseLDownPos.Y);

                DrawPressRect := False;
              end;
          end;

        MouseAction := MOUSEACTION_NONE;
      end;
    end // if Button = mbLeft...
  else // Right Mouse Button:
    begin
      if MouseAction = MOUSEACTION_NOACTION then
      begin
        MouseAction := MOUSEACTION_NONE;
        Exit;
      end;

    // ������ ���������� ��� ������� � �������:
      if MouseAction in [MOUSEACTION_MOVEOBJ, MOUSEACTION_RESIZE] then
      begin
        MouseAction := MOUSEACTION_NONE;
        FillProperty();
        Exit;
      end;

    // ��� �� ��� �������:
      if SelectFlag <> SELECTFLAG_NONE then
      begin
        if SelectFlag = SELECTFLAG_SELECTED then
          SelectFlag := SELECTFLAG_NONE;
        FillProperty();
        Exit;
      end;

    // ���� ���������� �� ����� ��������� �������:
      if (MousePos.X <> MouseRDownPos.X) and
         (MousePos.Y <> MouseRDownPos.Y) then
        begin
          rSelectRect := True;

          rRect.X := Min(MousePos.X, MouseRDownPos.X)-MapOffset.X;
          rRect.Y := Min(MousePos.Y, MouseRDownPos.Y)-MapOffset.Y;
          rRect.Width := Abs(MousePos.X-MouseRDownPos.X);
          rRect.Height := Abs(MousePos.Y-MouseRDownPos.Y);
        end
      else // ���� �� ���������� - ��� ��������������:
        begin
          rSelectRect := False;

          rRect.X := X-MapOffset.X-1;
          rRect.Y := Y-MapOffset.Y-1;
          rRect.Width := 2;
          rRect.Height := 2;
        end;

    // ���� ����� Ctrl - �������� ���, ����� ������ ���� ���������� ������: 
      if not (ssCtrl in Shift) then
        RemoveSelectFromObjects();

    // �������� �� � ��������� ��������������:
      IDArray := ObjectInRect(rRect.X, rRect.Y,
                   rRect.Width, rRect.Height,
                   pcObjects.ActivePageIndex+1, rSelectRect);

      if IDArray <> nil then
        for i := 0 to High(IDArray) do
          SelectObject(pcObjects.ActivePageIndex+1, IDArray[i],
            (ssCtrl in Shift) or rSelectRect);

      FillProperty();
    end;
end;

procedure TMainForm.RenderPanelMouseMove(Sender: TObject;
  Shift: TShiftState; X, Y: Integer);
var
  sX, sY: Integer;
  dWidth, dHeight: Integer;
  _id: Integer;
begin
  _id := GetFirstSelected();

// ������ ������ � ���������, ����� - ������� ��������:
  if (MouseAction = MOUSEACTION_DRAWPANEL) and
     (lbPanelType.ItemIndex in [0..8]) and
     (lbTextureList.ItemIndex <> -1) and
     (not IsSpecialTextureSel()) then
    begin
      sX := StrToIntDef(lTextureWidth.Caption, DotStep);
      sY := StrToIntDef(lTextureHeight.Caption, DotStep);
    end
  else
  // ������ ������ ������ � ���������, ����� - ������� ��������:
    if (MouseAction = MOUSEACTION_RESIZE) and
       ( (SelectedObjects[_id].ObjectType = OBJECT_PANEL) and
         IsTexturedPanel(gPanels[SelectedObjects[_id].ID].PanelType) and
         (gPanels[SelectedObjects[_id].ID].TextureName <> '') and
         (not IsSpecialTexture(gPanels[SelectedObjects[_id].ID].TextureName)) ) then
      begin
        sX := gPanels[SelectedObjects[_id].ID].TextureWidth;
        sY := gPanels[SelectedObjects[_id].ID].TextureHeight;
      end
    else
    // ������������ �� �����:
      if SnapToGrid then
        begin
          sX := DotStep;
          sY := DotStep;
        end
      else // ��� ������������ �� �����:
        begin
          sX := 1;
          sY := 1;
        end;

// ����� ������� ����:
  if MouseLDown then
    begin // ������ ����� ������ ����
      MousePos.X := (Round((X-MouseLDownPos.X)/sX)*sX)+MouseLDownPos.X;
      MousePos.Y := (Round((Y-MouseLDownPos.Y)/sY)*sY)+MouseLDownPos.Y;
    end
  else
    if MouseRDown then
      begin // ������ ������ ������ ����
        MousePos.X := (Round((X-MouseRDownPos.X)/sX)*sX)+MouseRDownPos.X;
        MousePos.Y := (Round((Y-MouseRDownPos.Y)/sY)*sY)+MouseRDownPos.Y;
      end
    else
      begin // ������ ���� �� ������
        MousePos.X := (Round(X/sX)*sX);
        MousePos.Y := (Round(Y/sY)*sY);
      end;

// ��������� ������� ����������� - ������ ������� ������:
  if ResizeType = RESIZETYPE_NONE then
    RenderPanel.Cursor := crDefault;

// ������ ������ ������ ������ ����:
  if (not MouseLDown) and (MouseRDown) then
  begin
  // ������ ������������� ���������:
    if MouseAction = MOUSEACTION_NONE then
      begin
        if DrawRect = nil then
          New(DrawRect);
        DrawRect.TopLeft := MouseRDownPos;
        DrawRect.BottomRight := MousePos;
      end
    else
    // ������� ���������� �������:
      if MouseAction = MOUSEACTION_MOVEOBJ then
        begin
          MoveSelectedObjects(ssShift in Shift, ssCtrl in Shift,
                              MousePos.X-LastMovePoint.X,
                              MousePos.Y-LastMovePoint.Y);
        end
      else
      // ������ ������ ����������� �������:
        if MouseAction = MOUSEACTION_RESIZE then
        begin
          if (SelectedObjectCount = 1) and
             (SelectedObjects[GetFirstSelected].Live) then
          begin
            dWidth := MousePos.X-LastMovePoint.X;
            dHeight := MousePos.Y-LastMovePoint.Y;

            case ResizeType of
              RESIZETYPE_VERTICAL: dWidth := 0;
              RESIZETYPE_HORIZONTAL: dHeight := 0;
            end;

            case ResizeDirection of
              RESIZEDIR_UP: dHeight := -dHeight;
              RESIZEDIR_LEFT: dWidth := -dWidth;
            end;

            ResizeObject(SelectedObjects[GetFirstSelected].ObjectType,
                         SelectedObjects[GetFirstSelected].ID,
                         dWidth, dHeight, ResizeDirection);

            LastMovePoint := MousePos;
          end;
        end;
  end;

// ������ ������ ����� ������ ����:
  if (not MouseRDown) and (MouseLDown) then
  begin
  // ������ ������������� ������������ ������:
    if MouseAction in [MOUSEACTION_DRAWPANEL,
                       MOUSEACTION_DRAWTRIGGER,
                       MOUSEACTION_DRAWPRESS] then
      begin
        if DrawRect = nil then
          New(DrawRect);
        DrawRect.TopLeft := MouseLDownPos;
        DrawRect.BottomRight := MousePos;
      end
    else // ������� �����:
      if MouseAction = MOUSEACTION_MOVEMAP then
      begin
        MoveMap(X, Y);
      end;
  end;

// ������� ���� �� ������:
  if (not MouseRDown) and (not MouseLDown) then
    DrawRect := nil;

// ������ ��������� - ���������� ����:
  StatusBar.Panels[1].Text := Format('(%d:%d)',
    [MousePos.X-MapOffset.X, MousePos.Y-MapOffset.Y]);
end;

procedure TMainForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose := MessageBox(0, PChar(_lc[I_MSG_EXIT_PROMT]),
                         PChar(_lc[I_MSG_EXIT]),
                         MB_ICONQUESTION or MB_YESNO or
                         MB_TASKMODAL or MB_DEFBUTTON1) = idYes;
end;

procedure TMainForm.aExitExecute(Sender: TObject);
begin
  Close();
end;

procedure TMainForm.FormDestroy(Sender: TObject);
var
  config: TConfig;
  i: Integer;
begin
  config := TConfig.CreateFile(EditorDir+'\Editor.cfg');

  config.WriteBool('Editor', 'Maximize', WindowState = wsMaximized);
  config.WriteBool('Editor', 'Minimap', ShowMap);
  config.WriteBool('Editor', 'DotEnable', DotEnable);
  config.WriteInt('Editor', 'DotStep', DotStep);
  config.WriteStr('Editor', 'LastOpenDir', OpenDialog.InitialDir);
  config.WriteStr('Editor', 'LastSaveDir', SaveDialog.InitialDir);
  config.WriteBool('Editor', 'EdgeShow', drEdge[3] < 255);
  config.WriteInt('Editor', 'EdgeColor', gColorEdge);
  config.WriteInt('Editor', 'EdgeAlpha', gAlphaEdge);
  config.WriteInt('Editor', 'LineAlpha', gAlphaTriggerLine);
  config.WriteInt('Editor', 'TriggerAlpha', gAlphaTriggerArea);

  for i := 0 to RecentCount-1 do
    if i < RecentFiles.Count then
      config.WriteStr('RecentFiles', IntToStr(i+1), RecentFiles[i])
    else
      config.WriteStr('RecentFiles', IntToStr(i+1), '');
  RecentFiles.Free();

  config.SaveFile(EditorDir+'\Editor.cfg');
  config.Free();

  slInvalidTextures.Free;

  wglDeleteContext(hRC);
end;

procedure TMainForm.RenderPanelResize(Sender: TObject);
begin
  if MainForm.Visible then
    MainForm.Resize();
end;

procedure TMainForm.aMapOptionsExecute(Sender: TObject);
var
  ResName: String;
begin
  MapOptionsForm.ShowModal();

  ResName := OpenedMap;
  while (Pos(':\', ResName) > 0) do
    Delete(ResName, 1, Pos(':\', ResName) + 1);

  UpdateCaption(gMapInfo.Name, ExtractFileName(OpenedWAD), ResName);
end;

procedure TMainForm.aAboutExecute(Sender: TObject);
begin
  AboutForm.ShowModal();
end;

procedure TMainForm.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  dx, dy, i: Integer;
begin
  if (not EditingProperties) then
  begin
    if Key = Ord('1') then
      SwitchLayer(LAYER_BACK);
    if Key = Ord('2') then
      SwitchLayer(LAYER_WALLS);
    if Key = Ord('3') then
      SwitchLayer(LAYER_FOREGROUND);
    if Key = Ord('4') then
      SwitchLayer(LAYER_STEPS);
    if Key = Ord('5') then
      SwitchLayer(LAYER_WATER);
    if Key = Ord('6') then
      SwitchLayer(LAYER_ITEMS);
    if Key = Ord('7') then
      SwitchLayer(LAYER_MONSTERS);
    if Key = Ord('8') then
      SwitchLayer(LAYER_AREAS);
    if Key = Ord('9') then
      SwitchLayer(LAYER_TRIGGERS);
    if Key = Ord('0') then
      tbShowClick(tbShow);
      
    if Key = Ord('V') then
    begin // ������� �������� � ��������:
      if (SelectedObjects <> nil) then
        for i := 0 to High(SelectedObjects) do
          if (SelectedObjects[i].Live) then
          begin
            if (SelectedObjects[i].ObjectType = OBJECT_MONSTER) then
              begin
                g_ChangeDir(gMonsters[SelectedObjects[i].ID].Direction);
              end
            else
              if (SelectedObjects[i].ObjectType = OBJECT_AREA) then
              begin
                g_ChangeDir(gAreas[SelectedObjects[i].ID].Direction);
              end;
          end;
    end;
  end;

// ������� ���������� �������:
  if (Key = VK_DELETE) and (SelectedObjects <> nil) and
     RenderPanel.Focused() then
    DeleteSelectedObjects();

// ����� ���������:
  if (Key = VK_ESCAPE) and (SelectedObjects <> nil) then
    RemoveSelectFromObjects();

// ����������� �������:
  if MainForm.ActiveControl = RenderPanel then
  begin
    dx := 0;
    dy := 0;

    if Key = VK_NUMPAD4 then
      dx := IfThen(ssAlt in Shift, -1, -DotStep);
    if Key = VK_NUMPAD6 then
      dx := IfThen(ssAlt in Shift, 1, DotStep);
    if Key = VK_NUMPAD8 then
      dy := IfThen(ssAlt in Shift, -1, -DotStep);
    if Key = VK_NUMPAD5 then
      dy := IfThen(ssAlt in Shift, 1, DotStep);

    if (dx <> 0) or (dy <> 0) then
    begin
      MoveSelectedObjects(ssShift in Shift, ssCtrl in Shift, dx, dy);
      Key := 0;
    end;
  end;

// ������������ ������ �����:
  with sbVertical do
  begin
    if Key = Ord('W') then
    begin
      Position := IfThen(Position > DotStep, Position-DotStep, 0);
      MapOffset.Y := -Round(Position/16) * 16;
    end;

    if Key = Ord('S') then
    begin
      Position := IfThen(Position+DotStep < Max, Position+DotStep, Max);
      MapOffset.Y := -Round(Position/16) * 16;
    end;
  end;

// �������������� ������ �����:
  with sbHorizontal do
  begin
    if Key = Ord('A') then
    begin
      Position := IfThen(Position > DotStep, Position-DotStep, 0);
      MapOffset.X := -Round(Position/16) * 16;
    end;

    if Key = Ord('D') then
    begin
      Position := IfThen(Position+DotStep < Max, Position+DotStep, Max);
      MapOffset.X := -Round(Position/16) * 16;
    end;
  end;
end;

procedure TMainForm.aOptimizeExecute(Sender: TObject);
begin
  RemoveSelectFromObjects();
  MapOptimizationForm.ShowModal();
end;

procedure TMainForm.aCheckMapExecute(Sender: TObject);
begin
  MapCheckForm.ShowModal();
end;

procedure TMainForm.bbAddTextureClick(Sender: TObject);
begin
  AddTextureForm.lbResourcesList.MultiSelect := True;
  AddTextureForm.ShowModal();
end;

procedure TMainForm.lbTextureListClick(Sender: TObject);
var
  TextureID: DWORD;
  TextureWidth, TextureHeight: Word;
begin
  if (lbTextureList.ItemIndex <> -1) and
     (not IsSpecialTextureSel()) then
    begin
      if g_GetTexture(SelectedTexture(), TextureID) then
      begin
        g_GetTextureSizeByID(TextureID, TextureWidth, TextureHeight);

        lTextureWidth.Caption := IntToStr(TextureWidth);
        lTextureHeight.Caption := IntToStr(TextureHeight);
      end else
      begin
        lTextureWidth.Caption := _lc[I_NOT_ACCESSIBLE];
        lTextureHeight.Caption := _lc[I_NOT_ACCESSIBLE];
      end;
    end
  else
    begin
      lTextureWidth.Caption := '';
      lTextureHeight.Caption := '';
    end;
end;

procedure TMainForm.vleObjectPropertyGetPickList(Sender: TObject;
  const KeyName: String; Values: TStrings);
begin
  if vleObjectProperty.ItemProps[KeyName].EditStyle = esPickList then
  begin
    if KeyName = _lc[I_PROP_PANEL_TYPE] then
      begin
        Values.Add(GetPanelName(PANEL_WALL));
        Values.Add(GetPanelName(PANEL_BACK));
        Values.Add(GetPanelName(PANEL_FORE));
        Values.Add(GetPanelName(PANEL_CLOSEDOOR));
        Values.Add(GetPanelName(PANEL_OPENDOOR));
        Values.Add(GetPanelName(PANEL_STEP));
        Values.Add(GetPanelName(PANEL_WATER));
        Values.Add(GetPanelName(PANEL_ACID1));
        Values.Add(GetPanelName(PANEL_ACID2));
        Values.Add(GetPanelName(PANEL_LIFTUP));
        Values.Add(GetPanelName(PANEL_LIFTDOWN));
        Values.Add(GetPanelName(PANEL_LIFTLEFT));
        Values.Add(GetPanelName(PANEL_LIFTRIGHT));
        Values.Add(GetPanelName(PANEL_BLOCKMON));
      end
    else if KeyName = _lc[I_PROP_DIRECTION] then
      begin
        Values.Add(DirNames[D_LEFT]);
        Values.Add(DirNames[D_RIGHT]);
      end
    else if KeyName = _lc[I_PROP_TR_TELEPORT_DIR] then
      begin
        Values.Add(DirNamesAdv[0]);
        Values.Add(DirNamesAdv[1]);
        Values.Add(DirNamesAdv[2]);
        Values.Add(DirNamesAdv[3]);
      end
    else if KeyName = _lc[I_PROP_TR_MUSIC_ACT] then
      begin
        Values.Add(_lc[I_PROP_TR_MUSIC_ON]);
        Values.Add(_lc[I_PROP_TR_MUSIC_OFF]);
      end
    else if KeyName = _lc[I_PROP_TR_MONSTER_BEHAVIOUR] then
      begin
        Values.Add(_lc[I_PROP_TR_MONSTER_BEHAVIOUR_0]);
        Values.Add(_lc[I_PROP_TR_MONSTER_BEHAVIOUR_1]);
        Values.Add(_lc[I_PROP_TR_MONSTER_BEHAVIOUR_2]);
        Values.Add(_lc[I_PROP_TR_MONSTER_BEHAVIOUR_3]);
        Values.Add(_lc[I_PROP_TR_MONSTER_BEHAVIOUR_4]);
        Values.Add(_lc[I_PROP_TR_MONSTER_BEHAVIOUR_5]);
      end
    else if KeyName = _lc[I_PROP_TR_SCORE_ACT] then
      begin
        Values.Add(_lc[I_PROP_TR_SCORE_ACT_0]);
        Values.Add(_lc[I_PROP_TR_SCORE_ACT_1]);
        Values.Add(_lc[I_PROP_TR_SCORE_ACT_2]);
        Values.Add(_lc[I_PROP_TR_SCORE_ACT_3]);
      end
    else if KeyName = _lc[I_PROP_TR_SCORE_TEAM] then
      begin
        Values.Add(_lc[I_PROP_TR_SCORE_TEAM_0]);
        Values.Add(_lc[I_PROP_TR_SCORE_TEAM_1]);
        Values.Add(_lc[I_PROP_TR_SCORE_TEAM_2]);
        Values.Add(_lc[I_PROP_TR_SCORE_TEAM_3]);
      end
    else if KeyName = _lc[I_PROP_TR_MESSAGE_KIND] then
      begin
        Values.Add(_lc[I_PROP_TR_MESSAGE_KIND_0]);
        Values.Add(_lc[I_PROP_TR_MESSAGE_KIND_1]);
      end
    else if KeyName = _lc[I_PROP_TR_MESSAGE_TO] then
      begin
        Values.Add(_lc[I_PROP_TR_MESSAGE_TO_0]);
        Values.Add(_lc[I_PROP_TR_MESSAGE_TO_1]);
        Values.Add(_lc[I_PROP_TR_MESSAGE_TO_2]);
        Values.Add(_lc[I_PROP_TR_MESSAGE_TO_3]);
        Values.Add(_lc[I_PROP_TR_MESSAGE_TO_4]);
        Values.Add(_lc[I_PROP_TR_MESSAGE_TO_5]);
      end
    else if KeyName = _lc[I_PROP_TR_SHOT_TO] then
      begin
        Values.Add(_lc[I_PROP_TR_SHOT_TO_0]);
        Values.Add(_lc[I_PROP_TR_SHOT_TO_1]);
        Values.Add(_lc[I_PROP_TR_SHOT_TO_2]);
        Values.Add(_lc[I_PROP_TR_SHOT_TO_3]);
        Values.Add(_lc[I_PROP_TR_SHOT_TO_4]);
      end
    else if (KeyName = _lc[I_PROP_PANEL_BLEND]) or
            (KeyName = _lc[I_PROP_DM_ONLY]) or
            (KeyName = _lc[I_PROP_ITEM_FALLS]) or
            (KeyName = _lc[I_PROP_TR_ENABLED]) or
            (KeyName = _lc[I_PROP_TR_D2D]) or
            (KeyName = _lc[I_PROP_TR_SILENT]) or
            (KeyName = _lc[I_PROP_TR_TELEPORT_SILENT]) or
            (KeyName = _lc[I_PROP_TR_EX_RANDOM]) or
            (KeyName = _lc[I_PROP_TR_TEXTURE_ONCE]) or
            (KeyName = _lc[I_PROP_TR_TEXTURE_ANIM_ONCE]) or
            (KeyName = _lc[I_PROP_TR_SOUND_LOCAL]) or
            (KeyName = _lc[I_PROP_TR_SOUND_SWITCH]) or
            (KeyName = _lc[I_PROP_TR_MONSTER_ACTIVE]) or
            (KeyName = _lc[I_PROP_TR_PUSH_RESET]) or
            (KeyName = _lc[I_PROP_TR_HEALTH_MAX]) or
            (KeyName = _lc[I_PROP_TR_SHOT_SOUND]) then
      begin
        Values.Add(BoolNames[True]);
        Values.Add(BoolNames[False]);
      end;
  end;
end;

procedure TMainForm.bApplyPropertyClick(Sender: TObject);
var
  _id, a, r, c: Integer;
  s: String;
  res: Boolean;
  NoTextureID: DWORD;
  NW, NH: Word;
begin
  if SelectedObjectCount() <> 1 then
    Exit;
  if not SelectedObjects[GetFirstSelected()].Live then
    Exit;

  try
    if not CheckProperty() then
      Exit;
  except
    Exit;
  end;

  _id := GetFirstSelected();

  r := vleObjectProperty.Row;
  c := vleObjectProperty.Col;

  case SelectedObjects[_id].ObjectType of
    OBJECT_PANEL:
      begin
        with gPanels[SelectedObjects[_id].ID] do
        begin
          X := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_X]]));
          Y := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_Y]]));
          Width := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_WIDTH]]));
          Height := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_HEIGHT]]));

          PanelType := GetPanelType(vleObjectProperty.Values[_lc[I_PROP_PANEL_TYPE]]);

        // ����� ������ �� �������� ����� ��������:
          if not WordBool(PanelType and (PANEL_WALL or PANEL_FORE or PANEL_BACK)) then
            if gTriggers <> nil then
              for a := 0 to High(gTriggers) do
                if (gTriggers[a].TriggerType <> 0) and
                   (gTriggers[a].TexturePanel = Integer(SelectedObjects[_id].ID)) then
                  gTriggers[a].TexturePanel := -1;

        // ����� ������ �� �������� �����:
          if not WordBool(PanelType and (PANEL_LIFTUP or PANEL_LIFTDOWN or PANEL_LIFTLEFT or PANEL_LIFTRIGHT)) then
            if gTriggers <> nil then
              for a := 0 to High(gTriggers) do
                if (gTriggers[a].TriggerType in [TRIGGER_LIFTUP, TRIGGER_LIFTDOWN, TRIGGER_LIFT]) and
                   (gTriggers[a].Data.PanelID = Integer(SelectedObjects[_id].ID)) then
                     gTriggers[a].Data.PanelID := -1;

        // ����� ������ �� �������� �����:
          if not WordBool(PanelType and (PANEL_OPENDOOR or PANEL_CLOSEDOOR)) then
            if gTriggers <> nil then
              for a := 0 to High(gTriggers) do
                if (gTriggers[a].TriggerType in [TRIGGER_OPENDOOR, TRIGGER_CLOSEDOOR, TRIGGER_DOOR,
                                                 TRIGGER_DOOR5, TRIGGER_CLOSETRAP, TRIGGER_TRAP]) and
                   (gTriggers[a].Data.PanelID = Integer(SelectedObjects[_id].ID)) then
                  gTriggers[a].Data.PanelID := -1;

          if IsTexturedPanel(PanelType) then
            begin // ����� ���� ��������
              if TextureName <> '' then
                begin // ���� ��������
                  Alpha := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_PANEL_ALPHA]]));
                  Blending := NameToBool(vleObjectProperty.Values[_lc[I_PROP_PANEL_BLEND]]);
                end
              else // �� ����
                begin
                  Alpha := 0;
                  Blending := False;
                end;

            // ����� ��������:
              TextureName := vleObjectProperty.Values[_lc[I_PROP_PANEL_TEX]];

              if TextureName <> '' then
                begin // ���� ��������
                // ������� ��������:
                  if not IsSpecialTexture(TextureName) then
                    begin
                      g_GetTextureSizeByName(TextureName,
                        TextureWidth, TextureHeight);

                    // �������� ��������� �������� ������:
                      res := True;
                      if TextureWidth <> 0 then
                        if gPanels[SelectedObjects[_id].ID].Width mod TextureWidth <> 0 then
                        begin
                          ErrorMessageBox(Format(_lc[I_MSG_WRONG_TEXWIDTH],
                                          [TextureWidth]));
                          Res := False;
                        end;
                      if Res and (TextureHeight <> 0) then
                        if gPanels[SelectedObjects[_id].ID].Height mod TextureHeight <> 0 then
                        begin
                          ErrorMessageBox(Format(_lc[I_MSG_WRONG_TEXHEIGHT],
                                          [TextureHeight]));
                          Res := False;
                        end;

                      if Res then
                      begin
                        if not g_GetTexture(TextureName, TextureID) then
                          // �� ������� ��������� ��������, ������ NOTEXTURE
                          if g_GetTexture('NOTEXTURE', NoTextureID) then
                          begin
                            TextureID := TEXTURE_SPECIAL_NOTEXTURE;
                            g_GetTextureSizeByID(NoTextureID, NW, NH);
                            TextureWidth := NW;
                            TextureHeight := NH;
                          end else
                          begin
                            TextureID := TEXTURE_SPECIAL_NONE;
                            TextureWidth := 1;
                            TextureHeight := 1;
                          end;
                      end
                      else
                        begin
                          TextureName := '';
                          TextureWidth := 1;
                          TextureHeight := 1;
                          TextureID := TEXTURE_SPECIAL_NONE;
                        end;
                    end
                  else // ����.��������
                    begin
                      TextureHeight := 1;
                      TextureWidth := 1;
                      TextureID := SpecialTextureID(TextureName);
                    end;
                end
              else // ��� ��������
                begin
                  TextureWidth := 1;
                  TextureHeight := 1;
                  TextureID := TEXTURE_SPECIAL_NONE;
                end;
            end
          else // �� ����� ���� ��������
            begin
              Alpha := 0;
              Blending := False;
              TextureName := '';
              TextureWidth := 1;
              TextureHeight := 1;
              TextureID := TEXTURE_SPECIAL_NONE;
            end;
        end;
      end;

    OBJECT_ITEM:
      begin
        with gItems[SelectedObjects[_id].ID] do
        begin
          X := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_X]]));
          Y := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_Y]]));
          OnlyDM := NameToBool(vleObjectProperty.Values[_lc[I_PROP_DM_ONLY]]);
          Fall := NameToBool(vleObjectProperty.Values[_lc[I_PROP_ITEM_FALLS]]);
        end;
      end;

    OBJECT_MONSTER:
      begin
        with gMonsters[SelectedObjects[_id].ID] do
        begin
          X := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_X]]));
          Y := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_Y]]));
          Direction := NameToDir(vleObjectProperty.Values[_lc[I_PROP_DIRECTION]]);
        end;
      end;

    OBJECT_AREA:
      begin
        with gAreas[SelectedObjects[_id].ID] do
        begin
          X := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_X]]));
          Y := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_Y]]));
          Direction := NameToDir(vleObjectProperty.Values[_lc[I_PROP_DIRECTION]]);
        end;
      end;

    OBJECT_TRIGGER:
      begin
        with gTriggers[SelectedObjects[_id].ID] do
        begin
          X := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_X]]));
          Y := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_Y]]));
          Width := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_WIDTH]]));
          Height := StrToInt(Trim(vleObjectProperty.Values[_lc[I_PROP_HEIGHT]]));
          Enabled := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_ENABLED]]);
          ActivateType := StrToActivate(vleObjectProperty.Values[_lc[I_PROP_TR_ACTIVATION]]);
          Key := StrToKey(vleObjectProperty.Values[_lc[I_PROP_TR_KEYS]]);

          case TriggerType of
            TRIGGER_EXIT:
              begin
                s := vleObjectProperty.Values[_lc[I_PROP_TR_NEXT_MAP]];
                ZeroMemory(@Data.MapName[0], 16);
                if s <> '' then
                  CopyMemory(@Data.MapName[0], @s[1], Min(Length(s), 16));
              end;

            TRIGGER_TEXTURE:
              begin
                Data.ActivateOnce := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_TEXTURE_ONCE]]);
                Data.AnimOnce := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_TEXTURE_ANIM_ONCE]]);
              end;

            TRIGGER_PRESS, TRIGGER_ON, TRIGGER_OFF, TRIGGER_ONOFF:
              begin
                Data.Wait := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_EX_DELAY]], 0), 65535);
                Data.Count := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_EX_COUNT]], 0), 65535);
                if Data.Count < 1 then
                  Data.Count := 1;
                if TriggerType = TRIGGER_PRESS then
                  Data.ExtRandom := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_EX_RANDOM]]);
              end;

            TRIGGER_OPENDOOR, TRIGGER_CLOSEDOOR, TRIGGER_DOOR, TRIGGER_DOOR5,
            TRIGGER_CLOSETRAP, TRIGGER_TRAP, TRIGGER_LIFTUP, TRIGGER_LIFTDOWN,
            TRIGGER_LIFT:
              begin
                Data.NoSound := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_SILENT]]);
                Data.d2d_doors := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_D2D]]);
              end;

            TRIGGER_TELEPORT:
              begin
                Data.d2d_teleport := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_D2D]]);
                Data.silent_teleport := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_TELEPORT_SILENT]]);
                Data.TlpDir := NameToDirAdv(vleObjectProperty.Values[_lc[I_PROP_TR_TELEPORT_DIR]]);
              end;

            TRIGGER_SOUND:
              begin
                s := vleObjectProperty.Values[_lc[I_PROP_TR_SOUND_NAME]];
                ZeroMemory(@Data.SoundName[0], 64);
                if s <> '' then
                  CopyMemory(@Data.SoundName[0], @s[1], Min(Length(s), 64));

                Data.Volume := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_SOUND_VOLUME]], 0), 255);
                Data.Pan := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_SOUND_PAN]], 0), 255);
                Data.PlayCount := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_SOUND_COUNT]], 0), 255);
                Data.Local := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_SOUND_LOCAL]]);
                Data.SoundSwitch := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_SOUND_SWITCH]]);
              end;

            TRIGGER_SPAWNMONSTER:
              begin
                Data.MonType := StrToMonster(vleObjectProperty.Values[_lc[I_PROP_TR_MONSTER_TYPE]]);
                Data.MonDir := Byte(NameToDir(vleObjectProperty.Values[_lc[I_PROP_DIRECTION]]));
                Data.MonHealth := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_HEALTH]], 0), 1000000);
                if Data.MonHealth < 0 then
                  Data.MonHealth := 0;
                Data.MonActive := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_MONSTER_ACTIVE]]);
                Data.MonCount := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_COUNT]], 0), 64);
                if Data.MonCount < 1 then
                  Data.MonCount := 1;
                Data.MonEffect := StrToEffect(vleObjectProperty.Values[_lc[I_PROP_TR_FX_TYPE]]);
                Data.MonMax := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_SPAWN_MAX]], 0), 65535);
                Data.MonDelay := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_SPAWN_DELAY]], 0), 65535);
                Data.MonBehav := 0;
                if vleObjectProperty.Values[_lc[I_PROP_TR_MONSTER_BEHAVIOUR]] = _lc[I_PROP_TR_MONSTER_BEHAVIOUR_1] then
                  Data.MonBehav := 1;
                if vleObjectProperty.Values[_lc[I_PROP_TR_MONSTER_BEHAVIOUR]] = _lc[I_PROP_TR_MONSTER_BEHAVIOUR_2] then
                  Data.MonBehav := 2;
                if vleObjectProperty.Values[_lc[I_PROP_TR_MONSTER_BEHAVIOUR]] = _lc[I_PROP_TR_MONSTER_BEHAVIOUR_3] then
                  Data.MonBehav := 3;
                if vleObjectProperty.Values[_lc[I_PROP_TR_MONSTER_BEHAVIOUR]] = _lc[I_PROP_TR_MONSTER_BEHAVIOUR_4] then
                  Data.MonBehav := 4;
                if vleObjectProperty.Values[_lc[I_PROP_TR_MONSTER_BEHAVIOUR]] = _lc[I_PROP_TR_MONSTER_BEHAVIOUR_5] then
                  Data.MonBehav := 5;
              end;

            TRIGGER_SPAWNITEM:
              begin
                Data.ItemType := StrToItem(vleObjectProperty.Values[_lc[I_PROP_TR_ITEM_TYPE]]);
                Data.ItemOnlyDM := NameToBool(vleObjectProperty.Values[_lc[I_PROP_DM_ONLY]]);
                Data.ItemFalls := NameToBool(vleObjectProperty.Values[_lc[I_PROP_ITEM_FALLS]]);
                Data.ItemCount := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_COUNT]], 0), 64);
                if Data.ItemCount < 1 then
                  Data.ItemCount := 1;
                Data.ItemEffect := StrToEffect(vleObjectProperty.Values[_lc[I_PROP_TR_FX_TYPE]]);
                Data.ItemMax := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_SPAWN_MAX]], 0), 65535);
                Data.ItemDelay := Min(StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_SPAWN_DELAY]], 0), 65535);
              end;

            TRIGGER_MUSIC:
              begin
                s := vleObjectProperty.Values[_lc[I_PROP_TR_MUSIC_NAME]];
                ZeroMemory(@Data.MusicName[0], 64);
                if s <> '' then
                  CopyMemory(@Data.MusicName[0], @s[1], Min(Length(s), 64));

                if vleObjectProperty.Values[_lc[I_PROP_TR_MUSIC_ACT]] = _lc[I_PROP_TR_MUSIC_ON] then
                  Data.MusicAction := 1
                else
                  Data.MusicAction := 2;
              end;

            TRIGGER_PUSH:
              begin
                Data.PushAngle := Min(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_PUSH_ANGLE]], 0), 360);
                Data.PushForce := Min(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_PUSH_FORCE]], 0), 255);
                Data.ResetVel := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_PUSH_RESET]]);
              end;

            TRIGGER_SCORE:
              begin
                Data.ScoreAction := 0;
                if vleObjectProperty.Values[_lc[I_PROP_TR_SCORE_ACT]] = _lc[I_PROP_TR_SCORE_ACT_1] then
                  Data.ScoreAction := 1
                else if vleObjectProperty.Values[_lc[I_PROP_TR_SCORE_ACT]] = _lc[I_PROP_TR_SCORE_ACT_2] then
                  Data.ScoreAction := 2
                else if vleObjectProperty.Values[_lc[I_PROP_TR_SCORE_ACT]] = _lc[I_PROP_TR_SCORE_ACT_3] then
                  Data.ScoreAction := 3;
                Data.ScoreCount := Min(Max(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_COUNT]], 0), 0), 255);
                Data.ScoreTeam := 0;
                if vleObjectProperty.Values[_lc[I_PROP_TR_SCORE_TEAM]] = _lc[I_PROP_TR_SCORE_TEAM_1] then
                  Data.ScoreTeam := 1
                else if vleObjectProperty.Values[_lc[I_PROP_TR_SCORE_TEAM]] = _lc[I_PROP_TR_SCORE_TEAM_2] then
                  Data.ScoreTeam := 2
                else if vleObjectProperty.Values[_lc[I_PROP_TR_SCORE_TEAM]] = _lc[I_PROP_TR_SCORE_TEAM_3] then
                  Data.ScoreTeam := 3;
              end;

            TRIGGER_MESSAGE:
              begin
                Data.MessageKind := 0;
                if vleObjectProperty.Values[_lc[I_PROP_TR_MESSAGE_KIND]] = _lc[I_PROP_TR_MESSAGE_KIND_1] then
                  Data.MessageKind := 1;

                Data.MessageSendTo := 0;
                if vleObjectProperty.Values[_lc[I_PROP_TR_MESSAGE_TO]] = _lc[I_PROP_TR_MESSAGE_TO_1] then
                  Data.MessageSendTo := 1
                else if vleObjectProperty.Values[_lc[I_PROP_TR_MESSAGE_TO]] = _lc[I_PROP_TR_MESSAGE_TO_2] then
                  Data.MessageSendTo := 2
                else if vleObjectProperty.Values[_lc[I_PROP_TR_MESSAGE_TO]] = _lc[I_PROP_TR_MESSAGE_TO_3] then
                  Data.MessageSendTo := 3
                else if vleObjectProperty.Values[_lc[I_PROP_TR_MESSAGE_TO]] = _lc[I_PROP_TR_MESSAGE_TO_4] then
                  Data.MessageSendTo := 4
                else if vleObjectProperty.Values[_lc[I_PROP_TR_MESSAGE_TO]] = _lc[I_PROP_TR_MESSAGE_TO_5] then
                  Data.MessageSendTo := 5;

                s := vleObjectProperty.Values[_lc[I_PROP_TR_MESSAGE_TEXT]];
                ZeroMemory(@Data.MessageText[0], 100);
                if s <> '' then
                  CopyMemory(@Data.MessageText[0], @s[1], Min(Length(s), 100));
              end;

            TRIGGER_DAMAGE:
              begin
                Data.DamageValue := Min(Max(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_DAMAGE_VALUE]], 0), 0), 65535);
                Data.DamageInterval := Min(Max(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_INTERVAL]], 0), 0), 65535);
              end;

            TRIGGER_HEALTH:
              begin
                Data.HealValue := Min(Max(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_HEALTH]], 0), 0), 65535);
                Data.HealInterval := Min(Max(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_INTERVAL]], 0), 0), 65535);
                Data.HealMax := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_HEALTH_MAX]]);
                Data.HealSilent := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_SILENT]]);
              end;

            TRIGGER_SHOT:
              begin
                Data.ShotType := StrToShot(vleObjectProperty.Values[_lc[I_PROP_TR_SHOT_TYPE]]);
                Data.ShotAngle := Min(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_SHOT_ANGLE]], 0), 360);
                Data.ShotSound := NameToBool(vleObjectProperty.Values[_lc[I_PROP_TR_SHOT_SOUND]]);
                Data.ShotTarget := 0;
                if vleObjectProperty.Values[_lc[I_PROP_TR_SHOT_TO]] = _lc[I_PROP_TR_SHOT_TO_1] then
                  Data.ShotTarget := 1
                else if vleObjectProperty.Values[_lc[I_PROP_TR_SHOT_TO]] = _lc[I_PROP_TR_SHOT_TO_2] then
                  Data.ShotTarget := 2
                else if vleObjectProperty.Values[_lc[I_PROP_TR_SHOT_TO]] = _lc[I_PROP_TR_SHOT_TO_3] then
                  Data.ShotTarget := 3
                else if vleObjectProperty.Values[_lc[I_PROP_TR_SHOT_TO]] = _lc[I_PROP_TR_SHOT_TO_4] then
                  Data.ShotTarget := 4;
                Data.ShotWait := Min(Max(
                  StrToIntDef(vleObjectProperty.Values[_lc[I_PROP_TR_EX_DELAY]], 0), 0), 65535);
              end;
          end;
        end;
      end;
  end;

  FillProperty();

  vleObjectProperty.Row := r;
  vleObjectProperty.Col := c;
end;

procedure TMainForm.bbRemoveTextureClick(Sender: TObject);
var
  a, i: Integer;
begin
  i := lbTextureList.ItemIndex;
  if i = -1 then
    Exit;

  if MessageBox(0, PChar(Format(_lc[I_MSG_DEL_TEXTURE_PROMT],
                                [SelectedTexture()])),
                PChar(_lc[I_MSG_DEL_TEXTURE]),
                MB_ICONQUESTION or MB_YESNO or
                MB_TASKMODAL or MB_DEFBUTTON1) <> idYes then
    Exit;

  if gPanels <> nil then
    for a := 0 to High(gPanels) do
      if (gPanels[a].PanelType <> 0) and
         (gPanels[a].TextureName = SelectedTexture()) then
      begin
        ErrorMessageBox(_lc[I_MSG_DEL_TEXTURE_CANT]);
        Exit;
      end;

  g_DeleteTexture(SelectedTexture());
  i := slInvalidTextures.IndexOf(lbTextureList.Items[i]);
  if i > -1 then
    slInvalidTextures.Delete(i);
  lbTextureList.DeleteSelected();
end;

procedure TMainForm.aNewMapExecute(Sender: TObject);
begin
  if (MessageBox(0, PChar(_lc[I_MSG_CLEAR_MAP_PROMT]),
                 PChar(_lc[I_MSG_CLEAR_MAP]),
                 MB_ICONQUESTION or MB_YESNO or
                 MB_TASKMODAL or MB_DEFBUTTON1) = mrYes) then
    FullClear();
end;

procedure TMainForm.aUndoExecute(Sender: TObject);
var
  a: Integer;
begin
  if UndoBuffer = nil then
    Exit;
  if UndoBuffer[High(UndoBuffer)] = nil then
    Exit;

  for a := 0 to High(UndoBuffer[High(UndoBuffer)]) do
    with UndoBuffer[High(UndoBuffer)][a] do
    begin
      case UndoType of
        UNDO_DELETE_PANEL:
          begin
            AddPanel(Panel^);
            Panel := nil;
          end;
        UNDO_DELETE_ITEM: AddItem(Item);
        UNDO_DELETE_AREA: AddArea(Area);
        UNDO_DELETE_MONSTER: AddMonster(Monster);
        UNDO_DELETE_TRIGGER: AddTrigger(Trigger);
        UNDO_ADD_PANEL: RemoveObject(AddID, OBJECT_PANEL);
        UNDO_ADD_ITEM: RemoveObject(AddID, OBJECT_ITEM);
        UNDO_ADD_AREA: RemoveObject(AddID, OBJECT_AREA);
        UNDO_ADD_MONSTER: RemoveObject(AddID, OBJECT_MONSTER);
        UNDO_ADD_TRIGGER: RemoveObject(AddID, OBJECT_TRIGGER);
      end;
    end;

  SetLength(UndoBuffer, Length(UndoBuffer)-1);

  RemoveSelectFromObjects();

  miUndo.Enabled := UndoBuffer <> nil;
end;


procedure TMainForm.aCopyObjectExecute(Sender: TObject);
var
  a, b: Integer;
  CopyBuffer: TCopyRecArray;
  str: String;
  ok: Boolean;

  function CB_Compare(I1, I2: TCopyRec): Integer;
  begin
    Result := Integer(I1.ObjectType) - Integer(I2.ObjectType);

    if Result = 0 then // ������ ����
      Result := Integer(I1.ID) - Integer(I2.ID);
  end;

  procedure QuickSortCopyBuffer(L, R: Integer);
  var
    I, J: Integer;
    P, T: TCopyRec;
  begin
    repeat
      I := L;
      J := R;
      P := CopyBuffer[(L + R) shr 1];

      repeat
        while CB_Compare(CopyBuffer[I], P) < 0 do
          Inc(I);
        while CB_Compare(CopyBuffer[J], P) > 0 do
          Dec(J);

        if I <= J then
        begin
          T := CopyBuffer[I];
          CopyBuffer[I] := CopyBuffer[J];
          CopyBuffer[J] := T;
          Inc(I);
          Dec(J);
        end;
      until I > J;

      if L < J then
        QuickSortCopyBuffer(L, J);

      L := I;
    until I >= R;
  end;

begin
  if SelectedObjects = nil then
    Exit;

  b := -1;
  CopyBuffer := nil;

// �������� �������:
  for a := 0 to High(SelectedObjects) do
    if SelectedObjects[a].Live then
      with SelectedObjects[a] do
      begin
        SetLength(CopyBuffer, Length(CopyBuffer)+1);
        b := High(CopyBuffer);
        CopyBuffer[b].ID := ID;
        CopyBuffer[b].Panel := nil;

        case ObjectType of
          OBJECT_PANEL:
            begin
              CopyBuffer[b].ObjectType := OBJECT_PANEL;
              New(CopyBuffer[b].Panel);
              CopyBuffer[b].Panel^ := gPanels[ID];
            end;

          OBJECT_ITEM:
            begin
              CopyBuffer[b].ObjectType := OBJECT_ITEM;
              CopyBuffer[b].Item := gItems[ID];
            end;

          OBJECT_MONSTER:
            begin
              CopyBuffer[b].ObjectType := OBJECT_MONSTER;
              CopyBuffer[b].Monster := gMonsters[ID];
            end;

          OBJECT_AREA:
            begin
              CopyBuffer[b].ObjectType := OBJECT_AREA;
              CopyBuffer[b].Area := gAreas[ID];
            end;

          OBJECT_TRIGGER:
            begin
              CopyBuffer[b].ObjectType := OBJECT_TRIGGER;
              CopyBuffer[b].Trigger := gTriggers[ID];
            end;
        end;
      end;

// ���������� �� ID:
  if CopyBuffer <> nil then
  begin
    QuickSortCopyBuffer(0, b);
  end;

// ���������� ������ ���������:
  for a := 0 to Length(CopyBuffer)-1 do
    if CopyBuffer[a].ObjectType = OBJECT_TRIGGER then
    begin
      case CopyBuffer[a].Trigger.TriggerType of
        TRIGGER_OPENDOOR, TRIGGER_CLOSEDOOR, TRIGGER_DOOR,
        TRIGGER_DOOR5, TRIGGER_CLOSETRAP, TRIGGER_TRAP,
        TRIGGER_LIFTUP, TRIGGER_LIFTDOWN, TRIGGER_LIFT:
          if CopyBuffer[a].Trigger.Data.PanelID <> -1 then
          begin
            ok := False;

            for b := 0 to Length(CopyBuffer)-1 do
              if (CopyBuffer[b].ObjectType = OBJECT_PANEL) and
                 (Integer(CopyBuffer[b].ID) = CopyBuffer[a].Trigger.Data.PanelID) then
              begin
                CopyBuffer[a].Trigger.Data.PanelID := b;
                ok := True;
                Break;
              end;

          // ���� ������� ��� ����� ����������:
            if not ok then
              CopyBuffer[a].Trigger.Data.PanelID := -1;
          end;
              
        TRIGGER_PRESS, TRIGGER_ON,
        TRIGGER_OFF, TRIGGER_ONOFF:
          if CopyBuffer[a].Trigger.Data.MonsterID <> 0 then
          begin
            ok := False;

            for b := 0 to Length(CopyBuffer)-1 do
              if (CopyBuffer[b].ObjectType = OBJECT_MONSTER) and
                 (Integer(CopyBuffer[b].ID) = CopyBuffer[a].Trigger.Data.MonsterID-1) then
              begin
                CopyBuffer[a].Trigger.Data.MonsterID := b+1;
                ok := True;
                Break;
              end;

          // ���� �������� ��� ����� ����������:
            if not ok then
              CopyBuffer[a].Trigger.Data.MonsterID := 0;
          end;
      end;

      if CopyBuffer[a].Trigger.TexturePanel <> -1 then
      begin
        ok := False;

        for b := 0 to Length(CopyBuffer)-1 do
          if (CopyBuffer[b].ObjectType = OBJECT_PANEL) and
             (Integer(CopyBuffer[b].ID) = CopyBuffer[a].Trigger.TexturePanel) then
          begin
            CopyBuffer[a].Trigger.TexturePanel := b;
            ok := True;
            Break;
          end;

      // ���� ������� ��� ����� ����������:
        if not ok then
          CopyBuffer[a].Trigger.TexturePanel := -1;
      end;
    end;

// � ����� ������:
  str := CopyBufferToString(CopyBuffer);
  ClipBoard.AsText := str;

  for a := 0 to Length(CopyBuffer)-1 do
    if (CopyBuffer[a].ObjectType = OBJECT_PANEL) and
       (CopyBuffer[a].Panel <> nil) then
      Dispose(CopyBuffer[a].Panel);

  CopyBuffer := nil;
end;

procedure TMainForm.aPasteObjectExecute(Sender: TObject);
var
  a, h: Integer;
  CopyBuffer: TCopyRecArray;
  res: Boolean;
  swad, ssec, sres: String;
begin
  CopyBuffer := nil;

  StringToCopyBuffer(ClipBoard.AsText, CopyBuffer);

  if CopyBuffer = nil then
    Exit;

  RemoveSelectFromObjects();

  h := High(CopyBuffer);
  for a := 0 to h do
    with CopyBuffer[a] do
    begin
      case ObjectType of
        OBJECT_PANEL:
          if Panel <> nil then
          begin
            Panel^.X := Panel^.X + 16;
            Panel^.Y := Panel^.Y + 16;

            Panel^.TextureID := TEXTURE_SPECIAL_NONE;
            Panel^.TextureWidth := 1;
            Panel^.TextureHeight := 1;

            if (Panel^.PanelType = PANEL_LIFTUP) or
               (Panel^.PanelType = PANEL_LIFTDOWN) or
               (Panel^.PanelType = PANEL_LIFTLEFT) or
               (Panel^.PanelType = PANEL_LIFTRIGHT) or
               (Panel^.PanelType = PANEL_BLOCKMON) or
               (Panel^.TextureName = '') then
              begin // ��� ��� �� ����� ���� ��������:
              end
            else // ���� ��������:
              begin
              // ������� ��������:
                if not IsSpecialTexture(Panel^.TextureName) then
                  begin
                    res := g_GetTexture(Panel^.TextureName, Panel^.TextureID);

                    if not res then
                    begin
                      g_ProcessResourceStr(Panel^.TextureName, swad, ssec, sres);
                      AddTexture(swad, ssec, sres, True);
                      res := g_GetTexture(Panel^.TextureName, Panel^.TextureID);
                    end;

                    if res then
                      g_GetTextureSizeByName(Panel^.TextureName,
                        Panel^.TextureWidth, Panel^.TextureHeight)
                    else
                      Panel^.TextureName := '';
                  end
                else // ����.��������:
                  begin
                    Panel^.TextureID := SpecialTextureID(Panel^.TextureName);
                    with MainForm.lbTextureList.Items do
                      if IndexOf(Panel^.TextureName) = -1 then
                        Add(Panel^.TextureName);
                  end;
              end;

            ID := AddPanel(Panel^);
            Dispose(Panel);
            Undo_Add(OBJECT_PANEL, ID, a > 0);
            SelectObject(OBJECT_PANEL, ID, True);
          end;

        OBJECT_ITEM:
          begin
            Item.X := Item.X + 16;
            Item.Y := Item.Y + 16;

            ID := AddItem(Item);
            Undo_Add(OBJECT_ITEM, ID, a > 0);
            SelectObject(OBJECT_ITEM, ID, True);
          end;

        OBJECT_MONSTER:
          begin
            Monster.X := Monster.X + 16;
            Monster.Y := Monster.Y + 16;

            ID := AddMonster(Monster);
            Undo_Add(OBJECT_MONSTER, ID, a > 0);
            SelectObject(OBJECT_MONSTER, ID, True);
          end;

        OBJECT_AREA:
          begin
            Area.X := Area.X + 16;
            Area.Y := Area.Y + 16;

            ID := AddArea(Area);
            Undo_Add(OBJECT_AREA, ID, a > 0);
            SelectObject(OBJECT_AREA, ID, True);
          end;

        OBJECT_TRIGGER:
          begin
            Trigger.X := Trigger.X + 16;
            Trigger.Y := Trigger.Y + 16;

            ID := AddTrigger(Trigger);
            Undo_Add(OBJECT_TRIGGER, ID, a > 0);
            SelectObject(OBJECT_TRIGGER, ID, True);
          end;
      end;
    end;

// ������������ ������ ���������:
  for a := 0 to High(CopyBuffer) do
    if CopyBuffer[a].ObjectType = OBJECT_TRIGGER then
    begin
      case CopyBuffer[a].Trigger.TriggerType of
        TRIGGER_OPENDOOR, TRIGGER_CLOSEDOOR, TRIGGER_DOOR,
        TRIGGER_DOOR5, TRIGGER_CLOSETRAP, TRIGGER_TRAP,
        TRIGGER_LIFTUP, TRIGGER_LIFTDOWN, TRIGGER_LIFT:
          if CopyBuffer[a].Trigger.Data.PanelID <> -1 then
            gTriggers[CopyBuffer[a].ID].Data.PanelID :=
              CopyBuffer[CopyBuffer[a].Trigger.Data.PanelID].ID;

        TRIGGER_PRESS, TRIGGER_ON,
        TRIGGER_OFF, TRIGGER_ONOFF:
          if CopyBuffer[a].Trigger.Data.MonsterID <> 0 then
            gTriggers[CopyBuffer[a].ID].Data.MonsterID :=
              CopyBuffer[CopyBuffer[a].Trigger.Data.MonsterID-1].ID+1;
      end;

      if CopyBuffer[a].Trigger.TexturePanel <> -1 then
        gTriggers[CopyBuffer[a].ID].TexturePanel :=
          CopyBuffer[CopyBuffer[a].Trigger.TexturePanel].ID;
    end;

  CopyBuffer := nil;

  if h = 0 then
    FillProperty();
end;

procedure TMainForm.aCutObjectExecute(Sender: TObject);
begin
  miCopy.Click();
  DeleteSelectedObjects();
end;

procedure TMainForm.vleObjectPropertyEditButtonClick(Sender: TObject);
var
  Key, FileName: String;
  b: Byte;
begin
  Key := vleObjectProperty.Keys[vleObjectProperty.Row];

  if Key = _lc[I_PROP_TR_TELEPORT_TO] then
    SelectFlag := SELECTFLAG_TELEPORT
  else if Key = _lc[I_PROP_TR_SPAWN_TO] then
    SelectFlag := SELECTFLAG_SPAWNPOINT
  else if (Key = _lc[I_PROP_TR_DOOR_PANEL]) or
          (Key = _lc[I_PROP_TR_TRAP_PANEL]) then
    SelectFlag := SELECTFLAG_DOOR
  else if Key = _lc[I_PROP_TR_TEXTURE_PANEL] then
    SelectFlag := SELECTFLAG_TEXTURE
  else if Key = _lc[I_PROP_TR_LIFT_PANEL] then
    SelectFlag := SELECTFLAG_LIFT
  else if key = _lc[I_PROP_TR_EX_MONSTER] then
    SelectFlag := SELECTFLAG_MONSTER
  else if Key = _lc[I_PROP_TR_EX_AREA] then
    DrawPressRect := True
  else if Key = _lc[I_PROP_TR_NEXT_MAP] then
    begin // ����� ��������� �����:
      g_ProcessResourceStr(OpenedMap, @FileName, nil, nil);
      SelectMapForm.GetMaps(FileName);

      if SelectMapForm.ShowModal() = mrOK then
      begin
        vleObjectProperty.Values[Key] := SelectMapForm.lbMapList.Items[SelectMapForm.lbMapList.ItemIndex];
        bApplyProperty.Click();
      end;
    end
  else if (Key = _lc[I_PROP_TR_SOUND_NAME]) or
          (Key = _lc[I_PROP_TR_MUSIC_NAME]) then
    begin // ����� ����� �����/������:
      AddSoundForm.OKFunction := nil;
      AddSoundForm.lbResourcesList.MultiSelect := False;
      AddSoundForm.SetResource := vleObjectProperty.Values[Key];

      if (AddSoundForm.ShowModal() = mrOk) then
      begin
        vleObjectProperty.Values[Key] := AddSoundForm.ResourceName;
        bApplyProperty.Click();
      end;
    end
  else if Key = _lc[I_PROP_TR_ACTIVATION] then
    with ActivationTypeForm, vleObjectProperty do
    begin // ����� ����� ���������:
      cbPlayerCollide.Checked := Pos('PC', Values[Key]) > 0;
      cbMonsterCollide.Checked := Pos('MC', Values[Key]) > 0;
      cbPlayerPress.Checked := Pos('PP', Values[Key]) > 0;
      cbMonsterPress.Checked := Pos('MP', Values[Key]) > 0;
      cbShot.Checked := Pos('SH', Values[Key]) > 0;
      cbNoMonster.Checked := Pos('NM', Values[Key]) > 0;

      if ShowModal() = mrOK then
      begin
        b := 0;
        if cbPlayerCollide.Checked then
          b := ACTIVATE_PLAYERCOLLIDE;
        if cbMonsterCollide.Checked then
          b := b or ACTIVATE_MONSTERCOLLIDE;
        if cbPlayerPress.Checked then
          b := b or ACTIVATE_PLAYERPRESS;
        if cbMonsterPress.Checked then
          b := b or ACTIVATE_MONSTERPRESS;
        if cbShot.Checked then
          b := b or ACTIVATE_SHOT;
        if cbNoMonster.Checked then
          b := b or ACTIVATE_NOMONSTER;

        Values[Key] := ActivateToStr(b);
        bApplyProperty.Click();
      end;
    end
  else if Key = _lc[I_PROP_TR_KEYS] then
    with KeysForm, vleObjectProperty do
    begin // ����� ����������� ������:
      cbRedKey.Checked := Pos('RK', Values[Key]) > 0;
      cbGreenKey.Checked := Pos('GK', Values[Key]) > 0;
      cbBlueKey.Checked := Pos('BK', Values[Key]) > 0;
      cbRedTeam.Checked := Pos('RT', Values[Key]) > 0;
      cbBlueTeam.Checked := Pos('BT', Values[Key]) > 0;
      
      if ShowModal() = mrOK then
      begin
        b := 0;
        if cbRedKey.Checked then
          b := KEY_RED;
        if cbGreenKey.Checked then
          b := b or KEY_GREEN;
        if cbBlueKey.Checked then
          b := b or KEY_BLUE;
        if cbRedTeam.Checked then
          b := b or KEY_REDTEAM;
        if cbBlueTeam.Checked then
          b := b or KEY_BLUETEAM;

        Values[Key] := KeyToStr(b);
        bApplyProperty.Click();
      end;
    end
  else if Key = _lc[I_PROP_TR_FX_TYPE] then
    with ChooseTypeForm, vleObjectProperty do
    begin // ����� ���� �������:
      Caption := _lc[I_CAP_FX_TYPE];
      lbTypeSelect.Items.Clear();

      for b := EFFECT_NONE to EFFECT_FIRE do
        lbTypeSelect.Items.Add(EffectToStr(b));

      lbTypeSelect.ItemIndex := StrToEffect(Values[Key]);

      if ShowModal() = mrOK then
      begin
        b := lbTypeSelect.ItemIndex;
        Values[Key] := EffectToStr(b);
        bApplyProperty.Click();
      end;
    end
  else if Key = _lc[I_PROP_TR_MONSTER_TYPE] then
    with ChooseTypeForm, vleObjectProperty do
    begin // ����� ���� �������:
      Caption := _lc[I_CAP_MONSTER_TYPE];
      lbTypeSelect.Items.Clear();

      for b := MONSTER_DEMON to MONSTER_MAN do
        lbTypeSelect.Items.Add(MonsterToStr(b));

      lbTypeSelect.ItemIndex := StrToMonster(Values[Key]) - MONSTER_DEMON;

      if ShowModal() = mrOK then
      begin
        b := lbTypeSelect.ItemIndex + MONSTER_DEMON;
        Values[Key] := MonsterToStr(b);
        bApplyProperty.Click();
      end;
    end
  else if Key = _lc[I_PROP_TR_ITEM_TYPE] then
    with ChooseTypeForm, vleObjectProperty do
    begin // ����� ���� ��������:
      Caption := _lc[I_CAP_ITEM_TYPE];
      lbTypeSelect.Items.Clear();

      for b := ITEM_MEDKIT_SMALL to ITEM_KEY_BLUE do
        lbTypeSelect.Items.Add(ItemToStr(b));
      lbTypeSelect.Items.Add(ItemToStr(ITEM_BOTTLE));
      lbTypeSelect.Items.Add(ItemToStr(ITEM_HELMET));
      lbTypeSelect.Items.Add(ItemToStr(ITEM_JETPACK));
      lbTypeSelect.Items.Add(ItemToStr(ITEM_INVIS));

      b := StrToItem(Values[Key]);
      if b >= ITEM_BOTTLE then
        b := b - 2;
      lbTypeSelect.ItemIndex := b - ITEM_MEDKIT_SMALL;

      if ShowModal() = mrOK then
      begin
        b := lbTypeSelect.ItemIndex + ITEM_MEDKIT_SMALL;
        if b >= ITEM_WEAPON_KASTET then
          b := b + 2;
        Values[Key] := ItemToStr(b);
        bApplyProperty.Click();
      end;
    end
  else if Key = _lc[I_PROP_TR_SHOT_TYPE] then
    with ChooseTypeForm, vleObjectProperty do
    begin // ����� ���� ��������:
      Caption := _lc[I_PROP_TR_SHOT_TYPE];
      lbTypeSelect.Items.Clear();

      for b := TRIGGER_SHOT_BULLET to TRIGGER_SHOT_REV do
        lbTypeSelect.Items.Add(ShotToStr(b));

      lbTypeSelect.ItemIndex := StrToShot(Values[Key]) - TRIGGER_SHOT_BULLET;

      if ShowModal() = mrOK then
      begin
        b := lbTypeSelect.ItemIndex + TRIGGER_SHOT_BULLET;
        Values[Key] := ShotToStr(b);
        bApplyProperty.Click();
      end;
    end
  else if Key = _lc[I_PROP_PANEL_TEX] then
    begin // ����� ��������:
      vleObjectProperty.Values[Key] := SelectedTexture();
      bApplyProperty.Click();
    end;
end;

procedure TMainForm.aSaveMapExecute(Sender: TObject);
var
  FileName, Section, Res: String;
begin
  if OpenedMap = '' then
  begin
    aSaveMapAsExecute(nil);
    Exit;
  end;

  g_ProcessResourceStr(OpenedMap, FileName, Section, Res);

  SaveMap(FileName+':\'+Res);
end;

procedure TMainForm.aOpenMapExecute(Sender: TObject);
begin
  OpenDialog.Filter := _lc[I_FILE_FILTER_ALL];

  if OpenDialog.Execute() then
  begin
    if (Pos('.ini', LowerCase(ExtractFileName(OpenDialog.FileName))) > 0) then
      begin // INI �����:
        FullClear();

        pLoadProgress.Left := (RenderPanel.Width div 2)-(pLoadProgress.Width div 2);
        pLoadProgress.Top := (RenderPanel.Height div 2)-(pLoadProgress.Height div 2);
        pLoadProgress.Show();

        OpenedMap := '';
        OpenedWAD := '';

        LoadMapOld(OpenDialog.FileName);

        MainForm.Caption := Format('%s - %s', [FormCaption, ExtractFileName(OpenDialog.FileName)]);

        pLoadProgress.Hide();
        MainForm.FormResize(Self);
      end
    else // ����� �� WAD:
      begin
        OpenMap(OpenDialog.FileName, '');
      end;

    OpenDialog.InitialDir := ExtractFileDir(OpenDialog.FileName);
  end;
end;

procedure TMainForm.FormActivate(Sender: TObject);
var
  lang: Integer;
  config: TConfig;
begin
  MainForm.ActiveControl := RenderPanel;

// ����:
  if gLanguage = '' then
  begin
    lang := SelectLanguageForm.ShowModal();
    case lang of
      1:   gLanguage := LANGUAGE_ENGLISH;
      else gLanguage := LANGUAGE_RUSSIAN;
    end;

    config := TConfig.CreateFile(EditorDir+'\Editor.cfg');
    config.WriteStr('Editor', 'Language', gLanguage);
    config.SaveFile(EditorDir+'\Editor.cfg');
    config.Free();
  end;

  //e_WriteLog('Read language file', MSG_NOTIFY);
  //g_Language_Load(EditorDir+'\data\'+gLanguage+LANGUAGE_FILE_NAME);
  g_Language_Set(gLanguage);
end;

procedure TMainForm.aDeleteMap(Sender: TObject);
var
  WAD: TWADEditor_1;
  MapList: SArray;
  MapName: Char16;
  a: Integer;
  str: String;
begin
  OpenDialog.Filter := _lc[I_FILE_FILTER_WAD];

  if not OpenDialog.Execute() then
    Exit;

  WAD := TWADEditor_1.Create();

  if not WAD.ReadFile(OpenDialog.FileName) then
  begin
    WAD.Free();
    Exit;
  end;

  WAD.CreateImage();

  MapList := WAD.GetResourcesList('');

  SelectMapForm.lbMapList.Items.Clear();

  if MapList <> nil then
    for a := 0 to High(MapList) do
      SelectMapForm.lbMapList.Items.Add(MapList[a]);

  if (SelectMapForm.ShowModal() = mrOK) then
  begin
    str := SelectMapForm.lbMapList.Items[SelectMapForm.lbMapList.ItemIndex];
    MapName := '';
    CopyMemory(@MapName[0], @str[1], Min(16, Length(str)));

    if MessageBox(0, PChar(Format(_lc[I_MSG_DELETE_MAP_PROMT],
                           [MapName, OpenDialog.FileName])),
                  PChar(_lc[I_MSG_DELETE_MAP]),
                  MB_ICONQUESTION or MB_YESNO or
                  MB_TASKMODAL or MB_DEFBUTTON2) <> mrYes then
      Exit;

    WAD.RemoveResource('', MapName);
    
    MessageBox(0, PChar(Format(_lc[I_MSG_MAP_DELETED_PROMT],
                               [MapName])),
               PChar(_lc[I_MSG_MAP_DELETED]),
               MB_ICONINFORMATION or MB_OK or
               MB_TASKMODAL or MB_DEFBUTTON1);

    WAD.SaveTo(OpenDialog.FileName);

  // ������� ������� ����� - ��������� �� ������� �� ������:
    if OpenedMap = (OpenDialog.FileName+':\'+MapName) then
    begin
      OpenedMap := '';
      OpenedWAD := '';
      MainForm.Caption := FormCaption;
    end;
  end;

  WAD.Free();
end;

procedure TMainForm.vleObjectPropertyKeyDown(Sender: TObject;
            var Key: Word; Shift: TShiftState);
begin
  if Key = VK_RETURN then
    bApplyProperty.Click();
end;

procedure MovePanel(var ID: DWORD; MoveType: Byte);
var
  _id, a: Integer;
  tmp: TPanel;
begin
  if (ID = 0) and (MoveType = 0) then
    Exit;
  if (ID = DWORD(High(gPanels))) and (MoveType <> 0) then
    Exit;
  if (ID > DWORD(High(gPanels))) then
    Exit;

  _id := Integer(ID);

  if MoveType = 0 then // to Back
    begin
      if gTriggers <> nil then
        for a := 0 to High(gTriggers) do
          with gTriggers[a] do
          begin
            if TriggerType = TRIGGER_NONE then
              Continue;

            if TexturePanel = _id then
              TexturePanel := 0
            else
              if (TexturePanel >= 0) and (TexturePanel < _id) then
                Inc(TexturePanel);

            case TriggerType of
              TRIGGER_OPENDOOR, TRIGGER_CLOSEDOOR, TRIGGER_DOOR,
              TRIGGER_DOOR5, TRIGGER_CLOSETRAP, TRIGGER_TRAP,
              TRIGGER_LIFTUP, TRIGGER_LIFTDOWN, TRIGGER_LIFT:
                if Data.PanelID = _id then
                  Data.PanelID := 0
                else
                  if (Data.PanelID >= 0) and (Data.PanelID < _id) then
                    Inc(Data.PanelID);
            end;
          end;

      tmp := gPanels[_id];

      for a := _id downto 1 do
        gPanels[a] := gPanels[a-1];

      gPanels[0] := tmp;

      ID := 0;
    end
  else // to Front
    begin
      if gTriggers <> nil then
        for a := 0 to High(gTriggers) do
          with gTriggers[a] do
          begin
            if TriggerType = TRIGGER_NONE then
              Continue;

            if TexturePanel = _id then
              TexturePanel := High(gPanels)
            else
              if TexturePanel > _id then
                Dec(TexturePanel);

            case TriggerType of
              TRIGGER_OPENDOOR, TRIGGER_CLOSEDOOR, TRIGGER_DOOR,
              TRIGGER_DOOR5, TRIGGER_CLOSETRAP, TRIGGER_TRAP,
              TRIGGER_LIFTUP, TRIGGER_LIFTDOWN, TRIGGER_LIFT:
                if Data.PanelID = _id then
                  Data.PanelID := High(gPanels)
                else
                  if Data.PanelID > _id then
                    Dec(Data.PanelID);
            end;
          end;

      tmp := gPanels[_id];

      for a := _id to High(gPanels)-1 do
        gPanels[a] := gPanels[a+1];

      gPanels[High(gPanels)] := tmp;

      ID := High(gPanels);
    end;
end;

procedure TMainForm.aMoveToBack(Sender: TObject);
var
  a: Integer;
begin
  if SelectedObjects = nil then
    Exit;

  for a := 0 to High(SelectedObjects) do
    with SelectedObjects[a] do
      if Live and (ObjectType = OBJECT_PANEL) then
      begin
        SelectedObjects[0] := SelectedObjects[a];
        SetLength(SelectedObjects, 1);
        MovePanel(ID, 0);
        FillProperty();
        Break;
      end;
end;

procedure TMainForm.aMoveToFore(Sender: TObject);
var
  a: Integer;
begin
  if SelectedObjects = nil then
    Exit;

  for a := 0 to High(SelectedObjects) do
    with SelectedObjects[a] do
      if Live and (ObjectType = OBJECT_PANEL) then
      begin
        SelectedObjects[0] := SelectedObjects[a];
        SetLength(SelectedObjects, 1);
        MovePanel(ID, 1);
        FillProperty();
        Break;
      end;
end;

procedure TMainForm.aSaveMapAsExecute(Sender: TObject);
var
  idx: Integer;
begin
  SaveDialog.Filter := _lc[I_FILE_FILTER_WAD];

  if not SaveDialog.Execute() then
    Exit;

  SaveMapForm.GetMaps(SaveDialog.FileName, True);

  if SaveMapForm.ShowModal() <> mrOK then
    Exit;

  SaveDialog.InitialDir := ExtractFileDir(SaveDialog.FileName);
  OpenedMap := SaveDialog.FileName+':\'+SaveMapForm.eMapName.Text;
  OpenedWAD := SaveDialog.FileName;

  idx := RecentFiles.IndexOf(OpenedMap);
// ����� ����� ��� ������� �����������:
  if idx >= 0 then
    RecentFiles.Delete(idx);
  RecentFiles.Insert(0, OpenedMap);
  RefreshRecentMenu;

  SaveMap(OpenedMap);

  gMapInfo.FileName := SaveDialog.FileName;
  gMapInfo.MapName := SaveMapForm.eMapName.Text;
  UpdateCaption(gMapInfo.Name, ExtractFileName(gMapInfo.FileName), gMapInfo.MapName);
end;

procedure TMainForm.aSelectAllExecute(Sender: TObject);
var
  a: Integer;
begin
  RemoveSelectFromObjects();

  case pcObjects.ActivePageIndex+1 of
    OBJECT_PANEL:
      if gPanels <> nil then
        for a := 0 to High(gPanels) do
          if gPanels[a].PanelType <> PANEL_NONE then
            SelectObject(OBJECT_PANEL, a, True);
    OBJECT_ITEM:
      if gItems <> nil then
        for a := 0 to High(gItems) do
          if gItems[a].ItemType <> ITEM_NONE then
            SelectObject(OBJECT_ITEM, a, True);
    OBJECT_MONSTER:
      if gMonsters <> nil then
        for a := 0 to High(gMonsters) do
          if gMonsters[a].MonsterType <> MONSTER_NONE then
            SelectObject(OBJECT_MONSTER, a, True);
    OBJECT_AREA:
      if gAreas <> nil then
        for a := 0 to High(gAreas) do
          if gAreas[a].AreaType <> AREA_NONE then
            SelectObject(OBJECT_AREA, a, True);
    OBJECT_TRIGGER:
      if gTriggers <> nil then
        for a := 0 to High(gTriggers) do
          if gTriggers[a].TriggerType <> TRIGGER_NONE then
            SelectObject(OBJECT_TRIGGER, a, True);
  end;
end;

procedure TMainForm.tbGridOnClick(Sender: TObject);
begin
  DotEnable := not DotEnable;
  (Sender as TToolButton).Down := DotEnable;
end;

procedure TMainForm.OnIdle(Sender: TObject; var Done: Boolean);
begin
  Draw();
end;

procedure TMainForm.miMapPreviewClick(Sender: TObject);
begin
  if not PreviewMode then
    begin
      Splitter2.Visible := False;
      Splitter1.Visible := False;
      StatusBar.Visible := False;
      PanelObjs.Visible := False;
      PanelProps.Visible := False;
      MainToolBar.Visible := False;
      sbHorizontal.Visible := False;
      sbVertical.Visible := False;
    end
  else
    begin
      StatusBar.Visible := True;
      PanelObjs.Visible := True;
      PanelProps.Visible := True;
      Splitter2.Visible := True;
      Splitter1.Visible := True;
      MainToolBar.Visible := True;
      sbHorizontal.Visible := True;
      sbVertical.Visible := True;
    end;

  PreviewMode := not PreviewMode;
  (Sender as TMenuItem).Checked := PreviewMode;
end;

procedure TMainForm.miLayer1Click(Sender: TObject);
begin
  SwitchLayer(LAYER_BACK);
end;

procedure TMainForm.miLayer2Click(Sender: TObject);
begin
  SwitchLayer(LAYER_WALLS);
end;

procedure TMainForm.miLayer3Click(Sender: TObject);
begin
  SwitchLayer(LAYER_FOREGROUND);
end;

procedure TMainForm.miLayer4Click(Sender: TObject);
begin
  SwitchLayer(LAYER_STEPS);
end;

procedure TMainForm.miLayer5Click(Sender: TObject);
begin
  SwitchLayer(LAYER_WATER);
end;

procedure TMainForm.miLayer6Click(Sender: TObject);
begin
  SwitchLayer(LAYER_ITEMS);
end;

procedure TMainForm.miLayer7Click(Sender: TObject);
begin
  SwitchLayer(LAYER_MONSTERS);
end;

procedure TMainForm.miLayer8Click(Sender: TObject);
begin
  SwitchLayer(LAYER_AREAS);
end;

procedure TMainForm.miLayer9Click(Sender: TObject);
begin
  SwitchLayer(LAYER_TRIGGERS);
end;

procedure TMainForm.tbShowClick(Sender: TObject);
var
  a: Integer;
  b: Boolean;
begin
  b := True;
  for a := 0 to High(LayerEnabled) do
    b := b and LayerEnabled[a];

  b := not b;

  ShowLayer(LAYER_BACK, b);
  ShowLayer(LAYER_WALLS, b);
  ShowLayer(LAYER_FOREGROUND, b);
  ShowLayer(LAYER_STEPS, b);
  ShowLayer(LAYER_WATER, b);
  ShowLayer(LAYER_ITEMS, b);
  ShowLayer(LAYER_MONSTERS, b);
  ShowLayer(LAYER_AREAS, b);
  ShowLayer(LAYER_TRIGGERS, b);
end;

procedure TMainForm.miMiniMapClick(Sender: TObject);
begin
  SwitchMap();
end;

procedure TMainForm.miSwitchGridClick(Sender: TObject);
begin
  if DotStep = DotStepOne then
    DotStep := DotStepTwo
  else
    DotStep := DotStepOne;

  MousePos.X := (MousePos.X div DotStep) * DotStep;
  MousePos.Y := (MousePos.Y div DotStep) * DotStep;
end;

procedure TMainForm.miShowEdgesClick(Sender: TObject);
begin
  ShowEdges();
end;

procedure TMainForm.miSnapToGridClick(Sender: TObject);
begin
  SnapToGrid := not SnapToGrid;

  MousePos.X := (MousePos.X div DotStep) * DotStep;
  MousePos.Y := (MousePos.Y div DotStep) * DotStep;

  miSnapToGrid.Checked := SnapToGrid;
end;

procedure TMainForm.minexttabClick(Sender: TObject);
begin
  if pcObjects.ActivePageIndex < pcObjects.PageCount-1 then
    pcObjects.ActivePageIndex := pcObjects.ActivePageIndex+1
  else
    pcObjects.ActivePageIndex := 0;
end;

procedure TMainForm.miSaveMiniMapClick(Sender: TObject);
begin
  SaveMiniMapForm.ShowModal();
end;

procedure TMainForm.bClearTextureClick(Sender: TObject);
begin
  lbTextureList.ItemIndex := -1;
  lTextureWidth.Caption := '';
  lTextureHeight.Caption := '';
end;

procedure TMainForm.miPackMapClick(Sender: TObject);
begin
  PackMapForm.ShowModal();
end;

procedure TMainForm.miMapTestSettingsClick(Sender: TObject);
begin
  MapTestForm.ShowModal();
end;

procedure TMainForm.miTestMapClick(Sender: TObject);
var
  NewMap: Boolean;
  cmd, dir, mapWAD, mapToRun: String;
  opt: LongWord;
  time: Integer;
  si: STARTUPINFO;
  pi: PROCESS_INFORMATION;
  lpMsgBuf: PChar;
begin
// ����� �����:
  NewMap := OpenedMap = '';
  if NewMap then
  begin
  // ��������� ��������� �����:
    time := 0;
    repeat
      mapWAD := ExtractFilePath(TestD2dExe) + Format('maps\temp%.4d.wad', [time]);
      Inc(time);
    until not FileExists(mapWAD);
    mapToRun := mapWAD + ':\' + TEST_MAP_NAME;
    SaveMap(mapToRun);
  end else
  begin
  // ��������� ��� �������� ������:
    g_ProcessResourceStr(OpenedMap, mapWAD, cmd, dir);
    mapToRun := mapWAD + ':\' + TEST_MAP_NAME;
    time := g_GetFileTime(mapWAD);
    SaveMap(mapToRun);
    g_SetFileTime(mapWAD, time);
  end;

// ����� ����:
  opt := 32 + 64;
  if TestOptionsTwoPlayers then
    opt := opt + 1;
  if TestOptionsTeamDamage then
    opt := opt + 2;
  if TestOptionsAllowExit then
    opt := opt + 4;
  if TestOptionsWeaponStay then
    opt := opt + 8;
  if TestOptionsMonstersDM then
    opt := opt + 16;

// ������� � Doom2DF.exe:
  dir := ExtractFilePath(TestD2dExe);

// ���������� ��������� ������:
  cmd := '"' + TestD2dExe + '"';
  cmd := cmd + ' -map "' + mapToRun + '"';
  cmd := cmd + ' -gm ' + TestGameMode;
  cmd := cmd + ' -limt ' + TestLimTime;
  cmd := cmd + ' -lims ' + TestLimScore;
  cmd := cmd + ' -opt ' + IntToStr(opt);

  if TestMapOnce then
    cmd := cmd + ' --close';

  cmd := cmd + ' --debug';

  if NewMap then
    cmd := cmd + ' --tempdelete'
  else
    cmd := cmd + ' --testdelete';

// ���������:
  ZeroMemory(@si, SizeOf(si));
  si.cb := SizeOf(si);
  ZeroMemory(@pi, SizeOf(pi));

  if not CreateProcess(nil, PChar(cmd),
                       nil, nil, False, 0, nil,
                       PChar(dir),
                       si, pi) then
  begin
    FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
                  nil, GetLastError(), LANG_SYSTEM_DEFAULT,
                  @lpMsgBuf, 0, nil);
    MessageBox(0, lpMsgBuf,
               PChar(_lc[I_MSG_EXEC_ERROR]),
               MB_OK or MB_ICONERROR);
  end;
end;

procedure TMainForm.sbVerticalScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  MapOffset.Y := -Normalize16(sbVertical.Position);
end;

procedure TMainForm.sbHorizontalScroll(Sender: TObject;
  ScrollCode: TScrollCode; var ScrollPos: Integer);
begin
  MapOffset.X := -Normalize16(sbHorizontal.Position);
end;

procedure TMainForm.miOpenWadMapClick(Sender: TObject);
begin
  if OpenedWAD <> '' then
  begin
    OpenMap(OpenedWAD, '');
  end;
end;

procedure TMainForm.selectall1Click(Sender: TObject);
var
  a: Integer;
begin
  RemoveSelectFromObjects();

  if gPanels <> nil then
    for a := 0 to High(gPanels) do
      if gPanels[a].PanelType <> PANEL_NONE then
        SelectObject(OBJECT_PANEL, a, True);

  if gItems <> nil then
    for a := 0 to High(gItems) do
      if gItems[a].ItemType <> ITEM_NONE then
        SelectObject(OBJECT_ITEM, a, True);

  if gMonsters <> nil then
    for a := 0 to High(gMonsters) do
      if gMonsters[a].MonsterType <> MONSTER_NONE then
        SelectObject(OBJECT_MONSTER, a, True);

  if gAreas <> nil then
    for a := 0 to High(gAreas) do
      if gAreas[a].AreaType <> AREA_NONE then
        SelectObject(OBJECT_AREA, a, True);

  if gTriggers <> nil then
    for a := 0 to High(gTriggers) do
      if gTriggers[a].TriggerType <> TRIGGER_NONE then
        SelectObject(OBJECT_TRIGGER, a, True);
end;

procedure TMainForm.Splitter1CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := (NewSize > 140);
end;

procedure TMainForm.Splitter2CanResize(Sender: TObject;
  var NewSize: Integer; var Accept: Boolean);
begin
  Accept := (NewSize > 110);
end;

procedure TMainForm.vleObjectPropertyEnter(Sender: TObject);
begin
  EditingProperties := True;
end;

procedure TMainForm.vleObjectPropertyExit(Sender: TObject);
begin
  EditingProperties := False;
end;

procedure TMainForm.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
// ������� �������������:
  if MainForm.ActiveControl = RenderPanel then
  begin
    if (Key = VK_NUMPAD4) or
       (Key = VK_NUMPAD6) or
       (Key = VK_NUMPAD8) or
       (Key = VK_NUMPAD5) or
       (Key = Ord('V')) then
      FillProperty();
  end;
end;

procedure TMainForm.lbTextureListDrawItem(Control: TWinControl;
  Index: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  with Control as TListBox do
  begin
    if odSelected in State then
    begin
      Canvas.Brush.Color := clHighlight;
      Canvas.Font.Color := clHighlightText;
    end else
      if slInvalidTextures.IndexOf(Items[Index]) > -1 then
      begin
        Canvas.Brush.Color := clRed;
        Canvas.Font.Color := clWhite;
      end;
    Canvas.FillRect(Rect);
    Canvas.TextRect(Rect, Rect.Left, Rect.Top, Items[Index]);
  end;
end;

end.
