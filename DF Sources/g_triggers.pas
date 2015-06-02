unit g_triggers;

interface

uses
  MAPSTRUCT, e_graphics, Windows, MAPDEF, g_basic, g_sound,
  BinEditor;

type
  TTrigger = record
    TriggerType:      Byte;
    X, Y:             Integer;
    Width, Height:    Word;
    Enabled:          Boolean;
    ActivateType:     Byte;
    Keys:             Byte;
    TexturePanel:     Integer;
    TexturePanelType: Word;

    TimeOut:          Word;
    ActivateUID:      Word;
    PlayerCollide:    Boolean;
    DoorTime:         Integer;
    PressTime:        Integer;
    PressCount:       Integer;
    SoundPlayCount:   Integer;
    Sound:            TPlayableSound;

    Data:             TTriggerData;
  end;

function g_Triggers_Create(Trigger: TTrigger): DWORD;
procedure g_Triggers_Update();
procedure g_Triggers_Press(ID: DWORD; ActivateType: Byte);
function g_Triggers_PressR(X, Y: Integer; Width, Height: Word; UID: Word;
                           ActivateType: Byte; IgnoreList: DWArray = nil): DWArray;
procedure g_Triggers_PressL(X1, Y1, X2, Y2: Integer; UID: DWORD; ActivateType: Byte);
procedure g_Triggers_PressC(CX, CY: Integer; Radius: Word; UID: Word; ActivateType: Byte);
procedure g_Triggers_OpenAll();
procedure g_Triggers_Free();
procedure g_Triggers_SaveState(var Mem: TBinMemoryWriter);
procedure g_Triggers_LoadState(var Mem: TBinMemoryReader);

var
  gTriggers: array of TTrigger;
  gSecretsCount: Integer = 0;
  gMonstersSpawned: array of LongInt = nil;

implementation

uses
  g_player, g_map, Math, g_gfx, g_game, g_textures,
  g_console, g_monsters, g_items, g_phys, g_weapons,
  WADEDITOR, g_main, SysUtils, e_log, g_language,
  g_options, g_netmsg;

const
  TRIGGER_SIGNATURE = $52475254; // 'TRGR'


function FindTrigger(): DWORD;
var
  i: Integer;
begin
  if gTriggers <> nil then
    for i := 0 to High(gTriggers) do
      if gTriggers[i].TriggerType = TRIGGER_NONE then
      begin
        Result := i;
        Exit;
      end;

  if gTriggers = nil then
  begin
    SetLength(gTriggers, 8);
    Result := 0;
  end
  else
  begin
    Result := High(gTriggers) + 1;
    SetLength(gTriggers, Length(gTriggers) + 8);
  end;
end;

function CloseDoor(PanelID: Integer; NoSound: Boolean; d2d: Boolean): Boolean;
var
  a, b, c: Integer;
begin
  Result := False;

  if PanelID = -1 then Exit;

  if not d2d then
  begin
    with gWalls[PanelID] do
    begin
      if g_CollidePlayer(X, Y, Width, Height) or
         g_CollideMonster(X, Y, Width, Height) then Exit;

      if not Enabled then
      begin
        if not NoSound then
        begin
          g_Sound_PlayExAt('SOUND_GAME_DOORCLOSE', X, Y);
          if g_Game_IsServer and g_Game_IsNet then
            MH_SEND_Sound(X, Y, 'SOUND_GAME_DOORCLOSE');
        end;
        g_Map_EnableWall(PanelID);
        Result := True;
      end;
    end;
  end
  else
  begin
    if gDoorMap = nil then Exit;

    c := -1;
    for a := 0 to High(gDoorMap) do
    begin
      for b := 0 to High(gDoorMap[a]) do
        if gDoorMap[a, b] = DWORD(PanelID) then
        begin
          c := a;
          Break;
        end;

      if c <> -1 then Break;
    end;
    if c = -1 then Exit;

    for b := 0 to High(gDoorMap[c]) do
      with gWalls[gDoorMap[c, b]] do
      begin
        if g_CollidePlayer(X, Y, Width, Height) or
          g_CollideMonster(X, Y, Width, Height) then Exit;
      end;

    if not NoSound then
      for b := 0 to High(gDoorMap[c]) do
        if not gWalls[gDoorMap[c, b]].Enabled then
        begin
          with gWalls[PanelID] do
          begin
            g_Sound_PlayExAt('SOUND_GAME_DOORCLOSE', X, Y);
            if g_Game_IsServer and g_Game_IsNet then
              MH_SEND_Sound(X, Y, 'SOUND_GAME_DOORCLOSE');
          end;
          Break;
        end;

    for b := 0 to High(gDoorMap[c]) do
      if not gWalls[gDoorMap[c, b]].Enabled then
      begin
        g_Map_EnableWall(gDoorMap[c, b]);
        Result := True;
      end;
  end;
end;

procedure CloseTrap(PanelID: Integer; NoSound: Boolean; d2d: Boolean);
var
  a, b, c: Integer;
begin
  if PanelID = -1 then Exit;

  if not d2d then
  begin
    with gWalls[PanelID] do
      if (not NoSound) and (not Enabled) then
      begin
        g_Sound_PlayExAt('SOUND_GAME_SWITCH1', X, Y);
        if g_Game_IsServer and g_Game_IsNet then
          MH_SEND_Sound(X, Y, 'SOUND_GAME_SWITCH1');
      end;


    with gWalls[PanelID] do
    begin
      if gPlayers <> nil then
        for a := 0 to High(gPlayers) do
          if (gPlayers[a] <> nil) and gPlayers[a].Live and
              gPlayers[a].Collide(X, Y, Width, Height) then
            gPlayers[a].Damage(1000, 0, 0, 0, HIT_TRAP);

      if gMonsters <> nil then
        for a := 0 to High(gMonsters) do
          if (gMonsters[a] <> nil) and gMonsters[a].Live and
          g_Obj_Collide(X, Y, Width, Height, @gMonsters[a].Obj) then
            gMonsters[a].Damage(1000, 0, 0, 0, HIT_TRAP);

      if not Enabled then g_Map_EnableWall(PanelID);
    end;
  end
  else
  begin
    if gDoorMap = nil then Exit;

    c := -1;
    for a := 0 to High(gDoorMap) do
    begin
      for b := 0 to High(gDoorMap[a]) do
        if gDoorMap[a, b] = DWORD(PanelID) then
        begin
          c := a;
          Break;
        end;

      if c <> -1 then Break;
    end;
    if c = -1 then Exit;

    if not NoSound then
      for b := 0 to High(gDoorMap[c]) do
        if not gWalls[gDoorMap[c, b]].Enabled then
        begin
          with gWalls[PanelID] do
          begin
            g_Sound_PlayExAt('SOUND_GAME_SWITCH1', X, Y);
            if g_Game_IsServer and g_Game_IsNet then
              MH_SEND_Sound(X, Y, 'SOUND_GAME_SWITCH1');
          end;
          Break;
        end;

    for b := 0 to High(gDoorMap[c]) do
      with gWalls[gDoorMap[c, b]] do
      begin
        if gPlayers <> nil then
          for a := 0 to High(gPlayers) do
            if (gPlayers[a] <> nil) and gPlayers[a].Live and
            gPlayers[a].Collide(X, Y, Width, Height) then
              gPlayers[a].Damage(1000, 0, 0, 0, HIT_TRAP);

        if gMonsters <> nil then
          for a := 0 to High(gMonsters) do
            if (gMonsters[a] <> nil) and gMonsters[a].Live and
            g_Obj_Collide(X, Y, Width, Height, @gMonsters[a].Obj) then
              gMonsters[a].Damage(1000, 0, 0, 0, HIT_TRAP);

        if not Enabled then g_Map_EnableWall(gDoorMap[c, b]);
      end;
  end;
