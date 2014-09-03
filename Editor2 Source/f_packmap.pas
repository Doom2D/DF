unit f_packmap;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes,
  Graphics, Controls, Forms, Dialogs, StdCtrls, ExtCtrls;

type
  TPackMapForm = class (TForm)
    bPack: TButton;
    SaveDialog: TSaveDialog;
    Panel1: TPanel;
  // ��������� �:
    LabelSaveTo: TLabel;
    eWAD: TEdit;
    bSelectWAD: TButton;
  // ��� �����:
    LabelMapName: TLabel;
    eResource: TEdit;
  // ��������:
    cbTextrures: TCheckBox;
    LabelTextures: TLabel;
    eTSection: TEdit;
  // ����:
    cbSky: TCheckBox;
    LabelSky: TLabel;
    eSSection: TEdit;
  // ������:
    cbMusic: TCheckBox;
    LabelMusic: TLabel;
    eMSection: TEdit;
  // �������������:
    cbAdd: TCheckBox;
    cbNonStandart: TCheckBox;
    
    procedure bSelectWADClick(Sender: TObject);
    procedure bPackClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  PackMapForm: TPackMapForm;

implementation

uses
  WADEDITOR, g_map, MAPREADER, MAPWRITER, MAPSTRUCT,
  f_main, math, g_language;

{$R *.dfm}

const
  STANDART_WAD = 'standart.wad';
  SHRSHADE_WAD = 'shrshade.wad';


procedure TPackMapForm.bSelectWADClick(Sender: TObject);
begin
  SaveDialog.Filter := _lc[I_FILE_FILTER_WAD];

  if SaveDialog.Execute() then
    eWAD.Text := SaveDialog.FileName;
end;

function ProcessResource(wad_to: TWADEditor_1;
           section_to, filename, section, resource: String): Boolean;
var
  wad2: TWADEditor_1;
  data: Pointer;
  reslen: Integer;
  //s: string;

begin
  Result := False;
 
  if filename = '' then
    g_ProcessResourceStr(OpenedMap, @filename, nil, nil)
  else
    filename := EditorDir+'wads\'+filename;

// ������ ������ �� WAD-����� ����� ��� ������-�� �������:
  wad2 := TWADEditor_1.Create();

  if not wad2.ReadFile(filename) then
  begin
    MessageBox(0, PChar(Format(_lc[I_MSG_WAD_ERROR],
                                   [ExtractFileName(filename)])),
               PChar(_lc[I_MSG_ERROR]), MB_OK + MB_ICONERROR);
    wad2.Free();
    Exit;
  end;

  if not wad2.GetResource(section, resource, data, reslen) then
  begin
    MessageBox(0, PChar(Format(_lc[I_MSG_RES_ERROR],
                                   [filename, section, resource])),
               PChar(_lc[I_MSG_ERROR]), MB_OK + MB_ICONERROR);
    wad2.Free();
    Exit;
  end;

  wad2.Free();

 {if wad_to.HaveResource(section_to, resource) then
 begin
  for a := 2 to 256 do
  begin
   s := IntToStr(a);
   if not wad_to.HaveResource(section_to, resource+s) then Break;
  end;
  resource := resource+s;
 end;}

// ���� ������ ������� ��� � WAD-�����-����������, �� ��������:
  if not wad_to.HaveResource(section_to, resource) then
  begin
    if not wad_to.HaveSection(section_to) then
      wad_to.AddSection(section_to);
    wad_to.AddResource(data, reslen, resource, section_to);
  end;

  FreeMem(data);

  Result := True;
end;

procedure TPackMapForm.bPackClick(Sender: TObject);
var
  WAD: TWADEditor_1;
  mr: TMapReader_1;
  mw: TMapWriter_1;
  data: Pointer;
  len: LongWord;
  textures: TTexturesRec1Array;
  header: TMapHeaderRec_1;
  a, b: Integer;
  r: Byte;
  ok: Boolean;
  res, tsection, ssection, msection, filename, section, resource: String;

begin
  if eWAD.Text = '' then
    Exit;
  if eResource.Text = '' then
    Exit;

  tsection := eTSection.Text;
  ssection := eSSection.Text;
  msection := eMSection.Text;

// ��������� ����� � ������:
  data := SaveMap('');
  if data = nil then
    Exit;

  WAD := TWADEditor_1.Create();

// �� �������������� WAD, � ���������:
  if cbAdd.Checked then
    if WAD.ReadFile(eWAD.Text) then
      WAD.CreateImage();

// ������ ����� �� ������:
  mr := TMapReader_1.Create();
  mr.LoadMap(data);
  FreeMem(data);

// �������� ��������:
  textures := mr.GetTextures();

// ����� ���������� ��������:
  if cbTextrures.Checked and (textures <> nil) then
    for a := 0 to High(textures) do
    begin
      res := textures[a].Resource;
      if IsSpecialTexture(res) then
        Continue;

      g_ProcessResourceStr(res, @filename, @section, @resource);

    // �� ���������� ����������� ��������:
      if (not cbNonStandart.Checked) or
         ( (AnsiLowerCase(filename) <> STANDART_WAD) and
           (AnsiLowerCase(filename) <> SHRSHADE_WAD) ) then
      begin
      // �������� ������ ��������:
        if not ProcessResource(WAD, tsection, filename, section, resource) then
        begin
          mr.Free();
          WAD.Free();
          Exit;
        end;

      // ��������������� ������ ��������:
        res := Format(':%s\%s', [tsection, resource]);
        ZeroMemory(@textures[a].Resource[0], 64);
        CopyMemory(@textures[a].Resource[0], @res[1], Min(Length(res), 64));
      end;
    end;

