import 'package:app_veterinaria/Model/breed.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../DataBase/notes_database.dart';

final breedDatabase = NotesDatabase.instance;

class BreedRegistration extends StatefulWidget {
  final Breed? breed;

  BreedRegistration({this.breed});

  @override
  _BreedRegistrationState createState() => _BreedRegistrationState();
}

class _BreedRegistrationState extends State<BreedRegistration> {
  String? _name;
  int? _id;
  @override
  void initState() {
    super.initState();
    if (widget.breed != null) {
      setState(() {
        _id = widget.breed!.id;
      });
      _name = widget.breed!.name;
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _saveBreed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Breed breed = Breed(
        id: _id,
        name: _name,
      );

      await breedDatabase.create(breed, 'breed');

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
        title: Text('Cadastro de Raças'),
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
                ElevatedButton(
                  onPressed: _saveBreed,
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
