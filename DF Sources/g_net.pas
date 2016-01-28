unit g_net;

interface

uses
  e_log, e_fixedbuffer, ENet, ENet_Types, ENet_Win32, Classes;

const
  NET_PROTOCOL_VER = 161;

  NET_MAXCLIENTS = 24;
  NET_CHANS = 11;

  NET_CHAN_SERVICE = 0;
  NET_CHAN_IMPORTANT = 1;
  NET_CHAN_GAME = 2;
  NET_CHAN_PLAYER = 3;
  NET_CHAN_PLAYERPOS = 4;
  NET_CHAN_MONSTER = 5;
  NET_CHAN_MONSTERPOS = 6;
  NET_CHAN_LARGEDATA = 7;
  NET_CHAN_CHAT = 8;
  NET_CHAN_DOWNLOAD = 9;
  NET_CHAN_SHOTS = 10;

  NET_NONE = 0;
  NET_SERVER = 1;
  NET_CLIENT = 2;

  NET_BUFSIZE = 65536;

  NET_EVERYONE = -1;

  NET_DISC_NONE: enet_uint32 = 0;
  NET_DISC_PROTOCOL: enet_uint32 = 1;
  NET_DISC_VERSION: enet_uint32 = 2;
  NET_DISC_FULL: enet_uint32 = 3;
  NET_DISC_KICK: enet_uint32 = 4;
  NET_DISC_DOWN: enet_uint32 = 5;
  NET_DISC_PASSWORD: enet_uint32 = 6;
  NET_DISC_TEMPBAN: enet_uint32 = 7;
  NET_DISC_BAN: enet_uint32 = 8;
  NET_DISC_MAX: enet_uint32 = 8;

  NET_STATE_NONE = 0;
  NET_STATE_AUTH = 1;
  NET_STATE_GAME = 2;

  BANLIST_FILENAME = 'banlist.txt';

type
  TNetClient = record
    ID:      Byte;
    Used:    Boolean;
    State:   Byte;
    Peer:    pENetPeer;
    Player:  Word;
    RequestedFullUpdate: Boolean;
    RCONAuth: Boolean;
    Voted:    Boolean;
  end;
  TBanRecord = record
    IP: LongWord;
    Perm: Boolean;
  end;
  pTNetClient = ^TNetClient;

  AByte = array of Byte;

var
  NetInitDone:     Boolean = False;
  NetMode:         Byte = NET_NONE;

  NetServerName:   string = 'Unnamed Server';
  NetPassword:     string = '';
  NetPort:         Word = 25666;

  NetAllowRCON:    Boolean = False;
  NetRCONPassword: string = '';

  NetTimeToUpdate:   Cardinal = 0;
  NetTimeToReliable: Cardinal = 0;
  NetTimeToMaster:   Cardinal = 0;

  NetHost:       pENetHost = nil;
  NetPeer:       pENetPeer = nil;
  NetEvent:      ENetEvent;
  NetAddr:       ENetAddress;

  NetPongAddr:   ENetAddress;
  NetPongSock:   ENetSocket = ENET_SOCKET_NULL;

  NetUseMaster: Boolean = True;
  NetSlistAddr: ENetAddress;
  NetSlistIP:   string = 'mpms.doom2d.org';
  NetSlistPort: Word = 25665;

  NetClientIP:   string = '127.0.0.1';
  NetClientPort: Word   = 25666;

  NetIn, NetOut: TBuffer;

  NetClients:     array of TNetClient;
  NetClientCount: Byte = 0;
  NetMaxClients:  Byte = 255;
  NetBannedHosts: array of TBanRecord;

  NetState:      Integer = NET_STATE_NONE;

  NetMyID:       Integer = -1;
  NetPlrUID1:    Integer = -1;
  NetPlrUID2:    Integer = -1;

  NetInterpLevel: Integer = 1;
  NetUpdateRate:  Cardinal = 0;  // as soon as possible
  NetRelupdRate:  Cardinal = 18; // around two times a second
  NetMasterRate:  Cardinal = 60000;

  NetForcePlayerUpdate: Boolean = False;
  NetPredictSelf:       Boolean = True;
  NetGotKeys:           Boolean = False;

  NetGotEverything: Boolean = False;

