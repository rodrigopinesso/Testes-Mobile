import 'package:flutter/material.dart';
import '../models/viagem.dart';
import '../services/viagem_service.dart';
import 'viagem_form_screen.dart';
import 'viagem_detail_screen.dart';

class ViagemListScreen extends StatefulWidget {
  @override
  _ViagemListScreenState createState() => _ViagemListScreenState();
}

class _ViagemListScreenState extends State<ViagemListScreen> {
  final ViagemService _viagemService = ViagemService();
  List<Viagem> _viagens = [];

  @override
  void initState() {
    super.initState();
    _fetchViagens();
  }

  Future<void> _fetchViagens() async {
    try {
      final viagens = await _viagemService.getViagens();
      setState(() {
        _viagens = viagens;
      });
    } catch (e) {
      print('Erro ao buscar viagens: $e');
    }
  }

  Future<void> _deleteViagem(String id) async {
    try {
      await _viagemService.deleteViagem(id);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Viagem excluída com sucesso')),
      );
      _fetchViagens(); // Atualiza a lista após a exclusão
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro ao excluir a viagem: $e')),
      );
    }
  }

  void _navigateToForm() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ViagemFormScreen()),
    );
    _fetchViagens();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Minhas Viagens')),
      body: ListView.builder(
        itemCount: _viagens.length,
        itemBuilder: (context, index) {
          final viagem = _viagens[index];
          return ListTile(
            title: Text(viagem.nome),
            subtitle: Text(viagem.destino),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViagemDetailScreen(viagem: viagem),
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text('Confirmar exclusão'),
                    content: Text('Tem certeza de que deseja excluir esta viagem?'),
                    actions: [
                      TextButton(
                        child: Text('Cancelar'),
                        onPressed: () => Navigator.of(context).pop(false),
                      ),
                      TextButton(
                        child: Text('Excluir'),
                        onPressed: () => Navigator.of(context).pop(true),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  await _deleteViagem(viagem.id);
                }
              },
            ),
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
