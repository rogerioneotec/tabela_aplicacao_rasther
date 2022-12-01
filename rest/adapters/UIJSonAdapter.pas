unit UIJSonAdapter;

interface

uses
  SysUtils;

type
  IJSonAdapter = interface(IUnknown)
    ['{2D8F1CF5-9B68-4742-A206-0243A84DCDA0}']
    function ToJSON(): String;
  end;

implementation

end.
 