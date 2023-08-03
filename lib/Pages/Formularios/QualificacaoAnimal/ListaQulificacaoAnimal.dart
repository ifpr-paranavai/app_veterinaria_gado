import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Pages/Formularios/Historic/HistoricRegistration.dart';
import 'package:app_veterinaria/Pages/Formularios/QualificacaoAnimal/ListaDeQualificacaoComValoresPorAnimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

final database = NotesDatabase.instance;

class ListagemQualificacaoAnimal extends StatefulWidget {
  final animalId = 0;
  final farmId;
  const ListagemQualificacaoAnimal({super.key, required this.farmId});

  @override
  State<ListagemQualificacaoAnimal> createState() =>
      _ListagemQualificacaoAnimalState();
}

class _ListagemQualificacaoAnimalState
    extends State<ListagemQualificacaoAnimal> {
  List historicos = [];

  var _animalid;
  var _farmId;

  TextEditingController _filterInput = TextEditingController();

  _fetchData() async {
    final animais = await database.readAllNotes(
        'excel_qualificacao_animal_individual',
        animalId: _farmId.id);
    setState(() {
      historicos = animais;
    });
  }

  @override
  void initState() {
    super.initState();
    _farmId = widget.farmId;
    _animalid = widget.animalId;
    _fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Qualificacao Animal'),
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
                              'historico', _filterInput.text);
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
                buildListagemHistorico(),
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
                if (value == null) {_fetchData()}
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 187, 174, 0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  buildListagemHistorico() {
    return Card(
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            tileColor: Colors.grey[300],
            title: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.14),
              child: Text(
                'Identificador',
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
                  'Selecionar',
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
                        ? Color.fromARGB(167, 32, 121, 66)
                        : Color.fromARGB(255, 202, 231, 190),
                    child: ListTile(
                      //leading: Icon(Icons.add_a_photo),
                      title: Row(
                        children: [
                          Expanded(
                            flex: 2,
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
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left:
                                      40.0), // Define a margem esquerda desejada aqui
                              child: Row(
                                children: [
                                  IconButton(
                                    onPressed: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ListagemDeQualificacaoComValoresPorAnimal(
                                          animalId: object.identificadorAnimal,
                                        ),
                                      ),
                                    ).then((value) => {
                                          if (value == null)
                                            {_fetchData()}
                                        }),
                                    icon: Icon(Icons.find_in_page),
                                    color: Color.fromARGB(255, 41, 16, 122),
                                  ),
                                  // Restante do código...
                                ],
                              ),
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
