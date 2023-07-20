import 'dart:convert';

import 'package:app_veterinaria/Model/breed.dart';
import 'package:app_veterinaria/Model/gado.dart';
import 'package:app_veterinaria/Model/vacina.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../../../DataBase/notes_database.dart';

final vacinaDatabase = NotesDatabase.instance;

class CadastroVacina extends StatefulWidget {
  final Vacina? vacina;
  final int? animalIdPrecinonado;
  // final int headquarters;

  CadastroVacina({this.vacina, this.animalIdPrecinonado});
  // , required this.headquarters
  @override
  _CadastroVacinaState createState() => _CadastroVacinaState();
}

class _CadastroVacinaState extends State<CadastroVacina> {
  // var _headquarters;

  @override
  void initState() {
    super.initState();

    // _headquarters = widget.headquarters;

    if (widget.vacina != null) {
      _getGadoName(widget.vacina!.idAnimal).then((value) {
        setState(() {
          _selectedAnimalName = value;
        });
      });
      setState(() {
        _id = widget.vacina!.id;
      });
      setState(() {
        _observacao = widget.vacina!.observacao;
      });
      setState(() {
        _responsavel = widget.vacina!.responsavel;
      });
      setState(() {
        _nome = widget.vacina!.nome;
      });
      setState(() {
        _numeroLote = widget.vacina!.numeroLote;
      });
      setState(() {
        _localAplicacao = widget.vacina!.localAplicacao;
      });
      setState(() {
        _dosagem = widget.vacina!.dosagem.toString();
      });
      _validade.text = widget.vacina?.validade != null
          ? DateFormat('dd/MM/yyyy').format(widget.vacina!.validade!)
          : '';
      _dataAplicacao.text = widget.vacina?.dataAplicacao != null
          ? DateFormat('dd/MM/yyyy').format(widget.vacina!.dataAplicacao!)
          : '';
      _selectedAnimalId = widget.vacina!.idAnimal;
    } else {
      _selectedAnimalId = widget.animalIdPrecinonado;
    }
  }

  final _formKey = GlobalKey<FormState>();

  Future<void> __saveVacina() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Vacina vacina = Vacina(
        id: _id,
        observacao: _observacao,
        dataAplicacao: _dataAplicacao.text != ""
            ? DateFormat('dd/MM/yyyy').parse(_dataAplicacao.text)
            : null,
        idAnimal: _selectedAnimalId,
        dosagem: double.parse(_dosagem!),
        localAplicacao: _localAplicacao,
        nome: _nome,
        numeroLote: _numeroLote,
        responsavel: _responsavel,
        validade: _validade.text != ""
            ? DateFormat('dd/MM/yyyy').parse(_validade.text)
            : null,
      );

      await vacinaDatabase.create(vacina, 'vacina');

      Navigator.pop(context);
    }
  }

  TextEditingController _dataAplicacao = TextEditingController();
  TextEditingController _validade = TextEditingController();

  Widget fieldDataAplicacao() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: _dataAplicacao,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 61, 10, 201)),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          icon: Icon(Icons.calendar_today_rounded,
              color: Color.fromARGB(255, 61, 10, 201)),
          hintText: 'Data da vacina',
        ),
        onTap: () async {
          DateTime? pickDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );

          if (pickDate != null) {
            setState(() {
              _dataAplicacao.text = DateFormat('dd/MM/yyyy').format(pickDate);
            });
          }
        },
      ),
    );
  }

  Widget fieldDataValidade() {
    return Padding(
      padding: const EdgeInsets.all(0),
      child: TextFormField(
        controller: _validade,
        decoration: const InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color.fromARGB(255, 61, 10, 201)),
            borderRadius: BorderRadius.all(Radius.circular(20.0)),
          ),
          icon: Icon(Icons.calendar_today_rounded,
              color: Color.fromARGB(255, 61, 10, 201)),
          hintText: 'Data da validade',
        ),
        onTap: () async {
          DateTime? pickDate = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime.now(),
          );

          if (pickDate != null) {
            setState(() {
              _validade.text = DateFormat('dd/MM/yyyy').format(pickDate);
            });
          }
        },
      ),
    );
  }

  int? _id;
  String? _nome;
  String? _responsavel;
  String? _localAplicacao;
  String? _numeroLote;
  String? _dosagem;
  String? _observacao;
  late List<Gado> autocompleteData;
  bool isLoading = false;
  int? _selectedAnimalId;
  String? _selectedAnimalName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro de Vacina'),
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
                    initialValue: _nome,
                    decoration: InputDecoration(labelText: 'Nome'),
                    onChanged: (value) => _nome = value,
                    onSaved: (value) => _nome = value,
                  ),
                ),
                fieldDataAplicacao(),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _responsavel,
                    decoration: InputDecoration(labelText: 'Responsavel'),
                    onChanged: (value) => _responsavel = value,
                    onSaved: (value) => _responsavel = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _localAplicacao,
                    decoration:
                        InputDecoration(labelText: 'Local da aplicação'),
                    onChanged: (value) => _localAplicacao = value,
                    onSaved: (value) => _localAplicacao = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _numeroLote,
                    decoration: InputDecoration(labelText: 'Número de Lote'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty && _numeroLote == null) {
                        return 'Insira o Numero do lote';
                      }
                      return null;
                    },
                    onSaved: (value) => _numeroLote = value,
                  ),
                ),
                fieldDataValidade(),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _dosagem,
                    decoration: InputDecoration(labelText: 'Dosagem'),
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value!.isEmpty && _dosagem == null) {
                        return 'Insira o dosagem do animal';
                      }
                      return null;
                    },
                    onSaved: (value) => _dosagem = value,
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: TextFormField(
                    initialValue: _observacao,
                    decoration: InputDecoration(labelText: 'Observação'),
                    onChanged: (value) => _observacao = value,
                    onSaved: (value) => _observacao = value,
                  ),
                ),
                ElevatedButton(
                  onPressed: __saveVacina,
                  child: Text('Cadastrar'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future fetchAutoCompleteData() async {
    setState(() {
      isLoading = true;
    });

    var search = await vacinaDatabase.searchDataWithParamiter('gado', '');

    search as List<Gado>;

    print("Olha aqui ");

    setState(() {
      isLoading = false;
      autocompleteData = search;
    });
  }

  Future fetchAutoCompleteSelectAnimal(String animalId) async {
    setState(() {
      isLoading = true;
    });

    var search = await vacinaDatabase.searchDataWithParamiter(
        'gadoSelecionado', animalId);

    search as List<Gado>;

    print("Olha aqui ");

    setState(() {
      isLoading = false;
      autocompleteData = search;
    });
  }

  _getGadoName([int? selectedIdAnimal]) async {
    var search = await vacinaDatabase.searchNameById(selectedIdAnimal);
    if (search != null) {
      var breed = search as Gado;

      return breed.nome;
    }
  }
}