function  g_Net_Init(): Boolean;
procedure g_Net_Cleanup();
procedure g_Net_Free();
procedure g_Net_Flush();

function  g_Net_Host(IPAddr: LongWord; Port: enet_uint16; MaxClients: Cardinal = 16): Boolean;
procedure g_Net_Host_Die();
procedure g_Net_Host_Send(ID: Integer; Reliable: Boolean; Chan: Byte = NET_CHAN_GAME);
function  g_Net_Host_Update(): enet_size_t;

function  g_Net_Connect(IP: string; Port: enet_uint16): Boolean;
procedure g_Net_Disconnect(Forced: Boolean = False);
procedure g_Net_Client_Send(Reliable: Boolean; Chan: Byte = NET_CHAN_GAME);
function  g_Net_Client_Update(): enet_size_t;
function  g_Net_Client_UpdateWhileLoading(): enet_size_t;

function  g_Net_Client_ByName(Name: string): pTNetClient;
function  g_Net_Client_ByPlayer(PID: Word): pTNetClient;
function  g_Net_ClientName_ByID(ID: Integer): string;

procedure g_Net_SendData(Data:AByte; peer: pENetPeer; Reliable: Boolean; Chan: Byte = NET_CHAN_DOWNLOAD);
function  g_Net_Wait_Event(msgId: Word): TMemoryStream;

function  IpToStr(IP: LongWord): string;
function  StrToIp(IPstr: string; var IP: LongWord): Boolean;

function  g_Net_IsHostBanned(IP: LongWord; Perm: Boolean = False): Boolean;
procedure g_Net_BanHost(IP: LongWord; Perm: Boolean = True); overload;
procedure g_Net_BanHost(IP: string; Perm: Boolean = True); overload;
function  g_Net_UnbanHost(IP: string): Boolean; overload;
function  g_Net_UnbanHost(IP: LongWord): Boolean; overload;
procedure g_Net_UnbanNonPermHosts();
procedure g_Net_SaveBanList();

implementation

uses
  SysUtils,
  e_input, g_nethandler, g_netmsg, g_netmaster, g_player, g_window, g_console,
  g_main, g_game, g_language, g_weapons;