end;

function OpenDoor(PanelID: Integer; NoSound: Boolean; d2d: Boolean): Boolean;
var
  a, b, c: Integer;
begin
  Result := False;

  if PanelID = -1 then Exit;

  if not d2d then
  begin
    with gWalls[PanelID] do
      if Enabled then
      begin
        if not NoSound then
        begin
          g_Sound_PlayExAt('SOUND_GAME_DOOROPEN', X, Y);
          if g_Game_IsServer and g_Game_IsNet then
            MH_SEND_Sound(X, Y, 'SOUND_GAME_DOOROPEN');
        end;
        g_Map_DisableWall(PanelID);
        Result := True;
      end;
  end
  else
  begin
    if gDoorMap = nil then Exit;

    c := -1;
    for a := 0 to High(gDoorMap) do
    begin
      for b := 0 to High(gDoorMap[a]) do
        if gDoorMap[a, b] = DWORD(PanelID) then
        begin
          c := a;
          Break;
        end;

      if c <> -1 then Break;
    end;
    if c = -1 then Exit;

    if not NoSound then
      for b := 0 to High(gDoorMap[c]) do
        if gWalls[gDoorMap[c, b]].Enabled then
        begin
          with gWalls[PanelID] do
          begin
            g_Sound_PlayExAt('SOUND_GAME_DOOROPEN', X, Y);
            if g_Game_IsServer and g_Game_IsNet then
              MH_SEND_Sound(X, Y, 'SOUND_GAME_DOOROPEN');
          end;
          Break;
        end;

    for b := 0 to High(gDoorMap[c]) do
      if gWalls[gDoorMap[c, b]].Enabled then
      begin
        g_Map_DisableWall(gDoorMap[c, b]);
        Result := True;
      end;
  end;
end;

function SetLift(PanelID: Integer; d: Integer; NoSound: Boolean; d2d: Boolean): Boolean;
var
  a, b, c, t: Integer;
begin
  t := 0;
  Result := False;

  if PanelID = -1 then Exit;

  if (gLifts[PanelID].PanelType = PANEL_LIFTUP) or
     (gLifts[PanelID].PanelType = PANEL_LIFTDOWN) then
    case d of
      0: t := 0;
      1: t := 1;
      else t := IfThen(gLifts[PanelID].LiftType = 1, 0, 1);
    end
  else if (gLifts[PanelID].PanelType = PANEL_LIFTLEFT) or
          (gLifts[PanelID].PanelType = PANEL_LIFTRIGHT) then
    case d of
      0: t := 2;
      1: t := 3;
      else t := IfThen(gLifts[PanelID].LiftType = 2, 3, 2);
    end;

  if not d2d then
  begin
    with gLifts[PanelID] do
      if LiftType <> t then
      begin
        g_Map_SetLift(PanelID, t);

        {if not NoSound then
          g_Sound_PlayExAt('SOUND_GAME_SWITCH0', X, Y);}
        Result := True;
      end;
  end
  else // ��� � D2d
  begin
    if gLiftMap = nil then Exit;

    c := -1;
    for a := 0 to High(gLiftMap) do
    begin
      for b := 0 to High(gLiftMap[a]) do
        if gLiftMap[a, b] = DWORD(PanelID) then
        begin
          c := a;
          Break;
        end;

      if c <> -1 then Break;
    end;
    if c = -1 then Exit;

    {if not NoSound then
      for b := 0 to High(gLiftMap[c]) do
        if gLifts[gLiftMap[c, b]].LiftType <> t then
        begin
          with gLifts[PanelID] do
            g_Sound_PlayExAt('SOUND_GAME_SWITCH0', X, Y);
          Break;
        end;}

    for b := 0 to High(gLiftMap[c]) do
      with gLifts[gLiftMap[c, b]] do
        if LiftType <> t then
        begin
          g_Map_SetLift(gLiftMap[c, b], t);

          Result := True;
        end;
  end;
end;


function ActivateTrigger(var Trigger: TTrigger; actType: Byte): Boolean;
var
  animonce: Boolean;
  p: TPlayer;
  m: TMonster;
  i, k: Integer;
  iid: LongWord;
  coolDown: Boolean;
  pAngle: Real;
  FramesID: DWORD;
  Anim: TAnimation;
