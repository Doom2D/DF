unit g_netmaster;

interface

uses ENet;

const
  NET_MCHANS = 2;

  NET_MCHAN_MAIN = 0;
  NET_MCHAN_UPD  = 1;

  NET_MMSG_UPD = 200;
  NET_MMSG_DEL = 201;
  NET_MMSG_GET = 202;

type
  TNetServer = record
    Number: Byte;
    Protocol: Byte;
    Name: string;
    IP: string;
    Port: Word;
    Map: string;
    Players, MaxPlayers, LocalPl, Bots: Byte;
    Ping: Integer;
    GameMode: Byte;
    Password: Boolean;
    PingAddr: ENetAddress;
  end;
  pTNetServer = ^TNetServer;

  TNetServerList = array of TNetServer;
  pTNetServerList = ^TNetServerList;

var
  NetMHost:       pENetHost = nil;
  NetMPeer:       pENetPeer = nil;

  slCurrent:       TNetServerList = nil;
  slWaitStr:       string = '';
  slReturnPressed: Boolean = True;

procedure g_Net_Slist_Set(IP: string; Port: Word);
function  g_Net_Slist_Fetch(var SL: TNetServerList): Boolean;
procedure g_Net_Slist_Update();
procedure g_Net_Slist_Remove();
function  g_Net_Slist_Connect(): Boolean;
procedure g_Net_Slist_Check();
procedure g_Net_Slist_Disconnect();
procedure g_Net_Slist_WriteInfo();

procedure g_Serverlist_Draw(var SL: TNetServerList);
procedure g_Serverlist_Control(var SL: TNetServerList);

implementation

uses
  SysUtils, e_fixedbuffer, e_input, e_graphics, e_log, g_window, g_net, g_console,
  g_map, g_game, g_sound, g_textures, g_gui, g_menu, g_options, g_language, WADEDITOR,
  Windows, ENet_Win32;

var
  NetMEvent:      ENetEvent;
  slSelection:    Byte = 0;
  slFetched:      Boolean = False;
  slDirPressed:   Boolean = False;

procedure PingServer(var S: TNetServer; Sock: ENetSocket);
var
  Buf: ENetBuffer;
  Ping: array [0..5] of Byte;
  ClTime: Integer;
begin
  ClTime := GetCurrentTime();

  Buf.data := Addr(Ping[0]);
  Buf.dataLength := 6;

  Ping[0] := Ord('D');
  Ping[1] := Ord('F');
  LongInt(Addr(Ping[2])^) := ClTime;

  enet_socket_send(Sock, Addr(S.PingAddr), @Buf, 1);
end;

function g_Net_Slist_Fetch(var SL: TNetServerList): Boolean;
var
  Cnt: Byte;
  P: pENetPacket;
  MID: Byte;
  I, T, RX: Integer;
  Sock: ENetSocket;
  Buf: ENetBuffer;
  SvAddr: ENetAddress;
