import 'package:flutter/material.dart';
import 'package:sera_que_chove/models/previsao_hora.dart';

class ProximasTemperaturas extends StatelessWidget {
  final List<PrevisaoHora> previsoes;

  const ProximasTemperaturas({super.key, required this.previsoes});

  Card criarCardPrevisao(int i) {
    return Card(
     // color: Colors.transparent,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(image: AssetImage('images/${previsoes[i].numeroIcone}.png'),
              width: 50, // Defina a largura desejada
              height: 50, // Defina a altura desejada
              ),
          Padding(padding: EdgeInsets.all(2)),
          Text(previsoes[i].horario),
          Padding(padding: EdgeInsets.all(5)),
          Text('${previsoes[i].temperatura.toStringAsFixed(0)}ºC'),
          Padding(padding: EdgeInsets.all(5)),
          Text(previsoes[i].descricao),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: previsoes.length,
        shrinkWrap: true,
        itemBuilder: (context, i) {
          return criarCardPrevisao(i);
        },
      ),
    );
  }
}
