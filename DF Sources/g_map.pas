Unit g_map;

Interface

Uses
  e_graphics, g_basic, MAPSTRUCT, windows, g_textures, Classes,
  g_phys, WADEDITOR, BinEditor, g_panel, md5asm;

Type
  TMapInfo = record
    Map:           String;
    Name:          String;
    Description:   String;
    Author:        String;
    MusicName:     String;
    SkyName:       String;
    Height:        Word;
    Width:         Word;
  end;

  PRespawnPoint = ^TRespawnPoint;
  TRespawnPoint = record
    X, Y:      Integer;
    Direction: TDirection;
    PointType: Byte;
  end;

  PFlagPoint = ^TFlagPoint;
  TFlagPoint = TRespawnPoint;

  PFlag = ^TFlag;
  TFlag = record
    Obj:         TObj;
    RespawnType: Byte;
    State:       Byte;
    Count:       Integer;
    Animation:   TAnimation;
    Direction:   TDirection;
  end;


function  g_Map_Load(Res: String): Boolean;
function  g_Map_GetMapInfo(Res: String): TMapInfo;
function  g_Map_GetMapsList(WADName: String): SArray;
function  g_Map_Exist(Res: String): Boolean;
procedure g_Map_Free();
procedure g_Map_Update();
procedure g_Map_DrawPanels(PanelType: Word);
procedure g_Map_DrawBack(dx, dy: Integer);
function  g_Map_CollidePanel(X, Y: Integer; Width, Height: Word;
                             PanelType: Word; b1x3: Boolean): Boolean;
function  g_Map_CollideLiquid_Texture(X, Y: Integer; Width, Height: Word): DWORD;
procedure g_Map_EnableWall(ID: DWORD);
procedure g_Map_DisableWall(ID: DWORD);
procedure g_Map_SwitchTexture(PanelType: Word; ID: DWORD; AnimLoop: Byte = 0);
procedure g_Map_SetLift(ID: DWORD; t: Integer);
procedure g_Map_ReAdd_DieTriggers();
function  g_Map_IsSpecialTexture(Texture: String): Boolean;

function  g_Map_GetPoint(PointType: Byte; var RespawnPoint: TRespawnPoint): Boolean;
function  g_Map_GetPointCount(PointType: Byte): Word;

function  g_Map_HaveFlagPoints(): Boolean;

procedure g_Map_ResetFlag(Flag: Byte);
procedure g_Map_DrawFlags();

procedure g_Map_SaveState(Var Mem: TBinMemoryWriter);
procedure g_Map_LoadState(Var Mem: TBinMemoryReader);

const
  RESPAWNPOINT_PLAYER1 = 1;
  RESPAWNPOINT_PLAYER2 = 2;
  RESPAWNPOINT_DM      = 3;
  RESPAWNPOINT_RED     = 4;
  RESPAWNPOINT_BLUE    = 5;

  FLAG_NONE = 0;
  FLAG_RED  = 1;
  FLAG_BLUE = 2;
  FLAG_DOM  = 3;

  FLAG_STATE_NORMAL   = 0;
  FLAG_STATE_DROPPED  = 1;
  FLAG_STATE_CAPTURED = 2;
  FLAG_STATE_SCORED   = 3; // ��� ������� ����� �����.
  FLAG_STATE_RETURNED = 4; // ��� ������� ����� �����.

  FLAG_TIME = 720; // 20 seconds

  SKY_STRETCH: Single = 1.5;

var
  gWalls: TPanelArray;
  gRenderBackgrounds: TPanelArray;
  gRenderForegrounds: TPanelArray;
  gWater, gAcid1, gAcid2: TPanelArray;
  gSteps: TPanelArray;
  gLifts: TPanelArray;
  gBlockMon: TPanelArray;
  gFlags: array [FLAG_RED..FLAG_BLUE] of TFlag;
  //gDOMFlags: array of TFlag;
  gMapInfo: TMapInfo;
  gBackSize: TPoint;
  gDoorMap: array of array of DWORD;
  gLiftMap: array of array of DWORD;
  gRelativeMapResStr: string = '';
  gWADHash: TMD5Digest;
  BackID:  DWORD = DWORD(-1);
  gExternalResources: TStringList;

Implementation

Uses
  g_main, e_log, SysUtils, g_items, g_gfx, g_console,
  dglOpenGL, g_weapons, g_game, g_sound, e_sound, CONFIG,
  g_options, MAPREADER, g_triggers, g_player, MAPDEF,
  Math, g_monsters, g_saveload, g_language, g_netmsg;

const
  FLAGRECT: TRectWH = (X:15; Y:12; Width:33; Height:52);
  MUSIC_SIGNATURE = $4953554D; // 'MUSI'
  FLAG_SIGNATURE = $47414C46; // 'FLAG'

var
  Textures:      TLevelTextureArray;
  RespawnPoints: Array of TRespawnPoint;
  FlagPoints:    Array [FLAG_RED..FLAG_BLUE] of PFlagPoint;
  //DOMFlagPoints: Array of TFlagPoint;


function g_Map_IsSpecialTexture(Texture: String): Boolean;
begin
  Result := (Texture = TEXTURE_NAME_WATER) or
            (Texture = TEXTURE_NAME_ACID1) or
            (Texture = TEXTURE_NAME_ACID2);
end;

procedure CreateDoorMap();
var
  PanelArray: Array of record
                         X, Y: Integer;
                         Width, Height: Word;
                         Active: Boolean;
                         PanelID: DWORD;
                       end;
  a, b, c, m, i, len: Integer;
  ok: Boolean;

begin
  if gWalls = nil then
    Exit;

  i := 0;
  len := 128;
  SetLength(PanelArray, len);

  for a := 0 to High(gWalls) do
    if gWalls[a].Door then
    begin
      PanelArray[i].X := gWalls[a].X;
      PanelArray[i].Y := gWalls[a].Y;
      PanelArray[i].Width := gWalls[a].Width;
      PanelArray[i].Height := gWalls[a].Height;
      PanelArray[i].Active := True;
      PanelArray[i].PanelID := a;

      i := i + 1;
      if i = len then
      begin
        len := len + 128;
        SetLength(PanelArray, len);
      end;
    end;

// ��� ������:
  if i = 0 then
  begin
    PanelArray := nil;
    Exit;
  end;

  SetLength(gDoorMap, 0);

  g_Game_SetLoadingText(_lc[I_LOAD_DOOR_MAP], i-1, False);

  for a := 0 to i-1 do
    if PanelArray[a].Active then
    begin
      PanelArray[a].Active := False;
      m := Length(gDoorMap);
      SetLength(gDoorMap, m+1);
      SetLength(gDoorMap[m], 1);
      gDoorMap[m, 0] := PanelArray[a].PanelID;
      ok := True;

      while ok do
      begin
        ok := False;

        for b := 0 to i-1 do
          if PanelArray[b].Active then
            for c := 0 to High(gDoorMap[m]) do
              if {((gRenderWalls[PanelArray[b].RenderPanelID].TextureID = gRenderWalls[gDoorMap[m, c]].TextureID) or
                    gRenderWalls[PanelArray[b].RenderPanelID].Hide or gRenderWalls[gDoorMap[m, c]].Hide) and}
                g_CollideAround(PanelArray[b].X, PanelArray[b].Y,
                                PanelArray[b].Width, PanelArray[b].Height,
                                gWalls[gDoorMap[m, c]].X,
                                gWalls[gDoorMap[m, c]].Y,
                                gWalls[gDoorMap[m, c]].Width,
                                gWalls[gDoorMap[m, c]].Height) then
              begin
                PanelArray[b].Active := False;
                SetLength(gDoorMap[m],
                          Length(gDoorMap[m])+1);
                gDoorMap[m, High(gDoorMap[m])] := PanelArray[b].PanelID;
                ok := True;
                Break;
              end;
      end;

      g_Game_StepLoading();
    end;

  PanelArray := nil;
end;

procedure CreateLiftMap();
var
  PanelArray: Array of record
                         X, Y: Integer;
                         Width, Height: Word;
                         Active: Boolean;
                       end;
  a, b, c, len, i, j: Integer;
  ok: Boolean;

