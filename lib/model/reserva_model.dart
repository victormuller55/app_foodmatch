import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:app_foodmatch/model/usuario_model.dart';

class ReservaModel {
  int? idReserva;
  UsuarioModel? usuario;
  DoacaoModel? doacao;
  String? dataCriacao;
  String? dataRetirada;
  String? horaRetirada;
  bool? retirado;

  ReservaModel({
    this.idReserva,
    this.usuario,
    this.doacao,
    this.dataCriacao,
    this.dataRetirada,
    this.horaRetirada,
    this.retirado,
  });

  factory ReservaModel.empty() {
    return ReservaModel(
      idReserva: 0,
      usuario: UsuarioModel.empty(),
      doacao: DoacaoModel.empty(),
      dataCriacao: '',
      dataRetirada: '',
      horaRetirada: '',
      retirado: false,
    );
  }

  ReservaModel.fromJson(Map<String, dynamic> json) {
    idReserva = json['idReserva'];
    usuario = UsuarioModel.fromJson(json['usuario']);
    doacao = DoacaoModel.fromJson(json['doacao']);
    dataCriacao = json['dataCriacao'];
    dataRetirada = json['dataRetirada'];
    horaRetirada = json['horaRetirada'];
    retirado = json['retirada'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idReserva'] = idReserva;
    data['usuario'] = usuario!.toJson();
    data['doacao'] = doacao!.toJson();
    data['dataCriacao'] = dataCriacao;
    data['dataRetirada'] = dataRetirada;
    data['retirada'] = retirado;
    return data;
  }
}
