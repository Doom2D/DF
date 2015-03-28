unit g_res_downloader;

interface

uses sysutils, Classes, md5asm;

type GResource = (
  RES_MAP,
  RES_WAD,
  RES_MODEL
);

function ResourceExist(const path, filename: string; resMd5:TMD5Digest; resType:GResource):string;
function saveResource(const path, filename: string; resStream: TMemoryStream; resType:GResource):string;

implementation

const DOWNLOAD_DIR = 'downloads';

procedure findFiles(const dirName, filename:string; var files:TStringList);
var
  searchResult: TSearchRec;
begin
  if FindFirst(dirName+'\*', faAnyFile, searchResult)=0 then begin
    try
      repeat
        if (searchResult.Attr and faDirectory)=0 then begin
          if searchResult.Name = filename then begin
            files.Add(dirName+'\'+filename);
            Exit;
          end;
        end else if (searchResult.Name<>'.') and (searchResult.Name<>'..') then begin
          findFiles(IncludeTrailingBackSlash(dirName)+searchResult.Name, filename, files);
        end;
      until (FindNext(searchResult)<>0);
    finally
      FindClose(searchResult);
    end;
  end;
end;

function compareFile(const filename: string; resMd5:TMD5Digest):Boolean;
var
  gResHash: TMD5Digest;
begin
  gResHash := MD5File(filename);
  Result := MD5Compare(gResHash, resMd5);
end;

function ResourceExist(const path, filename: string; resMd5:TMD5Digest; resType:GResource):string;
var
  res: string;
  files: TStringList;
  i: Integer;
begin
  Result := '';

  if FileExists(path + filename) and compareFile(path + filename, resMd5) then
  begin
    Result := path + filename;
    Exit;
  end;

  files := TStringList.Create;

  findFiles(path, filename, files);
  for i:=0 to files.Count-1 do
  begin
    res := files.Strings[i];
    if compareFile(res, resMd5) then
    begin
      Result := res;
      Break;
    end;
  end;

  files.Free;
end;

function saveResource(const path, filename: string; resStream: TMemoryStream; resType:GResource):string;
var
  resFile: TFileStream;
begin
  try
    Result := path + DOWNLOAD_DIR + '\' + filename;
    if not DirectoryExists(path + DOWNLOAD_DIR) then
    begin
      CreateDir(path + DOWNLOAD_DIR);
    end;
    resStream.SaveToFile(Result);
  except
    Result := '';
  end;
end;

end.
