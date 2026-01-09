import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/widgets%20globais/botao_retangular.dart';
import 'package:flutter/material.dart';

class RodapeBotaoRetangular extends StatelessWidget {
  const RodapeBotaoRetangular({super.key, required this.titulo, required this.funcaoBotao});

  final String titulo;
  final VoidCallback funcaoBotao;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 90,
      padding: EdgeInsets.only(bottom: 40),
      color: AppCores.transparente,
      child: BotaoRetangular(texto: titulo, aoPressionar: funcaoBotao, largura: 320),
    );
  }
}
