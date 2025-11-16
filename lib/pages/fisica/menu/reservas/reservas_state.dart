import 'package:app_foodmatch/model/reserva_model.dart';
import 'package:muller_package/models/error_model.dart';

abstract class ReservaState {
  ErrorModel errorModel;
  List<ReservaModel> reservas;

  ReservaState({required this.reservas, required this.errorModel});
}

class ReservaInitialState extends ReservaState {
  ReservaInitialState() : super(reservas: [], errorModel: ErrorModel.empty());
}

class ReservaLoadingState extends ReservaState {
  ReservaLoadingState() : super(reservas: [], errorModel: ErrorModel.empty());
}

class ReservaSuccessState extends ReservaState {
  ReservaSuccessState({required super.reservas}) : super(errorModel: ErrorModel.empty());
}

class ReservaErrorState extends ReservaState {
  ReservaErrorState({required super.errorModel}) : super(reservas: []);
}