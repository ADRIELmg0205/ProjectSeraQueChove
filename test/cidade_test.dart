import 'package:flutter_test/flutter_test.dart';
import 'package:sera_que_chove/models/cidade.dart';

void main() {
  test('Teste do método toString', () {//teste 01
    final cidade = Cidade('São Paulo', 'São Paulo', 'SP');
    final resultado = cidade.toString();
    expect(resultado, 'Cidade{id: 1, codigo: , nome: São Paulo, estado: São Paulo, siglaEstado: SP}');
  });

  test('Teste do método toMap', () {//teste 02
    final cidade = Cidade('São Paulo', 'São Paulo', 'SP');
    final resultado = cidade.toMap();
    expect(resultado, {
      'id': 1,
      'codigo': '',
      'nome': 'São Paulo',
      'estado': 'São Paulo',
      'siglaEstado': 'SP'
    });
  });

  test('Teste do método transformarJSON', () {//teste 03
    final objJson = {
      'Key': '123',
      'LocalizedName': 'São Paulo',
      'AdministrativeArea': {
        'LocalizedName': 'São Paulo',
        'ID': 'SP'
      }
    };

    final cidade = Cidade.transformarJSON(objJson);

    expect(cidade.codigo, '123');
    expect(cidade.nome, 'São Paulo');
    expect(cidade.estado, 'São Paulo');
    expect(cidade.siglaEstado, 'SP');
  });
}


//Testes criados:

////teste 01: verifica se o método toString retorna a representação em string correta da instância da classe Cidade.

////teste 02: verifica se o método toMap retorna o mapeamento correto dos atributos da instância da classe Cidade para um Map<String, dynamic>.

////teste 03: verifica se o método estático transformarJSON retorna uma instância da classe Cidade corretamente populada com os valores do objeto JSON fornecido.