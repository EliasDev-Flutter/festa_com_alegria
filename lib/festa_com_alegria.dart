import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_rotas.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FestaComAlegria extends StatelessWidget {
  const FestaComAlegria({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
        drawerTheme: DrawerThemeData(backgroundColor: AppCores.branco),
        bottomAppBarTheme: BottomAppBarThemeData(color: AppCores.branco),
        scaffoldBackgroundColor: AppCores.branco,
        textTheme: GoogleFonts.abhayaLibreTextTheme(),
        appBarTheme: AppBarTheme(
          titleTextStyle: GoogleFonts.abhayaLibreTextTheme().titleLarge,
          backgroundColor: AppCores.branco,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
