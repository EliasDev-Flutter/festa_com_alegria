import 'package:brasil_fields/brasil_fields.dart';
import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:festa_com_alegria/widgets%20globais/botao_retangular.dart';
import 'package:festa_com_alegria/widgets%20globais/campo_texto_personalizado.dart';
import 'package:festa_com_alegria/widgets%20globais/rodape_botao_retangular.dart';
import 'package:festa_com_alegria/widgets%20globais/topo_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class ImprevistosTela extends StatefulWidget {
  const ImprevistosTela({super.key});

  @override
  State<ImprevistosTela> createState() => _ImprevistosTelaState();
}

final List<Map<String, dynamic>> _itens = [];

class _ImprevistosTelaState extends State<ImprevistosTela> {
  final scrollController = ScrollController();
//TODO: incluir SharedPreferences nos imprevistos
  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEditing = false;

  double get _valorTotal {
    double total = 0.0;
    for (var item in _itens) {
      total += item['valor'] as double;
    }
    return total;
  }

  @override
  void dispose() {
    scrollController.dispose();
    _itemController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  void _limparControllers() {
    _itemController.clear();
    _valorController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bool semItem = _itens.isEmpty;
    return Scaffold(
      appBar: semItem
          ? TopoBase(titulo: AppTextos.imprevistos)
          : TopoBase(
              titulo: _isEditing ? AppTextos.removerItens : AppTextos.imprevistos,
              iconeBotao: AppIcones.editar,
              temBotao: true,
              aoPressionar: () {
                setState(() {
                  _isEditing = true;
                });
              },
              widgetAcao: _isEditing
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          _itens.clear();
                          _isEditing = false;
                        });
                      },
                      child: Text(
                        AppTextos.limpar,
                        style: TextStyle(fontSize: AppTipografias.pf, color: AppCores.azul),
                      ),
                    )
                  : null,
            ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Column(
          children: [
            Center(
              child: Text('Dezembro 2025', style: TextStyle(fontSize: AppTipografias.h2)),
            ),
            SizedBox(height: 40),
            Expanded(
              child: semItem
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(AppTextos.semItens, style: TextStyle(fontSize: AppTipografias.h4)),
                          SizedBox(height: 20),
                          Image.asset(AppImagens.semImprevistos),
                        ],
                      ),
                    )
                  : Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _itens.length,
                        itemBuilder: (context, index) {
                          final item = _itens[index];
                          return Padding(
                            padding: const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 10.0),
                            child: Row(
                              children: [
                                Text('• ', style: TextStyle(fontSize: AppTipografias.h4)),
                                SizedBox(width: 20),
                                Text(item['nome'], style: TextStyle(fontSize: AppTipografias.h4)),
                                Spacer(),
                                _isEditing
                                    ? IconButton(
                                        icon: Icon(Icons.close, size: 30),
                                        onPressed: () {
                                          setState(() {
                                            _itens.removeAt(index);
                                            if (_itens.isEmpty) {
                                              _isEditing = false;
                                            }
                                          });
                                        },
                                      )
                                    : SizedBox(),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
            ),
            if (!semItem) SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(AppTextos.total, style: TextStyle(fontSize: AppTipografias.h4)),
                  Text(
                    ' -${UtilBrasilFields.obterReal(_valorTotal)}',
                    style: TextStyle(fontSize: AppTipografias.h4, color: AppCores.vermelhoHover),
                  ),
                ],
              ),
            ),
            SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: RodapeBotaoRetangular(           
            titulo: AppTextos.adicionar,
            funcaoBotao: () {
              _limparControllers();
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    constraints: BoxConstraints.expand(width: double.infinity, height: 400),
                    backgroundColor: AppCores.cinzaClaro,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                      child: Form(
                        key: _formKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  AppTextos.novoImprevisto,
                                  style: TextStyle(fontSize: AppTipografias.h4),
                                ),
                                Spacer(),
                                IconButton(
                                  icon: SvgPicture.asset(AppIcones.cancelar, width: 40),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            ),
                            SizedBox(height: 20),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CampoTextoPersonalizado(
                                      titulo: AppTextos.item,
                                      controller: _itemController,
                                    ),
                                    SizedBox(height: 20),
                                    CampoTextoPersonalizado(
                                      exemplo: AppTextos.moedaValor,
                                      titulo: AppTextos.valor,
                                      teclado: TextInputType.number,
                                      controller: _valorController,
                                      formatadores: [
                                        FilteringTextInputFormatter.digitsOnly,
                                        CentavosInputFormatter(moeda: true),
                                      ],
                                    ),
                                    SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ),
                            ValueListenableBuilder(
                              valueListenable: _itemController,
                              builder: (context, itemValue, _) {
                                return ValueListenableBuilder(
                                  valueListenable: _valorController,
                                  builder: (context, valorValue, _) {
                                    final bool isFormValid =
                                        itemValue.text.isNotEmpty && valorValue.text.isNotEmpty;
          
                                    return BotaoRetangular(
                                      texto: AppTextos.adicionar,
                                      aoPressionar: isFormValid
                                          ? () {
                                              if (_formKey.currentState!.validate()) {
                                                final String nome = _itemController.text;
                                                final double valor =
                                                    UtilBrasilFields.converterMoedaParaDouble(
                                                      _valorController.text,
                                                    );
          
                                                setState(() {
                                                  _itens.add({'nome': nome, 'valor': valor});
                                                });
                                                Navigator.of(context).pop();
                                              }
                                            }
                                          : null,
                                    );
                                  },
                                );
                              },
                            ),
                            SizedBox(height: 30),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