begin
  if gLifts = nil then
    Exit;

  len := Length(gLifts);
  SetLength(PanelArray, len);

  for a := 0 to len-1 do
  begin
    PanelArray[a].X := gLifts[a].X;
    PanelArray[a].Y := gLifts[a].Y;
    PanelArray[a].Width := gLifts[a].Width;
    PanelArray[a].Height := gLifts[a].Height;
    PanelArray[a].Active := True;
  end;

  SetLength(gLiftMap, len);
  i := 0;

  g_Game_SetLoadingText(_lc[I_LOAD_LIFT_MAP], len-1, False);

  for a := 0 to len-1 do
    if PanelArray[a].Active then
    begin
      PanelArray[a].Active := False;
      SetLength(gLiftMap[i], 32);
      j := 0;
      gLiftMap[i, j] := a;
      ok := True;

      while ok do
      begin
        ok := False;
        for b := 0 to len-1 do
          if PanelArray[b].Active then
            for c := 0 to j do
              if g_CollideAround(PanelArray[b].X,
                                 PanelArray[b].Y,
                                 PanelArray[b].Width,
                                 PanelArray[b].Height,
                                 PanelArray[gLiftMap[i, c]].X,
                                 PanelArray[gLiftMap[i, c]].Y,
                                 PanelArray[gLiftMap[i, c]].Width,
                                 PanelArray[gLiftMap[i, c]].Height) then
              begin
                PanelArray[b].Active := False;
                j := j+1;
                if j > High(gLiftMap[i]) then
                  SetLength(gLiftMap[i],
                            Length(gLiftMap[i])+32);

                gLiftMap[i, j] := b;
                ok := True;

                Break;
              end;
      end;

      SetLength(gLiftMap[i], j+1);
      i := i+1;

      g_Game_StepLoading();
    end;

  SetLength(gLiftMap, i);

  PanelArray := nil;
end;

function CreatePanel(PanelRec: TPanelRec_1; AddTextures: TAddTextureArray;
                     CurTex: Integer; sav: Boolean): Integer;
var
  len: Integer;
  panels: ^TPanelArray;

begin
  Result := -1;

  case PanelRec.PanelType of
    PANEL_WALL, PANEL_OPENDOOR, PANEL_CLOSEDOOR:
      panels := @gWalls;
    PANEL_BACK:
      panels := @gRenderBackgrounds;
    PANEL_FORE:
      panels := @gRenderForegrounds;
    PANEL_WATER:
      panels := @gWater;
    PANEL_ACID1:
      panels := @gAcid1;
    PANEL_ACID2:
      panels := @gAcid2;
    PANEL_STEP:
      panels := @gSteps;
    PANEL_LIFTUP, PANEL_LIFTDOWN:
      panels := @gLifts;
    PANEL_BLOCKMON:
      panels := @gBlockMon;
    else
      Exit;
  end;

  len := Length(panels^);
  SetLength(panels^, len + 1);

  panels^[len] := TPanel.Create(PanelRec, AddTextures,
                                CurTex, Textures);
  if sav then
    panels^[len].SaveIt := True;

  Result := len;
end;

procedure CreateNullTexture(RecName: String);
begin
  SetLength(Textures, Length(Textures)+1);

  with Textures[High(Textures)] do
  begin
    TextureName := RecName;
    Width := 1;
    Height := 1;
    Anim := False;
    TextureID := TEXTURE_NONE;
  end;
end;

function CreateTexture(RecName: String; Map: string; log: Boolean): Boolean;
var
  WAD: TWADEditor_1;
  TextureData: Pointer;
  WADName: String;
  SectionName: String;
  TextureName: String;
  a, ResLength: Integer;

begin
  Result := False;

  if Textures <> nil then
    for a := 0 to High(Textures) do
      if Textures[a].TextureName = RecName then
      begin // �������� � ����� ������ ��� ����
        Result := True;
        Exit;
      end;

// �������� �� ������������ ������� (����, ����, �������):
  if (RecName = TEXTURE_NAME_WATER) or
     (RecName = TEXTURE_NAME_ACID1) or
     (RecName = TEXTURE_NAME_ACID2) then
  begin
    SetLength(Textures, Length(Textures)+1);

    with Textures[High(Textures)] do
    begin
      TextureName := RecName;

      if TextureName = TEXTURE_NAME_WATER then
        TextureID := TEXTURE_SPECIAL_WATER
      else
        if TextureName = TEXTURE_NAME_ACID1 then
          TextureID := TEXTURE_SPECIAL_ACID1
        else
          if TextureName = TEXTURE_NAME_ACID2 then
            TextureID := TEXTURE_SPECIAL_ACID2;

      Anim := False;
    end;

    Result := True;
    Exit;
  end;

// ��������� ������ �������� � ������ �� WAD'�:
  g_ProcessResourceStr(RecName, WADName, SectionName, TextureName);

  WAD := TWADEditor_1.Create();

  if WADName <> '' then
    WADName := GameDir+'\wads\'+WADName
  else
    WADName := Map;

  WAD.ReadFile(WADName);

  if WAD.GetResource(SectionName, TextureName, TextureData, ResLength) then
    begin
      SetLength(Textures, Length(Textures)+1);
      if not e_CreateTextureMem(TextureData, Textures[High(Textures)].TextureID) then
        Exit;
      e_GetTextureSize(Textures[High(Textures)].TextureID,
                       @Textures[High(Textures)].Width,
                       @Textures[High(Textures)].Height);
      FreeMem(TextureData);
      Textures[High(Textures)].TextureName := RecName;
      Textures[High(Textures)].Anim := False;

      Result := True;
    end
  else // ��� ������ ������� � WAD'�
    if log then
      begin
        e_WriteLog(Format('Error loading texture %s', [RecName]), MSG_WARNING);
        e_WriteLog(Format('WAD Reader error: %s', [WAD.GetLastErrorStr]), MSG_WARNING);
      end;

  WAD.Free();
end;

function CreateAnimTexture(RecName: String; Map: string; log: Boolean): Boolean;
var
  WAD: TWADEditor_1;
  TextureWAD: Pointer;
  TextData: Pointer;
  TextureData: Pointer;
  cfg: TConfig;
  WADName: String;
  SectionName: String;
  TextureName: String;
  ResLength: Integer;
  TextureResource: String;
  _width, _height, _framecount, _speed: Integer;
  _backanimation: Boolean;

begin
  Result := False;

// ������ WAD-������ ����.�������� �� WAD'� � ������:
  g_ProcessResourceStr(RecName, WADName, SectionName, TextureName);

  WAD := TWADEditor_1.Create();

  if WADName <> '' then
    WADName := GameDir+'\wads\'+WADName
  else
    WADName := Map;

  WAD.ReadFile(WADName);

  if not WAD.GetResource(SectionName, TextureName, TextureWAD, ResLength) then
  begin
    if log then
    begin
      e_WriteLog(Format('Error loading animation texture %s', [RecName]), MSG_WARNING);
      e_WriteLog(Format('WAD Reader error: %s', [WAD.GetLastErrorStr]), MSG_WARNING);
    end;
    WAD.Free();
    Exit;
  end;

  WAD.FreeWAD();

  if not WAD.ReadMemory(TextureWAD, ResLength) then
  begin
    FreeMem(TextureWAD);
    WAD.Free();
    Exit;
  end;

// ������ INI-������ ����. �������� � ���������� ��� ���������:
  if not WAD.GetResource('TEXT', 'ANIM', TextData, ResLength) then
  begin
    FreeMem(TextureWAD);
    WAD.Free();
    Exit;
  end;

  cfg := TConfig.CreateMem(TextData, ResLength);

  TextureResource := cfg.ReadStr('', 'resource', '');

  if TextureResource = '' then
  begin
    FreeMem(TextureWAD);
    FreeMem(TextData);
    WAD.Free();
    cfg.Free();
    Exit;
  end;

  _width := cfg.ReadInt('', 'framewidth', 0);
  _height := cfg.ReadInt('', 'frameheight', 0);
  _framecount := cfg.ReadInt('', 'framecount', 0);
  _speed := cfg.ReadInt('', 'waitcount', 0);
  _backanimation := cfg.ReadBool('', 'backanimation', False);

  cfg.Free();

