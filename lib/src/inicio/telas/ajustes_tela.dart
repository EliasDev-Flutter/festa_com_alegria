// ignore_for_file: use_build_context_synchronously

import 'package:festa_com_alegria/utils/app_cores.dart';
import 'package:festa_com_alegria/utils/app_icones.dart';
import 'package:festa_com_alegria/utils/app_sons.dart';
import 'package:festa_com_alegria/utils/app_textos.dart';
import 'package:festa_com_alegria/utils/app_tipografias.dart';
import 'package:festa_com_alegria/widgets%20globais/topo_base.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AjustesTela extends StatefulWidget {
  const AjustesTela({super.key});

  @override
  State<AjustesTela> createState() => _AjustesTelaState();
}

class _AjustesTelaState extends State<AjustesTela> {
  bool efeitoSonoro = true;
  bool introducao = false;
  bool notificacoes = false;

  @override
  void initState() {
    super.initState();
    _carregarPreferencias();
  }

  Future<void> _carregarPreferencias() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      efeitoSonoro = prefs.getBool('efeitoSonoro') ?? true;
      introducao = prefs.getBool('introducao') ?? false;
      notificacoes = prefs.getBool('notificacoes') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopoBase(titulo: 'Ajustes'),
      body: Column(
        children: [
          SizedBox(height: 40),
          CupertinoListTile(
            padding: EdgeInsets.symmetric(horizontal: 20),
            leading: SvgPicture.asset(AppIcones.sons, width: 40),
            title: Text(AppTextos.efeitoSonoro, style: TextStyle(fontSize: AppTipografias.h4)),
            trailing: CupertinoSwitch(
              value: efeitoSonoro,
              onChanged: (value) async {
                final prefs = await SharedPreferences.getInstance();
                if (value) {
                  await prefs.setBool('efeitoSonoro', true);
                  setState(() => efeitoSonoro = true);
                  await AppSons.tocarSalvar();
                } else {
                  await AppSons.tocarExcluir();
                  await prefs.setBool('efeitoSonoro', false);
                  setState(() => efeitoSonoro = false);
                }
              },
            ),
          ),
          SizedBox(height: 40),
          CupertinoListTile(
            padding: EdgeInsets.symmetric(horizontal: 20),
            leading: SvgPicture.asset(AppIcones.introducao, width: 40),
            title: Text(AppTextos.introducao, style: TextStyle(fontSize: AppTipografias.h4)),
            trailing: CupertinoSwitch(
              value: introducao,
              onChanged: (value) async {
                if (value) {
                  await AppSons.tocarSalvar();
                } else {
                  await AppSons.tocarExcluir();
                }
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('introducao', value);
                setState(() {
                  introducao = value;
                });
              },
            ),
          ),
          SizedBox(height: 40),
          CupertinoListTile(
            padding: EdgeInsets.symmetric(horizontal: 20),
            leading: SvgPicture.asset(AppIcones.notificacoes, width: 40),
            title: Text(AppTextos.notificacoes, style: TextStyle(fontSize: AppTipografias.h4)),
            trailing: CupertinoSwitch(
              value: notificacoes,
              onChanged: (value) async {
                if (value) {
                  await AppSons.tocarSalvar();
                } else {
                  await AppSons.tocarExcluir();
                }
                final prefs = await SharedPreferences.getInstance();
                await prefs.setBool('notificacoes', value);
                setState(() {
                  notificacoes = value;
                });
              },
            ),
          ),
          SizedBox(height: 40),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Material(
              borderRadius: BorderRadius.circular(5),
              elevation: 3,
              child: ListTile(
                title: Text(AppTextos.horaPadrao, style: TextStyle(fontSize: AppTipografias.h6)),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
                contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                leading: SvgPicture.asset(AppIcones.pendente, width: 40),
                trailing: SvgPicture.asset(AppIcones.adicionar),
                tileColor: AppCores.cinzaClaro,
                onTap: () async {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                    builder: (context, child) {
                      return Theme(
                        data: Theme.of(context).copyWith(
                          timePickerTheme: TimePickerThemeData(
                            backgroundColor: AppCores.branco,
                            hourMinuteShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            dayPeriodBorderSide: BorderSide.none,
                            dayPeriodShape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(8)),
                            ),
                            dayPeriodColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.selected)
                                  ? AppCores.azul.withValues(alpha: 0.2)
                                  : AppCores.cinzaClaro,
                            ),
                            dayPeriodTextColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.selected)
                                  ? AppCores.azul
                                  : AppCores.preto,
                            ),
                            hourMinuteColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.selected)
                                  ? AppCores.azul.withValues(alpha: 0.1)
                                  : AppCores.cinzaClaro,
                            ),
                            hourMinuteTextColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.selected)
                                  ? AppCores.azul
                                  : AppCores.preto,
                            ),
                            dialHandColor: AppCores.azul,
                            dialBackgroundColor: AppCores.branco,
                            dialTextColor: WidgetStateColor.resolveWith(
                              (states) => states.contains(WidgetState.selected)
                                  ? AppCores.branco
                                  : AppCores.preto,
                            ),
                            entryModeIconColor: AppCores.azul,
                            confirmButtonStyle: ButtonStyle(
                              foregroundColor: WidgetStateProperty.all(AppCores.azul),
                            ),
                            cancelButtonStyle: ButtonStyle(
                              foregroundColor: WidgetStateProperty.all(AppCores.azul),
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  if (time != null && context.mounted) {
                    final prefs = await SharedPreferences.getInstance();
                    final String formattedTime =
                        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
                    await prefs.setString('horaPadrao', formattedTime);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'A hora salva foi: $formattedTime',
                          style: TextStyle(fontSize: AppTipografias.h5),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
