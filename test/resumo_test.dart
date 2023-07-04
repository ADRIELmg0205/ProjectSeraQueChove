import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sera_que_chove/controllers/tema_controller.dart';
import 'package:sera_que_chove/widgets/resumo.dart';

void main() {
  testWidgets('Teste de construção do widget Resumo', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: Resumo(
            cidade: 'São Paulo',
            descricao: 'Ensolarado',
            temperaturaAtual: 30.0,
            temperaturaMaxima: 35.0,
            temperaturaMinima: 25.0,
            numeroIcone: 1,
          ),
        ),
      ),
    );

    // Verifica se o widget Resumo foi construído corretamente
    expect(find.text('São Paulo'), findsOneWidget);
    expect(find.text('Ensolarado'), findsOneWidget);
    expect(find.text('30 ºC'), findsOneWidget);
    expect(find.text('35 ºC'), findsOneWidget);
    expect(find.text('25 ºC'), findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    // Verifica se o valor do tema escuro está correto
    expect(TemaController.instancia.usarTemaEscuro, false);

    // Simula a interação com o Switch de tema escuro
    await tester.tap(find.byType(Switch));
    await tester.pump();

    // Verifica se o valor do tema escuro foi alterado
    expect(TemaController.instancia.usarTemaEscuro, true);
  });
}
