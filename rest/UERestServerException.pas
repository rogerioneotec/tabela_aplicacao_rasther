unit UERestServerException;

interface

uses
  UTHttpCodeStatus, SysUtils;

type
  ERestServerException = class(Exception)
    private
      FErrorMessage: String;
      FErrorStatus: THttpCodeStatus;
    public
      constructor Create(errorStatus: THttpCodeStatus; errorMessage: String);

      property ErrorStatus: THttpCodeStatus read FErrorStatus;
      property ErrorMessage: String read FErrorMessage;
  end;

implementation

{ ERestServerException }

constructor ERestServerException.Create(errorStatus: THttpCodeStatus;
  errorMessage: String);
begin
  inherited Create(errorMessage);
  FErrorMessage := errorMessage;
  FErrorStatus := errorStatus;
end;

end.
