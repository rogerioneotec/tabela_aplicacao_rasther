unit UTResponseJSonAdapter;

interface

uses
  uLkJSON, Classes, SysUtils, UTBaseJSonAdapter, UTHttpCodeStatus;

type
  TResponseJSonAdapter = class(TBaseJSonAdapter)
    private
    public
      procedure SetMessage(value: String);
      procedure SetStatusCode(code: THttpCodeStatus);
      procedure SetLocation(location: String);

      function GetStatusCode(): THttpCodeStatus;
      function GetLocation(): String;
      function GetMessage(): String;

  end;

implementation

{ TResponseJSonAdapter }

function TResponseJSonAdapter.GetLocation: String;
begin
  Result := jsonBase.getString('location');
end;

function TResponseJSonAdapter.GetMessage: String;
begin
  Result := jsonBase.getString('message');  
end;

function TResponseJSonAdapter.GetStatusCode: THttpCodeStatus;
begin
  Result := THttpCodeStatus(jsonBase.getInt('statusCode'))
end;

procedure TResponseJSonAdapter.SetLocation(location: String);
begin
  jsonBase.Add('location', location);
end;

procedure TResponseJSonAdapter.SetMessage(value: String);
begin
  jsonBase.Add('message', value);
end;

procedure TResponseJSonAdapter.SetStatusCode(code: THttpCodeStatus);
begin
  jsonBase.Add('statusCode', Integer(code));
end;

end.
