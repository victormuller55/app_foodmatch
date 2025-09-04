import 'dart:convert';

import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_event.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_service.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_state.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class CadastroBloc extends Bloc<CadastroEvent, CadastroState> {
  CadastroBloc() : super(CadastroInitialState()) {
    on<CadastroSalvarEvent>((event, emit) async {
      emit(CadastroLoadingState());
      try {

        AppResponse response = await postUser(event.usuarioModel);
        UsuarioModel usuarioModel = UsuarioModel.fromJson(jsonDecode(response.body));

        emit(CadastroSuccessState(usuarioModel: usuarioModel));
        // saveLocalUserData(usuarioModel);

      } catch (e) {
        emit(CadastroErrorState(errorModel: ApiException.errorModel(e)));
        // showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}