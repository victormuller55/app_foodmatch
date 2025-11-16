import 'package:app_foodmatch/app_widget/local_storage.dart';
import 'package:app_foodmatch/endpoints/endpoints.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> getReservas() async {
  UsuarioModel usuario = await getLocalUser();

  return await getHTTP(
    endpoint: '${AppEndpoints.reservas}/usuario',
    parameters: {'usuarioId': usuario.idUsuario.toString()},
  );
}

Future<AppResponse> setRetirada(int id) async {
  return await putHTTP(
    endpoint: '${AppEndpoints.reservas}/retirado',
    parameters: {'id': id.toString()},
  );
}