// ������ ������ ������� (������) ����. �������� � ������:
  if not WAD.GetResource('TEXTURES', TextureResource, TextureData, ResLength) then
  begin
    FreeMem(TextureWAD);
    FreeMem(TextData);
    WAD.Free();
    Exit;
  end;

  WAD.Free();

  SetLength(Textures, Length(Textures)+1);
  with Textures[High(Textures)] do
  begin
  // ������� ����� ����. �������� �� ������:
    if g_Frames_CreateMemory(@FramesID, '', TextureData,
         _width, _height, _framecount, _backanimation) then
      begin
        TextureName := RecName;
        Width := _width;
        Height := _height;
        Anim := True;
        FramesCount := _framecount;
        Speed := _speed;

        Result := True;
      end
    else
      if log then
        e_WriteLog(Format('Error loading animation texture %s', [RecName]), MSG_WARNING);
  end;

  FreeMem(TextureWAD);
  FreeMem(TextData);
end;

procedure CreateItem(Item: TItemRec_1);
begin
  if g_Game_IsClient then Exit;

  if (not (gGameSettings.GameMode in [GM_DM, GM_TDM, GM_CTF])) and
     ByteBool(Item.Options and ITEM_OPTION_ONLYDM) then
    Exit;

  g_Items_Create(Item.X, Item.Y, Item.ItemType, ByteBool(Item.Options and ITEM_OPTION_FALL),
                 gGameSettings.GameMode in [GM_DM, GM_TDM, GM_CTF, GM_COOP]);
end;

procedure CreateArea(Area: TAreaRec_1);
var
  a: Integer;
  id: DWORD;
begin
 case Area.AreaType of
  AREA_DMPOINT, AREA_PLAYERPOINT1, AREA_PLAYERPOINT2,
  AREA_REDTEAMPOINT, AREA_BLUETEAMPOINT:
  begin
   SetLength(RespawnPoints, Length(RespawnPoints)+1);
   with RespawnPoints[High(RespawnPoints)] do
   begin
    X := Area.X;
    Y := Area.Y;
    Direction := TDirection(Area.Direction);

    case Area.AreaType of
     AREA_DMPOINT: PointType := RESPAWNPOINT_DM;
     AREA_PLAYERPOINT1: PointType := RESPAWNPOINT_PLAYER1;
     AREA_PLAYERPOINT2: PointType := RESPAWNPOINT_PLAYER2;
     AREA_REDTEAMPOINT: PointType := RESPAWNPOINT_RED;
     AREA_BLUETEAMPOINT: PointType := RESPAWNPOINT_BLUE;
    end;
   end;
  end;

  AREA_REDFLAG, AREA_BLUEFLAG:
  begin
   if Area.AreaType = AREA_REDFLAG then a := FLAG_RED else a := FLAG_BLUE;

   if FlagPoints[a] <> nil then Exit;

   New(FlagPoints[a]);

   with FlagPoints[a]^ do
   begin
    X := Area.X-FLAGRECT.X;
    Y := Area.Y-FLAGRECT.Y;
    Direction := TDirection(Area.Direction);
   end;

   with gFlags[a] do
   begin
    case a of
     FLAG_RED: g_Frames_Get(id, 'FRAMES_FLAG_RED');
     FLAG_BLUE: g_Frames_Get(id, 'FRAMES_FLAG_BLUE');
    end;

    Animation := TAnimation.Create(id, True, 8);
    Obj.Rect := FLAGRECT;

    g_Map_ResetFlag(a);
   end;
  end;

  AREA_DOMFLAG:
  begin
   {SetLength(DOMFlagPoints, Length(DOMFlagPoints)+1);
   with DOMFlagPoints[High(DOMFlagPoints)] do
   begin
    X := Area.X;
    Y := Area.Y;
    Direction := TDirection(Area.Direction);
   end;

   g_Map_CreateFlag(DOMFlagPoints[High(DOMFlagPoints)], FLAG_DOM, FLAG_STATE_NORMAL);}
  end;
 end;
end;

procedure CreateTrigger(Trigger: TTriggerRec_1; fTexturePanelType: Word);
var
  _trigger: TTrigger;
begin
 if g_Game_IsClient and not (Trigger.TriggerType in [TRIGGER_SOUND, TRIGGER_MUSIC]) then Exit;

 with _trigger do
 begin
  X := Trigger.X;
  Y := Trigger.Y;
  Width := Trigger.Width;
  Height := Trigger.Height;
  Enabled := ByteBool(Trigger.Enabled);
  TexturePanel := Trigger.TexturePanel;
  TexturePanelType := fTexturePanelType;
  TriggerType := Trigger.TriggerType;
  ActivateType := Trigger.ActivateType;
  Keys := Trigger.Keys;
  Data.Default := Trigger.DATA;
 end;

 g_Triggers_Create(_trigger);
end;

procedure CreateMonster(monster: TMonsterRec_1);
var
  a, i: Integer;

begin
  if g_Game_IsClient then Exit;

  if (gGameSettings.GameType = GT_SINGLE) or (gGameSettings.GameMode = GM_COOP) or
     LongBool(gGameSettings.Options and GAME_OPTION_MONSTERDM) then
  begin
    i := g_Monsters_Create(monster.MonsterType, monster.X, monster.Y,
                           TDirection(monster.Direction));

    if gTriggers <> nil then
      for a := 0 to High(gTriggers) do
        if gTriggers[a].TriggerType in [TRIGGER_PRESS,
             TRIGGER_ON, TRIGGER_OFF, TRIGGER_ONOFF] then
          if (gTriggers[a].Data.MonsterID-1) = gMonsters[i].StartID then
            gMonsters[i].AddTrigger(a);

    if monster.MonsterType <> MONSTER_BARREL then
      Inc(gTotalMonsters);
  end;
end;

procedure g_Map_ReAdd_DieTriggers();
var
  i, a: Integer;

begin
  if g_Game_IsClient then Exit;

  for i := 0 to High(gMonsters) do
    if gMonsters[i] <> nil then
      begin
        gMonsters[i].ClearTriggers();

        for a := 0 to High(gTriggers) do
          if gTriggers[a].TriggerType in [TRIGGER_PRESS,
               TRIGGER_ON, TRIGGER_OFF, TRIGGER_ONOFF] then
            if (gTriggers[a].Data.MonsterID-1) = gMonsters[i].StartID then
              gMonsters[i].AddTrigger(a);
      end;
end;

function extractWadName(resourceName: string): string;
var posN: Integer;
begin
  posN := Pos(':', resourceName);
  if posN > 0 then
    Result:= Copy(resourceName, 0, posN-1)
  else
    Result := '';
end;

procedure addResToExternalResList(res: string);
begin
  res := extractWadName(res);
  if (res <> '') and (gExternalResources.IndexOf(res) = -1) then
    gExternalResources.Add(res);
end;

procedure generateExternalResourcesList(mapReader: TMapReader_1);
var
  textures: TTexturesRec1Array;
  mapHeader: TMapHeaderRec_1;
  i: integer;
  resFile: String;
begin
  if gExternalResources = nil then
    gExternalResources := TStringList.Create;

  gExternalResources.Clear;
  textures := mapReader.GetTextures();
  for i := 0 to High(textures) do
  begin
    addResToExternalResList(resFile);
  end;

  textures := nil;

  mapHeader := mapReader.GetMapHeader;

  addResToExternalResList(mapHeader.MusicName);
  addResToExternalResList(mapHeader.SkyName);
end;

function g_Map_Load(Res: String): Boolean;
const
  DefaultMusRes = 'Standart.wad:STDMUS\MUS1';
  DefaultSkyRes = 'Standart.wad:STDSKY\SKY0';

