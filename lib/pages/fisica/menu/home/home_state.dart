import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:muller_package/models/error_model.dart';

abstract class HomeState {
  ErrorModel errorModel;
  List<DoacaoModel> doacaoList;

  HomeState({required this.doacaoList, required this.errorModel});
}

class HomeInitialState extends HomeState {
  HomeInitialState() : super(doacaoList: [], errorModel: ErrorModel.empty());
}

class HomeLoadingState extends HomeState {
  HomeLoadingState() : super(doacaoList: [], errorModel: ErrorModel.empty());
}

class HomeSuccessState extends HomeState {
  HomeSuccessState({required super.doacaoList}) : super(errorModel: ErrorModel.empty());
}

class HomeErrorState extends HomeState {
  HomeErrorState({required super.errorModel}) : super(doacaoList: []);
}