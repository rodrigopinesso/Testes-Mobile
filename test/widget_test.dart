// test/widget_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/main.dart'; // Supondo que o widget de contagem está no main.dart

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Carrega o widget principal do aplicativo
    await tester.pumpWidget(MyApp());

    // Verifica se o texto inicial é '0'
    expect(find.text('0'), findsOneWidget);

    // Clica no ícone de incremento
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verifica se o texto foi alterado para '1'
    expect(find.text('1'), findsOneWidget);
  });
}
