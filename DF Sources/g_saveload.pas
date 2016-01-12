unit g_saveload;

interface

uses
  e_graphics, g_phys, g_textures, BinEditor;

function g_GetSaveName(n: Integer): String;
function g_SaveGame(n: Integer; Name: String): Boolean;
function g_LoadGame(n: Integer): Boolean;
procedure Obj_SaveState(o: PObj; var Mem: TBinMemoryWriter);
procedure Obj_LoadState(o: PObj; var Mem: TBinMemoryReader);

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
  PLAYER_VIEW_SIGNATURE = $57564C50; // 'PLVW'
  OBJ_SIGNATURE = $4A424F5F; // '_OBJ'

procedure Obj_SaveState(o: PObj; var Mem: TBinMemoryWriter);
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

procedure Obj_LoadState(o: PObj; var Mem: TBinMemoryReader);
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
  sig: DWORD;
  str: String;
  nPlayers: Byte;
  i, k: Integer;
  PID1, PID2: Word;
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
    str := gGameSettings.WAD;
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
  // ����� ������:
    bMem.WriteByte(gGameSettings.MaxLives);
  // ������� �����:
    bMem.WriteDWORD(gGameSettings.Options);
  // ��� �����:
    bMem.WriteWord(gCoopMonstersKilled);
    bMem.WriteWord(gCoopSecretsFound);
    bMem.WriteWord(gCoopTotalMonstersKilled);
    bMem.WriteWord(gCoopTotalSecretsFound);
    bMem.WriteWord(gCoopTotalMonsters);
    bMem.WriteWord(gCoopTotalSecrets);
  // ��������� ��������� ����:
    bFile.WriteMemory(bMem);
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ��������� �������� ���������: /////
    bMem := TBinMemoryWriter.Create(8);
    sig := PLAYER_VIEW_SIGNATURE;
    bMem.WriteDWORD(sig); // 'PLVW'
    PID1 := 0;
    PID2 := 0;
    if gPlayer1 <> nil then
      PID1 := gPlayer1.UID;
    if gPlayer2 <> nil then
      PID2 := gPlayer2.UID;
    bMem.WriteWord(PID1);
    bMem.WriteWord(PID2);
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
  sig: DWORD;
  str, WAD_Path, Map_Name: String;
  nPlayers, Game_Type, Game_Mode, Game_MaxLives: Byte;
  Game_TimeLimit, Game_GoalLimit: Word;
  Game_Time, Game_Options: Cardinal;
  Game_CoopMonstersKilled,
  Game_CoopSecretsFound,
  Game_CoopTotalMonstersKilled,
  Game_CoopTotalSecretsFound,
  Game_CoopTotalMonsters,
  Game_CoopTotalSecrets,
  PID1, PID2: Word;
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

    e_WriteLog('Loading saved game...', MSG_NOTIFY);
    g_Game_Free();

    g_Game_ClearLoading();
    g_Game_LoadData();
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
  // ����� ������:
    bMem.ReadByte(Game_MaxLives);
  // ������� �����:
    bMem.ReadDWORD(Game_Options);
  // ��� �����:
    bMem.ReadWord(Game_CoopMonstersKilled);
    bMem.ReadWord(Game_CoopSecretsFound);
    bMem.ReadWord(Game_CoopTotalMonstersKilled);
    bMem.ReadWord(Game_CoopTotalSecretsFound);
    bMem.ReadWord(Game_CoopTotalMonsters);
    bMem.ReadWord(Game_CoopTotalSecrets);
  // C�������� ���� ���������:
    bMem.Free();
    bMem := nil;
  ///// /////

  ///// ��������� ��������� �������� ���������: /////
    bMem := TBinMemoryReader.Create();
    bFile.ReadMemory(bMem);
    bMem.ReadDWORD(sig);
    if sig <> PLAYER_VIEW_SIGNATURE then // 'PLVW'
    begin
      raise EInOutError.Create('g_LoadGame: Wrong Player View Signature');
    end;
    bMem.ReadWord(PID1);
    bMem.ReadWord(PID2);
    bMem.Free();
    bMem := nil;
  ///// /////

  // ��������� �����:
    ZeroMemory(@gGameSettings, SizeOf(TGameSettings));
    gAimLine := False;
    gShowMap := False;
    if (Game_Type = GT_NONE) or (Game_Type = GT_SINGLE) then
    begin
    // ��������� ����:
      gGameSettings.GameType := GT_SINGLE;
      gGameSettings.MaxLives := 0;
      gGameSettings.Options := gGameSettings.Options + GAME_OPTION_ALLOWEXIT;
      gGameSettings.Options := gGameSettings.Options + GAME_OPTION_MONSTERS;
      gGameSettings.Options := gGameSettings.Options + GAME_OPTION_BOTVSMONSTER;
      gSwitchGameMode := GM_SINGLE;
    end
    else
    begin
    // ��������� ����:
      gGameSettings.GameType := GT_CUSTOM;
      gGameSettings.GameMode := Game_Mode;
      gSwitchGameMode := Game_Mode;
      gGameSettings.TimeLimit := Game_TimeLimit;
      gGameSettings.GoalLimit := Game_GoalLimit;
      gGameSettings.MaxLives := IfThen(Game_Mode = GM_CTF, 0, Game_MaxLives);
      gGameSettings.Options := Game_Options;
    end;
    g_Game_ExecuteEvent('ongamestart');

  // ��������� �������� ���� �������:
    g_Game_SetupScreenSize();

  // �������� � ������ �����:
    if not g_Game_StartMap(WAD_Path + ':\' + Map_Name, True) then
    begin
      g_FatalError(Format(_lc[I_GAME_ERROR_MAP_LOAD], [WAD_Path + ':\' + Map_Name]));
      Exit;
    end;

  // ��������� ������� � �����:
    g_Player_Init();

  // ������������� �����:
    gTime := Game_Time;
  // ���������� �����:
    gCoopMonstersKilled := Game_CoopMonstersKilled;
    gCoopSecretsFound := Game_CoopSecretsFound;
    gCoopTotalMonstersKilled := Game_CoopTotalMonstersKilled;
    gCoopTotalSecretsFound := Game_CoopTotalSecretsFound;
    gCoopTotalMonsters := Game_CoopTotalMonsters;
    gCoopTotalSecrets := Game_CoopTotalSecrets;

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
    // ���������:
      for i := 0 to nPlayers-1 do
      begin
      // ��������� ��������� ������:
        bMem := TBinMemoryReader.Create();
        bFile.ReadMemory(bMem);
      // ��������� ������/����:
        g_Player_CreateFromState(bMem);
        bMem.Free();
        bMem := nil;
      end;
    end;
  // ����������� �������� ������� � �������� ���������:
    gPlayer1 := g_Player_Get(PID1);
    gPlayer2 := g_Player_Get(PID2);
    if gPlayer1 <> nil then
    begin
      gPlayer1.Name := gPlayer1Settings.Name;
      gPlayer1.FPreferredTeam := gPlayer1Settings.Team;
      gPlayer1.FActualModelName := gPlayer1Settings.Model;
      gPlayer1.SetModel(gPlayer1.FActualModelName);
      gPlayer1.SetColor(gPlayer1Settings.Color);
    end;
    if gPlayer2 <> nil then
    begin
      gPlayer2.Name := gPlayer2Settings.Name;
      gPlayer2.FPreferredTeam := gPlayer2Settings.Team;
      gPlayer2.FActualModelName := gPlayer2Settings.Model;
      gPlayer2.SetModel(gPlayer2.FActualModelName);
      gPlayer2.SetColor(gPlayer2Settings.Color);
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