var
  WAD: TWADEditor_1;
  MapReader: TMapReader_1;
  Header: TMapHeaderRec_1;
  _textures: TTexturesRec1Array;
  panels: TPanelsRec1Array;
  items: TItemsRec1Array;
  monsters: TMonsterRec1Array;
  areas: TAreasRec1Array;
  triggers: TTriggersRec1Array;
  a, b, c, k: Integer;
  PanelID: DWORD;
  AddTextures: TAddTextureArray;
  texture: TTextureRec_1;
  TriggersTable: Array of record
                           TexturePanel: Integer;
                           LiftPanel: Integer;
                           DoorPanel: Integer;
                          end;
  FileName, SectionName, ResName,
  FileName2, s, TexName: String;
  Data: Pointer;
  Len: Integer;
  ok, isAnim, trigRef: Boolean;
  CurTex: Integer;
  
begin
  Result := False;
  gMapInfo.Map := Res;

// �������� WAD:
  g_Game_SetLoadingText(_lc[I_LOAD_WAD_FILE], 0, False);
  g_ProcessResourceStr(Res, FileName, SectionName, ResName);

  WAD := TWADEditor_1.Create();
  if not WAD.ReadFile(FileName) then
  begin
    g_FatalError(Format(_lc[I_GAME_ERROR_MAP_WAD], [FileName]));
    WAD.Free();
    Exit;
  end;
  if not WAD.GetResource('', ResName, Data, Len) then
  begin
    g_FatalError(Format(_lc[I_GAME_ERROR_MAP_RES], [ResName]));
    WAD.Free();
    Exit;
  end;
  WAD.Free();

// �������� �����:
  g_Game_SetLoadingText(_lc[I_LOAD_MAP], 0, False);
  MapReader := TMapReader_1.Create();

  if not MapReader.LoadMap(Data) then
  begin
    g_FatalError(Format(_lc[I_GAME_ERROR_MAP_LOAD], [Res]));
    FreeMem(Data);
    MapReader.Free();
    Exit;
  end;

  FreeMem(Data);
  generateExternalResourcesList(MapReader);
// �������� �������:
  g_Game_SetLoadingText(_lc[I_LOAD_TEXTURES], 0, False);
  _textures := MapReader.GetTextures();

// ���������� ������� � Textures[]:
  if _textures <> nil then
  begin
    g_Game_SetLoadingText(_lc[I_LOAD_TEXTURES], High(_textures), False);

    for a := 0 to High(_textures) do
    begin
    // ������������� ��������:
      if ByteBool(_textures[a].Anim) then
        begin
          if not CreateAnimTexture(_textures[a].Resource, FileName, True) then
          begin
            SetLength(s, 64);
            CopyMemory(@s[1], @_textures[a].Resource[0], 64);
            for b := 1 to Length(s) do
              if s[b] = #0 then
              begin
                SetLength(s, b-1);
                Break;
              end;
            g_SimpleError(Format(_lc[I_GAME_ERROR_TEXTURE_ANIM], [s]));
            CreateNullTexture(_textures[a].Resource);
          end;
        end
      else // ������� ��������:
        if not CreateTexture(_textures[a].Resource, FileName, True) then
        begin
          SetLength(s, 64);
          CopyMemory(@s[1], @_textures[a].Resource[0], 64);
          for b := 1 to Length(s) do
            if s[b] = #0 then
            begin
              SetLength(s, b-1);
              Break;
            end;
          g_SimpleError(Format(_lc[I_GAME_ERROR_TEXTURE_SIMPLE], [s]));
          CreateNullTexture(_textures[a].Resource);
        end;

      g_Game_StepLoading();
    end;
  end;

// �������� ���������:
  g_Game_SetLoadingText(_lc[I_LOAD_TRIGGERS], 0, False);
  triggers := MapReader.GetTriggers();

// �������� �������:
  g_Game_SetLoadingText(_lc[I_LOAD_PANELS], 0, False);
  panels := MapReader.GetPanels();

// �������� ������� ��������� (������������ ������� ���������):
  if triggers <> nil then
  begin
    SetLength(TriggersTable, Length(triggers));
    g_Game_SetLoadingText(_lc[I_LOAD_TRIGGERS_TABLE], High(TriggersTable), False);

    for a := 0 to High(TriggersTable) do
    begin
    // ����� �������� (��������, ������):
      TriggersTable[a].TexturePanel := triggers[a].TexturePanel;
    // �����:
      if triggers[a].TriggerType in [TRIGGER_LIFTUP, TRIGGER_LIFTDOWN, TRIGGER_LIFT] then
        TriggersTable[a].LiftPanel := TTriggerData(triggers[a].DATA).PanelID
      else
        TriggersTable[a].LiftPanel := -1;
    // �����:
      if triggers[a].TriggerType in [TRIGGER_OPENDOOR,
          TRIGGER_CLOSEDOOR, TRIGGER_DOOR, TRIGGER_DOOR5,
          TRIGGER_CLOSETRAP, TRIGGER_TRAP] then
        TriggersTable[a].DoorPanel := TTriggerData(triggers[a].DATA).PanelID
      else
        TriggersTable[a].DoorPanel := -1;

      g_Game_StepLoading();
    end;
  end;

// ������� ������:
  if panels <> nil then
  begin
    g_Game_SetLoadingText(_lc[I_LOAD_LINK_TRIGGERS], High(panels), False);

    for a := 0 to High(panels) do
    begin
      SetLength(AddTextures, 0);
      trigRef := False;
      CurTex := -1;
      if _textures <> nil then
        begin
          texture := _textures[panels[a].TextureNum];
          ok := True;
        end
      else
        ok := False;

      if ok then
      begin
      // �������, ��������� �� �� ��� ������ ��������.
      // ���� �� - �� ���� ������� ��� �������:
        ok := False;
        if (TriggersTable <> nil) and (_textures <> nil) then
          for b := 0 to High(TriggersTable) do
            if TriggersTable[b].TexturePanel = a then
            begin
              trigRef := True;
              ok := True;
              Break;
            end;
      end;

      if ok then
      begin // ���� ������ ��������� �� ��� ������
        SetLength(s, 64);
        CopyMemory(@s[1], @texture.Resource[0], 64);
      // �������� �����:
        Len := Length(s);
        for c := Len downto 1 do
          if s[c] <> #0 then
          begin
            Len := c;
            Break;
          end;
        SetLength(s, Len);

      // ����-�������� ���������:
        if g_Map_IsSpecialTexture(s) then
          ok := False
        else
      // ���������� ������� � ��������� ���� � ����� ������:
          ok := g_Texture_NumNameFindStart(s);

      // ���� ok, ������ ���� ����� � �����.
      // ��������� �������� � ���������� #:
        if ok then
        begin
          k := NNF_NAME_BEFORE;
        // ���� �� ��������� ����� ��������:
          while ok or (k = NNF_NAME_BEFORE) or
                (k = NNF_NAME_EQUALS) do
          begin
            k := g_Texture_NumNameFindNext(TexName);

            if (k = NNF_NAME_BEFORE) or
               (k = NNF_NAME_AFTER) then
              begin
                ok := False;
              // ������� �������� ����� ��������:
                if ByteBool(texture.Anim) then
                  begin // ��������� - �������������, ���� �������������
                    isAnim := True;
                    ok := CreateAnimTexture(TexName, FileName, False);
                    if not ok then
                    begin // ��� �������������, ���� �������
                      isAnim := False;
                      ok := CreateTexture(TexName, FileName, False);
                    end;
                  end
                else
                  begin // ��������� - �������, ���� �������
                    isAnim := False;
                    ok := CreateTexture(TexName, FileName, False);
                    if not ok then
                    begin // ��� �������, ���� �������������
                      isAnim := True;
                      ok := CreateAnimTexture(TexName, FileName, False);
                    end;
                  end;

              // ��� ����������. ������� �� ID � ������ ������:
                if ok then
                begin
                  for c := 0 to High(Textures) do
                    if Textures[c].TextureName = TexName then
                    begin
                      SetLength(AddTextures, Length(AddTextures)+1);
                      AddTextures[High(AddTextures)].Texture := c;
                      AddTextures[High(AddTextures)].Anim := isAnim;
                      Break;
                    end;
                end;
              end
            else
              if k = NNF_NAME_EQUALS then
                begin
                // ������� ������� �������� �� ���� �����:
                  SetLength(AddTextures, Length(AddTextures)+1);
                  AddTextures[High(AddTextures)].Texture := panels[a].TextureNum;
                  AddTextures[High(AddTextures)].Anim := ByteBool(texture.Anim);
                  CurTex := High(AddTextures);
                  ok := True;
                end
              else // NNF_NO_NAME
                ok := False;
          end; // while ok...
          
          ok := True;
        end; // if ok - ���� ������� ��������
      end; // if ok - ��������� ��������

      if not ok then
      begin
      // ������� ������ ������� ��������:
        SetLength(AddTextures, 1);
        AddTextures[0].Texture := panels[a].TextureNum;
        AddTextures[0].Anim := ByteBool(texture.Anim);
        CurTex := 0;
      end;

    // ������� ������ � ���������� �� �����:
      PanelID := CreatePanel(panels[a], AddTextures, CurTex, trigRef);

    // ���� ������������ � ���������, �� ������ ������ ID:
      if TriggersTable <> nil then
        for b := 0 to High(TriggersTable) do
        begin
        // ������� �����/�����:
          if (TriggersTable[b].LiftPanel = a) or
             (TriggersTable[b].DoorPanel = a) then
            TTriggerData(triggers[b].DATA).PanelID := PanelID;
        // ������� ����� ��������:
          if TriggersTable[b].TexturePanel = a then
            triggers[b].TexturePanel := PanelID;
        end;

      g_Game_StepLoading();
    end;
  end;

