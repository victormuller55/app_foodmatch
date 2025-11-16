import 'dart:convert';

import 'package:app_foodmatch/app_widget/local_storage.dart';
import 'package:app_foodmatch/model/reserva_model.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/juridica/menu/reservas/reservas_juridico_event.dart';
import 'package:app_foodmatch/pages/juridica/menu/reservas/reservas_juridico_service.dart';
import 'package:app_foodmatch/pages/juridica/menu/reservas/reservas_juridico_state.dart';
import 'package:bloc/bloc.dart';
import 'package:muller_package/muller_package.dart';

class ReservasJuridicoBloc extends Bloc<ReservasJuridicoEvent, ReservaJuridicoState> {
  ReservasJuridicoBloc() : super(ReservaJuridicoInitialState()) {
    on<ReservasJuridicoLoadEvent>((event, emit) async {
      emit(ReservaJuridicoLoadingState());
      try {

        UsuarioModel usuario = await getLocalUser();
        final int empresaAtualId = usuario.empresa!.idEmpresa!;

        AppResponse response = await getReservasJurifico();

        final List<dynamic> jsonList = jsonDecode(response.body);

        final List<ReservaModel> doacoes = jsonList
            .map((item) => ReservaModel.fromJson(item))
            .toList();

        emit(ReservaJuridicoSuccessState(reservas: doacoes.where((d) => d.doacao!.empresa!.idEmpresa == empresaAtualId).toList()));
      } catch (e) {
        emit(ReservaJuridicoErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });

    on<ReservaJuridicoPutEvent>((event, emit) async {
      emit(ReservaJuridicoLoadingState());
      try {

        UsuarioModel usuario = await getLocalUser();
        final int empresaAtualId = usuario.empresa!.idEmpresa!;

        await setRetiradaJurifico(event.id);
        AppResponse response = await getReservasJurifico();

        final List<dynamic> jsonList = jsonDecode(response.body);

        final List<ReservaModel> doacoes = jsonList
            .map((item) => ReservaModel.fromJson(item))
            .toList();

        showSnackbarSuccess(message: 'Reserva retirada com sucesso');
        emit(ReservaJuridicoSuccessState(reservas: doacoes.where((d) => d.doacao!.empresa!.idEmpresa == empresaAtualId).toList()));
      } catch (e) {
        emit(ReservaJuridicoErrorState(errorModel: ApiException.errorModel(e)));
        showSnackbarError(message: state.errorModel.mensagem);
      }
    });
  }
}