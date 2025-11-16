import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // 👈 necessário pra mudar a cor da status bar
import 'package:app_foodmatch/app_widget/app_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Define a cor da barra superior
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color.fromRGBO(255, 178, 0, 1.0), // cor da barra
    statusBarIconBrightness: Brightness.dark, // cor dos ícones (use Brightness.light se o fundo for escuro)
  ));

  runApp(const AppWidget());
}
