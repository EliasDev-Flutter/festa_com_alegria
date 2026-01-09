import 'dart:math';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_sons.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:festa_com_alegria/widgets%20globais/botao_retangular.dart';
import 'package:festa_com_alegria/widgets%20globais/campo_texto_personalizado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CriarPedidoWidget extends StatefulWidget {
  const CriarPedidoWidget({super.key, this.aoFinalizar});

  final VoidCallback? aoFinalizar;

  @override
  State<CriarPedidoWidget> createState() => _CriarPedidoWidgetState();
}

class _CriarPedidoWidgetState extends State<CriarPedidoWidget> {
  int _etapa = 1;
  bool _kitFesta = false;
  bool _kitPapelaria = false;

  final TextEditingController _dataEntregaController = TextEditingController();
  final TextEditingController _nomeClienteController = TextEditingController();
  final TextEditingController _temaController = TextEditingController();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorTotalController = TextEditingController();

  bool _pagamentoCinquenta = false;
  bool _pagamentoDebito = false;
  bool _pagamentoCredito = false;
  bool _pagamentoPix = false;

  @override
  void initState() {
    super.initState();
    _dataEntregaController.addListener(_atualizarEstado);
    _nomeClienteController.addListener(_atualizarEstado);
    _temaController.addListener(_atualizarEstado);
    _descricaoController.addListener(_atualizarEstado);
    _valorTotalController.addListener(_atualizarEstado);
  }

  void _atualizarEstado() {
    setState(() {});
  }

  @override
  void dispose() {
    _dataEntregaController.removeListener(_atualizarEstado);
    _nomeClienteController.removeListener(_atualizarEstado);
    _temaController.removeListener(_atualizarEstado);
    _descricaoController.removeListener(_atualizarEstado);
    _valorTotalController.removeListener(_atualizarEstado);
    _dataEntregaController.dispose();
    _nomeClienteController.dispose();
    _temaController.dispose();
    _descricaoController.dispose();
    _valorTotalController.dispose();
    super.dispose();
  }

  bool get _podeAvancar {
    return _dataEntregaController.text.isNotEmpty &&
        _nomeClienteController.text.isNotEmpty &&
        _temaController.text.isNotEmpty &&
        (_kitFesta || _kitPapelaria);
  }

  bool get _podeFinalizar {
    bool pagamentoSelecionado =
        _pagamentoCinquenta || _pagamentoDebito || _pagamentoCredito || _pagamentoPix;
    return _descricaoController.text.isNotEmpty &&
        _valorTotalController.text.isNotEmpty &&
        pagamentoSelecionado;
  }

  void _selecionarPagamento(String tipo) {
    setState(() {
      _pagamentoCinquenta = tipo == '50%';
      _pagamentoDebito = tipo == 'debito';
      _pagamentoCredito = tipo == 'credito';
      _pagamentoPix = tipo == 'pix';
    });
  }

  Future<void> _selecionarData() async {
    final DateTime? dataSelecionada = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      locale: const Locale('pt', 'BR'),
    );

