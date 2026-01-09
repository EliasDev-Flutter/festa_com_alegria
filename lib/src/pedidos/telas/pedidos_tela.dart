import 'dart:convert';

import 'package:festa_com_alegria/src/pedidos/models/pedido_model.dart';
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
import 'package:shared_preferences/shared_preferences.dart';

class PedidosTela extends StatefulWidget {
  const PedidosTela({super.key});

  @override
  State<PedidosTela> createState() => _PedidosTelaState();
}

class _PedidosTelaState extends State<PedidosTela> {
  bool semPedidos = true;
  int indiceAtual = 0;
  List<PedidoModel> _pedidos = [];

  @override
  void initState() {
    super.initState();
    _carregarPedidos();
  }

  Future<void> _carregarPedidos() async {
    final prefs = await SharedPreferences.getInstance();

    // Carregar filtro salvo
    final int? filtroSalvo = prefs.getInt('filtro_pedidos');
    if (filtroSalvo != null) {
      indiceAtual = filtroSalvo;
    }

    final String? pedidosString = prefs.getString('pedidos');
    if (pedidosString != null) {
      final List<dynamic> lista = json.decode(pedidosString);
      setState(() {
        _pedidos = lista.map((e) => PedidoModel.fromMap(e)).toList().reversed.toList();
        semPedidos = _pedidos.isEmpty;
      });
    } else {
      setState(() {
        _pedidos = [];
        semPedidos = true;
      });
    }
  }

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

  bool _isConcluido(String dataEntrega) {
    try {
      final parts = dataEntrega.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        int fullYear = year;
        if (year < 100) fullYear = 2000 + year;

        final entrega = DateTime(fullYear, month, day);
        final hoje = DateTime.now();
        final hojeZero = DateTime(hoje.year, hoje.month, hoje.day);

        return hojeZero.compareTo(entrega) >= 0;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  List<PedidoModel> get _pedidosFiltrados {
    if (indiceAtual == 0) return _pedidos;
    if (indiceAtual == 1) {
      return _pedidos.where((p) => !_isConcluido(p.dataEntrega)).toList();
    }
    if (indiceAtual == 2) {
      return _pedidos.where((p) => _isConcluido(p.dataEntrega)).toList();
    }
    return _pedidos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CorpoMenu(),
      appBar: TopoInicio(),
      body: semPedidos
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppTextos.naoPossuiPedidos,
                  textAlign: TextAlign.center,
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
                      PopupMenuButton<int>(
                        child: SvgPicture.asset(AppIcones.filtro),
                        itemBuilder: (context) {
                          return [
                            PopupMenuItem(value: 0, child: Text(tiposDeFiltros(0))),
                            PopupMenuItem(value: 1, child: Text(tiposDeFiltros(1))),
                            PopupMenuItem(value: 2, child: Text(tiposDeFiltros(2))),
                          ];
                        },
                        onSelected: (value) async {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setInt('filtro_pedidos', value);
                          setState(() {
                            indiceAtual = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: _pedidosFiltrados.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  indiceAtual == 1
                                      ? AppTextos.semPendencias
                                      : AppTextos.semFinalizados,
                                  style: TextStyle(fontSize: AppTipografias.h2),
                                ),
                                const SizedBox(height: 20),
                                Image.asset(AppImagens.semPendencias),
                              ],
                            ),
                          )
                        : ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(height: 15),
                            itemCount: _pedidosFiltrados.length,
                            itemBuilder: (context, index) {
                              return PedidoPersonalizadoWidget(pedido: _pedidosFiltrados[index]);
                            },
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
                  _carregarPedidos();
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
