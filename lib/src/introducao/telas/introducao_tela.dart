import 'package:festa_com_alegria/src/widgets/botao_retangular.dart';
import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:flutter/material.dart';

class IntroducaoTela extends StatefulWidget {
  const IntroducaoTela({super.key});

  @override
  State<IntroducaoTela> createState() => _IntroducaoTelaState();
}

class _IntroducaoTelaState extends State<IntroducaoTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: .infinity,
        decoration: BoxDecoration(gradient: AppCores.introGradiente),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            const Text('Onde cada momento vira lembrança feliz.'),
            BotaoRetangular(texto: 'Próximo', onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
