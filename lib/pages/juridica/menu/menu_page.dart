import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/app_widget/local_storage.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/fisica/menu/configuracoes/configuracao_page.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_page.dart';
import 'package:app_foodmatch/pages/juridica/menu/reservas/reservas_juridico_page.dart';
import 'package:app_foodmatch/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

Widget _menu({
  required IconData icon,
  required String title,
  Color? color,
  Color? textColor,
  required Widget page,
}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 1),
    child: ListTile(
      onTap: () => open(screen: page),
      tileColor: color?.withValues(alpha: 0.4) ?? Colors.grey.shade200,
      leading: appContainer(
        backgroundColor: color?.withValues(alpha: 0.3) ?? Colors.grey.shade300,
        padding: EdgeInsets.all(5),
        radius: BorderRadius.circular(5),
        child: Icon(icon, color: textColor),
      ),
      title: appText(
        title.toUpperCase(),
        color: textColor ?? AppColors.grey800,
        bold: true,
      ),
    ),
  );
}

Widget _header() {
  return FutureBuilder<UsuarioModel>(
    future: getLocalUser(),
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return appContainer(
          height: 240,
          width: double.infinity,
          gradient: LinearGradient(
            colors: [FMColors.primary, FMColors.secondary],
          ),
          child: const Center(
            child: CircularProgressIndicator(color: Colors.white),
          ),
        );
      }

      final user = snapshot.data!;
      final isPessoa = user.tipo?.toLowerCase() == "fisico";
      final nome = isPessoa ? user.pessoa?.nome : user.empresa?.nomeFantasia;
      final email = user.email ?? "";

      return appContainer(
        height: 240,
        width: double.infinity,
        gradient: LinearGradient(
          colors: [FMColors.primary, FMColors.secondary],
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 10),
            child: ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.grey.shade200,
                child: Icon(Icons.person, color: AppColors.grey700),
              ),
              title: appText(nome ?? "-", color: AppColors.white, bold: true),
              subtitle: appText(email, color: Colors.white70, bold: true),
            ),
          ),
        ),
      );
    },
  );
}

Widget drawerJuridico() {
  return Drawer(
    child: Column(
      children: [
        _header(),
        appSizedBox(height: 30),
        _menu(title: 'Home', icon: Icons.home, page: HomeJuridicoPage()),
        _menu(
          title: 'Reservas',
          icon: Icons.fastfood_sharp,
          page: ReservasJuridicoPage(),
        ),
        _menu(
          title: 'Configurações',
          icon: Icons.settings,
          page: ConfiguracaoPage(isJuridico: true),
        ),
        _menu(
          title: 'Sair da Conta',
          icon: Icons.logout,
          color: Colors.red,
          textColor: Colors.red.shade900,
          page: LoginPage(),
        ),
      ],
    ),
  );
}
