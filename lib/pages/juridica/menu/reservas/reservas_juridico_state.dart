import 'package:app_foodmatch/model/reserva_model.dart';
import 'package:muller_package/models/error_model.dart';

abstract class ReservaJuridicoState {
  ErrorModel errorModel;
  List<ReservaModel> reservas;

  ReservaJuridicoState({required this.reservas, required this.errorModel});
}

class ReservaJuridicoInitialState extends ReservaJuridicoState {
  ReservaJuridicoInitialState() : super(reservas: [], errorModel: ErrorModel.empty());
}

class ReservaJuridicoLoadingState extends ReservaJuridicoState {
  ReservaJuridicoLoadingState() : super(reservas: [], errorModel: ErrorModel.empty());
}

class ReservaJuridicoSuccessState extends ReservaJuridicoState {
  ReservaJuridicoSuccessState({required super.reservas}) : super(errorModel: ErrorModel.empty());
}

class ReservaJuridicoErrorState extends ReservaJuridicoState {
  ReservaJuridicoErrorState({required super.errorModel}) : super(reservas: []);
}