import 'package:flutter/material.dart';
import '../../DataBase/notes_database.dart';

final database = NotesDatabase.instance;

class Synchronize extends StatelessWidget {
  final farm;
  const Synchronize({super.key, required this.farm});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tela de Sincronização',
      home: TelaSincronizacao(farm: farm),
      debugShowCheckedModeBanner: false, // Passando farm para TelaSincronizacao
    );
  }
}

class TelaSincronizacao extends StatefulWidget {
  final farm; // Definindo a variável farm
  const TelaSincronizacao({super.key, required this.farm});

  @override
  _TelaSincronizacaoState createState() => _TelaSincronizacaoState();
}

class _TelaSincronizacaoState extends State<TelaSincronizacao> {
  late final _farm; // Declaração de _farm
  bool _estaSincronizando = false;

  @override
  void initState() {
    super.initState();
    _farm = widget.farm;
  }

  void sincronizarDados() async {
    setState(() {
      _estaSincronizando = true;
    });

    // Lógica de sincronização de dados
    await database.create(_farm.id, 'sincronizar'); // Usando _farm

    setState(() {
      _estaSincronizando = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Dados sincronizados com sucesso!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sincronizar Dados'),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: _estaSincronizando
            ? CircularProgressIndicator()
            : Text('Pressione o botão para sincronizar'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _estaSincronizando ? null : sincronizarDados,
        child: Icon(Icons.sync),
        tooltip: 'Sincronizar Dados',
      ),
    );
  }
}
