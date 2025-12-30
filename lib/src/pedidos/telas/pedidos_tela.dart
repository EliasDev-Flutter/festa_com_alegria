import 'package:flutter/material.dart';

class PedidosTela extends StatefulWidget {

  const PedidosTela({ super.key });

  @override
  State<PedidosTela> createState() => _PedidosTelaState();
}

class _PedidosTelaState extends State<PedidosTela> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Pedidos'),),
           body: Container(),
       );
  }
}