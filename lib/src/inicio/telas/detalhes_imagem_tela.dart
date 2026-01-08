import 'dart:io';

import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_sons.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:festa_com_alegria/widgets%20globais/botao_retangular.dart';
import 'package:festa_com_alegria/widgets%20globais/topo_base.dart';
import 'package:flutter/material.dart';
import 'package:gal/gal.dart';
import 'package:go_router/go_router.dart';

class DetalhesImagemTela extends StatelessWidget {
  const DetalhesImagemTela({super.key, required this.caminhoImagem, required this.aoRemover});

  final String caminhoImagem;
  final VoidCallback aoRemover;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoBase(
        iconeBotao: AppIcones.remover,
        tamanhoBotao: 80,
        temBotao: true,
        titulo: '',
        aoPressionar: () {
          AppSons.tocarExcluir();
          aoRemover();
          context.pop();
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: .spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Container(
                width: .infinity,
                height: 460,
                decoration: BoxDecoration(
                  border: Border.all(color: AppCores.preto, width: 1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.file(File(caminhoImagem), fit: BoxFit.cover),
                ),
              ),
            ),
            Column(
              children: [
                BotaoRetangular(
                  texto: 'Compartilhar',
                  aoPressionar: () {},
                  altura: 50,
                  temIcone: true,
                ),
                const SizedBox(height: 15),
                BotaoRetangular(
                  temIcone: true,
                  icone: AppIcones.salvar,
                  texto: 'Baixar',
                  aoPressionar: () async {
                    try {
                      await Gal.putImage(caminhoImagem);
                      if (context.mounted) {
                        AppSons.tocarSalvar();
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Imagem salva na galeria!',
                              style: TextStyle(fontSize: AppTipografias.h4),
                            ),
                          ),
                        );
                      }
                    } catch (e) {
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Erro ao salvar imagem: $e',
                              style: TextStyle(fontSize: AppTipografias.h4),
                            ),
                            backgroundColor: AppCores.vermelho,
                          ),
                        );
                      }
                    }
                  },
                  altura: 50,
                ),
                const SizedBox(height: 60),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
