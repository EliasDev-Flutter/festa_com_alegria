import 'dart:io';

import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_imagens.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:festa_com_alegria/widgets%20globais/topo_base.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GaleriaTela extends StatefulWidget {
  const GaleriaTela({super.key});

  @override
  State<GaleriaTela> createState() => _GaleriaTelaState();
}

class _GaleriaTelaState extends State<GaleriaTela> {
  List<String> _imagens = [];
  bool _carregando = true;
  bool _isSelectionMode = false;
  List<String> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _carregarImagens();
  }

  Future<void> _carregarImagens() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _imagens = prefs.getStringList('galeria_imagens') ?? [];
      _carregando = false;
    });
  }

  Future<void> _adicionarImagem(String caminho) async {
    setState(() {
      _imagens.add(caminho);
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('galeria_imagens', _imagens);
  }

  Future<void> _removerImagem(String caminho) async {
    setState(() {
      _imagens.remove(caminho);
      if (_selectedImages.contains(caminho)) {
        _selectedImages.remove(caminho);
        _salvarFavoritos(atualizarEstado: false);
      }
    });
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('galeria_imagens', _imagens);
  }

  Future<void> _alternarModoSelecao() async {
    if (_isSelectionMode) {
      setState(() {
        _isSelectionMode = false;
        _selectedImages.clear();
      });
    } else {
      final prefs = await SharedPreferences.getInstance();
      final favoritosSalvos = prefs.getStringList('favoritos_inicio') ?? [];
      setState(() {
        _isSelectionMode = true;
        _selectedImages = favoritosSalvos.where((path) => _imagens.contains(path)).toList();
      });
    }
  }

  Future<void> _salvarFavoritos({bool atualizarEstado = true}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favoritos_inicio', _selectedImages);
    if (atualizarEstado) {
      setState(() {
        _isSelectionMode = false;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Favoritos atualizados!', style: TextStyle(fontSize: AppTipografias.h4)),
          ),
        );
      }
    }
  }

  void _selecionarImagem(String caminho) {
    setState(() {
      if (_selectedImages.contains(caminho)) {
        _selectedImages.remove(caminho);
      } else {
        if (_selectedImages.length < 5) {
          _selectedImages.add(caminho);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Máximo de 5 imagens selecionadas.',
                style: TextStyle(fontSize: AppTipografias.h4),
              ),
            ),
          );
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _imagens.isNotEmpty
          ? TopoBase(
              iconeBotao: _isSelectionMode ? AppIcones.cancelar : AppIcones.favoritos,
              titulo: _isSelectionMode ? AppTextos.selecionarFavoritos : AppTextos.galeria,
              temBotao: true,
              aoPressionar: _alternarModoSelecao,
            )
          : TopoBase(titulo: AppTextos.galeria),
      body: _carregando
          ? const Center(child: CircularProgressIndicator())
          : _imagens.isEmpty
          ? Center(
              child: Column(
                children: [
                  const SizedBox(height: 60),
                  Text(AppTextos.semImagens, style: TextStyle(fontSize: AppTipografias.h4)),
                  const SizedBox(height: 30),
                  Image.asset(AppImagens.semImagens),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.all(20.0),
              children: [
                Center(
                  child: Wrap(
                    spacing: 10,
                    runSpacing: 10,
                    children: _imagens.map((caminho) {
                      final bool selecionado = _selectedImages.contains(caminho);
                      final int indexSelecionado = _selectedImages.indexOf(caminho) + 1;

                      return GestureDetector(
                        onTap: () {
                          if (_isSelectionMode) {
                            _selecionarImagem(caminho);
                          } else {
                            context.pushNamed(
                              'detalhesImagem',
                              extra: {
                                'caminhoImagem': caminho,
                                'aoRemover': () => _removerImagem(caminho),
                              },
                            );
                          }
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 109,
                              height: 137,
                              decoration: BoxDecoration(
                                border: Border.all(color: AppCores.preto, width: 1),
                              ),
                              child: Image.file(File(caminho), fit: BoxFit.cover),
                            ),
                            if (_isSelectionMode)
                              Container(
                                width: 109,
                                height: 137,
                                color: selecionado ? AppCores.cinza.withValues(alpha: .5) : AppCores.transparente,
                                child: selecionado
                                    ? Center(
                                        child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: const BoxDecoration(
                                            color: AppCores.cinzaClaroAtivo,
                                            shape: BoxShape.circle,
                                          ),
                                          child: Center(
                                            child: Text(
                                              '$indexSelecionado',
                                              style: const TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.bold,
                                                color: AppCores.preto,
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 100),
              ],
            ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(vertical: 110.0, horizontal: 20.0),
        child: FloatingActionButton(
          backgroundColor: AppCores.roxoEscuro,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          child: SvgPicture.asset(
            width: 40,
            _isSelectionMode ? AppIcones.salvar : AppIcones.adicionar,
            colorFilter: const ColorFilter.mode(AppCores.branco, BlendMode.srcIn),
          ),
          onPressed: () async {
            if (_isSelectionMode) {
              await _salvarFavoritos();
            } else {
              final ImagePicker picker = ImagePicker();
              final XFile? image = await picker.pickImage(source: ImageSource.gallery);
              if (image != null) {
                await _adicionarImagem(image.path);
              }
            }
          },
        ),
      ),
    );
  }
}
