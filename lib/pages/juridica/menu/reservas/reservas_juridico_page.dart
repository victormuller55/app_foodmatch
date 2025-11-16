import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/pages/juridica/menu/menu_page.dart';
import 'package:flutter/material.dart';
import 'package:muller_package/app_components/app_scaffold.dart';

class ReservasJuridicoPage extends StatefulWidget {
  const ReservasJuridicoPage({super.key});

  @override
  State<ReservasJuridicoPage> createState() => _ReservasJuridicoPageState();
}

class _ReservasJuridicoPageState extends State<ReservasJuridicoPage> {
  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: 'Reservas',
      body: Container(),
      drawerColor: Colors.white,
      appBarGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [FMColors.primary, FMColors.secondary],
      ),
      drawer: drawerJuridico(),
    );
  }
}
