import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:flutter/material.dart';

class BotaoRetangular extends StatelessWidget {
  final String texto;
  final VoidCallback? onPressed;
  final double? largura;
  final double? altura;
  final double? paddingHorizontal;

  const BotaoRetangular({
    super.key,
    required this.texto,
    this.onPressed,
    this.largura,
    this.altura,
    this.paddingHorizontal,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 37),
      child: SizedBox(
        height: altura ?? 44,
        width: largura ?? 320,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppCores.violetaClaro,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: Text(texto),
        ),
      ),
    );
  }
}
