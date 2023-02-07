import 'package:app_veterinaria/Model/gado.dart';
import 'package:app_veterinaria/Model/usuario.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../DataBase/notes_database.dart';

final usuarioDatabase = NotesDatabase.instance;

class CadastroUsuario extends StatefulWidget {
  final Usuario? usuario;

  CadastroUsuario({this.usuario});

  @override
  _CadastroUsuarioState createState() => _CadastroUsuarioState();
}

class _CadastroUsuarioState extends State<CadastroUsuario> {
  String? _name;
  String? _email;
  String? _password;
  int? _id;
  @override
  void initState() {
    super.initState();
    if (widget.usuario != null) {
      setState(() {
        _id = widget.usuario!.id;
      });
      _name = widget.usuario!.name;
      _email = widget.usuario!.email;
      _password = widget.usuario!.password;
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _saveUser() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Usuario usuario = Usuario(
        id: _id,
        name: _name,
        email: _email,
        password: _password,
      );

      await usuarioDatabase.create(usuario, 'usuario');

      Navigator.pop(context);
      // Adicione aqui a chamada para a função de salvar
      // passando a nota como parâmetro
    }
  }

  TextEditingController _dataNascimento = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Usuario'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _name,
                    decoration: InputDecoration(labelText: 'Nome:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor digite seu nome: ';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _email,
                    decoration: InputDecoration(labelText: 'Email:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor digite seu email: ';
                      }
                      return null;
                    },
                    onSaved: (value) => _email = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _password,
                    decoration: InputDecoration(labelText: 'Senha:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor digite uma senha: ';
                      }
                      return null;
                    },
                    onSaved: (value) => _password = value,
                  ),
                ),
                ElevatedButton(
                  onPressed: _saveUser,
                  child: Text('Cadastrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
