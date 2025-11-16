import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_bloc.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_event.dart';
import 'package:app_foodmatch/pages/cadastro/cadastro_state.dart';
import 'package:app_foodmatch/widgets/snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';
import 'package:flutter/material.dart';

class CadastroConcluirPage extends StatefulWidget {
  final UsuarioModel usuarioModel;
  const CadastroConcluirPage({super.key, required this.usuarioModel});

  @override
  State<CadastroConcluirPage> createState() => _CadastroConcluirPageState();
}

class _CadastroConcluirPageState extends State<CadastroConcluirPage> {

  final PageController _pageController = PageController();
  final CadastroBloc _bloc = CadastroBloc();

  final _formKeyTelefone = GlobalKey<FormState>();
  final _formKeyEndereco = GlobalKey<FormState>();
  final _formKeyDocumento = GlobalKey<FormState>();

  late AppFormField _telefoneForm;
  late AppFormField _enderecoForm;
  late AppFormField _documentoForm;

  int _currentPage = 0;

  String? _selected;

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _save() {

    if(_selected!.toLowerCase() == 'pessoa') {
      widget.usuarioModel.tipo = 'FISICO';
      widget.usuarioModel.pessoa!.endereco = _enderecoForm.controller.text;
      widget.usuarioModel.pessoa!.cpf = _documentoForm.controller.text;
      widget.usuarioModel.empresa = null;
    } else {
      widget.usuarioModel.tipo = 'JURIDICO';
      widget.usuarioModel.empresa!.endereco = _enderecoForm.controller.text;
      widget.usuarioModel.empresa!.cnpj = _documentoForm.controller.text;
      widget.usuarioModel.pessoa = null;
    }

    DateTime agora = DateTime.now();

    String dataFormatada = agora.toIso8601String().split('.').first;

    widget.usuarioModel.dataCriacao = dataFormatada;
    widget.usuarioModel.status = 'ATIVO';
    widget.usuarioModel.telefone = _telefoneForm.controller.text;
    _bloc.add(CadastroSalvarEvent(widget.usuarioModel));
  }

  void _onChangePage() {

    if (_currentPage == 0) {
      if (_selected == null) {
        showSnackbar('Escolha uma opção para continuar');
        return;
      }
      _nextPage();
      return;
    }

    if (_pageController.page == 3) {
      _save();
      return;
    }

    final isValid = [
      _formKeyTelefone,
      _formKeyEndereco,
      _formKeyDocumento,
    ][_currentPage - 1].currentState?.validate() ?? false;

    if (isValid) {
      _nextPage();
    } else {
      showSnackbar('Preencha o campo antes de continuar!');
    }
  }

