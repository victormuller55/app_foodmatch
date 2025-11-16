import 'package:app_foodmatch/model/doacao_model.dart';

abstract class HomeJuridicoEvent {}

class HomeJuridicoLoadDoacoesEvent extends HomeJuridicoEvent {}

class HomeJuridicoSaveDoacoesEvent extends HomeJuridicoEvent {
  DoacaoModel doacaoModel;
  HomeJuridicoSaveDoacoesEvent({required this.doacaoModel});
}

class HomeJuridicoDeleteDoacaoEvent extends HomeJuridicoEvent {
  int id;
  HomeJuridicoDeleteDoacaoEvent({required this.id});
}