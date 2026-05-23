unit UProduto.Model;

interface

uses
  System.SysUtils, FireDAC.Comp.Client, UConexao.Singleton, StrUtils;

type
  TProdutoModel = class
  private
    FId: Integer;
    FPartNumber: string;
    FDescricao: string;
    FAtivo: Boolean;
    procedure SetDescricao(const Value: string);
    procedure SetPartNumber(const Value: string);
  public
    constructor Create(const AId: Integer; const APartNumber, ADescricao: string; const AAtivo: Boolean); overload;
    constructor Create; overload;

    // Métodos de Validação
    function ValidarDados(out AMensagemErro: string): Boolean;

    // Métodos CRUD (Active Record Pattern)
    function Inserir: Boolean;
    function Alterar: Boolean;
    function Excluir: Boolean;

    // Propriedades
    property Id: Integer read FId write FId;
    property PartNumber: string read FPartNumber write SetPartNumber;
    property Descricao: string read FDescricao write SetDescricao;
    property Ativo: Boolean read FAtivo write FAtivo;
  end;

implementation

{ TProdutoModel }

constructor TProdutoModel.Create(const AId: Integer; const APartNumber, ADescricao: string; const AAtivo: Boolean);
begin
  Self.Create;
  FId         := AId;
  FPartNumber := APartNumber;
  FDescricao  := ADescricao;
  FAtivo      := AAtivo;
end;

constructor TProdutoModel.Create;
begin
  inherited Create;
  FId := 0;
  FAtivo := True;
end;

procedure TProdutoModel.SetDescricao(const Value: string);
begin
  if Value.Trim.IsEmpty then
    raise Exception.Create('A descrição não pode ser vazia.');
  FDescricao := Value.Trim;
end;

procedure TProdutoModel.SetPartNumber(const Value: string);
begin
  FPartNumber := Value.Trim;
end;

function TProdutoModel.ValidarDados(out AMensagemErro: string): Boolean;
begin
  Result := True;
  AMensagemErro := '';

  if FPartNumber.Trim.IsEmpty then
  begin
    AMensagemErro := 'O campo "Part Number" é obrigatório.';
    Exit(False);
  end;

  if FDescricao.Trim.IsEmpty then
  begin
    AMensagemErro := 'O campo "Descrição" é obrigatório.';
    Exit(False);
  end;
end;

function TProdutoModel.Inserir: Boolean;
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConexaoSingleton.GetInstance.Conexao;
    vQuery.SQL.Text := 
      'INSERT INTO PRODUTOS (PARTNUMBER, DESCRICAO, ATIVO) ' +
      'VALUES (:PARTNUMBER, :DESCRICAO, :ATIVO)';
    vQuery.ParamByName('PARTNUMBER').AsString := FPartNumber;
    vQuery.ParamByName('DESCRICAO').AsString   := FDescricao;
    vQuery.ParamByName('ATIVO').AsString       := IfThen(FAtivo, 'S', 'N'); // Considerando CHAR(1) no Firebird
    vQuery.ExecSQL;
    Result := True;
  finally
    vQuery.Free;
  end;
end;

function TProdutoModel.Alterar: Boolean;
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConexaoSingleton.GetInstance.Conexao;
    vQuery.SQL.Text := 
      'UPDATE PRODUTOS SET PARTNUMBER = :PARTNUMBER, DESCRICAO = :DESCRICAO, ATIVO = :ATIVO ' +
      'WHERE ID = :ID';
    vQuery.ParamByName('ID').AsInteger         := FId;
    vQuery.ParamByName('PARTNUMBER').AsString := FPartNumber;
    vQuery.ParamByName('DESCRICAO').AsString   := FDescricao;
    vQuery.ParamByName('ATIVO').AsString       := IfThen(FAtivo, 'S', 'N');
    vQuery.ExecSQL;
    Result := True;
  finally
    vQuery.Free;
  end;
end;

function TProdutoModel.Excluir: Boolean;
var
  vQuery: TFDQuery;
begin
  vQuery := TFDQuery.Create(nil);
  try
    vQuery.Connection := TConexaoSingleton.GetInstance.Conexao;
    vQuery.SQL.Text := 'DELETE FROM PRODUTOS WHERE ID = :ID';
    vQuery.ParamByName('ID').AsInteger := FId;
    vQuery.ExecSQL;
    Result := True;
  finally
    vQuery.Free;
  end;
end;

// Função auxiliar interna para simular o comportamento de Boolean para String
function IfThen(ABool: Boolean; ATrue, AFalse: string): string;
begin
  if ABool then Result := ATrue else Result := AFalse;
end;

end.