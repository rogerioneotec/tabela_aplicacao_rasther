unit UTDefaultJSonAdapter;

interface

uses
  uLkJSON, UTBaseJSonAdapter, UIDados;

type
  TDefaultJSonAdapter = class(TBaseJSonAdapter, IDados)
  public
   function GetId(): Integer;
   function GetNome(): String;
  end;
  TDefaultListJSonAdapter = class(TBaseJSonListAdapter, IDadosList)
    function GetItem(index: Integer):IDados;
  end;

implementation

{ TDefaultJSonAdapter }

function TDefaultJSonAdapter.GetId(): Integer;
begin
  if Self.isExist('id') then
    Result := jsonBase.getInt('id')
  else
    Result := 0;
end;

function TDefaultJSonAdapter.GetNome(): String;
begin
  if (Self.isExist('nome')) then
    Result := jsonBase.getString('nome')
  else Result := '';
end;

{ TDefaultListJSonAdapter }

function TDefaultListJSonAdapter.GetItem(index: Integer):IDados;
var
  resAdapter: TDefaultJSonAdapter;
begin
  resAdapter := TDefaultJSonAdapter.Create;
  resAdapter.Assign(inherited GetItem(index));
  Result := resAdapter;
end;


end.
