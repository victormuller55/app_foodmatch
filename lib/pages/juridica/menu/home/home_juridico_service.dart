import 'package:app_foodmatch/endpoints/endpoints.dart';
import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> getDoacoesJurifico() async {
  return await getHTTP(endpoint: AppEndpoints.doacao);
}

Future<AppResponse> postDoacoes(DoacaoModel doacaoModel) async {
  return await postHTTP(
    endpoint: "${AppEndpoints.doacao}/cadastrar",
    body: doacaoModel.toJson(),
  );
}
