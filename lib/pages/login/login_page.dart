import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_page.dart';
import 'package:app_foodmatch/pages/login/login_bloc.dart';
import 'package:app_foodmatch/pages/login/login_event.dart';
import 'package:app_foodmatch/pages/login/login_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final LoginBloc _bloc = LoginBloc();
  final _formKey = GlobalKey<FormState>();

  late AppFormField emailForm;
  late AppFormField passwordForm;

  bool inverted = false;

  void _save() {
    if (_formKey.currentState!.validate()) {
      _bloc.add(
        LoginLoginEvent(
          email: emailForm.controller.text,
          password: passwordForm.controller.text,
        ),
      );
    }
  }

  @override
  void initState() {
    emailForm = AppFormField(
      context: context,
      icon: Icon(Icons.email),
      hint: 'Digite seu e-mail',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
      // validator: (value) => validateEmail(value),
    );

    passwordForm = AppFormField(
      context: context,
      icon: Icon(Icons.lock),
      hint: 'Digite sua senha',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
      validator: (value) => validateEmpty(value),
      showContent: false,
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
              height: MediaQuery.of(context).size.height * 0.3,
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
                padding: const EdgeInsets.only(top: 100, left: 60, right: 60),
                child: Image.asset('assets/images/foodmatch.png'),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget googleButton(VoidCallback onPressed) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(40),
      child: InkWell(
        borderRadius: BorderRadius.circular(40),
        onTap: onPressed,
        splashColor: Colors.grey.withValues(alpha: 0.2),
        highlightColor: Colors.grey.withValues(alpha: 0.1),
        child: appContainer(
          height: 50,
          radius: BorderRadius.circular(40),
          border: Border.all(color: Colors.grey.shade500),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/google.png', height: 24),
              const SizedBox(width: 12),
              appText('Entrar com Google'),
            ],
          ),
        ),
      ),
    );
  }


  Widget _form() {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            appSizedBox(height: AppSpacing.big),
            emailForm.formulario,
            passwordForm.formulario,
            appSizedBox(height: AppSpacing.medium),
            appElevatedButtonTextGradient(
              'Entrar'.toUpperCase(),
              height: 50,
              width: double.infinity,
              function: () => _save(),
              gradient: LinearGradient(
                colors: [FMColors.secondary, FMColors.primary],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            appSizedBox(height: AppSpacing.normal),
            appTextButton(text:'Não tenho conta', onTap: () => open(screen: CadastroPage()), color: FMColors.primary),
            Hero(
              tag: 'google',
              child: Column(
                children: [
                  Divider(),
                  appSizedBox(height: AppSpacing.medium),
                  googleButton(() => {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return ListView(children: [_logo(), _form()]);
  }

  Widget _bodyBuilder() {
    return BlocBuilder<LoginBloc, LoginState>(
      bloc: _bloc,
      builder: (context, state) {
        if (state is LoginLoadingState) {
          return appLoading(child: CircularProgressIndicator());
        }

        return _body();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _bodyBuilder());
  }

  @override
  void dispose() {
    super.dispose();
  }
}
