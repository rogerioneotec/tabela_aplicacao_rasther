unit UIDados;

interface

uses
  Classes, SysUtils, UIJSonAdapter;

type
  IDados = interface(IJSonAdapter)
    ['{DF512FA4-848A-4643-8FBF-480D0D9F0CE5}']
    function GetId(): Integer;
    function GetNome(): String;
  end;
  PIDados = ^IDados;

  IDadosList = interface(IJSonAdapter)
    ['{D02D6294-2692-4B3D-8076-7EB0CA68CF41}']
    function Count():Integer;
    function GetItem(index: Integer):IDados;
  end;


implementation

end.
 