begin
  Result := False;
  if g_Game_IsClient then
    Exit;

  if not Trigger.Enabled then
    Exit;
  if Trigger.TimeOut <> 0 then
    Exit;
  if gLMSRespawn then
    Exit;

  animonce := False;

  coolDown := (actType <> 0);

  with Trigger do
  begin
    case TriggerType of
      TRIGGER_EXIT:
        begin
          g_Sound_PlayEx('SOUND_GAME_SWITCH0');
          if g_Game_IsNet then MH_SEND_Sound(X, Y, 'SOUND_GAME_SWITCH0');
          g_Game_ExitLevel(Data.MapName);
          TimeOut := 18;
          Result := True;

          Exit;
        end;

      TRIGGER_TELEPORT:
        begin
          case g_GetUIDType(ActivateUID) of
            UID_PLAYER:
              begin
                p := g_Player_Get(ActivateUID);
                if p = nil then
                  Exit;

                if Data.d2d_teleport then
                  begin
                    if p.TeleportTo(Data.TargetPoint.X-(p.Obj.Rect.Width div 2),
                                    Data.TargetPoint.Y-p.Obj.Rect.Height,
                                    Data.silent_teleport,
                                    Data.TlpDir) then
                      Result := True;
                  end
                else
                  if p.TeleportTo(Data.TargetPoint.X,
                                  Data.TargetPoint.Y,
                                  Data.silent_teleport,
                                  Data.TlpDir) then
                    Result := True;
              end;

            UID_MONSTER:
              begin
                m := g_Monsters_Get(ActivateUID);
                if m = nil then
                  Exit;

                if Data.d2d_teleport then
                  begin
                    if m.TeleportTo(Data.TargetPoint.X-(m.Obj.Rect.Width div 2),
                                    Data.TargetPoint.Y-m.Obj.Rect.Height,
                                    Data.silent_teleport,
                                    Data.TlpDir) then
                      Result := True;
                  end
                else
                  if m.TeleportTo(Data.TargetPoint.X,
                                  Data.TargetPoint.Y,
                                  Data.silent_teleport,
                                  Data.TlpDir) then
                    Result := True;
              end;
          end;

          TimeOut := 0;
        end;

      TRIGGER_OPENDOOR:
        begin
          Result := OpenDoor(Data.PanelID, Data.NoSound, Data.d2d_doors);
          TimeOut := 0;
        end;

      TRIGGER_CLOSEDOOR:
        begin
          Result := CloseDoor(Data.PanelID, Data.NoSound, Data.d2d_doors);
          TimeOut := 0;
        end;

      TRIGGER_DOOR, TRIGGER_DOOR5:
        begin
          if Data.PanelID <> -1 then
          begin
            if gWalls[Data.PanelID].Enabled then
              begin
                Result := OpenDoor(Data.PanelID, Data.NoSound, Data.d2d_doors);

                if TriggerType = TRIGGER_DOOR5 then
                  DoorTime := 180;
              end
            else
              Result := CloseDoor(Data.PanelID, Data.NoSound, Data.d2d_doors);

            if Result then
              TimeOut := 18;
          end;
        end;

      TRIGGER_CLOSETRAP, TRIGGER_TRAP:
        begin
          CloseTrap(Data.PanelID, Data.NoSound, Data.d2d_doors);

          if TriggerType = TRIGGER_TRAP then
            begin
              DoorTime := 40;
              TimeOut := 76;
            end
          else
            begin
              DoorTime := -1;
              TimeOut := 0;
            end;

          Result := True;
        end;

      TRIGGER_PRESS, TRIGGER_ON, TRIGGER_OFF, TRIGGER_ONOFF:
        begin
          PressCount := PressCount + 1;
          
          if PressTime = -1 then
            PressTime := Data.Wait;

          if coolDown then
            TimeOut := 18
          else
            TimeOut := 0;
          Result := True;
        end;

      TRIGGER_SECRET:
        if g_GetUIDType(ActivateUID) = UID_PLAYER then
        begin
          Enabled := False;
          Result := True;
          if not gLMSRespawn then
          begin
            g_Player_Get(ActivateUID).GetSecret();
            Inc(gCoopSecretsFound);
            if g_Game_IsNet then MH_SEND_GameStats();
          end;
        end;

      TRIGGER_LIFTUP:
        begin
          Result := SetLift(Data.PanelID, 0, Data.NoSound, Data.d2d_doors);
          TimeOut := 0;

          if (not Data.NoSound) and Result then begin
            g_Sound_PlayExAt('SOUND_GAME_SWITCH0',
                             X + (Width div 2),
                             Y + (Height div 2));
            if g_Game_IsServer and g_Game_IsNet then
              MH_SEND_Sound(X + (Width div 2),
                            Y + (Height div 2),
                            'SOUND_GAME_SWITCH0');
          end;
        end;

      TRIGGER_LIFTDOWN:
        begin
          Result := SetLift(Data.PanelID, 1, Data.NoSound, Data.d2d_doors);
          TimeOut := 0;

          if (not Data.NoSound) and Result then begin
            g_Sound_PlayExAt('SOUND_GAME_SWITCH0',
                             X + (Width div 2),
                             Y + (Height div 2));
            if g_Game_IsServer and g_Game_IsNet then
              MH_SEND_Sound(X + (Width div 2),
                            Y + (Height div 2),
                            'SOUND_GAME_SWITCH0');
          end;
        end;

      TRIGGER_LIFT:
        begin
          Result := SetLift(Data.PanelID, 3, Data.NoSound, Data.d2d_doors);

          if Result then
          begin
            TimeOut := 18;

            if (not Data.NoSound) and Result then begin
              g_Sound_PlayExAt('SOUND_GAME_SWITCH0',
                               X + (Width div 2),
                               Y + (Height div 2));
              if g_Game_IsServer and g_Game_IsNet then
                MH_SEND_Sound(X + (Width div 2),
                              Y + (Height div 2),
                              'SOUND_GAME_SWITCH0');
            end;
          end;
        end;

      TRIGGER_TEXTURE:
        begin
          if ByteBool(Data.ActivateOnce) then
            begin
              Enabled := False;
              TriggerType := TRIGGER_NONE;
            end
          else
            if coolDown then
              TimeOut := 6
           else
             TimeOut := 0;

          animonce := Data.AnimOnce;
          Result := True;
        end;

      TRIGGER_SOUND:
        begin
          if Sound <> nil then
          begin
            if Data.SoundSwitch and Sound.IsPlaying() then
              begin // ����� ���������, ���� �����
                Sound.Stop();
                SoundPlayCount := 0;
                Result := True;
              end
            else // (not Data.SoundSwitch) or (not Sound.IsPlaying())
              if (Data.PlayCount > 0) or (not Sound.IsPlaying()) then
                begin
                  if Data.PlayCount > 0 then
                    SoundPlayCount := Data.PlayCount
                  else // 0 - ������ ����������
                    SoundPlayCount := 1;
                  Result := True;
                end;
            if g_Game_IsNet then MH_SEND_TriggerSound(Trigger);
          end;
        end;

      TRIGGER_SPAWNMONSTER:
        if (Data.MonType in [MONSTER_DEMON..MONSTER_MAN]) then
        begin
          for k := 1 to Data.MonCount do
          begin
            i := g_Monsters_Create(Data.MonType,
                   Data.MonPos.X, Data.MonPos.Y,
                   TDirection(Data.MonDir), True);

          // ��������:
            if (Data.MonHealth > 0) then
              gMonsters[i].SetHealth(Data.MonHealth);
          // ���� ������ ����, ���� ����:
            if (Data.MonActive) then
              gMonsters[i].WakeUp();
            gMonsters[i].FNoRespawn := True;

            if Data.MonType <> MONSTER_BARREL then Inc(gTotalMonsters);

            if g_Game_IsNet then
            begin
              SetLength(gMonstersSpawned, Length(gMonstersSpawned)+1);
              gMonstersSpawned[High(gMonstersSpawned)] := gMonsters[i].UID;
            end;

            case Data.MonEffect of
              1: begin
                if g_Frames_Get(FramesID, 'FRAMES_TELEPORT') then
                begin
                  Anim := TAnimation.Create(FramesID, False, 3);
                  g_Sound_PlayExAt('SOUND_GAME_TELEPORT', Data.MonPos.X, Data.MonPos.Y);
                  g_GFX_OnceAnim(gMonsters[i].Obj.X+gMonsters[i].Obj.Rect.X+(gMonsters[i].Obj.Rect.Width div 2)-32,
                                 gMonsters[i].Obj.Y+gMonsters[i].Obj.Rect.Y+(gMonsters[i].Obj.Rect.Height div 2)-32, Anim);
                  Anim.Free();
                end;
                if g_Game_IsServer and g_Game_IsNet then
                  MH_SEND_Effect(gMonsters[i].Obj.X+gMonsters[i].Obj.Rect.X+(gMonsters[i].Obj.Rect.Width div 2)-32,
                                 gMonsters[i].Obj.Y+gMonsters[i].Obj.Rect.Y+(gMonsters[i].Obj.Rect.Height div 2)-32, 1,
                                 NET_GFX_TELE);
              end;
              2: begin
                if g_Frames_Get(FramesID, 'FRAMES_ITEM_RESPAWN') then
                begin
                  Anim := TAnimation.Create(FramesID, False, 4);
                  g_Sound_PlayExAt('SOUND_ITEM_RESPAWNITEM', Data.MonPos.X, Data.MonPos.Y);
                  g_GFX_OnceAnim(gMonsters[i].Obj.X+gMonsters[i].Obj.Rect.X+(gMonsters[i].Obj.Rect.Width div 2)-16,
                                 gMonsters[i].Obj.Y+gMonsters[i].Obj.Rect.Y+(gMonsters[i].Obj.Rect.Height div 2)-16, Anim);
                  Anim.Free();
                end;
                if g_Game_IsServer and g_Game_IsNet then
                  MH_SEND_Effect(gMonsters[i].Obj.X+gMonsters[i].Obj.Rect.X+(gMonsters[i].Obj.Rect.Width div 2)-16,
                                 gMonsters[i].Obj.Y+gMonsters[i].Obj.Rect.Y+(gMonsters[i].Obj.Rect.Height div 2)-16, 1,
                                 NET_GFX_RESPAWN);
              end;
              3: begin
                if g_Frames_Get(FramesID, 'FRAMES_FIRE') then
                begin
                  Anim := TAnimation.Create(FramesID, False, 4);
                  g_Sound_PlayExAt('SOUND_FIRE', Data.MonPos.X, Data.MonPos.Y);
                  g_GFX_OnceAnim(gMonsters[i].Obj.X+gMonsters[i].Obj.Rect.X+(gMonsters[i].Obj.Rect.Width div 2)-32,
                                 gMonsters[i].Obj.Y+gMonsters[i].Obj.Rect.Y+gMonsters[i].Obj.Rect.Height-128, Anim);
                  Anim.Free();
                end;
                if g_Game_IsServer and g_Game_IsNet then
                  MH_SEND_Effect(gMonsters[i].Obj.X+gMonsters[i].Obj.Rect.X+(gMonsters[i].Obj.Rect.Width div 2)-32,
                                 gMonsters[i].Obj.Y+gMonsters[i].Obj.Rect.Y+gMonsters[i].Obj.Rect.Height-128, 1,
                                 NET_GFX_FIRE);
              end;
            end;

            if g_Game_IsNet then
              MH_SEND_MonsterSpawn(gMonsters[i].UID);
          end;
          if g_Game_IsNet then
          begin
            MH_SEND_GameStats();
            MH_SEND_CoopStats();
          end;

          if coolDown then
            TimeOut := 18
          else
            TimeOut := 0;
          Result := True;
        end;

      TRIGGER_SPAWNITEM:
        if (Data.ItemType in [ITEM_MEDKIT_SMALL..ITEM_MAX]) then
        begin
          if (not Data.ItemOnlyDM) or
             (gGameSettings.GameMode in [GM_DM, GM_TDM, GM_CTF]) then
            for k := 1 to Data.ItemCount do
            begin
              iid := g_Items_Create(Data.ItemPos.X, Data.ItemPos.Y,
                Data.ItemType, Data.ItemFalls, False, True);

              case Data.ItemEffect of
                1: begin
                  if g_Frames_Get(FramesID, 'FRAMES_TELEPORT') then
                  begin
                    Anim := TAnimation.Create(FramesID, False, 3);
                    g_Sound_PlayExAt('SOUND_GAME_TELEPORT', Data.ItemPos.X, Data.ItemPos.Y);
                    g_GFX_OnceAnim(gItems[iid].Obj.X+gItems[iid].Obj.Rect.X+(gItems[iid].Obj.Rect.Width div 2)-32,
                                   gItems[iid].Obj.Y+gItems[iid].Obj.Rect.Y+(gItems[iid].Obj.Rect.Height div 2)-32, Anim);
                    Anim.Free();
                  end;
                  if g_Game_IsServer and g_Game_IsNet then
                    MH_SEND_Effect(gItems[iid].Obj.X+gItems[iid].Obj.Rect.X+(gItems[iid].Obj.Rect.Width div 2)-32,
                                   gItems[iid].Obj.Y+gItems[iid].Obj.Rect.Y+(gItems[iid].Obj.Rect.Height div 2)-32, 1,
                                   NET_GFX_TELE);
                end;
                2: begin
                  if g_Frames_Get(FramesID, 'FRAMES_ITEM_RESPAWN') then
                  begin
                    Anim := TAnimation.Create(FramesID, False, 4);
                    g_Sound_PlayExAt('SOUND_ITEM_RESPAWNITEM', Data.ItemPos.X, Data.ItemPos.Y);
                    g_GFX_OnceAnim(gItems[iid].Obj.X+gItems[iid].Obj.Rect.X+(gItems[iid].Obj.Rect.Width div 2)-16,
                                   gItems[iid].Obj.Y+gItems[iid].Obj.Rect.Y+(gItems[iid].Obj.Rect.Height div 2)-16, Anim);
                    Anim.Free();
                  end;
                  if g_Game_IsServer and g_Game_IsNet then
                    MH_SEND_Effect(gItems[iid].Obj.X+gItems[iid].Obj.Rect.X+(gItems[iid].Obj.Rect.Width div 2)-16,
                                   gItems[iid].Obj.Y+gItems[iid].Obj.Rect.Y+(gItems[iid].Obj.Rect.Height div 2)-16, 1,
                                   NET_GFX_RESPAWN);
                end;
                3: begin
                  if g_Frames_Get(FramesID, 'FRAMES_FIRE') then
                  begin
                    Anim := TAnimation.Create(FramesID, False, 4);
                    g_Sound_PlayExAt('SOUND_FIRE', Data.ItemPos.X, Data.ItemPos.Y);
                    g_GFX_OnceAnim(gItems[iid].Obj.X+gItems[iid].Obj.Rect.X+(gItems[iid].Obj.Rect.Width div 2)-32,
                                   gItems[iid].Obj.Y+gItems[iid].Obj.Rect.Y+gItems[iid].Obj.Rect.Height-128, Anim);
                    Anim.Free();
                  end;
                  if g_Game_IsServer and g_Game_IsNet then
                    MH_SEND_Effect(gItems[iid].Obj.X+gItems[iid].Obj.Rect.X+(gItems[iid].Obj.Rect.Width div 2)-32,
                                   gItems[iid].Obj.Y+gItems[iid].Obj.Rect.Y+gItems[iid].Obj.Rect.Height-128, 1,
                                   NET_GFX_FIRE);
                end;
              end;

              if g_Game_IsNet then
                MH_SEND_ItemSpawn(True, iid);
            end;

          if coolDown then
            TimeOut := 18
          else
            TimeOut := 0;
          Result := True;
        end;

      TRIGGER_MUSIC:
        begin
        // ������ ������, ���� ���� �� ���:
          if (Trigger.Data.MusicName <> '') then
          begin
            gMusic.SetByName(Trigger.Data.MusicName);
            gMusic.SpecPause := True;
            gMusic.Play();
          end;

          if Trigger.Data.MusicAction = 1 then
            begin // ��������
              if gMusic.SpecPause then // ���� �� ����� => ������
                gMusic.SpecPause := False
              else // ������ => �������
                gMusic.SetPosition(0);
            end
          else // ���������
            begin
            // �����:
              gMusic.SpecPause := True;
            end;

          if coolDown then
            TimeOut := 36
          else
            TimeOut := 0;
          Result := True;
          if g_Game_IsNet then MH_SEND_TriggerMusic;
        end;

      TRIGGER_PUSH:
        begin
          case g_GetUIDType(ActivateUID) of
            UID_PLAYER:
              begin
                p := g_Player_Get(ActivateUID);
                if p = nil then
                  Exit;
                if Data.ResetVel then
                begin
                  p.GameVelX := 0;
                  p.GameVelY := 0;
                  p.GameAccelX := 0;
                  p.GameAccelY := 0;
                end;

                pAngle := -DegToRad(Data.PushAngle);
                p.Push(Floor(Cos(pAngle)*Data.PushForce),
                       Floor(Sin(pAngle)*Data.PushForce));
              end;

            UID_MONSTER:
              begin
                m := g_Monsters_Get(ActivateUID);
                if m = nil then
                  Exit;
                if Data.ResetVel then
                begin
                  m.GameVelX := 0;
                  m.GameVelY := 0;
                  m.GameAccelX := 0;
                  m.GameAccelY := 0;
                end;

                pAngle := DegToRad(Data.PushAngle);
                m.Push(Floor(Cos(pAngle)*Data.PushForce),
                       Floor(Sin(pAngle)*Data.PushForce));
              end;
          end;

          TimeOut := 0;
          Result := True;
        end;
    end;
  end;
 
  if Result and (Trigger.TexturePanel <> -1) then
    g_Map_SwitchTexture(Trigger.TexturePanelType, Trigger.TexturePanel, IfThen(animonce, 2, 1));
