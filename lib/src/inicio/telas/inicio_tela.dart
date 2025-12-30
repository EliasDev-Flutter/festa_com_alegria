import 'package:festa_com_alegria/src/agenda/telas/agenda_tela.dart';
import 'package:festa_com_alegria/src/carteira/telas/carteira_tela.dart';
import 'package:festa_com_alegria/src/inicio/widgets/corpo_inicio.dart';
import 'package:festa_com_alegria/src/pedidos/telas/pedidos_tela.dart';
import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InicioTela extends StatefulWidget {
  const InicioTela({super.key});

  @override
  State<InicioTela> createState() => _InicioTelaState();
}

class _InicioTelaState extends State<InicioTela> {
  int _indiceAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _indiceAtual,
        children: const [CorpoInicio(), PedidosTela(), AgendaTela(), CarteiraTela()],
      ),
      bottomNavigationBar: Container(
        height: 120,
        decoration: BoxDecoration(
          color: AppCores.violetaClaro,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .15),
              spreadRadius: 3,
              blurRadius: 4,
              offset: const Offset(0, -1),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _indiceAtual = 0;
                  });
                },
                child: Container(
                  height: 90,
                  width: 80,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _indiceAtual == 0 ? AppCores.violetaBlecaute : AppCores.transparente,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    _indiceAtual == 0 ? AppIcones.inicioBranco : AppIcones.inicioPreto,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _indiceAtual = 1;
                  });
                },
                child: Container(
                  height: 90,
                  width: 80,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _indiceAtual == 1 ? AppCores.violetaBlecaute : AppCores.transparente,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    _indiceAtual == 1 ? AppIcones.pedidosBranco : AppIcones.pedidosPreto,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _indiceAtual = 2;
                  });
                },
                child: Container(
                  height: 90,
                  width: 80,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _indiceAtual == 2 ? AppCores.violetaBlecaute : AppCores.transparente,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    _indiceAtual == 2 ? AppIcones.agendaBranco : AppIcones.agendaPreto,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    _indiceAtual = 3;
                  });
                },
                child: Container(
                  height: 90,
                  width: 80,
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: _indiceAtual == 3 ? AppCores.violetaBlecaute : AppCores.transparente,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: SvgPicture.asset(
                    _indiceAtual == 3 ? AppIcones.carteiraBranco : AppIcones.carteiraPreto,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
