import 'package:app_foodmatch/model/empresa_model.dart';
import 'package:app_foodmatch/model/pessoa_model.dart';

class UsuarioModel {
  PessoaModel? pessoa;
  EmpresaModel? empresa;
  int? idUsuario;
  String? email;
  String? senha;
  String? telefone;
  String? tipo;
  String? status;
  String? dataCriacao;

  UsuarioModel({
    this.pessoa,
    this.empresa,
    this.idUsuario,
    this.email,
    this.senha,
    this.telefone,
    this.tipo,
    this.status,
    this.dataCriacao,
  });

  factory UsuarioModel.empty() {
    return UsuarioModel(
      pessoa: PessoaModel.empty(),
      empresa: EmpresaModel.empty(),
      idUsuario: 0,
      email: '',
      senha: '',
      telefone: '',
      tipo: '',
      status: '',
      dataCriacao: '',
    );
  }

  UsuarioModel.fromJson(Map<String, dynamic> json) {
    pessoa = json['pessoa'] != null
        ? PessoaModel.fromJson(json['pessoa'])
        : null;
    empresa = json['empresa'] != null
        ? EmpresaModel.fromJson(json['empresa'])
        : null;
    idUsuario = json['id_usuario'];
    email = json['email'];
    senha = json['senha'];
    telefone = json['telefone'];
    tipo = json['tipo'];
    status = json['status'];
    dataCriacao = json['data_criacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (pessoa != null) {
      data['pessoa'] = pessoa!.toJson();
    }
    if (empresa != null) {
      data['empresa'] = empresa!.toJson();
    }
    data['id_usuario'] = idUsuario;
    data['email'] = email;
    data['senha'] = senha;
    data['telefone'] = telefone;
    data['tipo'] = tipo;
    data['status'] = status;
    data['data_criacao'] = dataCriacao;
    return data;
  }
}
