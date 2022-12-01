unit UTDefaultJSonController;

interface

uses
  SysUtils, StrUtils, Variants, UTObjectPersistent, UTGetMethod,
  UTRestMethodBase, UTDefaultJSonAdapter, UTMapList, UIDados;

type
  TDefaultJSonController = class(TObjectPersistent)
    private
    public
      function Get(resource: String): IDadosList;overload;
      function Get(resource: String; parameters: TMap): IDadosList;overload;

      function isValidParameter(value: IDados):Boolean;
  end;

implementation

uses
  UTResource, UTResponseJSonAdapter;

{ TDefaultJSonController }

function TDefaultJSonController.Get(resource: String): IDadosList;
begin
  Result := Self.Get(resource, nil);
end;

function TDefaultJSonController.Get(resource: String; parameters: TMap): IDadosList;
var
  get: TGetMethod;
  json, endpoint: string;
  res: TDefaultListJSonAdapter;
  i: Integer;
  value: TEntry;
begin
  res := nil;
  try
    endpoint := resource;
    if (Assigned(parameters)) and (not parameters.IsEmpty) then
    begin
      for i:=0 to parameters.Size-1 do
      begin
        value := parameters.Get(i);
        endpoint := endpoint + VarToStr(value.Key) + '=' + VarToStr(value.Value);
      end;
    end;
    get := TGetMethod.Create(HTTP, PATH_SERVER, PORT_DEFAULT,
      RES_RASTHER + endpoint);
    get.Execute();
    json := get.GetRespose().GetMessage;
    res := TDefaultListJSonAdapter.Create();
    res.AssignJSon(json);
  finally
    Result := res;
  end;
end;

function TDefaultJSonController.isValidParameter(value: IDados):Boolean;
begin
  Result := (Assigned(value) AND (value.GetId > 0));
end;

end.