begin
  Result := False;
  SL := nil;

  if (NetMHost <> nil) or (NetMPeer <> nil) then
    Exit;

  if not g_Net_Slist_Connect then
    Exit;

  e_WriteLog('Fetching serverlist...', MSG_NOTIFY);
  g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_SLIST_FETCH]);

  e_Buffer_Clear(@NetOut);
  e_Buffer_Write(@NetOut, Byte(NET_MMSG_GET));

  P := enet_packet_create(Addr(NetOut.Data), NetOut.Len, Cardinal(ENET_PACKET_FLAG_RELIABLE));
  enet_peer_send(NetMPeer, NET_MCHAN_MAIN, P);
  enet_host_flush(NetMHost);

  while enet_host_service(NetMHost, @NetMEvent, 5000) > 0 do
  begin
    if NetMEvent.kind = ENET_EVENT_TYPE_RECEIVE then
    begin
      e_Raw_Seek(0);
      MID := e_Raw_Read_Byte(NetMEvent.packet^.data);

      if MID <> NET_MMSG_GET then continue;

      Cnt := e_Raw_Read_Byte(NetMEvent.packet^.data);
      e_WriteLog('Retrieved ' + IntToStr(Cnt) + ' server(s).', MSG_NOTIFY);
      g_Console_Add(_lc[I_NET_MSG] + Format(_lc[I_NET_SLIST_RETRIEVED], [Cnt]), True);

      if Cnt > 0 then
      begin
        SetLength(SL, Cnt);

        for I := 0 to Cnt - 1 do
        begin
          SL[I].Number := I;
          SL[I].IP := e_Raw_Read_String(NetMEvent.packet^.data);
          SL[I].Port := e_Raw_Read_Word(NetMEvent.packet^.data);
          SL[I].Name := e_Raw_Read_String(NetMEvent.packet^.data);
          SL[I].Map := e_Raw_Read_String(NetMEvent.packet^.data);
          SL[I].GameMode := e_Raw_Read_Byte(NetMEvent.packet^.data);
          SL[I].Players := e_Raw_Read_Byte(NetMEvent.packet^.data);
          SL[I].MaxPlayers := e_Raw_Read_Byte(NetMEvent.packet^.data);
          SL[I].Protocol := e_Raw_Read_Byte(NetMEvent.packet^.data);
          SL[I].Password := e_Raw_Read_Byte(NetMEvent.packet^.data) = 1;
          enet_address_set_host(Addr(SL[I].PingAddr), PChar(Addr(SL[I].IP[1])));
          SL[I].Ping := -1;
          SL[I].PingAddr.port := SL[I].Port + 1;
        end;
      end;

      Result := True;
      break;
    end;
  end;

  g_Net_Slist_Disconnect;
  e_Buffer_Clear(@NetOut);

  if Length(SL) = 0 then Exit;

  Sock := enet_socket_create(ENET_SOCKET_TYPE_DATAGRAM);
  if Sock < 0 then Exit;
  enet_socket_set_option(Sock, ENET_SOCKOPT_NONBLOCK, 1);

  for I := Low(SL) to High(SL) do
    PingServer(SL[I], Sock);

  T := GetCurrentTime();

  e_Buffer_Clear(@NetIn);
  Buf.data := Addr(NetIn.Data);
  Buf.dataLength := Length(NetIn.Data);
  Cnt := 0;
  while Cnt < Length(SL) do
  begin
    if GetCurrentTime() - T > 500 then break;

    e_Buffer_Clear(@NetIn);

    RX := enet_socket_receive(Sock, @SvAddr, @Buf, 1);
    if RX <= 0 then continue;
    NetIn.Len := RX + 1;
    NetIn.ReadPos := 0;

    if e_Buffer_Read_Char(@NetIn) <> 'D' then continue;
    if e_Buffer_Read_Char(@NetIn) <> 'F' then continue;

    for I := Low(SL) to High(SL) do
      if (SL[I].PingAddr.host = SvAddr.host) and
         (SL[I].PingAddr.port = SvAddr.port) then
      begin
        with SL[I] do
        begin
          Ping := e_Buffer_Read_LongInt(@NetIn);
          Ping := GetCurrentTime() - Ping;
          Name := e_Buffer_Read_String(@NetIn);
          Map := e_Buffer_Read_String(@NetIn);
          GameMode := e_Buffer_Read_Byte(@NetIn);
          Players := e_Buffer_Read_Byte(@NetIn);
          MaxPlayers := e_Buffer_Read_Byte(@NetIn);
          Protocol := e_Buffer_Read_Byte(@NetIn);
          Password := e_Buffer_Read_Byte(@NetIn) = 1;
          LocalPl := e_Buffer_Read_Byte(@NetIn);
          Bots := e_Buffer_Read_Word(@NetIn);
        end;
        Inc(Cnt);
        break;
      end;
  end;

  enet_socket_destroy(Sock);
end;

procedure g_Net_Slist_WriteInfo();
var
  Wad, Map: string;
  Cli: Byte;
