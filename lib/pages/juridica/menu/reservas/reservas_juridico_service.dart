import 'package:app_foodmatch/endpoints/endpoints.dart';
import 'package:muller_package/muller_package.dart';

Future<AppResponse> getReservasJurifico() async {
  return await getHTTP(endpoint: "${AppEndpoints.reservas}/listar");
}

Future<AppResponse> setRetiradaJurifico(int id) async {
  return await putHTTP(
    endpoint: '${AppEndpoints.reservas}/retirado',
    parameters: {'id': id.toString()},
  );
}
