import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:flutter/material.dart';

class CampoTextoPersonalizado extends StatefulWidget {
  const CampoTextoPersonalizado({super.key});

  @override
  State<CampoTextoPersonalizado> createState() => _CampoTextoPersonalizadoState();
}

class _CampoTextoPersonalizadoState extends State<CampoTextoPersonalizado> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(AppTextos.item),
        SizedBox(height: 2),
        TextFormField(
          decoration: InputDecoration(
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