{ /// SERVICE FUNCTIONS /// }


function g_Net_FindSlot(): Integer;
var
  I: Integer;
  F: Boolean;
  N, C: Integer;
begin
  N := -1;
  F := False;
  C := 0;
  for I := Low(NetClients) to High(NetClients) do
  begin
    if NetClients[I].Used then
      Inc(C)
    else
      if not F then
      begin
        F := True;
        N := I;
      end;
  end;
  if C >= NetMaxClients then
  begin
    Result := -1;
    Exit;
  end;

  if not F then
  begin
    if (Length(NetClients) >= NetMaxClients) then
      N := -1
    else
    begin
      SetLength(NetClients, Length(NetClients) + 1);
      N := High(NetClients);
    end;
  end;

  if N >= 0 then
  begin
    NetClients[N].Used := True;
    NetClients[N].ID := N;
    NetClients[N].RequestedFullUpdate := False;
    NetClients[N].RCONAuth := False;
    NetClients[N].Voted := False;
    NetClients[N].Player := 0;
  end;

  Result := N;
end;

function g_Net_Init(): Boolean;
var
  F: TextFile;
  IPstr: string;
  IP: LongWord;
begin
  e_Buffer_Clear(@NetIn);
  e_Buffer_Clear(@NetOut);
  SetLength(NetClients, 0);
  NetPeer := nil;
  NetHost := nil;
  NetMyID := -1;
  NetPlrUID1 := -1;
  NetPlrUID2 := -1;
  NetAddr.port := 25666;
  SetLength(NetBannedHosts, 0);
  if FileExists(DataDir + BANLIST_FILENAME) then
  begin
    Assign(F, DataDir + BANLIST_FILENAME);
    Reset(F);
    while not EOF(F) do
    begin
      Readln(F, IPstr);
      if StrToIp(IPstr, IP) then
        g_Net_BanHost(IP);
    end;
    CloseFile(F);
    g_Net_SaveBanList();
  end;

  Result := (enet_initialize() = 0);
end;

procedure g_Net_Flush();
begin
  enet_host_flush(NetHost);
end;

procedure g_Net_Cleanup();
begin
  e_Buffer_Clear(@NetIn);
  e_Buffer_Clear(@NetOut);

  SetLength(NetClients, 0);
  NetClientCount := 0;

  NetPeer := nil;
  NetHost := nil;
  NetMPeer := nil;
  NetMHost := nil;
  NetMyID := -1;
  NetPlrUID1 := -1;
  NetPlrUID2 := -1;
  NetState := NET_STATE_NONE;

  NetPongSock := ENET_SOCKET_NULL;

  NetTimeToMaster := 0;
  NetTimeToUpdate := 0;
  NetTimeToReliable := 0;

  NetMode := NET_NONE;
end;

procedure g_Net_Free();
begin
  g_Net_Cleanup();

  enet_deinitialize();
  NetInitDone := False;
end;


{ /// SERVER FUNCTIONS /// }


function g_Net_Host(IPAddr: LongWord; Port: enet_uint16; MaxClients: Cardinal = 16): Boolean;
begin
  if NetMode <> NET_NONE then
  begin
    g_Console_Add(_lc[I_NET_MSG_ERROR] + _lc[I_NET_ERR_INGAME]);
    Result := False;
    Exit;
  end;

  Result := True;

  g_Console_Add(_lc[I_NET_MSG] + Format(_lc[I_NET_MSG_HOST], [Port]));
  if not NetInitDone then
  begin
    if (not g_Net_Init()) then
    begin
      g_Console_Add(_lc[I_NET_MSG_FERROR] + _lc[I_NET_ERR_ENET]);
      Result := False;
      Exit;
    end
    else
      NetInitDone := True;
  end;

  NetAddr.host := IPAddr;
  NetAddr.port := Port;

  NetHost := enet_host_create(@NetAddr, NET_MAXCLIENTS, NET_CHANS, 0, 0);

  if (NetHost = nil) then
  begin
    g_Console_Add(_lc[I_NET_MSG_ERROR] + Format(_lc[I_NET_ERR_HOST], [Port]));
    Result := False;
    g_Net_Cleanup;
    Exit;
  end;

  NetPongSock := enet_socket_create(ENET_SOCKET_TYPE_DATAGRAM);
  if NetPongSock <> ENET_SOCKET_NULL then
  begin
    NetPongAddr.host := IPAddr;
    NetPongAddr.port := Port + 1;
    if enet_socket_bind(NetPongSock, @NetPongAddr) < 0 then
    begin
      enet_socket_destroy(NetPongSock);
      NetPongSock := ENET_SOCKET_NULL;
    end
    else
      enet_socket_set_option(NetPongSock, ENET_SOCKOPT_NONBLOCK, 1);
  end;

  NetMode := NET_SERVER;
  e_Buffer_Clear(@NetOut);
end;

procedure g_Net_Host_Die();
var
  I: Integer;
begin
  if NetMode <> NET_SERVER then Exit;

  g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_MSG_HOST_DISCALL]);
  for I := 0 to High(NetClients) do
    if NetClients[I].Used then
      enet_peer_disconnect(NetClients[I].Peer, NET_DISC_DOWN);

  while enet_host_service(NetHost, @NetEvent, 1000) > 0 do
    if NetEvent.kind = ENET_EVENT_TYPE_RECEIVE then
      enet_packet_destroy(NetEvent.packet);

  for I := 0 to High(NetClients) do
    if NetClients[I].Used then
    begin
      FreeMemory(NetClients[I].Peer^.data);
      NetClients[I].Peer^.data := nil;
      enet_peer_reset(NetClients[I].Peer);
      NetClients[I].Peer := nil;
      NetClients[I].Used := False;
    end;

  if (NetMPeer <> nil) and (NetMHost <> nil) then g_Net_Slist_Disconnect;
  if NetPongSock <> ENET_SOCKET_NULL then
    enet_socket_destroy(NetPongSock);

  g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_MSG_HOST_DIE]);
  enet_host_destroy(NetHost);

  NetMode := NET_NONE;

  g_Net_Cleanup;
  e_WriteLog('NET: Server stopped', MSG_NOTIFY);
