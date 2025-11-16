import 'package:app_foodmatch/app_widget/local_storage.dart';
import 'package:app_foodmatch/endpoints/endpoints.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> getDoacoes() async {
  return await getHTTP(endpoint: AppEndpoints.doacao);
}

Future<AppResponse> saveReserva(int idDoacao, String date, String hour) async {

  UsuarioModel usuario = await getLocalUser();

  return await postHTTP(
    endpoint: "${AppEndpoints.reservas}/criar",
    body: {"dataRetirada": date, "horaRetirada": hour},
    parameters: {
      'usuarioId': usuario.idUsuario.toString(),
      'doacaoId': idDoacao.toString(),
    },
  );
}
