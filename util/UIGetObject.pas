unit UIGetObject;

interface

type
  IGetObject = interface(IUnknown)
  ['{6168F14A-834D-4855-8099-C394A9E9C79E}']
    function GetSelf(): TObject;
  end;

implementation

end.
 