end;


procedure g_Net_Host_Send(ID: Integer; Reliable: Boolean; Chan: Byte = NET_CHAN_GAME);
var
  P: pENetPacket;
  F: enet_uint32;
begin
  if (Reliable) then
    F := LongWord(ENET_PACKET_FLAG_RELIABLE)
  else
    F := 0;

  if (ID >= 0) then
  begin
    if ID > High(NetClients) then Exit;
    if NetClients[ID].Peer = nil then Exit;

    P := enet_packet_create(Addr(NetOut.Data), NetOut.Len, F);
    if not Assigned(P) then Exit;

    enet_peer_send(NetClients[ID].Peer, Chan, P);
  end
  else
  begin
    P := enet_packet_create(Addr(NetOut.Data), NetOut.Len, F);
    if not Assigned(P) then Exit;

    enet_host_widecast(NetHost, Chan, P);
  end;

  g_Net_Flush();
  e_Buffer_Clear(@NetOut);
end;

procedure g_Net_Host_CheckPings();
var
  ClAddr: ENetAddress;
  Buf: ENetBuffer;
  Len, ClTime: Integer;
  Ping: array [0..5] of Byte;
  NPl: Byte;
begin
  if NetPongSock = ENET_SOCKET_NULL then Exit;

  Buf.data := Addr(Ping[0]);
  Buf.dataLength := 6;

  Ping[0] := 0;

  Len := enet_socket_receive(NetPongSock, @ClAddr, @Buf, 1);
  if Len < 0 then Exit;

  if (Ping[0] = Ord('D')) and (Ping[1] = Ord('F')) then
  begin
    ClTime := Integer(Addr(Ping[2])^);

    e_Buffer_Clear(@NetOut);
    e_Buffer_Write(@NetOut, Byte(Ord('D')));
    e_Buffer_Write(@NetOut, Byte(Ord('F')));
    e_Buffer_Write(@NetOut, ClTime);
    g_Net_Slist_WriteInfo();
    NPl := 0;
    if gPlayer1 <> nil then Inc(NPl);
    if gPlayer2 <> nil then Inc(NPl);
    e_Buffer_Write(@NetOut, NPl);
    e_Buffer_Write(@NetOut, gNumBots);

    Buf.data := Addr(NetOut.Data[0]);
    Buf.dataLength := NetOut.WritePos;
    enet_socket_send(NetPongSock, @ClAddr, @Buf, 1);

    e_Buffer_Clear(@NetOut);
  end;
end;

function g_Net_Host_Update(): enet_size_t;
var
  IP: string;
  Port: Word;
  ID: Integer;
  TC: pTNetClient;
  TP: TPlayer;
