import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TopoBase extends StatelessWidget implements PreferredSizeWidget {
  const TopoBase({
    super.key,
    required this.titulo,
    this.aoPressionar,
    this.temBotao = false,
    this.iconeBotao = AppIcones.apagar,
  });

  final String titulo;
  final VoidCallback? aoPressionar;
  final bool? temBotao;
  final String iconeBotao;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: IconButton(
        icon: SvgPicture.asset(AppIcones.voltar),
        onPressed: () {
          context.goNamed('inicio');
        },
      ),
      title: Text(titulo, style: TextStyle(fontSize: AppTipografias.h3)),
      actions: [
        if (temBotao ?? true)
          IconButton(onPressed: aoPressionar, icon: SvgPicture.asset(iconeBotao)),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80);
}