  String? validatorEmpty(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo obrigatório';
    }
    return null;
  }

  @override
  void initState() {

    _telefoneForm = AppFormField(
      context: context,
      hint: "Digite seu telefone",
      hintColor: AppColors.grey600,
      inputColor: AppColors.grey800,
      borderColor: FMColors.primary,
      backgroundColor: AppColors.transparent,
      underline: true,
      textInputType: TextInputType.phone,
      fontSize: AppFontSizes.medium,
      radius: 0,
      textInputFormatter: AppFormFormatters.phoneFormatter,
      validator: (value) => validatorEmpty(value),
    );

    _enderecoForm = AppFormField(
      context: context,
      hint: "Digite seu endereço",
      hintColor: AppColors.grey600,
      inputColor: AppColors.grey800,
      borderColor: FMColors.primary,
      backgroundColor: AppColors.transparent,
      underline: true,
      textInputType: TextInputType.text,
      fontSize: AppFontSizes.medium,
      radius: 0,
      validator: (value) => validatorEmpty(value),
    );

    _documentoForm = AppFormField(
      context: context,
      hint: "Digite o n° documento",
      hintColor: AppColors.grey600,
      inputColor: AppColors.grey800,
      borderColor: FMColors.primary,
      backgroundColor: AppColors.transparent,
      underline: true,
      textInputType: TextInputType.number,
      fontSize: AppFontSizes.medium,
      radius: 0,
      validator: (value) => validatorEmpty(value),
    );

    super.initState();
  }

  Widget _logo() {
    return Padding(
      padding: EdgeInsets.only(top: AppSpacing.giant),
      child: Center(
        child: SizedBox(
          width: 350,
          child: Hero(
            tag: 'logo',
            child: Image.asset("assets/images/foodmatch_colored.png"),
          ),
        ),
      ),
    );
  }

  Widget _texts({
    required String title,
    required String subtitle,
    required String animation,
    required Widget form,
  }) {
    return Padding(
      padding: EdgeInsets.all(AppSpacing.medium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SizedBox(
              height: 200,
              child: appContainer(
                backgroundColor: AppColors.grey300,
                radius: BorderRadius.circular(360),
                child: appAnimation(animation),
              ),
            ),
          ),
          appSizedBox(height: AppSpacing.big),
          appText(title, color: FMColors.primary, fontSize: 25, bold: true),
          appSizedBox(height: AppSpacing.normal),
          appText(
            subtitle,
            color: AppColors.grey800,
            fontSize: AppFontSizes.normal,
          ),
          appSizedBox(height: AppSpacing.medium),
          form,
        ],
      ),
    );
  }

  Widget _itens({
    required String title,
    required String subtitle,
    required String animation,
    required Widget form,
    required GlobalKey<FormState> formKey,
  }) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.normal),
        child: Form(
          key: formKey,
          child: _texts(
            title: title,
            subtitle: subtitle,
            animation: animation,
            form: form,
          ),
        ),
      ),
    );
  }

  Widget _button({required String text, required IconData icon}) {

    final bool isSelected = _selected == text;

    return GestureDetector(
      onTap: () => setState(() => _selected = text),
      child: TweenAnimationBuilder<double>(
        tween: Tween<double>(begin: 0, end: isSelected ? 1 : 0),
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return appContainer(
            height: 120,
            width: 150,
            radius: BorderRadius.circular(AppRadius.big),
            gradient: LinearGradient(
              colors: [
                FMColors.primary.withValues(alpha: value),
                FMColors.secondary.withValues(alpha: value),
              ],
            ),
            border: Border.all(color: FMColors.primary, width: 2),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isSelected ? AppColors.white : FMColors.primary,
                  size: 50,
                ),
                appText(
                  text.toUpperCase(),
                  bold: true,
                  color: isSelected ? AppColors.white : FMColors.primary,
                  fontSize: AppFontSizes.medium,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _tipoUsuario() {

    String message = 'Escolha uma opção para continuar';

    if (_selected != null) {
      if (_selected!.toLowerCase() == 'pessoa') {
        message = 'Você poderá encontrar comércios próximos que estão doando alimentos.';
      } else {
        message = 'Você irá cadastrar doações de alimentos para que pessoas possam buscá-los.';
      }
    }

    return Center(
      child: Column(
        children: [
          _logo(),
          appSizedBox(height: AppSpacing.medium),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: Divider(),
          ),
          appSizedBox(height: AppSpacing.medium),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: appText(
              'Seja bem-vindo ao FoodMatch!',
              color: AppColors.grey900,
              fontSize: AppFontSizes.medium,
              textAlign: TextAlign.center,
              bold: true,
            ),
          ),
          appSizedBox(height: AppSpacing.medium),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: AppSpacing.medium,
            children: [
              _button(text: 'Comercio', icon: Icons.store),
              _button(text: 'Pessoa', icon: Icons.person),
            ],
          ),
          appSizedBox(height: AppSpacing.medium),
          Padding(
            padding: const EdgeInsets.only(right: 40, left: 40),
            child: appText(
              message,
              color: AppColors.grey600,
              fontSize: AppFontSizes.normal,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  Widget _body() {
    return AppScrollVertical(
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.5,
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (index) => setState(() => _currentPage = index),
              children: [
                _tipoUsuario(),
                _itens(
                  title: 'Seu Telefone',
                  subtitle: 'Deixe um número de contato para que possamos conectar você às doações.',
                  animation: 'assets/animation/phone.json',
                  form: _telefoneForm.formulario,
                  formKey: _formKeyTelefone,
                ),
                _itens(
                  title: 'Seu endereço',
                  subtitle: 'Utilizamos seu endereço para encontrar doações perto de sua residencia.',
                  animation: 'assets/animation/location.json',
                  form: _enderecoForm.formulario,
                  formKey: _formKeyEndereco,
                ),
                _itens(
                  title: 'Qual seu CNPJ?',
                  subtitle: 'Fique tranquilo, os dados que pedimos são guardados todos com muita segurança.',
                  animation: 'assets/animation/identidade.json',
                  form: _documentoForm.formulario,
                  formKey: _formKeyDocumento,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomButton() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'button-conta',
            child: appElevatedButtonTextGradient(
              "Proximo".toUpperCase(),
              width: 200,
              height: 50,
              gradient: LinearGradient(
                colors: [FMColors.primary, FMColors.secondary],
              ),
              textColor: AppColors.white,
              function: () => _onChangePage(),
            ),
          ),
        ],
      ),
    );
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
    return scaffold(
      title: "",
      body: _bodyBuilder(),
      drawerColor: AppColors.grey900,
      appBarColor: AppColors.transparent,
      bottomNavigationBar: _bottomButton(),
    );
  }
}