begin
  IP := '';
  Result := 0;

  if NetUseMaster then
  begin
    g_Net_Slist_Check;
    g_Net_Host_CheckPings;
  end;

  while (enet_host_service(NetHost, @NetEvent, 0) > 0) do
  begin
    case (NetEvent.kind) of
      ENET_EVENT_TYPE_CONNECT:
      begin
        IP := IpToStr(NetEvent.Peer^.address.host);
        Port := NetEvent.Peer^.address.port;
        g_Console_Add(_lc[I_NET_MSG] +
          Format(_lc[I_NET_MSG_HOST_CONN], [IP, Port]));

        if (NetEvent.data <> NET_PROTOCOL_VER) then
        begin
          g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_MSG_HOST_REJECT] +
            _lc[I_NET_DISC_PROTOCOL]);
          NetEvent.peer^.data := GetMemory(SizeOf(Byte));
          Byte(NetEvent.peer^.data^) := 255;
          enet_peer_disconnect(NetEvent.peer, NET_DISC_PROTOCOL);
          enet_host_flush(NetHost);
          Exit;
        end;

        ID := g_Net_FindSlot();

        if ID < 0 then
        begin
          g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_MSG_HOST_REJECT] +
            _lc[I_NET_DISC_FULL]);
          NetEvent.Peer^.data := GetMemory(SizeOf(Byte));
          Byte(NetEvent.peer^.data^) := 255;
          enet_peer_disconnect(NetEvent.peer, NET_DISC_FULL);
          enet_host_flush(NetHost);
          Exit;
        end;

        NetClients[ID].Peer := NetEvent.peer;
        NetClients[ID].Peer^.data := GetMemory(SizeOf(Byte));
        Byte(NetClients[ID].Peer^.data^) := ID;
        NetClients[ID].State := NET_STATE_AUTH;
        NetClients[ID].RCONAuth := False;

        enet_peer_timeout(NetEvent.peer, ENET_PEER_TIMEOUT_LIMIT * 2, ENET_PEER_TIMEOUT_MINIMUM * 2, ENET_PEER_TIMEOUT_MAXIMUM * 2);

        Inc(NetClientCount);
        g_Console_Add(_lc[I_NET_MSG] + Format(_lc[I_NET_MSG_HOST_ADD], [ID]));
      end;

      ENET_EVENT_TYPE_RECEIVE:
      begin
        ID := Byte(NetEvent.peer^.data^);
        if ID > High(NetClients) then Exit;
        TC := @NetClients[ID];

        g_Net_HostMsgHandler(TC, NetEvent.packet);
      end;

      ENET_EVENT_TYPE_DISCONNECT:
      begin
        ID := Byte(NetEvent.peer^.data^);
        if ID > High(NetClients) then Exit;     
        TC := @NetClients[ID];
        if TC = nil then Exit;

        if not (TC^.Used) then Exit;

        TP := g_Player_Get(TC^.Player);

        if TP <> nil then
        begin
          TP.Lives := 0;
          TP.Kill(K_SIMPLEKILL, 0, HIT_DISCON);
          g_Console_Add(Format(_lc[I_PLAYER_LEAVE], [TP.Name]), True);
          e_WriteLog('NET: Client ' + TP.Name + ' [' + IntToStr(ID) + '] disconnected.', MSG_NOTIFY);
          g_Player_Remove(TP.UID);
        end;

        TC^.Used := False;
        TC^.State := NET_STATE_NONE;
        TC^.Peer := nil;
        TC^.Player := 0;
        TC^.RequestedFullUpdate := False;

        FreeMemory(NetEvent.peer^.data);
        NetEvent.peer^.data := nil;
        g_Console_Add(_lc[I_NET_MSG] + Format(_lc[I_NET_MSG_HOST_DISC], [ID]));
        Dec(NetClientCount);

        if NetUseMaster then g_Net_Slist_Update;
      end;
    end;
  end;
end;


{ /// CLIENT FUNCTIONS /// }


procedure g_Net_Disconnect(Forced: Boolean = False);
begin
  if NetMode <> NET_CLIENT then Exit;
  if (NetHost = nil) or (NetPeer = nil) then Exit;

  if not Forced then
  begin
    enet_peer_disconnect(NetPeer, NET_DISC_NONE);

    while (enet_host_service(NetHost, @NetEvent, 1500) > 0) do
    begin
      if (NetEvent.kind = ENET_EVENT_TYPE_DISCONNECT) then
      begin
        NetPeer := nil;
        break;
      end;

      if (NetEvent.kind = ENET_EVENT_TYPE_RECEIVE) then
        enet_packet_destroy(NetEvent.packet);
    end;

    if NetPeer <> nil then
    begin
      enet_peer_reset(NetPeer);
      NetPeer := nil;
    end;
  end
  else
  begin
    e_WriteLog('NET: Kicked from server: ' + IntToStr(NetEvent.data), MSG_NOTIFY);
    if (NetEvent.data <= NET_DISC_MAX) then
      g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_MSG_KICK] +
        _lc[TStrings_Locale(Cardinal(I_NET_DISC_NONE) + NetEvent.data)], True);
  end;

  if NetHost <> nil then
  begin
    enet_host_destroy(NetHost);
    NetHost := nil;
  end;
  g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_MSG_CLIENT_DISC]);

  g_Net_Cleanup;
  e_WriteLog('NET: Disconnected', MSG_NOTIFY);
end;

procedure g_Net_Client_Send(Reliable: Boolean; Chan: Byte = NET_CHAN_GAME);
var
  P: pENetPacket;
  F: enet_uint32;
