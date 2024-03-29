import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sera_que_chove/controllers/cidade_controller.dart';
import 'package:sera_que_chove/models/cidade.dart';
import 'package:sera_que_chove/models/previsao_hora.dart';
import 'package:sera_que_chove/services/previsao_service.dart';
import 'package:sera_que_chove/widgets/configuracoes.dart';
import 'package:sera_que_chove/widgets/proximas_temperaturas.dart';
import 'package:sera_que_chove/widgets/resumo.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<PrevisaoHora>> ultimasPrevisoes;
  late Future<List<Cidade>> cidades;

  @override
  void initState() {
    super.initState();
    carregarPrevisoes();
  }

  void carregarPrevisoes() {
    PrevisaoService service = PrevisaoService();
    ultimasPrevisoes = service.recuperarUltimasPrevisoes();
  }

  Future<Null> atualizarPrevisoes() async {
    setState(() => carregarPrevisoes());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            AppLocalizations.of(context)!.name,
            style: TextStyle(fontSize: 30),
          ),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => Configuracoes()),
              );
            },
            child: Icon(
              Icons.arrow_back_outlined, // add custom icons also
            ),
          )),
      body: RefreshIndicator(
        onRefresh: atualizarPrevisoes,
        child: Center(
          child: FutureBuilder<List<PrevisaoHora>>(
            future: ultimasPrevisoes,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<PrevisaoHora> previsoes = snapshot.data!;
                double temperaturaAtual = previsoes[0].temperatura;
                double menorTemperatura = double.maxFinite;
                double maiorTemperatura = double.negativeInfinity;
                previsoes.forEach((obj) {
                  if (obj.temperatura < menorTemperatura) {
                    menorTemperatura = obj.temperatura;
                  }

                  if (obj.temperatura > maiorTemperatura) {
                    maiorTemperatura = obj.temperatura;
                  }
                });

                String descricao = previsoes[0].descricao;
                int numeroIcone = previsoes[0].numeroIcone;

                return Column(
                  children: [
                    Resumo(
                      cidade: CidadeController.instancia.cidadeEscolhida!.nome,
                      temperaturaAtual: temperaturaAtual,
                      temperaturaMaxima: maiorTemperatura,
                      temperaturaMinima: menorTemperatura,
                      descricao: descricao,
                      numeroIcone: numeroIcone,
                    ),
                    Padding(padding: EdgeInsets.all(10)),
                    ProximasTemperaturas(
                      previsoes: previsoes.sublist(1, previsoes.length),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return Text(AppLocalizations.of(context)!.forecast_error,);
              }

              return CircularProgressIndicator();
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            atualizarPrevisoes();
          },
          icon: const Icon(Icons.refresh),
          label: Text(AppLocalizations.of(context)!.update,)),
    );
  }
}
