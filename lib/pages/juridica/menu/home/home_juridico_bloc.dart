import 'dart:convert';

import 'package:app_foodmatch/app_widget/local_storage.dart';
import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_event.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_service.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_state.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class HomeJuridicoBloc extends Bloc<HomeJuridicoEvent, HomeJuridicoState> {
  HomeJuridicoBloc() : super(HomeJuridicoInitialState()) {

    on<HomeJuridicoLoadDoacoesEvent>((event, emit) async {
      emit(HomeJuridicoLoadingState());
      try {
        final doacoesFiltradas = await _loadDoacoesFiltradas();
        emit(HomeJuridicoSuccessState(doacaoList: doacoesFiltradas));
      } catch (e) {
        emit(HomeJuridicoErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });

    on<HomeJuridicoSaveDoacoesEvent>((event, emit) async {
      emit(HomeJuridicoLoadingState());
      try {

        UsuarioModel usuario = await getLocalUser();
        event.doacaoModel.empresa = usuario.empresa!;

        await postDoacoes(event.doacaoModel);
        final doacoesFiltradas = await _loadDoacoesFiltradas();

        showSnackbarSuccess(message: 'Doação salva com sucesso!');
        emit(HomeJuridicoSuccessState(doacaoList: doacoesFiltradas));
      } catch (e) {
        emit(HomeJuridicoErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });

    on<HomeJuridicoDeleteDoacaoEvent>((event, emit) async {
      emit(HomeJuridicoLoadingState());
      try {

        await deleteDoacoesJurifico(event.id);
        final doacoesFiltradas = await _loadDoacoesFiltradas();

        showSnackbarSuccess(message: 'Doação apagada com sucesso!');
        emit(HomeJuridicoSuccessState(doacaoList: doacoesFiltradas));
      } catch (e) {

        if(e is ApiException) {
          if(e.response.statusCode == 400) {
            final doacoesFiltradas = await _loadDoacoesFiltradas();
            emit(HomeJuridicoSuccessState(doacaoList: doacoesFiltradas));
            ErrorModel error = ErrorModel.fromMap(jsonDecode(e.response.body));
            showSnackbarError(message: error.mensagem);
          }
        } else {
          emit(HomeJuridicoErrorState(errorModel: ApiException.errorModel(e)));
          showSnackbarError(message: state.errorModel.mensagem);
        }
      }
    });
  }

  Future<List<DoacaoModel>> _loadDoacoesFiltradas() async {
    UsuarioModel usuario = await getLocalUser();
    AppResponse response = await getDoacoesJurifico();

    final List<dynamic> jsonList = jsonDecode(response.body);

    final List<DoacaoModel> doacoes =
    jsonList.map((item) => DoacaoModel.fromJson(item)).toList();

    final int empresaAtualId = usuario.empresa!.idEmpresa!;

    return doacoes.where((d) => d.empresa?.idEmpresa == empresaAtualId).toList();
  }
}
