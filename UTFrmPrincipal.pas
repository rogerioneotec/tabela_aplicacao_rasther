unit UTFrmPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Menus, ExtCtrls, StdCtrls, UTTreeView, UIDados;

type
  TfrmPrincipal = class(TForm)
    mmPrincipal: TMainMenu;
    mArquivo: TMenuItem;
    mArquivoSair: TMenuItem;
    mSobre: TMenuItem;
    statusPrincipal: TStatusBar;
    pnlData: TPanel;
    mArquivoNovaEscolha: TMenuItem;
    mArquivoSeparador: TMenuItem;
    tmrInicializacao: TTimer;
    procedure mArquivoNovaEscolhaClick(Sender: TObject);
    procedure tmrInicializacaoTimer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure LimparEscolha();
    procedure NovaEscolha();
    procedure CreateTreeView(nameTreeview: string; values: IDadosList; click: TTreeViewClick);
    procedure CarregarMontadoras();
    procedure ClickMontadora(value: IDados);
  public
    { Public declarations }
  end;

var
  frmPrincipal: TfrmPrincipal;

implementation

uses
  UTMontadoraJSonController;

{$R *.dfm}

procedure TfrmPrincipal.CarregarMontadoras();
var
  controller: TMontadoraJSonController;
begin
  controller := TMontadoraJSonController.Create;
  CreateTreeView('montadora', controller.Get(), clickMontadora);
end;

procedure TfrmPrincipal.ClickMontadora(value: IDados);
begin
end;

procedure TfrmPrincipal.LimparEscolha();
begin
  while Self.pnlData.ControlCount > 0 do
    Self.pnlData.Controls[Self.pnlData.ControlCount-1].Free;
end;

procedure TfrmPrincipal.mArquivoNovaEscolhaClick(Sender: TObject);
begin
  NovaEscolha;
end;

procedure TfrmPrincipal.NovaEscolha;
begin
  LimparEscolha;
  CarregarMontadoras();
end;

procedure TfrmPrincipal.tmrInicializacaoTimer(Sender: TObject);
begin
  tmrInicializacao.Enabled := False;
  NovaEscolha;
end;

procedure TfrmPrincipal.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  LimparEscolha;
end;

procedure TfrmPrincipal.CreateTreeView(nameTreeview: string; values: IDadosList;
  click: TTreeViewClick);
var
  control: TControl;
begin
  control := (Self.pnlData.FindChildControl('tv' + nameTreeview));
  if Assigned(control) then
    control.Free;
  with TTreeView.Create(Self) do
  begin
    name := 'tv' + nameTreeview;
    Width := 180;
    SetClick := click;
    if (Self.pnlData.ControlCount > 0) then
    begin
      control := Self.pnlData.Controls[Self.pnlData.ControlCount-1];
      Left := control.Left + + control.Width + 10;
    end;
    Parent := Self.pnlData;
    Load(values);
    Align := alLeft;
  end;
end;


end.