    if (dataSelecionada != null) {
      final String dataFormatada =
          '${dataSelecionada.day.toString().padLeft(2, '0')}/${dataSelecionada.month.toString().padLeft(2, '0')}/${dataSelecionada.year}';
      setState(() {
        _dataEntregaController.text = dataFormatada;
      });
    }
  }

  void _avancar() {
    setState(() {
      _etapa = 2;
    });
  }

  void _voltar() {
    if (_etapa == 2) {
      setState(() {
        _etapa = 1;
      });
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      constraints: const BoxConstraints(maxHeight: 500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppCores.branco,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(AppTextos.novoPedido, style: TextStyle(fontSize: AppTipografias.h1)),
                Text(
                  _etapa == 1 ? AppTextos.pedidoParte1 : AppTextos.pedidoParte2,
                  style: TextStyle(fontSize: AppTipografias.h6),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (_etapa == 1) ...[
              CampoTextoPersonalizado(
                titulo: AppTextos.dataEntrega,
                controller: _dataEntregaController,
                somenteLeitura: true,
                aoPressionar: _selecionarData,
              ),
              const SizedBox(height: 8),
              CampoTextoPersonalizado(
                capitalizacao: TextCapitalization.sentences,
                titulo: AppTextos.nomeCliente,
                controller: _nomeClienteController,
              ),
              const SizedBox(height: 8),
              CampoTextoPersonalizado(
                capitalizacao: TextCapitalization.sentences,
                titulo: AppTextos.tema,
                controller: _temaController,
              ),
              const SizedBox(height: 8),
              Text(AppTextos.tipoPedido),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppCores.violetaClaro,
                        value: _kitFesta,
                        onChanged: (value) {
                          setState(() {
                            _kitFesta = value ?? false;
                            if (_kitFesta) {
                              _kitPapelaria = false;
                            }
                          });
                        },
                      ),
                      Text(
                        AppTextos.kitFesta,
                        style: TextStyle(fontSize: AppTipografias.h6, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        activeColor: AppCores.violetaClaro,
                        value: _kitPapelaria,
                        onChanged: (value) {
                          setState(() {
                            _kitPapelaria = value ?? false;
                            if (_kitPapelaria) {
                              _kitFesta = false;
                            }
                          });
                        },
                      ),
                      Text(
                        AppTextos.kitPapelaria,
                        style: TextStyle(fontSize: AppTipografias.h6, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
            ] else ...[
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(AppTextos.formaPagamento),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppCores.violetaClaro,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              onChanged: (value) => _selecionarPagamento('50%'),
                              value: _pagamentoCinquenta,
                            ),
                            Text(AppTextos.cinquentaPorcento),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppCores.violetaClaro,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: _pagamentoDebito,
                              onChanged: (value) => _selecionarPagamento('debito'),
                            ),
                            Text(AppTextos.debito),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppCores.violetaClaro,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: _pagamentoCredito,
                              onChanged: (value) => _selecionarPagamento('credito'),
                            ),
                            Text(AppTextos.credito),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              activeColor: AppCores.violetaClaro,
                              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              value: _pagamentoPix,
                              onChanged: (value) => _selecionarPagamento('pix'),
                            ),
                            Text(AppTextos.pix),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    CampoTextoPersonalizado(
                      controller: _descricaoController,
                      titulo: AppTextos.descricao,
                      linhasMaximas: 4,
                    ),
                    const SizedBox(height: 8),
                    CampoTextoPersonalizado(
                      titulo: AppTextos.valorTotal,
                      exemplo: AppTextos.moedaValor,
                      controller: _valorTotalController,
                      teclado: TextInputType.number,
                      formatadores: [
                        FilteringTextInputFormatter.digitsOnly,
                        CentavosInputFormatter(moeda: true),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                BotaoRetangular(
                  texto: AppTextos.voltar,
                  paddingHorizontal: 1,
                  semFundo: true,
                  largura: 140,
                  aoPressionar: _voltar,
                ),
                BotaoRetangular(
                  texto: _etapa == 1 ? AppTextos.avancar : AppTextos.finalizar,
                  paddingHorizontal: 1,
                  largura: 140,
                  aoPressionar: _etapa == 1
                      ? (_podeAvancar ? _avancar : null)
                      : (_podeFinalizar
                            ? () async {
                                Navigator.of(context).pop();
                                await showDialog(
                                  context: context,
                                  builder: (context) => const _DialogoPedidoCadastrado(),
                                );
                                widget.aoFinalizar?.call();
                              }
                            : null),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogoPedidoCadastrado extends StatefulWidget {
  const _DialogoPedidoCadastrado();

  @override
  State<_DialogoPedidoCadastrado> createState() => _DialogoPedidoCadastradoState();
}

class _DialogoPedidoCadastradoState extends State<_DialogoPedidoCadastrado> {
  @override
  void initState() {
    super.initState();
    _tocarSomAleatorio();
  }

  void _tocarSomAleatorio() {
    final random = Random();
    final opcao = random.nextInt(3);
    switch (opcao) {
      case 0:
        AppSons.tocarPedidoCriado1();
        break;
      case 1:
        AppSons.tocarPedidoCriado2();
        break;
      case 2:
        AppSons.tocarPedidoCriado3();
        break;
    }
  }

  @override
  void dispose() {
    AppSons.pararSom();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      constraints: const BoxConstraints(maxHeight: 460),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: AppCores.branco,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            children: [
              Text(AppTextos.pedidoCadastrado, style: TextStyle(fontSize: AppTipografias.h2)),
              Text(AppTextos.horaTrabalhar, style: TextStyle(fontSize: AppTipografias.h4)),
              const SizedBox(height: 20),
              Image.asset(AppImagens.pedidoCadastrado),
              const SizedBox(height: 40),
              BotaoRetangular(
                largura: double.infinity,
                texto: AppTextos.voltar,
                aoPressionar: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
