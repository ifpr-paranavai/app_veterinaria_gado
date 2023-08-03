import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Pages/Formularios/Historic/HistoricRegistration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

final database = NotesDatabase.instance;

class ListagemDeQualificacaoComValoresPorAnimal extends StatefulWidget {
  final animalId;
  const ListagemDeQualificacaoComValoresPorAnimal(
      {super.key, required this.animalId});

  @override
  State<ListagemDeQualificacaoComValoresPorAnimal> createState() =>
      _ListagemDeQualificacaoComValoresPorAnimalState();
}

class _ListagemDeQualificacaoComValoresPorAnimalState
    extends State<ListagemDeQualificacaoComValoresPorAnimal> {
  List historicos = [];

  var _animalidentificador;

  TextEditingController _filterInput = TextEditingController();

  _fetchDataHistorico() async {
    final relatorios = await database.readAllNotes('qualificacao_por_animal',
        identificador: _animalidentificador);
    setState(() {
      historicos = relatorios;
    });
  }

  @override
  void initState() {
    super.initState();
    _animalidentificador = widget.animalId;
    _fetchDataHistorico();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Relatorio de qualidade'),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          Container(
            decoration: BoxDecoration(),
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
                            color: Color.fromARGB(255, 209, 203, 203),
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: "Procurar...",
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(left: 15, top: -10),
                            ),
                            controller: _filterInput,
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
                          final itens = await database.readNote(
                              'qualificacao_por_animal', _filterInput.text);
                          if (itens is List) {
                            setState(
                              () {
                                historicos = itens;
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                buildListagemDeQualificacaoComValoresPorAnimal(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HistoricRegistration()),
          ).then((value) => {
                if (value == null) {_fetchDataHistorico()}
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 187, 174, 0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  buildListagemDeQualificacaoComValoresPorAnimal() {
    return Card(
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            tileColor: Colors.grey[300],
            title: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.08),
              child: Text(
                'Data',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Qualidade',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 60),
                Text(
                  'editar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'Excluir',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 40),
          ),
          ...historicos
              .asMap()
              .map(
                (index, object) => MapEntry(
                  index,
                  Container(
                    color: index % 2 == 0
                        ? Color.fromARGB(167, 64, 177, 108)
                        : Color.fromARGB(255, 155, 165, 151),
                    child: ListTile(
                      //leading: Icon(Icons.add_a_photo),
                      title: Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  object.identificadorAnimal,
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
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
                                  object.valor != "-" &&
                                          int.parse(object.valor) < 180
                                      ? "Sadia(${object.valor})"
                                      : object.valor != "-" &&
                                              int.parse(object.valor) >= 180 &&
                                              int.parse(object.valor) <= 200
                                          ? "Problema(${object.valor})"
                                          : "${object.valor}",
                                  style: TextStyle(
                                    color: object.valor != "-" &&
                                            int.parse(object.valor) < 180
                                        ? Color.fromARGB(255, 115, 254, 0)
                                        : object.valor != "-" &&
                                                int.parse(object.valor) >=
                                                    180 &&
                                                object.valor != "-" &&
                                                int.parse(object.valor) <= 200
                                            ? Color.fromARGB(255, 218, 218, 0)
                                            : Color.fromARGB(255, 254, 0, 42),
                                  ),
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
                                          builder: (context) =>
                                              HistoricRegistration(
                                                historico: object,
                                              )),
                                    ).then((value) => {
                                          if (value == null)
                                            {
                                              setState(() {
                                                _fetchDataHistorico();
                                              })
                                            }
                                        }),
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Color.fromARGB(255, 20, 122, 16),
                                ),
                                IconButton(
                                  onPressed: () => {
                                    database.delete(object.id, 'historico'),
                                    setState(() {
                                      _fetchDataHistorico();
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
                    ),
                  ),
                ),
              )
              .values
              .toList(),
        ],
      ),
    );
  }
}