// ���� �� LoadState, �� ������� ��������:
  if (triggers <> nil) and not gLoadGameMode then
  begin
    g_Game_SetLoadingText(_lc[I_LOAD_CREATE_TRIGGERS], 0, False);
  // ��������� ��� ������, ���� ����:
    for a := 0 to High(triggers) do
    begin
      if triggers[a].TexturePanel <> -1 then
        b := panels[TriggersTable[a].TexturePanel].PanelType
      else
        b := 0;
      CreateTrigger(triggers[a], b);
    end;
  end;

// �������� ���������:
  g_Game_SetLoadingText(_lc[I_LOAD_ITEMS], 0, False);
  items := MapReader.GetItems();

// ���� �� LoadState, �� ������� ��������:
  if (items <> nil) and not gLoadGameMode then
  begin
    g_Game_SetLoadingText(_lc[I_LOAD_CREATE_ITEMS], 0, False);
    for a := 0 to High(items) do
      CreateItem(Items[a]);
  end;

// �������� ��������:
  g_Game_SetLoadingText(_lc[I_LOAD_AREAS], 0, False);
  areas := MapReader.GetAreas();

// ���� �� LoadState, �� ������� �������:
  if areas <> nil then
  begin
    g_Game_SetLoadingText(_lc[I_LOAD_CREATE_AREAS], 0, False);
    for a := 0 to High(areas) do
      CreateArea(areas[a]);
  end;

// �������� ��������:
  g_Game_SetLoadingText(_lc[I_LOAD_MONSTERS], 0, False);
  monsters := MapReader.GetMonsters();

  gTotalMonsters := 0;

// ���� �� LoadState, �� ������� ��������:
  if (monsters <> nil) and not gLoadGameMode then
  begin
    g_Game_SetLoadingText(_lc[I_LOAD_CREATE_MONSTERS], 0, False);
    for a := 0 to High(monsters) do
      CreateMonster(monsters[a]);
  end;

// �������� �������� �����:
  g_Game_SetLoadingText(_lc[I_LOAD_MAP_HEADER], 0, False);
  Header := MapReader.GetMapHeader();

  MapReader.Free();

  with gMapInfo do
  begin
    Name := Header.MapName;
    Description := Header.MapDescription;
    Author := Header.MapAuthor;
    MusicName := Header.MusicName;
    SkyName := Header.SkyName;
    Height := Header.Height;
    Width := Header.Width;
  end;

// �������� ����:
  if gMapInfo.SkyName <> '' then
  begin
    g_Game_SetLoadingText(_lc[I_LOAD_SKY], 0, False);
    g_ProcessResourceStr(gMapInfo.SkyName, FileName, SectionName, ResName);
  
    if FileName <> '' then
      FileName := GameDir+'\wads\'+FileName
    else
      begin
        g_ProcessResourceStr(Res, @FileName2, nil, nil);
        FileName := FileName2;
      end;

    s := FileName+':'+SectionName+'\'+ResName;
    if g_Texture_CreateWAD(BackID, s) then
      begin
        g_Game_SetupScreenSize();
      end
    else
      g_FatalError(Format(_lc[I_GAME_ERROR_SKY], [s]));
  end;

// �������� ������:
  ok := False;
  if gMapInfo.MusicName <> '' then
  begin
    g_Game_SetLoadingText(_lc[I_LOAD_MUSIC], 0, False);
    g_ProcessResourceStr(gMapInfo.MusicName, FileName, SectionName, ResName);

    if FileName <> '' then
      FileName := GameDir+'\wads\'+FileName
    else
      begin
        g_ProcessResourceStr(Res, @FileName2, nil, nil);
        FileName := FileName2;
      end;

    s := FileName+':'+SectionName+'\'+ResName;
    if g_Sound_CreateWADEx(gMapInfo.MusicName, s, True) then
      ok := True
    else
      g_FatalError(Format(_lc[I_GAME_ERROR_MUSIC], [s]));
  end;

// ��������� ��������:
  CreateDoorMap();
  CreateLiftMap();

  g_Items_Init();
  g_Weapon_Init();
  g_Monsters_Init();

// ���� �� LoadState, �� ������� ����� ������������:
  if not gLoadGameMode then
    g_GFX_Init();

// ����� ��������� ��������:
  _textures := nil;
  panels := nil;
  items := nil;
  areas := nil;
  triggers := nil;
  TriggersTable := nil;
  AddTextures := nil;

// �������� ������, ���� ��� �� ��������:
  if ok and (not gLoadGameMode) then
    begin
      gMusic.SetByName(gMapInfo.MusicName);
      gMusic.Play();
    end
  else
    gMusic.SetByName('');

  Result := True;
end;

function g_Map_GetMapInfo(Res: String): TMapInfo;
var
  WAD: TWADEditor_1;
  MapReader: TMapReader_1;
  Header: TMapHeaderRec_1;
  FileName, SectionName, ResName: String;
  Data: Pointer;
  Len: Integer;

begin
  g_ProcessResourceStr(Res, FileName, SectionName, ResName);

  WAD := TWADEditor_1.Create();
  if not WAD.ReadFile(FileName) then
  begin
    WAD.Free();
    Exit;
  end;

  if not WAD.GetResource('', ResName, Data, Len) then
  begin
    WAD.Free();
    Exit;
  end;

  WAD.Free();

  MapReader := TMapReader_1.Create();

  if not MapReader.LoadMap(Data) then
    begin
      g_Console_Add(Format(_lc[I_GAME_ERROR_MAP_LOAD], [Res]), True);
      ZeroMemory(@Header, SizeOf(Header));
      Result.Name := _lc[I_GAME_ERROR_MAP_SELECT];
      Result.Description := _lc[I_GAME_ERROR_MAP_SELECT];
    end
  else
    begin
      Header := MapReader.GetMapHeader();
      Result.Name := Header.MapName;
      Result.Description := Header.MapDescription;
    end;

  FreeMem(Data);
  MapReader.Free();

  Result.Map := Res;
  Result.Author := Header.MapAuthor;
  Result.Height := Header.Height;
  Result.Width := Header.Width;
end;

function g_Map_GetMapsList(WADName: string): SArray;
var
  WAD: TWADEditor_1;
  a: Integer;
  ResList: SArray;
  Data: Pointer;
  Len: Integer;
  Sign: Array [0..2] of Char;

