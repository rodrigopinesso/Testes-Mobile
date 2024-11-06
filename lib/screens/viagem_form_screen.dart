import 'package:flutter/material.dart';
import '../models/viagem.dart';
import '../services/viagem_service.dart';

class ViagemFormScreen extends StatefulWidget {
  @override
  _ViagemFormScreenState createState() => _ViagemFormScreenState();
}

class _ViagemFormScreenState extends State<ViagemFormScreen> {
  final ViagemService _viagemService = ViagemService();
  final _formKey = GlobalKey<FormState>();
  String _nome = '';
  String _destino = '';
  String _descricao = '';

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      final novaViagem = Viagem(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Deixe vazio pois o JSON Server irá gerar o ID
        nome: _nome,
        dataInicio: DateTime.now(),
        dataFim: DateTime.now(),
        destino: _destino,
        descricao: _descricao,
      );
      await _viagemService.addViagem(novaViagem);
      Navigator.pop(context); // Volta para a tela de listagem
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Nova Viagem')),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome'),
                onChanged: (value) => _nome = value,
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Destino'),
                onChanged: (value) => _destino = value,
                validator: (value) => value!.isEmpty ? 'Informe o destino' : null,
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Descrição'),
                onChanged: (value) => _descricao = value,
                validator: (value) => value!.isEmpty ? 'Informe a descrição' : null,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: Text('Salvar Viagem'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}