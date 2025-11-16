import 'package:app_foodmatch/endpoints/endpoints.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> loginUser(String email, String password) async {
  return await postHTTP(
    endpoint: "${AppEndpoints.usuarios}/login",
    body: UsuarioModel.empty().toJson(),
    parameters: {
      'email': email,
      'password' : password,
    }
  );
}