import 'dart:convert';

import 'package:app_foodmatch/model/reserva_model.dart';
import 'package:app_foodmatch/pages/fisica/menu/reservas/reservas_event.dart';
import 'package:app_foodmatch/pages/fisica/menu/reservas/reservas_service.dart';
import 'package:app_foodmatch/pages/fisica/menu/reservas/reservas_state.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class ReservaBloc extends Bloc<ReservaEvent, ReservaState> {
  ReservaBloc() : super(ReservaInitialState()) {
    on<ReservaLoadEvent>((event, emit) async {
      emit(ReservaLoadingState());
      try {
        AppResponse response = await getReservas();

        final List<dynamic> jsonList = jsonDecode(response.body);

        final List<ReservaModel> doacoes = jsonList
            .map((item) => ReservaModel.fromJson(item))
            .toList();

        emit(ReservaSuccessState(reservas: doacoes));
      } catch (e) {
        emit(ReservaErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });

    on<ReservaPutEvent>((event, emit) async {
      emit(ReservaLoadingState());
      try {

        await setRetirada(event.id);
        AppResponse response = await getReservas();

        final List<dynamic> jsonList = jsonDecode(response.body);

        final List<ReservaModel> doacoes = jsonList
            .map((item) => ReservaModel.fromJson(item))
            .toList();

        showSnackbarSuccess(message: 'Reserva retirada com sucesso');
        emit(ReservaSuccessState(reservas: doacoes));
      } catch (e) {
        emit(ReservaErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}