begin
  if (Reliable) then
    F := LongWord(ENET_PACKET_FLAG_RELIABLE)
  else
    F := 0;

  P := enet_packet_create(Addr(NetOut.Data), NetOut.Len, F);
  if not Assigned(P) then Exit;

  enet_peer_send(NetPeer, Chan, P);
  g_Net_Flush();
  e_Buffer_Clear(@NetOut);
end;

function g_Net_Client_Update(): enet_size_t;
begin
  Result := 0;
  while (enet_host_service(NetHost, @NetEvent, 0) > 0) do
  begin
    case NetEvent.kind of
      ENET_EVENT_TYPE_RECEIVE:
        g_Net_ClientMsgHandler(NetEvent.packet);

      ENET_EVENT_TYPE_DISCONNECT:
      begin
        g_Net_Disconnect(True);
        Result := 1;
        Exit;
      end;
    end;
  end
end;

function g_Net_Client_UpdateWhileLoading(): enet_size_t;
begin
  Result := 0;
  while (enet_host_service(NetHost, @NetEvent, 0) > 0) do
  begin
    case NetEvent.kind of
      ENET_EVENT_TYPE_RECEIVE:
        g_Net_ClientLightMsgHandler(NetEvent.packet);

      ENET_EVENT_TYPE_DISCONNECT:
      begin
        g_Net_Disconnect(True);
        Result := 1;
        Exit;
      end;
    end;
  end;
  g_Net_Flush();
end;

function g_Net_Connect(IP: string; Port: enet_uint16): Boolean;
var
  OuterLoop: Boolean;
begin
  if NetMode <> NET_NONE then
  begin
    g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_ERR_INGAME], True);
    Result := False;
    Exit;
  end;

  Result := True;

  g_Console_Add(_lc[I_NET_MSG] + Format(_lc[I_NET_MSG_CLIENT_CONN],
    [IP, Port]));
  if not NetInitDone then
  begin
    if (not g_Net_Init()) then
    begin
      g_Console_Add(_lc[I_NET_MSG_FERROR] + _lc[I_NET_ERR_ENET], True);
      Result := False;
      Exit;
    end
    else
      NetInitDone := True;
  end;

  NetHost := enet_host_create(nil, 1, NET_CHANS, 0, 0);

  if (NetHost = nil) then
  begin
    g_Console_Add(_lc[I_NET_MSG_ERROR] + _lc[I_NET_ERR_CLIENT], True);
    g_Net_Cleanup;
    Result := False;
    Exit;
  end;

  enet_address_set_host(@NetAddr, PChar(Addr(IP[1])));
  NetAddr.port := Port;

  NetPeer := enet_host_connect(NetHost, @NetAddr, NET_CHANS, NET_PROTOCOL_VER);

  if (NetPeer = nil) then
  begin
    g_Console_Add(_lc[I_NET_MSG_ERROR] + _lc[I_NET_ERR_CLIENT], True);
    enet_host_destroy(NetHost);
    g_Net_Cleanup;
    Result := False;
    Exit;
  end;

  OuterLoop := True;
  while OuterLoop do
  begin
    while (enet_host_service(NetHost, @NetEvent, 0) > 0) do
    begin
      if (NetEvent.kind = ENET_EVENT_TYPE_CONNECT) then
      begin
        g_Console_Add(_lc[I_NET_MSG] + _lc[I_NET_MSG_CLIENT_DONE]);
        NetMode := NET_CLIENT;
        e_Buffer_Clear(@NetOut);
        enet_peer_timeout(NetPeer, ENET_PEER_TIMEOUT_LIMIT * 2, ENET_PEER_TIMEOUT_MINIMUM * 2, ENET_PEER_TIMEOUT_MAXIMUM * 2);
        NetClientIP := IP;
        NetClientPort := Port;
        Exit;
      end;
    end;

    ProcessLoading();
    
    e_PollInput();

    if e_KeyPressed(e_IKey_Escape) or e_KeyPressed(e_IKey_Space) then
      OuterLoop := False;
  end;

  g_Console_Add(_lc[I_NET_MSG_ERROR] + _lc[I_NET_ERR_TIMEOUT], True);
  if NetPeer <> nil then enet_peer_reset(NetPeer);
  if NetHost <> nil then
  begin
    enet_host_destroy(NetHost);
    NetHost := nil;
  end;
  g_Net_Cleanup();
  Result := False;
