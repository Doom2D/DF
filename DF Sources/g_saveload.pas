unit g_saveload;

interface

uses
  e_graphics, g_phys, g_textures, BinEditor;

function g_GetSaveName(n: Integer): String;
function g_SaveGame(n: Integer; Name: String): Boolean;
function g_LoadGame(n: Integer): Boolean;
procedure Obj_SaveState(o: PObj; Var Mem: TBinMemoryWriter);
procedure Obj_LoadState(o: PObj; Var Mem: TBinMemoryReader);

implementation

uses
  g_game, g_items, g_map, g_monsters, g_triggers,
  g_basic, windows, g_main, SysUtils, Math, WADEDITOR,
  MAPSTRUCT, MAPDEF, g_weapons, g_player, g_console,
  e_log, g_language;

const
  SAVE_SIGNATURE = $56534644; // 'DFSV'
  SAVE_VERSION = $02;
  END_MARKER_STRING = 'END';
  OBJ_SIGNATURE = $4A424F5F; // '_OBJ'
  
  
procedure Obj_SaveState(o: PObj; Var Mem: TBinMemoryWriter);
var
  sig: DWORD;

begin
  if Mem = nil then
    Exit;

// ��������� �������:
  sig := OBJ_SIGNATURE; // '_OBJ'
  Mem.WriteDWORD(sig);
// ��������� ��-�����������:
  Mem.WriteInt(o^.X);
// ��������� ��-���������:
  Mem.WriteInt(o^.Y);
// �������������� �������������:
  Mem.WriteInt(o^.Rect.X);
  Mem.WriteInt(o^.Rect.Y);
  Mem.WriteWord(o^.Rect.Width);
  Mem.WriteWord(o^.Rect.Height);
// ��������:
  Mem.WriteInt(o^.Vel.X);
  Mem.WriteInt(o^.Vel.Y);
// �������� � ��������:
  Mem.WriteInt(o^.Accel.X);
  Mem.WriteInt(o^.Accel.Y);
end;

procedure Obj_LoadState(o: PObj; Var Mem: TBinMemoryReader);
var
  sig: DWORD;

begin
  if Mem = nil then
    Exit;

// ��������� �������:
  Mem.ReadDWORD(sig);
  if sig <> OBJ_SIGNATURE then // '_OBJ'
  begin
    raise EBinSizeError.Create('Obj_LoadState: Wrong Object Signature');
  end;
// ��������� ��-�����������:
  Mem.ReadInt(o^.X);
// ��������� ��-���������:
  Mem.ReadInt(o^.Y);
// �������������� �������������:
  Mem.ReadInt(o^.Rect.X);
  Mem.ReadInt(o^.Rect.Y);
  Mem.ReadWord(o^.Rect.Width);
  Mem.ReadWord(o^.Rect.Height);
// ��������:
  Mem.ReadInt(o^.Vel.X);
  Mem.ReadInt(o^.Vel.Y);
// �������� � ��������:
  Mem.ReadInt(o^.Accel.X);
  Mem.ReadInt(o^.Accel.Y);
end;

function g_GetSaveName(n: Integer): String;
var
  bFile: TBinFileReader;
  bMem: TBinMemoryReader;
  str: String;

begin
  Result := '';
  str := '';
  bMem := nil;
  bFile := nil;

  try
  // ��������� ���� ����������:
    bFile := TBinFileReader.Create();
    if bFile.OpenFile(DataDir + 'SAVGAME' + IntToStr(n) + '.DAT',
                      SAVE_SIGNATURE, SAVE_VERSION) then
    begin
    // ������ ������ ���� - ��������� ����:
      bMem := TBinMemoryReader.Create();
      bFile.ReadMemory(bMem);
    // ��� ����:
      bMem.ReadString(str);

    // ��������� ����:
      bFile.CloseFile();
    end;

  except
    on E1: EInOutError do
      e_WriteLog('GetSaveName I/O Error: '+E1.Message, MSG_WARNING);
    on E2: EBinSizeError do
      e_WriteLog('GetSaveName Size Error: '+E2.Message, MSG_WARNING);
  end;

  bMem.Free();
  bFile.Free();

  Result := str;
end;

