unit UTCategoriaListJSonAdapter;

interface

uses
  uLkJSON, Classes, SysUtils, UTBaseJSonAdapter, UICategoria;

type
  TCategoriaListJSonAdapter = class(TBaseJSonListAdapter, ICategoriaList)
    function GetItem(Index: Integer):String;
  end;

implementation

{*------------------------------------------------------------------------------
  ["LEVES","PESADOS","AGRICOLAS","MOTOS"]
-------------------------------------------------------------------------------}

{ TCategoriaListJSonAdapter }

function TCategoriaListJSonAdapter.GetItem(
  Index: Integer): String;
begin
  Result := inherited GetItem(index).Value;
end;

end.
