import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSons {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<bool> _podeTocar() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('efeitoSonoro') ?? true;
  }

  static Future<void> tocarSplash() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('splash.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }

  static Future<void> tocarSalvar() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('salvar.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }

  static Future<void> tocarExcluir() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('excluir.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }

  static Future<void> tocarNotificacao() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('notificacao.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }

  static Future<void> tocarPedidoCriado() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('pedido-criado.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }
}
