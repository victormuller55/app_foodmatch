import 'package:app_foodmatch/model/empresa_model.dart';
import 'package:app_foodmatch/model/pessoa_model.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> saveLocalUserDataPessoa(UsuarioModel usuarioModel) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();

  localData.setInt("id_usuario", usuarioModel.idUsuario ?? 0);
  localData.setString("email", usuarioModel.email ?? "");
  localData.setString("telefone", usuarioModel.telefone ?? "");
  localData.setString("tipo", usuarioModel.tipo ?? "");
  localData.setString("status", usuarioModel.status ?? "");
  localData.setString("data_criacao", usuarioModel.dataCriacao ?? "");

  // Dados específicos da pessoa
  final pessoa = usuarioModel.pessoa;
  if (pessoa != null) {
    localData.setInt("id_pessoa", pessoa.idPessoa ?? 0);
    localData.setString("nome", pessoa.nome ?? "");
    localData.setString("cpf", pessoa.cpf ?? "");
    localData.setString("endereco", pessoa.endereco ?? "");
  }
}

Future<void> saveLocalUserDataEmpresa(UsuarioModel usuarioModel) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();

  localData.setInt("id_usuario", usuarioModel.idUsuario ?? 0);
  localData.setString("email", usuarioModel.email ?? "");
  localData.setString("telefone", usuarioModel.telefone ?? "");
  localData.setString("tipo", usuarioModel.tipo ?? "");
  localData.setString("status", usuarioModel.status ?? "");
  localData.setString("data_criacao", usuarioModel.dataCriacao ?? "");

  // Dados específicos da empresa
  final empresa = usuarioModel.empresa;
  if (empresa != null) {
    localData.setInt("id_empresa", empresa.idEmpresa ?? 0);
    localData.setString("razao_social", empresa.razaoSocial ?? "");
    localData.setString("nome_fantasia", empresa.nomeFantasia ?? "");
    localData.setString("cnpj", empresa.cnpj ?? "");
    localData.setString("categoria", empresa.categoria ?? "");
    localData.setString("horario_funcionamento", empresa.horarioFuncionamento ?? "");
    localData.setInt("capacidade_doacao", empresa.capacidadeDoacao ?? 0);
    localData.setString("endereco", empresa.endereco ?? "");
  }
}

Future<UsuarioModel> getLocalUser() async {
  final SharedPreferences localData = await SharedPreferences.getInstance();

  // Verifica o tipo de usuário salvo
  final tipo = localData.getString("tipo") ?? "";

  // Monta o modelo base
  final usuario = UsuarioModel(
    idUsuario: localData.getInt("id_usuario"),
    email: localData.getString("email"),
    telefone: localData.getString("telefone"),
    tipo: tipo,
    status: localData.getString("status"),
    dataCriacao: localData.getString("data_criacao"),
  );

  // Se for pessoa
  if (tipo.toLowerCase() == "fisico") {
    usuario.pessoa = PessoaModel(
      idPessoa: localData.getInt("id_pessoa"),
      nome: localData.getString("nome"),
      cpf: localData.getString("cpf"),
      endereco: localData.getString("endereco"),
    );
  } else {
    usuario.empresa = EmpresaModel(
      idEmpresa: localData.getInt("id_empresa"),
      razaoSocial: localData.getString("razao_social"),
      nomeFantasia: localData.getString("nome_fantasia"),
      cnpj: localData.getString("cnpj"),
      categoria: localData.getString("categoria"),
      horarioFuncionamento: localData.getString("horario_funcionamento"),
      capacidadeDoacao: localData.getInt("capacidade_doacao"),
      endereco: localData.getString("endereco"),
    );
  }

  return usuario;
}


void clearLocalData() async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.clear();
}

Future<bool> temLocalData() async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  return localData.getInt("id") != null;
}

void addLocalDataString(String key, String value) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.setString(key, value);
}

void addLocalDataInt(String key, int value) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.setInt(key, value);
}

void addLocalDataDouble(String key, double value) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.setDouble(key, value);
}

void addLocalDataBool(String key, bool value) async {
  final SharedPreferences localData = await SharedPreferences.getInstance();
  localData.setBool(key, value);
}
