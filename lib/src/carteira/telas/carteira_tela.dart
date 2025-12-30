import 'package:flutter/material.dart';

class CarteiraTela extends StatefulWidget {

  const CarteiraTela({ super.key });

  @override
  State<CarteiraTela> createState() => _CarteiraTelaState();
}

class _CarteiraTelaState extends State<CarteiraTela> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Carteira'),),
           body: Container(),
       );
  }
}