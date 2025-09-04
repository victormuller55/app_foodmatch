import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  late AppFormField emailForm;
  late AppFormField passwordForm;

  bool inverted = false;

  @override
  void initState() {

    emailForm = AppFormField(
      context: context,
      icon: Icon(Icons.email),
      hint: 'Digite seu e-mail',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
    );

    passwordForm = AppFormField(
      context: context,
      icon: Icon(Icons.lock),
      hint: 'Digite sua senha',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
    );

    super.initState();
  }

  Widget _logo() {
    return StatefulBuilder(
      builder: (context, setState) {
        return GestureDetector(
          onTap: () => setState(() => inverted = !inverted),
          child: Hero(
            tag: 'logo',
            child: AnimatedContainer(
              duration: Duration(milliseconds: 500),
              height: 350,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadius.big),
                  bottomRight: Radius.circular(AppRadius.big),
                ),
                gradient: LinearGradient(
                  colors: inverted
                      ? [FMColors.primary, FMColors.secondary] // invertido
                      : [FMColors.secondary, FMColors.primary], // original
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 30, right: 30),
                child: Image.asset('assets/image/foodmatch.png'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _form() {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          appSizedBox(height: AppSpacing.big),
          emailForm.formulario,
          passwordForm.formulario,
          appSizedBox(height: AppSpacing.medium),
          appElevatedButtonTextGradient(
            'Entrar'.toUpperCase()  ,
            height: 50,
            width: double.infinity,
            function: () => {},
            gradient: LinearGradient(
              colors: [FMColors.secondary, FMColors.primary],
              begin: Alignment.centerRight,
              end: Alignment.centerLeft,
            ),
          ),
          appSizedBox(height: AppSpacing.normal),
          appElevatedButtonText(
            'Não tenho conta'.toUpperCase(),
            height: 50,
            width: MediaQuery.of(context).size.width,
            function: () => open(screen: CadastroPage()),

            borderColor: FMColors.primary,
            textColor: FMColors.primary,
          ),
          Hero(
            tag: 'google',
            child: Column(
              children: [
                appSizedBox(height: AppSpacing.medium),
                Divider(),
                appSizedBox(height: AppSpacing.medium),
                SizedBox(height: 60, child: Image.asset('assets/image/google.png')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView(children: [_logo(), _form()]));
  }

  @override
  void dispose() {
    super.dispose();
  }
}
