import 'dart:async';
import 'dart:io';
import 'dart:ui' as ui;

import 'package:festa_com_alegria/src/inicio/widgets/corpo_menu.dart';
import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:festa_com_alegria/widgets%20globais/topo_inicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CorpoInicio extends StatefulWidget {
  const CorpoInicio({super.key});

  @override
  State<CorpoInicio> createState() => _CorpoInicioState();
}

class _CorpoInicioState extends State<CorpoInicio> {
  late PageController _pageController;
  Timer? _timer;
  Timer? _resumeTimer;
  final int _initialPage = 1000;
  int _paginaAtual = 0;
  List<String> _favoritos = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarFavoritos();
    _pageController = PageController(viewportFraction: 1.0, initialPage: _initialPage);
    _startAutoScroll();
  }

  Future<void> _carregarFavoritos() async {
    final prefs = await SharedPreferences.getInstance();
    final favs = prefs.getStringList('favoritos_inicio') ?? [];
    if (favs.isEmpty) {
      _favoritos = [
        AppImagens.foto0,
        AppImagens.foto1,
        AppImagens.foto2,
        AppImagens.foto3,
        AppImagens.foto4,
        AppImagens.foto5,
      ];
    } else {
      _favoritos = favs;
    }
    if (mounted) {
      setState(() {
        _carregando = false;
      });
    }
  }

  @override
  void dispose() {
    _resumeTimer?.cancel();
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  void _startAutoScroll() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
      if (_pageController.hasClients) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 1200),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _pauseAutoScrollAndScheduleResume() {
    _timer?.cancel();
    _resumeTimer?.cancel();
    _resumeTimer = Timer(const Duration(seconds: 10), _startAutoScroll);
  }

  bool _visivel = true;

  Widget _valorBorrado(String texto, TextStyle estilo, {Color? fill}) {
    if (_visivel) {
      return Text(texto, style: estilo);
    }
    return ClipRRect(
      child: ImageFiltered(
        imageFilter: ui.ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: Container(
          color: fill ?? AppCores.violetaClaroAtivo,
          child: Text(texto, style: estilo),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CorpoMenu(),
      appBar: TopoInicio(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: .start,
          children: [
            Text(AppTextos.favoritos, style: TextStyle(fontSize: 28.0)),
            NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollStartNotification ||
                    notification is ScrollUpdateNotification ||
                    notification is UserScrollNotification) {
                  _pauseAutoScrollAndScheduleResume();
                }
                return false;
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height * .2,
                child: _carregando
                    ? const Center(child: CircularProgressIndicator())
                    : PageView.builder(
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        controller: _pageController,
                        onPageChanged: (index) =>
                            setState(() => _paginaAtual = index % _favoritos.length),
                        itemBuilder: (context, index) {
                          if (_favoritos.isEmpty) return const SizedBox();
                          final int imageIndex = index % _favoritos.length;
                          return AnimatedBuilder(
                            animation: _pageController,
                            builder: (context, child) {
                              double value = 1.0;
                              if (_pageController.position.haveDimensions) {
                                value = _pageController.page! - index;
                                value = (1 - (value.abs() * 0.25)).clamp(0.75, 1.0);
                              } else {
                                value = index == _initialPage ? 1.0 : 0.75;
                              }
                              final size = MediaQuery.of(context).size;
                              final double heightBase = size.height * .2;
                              final double height = Curves.easeOut.transform(value) * heightBase;
                              return SizedBox(height: height, width: double.infinity, child: child);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Container(
                                margin: const EdgeInsets.symmetric(vertical: 6),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: AppCores.cinzaBlecaute.withValues(alpha: .10),
                                      offset: const Offset(0, 4),
                                      spreadRadius: 1,
                                      blurRadius: 1,
                                    ),
                                  ],
                                ),
                                child: GestureDetector(
                                  onTap: () => context.goNamed('galeria'),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: _favoritos[imageIndex].startsWith('assets/')
                                        ? Image.asset(_favoritos[imageIndex], fit: BoxFit.cover)
                                        : Image.file(
                                            File(_favoritos[imageIndex]),
                                            fit: BoxFit.cover,
                                          ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              mainAxisAlignment: .center,
              children: List.generate(_favoritos.length, (i) {
                final bool ativo = i == _paginaAtual;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      color: ativo ? AppCores.violeta : AppCores.cinzaClaro,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppCores.violeta, width: 1.5),
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 35),
            Container(
              height: 250,
              width: .infinity,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: AppCores.cinzaBlecaute.withValues(alpha: .15),
                    offset: const Offset(0, 4),
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
                color: AppCores.violetaClaroPairado,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        Text('Dezembro', style: TextStyle(fontSize: AppTipografias.h4)),
                        Text('2025', style: TextStyle(fontSize: AppTipografias.h4)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: .start,
                        children: [
                          Text(AppTextos.total, style: TextStyle(fontSize: AppTipografias.h6)),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Text(
                                  'R\$ ',
                                  style: TextStyle(fontSize: AppTipografias.valor, height: .9),
                                ),
                                SizedBox(
                                  width: 180,
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    alignment: Alignment.centerLeft,
                                    child: _valorBorrado(
                                      '3.620,00',
                                      TextStyle(fontSize: AppTipografias.valor, height: .9),
                                      fill: AppCores.cinza,
                                    ),
                                  ),
                                ),
                                Spacer(),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _visivel = !_visivel;
                                    });
                                  },
                                  child: SvgPicture.asset(
                                    _visivel ? AppIcones.visivel : AppIcones.naoVisivel,
                                    width: 30,
                                    height: 30,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: .end,
                            children: [
                              Text(AppTextos.materiaisMaisImprevistos),
                              Text('-R\$ ', style: TextStyle(color: AppCores.vermelhoHover)),
                              SizedBox(
                                width: 45,
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  alignment: Alignment.centerLeft,
                                  child: _valorBorrado(
                                    '380,00',
                                    TextStyle(color: AppCores.vermelhoHover),
                                    fill: AppCores.roxoClaroAtivo,
                                  ),
                                ),
                              ),
                              SizedBox(width: 40),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Spacer(),
                    Row(
                      mainAxisAlignment: .spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () => context.goNamed('materiais'),
                          child: Row(
                            spacing: 12,
                            children: [
                              SvgPicture.asset(AppIcones.materiais, height: 35),
                              Text(
                                AppTextos.materiais,
                                style: TextStyle(fontSize: AppTipografias.h6),
                              ),
                            ],
                          ),
                        ),
                        Container(color: AppCores.preto, width: 1, height: 43),
                        GestureDetector(
                          onTap: () => context.goNamed('imprevistos'),
                          child: Row(
                            spacing: 12,
                            children: [
                              SvgPicture.asset(AppIcones.imprevistos, height: 35),
                              Text(
                                AppTextos.imprevistos,
                                style: TextStyle(fontSize: AppTipografias.h6),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
