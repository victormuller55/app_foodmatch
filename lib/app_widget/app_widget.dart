import 'package:app_foodmatch/pages/cadastro/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: AppContext.navigatorKey,
      home: CadastroPage(),
    );
  }
}