begin
 Result := nil;

 WAD := TWADEditor_1.Create();
 if not WAD.ReadFile(WADName) then
 begin
  WAD.Free();
  Exit;
 end;

 ResList := WAD.GetResourcesList('');

 if ResList <> nil then
  for a := 0 to High(ResList) do
  begin
   if not WAD.GetResource('', ResList[a], Data, Len) then Continue;
   CopyMemory(@Sign[0], Data, 3);
   FreeMem(Data);
   
   if Sign = MAP_SIGNATURE then
   begin
    SetLength(Result, Length(Result)+1);
    Result[High(Result)] := ResList[a];
   end;
   
   Sign := '';
  end;

 WAD.Free();
end;

function g_Map_Exist(Res: string): Boolean;
var
  WAD: TWADEditor_1;
  FileName, SectionName, ResName: string;
  ResList: SArray;
  a: Integer;
begin
 Result := False;

 g_ProcessResourceStr(Res, FileName, SectionName, ResName);

 if Pos('.wad', LowerCase(FileName)) = 0 then FileName := FileName+'.wad';

 WAD := TWADEditor_1.Create;
 if not WAD.ReadFile(FileName) then
 begin
  WAD.Free();
  Exit;
 end;

 ResList := WAD.GetResourcesList('');
 WAD.Free();
 
 if ResList <> nil then
  for a := 0 to High(ResList) do if ResList[a] = ResName then
  begin
   Result := True;
   Exit;
  end;
end;

procedure g_Map_Free();
var
  a: Integer;

  procedure FreePanelArray(var panels: TPanelArray);
  var
    i: Integer;

  begin
    if panels <> nil then
    begin
      for i := 0 to High(panels) do
        panels[i].Free();
      panels := nil;
    end;
  end;

begin
  g_GFX_Free();
  g_Weapon_Free();
  g_Items_Free();
  g_Triggers_Free();
  g_Monsters_Free();

  RespawnPoints := nil;
  if FlagPoints[FLAG_RED] <> nil then
  begin
    Dispose(FlagPoints[FLAG_RED]);
    FlagPoints[FLAG_RED] := nil;
  end;
  if FlagPoints[FLAG_BLUE] <> nil then
  begin
    Dispose(FlagPoints[FLAG_BLUE]);
    FlagPoints[FLAG_BLUE] := nil;
  end;
  //DOMFlagPoints := nil;

  //gDOMFlags := nil;

  if Textures <> nil then
  begin
    for a := 0 to High(Textures) do
      if not g_Map_IsSpecialTexture(Textures[a].TextureName) then
        if Textures[a].Anim then
          g_Frames_DeleteByID(Textures[a].FramesID)
        else
          if Textures[a].TextureID <> TEXTURE_NONE then
            e_DeleteTexture(Textures[a].TextureID);

    Textures := nil;
  end;

  FreePanelArray(gWalls);
  FreePanelArray(gRenderBackgrounds);
  FreePanelArray(gRenderForegrounds);
  FreePanelArray(gWater);
  FreePanelArray(gAcid1);
  FreePanelArray(gAcid2);
  FreePanelArray(gSteps);
  FreePanelArray(gLifts);
  FreePanelArray(gBlockMon);

  if BackID <> DWORD(-1) then
  begin
    gBackSize.X := 0;
    gBackSize.Y := 0;
    e_DeleteTexture(BackID);
    BackID := DWORD(-1);
  end;

  g_Game_StopAllSounds(False);
  gMusic.FreeSound();
  g_Sound_Delete(gMapInfo.MusicName);

  gMapInfo.Name := '';
  gMapInfo.Description := '';
  gMapInfo.MusicName := '';
  gMapInfo.Height := 0;
  gMapInfo.Width := 0;

  gDoorMap := nil;
  gLiftMap := nil;
end;

procedure g_Map_Update();
var
  a, d, j: Integer;
  m: Word;
  s: String;

  procedure UpdatePanelArray(var panels: TPanelArray);
  var
    i: Integer;

  begin
    if panels <> nil then
      for i := 0 to High(panels) do
        panels[i].Update();
  end;

begin
  UpdatePanelArray(gWalls);
  UpdatePanelArray(gRenderBackgrounds);
  UpdatePanelArray(gRenderForegrounds);
  UpdatePanelArray(gWater);
  UpdatePanelArray(gAcid1);
  UpdatePanelArray(gAcid2);
  UpdatePanelArray(gSteps);

  if gGameSettings.GameMode = GM_CTF then
  begin
    for a := FLAG_RED to FLAG_BLUE do
      if gFlags[a].State <> FLAG_STATE_CAPTURED then
        with gFlags[a] do
        begin
          if gFlags[a].Animation <> nil then
            gFlags[a].Animation.Update();

          m := g_Obj_Move(@Obj, True, True);

          if gTime mod (GAME_TICK*2) <> 0 then
            Continue;

        // ������������� �������:
          Obj.Vel.X := z_dec(Obj.Vel.X, 1);

          if ((Count = 0) or ByteBool(m and MOVE_FALLOUT)) and g_Game_IsServer then
          begin
            g_Map_ResetFlag(a);
            if a = FLAG_RED then
              s := _lc[I_PLAYER_FLAG_RED]
            else
              s := _lc[I_PLAYER_FLAG_BLUE];
            g_Game_Message(Format(_lc[I_MESSAGE_FLAG_RETURN], [AnsiUpperCase(s)]), 144);

            if g_Game_IsNet then MH_SEND_FlagEvent(FLAG_STATE_RETURNED, a, 0);
            Continue;
          end;

          if Count > 0 then
            Count := Count - 1;

        // ����� ����� ����:
          if gPlayers <> nil then
          begin
            j := Random(Length(gPlayers)) - 1;

            for d := 0 to High(gPlayers) do
            begin
              Inc(j);
              if j > High(gPlayers) then
                j := 0;

              if gPlayers[j] <> nil then
                if gPlayers[j].Live and
                   g_Obj_Collide(@Obj, @gPlayers[j].Obj) then
                begin
                  if gPlayers[j].GetFlag(a) then
                    Break;
                end;
            end;
          end;
        end;
  end;
end;

procedure g_Map_DrawPanels(PanelType: Word);

  procedure DrawPanels(var panels: TPanelArray;
                       drawDoors: Boolean = False);
  var
    a: Integer;

  begin
    if panels <> nil then
      for a := 0 to High(panels) do
        if not (drawDoors xor panels[a].Door) then
          panels[a].Draw();
  end;
          
begin
  case PanelType of
    PANEL_WALL:       DrawPanels(gWalls);
    PANEL_CLOSEDOOR:  DrawPanels(gWalls, True);
    PANEL_BACK:       DrawPanels(gRenderBackgrounds);
    PANEL_FORE:       DrawPanels(gRenderForegrounds);
    PANEL_WATER:      DrawPanels(gWater);
    PANEL_ACID1:      DrawPanels(gAcid1);
    PANEL_ACID2:      DrawPanels(gAcid2);
    PANEL_STEP:       DrawPanels(gSteps);
  end;
end;

procedure g_Map_DrawBack(dx, dy: Integer);
begin
 if gDrawBackGround and (BackID <> DWORD(-1)) then
  e_DrawSize(BackID, dx, dy, 0, False, False, gBackSize.X, gBackSize.Y)
   else e_Clear(GL_COLOR_BUFFER_BIT, 0, 0, 0);
end;

function g_Map_CollidePanel(X, Y: Integer; Width, Height: Word;
                            PanelType: Word; b1x3: Boolean): Boolean;
var
  a, h: Integer;