begin
  g_ProcessResourceStr(gMapInfo.Map, @Wad, nil, @Map);
  Wad := ExtractFileName(Wad);

  e_Buffer_Write(@NetOut, NetServerName);

  e_Buffer_Write(@NetOut, Wad + ':\' + Map);
  e_Buffer_Write(@NetOut, gGameSettings.GameMode);

  Cli := NetClientCount;
  e_Buffer_Write(@NetOut, Cli);

  e_Buffer_Write(@NetOut, NetMaxClients);

  e_Buffer_Write(@NetOut, Byte(NET_PROTOCOL_VER));
  e_Buffer_Write(@NetOut, Byte(NetPassword <> ''));
end;

procedure g_Net_Slist_Update;
var

  P: pENetPacket;

begin
  if (NetMHost = nil) or (NetMPeer = nil) then Exit;

  e_Buffer_Clear(@NetOut);
  e_Buffer_Write(@NetOut, Byte(NET_MMSG_UPD));
  e_Buffer_Write(@NetOut, NetAddr.port);

  g_Net_Slist_WriteInfo();

  P := enet_packet_create(Addr(NetOut.Data), NetOut.Len, Cardinal(ENET_PACKET_FLAG_RELIABLE));
  enet_peer_send(NetMPeer, NET_MCHAN_UPD, P);

  enet_host_flush(NetMHost);
  e_Buffer_Clear(@NetOut);
end;

procedure g_Net_Slist_Remove;
var
  P: pENetPacket;
begin
  if (NetMHost = nil) or (NetMPeer = nil) then Exit;
  e_Buffer_Clear(@NetOut);
  e_Buffer_Write(@NetOut, Byte(NET_MMSG_DEL));
  e_Buffer_Write(@NetOut, NetAddr.port);

  P := enet_packet_create(Addr(NetOut.Data), NetOut.Len, Cardinal(ENET_PACKET_FLAG_RELIABLE));
  enet_peer_send(NetMPeer, NET_MCHAN_MAIN, P);

  enet_host_flush(NetMHost);
  e_Buffer_Clear(@NetOut);
end;

function g_Net_Slist_Connect: Boolean;
begin
  Result := False;

  NetMHost := enet_host_create(nil, 1, NET_MCHANS, 0, 0);
  if (NetMHost = nil) then
  begin
    g_Console_Add(_lc[I_NET_MSG_ERROR] + _lc[I_NET_ERR_CLIENT], True);
    Exit;
  end;

  NetMPeer := enet_host_connect(NetMHost, @NetSlistAddr, NET_MCHANS, 0);
  if (NetMPeer = nil) then
  begin
    g_Console_Add(_lc[I_NET_MSG_ERROR] + _lc[I_NET_ERR_CLIENT], True);
    enet_host_destroy(NetMHost);
    NetMHost := nil;
    Exit;
  end;

  if (enet_host_service(NetMHost, @NetMEvent, 3000) > 0) then
    if NetMEvent.kind = ENET_EVENT_TYPE_CONNECT then
    begin
      Result := True;
      g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_SLIST_CONN]);
      Exit;
    end
    else
      if NetMEvent.kind = ENET_EVENT_TYPE_RECEIVE then
        enet_packet_destroy(NetMEvent.packet);

  g_Console_Add(_lc[I_NET_MSG_ERROR] + _lc[I_NET_SLIST_ERROR], True);

  NetMHost := nil;
  NetMPeer := nil;
end;

procedure g_Net_Slist_Disconnect;
begin
  if (NetMHost = nil) and (NetMPeer = nil) then Exit;

  if NetMode = NET_SERVER then g_Net_Slist_Remove;

  enet_peer_disconnect(NetMPeer, 0);
  enet_host_flush(NetMHost);

  enet_peer_reset(NetMPeer);
  enet_host_destroy(NetMHost);

  NetMPeer := nil;
  NetMHost := nil;

  g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_SLIST_DISC]);
end;

procedure g_Net_Slist_Check;
begin
  if (NetMHost = nil) or (NetMPeer = nil) then Exit;

  while (enet_host_service(NetMHost, @NetMEvent, 0) > 0) do
  begin
    if NetMEvent.kind = ENET_EVENT_TYPE_DISCONNECT then
    begin
      g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_SLIST_LOST], True);
      if NetMPeer <> nil then enet_peer_reset(NetMPeer);
      if NetMHost <> nil then enet_host_destroy(NetMHost);
      NetMPeer := nil;
      NetMHost := nil;
      Break;
    end
    else
      if NetMEvent.kind = ENET_EVENT_TYPE_RECEIVE then
        enet_packet_destroy(NetMEvent.packet);
  end;
end;

procedure g_Net_Slist_Set(IP: string; Port: Word);
begin
  if NetInitDone then
  begin
    enet_address_set_host(@NetSlistAddr, PChar(Addr(IP[1])));
    NetSlistAddr.Port := Port;
    e_WriteLog('Masterserver address set to ' + IP + ':' + IntToStr(Port), MSG_NOTIFY);
  end;
end;

procedure g_Serverlist_Draw(var SL: TNetServerList);
var
  sy, i, y, mw, mx, l: Integer;
  cw, ch: Byte;
  ww, hh: Word;
  ip: string;
