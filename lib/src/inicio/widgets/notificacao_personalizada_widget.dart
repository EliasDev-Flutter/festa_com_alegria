import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificacaoPersonalizadaWidget extends StatelessWidget {

  final String tema;
  final String data;
  final String diasPassados;

  const NotificacaoPersonalizadaWidget({ super.key, required this.tema, required this.data, required this.diasPassados });

   @override
   Widget build(BuildContext context) {
       return ListTile(
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        shape: Border(bottom: BorderSide(color: AppCores.preto)),
                        leading: SvgPicture.asset(AppIcones.notificacoes, width: 30),
                        title: Text(
                          tema,
                          style: TextStyle(fontSize: AppTipografias.h6),
                        ),
                        subtitle: Text(data, style: TextStyle(fontSize: AppTipografias.h6)),
                        trailing: Text(
                          diasPassados,
                          style: TextStyle(
                            fontSize: AppTipografias.pf,
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Arial',
                          ),
                        ),
                      );
  }
}