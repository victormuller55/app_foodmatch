import 'dart:convert';

import 'package:app_foodmatch/app_widget/local_storage.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_page.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_page.dart';
import 'package:app_foodmatch/pages/login/login_event.dart';
import 'package:app_foodmatch/pages/login/login_service.dart';
import 'package:app_foodmatch/pages/login/login_state.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitialState()) {
    on<LoginLoginEvent>((event, emit) async {
      emit(LoginLoadingState());
      try {

        AppResponse response = await loginUser(event.email, event.password);
        UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(response.body));

        emit(LoginSuccessState(usuarioModel: usuarioModel));

        if(usuarioModel.pessoa != null) {
          saveLocalUserDataPessoa(usuarioModel);
          showSnackbarSuccess(message: 'Login realizado com sucesso, bem-vindo de volta!');
          open(screen: MenuPage());
        } else {
          saveLocalUserDataEmpresa(usuarioModel);
          showSnackbarSuccess(message: 'Login realizado com sucesso, bem-vindo de volta!');
          open(screen: HomeJuridicoPage());
        }

      } catch (e) {
        emit(LoginErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}