end;

function g_Triggers_Create(Trigger: TTrigger): DWORD;
var
  find_id: DWORD;
  fn, mapw: String;
begin
// �� ��������� �����, ���� ���� ��� ������:
  if (Trigger.TriggerType = TRIGGER_EXIT) and
     (not LongBool(gGameSettings.Options and GAME_OPTION_ALLOWEXIT)) then
    Trigger.TriggerType := TRIGGER_NONE;

// ���� ������� ���������, �������� �������:
  if (Trigger.TriggerType = TRIGGER_SPAWNMONSTER) and
     (not LongBool(gGameSettings.Options and GAME_OPTION_MONSTERDM)) and
     (gGameSettings.GameType <> GT_SINGLE) then
    Trigger.TriggerType := TRIGGER_NONE;

// ������� ���������� �������� �� �����:
  if Trigger.TriggerType = TRIGGER_SECRET then
    gSecretsCount := gSecretsCount + 1;

  find_id := FindTrigger();
  gTriggers[find_id] := Trigger;

  with gTriggers[find_id] do
  begin
    TimeOut := 0;
    ActivateUID := 0;
    PlayerCollide := False;
    DoorTime := -1;
    PressTime := -1;
    PressCount := 0;
    SoundPlayCount := 0;
    Sound := nil;
  end;