end;

function IpToStr(IP: LongWord): string;
var
  Ptr: Pointer;
begin
  Result := '';
  Ptr := Addr(IP);

  e_Raw_Seek(0);
  Result := Result + IntToStr(e_Raw_Read_Byte(Ptr)) + '.';
  Result := Result + IntToStr(e_Raw_Read_Byte(Ptr)) + '.';
  Result := Result + IntToStr(e_Raw_Read_Byte(Ptr)) + '.';
  Result := Result + IntToStr(e_Raw_Read_Byte(Ptr));
  e_Raw_Seek(0);
end;

function StrToIp(IPstr: string; var IP: LongWord): Boolean;
var
  EAddr: ENetAddress;
begin
  Result := enet_address_set_host(@EAddr, PChar(@IPstr[1])) = 0;
  IP := EAddr.host;
end;

function g_Net_Client_ByName(Name: string): pTNetClient;
var
  a: Integer;
  pl: TPlayer;
begin
  Result := nil;
  for a := Low(NetClients) to High(NetClients) do
    if (NetClients[a].Used) and (NetClients[a].State = NET_STATE_GAME) then
    begin
      pl := g_Player_Get(NetClients[a].Player);
      if pl = nil then continue;
      if Copy(LowerCase(pl.Name), 1, Length(Name)) <> LowerCase(Name) then continue;
      if NetClients[a].Peer <> nil then
      begin
        Result := @NetClients[a];
        Exit;
      end;
    end;
end;

function g_Net_Client_ByPlayer(PID: Word): pTNetClient;
var
  a: Integer;
begin
  Result := nil;
  for a := Low(NetClients) to High(NetClients) do
    if (NetClients[a].Used) and (NetClients[a].State = NET_STATE_GAME) then
      if NetClients[a].Player = PID then
      begin
        Result := @NetClients[a];
        Exit;
      end;
end;

function g_Net_ClientName_ByID(ID: Integer): string;
var
  a: Integer;
  pl: TPlayer;
begin
  Result := '';
  if ID = NET_EVERYONE then
    Exit;
  for a := Low(NetClients) to High(NetClients) do
    if (NetClients[a].ID = ID) and (NetClients[a].Used) and (NetClients[a].State = NET_STATE_GAME) then
    begin
      pl := g_Player_Get(NetClients[a].Player);
      if pl = nil then Exit;
      Result := pl.Name;
    end;
end;

procedure g_Net_SendData(Data:AByte; peer: pENetPeer; Reliable: Boolean; Chan: Byte = NET_CHAN_DOWNLOAD);
var
  P: pENetPacket;
  F: enet_uint32;
  dataLength: Cardinal;
begin
  dataLength := Length(Data);

  if (Reliable) then
    F := LongWord(ENET_PACKET_FLAG_RELIABLE)
  else
    F := 0;

  if (peer <> nil) then
  begin
    P := enet_packet_create(@Data[0], dataLength, F);
    if not Assigned(P) then Exit;
    enet_peer_send(peer, Chan, P);
  end
  else
  begin
    P := enet_packet_create(@Data[0], dataLength, F);
    if not Assigned(P) then Exit;
    enet_host_widecast(NetHost, Chan, P);
  end;

  enet_host_flush(NetHost);
end;

function g_Net_Wait_Event(msgId: Word): TMemoryStream;
var
  downloadEvent: ENetEvent;
  OuterLoop: Boolean;
  MID: Byte;
  Ptr: Pointer;
  msgStream: TMemoryStream;
