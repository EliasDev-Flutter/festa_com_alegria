import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CampoTextoPersonalizado extends StatefulWidget {
  const CampoTextoPersonalizado({
    super.key,
    this.formatadores,
    this.exemplo,
    required this.titulo,
    this.teclado = TextInputType.text,
    this.expansivo,
    this.controller,
    this.aoPressionar,
    this.somenteLeitura = false,
    this.linhasMaximas = 1,
    this.capitalizacao = .none,
  });

  @override
  State<CampoTextoPersonalizado> createState() => _CampoTextoPersonalizadoState();
  final String titulo;
  final TextEditingController? controller;
  final TextInputType teclado;
  final bool? expansivo;
  final String? exemplo;
  final List<TextInputFormatter>? formatadores;
  final VoidCallback? aoPressionar;
  final bool somenteLeitura;
  final int linhasMaximas;
  final TextCapitalization capitalizacao;
}

class _CampoTextoPersonalizadoState extends State<CampoTextoPersonalizado> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(widget.titulo),
        SizedBox(height: 2),
        TextFormField(
          textCapitalization: widget.capitalizacao,
          maxLines: widget.linhasMaximas,
          readOnly: widget.somenteLeitura,
          onTap: widget.aoPressionar,
          controller: widget.controller,
          inputFormatters: widget.formatadores,
          onTapOutside: (event) {
            FocusScope.of(context).unfocus();
          },
          textInputAction: .next,
          keyboardType: widget.teclado,
          expands: widget.expansivo ?? false,
          decoration: InputDecoration(
            hintText: widget.exemplo,
            fillColor: AppCores.violetaClaroPairado,
            filled: true,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppCores.violeta),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppCores.violeta),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: AppCores.violeta),
            ),
          ),
        ),
      ],
    );
  }
}