// ��������� ����, ���� ��� ������� "����":
  if (Trigger.TriggerType = TRIGGER_SOUND) and
     (Trigger.Data.SoundName <> '') then
  begin
  // ��� ��� ������ �����:
    if not g_Sound_Exists(Trigger.Data.SoundName) then
    begin
      g_ProcessResourceStr(Trigger.Data.SoundName, @fn, nil, nil);

      if fn = '' then
        begin // ���� � ����� � ������
          g_ProcessResourceStr(gMapInfo.Map, @mapw, nil, nil);
          fn := mapw + Trigger.Data.SoundName;
        end
      else // ���� � ��������� �����
        fn := GameDir + '\wads\' + Trigger.Data.SoundName;

      if not g_Sound_CreateWADEx(Trigger.Data.SoundName, fn) then
        g_FatalError(Format(_lc[I_GAME_ERROR_TR_SOUND], [fn, Trigger.Data.SoundName]));
    end;

  // ������� ������ �����:
    with gTriggers[find_id] do
    begin
      Sound := TPlayableSound.Create();
      if not Sound.SetByName(Trigger.Data.SoundName) then
      begin
        Sound.Free();
        Sound := nil;
      end;
    end;
  end;

// ��������� ������, ���� ��� ������� "������":
  if (Trigger.TriggerType = TRIGGER_MUSIC) and
     (Trigger.Data.MusicName <> '') then
  begin
  // ��� ��� ����� ������:
    if not g_Sound_Exists(Trigger.Data.MusicName) then
    begin
      g_ProcessResourceStr(Trigger.Data.MusicName, @fn, nil, nil);

      if fn = '' then
        begin // ������ � ����� � ������
          g_ProcessResourceStr(gMapInfo.Map, @mapw, nil, nil);
          fn := mapw + Trigger.Data.MusicName;
        end
      else // ������ � ����� � ������
        fn := GameDir+'\wads\'+Trigger.Data.MusicName;

      if not g_Sound_CreateWADEx(Trigger.Data.MusicName, fn, True) then
        g_FatalError(Format(_lc[I_GAME_ERROR_TR_SOUND], [fn, Trigger.Data.MusicName]));
    end;
  end;

  Result := find_id;
