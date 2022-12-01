unit UIRestMethod;

interface

uses UIGetObject, UTResponseJSonAdapter;

type
  IRestMethod = interface(IGetObject)
  ['{79E9D3DA-DB4F-4ED1-B544-CC95CACAB6A5}']
    function GetRequest(): String;
    function GetRespose(): TResponseJSonAdapter;
    function AddResource(resource: String): IRestMethod;
    function GetBodyParams(): String;
    function AddBodyParam(param: String): IRestMethod;
    procedure Execute();
  end;

implementation

end.