begin
 Result := False;

 if WordBool(PanelType and PANEL_WALL) then
  if gWalls <> nil then
  begin
   h := High(gWalls);

   for a := 0 to h do
    if gWalls[a].Enabled and
       g_Collide(X, Y, Width, Height,
                 gWalls[a].X, gWalls[a].Y,
                 gWalls[a].Width, gWalls[a].Height) then
    begin
     Result := True;
     Exit;
    end;
  end;

 if WordBool(PanelType and PANEL_WATER) then
  if gWater <> nil then
  begin
   h := High(gWater);

   for a := 0 to h do
    if g_Collide(X, Y, Width, Height,
                 gWater[a].X, gWater[a].Y,
                 gWater[a].Width, gWater[a].Height) then
    begin
     Result := True;
     Exit;
    end;
  end;

 if WordBool(PanelType and PANEL_ACID1) then
  if gAcid1 <> nil then
  begin
   h := High(gAcid1);

   for a := 0 to h do
    if g_Collide(X, Y, Width, Height,
                 gAcid1[a].X, gAcid1[a].Y,
                 gAcid1[a].Width, gAcid1[a].Height) then
    begin
     Result := True;
     Exit;
    end;
  end;

 if WordBool(PanelType and PANEL_ACID2) then
  if gAcid2 <> nil then
  begin
   h := High(gAcid2);

   for a := 0 to h do
    if g_Collide(X, Y, Width, Height,
                 gAcid2[a].X, gAcid2[a].Y,
                 gAcid2[a].Width, gAcid2[a].Height) then
    begin
     Result := True;
     Exit;
    end;
  end;

 if WordBool(PanelType and PANEL_STEP) then
  if gSteps <> nil then
  begin
   h := High(gSteps);

   for a := 0 to h do
    if g_Collide(X, Y, Width, Height,
                 gSteps[a].X, gSteps[a].Y,
                 gSteps[a].Width, gSteps[a].Height) then
    begin
     Result := True;
     Exit;
    end;
  end;

 if WordBool(PanelType and (PANEL_LIFTUP or PANEL_LIFTDOWN)) then
  if gLifts <> nil then
  begin
   h := High(gLifts);

   for a := 0 to h do
    if ((WordBool(PanelType and (PANEL_LIFTUP)) and (gLifts[a].LiftType = 0)) or
        (WordBool(PanelType and (PANEL_LIFTDOWN)) and (gLifts[a].LiftType = 1))) and
       g_Collide(X, Y, Width, Height,
                 gLifts[a].X, gLifts[a].Y,
                 gLifts[a].Width, gLifts[a].Height) then
    begin
     Result := True;
     Exit;
    end;
  end;

 if WordBool(PanelType and PANEL_BLOCKMON) then
  if gBlockMon <> nil then
  begin
   h := High(gBlockMon);

   for a := 0 to h do
    if ( (not b1x3) or
         ((gBlockMon[a].Width + gBlockMon[a].Height) >= 64) ) and 
       g_Collide(X, Y, Width, Height,
                 gBlockMon[a].X, gBlockMon[a].Y,
                 gBlockMon[a].Width, gBlockMon[a].Height) then
    begin
     Result := True;
     Exit;
    end;
  end;
end;

function g_Map_CollideLiquid_Texture(X, Y: Integer; Width, Height: Word): DWORD;
var
  a, h: Integer;

begin
  Result := TEXTURE_NONE;

  if gWater <> nil then
  begin
    h := High(gWater);

    for a := 0 to h do
      if g_Collide(X, Y, Width, Height,
                   gWater[a].X, gWater[a].Y,
                   gWater[a].Width, gWater[a].Height) then
      begin
        Result := gWater[a].GetTextureID();
        Exit;
      end;
  end;

  if gAcid1 <> nil then
  begin
    h := High(gAcid1);

    for a := 0 to h do
      if g_Collide(X, Y, Width, Height,
                   gAcid1[a].X, gAcid1[a].Y,
                   gAcid1[a].Width, gAcid1[a].Height) then
      begin
        Result := gAcid1[a].GetTextureID();
        Exit;
      end;
  end;

  if gAcid2 <> nil then
  begin
    h := High(gAcid2);

    for a := 0 to h do
      if g_Collide(X, Y, Width, Height,
                   gAcid2[a].X, gAcid2[a].Y,
                   gAcid2[a].Width, gAcid2[a].Height) then
      begin
        Result := gAcid2[a].GetTextureID();
        Exit;
      end;
  end;
end;

procedure g_Map_EnableWall(ID: DWORD);
begin
  with gWalls[ID] do
  begin
    Enabled := True;
    g_Mark(X, Y, Width, Height, MARK_DOOR, True);

    if g_Game_IsServer and g_Game_IsNet then MH_SEND_PanelState(PanelType, ID);
  end;
end;

procedure g_Map_DisableWall(ID: DWORD);
begin
  with gWalls[ID] do
  begin
    Enabled := False;
    g_Mark(X, Y, Width, Height, MARK_DOOR, False);

    if g_Game_IsServer and g_Game_IsNet then MH_SEND_PanelState(PanelType, ID);
  end;
end;

procedure g_Map_SwitchTexture(PanelType: Word; ID: DWORD; AnimLoop: Byte = 0);
var
  tp: TPanel;

begin            
  case PanelType of
    PANEL_WALL, PANEL_OPENDOOR, PANEL_CLOSEDOOR:
      tp := gWalls[ID];
    PANEL_FORE:
      tp := gRenderForegrounds[ID];
    PANEL_BACK:
      tp := gRenderBackgrounds[ID];
    PANEL_WATER:
      tp := gWater[ID];
    PANEL_ACID1:
      tp := gAcid1[ID];
    PANEL_ACID2:
      tp := gAcid2[ID];
    PANEL_STEP:
      tp := gSteps[ID];
    else
      Exit;
  end;

  tp.NextTexture(AnimLoop);
  if g_Game_IsServer and g_Game_IsNet then MH_SEND_PanelTexture(PanelType, ID, AnimLoop);
end;

procedure g_Map_SetLift(ID: DWORD; t: Integer);
begin
  if gLifts[ID].LiftType = t then
    Exit;

  with gLifts[ID] do
  begin
    LiftType := t;

    g_Mark(X, Y, Width, Height, MARK_LIFT, False);

    if LiftType = 1 then
      g_Mark(X, Y, Width, Height, MARK_LIFTDOWN, True)
    else
      g_Mark(X, Y, Width, Height, MARK_LIFTUP, True);

    if g_Game_IsServer and g_Game_IsNet then MH_SEND_PanelState(PanelType, ID);
  end;
end;

function g_Map_GetPoint(PointType: Byte; var RespawnPoint: TRespawnPoint): Boolean;
var
  a: Integer;
  PointsArray: Array of TRespawnPoint;

begin
  Result := False;

  if RespawnPoints = nil then
    Exit;

  for a := 0 to High(RespawnPoints) do
    if RespawnPoints[a].PointType = PointType then
    begin
      SetLength(PointsArray, Length(PointsArray)+1);
      PointsArray[High(PointsArray)] := RespawnPoints[a];
    end;

  if PointsArray = nil then
    Exit;

  RespawnPoint := PointsArray[Random(Length(PointsArray))];
  Result := True;
end;

function g_Map_GetPointCount(PointType: Byte): Word;
var
  a: Integer;

begin
  Result := 0;

  if RespawnPoints = nil then
    Exit;

  for a := 0 to High(RespawnPoints) do
    if RespawnPoints[a].PointType = PointType then
      Result := Result + 1;
end;

function g_Map_HaveFlagPoints(): Boolean;
begin
 Result := (FlagPoints[FLAG_RED] <> nil) and (FlagPoints[FLAG_BLUE] <> nil);
end;

procedure g_Map_ResetFlag(Flag: Byte);
begin
 with gFlags[Flag] do
 begin
  Obj.X := FlagPoints[Flag]^.X;
  Obj.Y := FlagPoints[Flag]^.Y;
  Obj.Vel.X := 0;
  Obj.Vel.Y := 0;
  Direction := FlagPoints[Flag]^.Direction;
  State := FLAG_STATE_NORMAL;
  Count := -1;
 end;
end;

procedure g_Map_DrawFlags();
var
  i, dx: Integer;
  Mirror: TMirrorType;

begin
  if gGameSettings.GameMode <> GM_CTF then
    Exit;

  for i := FLAG_RED to FLAG_BLUE do
    with gFlags[i] do
      if State <> FLAG_STATE_CAPTURED then
      begin
        if Direction = D_LEFT then
          begin
            Mirror := M_HORIZONTAL;
            dx := -1;
          end
        else
          begin
            Mirror := M_NONE;
            dx := 1;
          end;
          
        Animation.Draw(Obj.X+dx, Obj.Y+1, Mirror);

        if g_debug_Frames then
         begin
           e_DrawQuad(Obj.X+Obj.Rect.X,
                      Obj.Y+Obj.Rect.Y,
                      Obj.X+Obj.Rect.X+Obj.Rect.Width-1,
                      Obj.Y+Obj.Rect.Y+Obj.Rect.Height-1,
                      0, 255, 0);
         end;
      end;