begin
  ip := '';
  sy := 0;

  e_CharFont_GetSize(gMenuFont, _lc[I_NET_SLIST], ww, hh);
  e_CharFont_Print(gMenuFont, (gScreenWidth div 2) - (ww div 2), 16, _lc[I_NET_SLIST]);

  e_TextureFontGetSize(gStdFont, cw, ch);

  ip := _lc[I_NET_SLIST_HELP];
  mw := (Length(ip) * cw) div 2;

  e_DrawFillQuad(16, 64, gScreenWidth-16, gScreenHeight-44, 64, 64, 64, 110);
  e_DrawQuad(16, 64, gScreenWidth-16, gScreenHeight-44, 255, 127, 0);

  e_TextureFontPrintEx(gScreenWidth div 2 - mw, gScreenHeight-24, ip, gStdFont, 225, 225, 225, 1);

  if SL = nil then
  begin
    l := Length(slWaitStr) div 2;
    e_DrawFillQuad(16, 64, gScreenWidth-16, gScreenHeight-44, 64, 64, 64, 128);
    e_DrawQuad(gScreenWidth div 2 - 192, gScreenHeight div 2 - 10,
      gScreenWidth div 2 + 192, gScreenHeight div 2 + 11, 255, 127, 0);
    e_TextureFontPrint(gScreenWidth div 2 - cw * l, gScreenHeight div 2 - ch div 2,
      slWaitStr, gStdFont);
    Exit;
  end;

  y := 90;
  if (slSelection < Length(SL)) then
  begin
    I := slSelection;
    sy := y + 42 * I - 4;
    ip := _lc[I_NET_ADDRESS] + ' ' + SL[I].IP + ':' + IntToStr(SL[I].Port);
    if SL[I].Password then
      ip := ip + '  ' + _lc[I_NET_SERVER_PASSWORD] + ' ' + _lc[I_MENU_YES]
    else
      ip := ip + '  ' + _lc[I_NET_SERVER_PASSWORD] + ' ' + _lc[I_MENU_NO];
  end else
    if Length(SL) > 0 then
      slSelection := 0;

  mw := (gScreenWidth - 188);
  mx := 16 + mw;

  e_DrawFillQuad(16 + 1, sy, gScreenWidth - 16 - 1, sy + 40, 64, 64, 64, 0);
  e_DrawLine(1, 16 + 1, sy, gScreenWidth - 16 - 1, sy, 205, 205, 205);
  e_DrawLine(1, 16 + 1, sy + 41, gScreenWidth - 16 - 1, sy + 41, 255, 255, 255);

  e_DrawLine(1, 16, 85, gScreenWidth - 16, 85, 255, 127, 0);
  e_DrawLine(1, 16, gScreenHeight-64, gScreenWidth-16, gScreenHeight-64, 255, 127, 0);

  e_DrawLine(1, mx - 52, 64, mx - 52, gScreenHeight-44, 255, 127, 0);
  e_DrawLine(1, mx, 64, mx, gScreenHeight-64, 255, 127, 0);
  e_DrawLine(1, mx + 52, 64, mx + 52, gScreenHeight-64, 255, 127, 0);
  e_DrawLine(1, mx + 104, 64, mx + 104, gScreenHeight-64, 255, 127, 0);

  e_TextureFontPrintEx(18, 68, 'NAME/MAP', gStdFont, 255, 127, 0, 1);

  y := 90;
  for I := 0 to High(SL) do
  begin
    e_TextureFontPrintEx(18, y, SL[I].Name, gStdFont, 255, 255, 255, 1);
    e_TextureFontPrintEx(18, y + 16, SL[I].Map, gStdFont, 210, 210, 210, 1);

    y := y + 42;
  end;

  e_TextureFontPrintEx(mx - 50, 68, 'PING', gStdFont, 255, 127, 0, 1);
  y := 90;
  for I := 0 to High(SL) do
  begin
    if (SL[I].Ping < 0) or (SL[I].Ping > 999) then
      e_TextureFontPrintEx(mx - 50, y, _lc[I_NET_SLIST_NO_ACCESS], gStdFont, 255, 0, 0, 1)
    else
      if SL[I].Ping = 0 then
        e_TextureFontPrintEx(mx - 50, y, '<1' + _lc[I_NET_SLIST_PING_MS], gStdFont, 255, 255, 255, 1)
      else
        e_TextureFontPrintEx(mx - 50, y, IntToStr(SL[I].Ping) + _lc[I_NET_SLIST_PING_MS], gStdFont, 255, 255, 255, 1);

    y := y + 42;
  end;

  e_TextureFontPrintEx(mx + 2, 68, 'MODE', gStdFont, 255, 127, 0, 1);
  y := 90;
  for I := 0 to High(SL) do
  begin
    e_TextureFontPrintEx(mx + 2, y, g_Game_ModeToText(SL[I].GameMode), gStdFont, 255, 255, 255, 1);

    y := y + 42;
  end;

  e_TextureFontPrintEx(mx + 54, 68, 'PLRS', gStdFont, 255, 127, 0, 1);
  y := 90;
  for I := 0 to High(SL) do
  begin
    e_TextureFontPrintEx(mx + 54, y, IntToStr(SL[I].Players) + '/' + IntToStr(SL[I].MaxPlayers), gStdFont, 255, 255, 255, 1);
    e_TextureFontPrintEx(mx + 54, y + 16, IntToStr(SL[I].LocalPl) + '+' + IntToStr(SL[I].Bots), gStdFont, 210, 210, 210, 1);
    y := y + 42;
  end;

  e_TextureFontPrintEx(mx + 106, 68, 'VER', gStdFont, 255, 127, 0, 1);
  y := 90;
  for I := 0 to High(SL) do
  begin
    e_TextureFontPrintEx(mx + 106, y, IntToStr(SL[I].Protocol), gStdFont, 255, 255, 255, 1);

    y := y + 42;
  end;

  e_TextureFontPrintEx(20, gScreenHeight-61, ip, gStdFont, 205, 205, 205, 1);
  ip := IntToStr(Length(SL)) + _lc[I_NET_SLIST_SERVERS];
  e_TextureFontPrintEx(gScreenWidth - 40 - (Length(ip) + 1)*cw,
    gScreenHeight-61, ip, gStdFont, 205, 205, 205, 1);
