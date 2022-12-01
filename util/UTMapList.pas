unit UTMapList;

interface

uses
  Variants;

type
  TKey = type Variant;
  TValue = type Variant;

  TKeySet = array of TKey;
  TValueSet = array of TValue;

  TEntry = record
    Key: TKey;
    Value: TValue;
  end;

  TMap = class
    private
      MapArrayList: array of TEntry;

      function NewEntry(): integer;
      function IndexOf(key: TKey): Integer;
      
    public
      constructor Create(); 
      destructor Destroy(); override;

      procedure Clear();
      function ContainsKey(key: TKey): Boolean;
      function ContainsValue(Value: TValue): Boolean;
      function Get(Key: TKey): TEntry;overload;
      function Get(Index: Integer): TEntry;overload;
      function GetToString(Key: TKey): String;overload;
      function GetToString(Index: Integer): String;overload;
      function IsEmpty(): Boolean;
      function KeySet(): TKeySet;
      function Put(Key: TKey; Value: TValue): TValue;
      procedure PutAll(Other: TMap);
      function Remove(Key: TKey): TValue;
      function Size(): Integer;
      function Values(): TValueSet;
end;

implementation

{ TMap }

constructor TMap.Create;
begin
  SetLength(MapArrayList, 0);
end;

procedure TMap.Clear;
begin
  SetLength(MapArrayList, 0);
end;

function TMap.ContainsKey(key: TKey): Boolean;
begin
  Result := Get(key).Value <> null;
end;

function TMap.ContainsValue(Value: TValue): Boolean;
var
  i: Integer;
  key: TKey;
begin
  Result := False;
  for i := 0 to Size() - 1 do
  begin
    key := KeySet()[i];
    Result := (Get(key).Value = Value);
    if Result then
      break;
  end;
end;

function TMap.Get(Key: TKey): TEntry;
begin
  Result := MapArrayList[IndexOf(Key)];
end;

function TMap.IsEmpty: Boolean;
begin
  Result := Size() = 0;
end;

function TMap.KeySet: TKeySet;
var i: Integer;
begin
  for i := 0 to Size() -1 do
  begin
    SetLength(Result, i + 1);
    Result[i] := MapArrayList[i].Key;
  end;
end;

function TMap.Put(Key: TKey; Value: TValue): TValue;
var
  entry: TEntry;
begin
  entry.Key := Key;
  entry.Value := Value;

  MapArrayList[NewEntry()] := Entry;
  Result := Entry.Value;
end;

procedure TMap.PutAll(Other: TMap);
var
  i: Integer;
  key: TKey;
begin
  for i := 0 to Other.Size() - 1 do
  begin
    key := Other.KeySet()[i];
    MapArrayList[NewEntry()] := Other.Get(key);
  end;
end;

function TMap.Remove(Key: TKey): TValue;
var index: Integer;
begin
  index := IndexOf(Key);
  //Result := MapArrayList[index].Value;
  Finalize(MapArrayList[index]);
  System.Move(MapArrayList[index + 1], MapArrayList[index],
    (Length(MapArrayList) - index - 1) * SizeOf(TEntry) + 1);
  SetLength(MapArrayList, Size() - 1);  
end;

function TMap.Size: Integer;
begin
  Result := Length(MapArrayList);
end;

function TMap.Values: TValueSet;
var i: Integer;
begin
  for i := 0 to Size() -1 do
  begin
    SetLength(Result, i + 1);
    Result[i] := MapArrayList[i].Value;
  end;
end;

function TMap.NewEntry: Integer;
begin
  SetLength(MapArrayList, Size() + 1);
  Result := Size() - 1;
end;

function TMap.IndexOf(key: TKey): Integer;
begin
  for Result := 0 to Size() - 1 do
  begin
    try
      if (Key = MapArrayList[Result].Key) then
        Exit;
    except
    end;
  end;
  Result := -1;
end;

destructor TMap.Destroy;
begin
  Clear();
  inherited;
end;

function TMap.Get(Index: Integer): TEntry;
begin
  Result := MapArrayList[Index];  
end;

function TMap.GetToString(Key: TKey): String;
var
  Entry: TEntry;
begin
  Entry := Self.Get(Key);
  Result := VarToStr(Entry.Key)+':'+VarToStr(Entry.Value)+';';
end;

function TMap.GetToString(Index: Integer): String;
var
  Entry: TEntry;
begin
  Entry := Self.Get(Index);
  Result := VarToStr(Entry.Key)+':'+VarToStr(Entry.Value)+';';
end;

end.
