unit UFormCadastroProdutos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, {Vcl.ComComps,} Vcl.ExtCtrls,
  Vcl.StdCtrls, Vcl.Grids, Vcl.DBGrids, Data.DB, FireDAC.Comp.Client, 
  UProduto.Model, UConexao.Singleton, Vcl.Buttons, Vcl.ComCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet;

type
  TFormCadastroProdutos = class(TForm)
    pgcPrincipal: TPageControl;
    tbsGeral: TTabSheet;
    tbsManutencao: TTabSheet;
    pnlPesquisaTopo: TPanel;
    lblPesquisa: TLabel;
    edtPesquisa: TEdit;
    btnPesquisar: TBitBtn;
    dbgProdutos: TDBGrid;
    lblId: TLabel;
    edtId: TEdit;
    lblPartNumber: TLabel;
    edtPartNumber: TEdit;
    lblDescricao: TLabel;
    edtDescricao: TEdit;
    chkAtivo: TCheckBox;
    pnlBotoesManutencao: TPanel;
    btnOk: TBitBtn;
    btnCancela: TBitBtn;


    qryPesquisa: TFDQuery;
    dsProdutos: TDataSource;
    Panel1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure btnPesquisarClick(Sender: TObject);
    procedure dbgProdutosDblClick(Sender: TObject);
    procedure dbgProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnOkClick(Sender: TObject);
    procedure btnCancelaClick(Sender: TObject);
  private
    { Private declarations }
    FOperacaoInclusao: Boolean;
    procedure ConfigurarComponentes;
    procedure ExecutarPesquisa;
    procedure PrepararManutencao(const AInclusao: Boolean);
    procedure SalvarRegistro;
    procedure RetornarParaGeral;
  public
    { Public declarations }
  end;

var
  FormCadastroProdutos: TFormCadastroProdutos;

implementation

{$R *.dfm}

procedure TFormCadastroProdutos.FormCreate(Sender: TObject);
begin
  ConfigurarComponentes;
end;

procedure TFormCadastroProdutos.ConfigurarComponentes;
begin
  // Força que a aba inicial seja sempre a Geral e esconde os Tabs em runtime para Clean UX
  pgcPrincipal.ActivePage := tbsGeral;
  
  // Amarra a query local à conexão global Singleton
  qryPesquisa.Connection := TConexaoSingleton.GetInstance.Conexao;
  dsProdutos.DataSet := qryPesquisa;
  dbgProdutos.DataSource := dsProdutos;
end;

procedure TFormCadastroProdutos.btnPesquisarClick(Sender: TObject);
begin
  ExecutarPesquisa;
end;

procedure TFormCadastroProdutos.ExecutarPesquisa;
begin
  qryPesquisa.Close;
  qryPesquisa.SQL.Text := 'SELECT ID, PARTNUMBER, DESCRICAO, ATIVO FROM PRODUTOS WHERE 1=1';
  
  if Trim(edtPesquisa.Text) <> EmptyStr then
  begin
    qryPesquisa.SQL.Add('AND UPPER(DESCRICAO) LIKE :PESQUISA');
    qryPesquisa.ParamByName('PESQUISA').AsString := '%' + UpperCase(trim(edtPesquisa.Text)) + '%';
  end;

  qryPesquisa.Open;
end;

procedure TFormCadastroProdutos.PrepararManutencao(const AInclusao: Boolean);
begin
  FOperacaoInclusao := AInclusao;
  
  if FOperacaoInclusao then
  begin
    // Limpando campos para um novo registro
    edtId.Text         := 'Gerado Automaticamente';
    edtId.ReadOnly     := True;
    edtPartNumber.Text := string.Empty;
    edtDescricao.Text  := string.Empty;
    chkAtivo.Checked   := True;
  end
  else
  begin
    // Carregando dados da Grid/Query para os Edits de edição
    if qryPesquisa.IsEmpty then Exit;
    
    edtId.Text         := qryPesquisa.FieldByName('ID').AsString;
    edtPartNumber.Text := qryPesquisa.FieldByName('PARTNUMBER').AsString;
    edtDescricao.Text  := qryPesquisa.FieldByName('DESCRICAO').AsString;
    chkAtivo.Checked   := qryPesquisa.FieldByName('ATIVO').AsString = 'S';
  end;

  // Redireciona o foco visual à aba manutenção conforme regras do projeto
  tbsManutencao.TabVisible := True;
  pgcPrincipal.ActivePage := tbsManutencao;
  edtPartNumber.SetFocus;
end;

procedure TFormCadastroProdutos.dbgProdutosDblClick(Sender: TObject);
begin
  // Duplo clique altera o registro selecionado
  PrepararManutencao(False);
end;

procedure TFormCadastroProdutos.dbgProdutosKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  // Tecla INSERT interceptada para criar novo registro
  if Key = VK_INSERT then
  begin
    Key := 0; // Consome a tecla
    PrepararManutencao(True);
  end;
  if Key = VK_RETURN then
  begin
    dbgProdutosDblClick(self);
  end;
  if Key = VK_DELETE then
  begin
    Key := 0;
    PrepararManutencao(False);
    If Application.MessageBox('Confirma a EXCLUSÃO do registro', 'EXCLUSÃO', MB_YESNO) = IDYES then
    begin
      var vProduto: TProdutoModel;
      try
        vProduto := TProdutoModel.Create(qryPesquisa.FieldByName('ID').AsInteger,
                                         qryPesquisa.FieldByName('PARTNUMBER').AsString,
                                         qryPesquisa.FieldByName('DESCRICAO').AsString,
                                         qryPesquisa.FieldByName('ATIVO').AsString = 'S');
        vProduto.Excluir;
        // Atualiza os dados e retorna à tela principal
        ExecutarPesquisa;

      finally
        vProduto.Free;
      end;
    end;
    RetornarParaGeral;
  end;
end;

procedure TFormCadastroProdutos.btnOkClick(Sender: TObject);
begin
  SalvarRegistro;
end;

procedure TFormCadastroProdutos.SalvarRegistro;
var
  vProduto: TProdutoModel;
  vMsgErro: string;
  vIdAtual: Integer;
begin
  vIdAtual := 0;
  if not FOperacaoInclusao then
    vIdAtual := StrToIntDef(edtId.Text, 0);

  // Instanciando a entidade usando o construtor enriquecido
  vProduto := TProdutoModel.Create(vIdAtual, edtPartNumber.Text, edtDescricao.Text, chkAtivo.Checked);
  try
    // Executa as validações internas de Clean Code da classe
    if not vProduto.ValidarDados(vMsgErro) then
    begin
      ShowMessage(vMsgErro);
      Exit;
    end;

    // Persistência baseada no estado da tela
    if FOperacaoInclusao then
      vProduto.Inserir
    else
      vProduto.Alterar;

    // Atualiza os dados e retorna à tela principal
    ExecutarPesquisa;
    RetornarParaGeral;
  finally
    vProduto.Free;
  end;
end;

procedure TFormCadastroProdutos.btnCancelaClick(Sender: TObject);
begin
  RetornarParaGeral;
end;

procedure TFormCadastroProdutos.RetornarParaGeral;
begin
  pgcPrincipal.ActivePage := tbsGeral;
  tbsManutencao.TabVisible := False;
  edtPesquisa.SetFocus;
end;

end.