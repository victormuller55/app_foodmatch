import 'package:app_foodmatch/model/usuario_model.dart';

abstract class CadastroEvent {}

class CadastroSalvarEvent extends CadastroEvent {
  UsuarioModel usuarioModel;
  CadastroSalvarEvent(this.usuarioModel);
}
