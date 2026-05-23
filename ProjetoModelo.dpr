program ProjetoModelo;

uses
  Vcl.Forms,
  UFormCadastroProdutos in 'view\UFormCadastroProdutos.pas' {FormCadastroProdutos},
  uConexao.Singleton in 'entity\uConexao.Singleton.pas',
  UProduto.Model in 'entity\UProduto.Model.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCadastroProdutos, FormCadastroProdutos);
  Application.Run;
end.