end;

procedure g_Map_SaveState(Var Mem: TBinMemoryWriter);
var
  dw: DWORD;
  b: Byte;
  str: String;
  boo: Boolean;

  procedure SavePanelArray(var panels: TPanelArray);
  var
    PAMem: TBinMemoryWriter;
    i: Integer;

  begin
  // ������� ����� ������ ����������� �������:
    PAMem := TBinMemoryWriter.Create((Length(panels)+1) * 40);

    for i := 0 to Length(panels)-1 do
      if panels[i].SaveIt then
      begin
      // ID ������:
        PAMem.WriteInt(i);
      // ��������� ������:
        panels[i].SaveState(PAMem);
      end;

  // ��������� ���� ������ �������:
    PAMem.SaveToMemory(Mem);
    PAMem.Free();
  end;

  procedure SaveFlag(flag: PFlag);
  begin
  // ��������� �����:
    dw := FLAG_SIGNATURE; // 'FLAG'
    Mem.WriteDWORD(dw);
  // ����� ������������� �����:
    Mem.WriteByte(flag^.RespawnType);
  // ��������� �����:
    Mem.WriteByte(flag^.State);
  // ����������� �����:
    if flag^.Direction = D_LEFT then
      b := 1
    else // D_RIGHT
      b := 2;
    Mem.WriteByte(b);
  // ������ �����:
    Obj_SaveState(@flag^.Obj, Mem);
  end;

begin
  Mem := TBinMemoryWriter.Create(1024 * 1024); // 1 MB

///// ��������� ������ �������: /////
// ��������� ������ ���� � ������:
  SavePanelArray(gWalls);
// ��������� ������ ����:
  SavePanelArray(gRenderBackgrounds);
// ��������� ������ ��������� �����:
  SavePanelArray(gRenderForegrounds);
// ��������� ������ ����:
  SavePanelArray(gWater);
// ��������� ������ �������-1:
  SavePanelArray(gAcid1);
// ��������� ������ �������-2:
  SavePanelArray(gAcid2);
// ��������� ������ ��������:
  SavePanelArray(gSteps);
// ��������� ������ ������:
  SavePanelArray(gLifts);
///// /////

///// ��������� ������: /////
// ��������� ������:
  dw := MUSIC_SIGNATURE; // 'MUSI'
  Mem.WriteDWORD(dw);
// �������� ������:
  Assert(gMusic <> nil, 'g_Map_SaveState: gMusic = nil');
  if gMusic.NoMusic then
    str := ''
  else
    str := gMusic.Name;
  Mem.WriteString(str, 64);
// ������� ������������ ������:
  dw := gMusic.GetPosition();
  Mem.WriteDWORD(dw);
// ����� �� ������ �� ����-�����:
  boo := gMusic.SpecPause;
  Mem.WriteBoolean(boo);
///// /////

///// ��������� ���������� ��������: /////
  Mem.WriteInt(gTotalMonsters);
///// /////

//// ��������� �����, ���� ��� CTF: /////
  if gGameSettings.GameMode = GM_CTF then
  begin
  // ���� ������� �������:
    SaveFlag(@gFlags[FLAG_RED]);
  // ���� ����� �������:
    SaveFlag(@gFlags[FLAG_BLUE]);
  end;
///// /////

///// ��������� ���������� �����, ���� ��� TDM/CTF: /////
  if gGameSettings.GameMode in [GM_TDM, GM_CTF] then
  begin
  // ���� ������� �������:
    Mem.WriteSmallInt(gTeamStat[TEAM_RED].Goals);
  // ���� ����� �������:
    Mem.WriteSmallInt(gTeamStat[TEAM_BLUE].Goals);
  end;
///// /////
end;

procedure g_Map_LoadState(Var Mem: TBinMemoryReader);
var
  dw: DWORD;
  b: Byte;
  str: String;
  boo: Boolean;

  procedure LoadPanelArray(var panels: TPanelArray);
  var
    PAMem: TBinMemoryReader;
    i, id: Integer;

  begin
  // ��������� ������� ������ �������:
    PAMem := TBinMemoryReader.Create();
    PAMem.LoadFromMemory(Mem);

    for i := 0 to Length(panels)-1 do
      if panels[i].SaveIt then
      begin
      // ID ������:
        PAMem.ReadInt(id);
        if id <> i then
        begin
          raise EBinSizeError.Create('g_Map_LoadState: LoadPanelArray: Wrong Panel ID');
        end;
      // ��������� ������:
        panels[i].LoadState(PAMem);
      end;

  // ���� ������ ������� ��������:
    PAMem.Free();
  end;

  procedure LoadFlag(flag: PFlag);
  begin
  // ��������� �����:
    Mem.ReadDWORD(dw);
    if dw <> FLAG_SIGNATURE then // 'FLAG'
    begin
      raise EBinSizeError.Create('g_Map_LoadState: LoadFlag: Wrong Flag Signature');
    end;
  // ����� ������������� �����:
    Mem.ReadByte(flag^.RespawnType);
  // ��������� �����:
    Mem.ReadByte(flag^.State);
  // ����������� �����:
    Mem.ReadByte(b);
    if b = 1 then
      flag^.Direction := D_LEFT
    else // b = 2
      flag^.Direction := D_RIGHT;
  // ������ �����:
    Obj_LoadState(@flag^.Obj, Mem);
  end;

begin
  if Mem = nil then
    Exit;

///// ��������� ������ �������: /////
// ��������� ������ ���� � ������:
  LoadPanelArray(gWalls);
// ��������� ������ ����:
  LoadPanelArray(gRenderBackgrounds);
// ��������� ������ ��������� �����:
  LoadPanelArray(gRenderForegrounds);
// ��������� ������ ����:
  LoadPanelArray(gWater);
// ��������� ������ �������-1:
  LoadPanelArray(gAcid1);
// ��������� ������ �������-2:
  LoadPanelArray(gAcid2);
// ��������� ������ ��������:
  LoadPanelArray(gSteps);
// ��������� ������ ������:
  LoadPanelArray(gLifts);
///// /////

// ��������� ����� ������������:
  g_GFX_Init();

///// ��������� ������: /////
// ��������� ������:
  Mem.ReadDWORD(dw);
  if dw <> MUSIC_SIGNATURE then // 'MUSI'
    begin
      raise EBinSizeError.Create('g_Map_LoadState: Wrong Music Signature');
    end;
// �������� ������:
  Assert(gMusic <> nil, 'g_Map_LoadState: gMusic = nil');
  Mem.ReadString(str);
// ������� ������������ ������:
  Mem.ReadDWORD(dw);
// ����� �� ������ �� ����-�����:
  Mem.ReadBoolean(boo);
// ��������� ��� ������:
  gMusic.SetByName(str);
  gMusic.SpecPause := boo;
  gMusic.Play();
  gMusic.Pause(True);
  gMusic.SetPosition(dw);
///// /////

///// ��������� ���������� ��������: /////
  Mem.ReadInt(gTotalMonsters);
///// /////

//// ��������� �����, ���� ��� CTF: /////
  if gGameSettings.GameMode = GM_CTF then
  begin
  // ���� ������� �������:
    LoadFlag(@gFlags[FLAG_RED]);
  // ���� ����� �������:
    LoadFlag(@gFlags[FLAG_BLUE]);
  end;
///// /////

///// ��������� ���������� �����, ���� ��� TDM/CTF: /////
  if gGameSettings.GameMode in [GM_TDM, GM_CTF] then
  begin
  // ���� ������� �������:
    Mem.ReadSmallInt(gTeamStat[TEAM_RED].Goals);
  // ���� ����� �������:
    Mem.ReadSmallInt(gTeamStat[TEAM_BLUE].Goals);
  end;
///// /////
end;

End.
