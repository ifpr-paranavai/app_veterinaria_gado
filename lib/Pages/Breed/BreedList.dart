import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Pages/Breed/BreedRegistration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

final breedDatabase = NotesDatabase.instance;

class BreedList extends StatefulWidget {
  const BreedList({super.key});

  @override
  State<BreedList> createState() => _BreedListState();
}

class _BreedListState extends State<BreedList> {
  List _breeds = [];

  TextEditingController _filterInput = TextEditingController();

  _fetchDataBreed() async {
    final breeds = await breedDatabase.readAllNotes('breed');
    setState(() {
      _breeds = breeds;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDataBreed();
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
            title: Text('Listagem de Raças'),
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
                            final itens = await breedDatabase.readNote(
                                'breed', _filterInput.text);
                            if (itens is List) {
                              setState(
                                () {
                                  _breeds = itens;
                                },
                              );
                            }
                          },
                        ),
                      ],
                    )),
                Expanded(
                  child: buildUserList(),
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => BreedRegistration()),
              ).then((value) => {
                    if (value == null) {_fetchDataBreed()}
                  });
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 187, 174, 0),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat),
    );
  }

  buildUserList() {
    return ListView(
      children: _breeds
          .asMap()
          .map(
            (index, breed) => MapEntry(
              index,
              Container(
                color: index % 2 == 0 ? Colors.white : Colors.grey[200],
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
                              breed.name,
                              style: TextStyle(
                                  color: Color.fromARGB(255, 0, 0, 0)),
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
                                      builder: (context) => BreedRegistration(
                                            breed: breed,
                                          )),
                                ).then((value) => {
                                      if (value == null) {_fetchDataBreed()}
                                    })
                              },
                              icon: Icon(Icons.edit),
                              color: Color.fromARGB(255, 20, 122, 16),
                            ),
                            IconButton(
                              onPressed: () => {
                                breedDatabase.delete(breed.id, 'breed'),
                                setState(() {
                                  _fetchDataBreed();
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
    );
  }
}
