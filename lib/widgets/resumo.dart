import 'package:flutter/material.dart';
import 'package:sera_que_chove/controllers/tema_controller.dart';

class Resumo extends StatelessWidget {
  final String cidade;
  final String descricao;
  final double temperaturaAtual;
  final double temperaturaMaxima;
  final double temperaturaMinima;
  final int numeroIcone;

  const Resumo({
    super.key,
    required this.cidade,
    required this.descricao,
    required this.temperaturaAtual,
    required this.temperaturaMaxima,
    required this.temperaturaMinima,
    required this.numeroIcone,
  });

  @override
  Widget build(BuildContext context) {
    String fundo;
    String icone;
    if (numeroIcone < 3) {
      fundo = 'sol';
      icone = 'sol.gif';
    } else if (numeroIcone >= 3 && numeroIcone <= 6) {
      fundo = 'sol';
      icone = 'solnublado.png';
    } else if (numeroIcone >= 7 && numeroIcone <= 11) {
      fundo = 'nublado';
      icone = 'nublado.png';
    } else if (numeroIcone >= 12 && numeroIcone <= 29) {
      fundo = 'chuva';
      icone = 'chuva.png';
    } else if (numeroIcone >= 30 && numeroIcone <= 34) {
      fundo = 'noite';
      icone = 'noite.png';
    } else if (numeroIcone >= 35 && numeroIcone <= 38) {
      fundo = 'noite';
      icone = 'noitenublado.png';
    } else {
      fundo = 'chuva';
      icone = 'chuva.png';
    }
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          opacity: 0.5,
          image: AssetImage(
            'images/$fundo.png',
          ), // Substitua 'background_image.png' pelo caminho da sua imagem de fundo.
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(padding: EdgeInsets.all(5)),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Column(
                children: [
                  Icon(Icons.brightness_6_outlined),
                  Switch(
                    value: TemaController.instancia.usarTemaEscuro!,
                    onChanged: (valor) {
                      TemaController.instancia.trocarTema();
                    },
                  ),
                ],
              ),
            ],
          ),
          Text(
            cidade,
            style: TextStyle(fontSize: 30),
          ),
          Padding(padding: EdgeInsets.all(5)),
          IntrinsicHeight(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image(
                  image: AssetImage(
                    'images/principal/$icone',
                  ),
                  width: 120, // Defina a largura desejada
                  height: 120, // Defina a altura desejada
                ),
                Padding(padding: EdgeInsets.all(2)),
                Text(
                  '${temperaturaAtual.toStringAsFixed(0)} ºC',
                  style: TextStyle(fontSize: 70),
                ),
                VerticalDivider(
                  color: Colors.black,
                  thickness: 1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${temperaturaMaxima.toStringAsFixed(0)} ºC',
                      style: TextStyle(fontSize: 25),
                    ),
                    Text(
                      '${temperaturaMinima.toStringAsFixed(0)} ºC',
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.all(10)),
          Text(
            descricao,
            style: TextStyle(fontSize: 25),
          ),
          const SizedBox(height: 90),
        ],
      ),
    );
  }
}
