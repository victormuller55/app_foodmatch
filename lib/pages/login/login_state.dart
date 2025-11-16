import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:muller_package/models/error_model.dart';

abstract class LoginState {
  ErrorModel errorModel;
  UsuarioModel usuarioModel;

  LoginState({required this.usuarioModel, required this.errorModel});
}

class LoginInitialState extends LoginState {
  LoginInitialState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class LoginLoadingState extends LoginState {
  LoginLoadingState() : super(usuarioModel: UsuarioModel.empty(), errorModel: ErrorModel.empty());
}

class LoginSuccessState extends LoginState {
  LoginSuccessState({required super.usuarioModel}) : super(errorModel: ErrorModel.empty());
}

class LoginErrorState extends LoginState {
  LoginErrorState({required super.errorModel}) : super(usuarioModel: UsuarioModel.empty());
}