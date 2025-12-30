import 'package:flutter/material.dart';

class ImprevistosTela extends StatefulWidget {
  const ImprevistosTela({super.key});

  @override
  State<ImprevistosTela> createState() => _ImprevistosTelaState();
}

class _ImprevistosTelaState extends State<ImprevistosTela> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Imprevistos')),
      body: Container(),
    );
  }
}
