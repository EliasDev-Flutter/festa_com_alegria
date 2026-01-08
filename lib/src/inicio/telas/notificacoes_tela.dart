import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/widgets%20globais/topo_base.dart';
import 'package:flutter/material.dart';

class NotificacoesTela extends StatefulWidget {
  const NotificacoesTela({super.key});

  @override
  State<NotificacoesTela> createState() => _NotificacoesTelaState();
}

class _NotificacoesTelaState extends State<NotificacoesTela> {
  bool semNotificacoes = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: semNotificacoes
          ? TopoBase(titulo: AppTextos.notificacoes)
          : TopoBase(
              titulo: AppTextos.notificacoes,
              temBotao: true,
              iconeBotao: AppIcones.limparNotificacoes,
            ),
      body: Container(),
    );
  }
}
