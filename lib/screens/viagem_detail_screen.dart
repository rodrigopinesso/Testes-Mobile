import 'package:flutter/material.dart';
import '../models/viagem.dart';
import '../models/entrada_diario.dart';
import '../services/viagem_service.dart';
import 'entrada_diario_list_screen.dart';

class ViagemDetailScreen extends StatelessWidget {
    final Viagem viagem;
    final ViagemService _viagemService = ViagemService();

    ViagemDetailScreen({required this.viagem});

    @override
    Widget build (BuildContext context) {
        return Scaffold (
            appBar: AppBar (title: Text(viagem.nome)),
            body: Column (
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Padding (
                        padding: const EdgeInsets.all(8.0),
                        child: Text ('Destino: ${viagem.destino}', style: TextStyle(fontSize: 18)),
                    ),
                    Padding (
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Descrição: ${viagem.descricao}', style: TextStyle(fontSize: 16)),
                    ),
                    ElevatedButton (
                        onPressed: () {
                            Navigator.push (
                                context, 
                                MaterialPageRoute(
                                    builder: (context) => EntradaDiarioListScreen(viagemId: viagem.id),
                                ),
                            );
                        },
                        child: Text ('Ver entradas do diário'),
                    ),
                ],
            ),
        );
    }
}