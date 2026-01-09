import 'package:brasil_fields/brasil_fields.dart';
import 'package:festa_com_alegria/src/inicio/widgets/corpo_materiais_widget.dart';
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

class MateriaisTela extends StatefulWidget {
  const MateriaisTela({super.key});

  @override
  State<MateriaisTela> createState() => _MateriaisTelaState();
}

class _MateriaisTelaState extends State<MateriaisTela> {
  final List<Map<String, dynamic>> _itens = [];
  final scrollController = ScrollController();

  final TextEditingController _itemController = TextEditingController();
  final TextEditingController _quantidadeController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isEditing = false;

  @override
  void dispose() {
    scrollController.dispose();
    _itemController.dispose();
    _quantidadeController.dispose();
    _valorController.dispose();
    super.dispose();
  }

  double get _valorTotal {
    double total = 0.0;
    for (var item in _itens) {
      total += (item['quantidade'] as int) * (item['valor'] as double);
    }
    return total;
  }
//TODO: incluir SharedPreferences nos materiais
  void _limparControllers() {
    _itemController.clear();
    _quantidadeController.clear();
    _valorController.clear();
  }

  @override
  Widget build(BuildContext context) {
    final bool semItem = _itens.isEmpty;

    return Scaffold(
      appBar: semItem
          ? TopoBase(titulo: AppTextos.materiais)
          : TopoBase(
              titulo: _isEditing ? AppTextos.removerItens : AppTextos.materiais,
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
        child: CorpoMateriaisWidget(
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
                      ],
                    ),
                  )
                : Expanded(
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: _itens.length,
                        itemBuilder: (context, index) {
                          final item = _itens[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Row(
                              children: [
                                Text('• ', style: TextStyle(fontSize: AppTipografias.h4)),
                                SizedBox(width: 20),
                                Text(item['nome'], style: TextStyle(fontSize: AppTipografias.h4)),
                                Spacer(),
                                if (_isEditing)
                                  IconButton(
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
                                else
                                  Text(
                                    '${item['quantidade']}',
                                    style: TextStyle(fontSize: AppTipografias.h4),
                                  ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
            if (semItem) Spacer(),
            if (!semItem) SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(AppTextos.total, style: TextStyle(fontSize: AppTipografias.h4)),
                Text(
                  ' -${UtilBrasilFields.obterReal(_valorTotal)}',
                  style: TextStyle(fontSize: AppTipografias.h4, color: AppCores.vermelhoHover),
                ),
              ],
            ),
            SizedBox(height: 90),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: RodapeBotaoRetangular(
          titulo: AppTextos.adicionar,
          funcaoBotao: () {
            _limparControllers();
            showDialog(
              context: context,
              builder: (context) {
                return Dialog(
                  constraints: BoxConstraints.expand(width: double.infinity, height: 500),
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
                                AppTextos.novoItem,
                                style: TextStyle(fontSize: AppTipografias.h2),
                              ),
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
                                    titulo: AppTextos.quantidade,
                                    teclado: TextInputType.number,
                                    controller: _quantidadeController,
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
                                valueListenable: _quantidadeController,
                                builder: (context, qtdValue, _) {
                                  return ValueListenableBuilder(
                                    valueListenable: _valorController,
                                    builder: (context, valorValue, _) {
                                      final bool isFormValid =
                                          itemValue.text.isNotEmpty &&
                                          qtdValue.text.isNotEmpty &&
                                          valorValue.text.isNotEmpty;

                                      return BotaoRetangular(
                                        texto: AppTextos.adicionarItem,
                                        aoPressionar: isFormValid
                                            ? () {
                                                if (_formKey.currentState!.validate()) {
                                                  final String nome = _itemController.text;
                                                  final int qtd =
                                                      int.tryParse(_quantidadeController.text) ?? 0;
                                                  final double valor =
                                                      UtilBrasilFields.converterMoedaParaDouble(
                                                        _valorController.text,
                                                      );

                                                  setState(() {
                                                    _itens.add({
                                                      'nome': nome,
                                                      'quantidade': qtd,
                                                      'valor': valor,
                                                    });
                                                  });
                                                  Navigator.of(context).pop();
                                                }
                                              }
                                            : null,
                                      );
                                    },
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
    );
  }
}
