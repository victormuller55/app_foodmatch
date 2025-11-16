import 'package:app_foodmatch/model/doacao_model.dart';

abstract class HomeEvent {}

class HomeLoadDoacoesEvent extends HomeEvent {}

class HomeSaveReservaEvent extends HomeEvent {
  DoacaoModel doacaoModel;
  String date;
  String hour;

  HomeSaveReservaEvent({
    required this.doacaoModel,
    required this.date,
    required this.hour,
  });
}