end;

procedure g_Triggers_Update();
var
  a, b: Integer;
begin
  if gTriggers = nil then
    Exit;

  for a := 0 to High(gTriggers) do
    with gTriggers[a] do
    // ���� ������� � �� �������:
      if (TriggerType <> TRIGGER_NONE) and Enabled then
      begin
      // ��������� ����� �� �������� ����� (�������� �������):
        if DoorTime > 0 then
          DoorTime := DoorTime - 1;
      // ��������� ����� �������� ����� �������:
        if PressTime > 0 then
          PressTime := PressTime - 1;

      // ������� "����" ��� �������, ���� ����� ��� - �������������:
        if (TriggerType = TRIGGER_SOUND) and (Sound <> nil) then
          if (SoundPlayCount > 0) and (not Sound.IsPlaying()) then
          begin
            if Data.PlayCount > 0 then // ���� 0 - ������ ���� ����������
              SoundPlayCount := SoundPlayCount - 1;
            if Data.Local then
              Sound.PlayVolumeAt(X+(Width div 2), Y+(Height div 2), Data.Volume/255.0)
            else
              Sound.PlayPanVolume((Data.Pan-127.0)/128.0, Data.Volume/255.0);
          end;

      // ������� "�������" - ���� ���������:
        if (TriggerType = TRIGGER_TRAP) and (DoorTime = 0) and (Data.PanelID <> -1) then
        begin
          OpenDoor(Data.PanelID, Data.NoSound, Data.d2d_doors);
          DoorTime := -1;
        end;

      // ������� "����� 5 ���" - ���� ���������:
        if (TriggerType = TRIGGER_DOOR5) and (DoorTime = 0) and (Data.PanelID <> -1) then
        begin
        // ��� �������:
          if gWalls[Data.PanelID].Enabled then
            DoorTime := -1
          else // ���� ������� - ���������
            if CloseDoor(Data.PanelID, Data.NoSound, Data.d2d_doors) then
              DoorTime := -1;
        end;

      // ������� - ����������� ��� �������������, � ������ ��������, � ������ ������ ����� ���:
        if (TriggerType in [TRIGGER_PRESS, TRIGGER_ON, TRIGGER_OFF, TRIGGER_ONOFF]) and
           (PressTime = 0) and (PressCount >= Data.Count) then
        begin
        // ���������� �������� ���������:
          PressTime := -1;
        // ���������� ������� �������:
          if Data.Count > 0 then
            PressCount := PressCount - Data.Count
          else
            PressCount := 0;

        // ���������� �� ��������:
          for b := 0 to High(gTriggers) do
            if g_Collide(Data.tX, Data.tY, Data.tWidth, Data.tHeight, gTriggers[b].X, gTriggers[b].Y,
               gTriggers[b].Width, gTriggers[b].Height) and
               ((b <> a) or (Data.Wait > 0)) then
            begin // Can be self-activated, if there is Data.Wait
              case TriggerType of
                TRIGGER_PRESS:
                  begin
                    gTriggers[b].ActivateUID := gTriggers[a].ActivateUID;
                    ActivateTrigger(gTriggers[b], 0);
                  end;
                TRIGGER_ON:
                  begin
                    gTriggers[b].Enabled := True;
                  end;
                TRIGGER_OFF:
                  begin
                    gTriggers[b].Enabled := False;
                  end;
                TRIGGER_ONOFF:
                  begin
                    gTriggers[b].Enabled := not gTriggers[b].Enabled;
                  end;
              end;
            end;
        end;

      // ��������� ����� �� ����������� ��������� ���������:
        if TimeOut > 0 then
        begin
          TimeOut := TimeOut - 1;
          Continue; // ����� �� �������� 1 ������� ��������
        end;

      // "����� ������":
        if ByteBool(ActivateType and ACTIVATE_PLAYERCOLLIDE) and
           (TimeOut = 0) then
          if gPlayers <> nil then
            for b := 0 to High(gPlayers) do
              if gPlayers[b] <> nil then
                with gPlayers[b] do
                // ���, ���� ������ ����� � �� �����:
                  if Live and ((gTriggers[a].Keys and GetKeys) = gTriggers[a].Keys) and
                     Collide(X, Y, Width, Height) then
                  begin
                    gTriggers[a].ActivateUID := UID;

                    if (gTriggers[a].TriggerType in [TRIGGER_SOUND, TRIGGER_MUSIC]) and
                       PlayerCollide then
                      { Don't activate sound/music again if player is here }
                    else
                      ActivateTrigger(gTriggers[a], ACTIVATE_PLAYERCOLLIDE);
                  end;

        { TODO 5 : ��������� ��������� ��������� � ������� }

      // "������ ������":
        if ByteBool(ActivateType and ACTIVATE_MONSTERCOLLIDE) and
           (TimeOut = 0) and (Keys = 0) then // ���� �� ����� �����
          if gMonsters <> nil then
            for b := 0 to High(gMonsters) do
              if (gMonsters[b] <> nil) then
                with gMonsters[b] do
                  if Collide(X, Y, Width, Height) then
                  begin
                    gTriggers[a].ActivateUID := UID;
                    ActivateTrigger(gTriggers[a], ACTIVATE_MONSTERCOLLIDE);
                  end;

      // "�������� ���":
        if ByteBool(ActivateType and ACTIVATE_NOMONSTER) and
           (TimeOut = 0) and (Keys = 0) then
          if not g_CollideMonster(X, Y, Width, Height) then
          begin
            gTriggers[a].ActivateUID := 0;
            ActivateTrigger(gTriggers[a], ACTIVATE_NOMONSTER);
          end;

        PlayerCollide := g_CollidePlayer(X, Y, Width, Height);
      end;
end;

procedure g_Triggers_Press(ID: DWORD; ActivateType: Byte);
begin
  gTriggers[ID].ActivateUID := 0;
  ActivateTrigger(gTriggers[ID], ActivateType);
end;

function g_Triggers_PressR(X, Y: Integer; Width, Height: Word; UID: Word;
                           ActivateType: Byte; IgnoreList: DWArray = nil): DWArray;
var
  a: Integer;
  k: Byte;
  p: TPlayer;
begin
  if gTriggers = nil then Exit;

  case g_GetUIDType(UID) of
    UID_GAME: k := 255;
    UID_PLAYER:
    begin
      p := g_Player_Get(UID);
      if p <> nil then
        k := p.GetKeys
      else
        k := 0;
    end;
    else k := 0;
  end;

  Result := nil;

  for a := 0 to High(gTriggers) do
    if (gTriggers[a].TriggerType <> TRIGGER_NONE) and
       (gTriggers[a].TimeOut = 0) and
       (not InDWArray(a, IgnoreList)) and
       ((gTriggers[a].Keys and k) = gTriggers[a].Keys) and
       ByteBool(gTriggers[a].ActivateType and ActivateType) then
      if g_Collide(X, Y, Width, Height,
         gTriggers[a].X, gTriggers[a].Y,
         gTriggers[a].Width, gTriggers[a].Height) then
      begin
        gTriggers[a].ActivateUID := UID;
        if ActivateTrigger(gTriggers[a], ActivateType) then
        begin
          SetLength(Result, Length(Result)+1);
          Result[High(Result)] := a;
        end;
      end;
end;

procedure g_Triggers_PressL(X1, Y1, X2, Y2: Integer; UID: DWORD; ActivateType: Byte);
var
  a: Integer;
  k: Byte;
  p: TPlayer;
begin
  if gTriggers = nil then Exit;

  case g_GetUIDType(UID) of
    UID_GAME: k := 255;
    UID_PLAYER:
    begin
      p := g_Player_Get(UID);
      if p <> nil then
        k := p.GetKeys
      else
        k := 0;
    end;
    else k := 0;
  end;

  for a := 0 to High(gTriggers) do
    if (gTriggers[a].TriggerType <> TRIGGER_NONE) and
       (gTriggers[a].TimeOut = 0) and
       ((gTriggers[a].Keys and k) = gTriggers[a].Keys) and
       ByteBool(gTriggers[a].ActivateType and ActivateType) then
      if g_CollideLine(x1, y1, x2, y2, gTriggers[a].X, gTriggers[a].Y,
         gTriggers[a].Width, gTriggers[a].Height) then
      begin
        gTriggers[a].ActivateUID := UID;
        ActivateTrigger(gTriggers[a], ActivateType);
      end;
end;

procedure g_Triggers_PressC(CX, CY: Integer; Radius: Word; UID: Word; ActivateType: Byte);
var
  a: Integer;
  k: Byte;
  rsq: Word;
  p: TPlayer;
begin
  if gTriggers = nil then
    Exit;

  case g_GetUIDType(UID) of
    UID_GAME: k := 255;
    UID_PLAYER:
    begin
     p := g_Player_Get(UID);
     if p <> nil then
      k := p.GetKeys
     else
      k := 0;
    end;
    else k := 0;
  end;

  rsq := Radius * Radius;

  for a := 0 to High(gTriggers) do
    if (gTriggers[a].TriggerType <> TRIGGER_NONE) and
       (gTriggers[a].TimeOut = 0) and
       ((gTriggers[a].Keys and k) = gTriggers[a].Keys) and
       ByteBool(gTriggers[a].ActivateType and ActivateType) then
      with gTriggers[a] do
        if g_Collide(CX-Radius, CY-Radius, 2*Radius, 2*Radius,
                     X, Y, Width, Height) then
          if ((Sqr(CX-X)+Sqr(CY-Y)) < rsq) or // ����� ����� ������ � �������� ������ ����
             ((Sqr(CX-X-Width)+Sqr(CY-Y)) < rsq) or // ����� ����� ������ � �������� ������� ����
             ((Sqr(CX-X-Width)+Sqr(CY-Y-Height)) < rsq) or // ����� ����� ������ � ������� ������� ����
             ((Sqr(CX-X)+Sqr(CY-Y-Height)) < rsq) or // ����� ����� ������ � ������� ������ ����
             ( (CX > (X-Radius)) and (CX < (X+Width+Radius)) and
               (CY > Y) and (CY < (Y+Height)) ) or // ����� ����� �������� �� ������������ ������ ��������������
             ( (CY > (Y-Radius)) and (CY < (Y+Height+Radius)) and
               (CX > X) and (CX < (X+Width)) ) then // ����� ����� �������� �� �������������� ������ ��������������
          begin
            ActivateUID := UID;
            ActivateTrigger(gTriggers[a], ActivateType);
          end;
end;

procedure g_Triggers_OpenAll();
var
  a: Integer;
  b: Boolean;
begin
  if gTriggers = nil then Exit;

  b := False;
  for a := 0 to High(gTriggers) do
    with gTriggers[a] do
      if (TriggerType = TRIGGER_OPENDOOR) or
         (TriggerType = TRIGGER_DOOR5) or
         (TriggerType = TRIGGER_DOOR) then
      begin
        OpenDoor(Data.PanelID, True, Data.d2d_doors);
        if TriggerType = TRIGGER_DOOR5 then DoorTime := 180;
        b := True;
      end;

  if b then g_Sound_PlayEx('SOUND_GAME_DOOROPEN');
end;

procedure g_Triggers_Free();
var
  a: Integer;
begin
  if gTriggers <> nil then
    for a := 0 to High(gTriggers) do
      if gTriggers[a].TriggerType = TRIGGER_SOUND then
      begin
        if g_Sound_Exists(gTriggers[a].Data.SoundName) then
          g_Sound_Delete(gTriggers[a].Data.SoundName);

        gTriggers[a].Sound.Free();
      end;

  gTriggers := nil;
  gSecretsCount := 0;
  SetLength(gMonstersSpawned, 0);
end;

procedure g_Triggers_SaveState(var Mem: TBinMemoryWriter);
var
  count, i: Integer;
  dw: DWORD;
  sg: Single;
  b: Boolean;
  p: Pointer;
begin
// ������� ���������� ������������ ���������:
  count := 0;
  if gTriggers <> nil then
    for i := 0 to High(gTriggers) do
      count := count + 1;

  Mem := TBinMemoryWriter.Create((count+1) * 200);

// ���������� ���������:
  Mem.WriteInt(count);

  if count = 0 then
    Exit;

  for i := 0 to High(gTriggers) do
  begin
  // ��������� ��������:
    dw := TRIGGER_SIGNATURE; // 'TRGR'
    Mem.WriteDWORD(dw);
  // ��� ��������:
    Mem.WriteByte(gTriggers[i].TriggerType);
  // ����������� ������ ��������:
    p := @gTriggers[i].Data;
    Mem.WriteMemory(p, SizeOf(TTriggerData));
  // ���������� ������ �������� ����:
    Mem.WriteInt(gTriggers[i].X);
    Mem.WriteInt(gTriggers[i].Y);
  // �������:
    Mem.WriteWord(gTriggers[i].Width);
    Mem.WriteWord(gTriggers[i].Height);
  // ������� �� �������:
    Mem.WriteBoolean(gTriggers[i].Enabled);
  // ��� ��������� ��������:
    Mem.WriteByte(gTriggers[i].ActivateType);
  // �����, ����������� ��� ���������:
    Mem.WriteByte(gTriggers[i].Keys);
  // ID ������, �������� ������� ���������:
    Mem.WriteInt(gTriggers[i].TexturePanel);
  // ��� ���� ������:
    Mem.WriteWord(gTriggers[i].TexturePanelType);
  // ����� �� ����������� ���������:
    Mem.WriteWord(gTriggers[i].TimeOut);
  // UID ����, ��� ����������� ���� �������:
    Mem.WriteWord(gTriggers[i].ActivateUID);
  // ����� �� ����� � ������� ��������:
    Mem.WriteBoolean(gTriggers[i].PlayerCollide);
  // ����� �� �������� �����:
    Mem.WriteInt(gTriggers[i].DoorTime);
  // �������� ���������:
    Mem.WriteInt(gTriggers[i].PressTime);
  // ������� �������:
    Mem.WriteInt(gTriggers[i].PressCount);
  // ������� ��� �������� ����:
    Mem.WriteInt(gTriggers[i].SoundPlayCount);
  // ������������� �� ����?
    if gTriggers[i].Sound <> nil then
      b := gTriggers[i].Sound.IsPlaying()
    else
      b := False;
    Mem.WriteBoolean(b);
    if b then
    begin
    // ������� ������������ �����:
      dw := gTriggers[i].Sound.GetPosition();
      Mem.WriteDWORD(dw);
    // ��������� �����:
      sg := gTriggers[i].Sound.GetVolume();
      sg := sg / (gSoundLevel/255.0);
      Mem.WriteSingle(sg);
    // ������ �������� �����:
      sg := gTriggers[i].Sound.GetPan();
      Mem.WriteSingle(sg);
    end;
  end;
end;

procedure g_Triggers_LoadState(var Mem: TBinMemoryReader);
var
  count, i, a: Integer;
  dw: DWORD;
  vol, pan: Single;
  b: Boolean;
  p: Pointer;
  Trig: TTrigger;
begin
  if Mem = nil then
    Exit;

  g_Triggers_Free();

// ���������� ���������:
  Mem.ReadInt(count);

  if count = 0 then
    Exit;

  for a := 0 to count-1 do
  begin
  // ��������� ��������:
    Mem.ReadDWORD(dw);
    if dw <> TRIGGER_SIGNATURE then // 'TRGR'
    begin
      raise EBinSizeError.Create('g_Triggers_LoadState: Wrong Trigger Signature');
    end;
  // ��� ��������:
    Mem.ReadByte(Trig.TriggerType);
  // ����������� ������ ��������:
    Mem.ReadMemory(p, dw);
    if dw <> SizeOf(TTriggerData) then
    begin
      raise EBinSizeError.Create('g_Triggers_LoadState: Wrong TriggerData Size');
    end;
    Trig.Data := TTriggerData(p^);
  // ������� �������:
    i := g_Triggers_Create(Trig);
  // ���������� ������ �������� ����:
    Mem.ReadInt(gTriggers[i].X);
    Mem.ReadInt(gTriggers[i].Y);
  // �������:
    Mem.ReadWord(gTriggers[i].Width);
    Mem.ReadWord(gTriggers[i].Height);
  // ������� �� �������:
    Mem.ReadBoolean(gTriggers[i].Enabled);
  // ��� ��������� ��������:
    Mem.ReadByte(gTriggers[i].ActivateType);
  // �����, ����������� ��� ���������:
    Mem.ReadByte(gTriggers[i].Keys);
  // ID ������, �������� ������� ���������:
    Mem.ReadInt(gTriggers[i].TexturePanel);
  // ��� ���� ������:
    Mem.ReadWord(gTriggers[i].TexturePanelType);
  // ����� �� ����������� ���������:
    Mem.ReadWord(gTriggers[i].TimeOut);
  // UID ����, ��� ����������� ���� �������:
    Mem.ReadWord(gTriggers[i].ActivateUID);
  // ����� �� ����� � ������� ��������:
    Mem.ReadBoolean(gTriggers[i].PlayerCollide);
  // ����� �� �������� �����:
    Mem.ReadInt(gTriggers[i].DoorTime);
  // �������� ���������:
    Mem.ReadInt(gTriggers[i].PressTime);
  // ������� �������:
    Mem.ReadInt(gTriggers[i].PressCount);
  // ������� ��� �������� ����:
    Mem.ReadInt(gTriggers[i].SoundPlayCount);
  // ������������� �� ����?
    Mem.ReadBoolean(b);
    if b then
    begin
    // ������� ������������ �����:
      Mem.ReadDWORD(dw);
    // ��������� �����:
      Mem.ReadSingle(vol);
    // ������ �������� �����:
      Mem.ReadSingle(pan);
    // ��������� ����, ���� ����:
      if gTriggers[i].Sound <> nil then
      begin
        gTriggers[i].Sound.PlayPanVolume(pan, vol);
        gTriggers[i].Sound.Pause(True);
        gTriggers[i].Sound.SetPosition(dw);
      end
    end;
  end;
end;

end.
