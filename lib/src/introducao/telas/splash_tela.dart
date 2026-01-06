import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_sons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashTela extends StatefulWidget {
  const SplashTela({super.key});

  @override
  State<SplashTela> createState() => _SplashTelaState();
}

class _SplashTelaState extends State<SplashTela> {
  @override
  void initState() {
    super.initState();
    _navegar();
  }

  Future<void> _navegar() async {
    await AppSons.tocarSplash();
    await Future.delayed(const Duration(seconds: 5));
    if (mounted) {
      final prefs = await SharedPreferences.getInstance();
      final bool introducao = prefs.getBool('introducao') ?? false;

      if (mounted) {
        if (introducao) {
          context.goNamed('introducao');
        } else {
          context.goNamed('inicio');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: .infinity,
        decoration: BoxDecoration(gradient: AppCores.introGradiente),
        child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Image.asset(
                AppImagens.logo,
                height: 200,
                width: 200,
              ).animate().fadeIn(duration: 1000.ms),
            ),
            Expanded(flex: 1, child: SizedBox()),
          ],
        ),
      ),
    );
  }
}
