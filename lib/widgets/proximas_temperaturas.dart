import 'package:flutter/material.dart';
import 'package:sera_que_chove/models/previsao_hora.dart';


class ProximasTemperaturas extends StatelessWidget {
  final List<PrevisaoHora> previsoes;

  const ProximasTemperaturas({super.key, required this.previsoes});

  Card criarCardPrevisao(int i) {
  return Card(
    // color: Colors.transparent,
    child: Container(
      width: 130, // Defina a largura máxima desejada para o card
      child: Wrap(
        //alignment: WrapAlignment.start,
        //direction: Axis.horizontal,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('images/${previsoes[i].numeroIcone}.png'),
                width: 120, // Defina a largura desejada
                height: 120, // Defina a altura desejada
              ),
              SizedBox(width: 20),
              Padding(padding: EdgeInsets.all(2)),
              Text(
                previsoes[i].horario,
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(width: 10),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                '${previsoes[i].temperatura.toStringAsFixed(0)}ºC',
                style: TextStyle(fontSize: 25),
              ),
              SizedBox(width: 10),
              Padding(padding: EdgeInsets.all(5)),
              Text(
                previsoes[i].descricao,
                style: TextStyle(fontSize: 13),
                softWrap: true, // Permite a quebra de linha
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 3),
            ],
          ),
        ],
      ),
    ),
  );
}


  // @override
  // Widget build(BuildContext context) {
  //   return Expanded(
  //     child: ListView.builder(
  //       itemCount: previsoes.length,
  //       shrinkWrap: true,
  //       itemBuilder: (context, i) {
  //         return criarCardPrevisao(i);
  //       },
  //     ),
  //   );
  // }
  Widget build(BuildContext context) {
  return Expanded(
    child: ListView(
      scrollDirection: Axis.horizontal,
      children: [
        for (int i = 0; i < previsoes.length; i++)
          Padding(
            padding: EdgeInsets.all(8),
            child: criarCardPrevisao(i),
          ),
      ],
    ),
  );
}

}

