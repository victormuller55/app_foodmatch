import 'package:app_foodmatch/app_widget/app_colors.dart';
import 'package:app_foodmatch/app_widget/local_storage.dart';
import 'package:app_foodmatch/model/doacao_model.dart';
import 'package:app_foodmatch/model/usuario_model.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_bloc.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_event.dart';
import 'package:app_foodmatch/pages/juridica/menu/home/home_juridico_state.dart';
import 'package:app_foodmatch/pages/juridica/menu/menu_page.dart';
import 'package:app_foodmatch/pages/juridica/menu/novo_produto/novo_produto_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muller_package/muller_package.dart';

class HomeJuridicoPage extends StatefulWidget {
  const HomeJuridicoPage({super.key});

  @override
  State<HomeJuridicoPage> createState() => _HomeJuridicoPageState();
}

class _HomeJuridicoPageState extends State<HomeJuridicoPage> {
  HomeJuridicoBloc bloc = HomeJuridicoBloc();

  @override
  void initState() {
    bloc.add(HomeJuridicoLoadDoacoesEvent());
    super.initState();
  }

  Widget _infoEmpresa(UsuarioModel user) {
    return appContainer(
      width: double.infinity,
      backgroundColor: AppColors.white,
      radius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(radius: 30, child: Icon(Icons.store)),
            title: appText(
              user.empresa!.nomeFantasia!,
              bold: true,
              fontSize: 20,
            ),
            subtitle: appText(
              user.empresa!.cnpj!,
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
          Divider(),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: appText(
              "Endereço: ${user.empresa!.endereco!}",
              color: Colors.grey,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _usuarioNaoEncontrado() {
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

  Widget _loadingInfoEmpresa() {
    return appContainer(
      radius: BorderRadius.circular(20),
      padding: const EdgeInsets.all(10),
      backgroundColor: AppColors.white,
      height: 100,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _header() {
    return FutureBuilder<UsuarioModel>(
      future: getLocalUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _loadingInfoEmpresa();
        }

        if (!snapshot.hasData) {
          return _usuarioNaoEncontrado();
        }

        return _infoEmpresa(snapshot.data!);
      },
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

  Widget _meusProdutos(List<DoacaoModel> list) {
    if (list.isEmpty) {
      return SizedBox(
        height: 100,
        width: double.infinity,
        child: Center(child: appText('Nenhum item encontrado')),
      );
    }

    return Column(children: list.map((e) => _item(e)).toList());
  }

  Widget _item(DoacaoModel doacao) {
    return GestureDetector(
      onLongPress: () => {},
      child: appContainer(
        radius: BorderRadius.circular(20),
        backgroundColor: Colors.white,
        margin: EdgeInsets.only(bottom: 5),
        padding: EdgeInsets.all(10),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: FMColors.primary.withValues(alpha: 0.15),
              foregroundColor: FMColors.primary,
              child: const Icon(Icons.fastfood_sharp, size: 28),
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
                    icon: Icons.shopping_bag,
                    title: 'Quantidade',
                    item: doacao.quantidade.toString(),
                  ),
                  _infoItem(
                    icon: Icons.event,
                    title: 'Validade',
                    item: formatarData2(doacao.dataValidade!),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _body(List<DoacaoModel> list) {
    return ListView(
      padding: EdgeInsets.all(10),
      children: [
        _header(),
        appSizedBox(height: 20),
        Center(child: appText('Meus Produtos', fontSize: 17, bold: true)),
        appSizedBox(height: 10),
        _meusProdutos(list),
      ],
    );
  }

  Widget _bodyBuilder() {
    return BlocBuilder<HomeJuridicoBloc, HomeJuridicoState>(
      bloc: bloc,
      builder: (context, state) {
        if (state is HomeJuridicoLoadingState) {
          return appLoading(
            child: CircularProgressIndicator(color: FMColors.primary),
          );
        }

        if (state is HomeJuridicoErrorState) {
          return appError(
            state.errorModel,
            function: () => bloc.add(HomeJuridicoLoadDoacoesEvent()),
          );
        }

        return _body(state.doacaoList);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return scaffold(
      title: 'Doações',
      body: _bodyBuilder(),
      drawer: drawerJuridico(),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => open(screen: NovoProdutoPage(bloc: bloc)),
        backgroundColor: FMColors.secondary,
        label: Row(
          children: [
            Icon(Icons.add, color: AppColors.black),
            appSizedBox(width: 10),
            appText('Nova Doação'.toUpperCase(), bold: true),
          ],
        ),
      ),
      drawerColor: Colors.white,
      appBarGradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [FMColors.primary, FMColors.secondary],
      ),
    );
  }
}