end;

procedure g_Serverlist_Control(var SL: TNetServerList);
begin
  if gConsoleShow or gChatShow then
    Exit;

  e_PollInput();

  if e_KeyPressed(e_IKey_Escape) then
  begin
    SL := nil;
    gState := STATE_MENU;
    g_GUI_ShowWindow('MainMenu');
    g_GUI_ShowWindow('NetGameMenu');
    g_GUI_ShowWindow('NetClientMenu');
    g_Sound_PlayEx(WINDOW_CLOSESOUND);
    Exit;
  end;

  if e_KeyPressed(e_IKey_Space) then
  begin
    if not slFetched then
    begin
      slWaitStr := _lc[I_NET_SLIST_WAIT];

      g_Game_Draw;
      g_window.ReDrawWindow;

      if g_Net_Slist_Fetch(SL) then
      begin
        if SL = nil then
          slWaitStr := _lc[I_NET_SLIST_NOSERVERS];
      end
      else
        slWaitStr := _lc[I_NET_SLIST_ERROR];
      slFetched := True;
      slSelection := 0;
    end;
  end
  else
    slFetched := False;

  if SL = nil then Exit;

  if e_KeyPressed(e_IKey_Enter) then
  begin
    if not slReturnPressed then
    begin
      if SL[slSelection].Password then
      begin
        PromptIP := SL[slSelection].IP;
        PromptPort := SL[slSelection].Port;
        gState := STATE_MENU;
        g_GUI_ShowWindow('ClientPasswordMenu');
        SL := nil;
        slReturnPressed := True;
        Exit;
      end
      else
        g_Game_StartClient(SL[slSelection].IP, SL[slSelection].Port, '');
      SL := nil;
      slReturnPressed := True;
      Exit;
    end;
  end
  else
    slReturnPressed := False;

  if e_KeyPressed(e_IKey_Down) then
  begin
    if not slDirPressed then
    begin
      Inc(slSelection);
      if slSelection > High(SL) then slSelection := 0;
      slDirPressed := True;
    end;
  end;
  
  if e_KeyPressed(e_IKey_Up) then
  begin
    if not slDirPressed then
    begin
      if slSelection = 0 then slSelection := Length(SL);
      Dec(slSelection);

      slDirPressed := True;
    end;
  end;

  if (not e_KeyPressed(e_IKey_Down)) and (not e_KeyPressed(e_IKey_Up)) then
    slDirPressed := False;
end;

end.
