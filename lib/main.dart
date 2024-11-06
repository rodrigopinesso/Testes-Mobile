// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp()); // A chamada aqui deve ser com "const"
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Adicionando o modificador "const"

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Diário de Viagem',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(), // Define HomeScreen como tela inicial
    );
  }
}
