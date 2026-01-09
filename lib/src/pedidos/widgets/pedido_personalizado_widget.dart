import 'package:flutter/material.dart';

class PedidoPersonalizadoWidget extends StatefulWidget {
  const PedidoPersonalizadoWidget({super.key});

  @override
  State<PedidoPersonalizadoWidget> createState() => _PedidoPersonalizadoWidgetState();
}

class _PedidoPersonalizadoWidgetState extends State<PedidoPersonalizadoWidget> {
  @override
  Widget build(BuildContext context) {
    return ListTile(title: Text('Pedido Personalizado'), subtitle: Text('R\$ 100,00'));
  }
}
