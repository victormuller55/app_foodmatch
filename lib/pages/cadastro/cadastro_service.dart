import 'package:app_foodmatch/endpoints/endpoints.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> postUser(UsuarioModel usuarioModel) async {
  return await postHTTP(
    endpoint: "${AppEndpoints.usuarios}/cadastrar",
    body: usuarioModel.toJson(),
  );
}