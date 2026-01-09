import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class TopoInicio extends StatelessWidget implements PreferredSizeWidget {
  const TopoInicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .15),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Builder(
            builder: (context) {
              return IconButton(
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
                icon: Icon(Icons.menu, size: 45),
              );
            },
          ),
        ),
        leadingWidth: 60,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        bottom: PreferredSize(preferredSize: Size.fromHeight(17), child: SizedBox()),
        backgroundColor: AppCores.violetaClaro,
        actionsPadding: EdgeInsets.all(20),
        toolbarHeight: 85,
        title: Text('Olá, Lulu!', style: TextStyle(fontSize: 36)),
        actions: [
          //TODO: Ajustar badge de acordo com notificacao visualizada
          Badge(
            smallSize: 12,
            backgroundColor: AppCores.vermelho,
            child: GestureDetector(
              onTap: () => context.goNamed('notificacoes'),
              child: SvgPicture.asset(AppIcones.notificacoes, width: 40, height: 40),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(107);
}
