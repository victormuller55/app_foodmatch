class PessoaModel {
  int? idPessoa;
  String? nome;
  String? cpf;
  String? endereco;

  PessoaModel({this.idPessoa, this.nome, this.cpf, this.endereco});

  PessoaModel.fromJson(Map<String, dynamic> json) {
    idPessoa = json['id_pessoa'];
    nome = json['nome'];
    cpf = json['cpf'];
    endereco = json['endereco'];
  }

  factory PessoaModel.empty() {
    return PessoaModel(
      idPessoa: 0,
      nome: '',
      cpf: '',
      endereco: '',
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_pessoa'] = idPessoa;
    data['nome'] = nome;
    data['cpf'] = cpf;
    data['endereco'] = endereco;
    return data;
  }
}