// �������� ��������� �����:
  header := mr.GetMapHeader();

// ����� ���������� ����:
  if cbSky.Checked then
  begin
    res := header.SkyName;
    g_ProcessResourceStr(res, @filename, @section, @resource);

  // �� ���������� ����������� ����:
    if (not cbNonStandart.Checked) or
       ( (AnsiLowerCase(filename) <> STANDART_WAD) and
         (AnsiLowerCase(filename) <> SHRSHADE_WAD) ) then
    begin
    // �������� ������ ����:
      if not ProcessResource(WAD, ssection, filename, section, resource) then
      begin
        mr.Free();
        WAD.Free();
        Exit;
      end;

    // ��������������� ������ ����:
      res := Format(':%s\%s', [ssection, resource]);
      ZeroMemory(@header.SkyName[0], 64);
      CopyMemory(@header.SkyName[0], @res[1], Min(Length(res), 64));
    end;
  end;

// ����� ���������� ������:
  if cbMusic.Checked then
  begin
    res := header.MusicName;
    g_ProcessResourceStr(res, @filename, @section, @resource);

  // �� ���������� ����������� ������:
    if (not cbNonStandart.Checked) or
       ( (AnsiLowerCase(filename) <> STANDART_WAD) and
         (AnsiLowerCase(filename) <> SHRSHADE_WAD) ) then
    begin
    // �������� ������ ������:
      if not ProcessResource(WAD, msection, filename, section, resource) then
      begin
        mr.Free();
        WAD.Free();
        Exit;
      end;

    // ��������������� ������ ������:
      res := Format(':%s\%s', [msection, resource]);
      ZeroMemory(@header.MusicName[0], 64);
      CopyMemory(@header.MusicName[0], @res[1], Min(Length(res), 64));
    end;
  end;

  {
// ����� ���������� �������������� ��������:
  if cbTextrures.Checked and (textures <> nil) and
     (gPanels <> nil) and (gTriggers <> nil) then
  begin
    for a := 0 to High(gPanels) do
    begin
      ok := False;

    // ��������� �� �� ��� ������ ��������:
      for b := 0 to High(gTriggers) do
        if ( (gTriggers[b].TriggerType in [TRIGGER_OPENDOOR,
                TRIGGER_CLOSEDOOR, TRIGGER_DOOR, TRIGGER_DOOR5,
                TRIGGER_CLOSETRAP, TRIGGER_TRAP, TRIGGER_LIFTUP,
                TRIGGER_LIFTDOWN, TRIGGER_LIFT]) and
             (gTriggers[b].Data.PanelID = a) ) or
           (gTriggers[b].TexturePanel = a) then
        begin
          ok := True;
          Break;
        end;

    // ���� �������� �� ��� ������:
      if ok and (gPanels[a].TextureName <> '') and
         (not IsSpecialTexture(gPanels[a].TextureName) and
         g_Texture_NumNameFindStart(gPanels[a].TextureName) then
      begin
        while True do
        begin
          r := g_Texture_NumNameFindNext(res);
          case r of
            NNF_NAME_FOUND: ;
            NNF_NAME_EQUALS: Continue;
            else Break;
          end;

          if res = '' then
            Break;

          g_ProcessResourceStr(res, @filename, @section, @resource);

        // �� ���������� ����������� �������������� ��������:
          if (not cbNonStandart.Checked) or
             ( (AnsiLowerCase(filename) <> STANDART_WAD) and
               (AnsiLowerCase(filename) <> SHRSHADE_WAD) ) then
          begin
          // �������� ������ �������������� ��������:
            if ProcessResource(WAD, tsection, filename, section, resource) then
            begin

              ����� ��������� ���� ����� �������� textures � ���� �� ��� ������?
            // ��������������� ������ ��������:
              res := Format(':%s\%s', [tsection, resource]);
              ZeroMemory(@textures[a].Resource[0], 64);
              CopyMemory(@textures[a].Resource[0], @res[1], Min(Length(res), 64));



            end;
          end;
        end; // while True
      end;
    end;
  end;
  }

// ���������� ��������� �����:
  mw := TMapWriter_1.Create();

  mw.AddHeader(header);
  mw.AddTextures(textures);
  mw.AddPanels(mr.GetPanels());
  mw.AddItems(mr.GetItems());
  mw.AddAreas(mr.GetAreas());
  mw.AddMonsters(mr.GetMonsters());
  mw.AddTriggers(mr.GetTriggers());

// ��������� ����� �� ������ ��� ����� ������ � WAD-����:
  len := mw.SaveMap(data);
  WAD.AddResource(data, len, eResource.Text, '');
  WAD.SaveTo(eWAD.Text);

  mw.Free();
  mr.Free();
  WAD.Free();

  MessageDlg(Format(_lc[I_MSG_PACKED],
                    [eResource.Text, ExtractFileName(eWAD.Text)]),
             mtInformation, [mbOK], 0);

  Close();
end;

procedure TPackMapForm.FormCreate(Sender: TObject);
begin
  SaveDialog.InitialDir := EditorDir;
end;

end.
