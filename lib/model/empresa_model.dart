class EmpresaModel {
  int? idEmpresa;
  String? nomeSocial;
  String? nomeFantasia;
  String? cnpj;
  String? categoria;
  String? horarioFuncionamento;
  int? capacidadeDoacao;
  String? endereco;

  EmpresaModel({
    this.idEmpresa,
    this.nomeSocial,
    this.nomeFantasia,
    this.cnpj,
    this.categoria,
    this.horarioFuncionamento,
    this.capacidadeDoacao,
    this.endereco,
  });

  factory EmpresaModel.empty() {
    return EmpresaModel(
      idEmpresa: 0,
      nomeSocial: '',
      nomeFantasia: '',
      categoria: '',
      capacidadeDoacao: 0,
      cnpj: '',
      endereco: '',
      horarioFuncionamento: '',
    );
  }


  EmpresaModel.fromJson(Map<String, dynamic> json) {
    idEmpresa = json['id_empresa'];
    nomeSocial = json['nome_social'];
    nomeFantasia = json['nome_fantasia'];
    cnpj = json['cnpj'];
    categoria = json['categoria'];
    horarioFuncionamento = json['horario_funcionamento'];
    capacidadeDoacao = json['capacidade_doacao'];
    endereco = json['endereco'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id_empresa'] = idEmpresa;
    data['nome_social'] = nomeSocial;
    data['nome_fantasia'] = nomeFantasia;
    data['cnpj'] = cnpj;
    data['categoria'] = categoria;
    data['horario_funcionamento'] = horarioFuncionamento;
    data['capacidade_doacao'] = capacidadeDoacao;
    data['endereco'] = endereco;
    return data;
  }
}
