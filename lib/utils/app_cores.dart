import 'package:flutter/material.dart';

abstract class AppCores {
  //Cores do app

  //Gradiente de introdução
  static const Gradient introGradiente = LinearGradient(
    colors: [Color(0xFFF093FB), Color(0xFFF5576C)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  //Tons de violeta
  static const Color violetaClaro = Color(0xFFF9B0FA);
  static const Color violetaClaroPairado = Color(0xFFFCD9FD);
  static const Color violetaClaroAtivo = Color(0xFFF9B0FA);
  static const Color violeta = Color(0xFFEC00F0);
  static const Color violetaPairado = Color(0xFFD400D8);
  static const Color violetaAtivo = Color(0xFFBD00C0);
  static const Color violetaEscuro = Color(0xFFB100B4);
  static const Color violetaEscuroPairado = Color(0xFF8E0090);
  static const Color violetaEscuroAtivo = Color(0xFF6A006C);
  static const Color violetaBlecaute = Color(0xFF530054);

  //Tons de roxo
  static const Color roxoClaro = Color(0xFFF5E6F6);
  static const Color roxoClaroPairado = Color(0xFFF0D9F2);
  static const Color roxoClaroAtivo = Color(0xFFE1B0E4);
  static const Color roxo = Color(0xFF9D00A8);
  static const Color roxoPairado = Color(0xFF8D0097);
  static const Color roxoAtivo = Color(0xFF7E0086);
  static const Color roxoEscuro = Color(0xFF76007E);
  static const Color roxoEscuroPairado = Color(0xFF5E0065);
  static const Color roxoEscuroAtivo = Color(0xFF47004C);
  static const Color roxoBlecaute = Color(0xFF37003B);

  //Tons de cinza
  static const Color cinzaClaro = Color(0xFFF5F5F5);
  static const Color cinzaClaroPairado = Color(0xFFF0F0F0);
  static const Color cinzaClaroAtivo = Color(0xFFE1E1E1);
  static const Color cinza = Color(0xFF9E9E9E);
  static const Color cinzaPairado = Color(0xFF8E8E8E);
  static const Color cinzaAtivo = Color(0xFF7E7E7E);
  static const Color cinzaEscuro = Color(0xFF777777);
  static const Color cinzaEscuroPairado = Color(0xFF5F5F5F);
  static const Color cinzaEscuroAtivo = Color(0xFF474747);
  static const Color cinzaBlecaute = Color(0xFF373737);

  //Tons de vermelho
  static const Color vermelho = Color(0xFFFF0000);
  static const Color vermelhoHover = Color(0xFFE60000);

  //Tons de verde
  static const Color verde = Color(0xFF01EF31);
  static const Color verdePairado = Color(0xFF01D72C);

  //Branco e preto
  static const Color transparente = Color(0x00000000);
  static const Color branco = Color(0xFFFFFFFF);
  static const Color preto = Color(0xFF000000);
}
