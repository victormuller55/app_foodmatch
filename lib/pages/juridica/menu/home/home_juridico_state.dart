import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:muller_package/models/error_model.dart';

abstract class HomeJuridicoState {
  ErrorModel errorModel;
  List<DoacaoModel> doacaoList;

  HomeJuridicoState({required this.doacaoList, required this.errorModel});
}

class HomeJuridicoInitialState extends HomeJuridicoState {
  HomeJuridicoInitialState() : super(doacaoList: [], errorModel: ErrorModel.empty());
}

class HomeJuridicoLoadingState extends HomeJuridicoState {
  HomeJuridicoLoadingState() : super(doacaoList: [], errorModel: ErrorModel.empty());
}

class HomeJuridicoSuccessState extends HomeJuridicoState {
  HomeJuridicoSuccessState({required super.doacaoList}) : super(errorModel: ErrorModel.empty());
}

class HomeJuridicoErrorState extends HomeJuridicoState {
  HomeJuridicoErrorState({required super.errorModel}) : super(doacaoList: []);
}