import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/model/empresa_model.dart';
import 'package:app_foodmatch/model/pessoa_model.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_concluir.dart';
import 'package:app_foodmatch/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/muller_package.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  final _formKey = GlobalKey<FormState>();

  late AppFormField _nomeForm;
  late AppFormField _emailForm;
  late AppFormField _senhaForm;
  late AppFormField _confirmarSenhaForm;

  bool inverted = false;

  bool _validForm() {
    return _formKey.currentState!.validate();
  }

  void _save() {
    if (_validForm()) {
      UsuarioModel usuarioModel = UsuarioModel();
      PessoaModel pessoaModel = PessoaModel();
      EmpresaModel empresaModel = EmpresaModel();

      empresaModel.nomeFantasia = _nomeForm.controller.text;
      empresaModel.razaoSocial = _nomeForm.controller.text;
      pessoaModel.nome = _nomeForm.controller.text;
      usuarioModel.email = _emailForm.controller.text;
      usuarioModel.senha = _senhaForm.controller.text;

      usuarioModel.pessoa = pessoaModel;
      usuarioModel.empresa = empresaModel;

      open(screen: CadastroConcluirPage(usuarioModel: usuarioModel));
    }
  }

  @override
  void initState() {
    _nomeForm = AppFormField(
      context: context,
      icon: Icon(Icons.person),
      hint: 'Digite seu Nome',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
      validator: (value) => validateEmpty(value),
    );

    _emailForm = AppFormField(
      context: context,
      icon: Icon(Icons.email),
      hint: 'Digite seu e-mail',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
      // validator: (value) => validateEmail(value),
    );

    _senhaForm = AppFormField(
      context: context,
      icon: Icon(Icons.lock),
      hint: 'Digite sua senha',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
      validator: (value) => validateEmpty(value),
      showContent: false,
    );

    _confirmarSenhaForm = AppFormField(
      context: context,
      icon: Icon(Icons.lock),
      hint: 'Confirme sua senha',
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
              height: MediaQuery.of(context).size.height * 0.22,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(AppRadius.big),
                  bottomRight: Radius.circular(AppRadius.big),
                ),
                gradient: LinearGradient(
                  colors: [FMColors.primary, FMColors.secondary],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.05,
                  left: 60,
                  right: 60,
                ),
                child: Image.asset('assets/images/foodmatch.png', width: 70),
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
            appSizedBox(height: AppSpacing.normal),
            _nomeForm.formulario,
            _emailForm.formulario,
            _senhaForm.formulario,
            _confirmarSenhaForm.formulario,
            appSizedBox(height: AppSpacing.medium),
            appElevatedButtonTextGradient(
              'Criar Conta'.toUpperCase(),
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
            appTextButton(
              text: 'Já tenho conta',
              onTap: () => open(screen: LoginPage()),
              color: FMColors.primary,
            ),
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

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: 'Cadastro',
      size: 0,
      appBarGradient: LinearGradient(
        colors: [FMColors.primary, FMColors.secondary],
        begin: Alignment.centerLeft,
        end: Alignment.centerRight,
      ),
      background: Colors.white,
      body: _body(),
    );
  }
}