begin
  msgStream := nil;
  OuterLoop := True;
  while OuterLoop do
  begin
    while (enet_host_service(NetHost, @downloadEvent, 0) > 0) do
    begin
      if (downloadEvent.kind = ENET_EVENT_TYPE_RECEIVE) then
      begin
        Ptr := downloadEvent.packet^.data;

        MID := Byte(Ptr^);

        if (MID = msgId) then
        begin
          msgStream := TMemoryStream.Create;
          msgStream.SetSize(downloadEvent.packet^.dataLength);
          msgStream.WriteBuffer(Ptr^, downloadEvent.packet^.dataLength);
          msgStream.Seek(0, soFromBeginning);

          OuterLoop := False;
          enet_packet_destroy(downloadEvent.packet);
          break;
        end
        else begin
          enet_packet_destroy(downloadEvent.packet);
        end;
      end
      else
        if (downloadEvent.kind = ENET_EVENT_TYPE_DISCONNECT) then
        begin
          if (downloadEvent.data <= NET_DISC_MAX) then
            g_Console_Add(_lc[I_NET_MSG_ERROR] + _lc[I_NET_ERR_CONN] + ' ' +
            _lc[TStrings_Locale(Cardinal(I_NET_DISC_NONE) + downloadEvent.data)], True);
          OuterLoop := False;
          Break;
        end;
    end;

    ProcessLoading();

    e_PollInput();

    if e_KeyPressed(e_IKey_Escape) or e_KeyPressed(e_IKey_Space) then
      break;
  end;
  Result := msgStream;
end;

function g_Net_IsHostBanned(IP: LongWord; Perm: Boolean = False): Boolean;
var
  I: Integer;
begin
  Result := False;
  if NetBannedHosts = nil then
    Exit;
  for I := 0 to High(NetBannedHosts) do
    if (NetBannedHosts[I].IP = IP) and ((not Perm) or (NetBannedHosts[I].Perm)) then
    begin
      Result := True;
      break;
    end;
end;

procedure g_Net_BanHost(IP: LongWord; Perm: Boolean = True); overload;
var
  I, P: Integer;
begin
  if IP = 0 then
    Exit;
  if g_Net_IsHostBanned(IP, Perm) then
    Exit;

  P := -1;
  for I := Low(NetBannedHosts) to High(NetBannedHosts) do
    if NetBannedHosts[I].IP = 0 then
    begin
      P := I;
      break;
    end;

  if P < 0 then
  begin
    SetLength(NetBannedHosts, Length(NetBannedHosts) + 1);
    P := High(NetBannedHosts);
  end;

  NetBannedHosts[P].IP := IP;
  NetBannedHosts[P].Perm := Perm;
end;

procedure g_Net_BanHost(IP: string; Perm: Boolean = True); overload;
var
  a: LongWord;
  b: Boolean;
begin
  b := StrToIp(IP, a);
  if b then
    g_Net_BanHost(a, Perm);
end;

procedure g_Net_UnbanNonPermHosts();
var
  I: Integer;
begin
  if NetBannedHosts = nil then
    Exit;
  for I := Low(NetBannedHosts) to High(NetBannedHosts) do
    if (NetBannedHosts[I].IP > 0) and not NetBannedHosts[I].Perm then
    begin
      NetBannedHosts[I].IP := 0;
      NetBannedHosts[I].Perm := True;
    end;
end;

function g_Net_UnbanHost(IP: string): Boolean; overload;
var
  a: LongWord;
begin
  Result := StrToIp(IP, a);
  if Result then
    Result := g_Net_UnbanHost(a);
end;

function g_Net_UnbanHost(IP: LongWord): Boolean; overload;
var
  I: Integer;
begin
  Result := False;
  if IP = 0 then
    Exit;
  if NetBannedHosts = nil then
    Exit;
  for I := 0 to High(NetBannedHosts) do
    if NetBannedHosts[I].IP = IP then
    begin
      NetBannedHosts[I].IP := 0;
      NetBannedHosts[I].Perm := True;
      Result := True;
      // no break here to clear all bans of this host, perm and non-perm
    end;
end;

procedure g_Net_SaveBanList();
var
  F: TextFile;
  I: Integer;
begin
  Assign(F, DataDir + BANLIST_FILENAME);
  Rewrite(F);
  if NetBannedHosts <> nil then
    for I := 0 to High(NetBannedHosts) do
      if NetBannedHosts[I].Perm and (NetBannedHosts[I].IP > 0) then
        Writeln(F, IpToStr(NetBannedHosts[I].IP));
  CloseFile(F);
end;

end.
