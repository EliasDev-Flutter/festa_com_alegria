import 'package:festa_com_alegria/src/pedidos/models/pedido_model.dart';
import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PedidoPersonalizadoWidget extends StatefulWidget {
  final PedidoModel pedido;

  const PedidoPersonalizadoWidget({super.key, required this.pedido});

  @override
  State<PedidoPersonalizadoWidget> createState() => _PedidoPersonalizadoWidgetState();
}

class _PedidoPersonalizadoWidgetState extends State<PedidoPersonalizadoWidget> {
  bool _expandido = false;

  void _alternarExpansao() {
    setState(() {
      _expandido = !_expandido;
    });
  }

  bool get _pedidoConcluido {
    try {
      final parts = widget.pedido.dataEntrega.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        // Assuming year is 2 digits like '25', convert to 2025? Or is it 4 digits?
        // User input was '31/12/25'. BrasilFields usually formats as dd/MM/yyyy (4 digits) if using DataInputFormatter.
        // But if user typed 25, it might be 0025.
        // However, standard masks usually force 4 digits.
        // Let's handle 2 digit years just in case, or assume 4 digits if > 100.
        int fullYear = year;
        if (year < 100) {
          fullYear = 2000 + year;
        }

        final entrega = DateTime(fullYear, month, day);
        final hoje = DateTime.now();
        final hojeZero = DateTime(hoje.year, hoje.month, hoje.day);

        return hojeZero.compareTo(entrega) >= 0;
      }
    } catch (e) {
      // Error parsing
    }
    return false;
  }

  String get _iconePagamento {
    switch (widget.pedido.formaPagamento.toLowerCase()) {
      case 'pix':
        return AppIcones.pix;
      case 'debito':
        return AppIcones.debito;
      case 'credito':
        return AppIcones.credito;
      case '50%':
        return AppIcones.metade;
      default:
        return AppIcones.metade;
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusIcon = _pedidoConcluido ? AppIcones.concluido : AppIcones.ausente;
    final statusText = _pedidoConcluido ? 'Entregue' : 'Pendente';

    return GestureDetector(
      onTap: _alternarExpansao,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: AppCores.violetaClaroPairado,
          border: Border.all(color: AppCores.violeta),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                if (_expandido) ...[
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppCores.violetaEscuroAtivo,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.all(4),
                    child: SvgPicture.asset(
                      width: 30,
                      _iconePagamento,
                      colorFilter: const ColorFilter.mode(AppCores.branco, BlendMode.srcIn),
                    ),
                  ),
                  const SizedBox(width: 10),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '${widget.pedido.nomeCliente} - ${widget.pedido.tema}',
                          style: TextStyle(
                            fontSize: AppTipografias.h5,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!_expandido)
                        Text(
                          widget.pedido.dataEntrega,
                          style: TextStyle(fontSize: AppTipografias.p),
                        ),
                    ],
                  ),
                ),
                if (!_expandido) ...[
                  SvgPicture.asset(statusIcon, width: 24),
                  const SizedBox(width: 10),
                ],
                SvgPicture.asset(_expandido ? AppIcones.aberto : AppIcones.fechado, width: 24),
              ],
            ),

            // Expanded Content
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.pedido.descricao, style: TextStyle(fontSize: AppTipografias.p)),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Status:', style: TextStyle(fontSize: AppTipografias.p)),
                        Text(statusText, style: TextStyle(fontSize: AppTipografias.p)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Tipo de pedido:', style: TextStyle(fontSize: AppTipografias.p)),
                        Text(
                          widget.pedido.tipoPedido,
                          style: TextStyle(fontSize: AppTipografias.p),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Data de entrega:', style: TextStyle(fontSize: AppTipografias.p)),
                        Text(
                          widget.pedido.dataEntrega,
                          style: TextStyle(fontSize: AppTipografias.p),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total:',
                          style: TextStyle(
                            fontSize: AppTipografias.h4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          widget.pedido.valorTotal,
                          style: TextStyle(
                            fontSize: AppTipografias.h4,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              crossFadeState: _expandido ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),
          ],
        ),
      ),
    );
  }
}
