import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

class CorpoMenu extends StatefulWidget {
  const CorpoMenu({super.key});

  @override
  State<CorpoMenu> createState() => _CorpoMenuState();
}

class _CorpoMenuState extends State<CorpoMenu> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          SizedBox(
            height: 160,
            width: .infinity,
            child: DrawerHeader(
              decoration: BoxDecoration(
                color: AppCores.violetaClaro,
                border: Border(bottom: BorderSide(color: AppCores.preto)),
              ),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AppImagens.logo),
                    SizedBox(width: 20),
                    Text(AppTextos.festaComAlegria, style: TextStyle(fontSize: AppTipografias.h6)),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SearchBar(
              //TODO: Ajustar busca de pedidos
              side: WidgetStatePropertyAll(BorderSide(color: AppCores.preto)),
              backgroundColor: WidgetStateProperty.all(AppCores.branco),
              leading: SvgPicture.asset(AppIcones.pesquisar, width: 30),
              hintText: AppTextos.pesquisarPedidos,
              elevation: WidgetStatePropertyAll(0),
              hintStyle: WidgetStatePropertyAll(
                TextStyle(fontSize: AppTipografias.h5, color: AppCores.cinzaAtivo),
              ),
            ),
          ),
          SizedBox(height: 20),
          ListTile(
            onTap: () => context.goNamed('ajustes'),
            title: Text(AppTextos.ajustes, style: TextStyle(fontSize: AppTipografias.h5)),
            trailing: SvgPicture.asset(AppIcones.ajustes, width: 30),
          ),
          SizedBox(height: 30),
          ListTile(
            onTap: () => context.goNamed('galeria'),
            title: Text(AppTextos.galeria, style: TextStyle(fontSize: AppTipografias.h5)),
            trailing: SvgPicture.asset(AppIcones.galeria, width: 30),
          ),
          SizedBox(height: 30),
          ListTile(
            onTap: () => context.goNamed('notificacoes'),
            title: Text(AppTextos.notificacoes, style: TextStyle(fontSize: AppTipografias.h5)),
            trailing: SvgPicture.asset(AppIcones.notificacoes, width: 30),
          ),
          SizedBox(height: 30),
          ListTile(
            onTap: () => launchUrl(
              Uri.parse('https://www.instagram.com/festa_com_alegria/'),
              mode: LaunchMode.externalApplication,
            ),
            title: Text(AppTextos.instagram, style: TextStyle(fontSize: AppTipografias.h5)),
            trailing: SvgPicture.asset(AppIcones.instagram, width: 30),
          ),
        ],
      ),
    );
  }
}
