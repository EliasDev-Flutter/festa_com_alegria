import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppSons {
  static final AudioPlayer _audioPlayer = AudioPlayer();

  static Future<bool> _podeTocar() async {
    final prefs = await SharedPreferences.getInstance();
    final pode = prefs.getBool('efeitoSonoro') ?? true;
    return pode;
  }

  static Future<void> _configurarAudio() async {
    await _audioPlayer.setAudioContext(
      AudioContext(
        android: AudioContextAndroid(
          isSpeakerphoneOn: true,
          stayAwake: true,
          contentType: AndroidContentType.music,
          usageType: AndroidUsageType.media,
          audioFocus: AndroidAudioFocus.gain,
        ),
        iOS: AudioContextIOS(
          category: AVAudioSessionCategory.playback,
          options: {AVAudioSessionOptions.mixWithOthers},
        ),
      ),
    );
  }

  static Future<void> tocarSplash() async {
    try {
      if (await _podeTocar()) {
        await _configurarAudio();
        await _audioPlayer.setVolume(1.0);
        await _audioPlayer.setReleaseMode(ReleaseMode.stop);
        await _audioPlayer.play(AssetSource('audio/splash.wav'));
      } else {
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }

  static Future<void> tocarSalvar() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('audio/salvar.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }

  static Future<void> tocarExcluir() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('audio/excluir.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }

  static Future<void> tocarNotificacao() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('audio/notificacao.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }

  static Future<void> tocarPedidoCriado() async {
    try {
      if (await _podeTocar()) {
        await _audioPlayer.play(AssetSource('audio/pedido-criado.wav'));
      }
    } catch (e) {
      debugPrint('Erro ao tocar som: $e');
    }
  }
}
