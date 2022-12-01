unit UTBaseJSonAdapter;

interface

uses
  UTObjectPersistent, uLkJSON, Classes, SysUtils, UIJSonAdapter;

type
  TBaseJSonListAdapter = class(TObjectPersistent, IJSonAdapter)
    protected
      jsonBase: TlkJSONlist;
    public
      constructor Create();
      destructor Destroy(); override;
      procedure Assign(Source: TObject);reintroduce;
      function AssignJSon(json: String): TBaseJSonListAdapter; virtual;
      function ToJSON(): String; virtual;

      function Count():Integer;
      function GetItem(Index: Integer):TlkJSONbase;
  end;
  TBaseJSonAdapter = class(TObjectPersistent, IJSonAdapter)
    protected
      jsonBase: TlkJSONobject;
      function isExist(parameter: String):Boolean;
    public
      constructor Create();
      destructor Destroy(); override;
      procedure Assign(Source: TObject);reintroduce;
      function AssignJSon(json: String): TBaseJSonAdapter; virtual;
      function ToJSON(): String; virtual;
  end;

implementation

{ TBaseJSonAdapter }

constructor TBaseJSonAdapter.Create;
begin
  jsonBase := TlkJSONobject.Create();
end;

destructor TBaseJSonAdapter.Destroy;
begin
  inherited;
end;

function TBaseJSonAdapter.AssignJSon(json: String): TBaseJSonAdapter;
begin
  if json <> '' then
    jsonBase := TlkJSON.ParseText(json) as TlkJSONobject;

  Result := Self;
end;

function TBaseJSonAdapter.ToJSON: String;
begin
  Result := TlkJSON.GenerateText(jsonBase);
end;

procedure TBaseJSonAdapter.Assign(Source: TObject);
begin
  if Source is TBaseJSonAdapter then
    inherited Assign(TPersistent(Source))
  else
    if Source is TlkJSONobject then
      Self.jsonBase := source as TlkJSONobject;
end;

function TBaseJSonAdapter.isExist(parameter: String): Boolean;
begin
  Result := (Assigned(jsonBase) and
            (jsonBase.Count > 0) and
            (jsonBase.IndexOfName(parameter) > -1));
end;

{ TBaseJSonListAdapter }

procedure TBaseJSonListAdapter.Assign(Source: TObject);
begin
  if Source is TBaseJSonAdapter then
    inherited Assign(TPersistent(Source))
  else
    if Source is TlkJSONlist then
      Self.jsonBase := source as TlkJSONlist;
end;

function TBaseJSonListAdapter.AssignJSon(
  json: String): TBaseJSonListAdapter;
begin
  if json <> '' then
    jsonBase := TlkJSON.ParseText(json) as TlkJSONlist;

  Result := Self;
end;

function TBaseJSonListAdapter.Count: Integer;
begin
  Result := Self.jsonBase.Count;
end;

constructor TBaseJSonListAdapter.Create;
begin
  jsonBase := TlkJSONlist.Create();
end;

destructor TBaseJSonListAdapter.Destroy;
begin
  inherited;
end;

function TBaseJSonListAdapter.GetItem(Index: Integer): TlkJSONbase;
begin
  if (Index < Self.Count) then
    Result := Self.jsonBase.Child[index]
  else
    Result := nil;
end;

function TBaseJSonListAdapter.ToJSON: String;
begin
  Result := TlkJSON.GenerateText(jsonBase);
end;

end.
