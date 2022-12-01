unit UTCategoriaJSonController;

interface

uses
  SysUtils, UTObjectPersistent, UTGetMethod, UERestServerException,
  UTHttpCodeStatus, UTRestMethodBase, UTCategoriaListJSonAdapter, UICategoria;

type
  TCategoriaJSonController = class(TObjectPersistent)
    private
    public
      function Get(): ICategoriaList;
  end;

implementation

uses
  UTResource, UTResponseJSonAdapter;

const
  RES_CATEGORIA = '/tipo';

{ TCategoriaJSonController }

function TCategoriaJSonController.Get: ICategoriaList;
var
  get: TGetMethod;
  json: string;
  res: TCategoriaListJSonAdapter;
begin
  res := nil;
  try        
    get := TGetMethod.Create(HTTP, PATH_SERVER, PORT_DEFAULT,
      RES_RASTHER + RES_CATEGORIA);
    get.Execute();
    json := get.GetRespose().GetMessage;
    res := TCategoriaListJSonAdapter.Create();
    res.AssignJSon(json);
  finally
    Result := res;
  end;
end;


end.
