import 'package:flutter/material.dart';
import 'package:sera_que_chove/controllers/cidade_controller.dart';
import 'package:sera_que_chove/controllers/tema_controller.dart';
import 'package:sera_que_chove/widgets/configuracoes.dart';
import 'package:sera_que_chove/widgets/home.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SeraQueChove extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: TemaController.instancia,
      builder: (context, child) {
        return MaterialApp(
            title: 'Será Que Chove?',
            //title: AppLocalizations.of(context)!.helloWord,
            theme: TemaController.instancia.usarTemaEscuro!
                ? ThemeData.dark()
                : ThemeData.light(),
            debugShowCheckedModeBanner: false,
            home: CidadeController.instancia.cidadeEscolhida != null
                ? Home()
                : Configuracoes(),
            routes: {
              '/home': (context) => Home(),
            },
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales);
      },
    );
  }
}