function g_SaveGame(n: Integer; Name: String): Boolean;
var
  bFile: TBinFileWriter;
  bMem: TBinMemoryWriter;
  str: String;
  nPlayers: Byte;
  i, k: Integer;

begin
  Result := False;
  bMem := nil;
  bFile := nil;

  try
  // ������� ���� ����������:
    bFile := TBinFileWriter.Create();
    bFile.OpenFile(DataDir + 'SAVGAME' + IntToStr(n) + '.DAT',
                   SAVE_SIGNATURE, SAVE_VERSION);

  ///// �������� ��������� ����: /////
    bMem := TBinMemoryWriter.Create(256);
  // ��� ����:
    bMem.WriteString(Name, 32);
  // ���� � �����:
    str := ExtractRelativePath(MapsDir, gGameSettings.WAD);
    bMem.WriteString(str, 128);
  // ��� �����:
    g_ProcessResourceStr(gMapInfo.Map, nil, nil, @str);
    bMem.WriteString(str, 32);
  // ���������� �������:
    nPlayers := g_Player_GetCount();
    bMem.WriteByte(nPlayers);
  // ������� �����:
    bMem.WriteDWORD(gTime);
  // ��� ����:
    bMem.WriteByte(gGameSettings.GameType);
  // ����� ����:
    bMem.WriteByte(gGameSettings.GameMode);
  // ����� �������:
    bMem.WriteWord(gGameSettings.TimeLimit);
  // ����� �����:
    bMem.WriteWord(gGameSettings.GoalLimit);
  // ������� �����:
    bMem.WriteDWORD(gGameSettings.Options);
  // ��������� ��������� ����:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// �������� ��������� �����: /////
    g_Map_SaveState(bMem);
  // ��������� ��������� �����:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// �������� ��������� ���������: /////
    g_Items_SaveState(bMem);
  // ��������� ��������� ���������:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// �������� ��������� ���������: /////
    g_Triggers_SaveState(bMem);
  // ��������� ��������� ���������:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////
  
  ///// �������� ��������� ������: /////
    g_Weapon_SaveState(bMem);
  // ��������� ��������� ������:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// �������� ��������� ��������: /////
    g_Monsters_SaveState(bMem);
  // ��������� ��������� ��������:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// �������� ��������� ������: /////
    g_Player_Corpses_SaveState(bMem);
  // ��������� ��������� ������:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ������� (� ��� ����� �����): /////
    if nPlayers > 0 then
    begin
      k := 0;
      for i := 0 to High(gPlayers) do
        if gPlayers[i] <> nil then
        begin
        // �������� ��������� ������:
          gPlayers[i].SaveState(bMem);
        // ��������� ��������� ������:
          bFile.WriteMemory(bMem);
          bMem.Free();
          bMem := nil;
          Inc(k);
        end;
        
    // ��� �� ������ �� �����:
      if k <> nPlayers then
      begin
        raise EInOutError.Create('g_SaveGame: Wrong Players Count');
      end;
    end;
  ///// /////

  ///// ������ ���������: /////
    bMem := TBinMemoryWriter.Create(4);
  // ������ - ����������� �����:
    str := END_MARKER_STRING; // 'END'
    bMem.WriteString(str, 3);
  // ��������� ������ ���������:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  // ��������� ���� ����������:
    bFile.CloseFile();
    Result := True;

  except
    on E1: EInOutError do
      begin
        g_Console_Add(_lc[I_GAME_ERROR_SAVE]);
        e_WriteLog('SaveState I/O Error: '+E1.Message, MSG_WARNING);
      end;
    on E2: EBinSizeError do
      begin
        g_Console_Add(_lc[I_GAME_ERROR_SAVE]);
        e_WriteLog('SaveState Size Error: '+E2.Message, MSG_WARNING);
      end;
  end;

  bMem.Free();
  bFile.Free();
end;

function g_LoadGame(n: Integer): Boolean;
var
  bFile: TBinFileReader;
  bMem: TBinMemoryReader;
  str, WAD_Path, Map_Name: String;
  nPlayers, Game_Type, Game_Mode: Byte;
  Game_TimeLimit, Game_GoalLimit: Word;
  Game_Time, Game_Options: Cardinal;
  i: Integer;

