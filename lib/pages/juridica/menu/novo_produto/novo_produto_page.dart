import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_bloc.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_event.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muller_package/app_components/app_container.dart';
import 'package:muller_package/app_components/app_elevated_button.dart';
import 'package:muller_package/app_components/app_scaffold.dart';
import 'package:muller_package/app_components/app_sized_box.dart';
import 'package:muller_package/app_components/app_text.dart';
import 'package:muller_package/app_components/form_field/app_form_field.dart';
import 'package:muller_package/app_consts/app_colors.dart';
import 'package:muller_package/app_consts/app_form_formatter.dart';
import 'package:muller_package/functions/util.dart';

class NovoProdutoPage extends StatefulWidget {
  final HomeJuridicoBloc bloc;
  const NovoProdutoPage({super.key, required this.bloc});

  @override
  State<NovoProdutoPage> createState() => _NovoProdutoPageState();
}

class _NovoProdutoPageState extends State<NovoProdutoPage> {

  late AppFormField _descricaoForm;
  late AppFormField _quantidadeForm;
  late AppFormField _dataValidadeForm;
  late AppFormField _localForm;

  String formatarData(String dataBr) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');
    final dateTime = inputFormat.parse(dataBr);
    return outputFormat.format(dateTime);
  }

  String converterData(String data) {
    final partes = data.split('/');

    final dia = int.parse(partes[0]);
    final mes = int.parse(partes[1]);
    final ano = int.parse(partes[2]);

    final dateTime = DateTime(ano, mes, dia, 18, 0, 0);

    // Retorna no formato correto
    return dateTime.toIso8601String();
  }

  void _save() {

    DoacaoModel doacaoModel = DoacaoModel(
      descricao: _descricaoForm.controller.text,
      quantidade: int.parse(_quantidadeForm.controller.text),
      dataValidade: formatarData(_dataValidadeForm.controller.text),
      dataDisponivel:  converterData(_dataValidadeForm.controller.text),
      localizacao: _localForm.controller.text,
      status: 'PENDENTE',
    );

    widget.bloc.add(HomeJuridicoSaveDoacoesEvent(doacaoModel: doacaoModel));
    Navigator.pop(context);
  }

  @override
  void initState() {
    _descricaoForm = AppFormField(
      context: context,
      icon: Icon(Icons.fastfood_rounded),
      hint: 'Digite a Descrição',
      backgroundColor: AppColors.white,
      hintColor: AppColors.grey600,
      validator: (value) => validateEmpty(value),
    );

    _quantidadeForm = AppFormField(
      context: context,
      icon: Icon(Icons.numbers_outlined),
      hint: 'Digite a quantidade',
      backgroundColor: AppColors.white,
      hintColor: AppColors.grey600,
      textInputType: TextInputType.number,
      validator: (value) => validateEmpty(value),
    );

    _dataValidadeForm = AppFormField(
      context: context,
      icon: Icon(Icons.date_range),
      hint: 'Digite a data de validade',
      backgroundColor: AppColors.white,
      hintColor: AppColors.grey600,
      validator: (value) => validateEmpty(value),
      textInputType: TextInputType.datetime,
      textInputFormatter: AppFormFormatters.dateFormatter,
    );

    _localForm = AppFormField(
      context: context,
      icon: Icon(Icons.location_pin),
      hint: 'Digite o local de retirada',
      backgroundColor: AppColors.white,
      hintColor: AppColors.grey600,
      validator: (value) => validateEmpty(value),
    );

    super.initState();
  }

  Widget _body() {
    return ListView(
      padding: EdgeInsets.all(20),
      children: [
        appContainer(
          backgroundColor: Colors.black87,
          width: double.infinity,
          padding: EdgeInsets.all(10),
          radius: BorderRadius.circular(20),
          child: appText(
            'Preencha os campos abaixo para cadastrar uma nova doação. '
            'Informe a descrição do produto, a quantidade disponível, a data de validade '
            'e o local onde a doação poderá ser retirada.',
            textAlign: TextAlign.center,
            color: Colors.white,
          ),
        ),
        appSizedBox(height: 10),
        _descricaoForm.formulario,
        _quantidadeForm.formulario,
        _dataValidadeForm.formulario,
        _localForm.formulario,
        appSizedBox(height: 10),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: 'Nova doação',
      body: _body(),
      drawerColor: Colors.white,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30, left: 20, right: 20),
        child: appElevatedButtonTextGradient(
          'Salvar'.toUpperCase(),
          function: () => _save(),
          gradient: LinearGradient(
            colors: [FMColors.primary, FMColors.secondary],
          ),
        ),
      ),
      appBarGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [FMColors.primary, FMColors.secondary],
      ),
    );
  }
}
