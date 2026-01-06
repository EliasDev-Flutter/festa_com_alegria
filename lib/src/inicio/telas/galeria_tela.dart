import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

class GaleriaTela extends StatefulWidget {
  const GaleriaTela({super.key});

  @override
  State<GaleriaTela> createState() => _GaleriaTelaState();
}

class _GaleriaTelaState extends State<GaleriaTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: SvgPicture.asset(AppIcones.voltar),
          onPressed: () => context.goNamed('inicio'),
        ),
        title: const Text('Galeria'),
      ),
      body: Container(),
    );
  }
}
