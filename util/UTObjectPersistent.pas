unit UTObjectPersistent;

interface

uses
  Windows, Classes, SysUtils;

type
/// <summary> Pode ser usada para ser herdada por qualquer classe que implementa
/// uma interface. Com ela o delphi consegue controlar as referências de uma
/// interface, para poder destrui-lá quando suas referências forem 0 ou menor.
/// @author thiago barros
/// </summary>

TObjectPersistent = class(TInterfacedPersistent, IUnknown)
  private
    FRefCount: Integer;
    classNameStr: String;
  published

  //métodos de IInterface
    function _AddRef: Integer; stdcall;
    function _Release: Integer; stdcall;

    function GetSelf(): TObject;
end;

implementation

function TObjectPersistent.GetSelf: TObject;
begin
  Result := Self;
end;

function TObjectPersistent._AddRef: Integer;
begin
  InterlockedIncrement(FRefCount);
  Result := FRefCount;
end;

function TObjectPersistent._Release: Integer;
begin
  if Assigned(Self) and (FRefCount > 0) then
  begin
    classNameStr := ClassName;
    InterlockedDecrement(FRefCount);
    if FRefCount = 0 then
      Free;
  end;
  Result := FRefCount;
end;

initialization
  RegisterClass(TObjectPersistent);

end.
