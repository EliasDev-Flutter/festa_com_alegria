import 'package:flutter/material.dart';

class AgendaTela extends StatefulWidget {

  const AgendaTela({ super.key });

  @override
  State<AgendaTela> createState() => _AgendaTelaState();
}

class _AgendaTelaState extends State<AgendaTela> {

   @override
   Widget build(BuildContext context) {
       return Scaffold(
           appBar: AppBar(title: const Text('Agenda'),),
           body: Container(),
       );
  }
}