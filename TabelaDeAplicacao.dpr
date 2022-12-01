program TabelaDeAplicacao;

uses
  Forms,
  UTFrmPrincipal in 'UTFrmPrincipal.pas' {frmPrincipal},
  UERestServerException in 'rest\UERestServerException.pas',
  UIServerRest in 'rest\UIServerRest.pas',
  UTHttpCodeStatus in 'rest\UTHttpCodeStatus.pas',
  UIRestMethod in 'rest\methods\UIRestMethod.pas',
  UTGetMethod in 'rest\methods\UTGetMethod.pas',
  UTRestMethodBase in 'rest\methods\UTRestMethodBase.pas',
  UTResponseJSonAdapter in 'rest\adapters\UTResponseJSonAdapter.pas',
  uLkJSON in 'util\uLkJSON.pas',
  UTBaseJSonAdapter in 'rest\adapters\UTBaseJSonAdapter.pas',
  UIGetObject in 'util\UIGetObject.pas',
  UTObjectPersistent in 'util\UTObjectPersistent.pas',
  UTMontadoraJSonController in 'rest\controllers\UTMontadoraJSonController.pas',
  UTResource in 'rest\UTResource.pas',
  UTDefaultJSonAdapter in 'rest\adapters\UTDefaultJSonAdapter.pas',
  UIJSonAdapter in 'rest\adapters\UIJSonAdapter.pas',
  UIDados in 'rest\adapters\UIDados.pas',
  UTCategoriaJSonController in 'rest\controllers\UTCategoriaJSonController.pas',
  UTCategoriaListJSonAdapter in 'rest\adapters\UTCategoriaListJSonAdapter.pas',
  UICategoria in 'rest\adapters\UICategoria.pas',
  UTTreeView in 'UTTreeView.pas',
  UTMapList in 'util\UTMapList.pas',
  UTDefaultJSonController in 'rest\controllers\UTDefaultJSonController.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Tabela de Aplicação';
  Application.CreateForm(TfrmPrincipal, frmPrincipal);
  Application.Run;
end.
