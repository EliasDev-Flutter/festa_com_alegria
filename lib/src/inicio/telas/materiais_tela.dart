import 'package:festa_com_alegria/src/inicio/widgets/corpo_materiais_widget.dart';
import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:festa_com_alegria/widgets%20globais/campo_texto_personalizado.dart';
import 'package:festa_com_alegria/widgets%20globais/rodape_botao_retangular.dart';
import 'package:festa_com_alegria/widgets%20globais/topo_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class MateriaisTela extends StatefulWidget {
  const MateriaisTela({super.key});

  @override
  State<MateriaisTela> createState() => _MateriaisTelaState();
}

class _MateriaisTelaState extends State<MateriaisTela> {
  final bool semItem = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoBase(titulo: AppTextos.materiais),
      body: CorpoMateriaisWidget(
        corpo: [
          Center(
            child: Text('Dezembro 2025', style: TextStyle(fontSize: AppTipografias.h2)),
          ),
          SizedBox(height: 40),
          semItem
              ? Center(
                  child: Column(
                    children: [
                      Text(AppTextos.semItens, style: TextStyle(fontSize: AppTipografias.h4)),
                      SizedBox(height: 20),
                      Image.asset(AppImagens.semItens),
                      SizedBox(height: 20),
                    ],
                  ),
                )
              : Column(children: []),
          Spacer(),
          Row(
            mainAxisAlignment: .end,
            children: [
              Text(AppTextos.total, style: TextStyle(fontSize: AppTipografias.h4)),
              Text(
                ' -R\$ 0,00',
                style: TextStyle(fontSize: AppTipografias.h4, color: AppCores.vermelhoHover),
              ),
            ],
          ),
          SizedBox(height: 90),
        ],
      ),
      bottomNavigationBar: RodapeBotaoRetangular(
        titulo: AppTextos.adicionar,
        funcaoBotao: () {
          showDialog(
            context: context,
            builder: (context) {
              return Dialog(
                constraints: BoxConstraints.expand(width: .infinity, height: 500),
                backgroundColor: AppCores.cinzaClaro,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: Column(
                    crossAxisAlignment: .start,
                    children: [
                      Row(
                        children: [
                          Text(AppTextos.novoItem, style: TextStyle(fontSize: AppTipografias.h2)),
                          Spacer(),
                          IconButton(
                            icon: SvgPicture.asset(AppIcones.cancelar),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      CampoTextoPersonalizado(),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
