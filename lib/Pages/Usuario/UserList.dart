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

  _fetchDataUser() async {
    final users = await usuarioDatabase.readAllNotes('usuario');
    setState(() {
      _users = users;
    });
  }

  @override
  void initState() {
    super.initState();
    _fetchDataUser();
  }

  TextEditingController _filterImput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context, false),
        ),
        title: Text('Listagem de Usuarios'),
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
                            controller: _filterImput,
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
                          final itens = await usuarioDatabase.readNote(
                            'usuario',
                            _filterImput.text,
                          );
                          if (itens is List) {
                            setState(() {
                              _users = itens as List;
                            });
                          }
                          // adicione o código de filtragem aqui
                        },
                      ),
                    ],
                  ),
                ),
                buildUserList(),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // adicione o código para abrir a página de cadastro aqui
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CadastroUsuario()),
          ).then((value) {
            if (value == null) _fetchDataUser();
          });
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 187, 174, 0),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }

  buildUserList() {
    return Card(
      child: Column(children: [
        ListTile(
          visualDensity: VisualDensity.compact,
          tileColor: Colors.grey[300],
          title: Padding(
            padding: EdgeInsets.only(left: 12),
            child: Text(
              'Nome',
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
                'Email',
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 45),
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
          contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 40),
        ),
        ..._users
            .asMap()
            .map(
              (index, user) => MapEntry(
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
                                    user.name == null || user.name == ""
                                        ? "XXX-XXX"
                                        : user.name,
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 0, 0, 0))),
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
                                          builder: (context) => CadastroUsuario(
                                                usuario: user,
                                              )),
                                    ).then((value) {
                                      if (value == null) _fetchDataUser();
                                    })
                                  },
                                  icon: Icon(Icons.edit),
                                  color: Color.fromARGB(255, 20, 122, 16),
                                ),
                                IconButton(
                                  onPressed: () => {
                                    usuarioDatabase.delete(user.id, 'usuario'),
                                    _fetchDataUser()
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
                  )),
            )
            .values
            .toList(),
      ]),
    );
  }
}
