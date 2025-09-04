import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:muller_package/models/error_model.dart';

abstract class CadastroState {
  ErrorModel errorModel;
  UsuarioModel usuarioModel;

  CadastroState({required this.usuarioModel, required this.errorModel});
}

class CadastroInitialState extends CadastroState {
  CadastroInitialState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class CadastroLoadingState extends CadastroState {
  CadastroLoadingState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class CadastroSuccessState extends CadastroState {
  CadastroSuccessState({required super.usuarioModel}) : super(errorModel: ErrorModel.empty());
}

class CadastroErrorState extends CadastroState {
  CadastroErrorState({required super.errorModel}) : super(usuarioModel: UsuarioModel.empty());
}