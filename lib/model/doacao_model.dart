import 'package:app_foodmatch/model/empresa_model.dart';

class DoacaoModel {
  int? idDoacao;
  EmpresaModel? empresa;
  String? descricao;
  int? quantidade;
  String? dataValidade;
  String? dataDisponivel;
  String? status;
  String? localizacao;

  DoacaoModel({
    this.idDoacao,
    this.empresa,
    this.descricao,
    this.quantidade,
    this.dataValidade,
    this.dataDisponivel,
    this.status,
    this.localizacao,
  });

  factory DoacaoModel.empty() {
    return DoacaoModel(
      idDoacao: 0,
      empresa: EmpresaModel.empty(),
      descricao: '',
      quantidade: 0,
      dataValidade: '',
      dataDisponivel: '',
      localizacao: '',
      status: '',
    );
  }

  DoacaoModel.fromJson(Map<String, dynamic> json) {
    idDoacao = json['idDoacao'];
    empresa = EmpresaModel.fromJson(json['empresa']);
    descricao = json['descricao'];
    quantidade = json['quantidade'];
    dataValidade = json['dataValidade'];
    dataDisponivel = json['dataDisponivel'];
    status = json['status'];
    localizacao = json['localizacao'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idDoacao'] = idDoacao;
    data['empresa'] = empresa!.toJson();
    data['descricao'] = descricao;
    data['quantidade'] = quantidade;
    data['dataValidade'] = dataValidade;
    data['dataDisponivel'] = dataDisponivel;
    data['status'] = status;
    data['localizacao'] = localizacao;
    return data;
  }
}
