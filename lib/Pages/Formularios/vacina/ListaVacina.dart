import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Pages/Formularios/Pesagem/CadastroPesagem.dart';
import 'package:app_veterinaria/Pages/Formularios/vacina/CadastroVacina.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

final database = NotesDatabase.instance;

class ListaVacina extends StatefulWidget {
  final animalId;
  const ListaVacina({super.key, required this.animalId});

  @override
  State<ListaVacina> createState() => _ListaVacinaState();
}

class _ListaVacinaState extends State<ListaVacina> {
  List _vacinas = [];

  var _animalid;

  TextEditingController _filterInput = TextEditingController();

  _fetchDataVacina() async {
    final animais = await database.readAllNotes('vacina', animalId: _animalid);
    setState(() {
      _vacinas = animais;
    });
  }

  @override
  void initState() {
    super.initState();
    _animalid = widget.animalId;
    _fetchDataVacina();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Vacinas do animal'),
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
                              'pesagem', _filterInput.text);
                          if (itens is List) {
                            setState(
                              () {
                                _vacinas = itens;
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                buildListaVacina(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    CadastroVacina(animalIdPrecinonado: widget.animalId)),
          ).then((value) => {
                if (value == null) {_fetchDataVacina()}
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 187, 174, 0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  buildListaVacina() {
    return Card(
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            tileColor: Colors.grey[300],
            title: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.04),
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
                  'Nome',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 50),
                Text(
                  'Editar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 20),
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
          ..._vacinas
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
                            flex: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  convertDat(object.dataAplicacao),
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
                                  object.nome == null || object.nome == ""
                                      ? "00.00"
                                      : object.nome.toString(),
                                  //style: TextStyle(color: Colors.white),
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
                                          builder: (context) => CadastroVacina(
                                                vacina: object,
                                                animalIdPrecinonado: _animalid,
                                              )),
                                    ).then((value) => {
                                          if (value == null)
                                            {_fetchDataVacina()}
                                        })
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Color.fromARGB(255, 20, 122, 16),
                                ),
                                IconButton(
                                  onPressed: () => {
                                    database.delete(object.id, 'vacina'),
                                    setState(() {
                                      _fetchDataVacina();
                                    })
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Color.fromARGB(255, 255, 0, 0),
                                ),

                                // IconButton(
                                //   onPressed: () => {
                                //     database.delete(breed._id, 'gado'),
                                //     setState(() {
                                //       _fetchDataVacina();
                                //     })
                                //   },
                                //   icon: Icon(Icons.delete),
                                //   color: Color.fromARGB(255, 189, 18, 18),
                                // ),
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

  convertDat(DateTime dateTime) {
    DateFormat formatter = DateFormat('dd/MM/yyyy');
    String formattedHour = formatter.format(dateTime);
    return formattedHour;
  }
}
