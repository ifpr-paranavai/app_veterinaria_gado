import 'package:app_veterinaria/Model/breed.dart';
import 'package:app_veterinaria/Model/headquarters.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../DataBase/notes_database.dart';

final database = NotesDatabase.instance;

class HeadQuartersRegistration extends StatefulWidget {
  final Headquarters? headquarters;

  HeadQuartersRegistration({this.headquarters});

  @override
  _HeadQuartersRegistrationState createState() =>
      _HeadQuartersRegistrationState();
}

class _HeadQuartersRegistrationState extends State<HeadQuartersRegistration> {
  String? _name;
  String? _cpfCnpj;
  String? _number;
  String? _observacao;
  int? _id;
  int? _idUsuario;
  @override
  void initState() {
    super.initState();
    if (widget.headquarters != null) {
      setState(() {
        _id = widget.headquarters!.id;
      });
      _name = widget.headquarters!.name;
      _cpfCnpj = widget.headquarters!.cpfCnpj;
      _number = widget.headquarters!.number;
      _observacao = widget.headquarters!.observacao;
      _idUsuario = widget.headquarters!.idUsuario;
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> _saveBreed() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Headquarters object = Headquarters(
        id: _id,
        name: _name,
        cpfCnpj: _cpfCnpj,
        number: _number,
        observacao: _observacao,
        idUsuario: _idUsuario,
      );

      await database.create(object, 'headquarters');

      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Matriz'),
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
                    decoration: InputDecoration(labelText: 'Nome da Matriz:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor digite o nome da Matrix: ';
                      }
                      return null;
                    },
                    onSaved: (value) => _name = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _cpfCnpj,
                    decoration: InputDecoration(labelText: 'CPF/CNPJ:'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Por favor digite o CPF/CNPJ da matriz: ';
                      }
                      return null;
                    },
                    onSaved: (value) => _cpfCnpj = value,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // obrigatório
                      FilteringTextInputFormatter.digitsOnly,
                      CpfOuCnpjFormatter(),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _number,
                    decoration: InputDecoration(labelText: 'Numero da matrix:'),
                    onSaved: (value) => _number = value,
                    keyboardType: TextInputType.number,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _observacao,
                    maxLines: null,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      hintText: 'Digite aqui uma observação sobre a matriz:',
                    ),
                    onSaved: (value) => _observacao = value,
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
