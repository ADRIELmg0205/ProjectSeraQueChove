import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:sera_que_chove/controllers/cidade_controller.dart';
import 'package:sera_que_chove/models/cidade.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';
import 'package:logger/logger.dart';

class CidadeService {
  final String baseUrlAPI = 'dataservice.accuweather.com';
  final String path = '/locations/v1/cities/search';
  final Map<String, String> params = {
    'apikey': dotenv.env['API_KEY']!,
    'language': 'pt-BR'
  };

  Future<void> pesquisarCidade(String filtro) async {
  var logger = Logger();

  logger.d('Parâmetro filtro: $filtro');

  params['q'] = filtro;

  final Response resposta = await get(Uri.https(baseUrlAPI, path, params));

 //logger.d('URL da API: ${resposta.request.url}');
  logger.d('Código de status da resposta: ${resposta.statusCode}');
  logger.d('Corpo da resposta: ${resposta.body}');

  if (resposta.statusCode == 200) {
    Iterable it = await json.decode(resposta.body);
    Cidade cidade = Cidade.transformarJSON(it.first);
    CidadeController.instancia.trocarCidade(cidade);
  } else {
    throw Exception('Erro ao tentar pesquisar a cidade');
  }
}


  Future<List<Cidade>> recuperarCidades() async {
    final String resposta = await rootBundle.loadString("data/cidades.json");
    final dados = await json.decode(resposta);
    List<Cidade> cidadesCarregadas = [];
    final List<dynamic> estados = dados["estados"];
    estados.forEach((estado) {
      final String nomeEstado = estado["nome"];
      final String siglaEstado = estado["sigla"];
      final List<dynamic> cidadesDoEstado = estado["cidades"];
      cidadesDoEstado.forEach((nomeCidade) {
        final Cidade cidade = Cidade(nomeCidade, nomeEstado, siglaEstado);
        cidadesCarregadas.add(cidade);
      });
    });

    /**
     * Realiza a ordenação das cidades em ordem alfabética
     */
    cidadesCarregadas.sort((a, b) => a.nome.compareTo(b.nome));

    return cidadesCarregadas;
  }
}
