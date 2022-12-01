unit UTTreeView;

interface

uses
  Classes, SysUtils, ComCtrls, Dialogs, UIDados;

type
  TTreeViewClick = procedure(value: IDados) of Object;
  TTreeView = class(ComCtrls.TTreeView)
  private
    fValues: IDadosList;
    fClick: TTreeViewClick;

    procedure OnClick(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

    procedure Load(values: IDadosList);
    property SetClick: TTreeViewClick read fClick write fClick;
  end;

implementation

{ TTreeView }

procedure TTreeView.OnClick(Sender: TObject);
var
  dados: PIDados;
begin
  dados := Self.Selected.Data;
  if Assigned(fClick) then
    fClick(dados^);
end;

constructor TTreeView.Create(AOwner: TComponent);
begin
  inherited;
  Self.MultiSelectStyle := [];
  Self.ReadOnly := True;
  Self.RowSelect := True;
  Self.ShowLines := False;
  Self.ShowRoot := False;
  Self.SortType := stText;
  Self.ToolTips := False;
  Self.HideSelection := False;
  inherited OnClick := Self.OnClick;
end;

destructor TTreeView.Destroy;
begin
  Self.fValues := nil;
  Self.Items.Clear;
  inherited;
end;

procedure TTreeView.Load(values: IDadosList);
var
  i: Integer;
  dados: IDados;
  p: PIDados;
begin
  Self.fValues := values;
  for i:=0 to fValues.Count-1 do
  begin
    dados := fValues.GetItem(i);
    New(p);
    p^ := dados;
    Self.Items.AddObject(nil, dados.GetNome, p);
  end;
end;

end.
