unit UIServerRest;

interface

uses UIGetObject;

type
  IRestServer = interface(IGetObject)
  ['{E14DC9FF-958D-408F-972B-FE30255F4150}']
    function Post(json: String): String;
    procedure Put(json: String);
    procedure Delete(json: string);
    function Get(json: string): string;
  end;

implementation

end.
