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
        UsuarioModel usuario = await getLocalUser();
        AppResponse response = await getDoacoesJurifico();

        final List<dynamic> jsonList = jsonDecode(response.body);

        final List<DoacaoModel> doacoes = jsonList
            .map((item) => DoacaoModel.fromJson(item))
            .toList();

        final int empresaAtualId = usuario.empresa!.idEmpresa!;

        final List<DoacaoModel> doacoesFiltradas = doacoes
            .where((d) => d.empresa?.idEmpresa == empresaAtualId)
            .toList();

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
        AppResponse response = await getDoacoesJurifico();

        final List<dynamic> jsonList = jsonDecode(response.body);

        final List<DoacaoModel> doacoes = jsonList
            .map((item) => DoacaoModel.fromJson(item))
            .toList();

        final int empresaAtualId = usuario.empresa!.idEmpresa!;

        final List<DoacaoModel> doacoesFiltradas = doacoes
            .where((d) => d.empresa?.idEmpresa == empresaAtualId)
            .toList();

        showSnackbarSuccess(message: 'Cadastrado com sucesso!');
        emit(HomeJuridicoSuccessState(doacaoList: doacoesFiltradas));
      } catch (e) {
        emit(HomeJuridicoErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}
