import 'package:flutter/material.dart';
import '../models/entrada_diario.dart';
import '../services/viagem_service.dart';
import 'entrada_diario_from_screen.dart';

class EntradaDiarioListScreen extends StatefulWidget {
  final String viagemId;

  EntradaDiarioListScreen({required this.viagemId});

  @override
  _EntradaDiarioListScreenState createState() => _EntradaDiarioListScreenState();
}

class _EntradaDiarioListScreenState extends State<EntradaDiarioListScreen> {
  final ViagemService _viagemService = ViagemService();
  List<EntradaDiario> _entradas = [];

  @override
  void initState() {
    super.initState();
    _fetchEntradas();
  }

  Future<void> _fetchEntradas() async {
    try {
      final entradas = await _viagemService.getEntradasPorViagem(widget.viagemId);
      setState(() {
        _entradas = entradas;
      });
    } catch (e) {
      print('Erro ao carregar entradas: $e');
    }
  }

  void _navigateToForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EntradaDiarioFormScreen(viagemId: widget.viagemId)),
    );
    _fetchEntradas();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Entradas do Diário')),
      body: ListView.builder(
        itemCount: _entradas.length,
        itemBuilder: (context, index) {
          final entrada = _entradas[index];
          return ListTile(
            title: Text(entrada.titulo),
            subtitle: Text(entrada.conteudo),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToForm,
        child: Icon(Icons.add),
      ),
    );
  }
}