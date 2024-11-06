import 'package:flutter/material.dart';

class EntradaDiarioFormScreen extends StatefulWidget {
  final String viagemId;

  EntradaDiarioFormScreen({required this.viagemId});

  @override
  _EntradaDiarioFormScreenState createState() => _EntradaDiarioFormScreenState();
}

class _EntradaDiarioFormScreenState extends State<EntradaDiarioFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _conteudoController = TextEditingController();

  @override
  void dispose() {
    _tituloController.dispose();
    _dataController.dispose();
    _conteudoController.dispose();
    super.dispose();
  }

  void _saveEntradaDiario() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode implementar o código para salvar os dados da entrada de diário
      // Pode incluir uma requisição ao backend JSON server para adicionar a entrada
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nova Entrada de Diário'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: InputDecoration(labelText: 'Título'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o título';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _dataController,
                decoration: InputDecoration(labelText: 'Data'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira a data';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _conteudoController,
                decoration: InputDecoration(labelText: 'Conteúdo'),
                maxLines: 5,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, insira o conteúdo';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveEntradaDiario,
                child: Text('Salvar Entrada'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}