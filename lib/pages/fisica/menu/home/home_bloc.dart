import 'dart:convert';

import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_event.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_service.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_state.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeLoadDoacoesEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {
        AppResponse response = await getDoacoes();

        final List<dynamic> jsonList = jsonDecode(response.body);

        final List<DoacaoModel> doacoes = jsonList
            .map((item) => DoacaoModel.fromJson(item))
            .toList();

        emit(HomeSuccessState(doacaoList: doacoes));
      } catch (e) {
        emit(HomeErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });

    on<HomeSaveReservaEvent>((event, emit) async {
      emit(HomeLoadingState());
      try {

        await saveReserva(
          event.doacaoModel.idDoacao!,
          event.date,
          event.hour,
        );

        AppResponse response = await getDoacoes();

        final List<dynamic> jsonList = jsonDecode(response.body);

        final List<DoacaoModel> doacoes = jsonList
            .map((item) => DoacaoModel.fromJson(item))
            .toList();

        emit(HomeSuccessState(doacaoList: doacoes));
        showSnackbarSuccess(message: 'Reservado com sucesso!');
      } catch (e) {
        emit(HomeErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}
