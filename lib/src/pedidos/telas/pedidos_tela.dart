import 'package:festa_com_alegria/src/pedidos/widgets/criar_pedido_widget.dart';
import 'package:festa_com_alegria/src/pedidos/widgets/pedido_personalizado_widget.dart';
import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:festa_com_alegria/widgets%20globais/corpo_menu.dart';
import 'package:festa_com_alegria/widgets%20globais/topo_inicio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PedidosTela extends StatefulWidget {
  const PedidosTela({super.key});

  @override
  State<PedidosTela> createState() => _PedidosTelaState();
}

class _PedidosTelaState extends State<PedidosTela> {
  bool semPedidos = true;
  int indiceAtual = 0;

  String tiposDeFiltros(int indice) {
    switch (indice) {
      case 0:
        return AppTextos.todos;
      case 1:
        return AppTextos.pendentes;
      case 2:
        return AppTextos.finalizado;
      default:
        return AppTextos.todos;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CorpoMenu(),
      appBar: TopoInicio(),
      body: semPedidos
          ? Column(
              mainAxisAlignment: .center,
              children: [
                Text(
                  textAlign: .center,
                  AppTextos.naoPossuiPedidos,
                  style: TextStyle(fontSize: AppTipografias.h1),
                ),
                SizedBox(height: 20),
                Image.asset(AppImagens.alerta, width: 80),
                SizedBox(height: 150),
              ],
            )
          : Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(AppTextos.filtrandoPor, style: TextStyle(fontSize: AppTipografias.h5)),
                      Text(
                        tiposDeFiltros(indiceAtual),
                        style: TextStyle(fontSize: AppTipografias.h3),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            PopupMenuButton(
                              itemBuilder: (context) {
                                return [
                                  PopupMenuItem(value: 0, child: Text(tiposDeFiltros(0))),
                                  PopupMenuItem(value: 1, child: Text(tiposDeFiltros(1))),
                                  PopupMenuItem(value: 2, child: Text(tiposDeFiltros(2))),
                                ];
                              },
                              onSelected: (value) {
                                setState(() {
                                  indiceAtual = value;
                                });
                              },
                            );
                          });
                        },
                        child: SvgPicture.asset(AppIcones.filtro),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SingleChildScrollView(
                    physics: ClampingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox(
                          width: .infinity,
                          child: ListView.separated(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return PedidoPersonalizadoWidget();
                            },
                            separatorBuilder: (context, index) => SizedBox(height: 10),
                            itemCount: 5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: FloatingActionButton(
          backgroundColor: AppCores.roxoEscuro,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: Padding(
            padding: const EdgeInsets.only(left: 5.0, bottom: 3.0),
            child: SvgPicture.asset(
              colorFilter: const ColorFilter.mode(AppCores.branco, BlendMode.srcIn),
              AppIcones.criarPedido,
              width: 40,
            ),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) => CriarPedidoWidget(
                aoFinalizar: () {
                  setState(() {
                    semPedidos = false;
                  });
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
