unit UTMontadoraJSonController;

interface

uses
  StrUtils, UTObjectPersistent, UTGetMethod, UTRestMethodBase,
  UTDefaultJSonAdapter, UTDefaultJSonController, UIDados, UTMapList;

type
  TMontadoraJSonController = class(TDefaultJSonController)
    private
    public
      function Get(): IDadosList;overload;
      function Get(Categoria: String): IDadosList;overload;
  end;

implementation

uses
  UTResource, UTResponseJSonAdapter;

const
  RES_MONTADORA = '/montadora?pm.platform=1&pm.version=23';

{ TMontadoraJSonController }

function TMontadoraJSonController.Get: IDadosList;
begin
  Result := inherited Get(RES_MONTADORA);
end;

function TMontadoraJSonController.Get(Categoria: String): IDadosList;
var
  parameters: TMap;
begin
  parameters := TMap.Create;
  if (Categoria <> '') then
    parameters.Put('&pm.type', Categoria);
  Result := Self.Get(RES_MONTADORA, parameters);
end;


end.
