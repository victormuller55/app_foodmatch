import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_bloc.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_event.dart';
import 'package:app_foodmatch/pages/fisica/menu/home/home_state.dart';
import 'package:app_foodmatch/pages/fisica/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:muller_package/app_components/app_container.dart';
import 'package:muller_package/app_components/app_dropdown.dart';
import 'package:muller_package/app_components/app_elevated_button.dart';
import 'package:muller_package/app_components/app_error.dart';
import 'package:muller_package/app_components/app_loading.dart';
import 'package:muller_package/app_components/app_modal.dart';
import 'package:muller_package/app_components/app_scaffold.dart';
import 'package:muller_package/app_components/app_sized_box.dart';
import 'package:muller_package/app_components/app_text.dart';
import 'package:muller_package/app_components/form_field/app_form_field.dart';
import 'package:muller_package/app_consts/app_colors.dart';
import 'package:muller_package/app_consts/app_form_formatter.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  HomeBloc homeBloc = HomeBloc();

  @override
  void initState() {
    homeBloc.add(HomeLoadDoacoesEvent());
    super.initState();
  }

  void _save({
    required DoacaoModel doacao,
    required String date,
    required String hour,
  }) {
    Navigator.pop(context);
    homeBloc.add(
      HomeSaveReservaEvent(doacaoModel: doacao, date: date, hour: hour),
    );
  }

  String formatarData(String dataBr) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final outputFormat = DateFormat('yyyy-MM-dd');

    final dateTime = inputFormat.parse(dataBr);
    return outputFormat.format(dateTime);
  }

  Widget _bodyModal(DoacaoModel doacao) {
    final AppDropdown dropdownHorarios = AppDropdown<String>(
      items: [
        '08:00',
        '09:00',
        '10:00',
        '11:00',
        '12:00',
        '13:00',
        '14:00',
        '15:00',
        '16:00',
        '17:00',
        '18:00',
        '19:00',
        '20:00',
      ],
      hint: 'Selecione a hora do resgate',
    );

    final AppFormField formField = AppFormField(
      context: context,
      hint: 'Digite a data de retirada',
      textInputFormatter: AppFormFormatters.dateFormatter,
      textInputType: TextInputType.datetime,
    );

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          appText(
            'Deseja reservar essa doação?'.toUpperCase(),
            bold: true,
            fontSize: 20,
          ),
          Divider(),
          appSizedBox(height: 10),
          _item(doacao),
          formField.formulario,
          dropdownHorarios.dropdown,
          appSizedBox(height: 20),
          appElevatedButtonTextGradient(
            'Reservar'.toUpperCase(),
            width: double.infinity,
            height: 50,
            function: () => _save(
              doacao: doacao,
              date: formatarData(formField.controller.text),
              hour: dropdownHorarios.selectedValue,
            ),
            gradient: LinearGradient(
              colors: [FMColors.primary, FMColors.secondary],
            ),
          ),
        ],
      ),
    );
  }

  String formatarData2(String data) {
    try {
      final date = DateTime.parse(data);
      return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    } catch (e) {
      return data;
    }
  }


  Widget _infoItem({
    required IconData icon,
    required String title,
    required String item,
  }) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Expanded(
          child: appText(
            "$title: $item",
            fontSize: 14,
            color: Colors.grey[700],
            overflow: true,
          ),
        ),
      ],
    );
  }

  Widget _item(DoacaoModel doacao, {bool? isModal}) {
    return GestureDetector(
      onTap: () => showModalEmpty(context, child: _bodyModal(doacao)),
      child: appContainer(
        radius: BorderRadius.circular(isModal ?? false ? 20 : 10),
        backgroundColor: Colors.white,
        margin: isModal == false ? const EdgeInsets.only(top: 10, left: 10, right: 10) : null,
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: FMColors.primary.withValues(alpha: 0.15),
              foregroundColor: FMColors.primary,
              child: const Icon(Icons.store, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                spacing: 3,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  appText(
                    doacao.descricao!,
                    bold: true,
                    fontSize: 16,
                    color: AppColors.grey700,
                    overflow: true,
                  ),
                  Divider(),
                  _infoItem(
                    icon: Icons.business,
                    title: 'Local',
                    item: doacao.empresa!.nomeFantasia!,
                  ),
                  _infoItem(
                    icon: Icons.shopping_bag,
                    title: 'Quantidade',
                    item: doacao.quantidade.toString(),
                  ),
                  _infoItem(
                    icon: Icons.event,
                    title: 'Validade',
                    item: formatarData2(doacao.dataValidade!),
                  ),
                  _infoItem(
                    icon: Icons.location_on,
                    title: 'Endereço',
                    item: doacao.localizacao!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(List<DoacaoModel> doacoes) {

    if(doacoes.isEmpty) {
      return Center(child: appText('Nenhuma doação encontrada.'));
    }


    return RefreshIndicator(
      backgroundColor: FMColors.secondary,
      color: FMColors.primary,
      onRefresh: () async {
        homeBloc.add(HomeLoadDoacoesEvent());
        await Future.delayed(Duration(milliseconds: 800));
      },
      child: ListView(
        physics: AlwaysScrollableScrollPhysics(),
        children: doacoes.map((e) => _item(e, isModal: false)).toList(),
      ),
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: homeBloc,
      builder: (context, state) {

        if (state is HomeLoadingState) {
          return appLoading(
            child: CircularProgressIndicator(color: FMColors.primary),
          );
        }

        if (state is HomeErrorState) {
          return appError(state.errorModel, function: () => homeBloc.add(HomeLoadDoacoesEvent()));
        }

        return _body(state.doacaoList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: "Menu",
      drawer: drawer(),
      drawerColor: Colors.white,
      appBarColor: Colors.blue,
      appBarGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [FMColors.primary, FMColors.secondary],
      ),
      body: _bodyBuilder(),
    );
  }
}