begin
  Result := False;
  bMem := nil;
  bFile := nil;

  try
  // ��������� ���� � �����������:
    bFile := TBinFileReader.Create();
    if not bFile.OpenFile(DataDir + 'SAVGAME' + IntToStr(n) + '.DAT',
                          SAVE_SIGNATURE, SAVE_VERSION) then
    begin
      bFile.Free();
      Exit;
    end;

    g_Game_ClearLoading();
    g_Game_SetLoadingText(_lc[I_LOAD_SAVE_FILE], 0, False);
    gLoadGameMode := True;

  ///// ��������� ��������� ����: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
  // ��� ����:
    bMem.ReadString(str);
  // ���� � �����:
    bMem.ReadString(WAD_Path);
  // ��� �����:
    bMem.ReadString(Map_Name);
  // ���������� �������:
    bMem.ReadByte(nPlayers);
  // ������� �����:
    bMem.ReadDWORD(Game_Time);
  // ��� ����:
    bMem.ReadByte(Game_Type);
  // ����� ����:
    bMem.ReadByte(Game_Mode);
  // ����� �������:
    bMem.ReadWord(Game_TimeLimit);
  // ����� �����:
    bMem.ReadWord(Game_GoalLimit);
  // ������� �����:
    bMem.ReadDWORD(Game_Options);
  // C�������� ���� ���������:
    bMem.Free();
    bMem := nil;
  ///// /////
  
  // ��������� �����:
    if (Game_Type = GT_NONE) or (Game_Type = GT_SINGLE) then
      g_Game_StartSingle(MapsDir + WAD_Path, Map_Name,
                         LongBool(Game_Options and GAME_OPTION_TWOPLAYER),
                         nPlayers)
    else
      g_Game_StartCustom(MapsDir + WAD_Path + ':\' + Map_Name,
                         Game_Mode, Game_TimeLimit,
                         Game_GoalLimit, Game_Options,
                         nPlayers);
  // ������������� �����:
    gTime := Game_Time;

  ///// ��������� ��������� �����: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
  // ��������� �����:
    g_Map_LoadState(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ��������� ���������: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
  // ��������� ���������:
    g_Items_LoadState(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ��������� ���������: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
  // ��������� ���������:
    g_Triggers_LoadState(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ��������� ������: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
  // ��������� ������:
    g_Weapon_LoadState(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ��������� ��������: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
  // ��������� ��������:
    g_Monsters_LoadState(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ��������� ������: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
  // ��������� ������:
    g_Player_Corpses_LoadState(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ������� (� ��� ����� �����): /////
    if nPlayers > 0 then
    begin
    // ���� �� ������ ������:
      if gPlayers = nil then
      begin
        raise EInOutError.Create('g_LoadGame: No Players');
      end;
      
    // ���������:
      for i := 0 to nPlayers-1 do
      begin
      // ��������� ��������� ������:
        bMem := TBinMemoryReader.Create();
        bFile.ReadMemory(bMem);
      // ��������� ������/����:
        if gPlayers[i] = nil then
        begin
          raise EInOutError.Create('g_LoadGame: Nil Player');
        end;
        gPlayers[i].LoadState(bMem);
        bMem.Free();
        bMem := nil;
      end;
    end;
  ///// /////

  ///// ������ ���������: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
  // ������ - ����������� �����:
    bMem.ReadString(str);
    if str <> END_MARKER_STRING then // 'END'
    begin
      raise EInOutError.Create('g_LoadGame: No END Marker');
    end;
  // ������ ��������� ��������:
    bMem.Free();
    bMem := nil;
  ///// /////

  // ���� �������� � �������� ������ ��������:
    if (gMonsters <> nil) and (gTriggers <> nil) then
      g_Map_ReAdd_DieTriggers();

  // ��������� ���� ��������:
    bFile.CloseFile();
    gLoadGameMode := False;
    Result := True;

  except
    on E1: EInOutError do
      begin
        g_Console_Add(_lc[I_GAME_ERROR_LOAD]);
        e_WriteLog('LoadState I/O Error: '+E1.Message, MSG_WARNING);
      end;
    on E2: EBinSizeError do
      begin
        g_Console_Add(_lc[I_GAME_ERROR_LOAD]);
        e_WriteLog('LoadState Size Error: '+E2.Message, MSG_WARNING);
      end;
  end;

  bMem.Free();
  bFile.Free();
end;

end.
