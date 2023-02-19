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

  TextEditingController _filterInput = TextEditingController();

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () => Navigator.pop(context, false),
            ),
            title: Text('Listagem de Gado'),
            backgroundColor: Colors.green,
          ),
          body: Container(
            decoration: BoxDecoration(
                //color: Colors.grey[850],
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
                              color: Color.fromARGB(255, 209, 203, 203),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(6.0)),
                            ),
                            child: TextField(
                              decoration: InputDecoration(
                                  hintText: "Procurar...",
                                  border: InputBorder.none,
                                  contentPadding:
                                      EdgeInsets.only(left: 15, top: -10)),
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
                            final itens = await gadoDatabase.readNote(
                                'gado', _filterInput.text);
                            if (itens is List) {
                              setState(() {
                                _gados = itens;
                              });
                            }
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
    return Card(
      child: Column(
        children: [
          ListTile(
            visualDensity: VisualDensity.compact,
            tileColor: Colors.grey[300],
            title: Padding(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.02),
              child: Text(
                'Nome',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Número',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 30),
                Text(
                  'excluir',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(width: 16),
                Text(
                  'editar',
                  style: TextStyle(
                    color: Color.fromARGB(255, 0, 0, 0),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            contentPadding: EdgeInsets.symmetric(vertical: 1, horizontal: 40),
          ),
          ..._gados
              .asMap()
              .map(
                (index, gado) => MapEntry(
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
                                  gado.nome == null || gado.nome == ""
                                      ? "XXX-XXX"
                                      : gado.nome,
                                  //style: TextStyle(color: Colors.white),
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
                                          builder: (context) => CadastroGado(
                                                gado: gado,
                                              )),
                                    ).then((value) => {
                                          if (value == null)
                                            {
                                              setState(() {
                                                _readAllNotes();
                                              })
                                            }
                                        }),
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
