import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_page.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_page.dart';
import 'package:app_foodmatch/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/functions/navigation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InitPage extends StatefulWidget {
  const InitPage({super.key});

  @override
  State<InitPage> createState() => _InitPageState();
}

class _InitPageState extends State<InitPage> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  Future<void> _checkUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    // Verifica se existe um usuário salvo
    final int? idUsuario = prefs.getInt("id_usuario");
    final String? tipo = prefs.getString("tipo");

    // Delay opcional só pra mostrar o splash
    await Future.delayed(const Duration(milliseconds: 500));

    if (idUsuario != null && idUsuario > 0 && tipo != null && tipo.isNotEmpty) {
      if(tipo.toLowerCase() == "fisico") {
        open(screen: const MenuPage(), closePrevious: true);
      } else {
        open(screen: const HomeJuridicoPage(), closePrevious: true);
      }
    } else {
      open(screen: const LoginPage(), closePrevious: true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(color: FMColors.primary),
      ),
    );
  }
}
