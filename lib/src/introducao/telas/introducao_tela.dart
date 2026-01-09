import 'dart:async';

import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/widgets%20globais/botao_retangular.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IntroducaoTela extends StatefulWidget {
  const IntroducaoTela({super.key});

  @override
  State<IntroducaoTela> createState() => _IntroducaoTelaState();
}

class _IntroducaoTelaState extends State<IntroducaoTela> {
  int _passo = 1;
  final String texto1 = AppTextos.ondeCadaMomento;
  final String texto2 = AppTextos.celebrandoSorrisos;
  final String texto3 = AppTextos.festaDoJeitinho;

  late PageController _pageController;
  late Timer _timer;
  final int _initialPage = 1000;

  final List<String> _imagens = [
    AppImagens.foto0,
    AppImagens.foto1,
    AppImagens.foto2,
    AppImagens.foto3,
    AppImagens.foto4,
    AppImagens.foto5,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.7, initialPage: _initialPage);
    _timer = Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _proximoPasso() {
    if (_passo < 3) {
      setState(() {
        _passo++;
      });
    } else {
      context.goNamed('inicio');
    }
  }

  String get _textoAtual {
    switch (_passo) {
      case 1:
        return texto1;
      case 2:
        return texto2;
      case 3:
        return texto3;
      default:
        return texto1;
    }
  }

  String get _textoBotao {
    return _passo == 3 ? AppTextos.irParaInicio : AppTextos.proximo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: .infinity,
        decoration: BoxDecoration(gradient: AppCores.introGradiente),
        child: Column(
          mainAxisAlignment: .center,
          children: [
            Expanded(flex: 2, child: SizedBox()),
            SizedBox(
              height: 350,
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) {
                  final int imageIndex = index % _imagens.length;
                  return AnimatedBuilder(
                    animation: _pageController,
                    builder: (context, child) {
                      double value = 1.0;
                      if (_pageController.position.haveDimensions) {
                        value = _pageController.page! - index;
                        value = (1 - (value.abs() * 0.3)).clamp(0.7, 1.0);
                      } else {
                        value = index == _initialPage ? 1.0 : 0.7;
                      }
                      return Center(
                        child: SizedBox(
                          height: Curves.easeOut.transform(value) * 350,
                          width: Curves.easeOut.transform(value) * 350,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .2),
                            offset: const Offset(0, 3),
                            spreadRadius: 2,
                            blurRadius: 5,
                          ),
                        ],
                        color: AppCores.branco,
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(_imagens[imageIndex], fit: BoxFit.cover),
                      ),
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: Text(
                  _textoAtual,
                  key: ValueKey<int>(_passo),
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 32, color: AppCores.branco),
                ),
              ),
            ),
            Expanded(flex: 2, child: SizedBox()),
            BotaoRetangular(texto: _textoBotao, aoPressionar: _proximoPasso, largura: 320),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
