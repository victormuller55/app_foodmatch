import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/app_widget/local_storage.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_page.dart';
import 'package:app_foodmatch/pages/fisica/menu/menu_page.dart';
import 'package:app_foodmatch/pages/juridica/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

class ConfiguracaoPage extends StatefulWidget {
  final bool? isJuridico;
  const ConfiguracaoPage({super.key, required this.isJuridico});

  @override
  State<ConfiguracaoPage> createState() => _ConfiguracaoPageState();
}

class _ConfiguracaoPageState extends State<ConfiguracaoPage> {

  bool isJuridico = false;

  Widget _userInfos() {
    return FutureBuilder<UsuarioModel>(
      future: getLocalUser(), // seu método que pega o usuário do SharedPreferences
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          // Enquanto carrega
          return appContainer(
            radius: BorderRadius.circular(20),
            padding: const EdgeInsets.all(10),
            backgroundColor: AppColors.white,
            height: 100,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        if (!snapshot.hasData) {
          // Se não houver dados
          return appContainer(
            radius: BorderRadius.circular(20),
            padding: const EdgeInsets.all(10),
            backgroundColor: AppColors.white,
            height: 100,
            child: Center(
              child: appText(
                "Usuário não encontrado",
                color: AppColors.grey800,
                bold: true,
              ),
            ),
          );
        }



        // Usuário carregado com sucesso
        final user = snapshot.data!;
        isJuridico = user.tipo?.toLowerCase() != "fisico";
        final isPessoa = user.tipo?.toLowerCase() == "fisico";
        final nome = isPessoa ? user.pessoa?.nome : user.empresa?.nomeFantasia;
        final email = user.email ?? "";

        return appContainer(
          radius: BorderRadius.circular(20),
          padding: const EdgeInsets.all(10),
          backgroundColor: AppColors.white,
          height: 100,
          child: Center(
            child: ListTile(
              leading: CircleAvatar(
                radius: 40,
                backgroundColor: AppColors.grey300,
                child: Icon(Icons.person, color: AppColors.grey700,),
              ),
              title: appText(
                nome ?? "-",
                color: AppColors.grey800,
                bold: true,
                fontSize: 17,
              ),
              subtitle: appText(
                email,
                color: AppColors.grey600,
                bold: true,
              ),
            ),
          ),
        );
      },
    );
  }


  Widget _menu({
    required String title,
    required Widget page
  }) {
    return InkWell(
      onTap: () => open(screen: page),
      borderRadius: BorderRadius.circular(100),
      child: appContainer(
        margin: EdgeInsets.only(bottom: 3),
        width: double.infinity,
        padding: EdgeInsets.all(15),
        radius: BorderRadius.circular(100),
        backgroundColor: AppColors.white,
        child: Row(
          children: [
            appSizedBox(width: 10),
            appText(title.toUpperCase(), bold: true),
            Spacer(),
            Icon(Icons.keyboard_arrow_right_sharp),
            appSizedBox(width: 10),
          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: "Configurações",
      drawer: widget.isJuridico ?? false ? drawerJuridico() : drawer(),
      drawerColor: Colors.white,
      appBarGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [FMColors.primary, FMColors.secondary],
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          _userInfos(),
          Divider(),
          _menu(title: 'Alterar nome/e-mail', page: MenuPage()),
          _menu(title: 'Alterar dados do perfil', page: MenuPage()),
          _menu(title: 'Alterar senha', page: MenuPage()),
          _menu(title: 'Termos de uso', page: MenuPage()),
          _menu(title: 'Politica de privacidade', page: MenuPage()),
          _menu(title: 'Sair', page: MenuPage()),
        ],
      )
    );
  }
}
