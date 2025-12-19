import 'package:festa_com_alegria/utils/app_rotas.dart';
import 'package:flutter/material.dart';

class FestaComAlegria extends StatelessWidget {
  const FestaComAlegria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: true,

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
