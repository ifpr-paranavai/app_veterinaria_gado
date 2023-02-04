import 'package:app_veterinaria/DataBase/notes_database.dart';
import 'package:app_veterinaria/Model/note.dart';
import 'package:flutter/material.dart';

final notesDatabase = NotesDatabase.instance;

class NoteForm extends StatefulWidget {
  @override
  _NoteFormState createState() => _NoteFormState();
}

class _NoteFormState extends State<NoteForm> {
  final _formKey = GlobalKey<FormState>();
  int _isImportant = 0;
  int? _number;
  String? _title;
  String? _description;

  Future<void> _saveNote() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Note note = Note(
        isImportant: _isImportant == 1,
        number: _number,
        title: _title,
        description: _description,
        createdTime: DateTime.now(),
      );

      await notesDatabase.create(note, "tab_note");

      // Adicione aqui a chamada para a função de salvar
      // passando a nota como parâmetro
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note Form'),
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Checkbox(
                value: _isImportant == 1,
                onChanged: (value) {
                  setState(() {
                    _isImportant = value! ? 1 : 0;
                  });
                },
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                onSaved: (value) => _number = int.parse(value!),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
              TextFormField(
                onSaved: (value) => _title = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                onSaved: (value) => _description = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: _saveNote,
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
