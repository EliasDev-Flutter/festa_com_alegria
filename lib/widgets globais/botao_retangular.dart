import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class BotaoRetangular extends StatelessWidget {
  final String texto;
  final VoidCallback? aoPressionar;
  final double? largura;
  final double? altura;
  final double? paddingHorizontal;
  final bool temIcone;
  final String icone;
  final bool semFundo;

  const BotaoRetangular({
    super.key,
    required this.texto,
    this.aoPressionar,
    this.largura,
    this.altura,
    this.paddingHorizontal,
    this.temIcone = false,
    this.icone = AppIcones.enviar,
    this.semFundo = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 0),
      child: SizedBox(
        height: altura ?? 44,
        width: largura ?? double.infinity,
        child: ElevatedButton(
          onPressed: aoPressionar,
          style: ElevatedButton.styleFrom(
            backgroundColor: semFundo ? AppCores.branco : AppCores.violetaClaro,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            side: semFundo ? BorderSide(color: AppCores.violetaClaro, width: 2) : null,
          ),
          child: temIcone
              ? Row(
                  mainAxisAlignment: .center,
                  children: [
                    SvgPicture.asset(icone, width: 30),
                    SizedBox(width: 10),
                    Text(
                      texto,
                      style: TextStyle(fontSize: AppTipografias.h5, color: AppCores.preto),
                    ),
                  ],
                )
              : Text(
                  texto,
                  style: TextStyle(fontSize: AppTipografias.h5, color: AppCores.preto),
                ),
        ),
      ),
    );
  }
}
