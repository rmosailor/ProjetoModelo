unit UConexao.Singleton;

interface

uses
  System.SysUtils, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.FB, FireDAC.Phys.FBDef,
  FireDAC.VCLUI.Wait, FireDAC.Comp.Client, IniFiles;

type
  TConexaoSingleton = class
  private
    FConexao: TFDConnection;
    class var FInstance: TConexaoSingleton;
    constructor Create;
  public
    destructor Destroy; override;
    class function GetInstance: TConexaoSingleton;
    property Conexao: TFDConnection read FConexao;
  end;

implementation

{ TConexaoSingleton }

constructor TConexaoSingleton.Create;
var
  ini : TIniFile;
begin
  ini := TIniFIle.Create('.\ProjetoModelo.ini');
  try
    inherited Create;
    FConexao := TFDConnection.Create(nil);

    // Recupera os dados para a conexão
    var DriverID := ini.ReadString('config', 'Driver', '');
    var Database := ini.ReadString('config', 'Database', '');
    var User     := ini.ReadString('config', 'Username', '');
    var Pass     := ini.ReadString('config', 'Password', '');

    // Configuração padrão da conexão Firebird
    FConexao.Params.DriverID := DriverID; //'FB'; // Banco de dados firebird
    FConexao.Params.Database := Database; // 'C:\Projetos\Delphi\ExemploCadastro\database\BDADOS.FDB'; // Caminho fictício
    FConexao.Params.UserName := User;     // 'SYSDBA'; // Padrão
    FConexao.Params.Password := Pass;     // 'masterkey'; // Senha
    FConexao.LoginPrompt     := False;
    FConexao.Connected       := True;
  finally
    ini.Free;
  end;
end;

destructor TConexaoSingleton.Destroy;
begin
  FConexao.Connected := False;
  FConexao.Free;
  inherited;
end;

class function TConexaoSingleton.GetInstance: TConexaoSingleton;
begin
  if not Assigned(FInstance) then
    FInstance := TConexaoSingleton.Create;
  Result := FInstance;
end;

initialization
  // Inicialização tardia controlada pelo GetInstance

finalization
  if Assigned(TConexaoSingleton.FInstance) then
    TConexaoSingleton.FInstance.Free;

end.