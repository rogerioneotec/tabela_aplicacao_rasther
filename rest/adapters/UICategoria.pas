unit UICategoria;

interface

uses
  UIJSonAdapter;

type
  ICategoriaList = interface(IJSonAdapter)
    ['{45815330-B3BB-4FE7-AD90-7A8E93FC25EA}']
    function Count():Integer;
    function GetItem(Index: Integer):String;
  end;

implementation

end.
