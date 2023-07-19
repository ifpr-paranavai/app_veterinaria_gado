import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Pages/Formularios/Pesagem/CadastroPesagem.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:intl/intl.dart';

final database = NotesDatabase.instance;

class ListaPesagem extends StatefulWidget {
  final animalId;
  const ListaPesagem({super.key, required this.animalId});

  @override
  State<ListaPesagem> createState() => _ListaPesagemState();
}

class _ListaPesagemState extends State<ListaPesagem> {
  List _pesagens = [];

  var _animalid;

  TextEditingController _filterInput = TextEditingController();

  _fetchDataPesagem() async {
    final animais = await database.readAllNotes('pesagem', animalId: _animalid);
    setState(() {
      _pesagens = animais;
    });
  }

  @override
  void initState() {
    super.initState();
    _animalid = widget.animalId;
    _fetchDataPesagem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Pesagem por animal'),
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
                                _pesagens = itens;
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                buildListaPesagem(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroPesagem()),
          ).then((value) => {
                if (value == null) {_fetchDataPesagem()}
              });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 187, 174, 0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  buildListaPesagem() {
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
                  'Peso',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 100),
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
          ..._pesagens
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
                                  convertDat(object.dataPesagem),
                                  style: TextStyle(
                                      color: Color.fromARGB(255, 0, 0, 0)),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  object.peso == null || object.peso == ""
                                      ? "00.00"
                                      : object.peso.toString(),
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
                                    database.delete(object.id, 'pesagem'),
                                    setState(() {
                                      _fetchDataPesagem();
                                    })
                                  },
                                  icon: Icon(Icons.delete),
                                  color: Color.fromARGB(255, 255, 0, 0),
                                ),

                                // IconButton(
                                //   onPressed: () => {
                                //     database.delete(breed._id, 'gado'),
                                //     setState(() {
                                //       _fetchDataPesagem();
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
