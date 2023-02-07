import 'package:app_veterinaria/Pages/Formularios/Gado/CadastroGado.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class GadoList extends StatefulWidget {
  const GadoList({super.key});

  @override
  State<GadoList> createState() => _GadoListState();
}

class _GadoListState extends State<GadoList> {
  List _gados = [];

  _readAllNotes() async {
    final notes = await gadoDatabase.readAllNotes('gado');
    setState(() {
      _gados = notes;
    });
  }

  @override
  void initState() {
    super.initState();
    _readAllNotes();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _readAllNotes(); // Método para atualizar os dados da tela
    });
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Listagem de Gado'),
            backgroundColor: Colors.grey[800],
          ),
          body: Container(
            decoration: BoxDecoration(
              color: Colors.grey[850],
            ),
            child: Column(
              children: [
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 35,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Procurar...",
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 15, top: -10)),
                            ),
                          ),
                        ),
                        ElevatedButton(
                          child: Text("Filtrar!"),
                          style: OutlinedButton.styleFrom(
                            backgroundColor: Colors.black,
                            primary: Colors.amberAccent, //<-- SEE HERE
                          ),
                          onPressed: () async {
                            final itens = await gadoDatabase.readNote('gado');
                            setState(() {
                              _gados = itens as List;
                            });
                            // adicione o código de filtragem aqui
                          },
                        ),
                      ],
                    )),
                Expanded(
                  child: buildGadoList(),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // adicione o código para abrir a página de cadastro aqui
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CadastroGado()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 187, 174, 0),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat),
    );
  }

  buildGadoList() {
    return ListView(
      children: _gados
          .map((gado) => ListTile(
                //leading: Icon(Icons.add_a_photo),
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            gado.nome == null || gado.nome == ""
                                ? "XXX-XXX"
                                : gado.nome,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            gado.numero == null || gado.numero == ""
                                ? "000-000"
                                : gado.numero,
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CadastroGado(
                                          gado: gado,
                                        )),
                              )
                            },
                            icon: Icon(Icons.edit),
                            color: Color.fromARGB(255, 20, 122, 16),
                          ),
                          IconButton(
                            onPressed: () => {
                              gadoDatabase.delete(gado.id, 'gado'),
                              setState(() {
                                _readAllNotes();
                              })
                            },
                            icon: Icon(Icons.delete),
                            color: Color.fromARGB(255, 189, 18, 18),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ))
          .toList(),
    );
  }
}
