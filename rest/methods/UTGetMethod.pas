unit UTGetMethod;

interface

uses
  UIRestMethod, UTRestMethodBase, Classes, IdHTTP, UERestServerException,
  UTHttpCodeStatus, UTResponseJSonAdapter;

type
  TGetMethod = class(TRestMethodBase)
    public
      procedure Execute(); override;      
  end;

implementation

{ TPostMethod }

procedure TGetMethod.Execute;
begin
  try
    responseJSon := TResponseJSonAdapter.Create();
    responseJSon.SetMessage(idHttp.Get(GetRequest()));
    responseJSon.SetStatusCode(GetCodeStatus());
    responseJSon.SetLocation(idHttp.Response.Location);
  except
    on e:EIdHTTPProtocolException do
    begin
      CreateHttpConnection();
      raise ERestServerException.Create(THttpCodeStatus(e.ErrorCode), e.ErrorMessage);
    end;
  end;
end;

end.
