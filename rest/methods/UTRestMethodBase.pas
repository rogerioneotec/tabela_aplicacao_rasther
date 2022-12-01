unit UTRestMethodBase;

interface

uses
  Classes, SysUtils, UTObjectPersistent, IdHTTP, UIRestMethod, UTHttpCodeStatus,
  UTResponseJSonAdapter, IdSSLOpenSSL;

type
  THttpProtocol = (HTTP, HTTPS);

  {*----------------------------------------------------------------------------
    Alteração necessária do componente para não ter que alterar o código no
    componente Indy na Unit IdHTTP
  -----------------------------------------------------------------------------}
  TIdHttp = class(idHTTP.TidHTTP)
  public
     procedure Delete(AURL: String);
  end;
  {*---------------------------------------------------------------------------}  

  TRestMethodBase = class(TObjectPersistent, IRestMethod)
    private
      resource: string;
      protocol: THttpProtocol;
      port: integer;
      path: String;
    protected
      idHttp: TIdHTTP;
      responseJSon: TResponseJSonAdapter;
      bodyParam: TStringList;
      function GetProtocol(): String;
      procedure CreateHttpConnection();
    public
      constructor Create(protocol: THttpProtocol; path: String; port: Integer; resource: String);
      destructor Destroy(); override;

      function GetRequest(): String;
      function GetCodeStatus(): THttpCodeStatus;
      function GetRespose(): TResponseJSonAdapter;
      function AddResource(resource: String): IRestMethod;
      function GetBodyParams(): String;
      function AddBodyParam(param: String): IRestMethod;

      procedure Execute(); virtual; abstract;
  end;


implementation

{ TRestServerBase }

constructor TRestMethodBase.Create(protocol: THttpProtocol; path: String; port: Integer; resource: String);
begin
  Self.protocol := protocol;
  Self.path := path;
  Self.port := port;
  Self.resource := resource;
  bodyParam := TStringList.Create;
  CreateHttpConnection();
end;

destructor TRestMethodBase.Destroy;
begin
  FreeAndNil(idHttp);
  inherited;
end;

function TRestMethodBase.AddResource(resource: String): IRestMethod;
begin
  Self.resource := Self.resource + '/' + resource;
  Result := Self;
end;

function TRestMethodBase.AddBodyParam(param: String): IRestMethod;
begin
  bodyParam.Add(param);
  Result := Self;
end;

function TRestMethodBase.GetProtocol: String;
begin
  Result := 'http://';
  case protocol of
    HTTP: Result := 'http://';
    HTTPS: Result := 'https://';
  end;
end;

function TRestMethodBase.GetBodyParams: String;
begin
  Result := bodyParam.Text;
end;

function TRestMethodBase.GetRequest: String;
var port: String;
begin
  port := '';
  if Self.port > 0 then
    port := ':'+IntToStr(Self.port);

  Result := GetProtocol() + path + port + resource;
end;

function TRestMethodBase.GetRespose: TResponseJSonAdapter;
begin
  Result := responseJSon;
end;

function TRestMethodBase.GetCodeStatus: THttpCodeStatus;
begin
  Result := THttpCodeStatus(idHttp.ResponseCode);
end;

{ TIdHttp }

procedure TIdHttp.Delete(AURL: String);
begin
  DoRequest(hmDelete, AURL,nil, nil, []);
end;

procedure TRestMethodBase.CreateHttpConnection;
begin
  if Assigned(idHttp) then
    FreeAndNil(idHttp);
  idHttp := TIdHTTP.Create(nil);
  IdHTTP.Request.ContentType := 'application/json';
  IdHTTP.Request.Accept := 'application/json';
  idHttp.ProtocolVersion := pv1_1;
  if Self.protocol = HTTPS then
  begin
    idHttp.IOHandler := TIdSSLIOHandlerSocketOpenSSL.Create(idHttp);
    idHttp.HandleRedirects := True;
  end;
end;

end.
