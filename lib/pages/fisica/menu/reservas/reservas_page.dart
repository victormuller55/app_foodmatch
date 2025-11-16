import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/model/reserva_model.dart';
import 'package:app_foodmatch/pages/fisica/menu/menu_page.dart';
import 'package:app_foodmatch/pages/fisica/menu/reservas/reservas_bloc.dart';
import 'package:app_foodmatch/pages/fisica/menu/reservas/reservas_event.dart';
import 'package:app_foodmatch/pages/fisica/menu/reservas/reservas_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class ReservasPage extends StatefulWidget {
  const ReservasPage({super.key});

  @override
  State<ReservasPage> createState() => _ReservasPageState();
}

class _ReservasPageState extends State<ReservasPage> {
  ReservaBloc reservaBloc = ReservaBloc();

  @override
  void initState() {
    reservaBloc.add(ReservaLoadEvent());
    super.initState();
  }

  void _marcarRetirada(int id) {
    reservaBloc.add(ReservaPutEvent(id: id));
  }

  String formatarData(String data) {
    try {
      final date = DateTime.parse(data);
      return "${date.day.toString().padLeft(2, '0')}/"
          "${date.month.toString().padLeft(2, '0')}/"
          "${date.year}";
    } catch (e) {
      return data;
    }
  }

  Widget _bodyModal(ReservaModel reserva) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          appText(
            'Você ja retirou essa reserva?'.toUpperCase(),
            bold: true,
            fontSize: 20,
          ),
          Divider(),
          appSizedBox(height: 10),
          appElevatedButtonTextGradient(
            'Sim'.toUpperCase(),
            width: double.infinity,
            height: 50,
            function: () => _marcarRetirada(reserva.idReserva!),
            gradient: LinearGradient(
              colors: [FMColors.primary, FMColors.secondary],
            ),
          ),
          appSizedBox(height: 10),
          appElevatedButtonText(
            'Não'.toUpperCase(),
            width: MediaQuery.of(context).size.width,
            height: 50,
            textColor: FMColors.primary,
            borderColor: FMColors.primary,
            color: Colors.transparent,
            function: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _item(ReservaModel reserva) {
    return appContainer(
      width: double.infinity,
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
      radius: BorderRadius.circular(10),
      backgroundColor: AppColors.white,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: appContainer(
              height: 60,
              width: 60,
              radius: BorderRadius.circular(10),
              backgroundColor: Colors.grey.shade300,
              child: Icon(Icons.store),
            ),
            title: appText(
              reserva.doacao!.empresa!.nomeFantasia!,
              bold: true,
              fontSize: 20,
            ),
            subtitle: appText(
              "Quem irá retirar: ${reserva.usuario!.pessoa!.nome!}\n"
              "Dia: ${formatarData(reserva.dataRetirada!)}\n"
              "Hora: ${reserva.horaRetirada!}\n"
              "Local: ${reserva.doacao!.empresa!.endereco!}\n",
            ),
          ),
          appContainer(
            width: double.infinity,
            radius: BorderRadius.circular(30),
            padding: EdgeInsets.only(top: 12, bottom: 12),
            backgroundColor: Colors.grey.shade200,
            child: Center(child: appText(reserva.doacao!.descricao!)),
          ),
          appSizedBox(height: 10),
          if (reserva.retirado!)
            SizedBox(
              height: 50,
              width: double.infinity,
              child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle),
                  appSizedBox(width: 10),
                  appText('RESERVA RETIRADA', bold: true),
                ],
              )),
            ),
          if (!reserva.retirado!)
            appElevatedButtonText(
              'Marcar como retirado',
              function: () => showModalEmpty(
                context,
                child: _bodyModal(reserva),
                initialHeight: 0.3,
                minHeight: 0.3,
              ),
              borderColor: FMColors.primary,
              textColor: FMColors.primary,
              width: MediaQuery.of(context).size.width,
              height: 50,
            ),
        ],
      ),
    );
  }

  Widget _body(List<ReservaModel> reservas) {
    List<Widget> items = [];

    for (ReservaModel reserva in reservas) {
      if (reserva.doacao!.quantidade! > 0) items.add(_item(reserva));
    }

    if (items.isEmpty) {
      return Center(child: appText('Nenhuma reserva encontrada'));
    }

    return ListView(children: items);
  }
  Widget _bodyBuilder() {
    return BlocBuilder<ReservaBloc, ReservaState>(
      bloc: reservaBloc,
      builder: (context, state) {
        if (state is ReservaLoadingState) {
          return appLoading(
            child: CircularProgressIndicator(color: FMColors.primary),
          );
        }

        return RefreshIndicator(
          onRefresh: () async {
            reservaBloc.add(ReservaLoadEvent());
          },
          // Cores do círculo do pull-to-refresh
          color: FMColors.primary,
          backgroundColor: FMColors.secondary,
          child: _body(state.reservas),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: "Minhas reservas",
      drawer: drawer(),
      drawerColor: Colors.white,
      appBarGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [FMColors.primary, FMColors.secondary],
      ),
      body: _bodyBuilder(),
    );
  }
}
