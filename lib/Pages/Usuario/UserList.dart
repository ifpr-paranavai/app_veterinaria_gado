import 'package:app_veterinaria/Pages/Usuario/cadastroUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserList extends StatefulWidget {
  const UserList({super.key});

  @override
  State<UserList> createState() => _UserListState();
}

class _UserListState extends State<UserList> {
  List _users = [];

  _readAllNotes() async {
    final users = await usuarioDatabase.readAllNotes('usuario');
    setState(() {
      _users = users;
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
            title: Text('Listagem de Usuarios'),
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
                            final itens =
                                await usuarioDatabase.readNote('usuario');
                            setState(() {
                              _users = itens as List;
                            });
                            // adicione o código de filtragem aqui
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
              // adicione o código para abrir a página de cadastro aqui
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CadastroUsuario()),
              );
            },
            child: Icon(Icons.add),
            backgroundColor: Color.fromARGB(255, 187, 174, 0),
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat),
    );
  }

  buildUserList() {
    return ListView(
      children: _users
          .map((user) => ListTile(
                //leading: Icon(Icons.add_a_photo),
                title: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            user.name == null || user.name == ""
                                ? "XXX-XXX"
                                : user.name,
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
                            user.email == null || user.email == ""
                                ? "000-000"
                                : user.email,
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
                                    builder: (context) => CadastroUsuario(
                                          usuario: user,
                                        )),
                              )
                            },
                            icon: Icon(Icons.edit),
                            color: Color.fromARGB(255, 20, 122, 16),
                          ),
                          IconButton(
                            onPressed: () => {
                              usuarioDatabase.delete(user.id, 'gado'),
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
