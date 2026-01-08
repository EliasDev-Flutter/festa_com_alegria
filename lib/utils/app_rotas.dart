import 'package:festa_com_alegria/src/inicio/telas/ajustes_tela.dart';
import 'package:festa_com_alegria/src/inicio/telas/detalhes_imagem_tela.dart';
import 'package:festa_com_alegria/src/inicio/telas/galeria_tela.dart';
import 'package:festa_com_alegria/src/inicio/telas/imprevistos_tela.dart';
import 'package:festa_com_alegria/src/inicio/telas/inicio_tela.dart';
import 'package:festa_com_alegria/src/inicio/telas/materiais_tela.dart';
import 'package:festa_com_alegria/src/inicio/telas/notificacoes_tela.dart';
import 'package:festa_com_alegria/src/introducao/telas/introducao_tela.dart';
import 'package:festa_com_alegria/src/introducao/telas/splash_tela.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(
      path: '/splash',
      name: 'splash',
      builder: (BuildContext context, GoRouterState state) {
        return const SplashTela();
      },
    ),
    GoRoute(
      path: '/introducao',
      name: 'introducao',
      pageBuilder: (BuildContext context, GoRouterState state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: const IntroducaoTela(),
          transitionsBuilder:
              (
                BuildContext context,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                Widget child,
              ) {
                return FadeTransition(
                  opacity: CurvedAnimation(parent: animation, curve: Curves.easeInOut),
                  child: child,
                );
              },
          transitionDuration: const Duration(milliseconds: 800),
          reverseTransitionDuration: const Duration(milliseconds: 800),
        );
      },
    ),
    GoRoute(
      path: '/inicio',
      name: 'inicio',
      builder: (BuildContext context, GoRouterState state) {
        return const InicioTela();
      },
    ),
    GoRoute(
      path: '/materiais',
      name: 'materiais',
      builder: (BuildContext context, GoRouterState state) {
        return const MateriaisTela();
      },
    ),
    GoRoute(
      path: '/imprevistos',
      name: 'imprevistos',
      builder: (BuildContext context, GoRouterState state) {
        return const ImprevistosTela();
      },
    ),
    GoRoute(
      path: '/ajustes',
      name: 'ajustes',
      builder: (BuildContext context, GoRouterState state) {
        return const AjustesTela();
      },
    ),
    GoRoute(
      path: '/galeria',
      name: 'galeria',
      builder: (BuildContext context, GoRouterState state) {
        return const GaleriaTela();
      },
    ),
    GoRoute(
      path: '/notificacoes',
      name: 'notificacoes',
      builder: (BuildContext context, GoRouterState state) {
        return const NotificacoesTela();
      },
    ),
    GoRoute(
      path: '/detalhes-imagem',
      name: 'detalhesImagem',
      builder: (BuildContext context, GoRouterState state) {
        final Map<String, dynamic> extra = state.extra as Map<String, dynamic>;
        return DetalhesImagemTela(
          caminhoImagem: extra['caminhoImagem'] as String,
          aoRemover: extra['aoRemover'] as VoidCallback,
        );
      },
    ),
  ],
);
