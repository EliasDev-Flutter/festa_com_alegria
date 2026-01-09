import 'package:festa_com_alegria/src/inicio/widgets/notificacao_personalizada_widget.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_sons.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
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
              iconeBotao: AppIcones.limparNotificacoes,
              titulo: AppTextos.notificacoes,
              temBotao: true,
              aoPressionar: () async {
                await AppSons.tocarExcluir();
                setState(() {
                  semNotificacoes = true;
                });
              },
            ),
      body: semNotificacoes
          ? Center(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(AppTextos.semNotificacao, style: TextStyle(fontSize: AppTipografias.h4)),
                  SizedBox(height: 20),
                  GestureDetector(
                    onTap: () {
                      //TODO: remover após criar tela de pedidos
                      setState(() {
                        semNotificacoes = false;
                      });
                    },
                    child: Image.asset(AppImagens.semNotificacoes),
                  ),
                  SizedBox(height: 180),
                ],
              ),
            )
          : SingleChildScrollView(
              physics: ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    width: .infinity,
                    child: ListView.separated(
                      separatorBuilder: (context, index) => SizedBox(),
                      physics: NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: 5,
                      itemBuilder: (context, index) => NotificacaoPersonalizadaWidget(
                        tema: 'Tema $index',
                        data: '04/01/2025',
                        diasPassados: '2 dias',
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
