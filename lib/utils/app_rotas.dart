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
  ],
);
