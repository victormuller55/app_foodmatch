import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/model/pessoa_model.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_bloc.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_concluir.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_event.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_state.dart';
import 'package:app_foodmatch/pages/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({super.key});

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {

  final CadastroBloc _bloc = CadastroBloc();
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

      pessoaModel.nome = _nomeForm.controller.text;
      pessoaModel.cpf = '';

      usuarioModel.email = _emailForm.controller.text;
      usuarioModel.senha = _senhaForm.controller.text;
      usuarioModel.telefone = '';
      usuarioModel.tipo = 'FISICO';
      usuarioModel.pessoa = pessoaModel;
      usuarioModel.status = 'ATIVO';

      _bloc.add(CadastroSalvarEvent(usuarioModel));
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
    );

    _emailForm = AppFormField(
      context: context,
      icon: Icon(Icons.email),
      hint: 'Digite seu e-mail',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
    );

    _senhaForm = AppFormField(
      context: context,
      icon: Icon(Icons.lock),
      hint: 'Digite sua senha',
      backgroundColor: AppColors.grey200,
      hintColor: AppColors.grey600,
    );

    _confirmarSenhaForm = AppFormField(
      context: context,
      icon: Icon(Icons.lock),
      hint: 'Confirme sua senha',
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
              height: 300,
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
              function: () => open(screen: CadastroConcluirPage()),
              gradient: LinearGradient(
                colors: [FMColors.secondary, FMColors.primary],
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
              ),
            ),
            appSizedBox(height: AppSpacing.normal),
            appElevatedButtonText(
              'Já tenho conta'.toUpperCase(),
              height: 50,
              width: MediaQuery.of(context).size.width,
              function: () => open(screen: LoginPage()),
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
                  SizedBox(
                    height: 60,
                    child: Image.asset('assets/image/google.png'),
                  ),
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
    return BlocBuilder<CadastroBloc, CadastroState>(
      bloc: _bloc,
      builder: (context, state) {

        if(state is CadastroLoadingState) {
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
