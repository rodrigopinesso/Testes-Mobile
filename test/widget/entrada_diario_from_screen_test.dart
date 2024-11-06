import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:crud_viagem/screens/entrada_diario_form_screen.dart';  
import 'package:flutter/services.dart';

void main() {
  testWidgets('EntradaDiarioFormScreen widget test', (WidgetTester tester) async {

    await tester.pumpWidget(MaterialApp(
      home: EntradaDiarioFormScreen(viagemId: '123'),  
    ));

    expect(find.byType(TextFormField), findsNWidgets(3)); 
    expect(find.byType(ElevatedButton), findsOneWidget);  

    expect(find.text('Título'), findsOneWidget);
    expect(find.text('Data'), findsOneWidget);
    expect(find.text('Conteúdo'), findsOneWidget);

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump(); 

    expect(find.text('Por favor, insira o título'), findsOneWidget);
    expect(find.text('Por favor, insira a data'), findsOneWidget);
    expect(find.text('Por favor, insira o conteúdo'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).first, 'Título de Teste');
    await tester.enterText(find.byType(TextFormField).at(1), '01/01/2024');
    await tester.enterText(find.byType(TextFormField).last, 'Conteúdo da entrada de diário.');

    await tester.tap(find.byType(ElevatedButton));
    await tester.pump();  

    expect(find.byType(EntradaDiarioFormScreen), findsNothing);  
  });
}
